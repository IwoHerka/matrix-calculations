/*
 * Sequential program computing the product of two NxM dense matrices such that:
 *      1. Only 1 processor is involved in computations.
 *      2. ijk matrix multiplication scheme is used.
 */

#include <stdio.h>
#include <cblas.h>
#include "lib/matrix.h"
#include "lib/utils.h"


int
main(int argc, char **argv)
{
        struct matrix *A, *B, *C;    // Matrix handles.

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
        DEBUG_ARGS("%d, %d, %d\n", A->nr_rows, B->nr_cols, A->nr_cols);

        cblas_dgemm(
                CblasRowMajor, CblasNoTrans, CblasNoTrans,
                A->nr_rows, B->nr_cols, A->nr_cols,
                1.0,
                &A->data[0], A->nr_cols,
                &B->data[0], B->nr_cols,
                1.0,
                &C->data[0], C->nr_cols
        );

        DEBUG_ARGS("\nMatrix C:\n"); DEBUG_MAT(C);

	free_matrix(A);
	free_matrix(B);
	free_matrix(C);

	return 0;
}
