
### Matrix Calculations With Blocking, BLAS, Pthreads OpenMP and MPI

This project was created during my High-Performance Computing course as part of the Master's degree in Software Engineering on University College Dublin, 2017/2018. I'm uploading it in hope it be may be useful to other students.

----------

#### Problem #1 - Matrix multiplication

The goal of the first assignment is to write C programs implementing the 
following four algorithms of multiplication of two _n×n_ dense matrices:

1) Straightforward non-blocked _ijk_ algorithm.
2) Straightforward BLAS algorithm.
3) Blocked _ijk_ algorithm using square _b×b_ blocks.
4) Blocked _kij_ algorithm using square _b×b_ blocks.

#### Problem #2 - Matrix multiplication + norm calculation

The goal of the second assignment is to write Pthreads, OpenMP and MPI C programs implementing the 
algorithm of multiplication of two _n×n_ dense matrices on p-processor SMP and calculation of its norm such that:

1. _p_ threads/processes are involved in the computations.
2. 1-dimensional parallel algorithm of matrix multiplication is
   employed:
- matrix B is vertically partitioned into p equal slices.
 - there is one-to-one mapping between the partitions and the
   threads.
 - each thread is responsible for computation of the
                 corresponding slice of the resulting matrix.
 3. Computation of the norm of the resulting matrix employs the mutex
    synchronization mechanism.
 4. The norm used is the maximum absolute row sum norm (infinity norm).
 
#### Project Tree

    .
    |-- bin/ (compiled binaries)
    |-- data/ (txt files with generated data)
    |-- src
    |   |-- lib
    |   |   |-- utils.h
    |   |   |-- matrix.c
    |   |   `-- matrix.h
    |   |-- mpi.c
    |   |-- openmp.c
    |   |-- pthread.c
    |   |-- blk_seq_ijk.c
    |   |-- blk_seq_kij.c
    |   |-- seq_blas.c
    |   `-- seq_ijk.c
    |-- Makefile
    |-- random_matrix.py
    |-- README.md
    |-- test_blocked_seq.sh
    |-- test_mpi.sh
    |-- test_openmp.sh
    |-- test_pthread.sh
    |-- test_sequential.sh
    `-- test.sh
   
##### Legend
    
```
seq_ijk ............... Sequential ijk multiplication
seq_kij ..............  Sequential kij multiplication
seq_blas ............. Sequential BLAS multiplication
blk_seq_ijk ... Blocked sequential ijk multiplication
blk_seq_kij ... Blocked sequential kij multiplication
pthread ...................... Pthreads infinity norm
openmp ......................... OpenMP infinity norm
mpi ............................... MPI infinity norm
```

The python script `random_matrix.py` generates `n x m` random floating-point matrix. The scipt is based on `uniform` function from package `random` from Python's standard library. Script can be used manually, or, alternatively, `testdata` recipe from `Makefile` can be run to generate random matrices ranging from `8 x 8` to `4096 x 4096`. `Makefile` also includes all recipes required to compile 
and run the tests. Each compilation plan includes debug variant with verbose message logging. Check `lib/utils.h` for details.

`Makefile` also includes all parameter configuration for GCC and path to BLAS library (OpenBLAS by default). `Makefile` is intended to be run by `run.sh` and specific test suites.

#### Makefile

    CC=gcc
    CFLAGS= -Wall -std=gnu99 -g
    LIBS=src/lib/matrix.c
    TUNE= -O0
    OPEN_BLAS_DIR=/opt/OpenBLAS
    OPEN_BLAS=-static -I$(OPEN_BLAS_DIR)/include/ -L$(OPEN_BLAS_DIR)/lib -lopenblas -lpthread

    seq_blas:
            $(CC) $(TUNE) $(CFLAGS) -o bin/seq_blas $(LIBS) src/seq_blas.c $(OPEN_BLAS)

    debug_seq_blas:
    		$(CC) $(TUNE) $(CFLAGS) -DDEBUG -o bin/seq_blas $(LIBS) src/seq_blas.c $(OPEN_BLAS)
            
    ...

All binaries are compiled without any compiler optimizations (`-O0` option).

#### run.sh

This little wrapper script is used as a shorthand when debugging. It accepts the name of the program to be compiled, matrix dimensions and optional specific arguments (such as block-size) and run the test. Run `./run.sh` for help and available options.


##### Example

	$ make testdata
    $ ./run.sh seq_ijk 8 8 8 --debug
    
    Hardware statistics .................
    CPU(s):              8
    Thread(s) per core:  2
    Core(s) per socket:  4
    Socket(s):           1
    Compiling debug seq_ijk .............

    Running tests .......................


#### Performance Tests

1. `test_sequential` - Tests performance of straightforward ijk, blocked ijk/kij and BLAS routines in matrix multiplication.
2. `test_block_size_dependence` - Tests dependence of the blocked ijk/kij algorithms on the block-size.
3. `test_mpi` - Tests MPI performance in matrix norm calculation, 4 processes.
4. `test_openmp` - Tests OpenMP performance in matrix norm calculation.
5. `test_pthread` - Tests Pthreads performance in matrix norm calculation.
6. `test_mpi_np_dependence` - Tests MPI performance against number of processes.

#### Results

<p align="center">
    <img align="center" src="https://raw.githubusercontent.com/IwoHerka/matrix-calculations/master/norm_calc_results.png">
</p>


