CC=gcc
CFLAGS= -Wall -std=gnu99 -g
LIBS=src/lib/matrix.c
TUNE= -O0
OPEN_BLAS_DIR=/opt/OpenBLAS
OPEN_BLAS=-static -I$(OPEN_BLAS_DIR)/include/ -L$(OPEN_BLAS_DIR)/lib -lopenblas -lpthread

seq_ijk:
		$(CC) $(TUNE) $(CFLAGS) -o bin/seq_ijk $(LIBS) src/seq_ijk.c

seq_kij:
		$(CC) $(TUNE) $(CFLAGS) -DDEBUG -o bin/seq_kij $(LIBS) src/seq_kij.c

seq_blas:
		$(CC) $(TUNE) $(CFLAGS) -o bin/seq_blas $(LIBS) src/seq_blas.c $(OPEN_BLAS)

debug_seq_blas:
		$(CC) $(TUNE) $(CFLAGS) -DDEBUG -o bin/seq_blas $(LIBS) src/seq_blas.c $(OPEN_BLAS)

debug_seq_ijk:
		$(CC) $(TUNE) $(CFLAGS) -DDEBUG -o bin/seq_ijk $(LIBS) src/seq_ijk.c

blk_seq_ijk:
		$(CC) $(TUNE) $(CFLAGS) -o bin/blk_seq_ijk $(LIBS) src/blk_seq_ijk.c

debug_blk_seq_ijk:
		$(CC) $(TUNE) $(CFLAGS) -DDEBUG -o bin/blk_seq_ijk $(LIBS) src/blk_seq_ijk.c

blk_seq_kij:
		$(CC) $(TUNE) $(CFLAGS) -o bin/blk_seq_kij $(LIBS) src/blk_seq_kij.c

debug_blk_seq_kij:
		$(CC) $(TUNE) $(CFLAGS) -DDEBUG -o bin/blk_seq_kij $(LIBS) src/blk_seq_kij.c

pthread:
		$(CC) $(TUNE) $(CFLAGS) -pthread -o bin/pthread $(LIBS) src/pthread.c

debug_pthread:
		$(CC) $(TUNE) $(CFLAGS) -DDEBUG -pthread -o bin/pthread $(LIBS) src/pthread.c

openmp:
		$(CC) $(TUNE) $(CFLAGS) -fopenmp -o bin/openmp $(LIBS) src/openmp.c

debug_openmp:
		$(CC) $(TUNE) $(CFLAGS) -DDEBUG -fopenmp -o bin/openmp $(LIBS) src/openmp.c

mpi:
		mpicc $(tune) $(cflags) -o bin/mpi $(LIBS) src/mpi.c -lm

debug_mpi:
		mpicc $(tune) $(cflags) -DDEBUG -o bin/mpi $(LIBS) src/mpi.c -lm


clean:
		rm -f bin/*; rm -f data/*

cleanbin:
		rm -f bin/*

cleandata:
		rm -f data/*

PYTASK=python random_matrix.py

testdata:
		$(PYTASK) 8 8 > data/8x8a.txt
		$(PYTASK) 8 8 > data/8x8b.txt
		$(PYTASK) 8 16 > data/8x16a.txt
		$(PYTASK) 16 8 > data/16x8b.txt
		$(PYTASK) 16 16 > data/16x16a.txt
		$(PYTASK) 16 16 > data/16x16b.txt
		$(PYTASK) 512 512 > data/512x512a.txt
		$(PYTASK) 512 512 > data/512x512b.txt
		$(PYTASK) 1024 1024 > data/1024x1024a.txt
		$(PYTASK) 1024 1024 > data/1024x1024b.txt
		$(PYTASK) 1536 1536 > data/1536x1536a.txt
		$(PYTASK) 1536 1536 > data/1536x1536b.txt
		$(PYTASK) 2048 2048 > data/2048x2048a.txt
		$(PYTASK) 2048 2048 > data/2048x2048b.txt
		$(PYTASK) 2560 2560 > data/2560x2560a.txt
		$(PYTASK) 2560 2560 > data/2560x2560b.txt
		$(PYTASK) 3072 3072 > data/3072x3072a.txt
		$(PYTASK) 3072 3072 > data/3072x3072b.txt
		$(PYTASK) 3584 3584 > data/3584x3584a.txt
		$(PYTASK) 3584 3584 > data/3584x3584b.txt
		$(PYTASK) 4096 4096 > data/4096x4096a.txt
		$(PYTASK) 4096 4096 > data/4096x4096b.txt
