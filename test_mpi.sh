#!/bin/bash

echo "Hardware statistics ................."
lscpu | grep -E '^Thread|^Core|^Socket|^CPU\('

echo "Compiling MPI ......................."
echo

make mpi 1>/dev/null

echo "Running tests ......................."
echo

cal_t=$((time mpirun -np 4 bin/mpi data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "512 x 512 ..................... $cal_t"
cal_t=$((time mpirun -np 4 bin/mpi data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "1024 x 1024 ................... $cal_t"
cal_t=$((time mpirun -np 4 bin/mpi data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "1536 x 1536 ................... $cal_t"
cal_t=$((time mpirun -np 4 bin/mpi data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "2048 x 2048 ................... $cal_t"
cal_t=$((time mpirun -np 4 bin/mpi data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "2560 x 2560 ................... $cal_t"
cal_t=$((time mpirun -np 4 bin/mpi data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "3072 x 3072 ................... $cal_t"
cal_t=$((time mpirun -np 4 bin/mpi data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "3584 x 3584 ................... $cal_t"
cal_t=$((time mpirun -np 4 bin/mpi data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "4096 x 4096 ................... $cal_t"
