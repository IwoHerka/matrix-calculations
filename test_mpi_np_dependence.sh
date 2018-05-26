#!/bin/bash

echo "Hardware statistics ................."
lscpu | grep -E '^Thread|^Core|^Socket|^CPU\('

echo "Compiling MPI ......................."
echo

make mpi 1>/dev/null

echo "Running tests ......................."
echo

cal_t=$((time mpirun -np 1 bin/mpi data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "4096 x 4096 - 1 ............... $cal_t"
cal_t=$((time mpirun -np 2 bin/mpi data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "4096 x 4096 - 2 ............... $cal_t"
cal_t=$((time mpirun -np 3 bin/mpi data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "4096 x 4096 - 3 ............... $cal_t"
cal_t=$((time mpirun -np 4 bin/mpi data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "4096 x 4096 - 4 ............... $cal_t"
