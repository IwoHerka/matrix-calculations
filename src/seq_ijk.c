/*
 * Sequential program computing the product of two NxM dense matrices such that:
 *      1. Only 1 processor is involved in computations.
 *      2. ijk matrix multiplication scheme is used.
 */

#include <stdio.h>
#include "lib/matrix.h"
#include "lib/utils.h"


int
main(int argc, char **argv)
{
        double          acc;           // Loop accumulator.
        unsigned int    i, j, k;       // Loop vars.
        struct matrix   *A, *B, *C;    // Matrix handles.

	if (argc < 3) {
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

	for (i = 0; i < A->nr_rows; i++)
		for (j = 0; j < B->nr_cols; j++) {
			acc = 0;
			for (k = 0; k < A->nr_cols; k++)
				acc += A->data[i * A->nr_cols + k] * B->data[k * B->nr_cols + j];
			C->data[i * C->nr_cols + j] = acc;
		}

        DEBUG_ARGS("\nMatrix C:\n"); DEBUG_MAT(C);

	free_matrix(A);
	free_matrix(B);
	free_matrix(C);

	return 0;
}
