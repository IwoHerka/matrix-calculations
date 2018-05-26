/*
 * Parallel MPI program computing the product of two NxN dense matrices on
 * p processors so that:
 *      1. p processors are involved in the computation.
 *      2. 2-dimensional parallel algorithm of matrix multiplication is
 *         employed:
 *              - matrices are identically and equally partitioned into p
 *                squares.
 *              - there is one-to-one mapping between the partitions and the
 *                processors.
 *              - each processor is responsible for computation of the
 *                corresponding square of the resulting matrix.
 *      3. Only native matrix multiplication is used for local computation.
 */

// Some objects are initialized inside the parallel sections.
// Ignore compiler's complaints.
#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpi.h>
#include <math.h>
#include "lib/matrix.h"
#include "lib/utils.h"


int
main(int argc, char *argv[])
{
        // Calculations related to matrix division, node coordination and
        // data passing often use the following three 'magic' values:
        //     1. N - matrix dimension.
        //     2. sqrt_ws - Square root of world-size (numer of cluster nodes).
        //     3. M - N over sqrt_ws.

        struct matrix *A, *B;      // Matrix handles.
        matrix_t *T1, *T2, *T3;    // Temporary matrix arrays.

        int      worldsize,        // Number of cluster nodes.
                 worldrank,        // World-rank of the local node.
                 N,                // Matrix dimension.
                 M,                // M over sqrt_ws.
                 mprops[4],        // Properties of matrices.
                 sqrt_ws;          // Square root of nodes in the cluster.

        MPI_Init(&argc, &argv);
        MPI_Comm_size(MPI_COMM_WORLD, &worldsize);
        MPI_Comm_rank(MPI_COMM_WORLD, &worldrank);
        sqrt_ws = (int) sqrt((double) worldsize);

        if (worldrank == 0) {
                DEBUG_ARGS("Number of nodes: %d\n", worldsize);

                if (argc != 3) {
                        printf("ERROR: Please specify only two files.\n");
                        exit(0);
                }

                A = load_matrix(argv[1]);
                B = load_matrix(argv[2]);

                if (A->nr_cols != A->nr_rows || B->nr_rows != A->nr_cols ||
                                B->nr_cols != A->nr_cols) {
                        printf("ERROR: MPI program supports only square "
                               "matrices of the same size.\n");
                        exit(1);
                }

                T1 = malloc(A->nr_rows * A->nr_cols * sizeof(matrix_t));
                T2 = malloc(B->nr_rows * B->nr_cols * sizeof(matrix_t));

                memcpy(T1, A->data, A->nr_rows * A->nr_cols * sizeof(matrix_t));
                memcpy(T2, B->data, B->nr_rows * B->nr_cols * sizeof(matrix_t));

                // Fill the property-array for workers.

                mprops[0] = A->nr_rows;
                mprops[1] = A->nr_cols;
                mprops[2] = B->nr_rows;
                mprops[3] = B->nr_cols;

                if (A->nr_rows % worldsize != 0) {
                        printf("ERROR: Matrix can not be calculated with "
                               "this number of tasks.\n");
                        exit(1);
                }
        } else if (argc != 3) {
                exit(1);
        }

        // Send meta-data (properties of matrices) to worker threads.

        MPI_Bcast(
                mprops,           // Dimensions of matrices A and B.
                4,                // Number of entries in the buffer (all).
                MPI_INT,          // Type of data in the buffer.
                0,                // Rank of broadcasting node.
                MPI_COMM_WORLD    // Communicator (world-wide).
        );

        N = mprops[1];
        M = N / sqrt_ws;

        // Allocate memory for the result matrix.
        // Final data is gathered by the root node.
        int const nr_elems = N * N;
        T3 = malloc(nr_elems * sizeof(matrix_t));

        if (worldrank != 0) {
                // Allocate memory for temporary matrices.
                // TODO: Too much memory.
                T1 = malloc(mprops[0] * mprops[1] * sizeof(matrix_t));
                T2 = malloc(mprops[2] * mprops[3] * sizeof(matrix_t));
        }

        if (worldrank != 0)
                goto await_data0;

        // Distribute matrix chunks across workers.
        int c = 0;

        for (int j = 0; j < N; j += M) {
                for (int i = 0; i < N; i += M) {
                        for (int jj = j; jj < j + M; jj++) {
                                /* printf("send to c: %d, index: %d\n", */
                                /*        c, jj * 8 + i); */

                                if (c > 0)
                                        MPI_Send(
                                                // Starting index.
                                                &A->data[jj * N + i],
                                                // Number of elements.
                                                M,
                                                MPI_DOUBLE,
                                                // Destination worker.
                                                c,
                                                0,
                                                MPI_COMM_WORLD
                                        );
                        }
                        c += 1;
                }
        }

await_data0:
        // Wait to receive matrix A's chunk.

        if (worldrank > 0) {
                for (int i = 0; i < M * M; i += M)
                        MPI_Recv(&T1[i], M, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, 0);

                goto await_datT1;
        }

        // Iterate over B's rows.
        int row = 0;

        for (int i = 0; i < sqrt_ws; i++)
                for (int m = 0; m < M; m++) {
                        // Iterate over nodes in the group.
                        for (int rank = i; rank < worldsize; rank += sqrt_ws) {
                                /* printf("Sending starting at: %d to %d\n", row, rank); */
                                if (rank > 0)
                                        MPI_Send(
                                                &B->data[row],
                                                N,
                                                MPI_DOUBLE,
                                                rank,
                                                0,
                                                MPI_COMM_WORLD
                                        );
                        }

                        row += N;
                }

await_datT1:

        if (worldrank > 0)
                for (int i = 0; i < M; i++)
                        MPI_Recv(&T2[i * N], N, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, 0);

        if (worldrank > 0)
                for (int i = 0; i < M; i++)
                        for (int j = 0; j < N; j++) {
                                double l = 0;
                                /* printf("%d - %d > %d\n", i, j, i * N + j); */
                                for (int k = 0; k < M; k++)
                                        l += T1[i * M + k] * T2[k * N + j];
                                T3[i * N + j] = l;
                        }
        else
                for (int i = 0; i < M; i++)
                        for (int j = 0; j < N; j++) {
                                double l = 0;
                                /* printf("%d - %d > %d\n", i, j, i * N + j); */
                                for (int k = 0; k < M; k++)
                                        l += A->data[i * N + k] * B->data[k * N + j];
                                T3[i * N + j] = l;
                        }

        if (worldrank > 0)
                MPI_Send(&T3[0], N * M, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD);

        DEBUG_ARGS("Node %d sent %d cells from T3 to root node.\n", worldrank, N * M);

        if (worldrank != 0)
                goto finish;

        int off;

        for (int rank = 1; rank < worldsize; rank++) {
                // Calculate offset based on rank column.
                off = (rank / sqrt_ws) * M * N;

                DEBUG_ARGS("Awaiting data from node: %d, off: %d\n", rank, off);

                // Receive data from the worker.
                MPI_Recv(&T1[0], N * M, MPI_DOUBLE, rank, 0, MPI_COMM_WORLD, 0);

                // Save results to final matrix.
                for (int row = 0; row < M; row++) {
                        for (int col = 0; col < N; col++) {
                                T3[off + row * N + col] += T1[row * N + col];
                        }
                }
        }

        free_matrix(A);
        free_matrix(B);
finish:
        free(T1);
        free(T2);
        free(T3);

        printf("Node %d finished.\n", worldrank);

        MPI_Finalize();
        return 0;
}
