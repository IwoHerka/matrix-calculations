/*
 * Parallel Pthreads program computing the norm of the product of two n×n dense
 * matrices on p-processor SMP so that:
 *      1. p threads are involved in the computations.
 *      2. 1-dimensional parallel algorithm of matrix multiplication is
 *         employed:
 *              - matrix B is vertically partitioned into p equal slices.
 *              - there is one-to-one mapping between the partitions and the
 *                threads.
 *              - each thread is responsible for computation of the
 *                corresponding slice of the resulting matrix.
 *      3. Computation of the norm of the resulting matrix employs the mutex
 *         synchronization mechanism.
 *      4. The norm used is the maximum absolute row sum norm (infinity norm).
 */

#include <stdio.h>
#include <unistd.h>
#include <malloc.h>
#include <pthread.h>
#include "lib/matrix.h"
#include "lib/utils.h"


// Infinity norm.
static long double max_sum = 0;

// max_sum's mutex.
static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

// Pthread workers.
void *multiply(void *);
void *calc_norm(void *);

// Multiplication worker data.
struct mul_dat {
        unsigned int     start;
        unsigned int     end;
        struct matrix    *A;
        struct matrix    *B;
        struct matrix    *C;
};

// Norm calculation worker data.
struct norm_dat {
        unsigned int     start;
        unsigned int     end;
        struct matrix    *mat;
};

int
main(int argc, char **argv)
{
        unsigned int     nr_proc;       // Number of Pthreads.
        unsigned int     i;
        pthread_t        *threads;      // Thread handles.
        struct matrix    *A, *B, *C;    // Matrices.

        if (argc != 3) {
                printf("ERR: Please specify exactly two files.\n");
                return 1;
        }

        A = load_matrix(argv[1]);
        B = load_matrix(argv[2]);

        if (A->nr_cols != B->nr_rows) {
                printf("ERROR: The number of columns of matrix A must match"
                       "the number of rows of matrix B.\n");
                return 1;
        }

        C = alloc_matrix(A->nr_rows, B->nr_cols);
        nr_proc = 4;//MIN(B->nr_cols, sysconf(_SC_NPROCESSORS_ONLN));
        threads = (pthread_t *) malloc(nr_proc * sizeof(pthread_t));

        for (i = 0; i < nr_proc; i++) {
                struct mul_dat *dat = malloc(sizeof(struct mul_dat));
                int const delta = B->nr_cols / nr_proc;

                dat->A = A;
                dat->B = B;
                dat->C = C;
                dat->start = i * delta;
                dat->end = i == nr_proc - 1 ? B->nr_cols : dat->start + delta;

                if (i < nr_proc - 1)
                        pthread_create(&threads[i], NULL, multiply, dat);
                else
                        multiply(dat);
        }

        for (i = 0; i < nr_proc - 1; i++)
                pthread_join(threads[i], NULL);

        DEBUG_ARGS("Matrix C:\n"); DEBUG_MAT(C); DEBUG_ARGS("\n");

        nr_proc = MIN(C->nr_rows, sysconf(_SC_NPROCESSORS_ONLN));

        for (i = 0; i < nr_proc; i++) {
                struct norm_dat *dat = malloc(sizeof(struct norm_dat));
                int delta = C->nr_rows / nr_proc;

                dat->mat = C;
                dat->start = i * delta;
                dat->end = i == nr_proc - 1 ? C->nr_rows : dat->start + delta;


        }

        for (i = 0; i < nr_proc; i++)
                pthread_join(threads[i], NULL);

        DEBUG_ARGS("Max row sum = %Lf\n", max_sum);

        free_matrix(C);
        return 0;
}

void *
multiply(void *dptr)
{
        long double acc;
        unsigned int i, j, k;
        struct mul_dat *dat = dptr;

        for (j = dat->start; j < dat->end; j++)
                for (i = 0; i < dat->A->nr_rows; i++) {
                        acc = 0;
                        for (k = 0; k < dat->B->nr_rows; k++)
                                acc += dat->A->data[i * dat->A->nr_cols + k] * dat->B->data[k * dat->B->nr_cols + j];
                        dat->C->data[i * dat->C->nr_cols + j] = acc;
                }

        pthread_exit(0);
}

/*
 * Norm calculation worker.
 * This functon should be called in parallel.
 */
void *
calc_norm(void *dptr)
{
        unsigned i, j;
        long double sum;
        struct norm_dat *dat = dptr;

        for (i = dat->start; i < dat->end; i++) {
                sum = 0;

                for (j = 0; j < dat->mat->nr_cols; j++)
                        sum += dat->mat->data[i * dat->mat->nr_cols + j];

                pthread_mutex_lock(&mutex);

                if (sum > max_sum)
                        max_sum = sum;

                pthread_mutex_unlock(&mutex);
        }

        pthread_exit(0);
}
