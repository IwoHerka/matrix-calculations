#include <omp.h>
#include <stdio.h>
#include <malloc.h>
#include "lib/matrix.h"
#include "lib/utils.h"


static long double max_sum = 0;    // Infinity norm.
static omp_lock_t norm_lock;       // max_sum's mutex.

void calc_norm(void *);            // Norm calculation worker.

struct norm_work_dat {
        unsigned int     start;
        unsigned int     end;
        char             use_lock;
        struct matrix    *mat;
};


int
main(int argc, char **argv)
{
        char             failure = 0;
        unsigned int     thread_id,
                         nr_thread,
                         i, j, k;
        matrix_t         acc;
        struct matrix    *A, *B, *C;
        int const        max_nr_thread = omp_get_max_threads();

        if (argc != 3) {
                printf("ERR: Please specify exactly two files.\n");
                return 1;
        }

        A = load_matrix(argv[1]);
        B = load_matrix(argv[2]);

        if (A->nr_cols != B->nr_rows) {
                printf("ERR: The number of columns of matrix A "
                       "must match the number of rows of matrix B.\n");
                return 1;
        }

        C = alloc_matrix(A->nr_rows, B->nr_cols);

        if (max_nr_thread >= A->nr_cols) {
                omp_set_num_threads(A->nr_cols);
        } else {
                int max = MAX(1, max_nr_thread - (A->nr_cols % max_nr_thread));
                omp_set_num_threads(max);
        }

        # pragma omp parallel private(acc, i, j, k, thread_id, nr_thread) shared(A, B, C)
        {
                thread_id = omp_get_thread_num();
                nr_thread = omp_get_num_threads();

                // Allocate memory for norm worker data.
                struct norm_work_dat *dat = malloc(sizeof(struct norm_work_dat));
                // Calculate the size of a chunk of matrix assigned to the thread.
                int const delta = B->nr_cols / nr_thread;

                dat->start = thread_id * delta;
                // If this thread is the last one, assign the remaining martrix.
                // Otherwise, add delta to the starting offset.
                dat->end = thread_id == nr_thread - 1 ? B->nr_cols : dat->start + delta;
                dat->mat = C;
                dat->use_lock = nr_thread > 1;

                for (j = dat->start; j < dat->end; j++) {
                        for (i = 0; i < A->nr_rows; i++) {
                                acc = 0;
                                for (k = 0; k < B->nr_rows; k++)
                                        acc += A->data[i * A->nr_cols + k] * B->data[k * B->nr_cols + j];
                                C->data[i * C->nr_cols + j] = acc;
                        }
                }
                calc_norm(dat);
exit_parallel: ;
        }

        DEBUG_ARGS("Max row sum = %Lf\n", max_sum);

        if (failure)
                printf("ERR: Program failed. Ensure that number of threads is "
                       "1 or is divisible by the dimension of the matrx A. ");
        else
                DEBUG_ARGS("\nMatrix C:\n"); DEBUG_MAT(C); DEBUG_ARGS("\n");

        free_matrix(A);
        free_matrix(B);
        free_matrix(C);

        return !failure;
}

/*
 * Infinity-norm worker.
 * This function should should be called in parallel.
 */
void
calc_norm(void *dptr)
{
        long double sum;
        unsigned int i, j;
        struct norm_work_dat *dat = dptr;

        for (i = dat->start; i < dat->end; i++) {
                sum = 0;

                for (j = 0; j < dat->mat->nr_cols; j++)
                        sum += dat->mat->data[i * dat->mat->nr_cols + j];

                if (dat->use_lock)
                        omp_init_lock(&norm_lock);

                if (sum > max_sum)
                        max_sum = sum;

                if (dat->use_lock)
                        omp_destroy_lock(&norm_lock);
        }
}
