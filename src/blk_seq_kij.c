/*
 * Blocked sequential program computing the product of two NxM dense matrices
 * such that:
 *      1. Only 1 processor is involved in computations.
 *      2. kij matrix multiplication scheme is used.
 *      3. Multiplication is blocked into k segments.
 */

#include <stdio.h>
#include "lib/matrix.h"
#include "lib/utils.h"


int
main(int argc, char **argv)
{
        int              block_size;
        double           tmp;                    // Loop accumulator.
        struct matrix    *A, *B, *C;             // Matrix handles.
        unsigned int     i, j, k, ii, jj, kk;    // Loop vars.

        if (argc != 4) {
                printf("ERR: Please specify exactly three parameters.\n");
                return 1;
        }

        sscanf(argv[1], "%d", &block_size);
        A = load_matrix(argv[2]);
        B = load_matrix(argv[3]);

        if (A->nr_cols != B->nr_rows) {
                printf("ERR: The number of columns of matrix A "
                       "must match the number of rows of matrix B.\n");
                return 1;
        }

        C = alloc_matrix(A->nr_rows, B->nr_cols);
        int const step = block_size;

        DEBUG_ARGS("Step: %d\n", step);

        for (k = 0; k < A->nr_cols; k += step)
                for (i = 0; i < A->nr_rows; i += step)
                        for (j = 0; j < B->nr_cols; j += step)
                                for (kk = k; kk < MIN(k + step, A->nr_cols); kk++)
                                        for (ii = i; ii < MIN(i + step, A->nr_cols); ii++) {
                                                tmp = A->data[ii * A->nr_cols + kk];
                                                for (jj = j; jj < MIN(j + step, B->nr_cols); jj++)
                                                       C->data[ii * B->nr_cols + jj] += tmp * B->data[kk * B->nr_cols + jj];
                                        }

        DEBUG_ARGS("\nMatrix C:\n"); DEBUG_MAT(C);

        free_matrix(A);
        free_matrix(B);
        free_matrix(C);

        return 0;
}
