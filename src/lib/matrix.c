#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>
#include "matrix.h"


/*
   Initialize matrix with data from 'fname' file.
   Values must be separated with '\t'. Number of
   cols equals the number of '\t's + 1. Each line
   must be terminated with '\n'. Number of rows
   equals the number of '\n's.
   */
struct matrix *
load_matrix(char fname[])
{
        struct matrix *m;
        FILE* mdata;
        int c, i, j;

        if ((mdata = fopen(fname, "r")) == NULL) {
                printf("%s\n", fname);
                printf("ERR: Data file could not be opened.\n");
                exit(1);
        }

        // Initialize matrix.
        m = malloc(sizeof(struct matrix));
        m->nr_rows = 0;
        m->nr_cols = 0;

        // Count columns by scanning the first row.
        while ((c = fgetc(mdata)) != EOF && c != '\n')
                if (c == '\t')
                        m->nr_cols++;

        if (c == '\n') {
                m->nr_cols++; // Compensate for missing \t.
                m->nr_rows++; // Add 1 for the first scanned row.
        }

        // Count rows.
        while ((c = fgetc(mdata)) != EOF)
                if (c == '\n')
                        m->nr_rows++;

        // Allocate arrays (rows) of length = cols.
        m->data = malloc(m->nr_rows * m->nr_cols * sizeof(matrix_t));

        rewind(mdata);

        // Copy data from the file.
        for (i = 0; i < m->nr_rows; i++) {
                for (j = 0; j < m->nr_cols; j++) {
                        if (!fscanf(mdata, "%lf", &m->data[i * m->nr_cols + j])) {
                                printf("ERR: Scan failed at %d, %d.\n", i, j);
                                exit(1);
                        }
                }
        }

        fclose(mdata);
        return m;
}


struct matrix *
alloc_matrix(int nr_rows, int nr_cols)
{
        struct matrix *mat = malloc(sizeof(struct matrix));
        mat->nr_rows = nr_rows;
        mat->nr_cols = nr_cols;
        mat->data = malloc(nr_rows * nr_cols * sizeof(matrix_t));
        return mat;
}


void
free_matrix(struct matrix *mat)
{
        free(mat->data);
        free(mat);
}


void
print_matrix(struct matrix *mat)
{
        for (int i = 0; i < mat->nr_rows; i++) {
                for (int j = 0; j < mat->nr_cols; j++)
                        printf("%lf\t", mat->data[i * mat->nr_cols + j]);
                printf("\n");
        }
}
