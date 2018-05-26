#!/bin/bash
for LAST; do true; done

if [ -z "$1" ]; then
    echo "./run.sh <name> <A-nr-rows> <B-nr-rows> <B-nr-cols>"
    echo "         [<block-size>] [--debug]"
    echo
    echo "Missing argument. Choices:"
    echo
    echo "seq_ijk ............... Sequential ijk multiplication"
    echo "seq_kij ..............  Sequential kij multiplication"
    echo "seq_blas ............. Sequential BLAS multiplication"
    echo "blk_seq_ijk ... Blocked sequential ijk multiplication"
    echo "blk_seq_kij ... Blocked sequential kij multiplication"
    echo "pthread ...................... Pthreads infinity norm"
    echo "openmp ......................... OpenMP infinity norm"
    echo "mpi ............................... MPI infinity norm"
    echo
    echo "To compile debug (verbose) use \"--debug\" option."
    echo "Blocked variants expect extra argument for the block size."
else
    if [ "$LAST" = "--debug" ]; then
        echo "Compiling debug $1..."
        make debug_$1
        echo "Testing..."
        echo "bin/$1 data/$2x$3a.txt data/$3x$4b.txt $5"
        time bin/$1 data/$2x$3a.txt data/$3x$4b.txt $5
    else
        echo "Compiling $1..."
        make $1
        echo "Testing..."
        echo "bin/$1 data/$2x$3a.txt data/$3x$4b.txt $5"
        time bin/$1 data/$2x$3a.txt data/$3x$4b.txt $5
    fi
fi
