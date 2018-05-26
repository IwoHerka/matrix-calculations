typedef double matrix_t;
typedef long double long_matrix_t;

// General matrix, implemented as a 1D array.
struct matrix {
    matrix_t *data;
    unsigned int nr_rows;
    unsigned int nr_cols;
};

struct matrix *load_matrix(char fname[]);
struct matrix *alloc_matrix(int nr, int nc);

void print_matrix(struct matrix *mp);
void free_matrix(struct matrix *mp);
