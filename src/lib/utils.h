// Define some useful macros.

#ifndef UTILS_INCLUDED
#define UTILS_INCLUDED

#define MIN(X, Y) (((X) < (Y)) ? (X) : (Y))
#define MAX(X, Y) (((X) > (Y)) ? (X) : (Y))

#ifdef DEBUG

#define DEBUG_ARGS(ARGS...) printf(ARGS)
#define DEBUG_MAT(MAT) print_matrix(MAT)

#else

#define DEBUG_ARGS(ARGS...) do {} while (0)
#define DEBUG_MAT(MAT) do {} while (0)

#endif

#endif
