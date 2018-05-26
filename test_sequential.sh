#!/bin/bash

echo "Hardware statistics ................."
lscpu | grep -E '^Thread|^Core|^Socket|^CPU\('

echo "Checking test data .................."
echo

echo "Compiling ..........................."
echo

echo "Compiling sequential ijk"
make seq_ijk 1>/dev/null
echo "Compiling blocked sequential ijk"
make blk_seq_ijk 1>/dev/null
echo "Compiling blocked sequential kij"
make blk_seq_kij 1>/dev/null
echo "Compiling BLAS"
make seq_blas 1>/dev/null
echo

echo "Running tests ......................."
echo

echo "512 x 512 ..........................."
cal_t=$((time bin/seq_ijk data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "ijk algorithm                $cal_t"
cal_t=$((time bin/blk_seq_ijk data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"
cal_t=$((time bin/seq_blas data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "BLAS                         $cal_t"

echo "1024 x 1024 ..........................."
cal_t=$((time bin/seq_ijk data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "ijk algorithm                $cal_t"
cal_t=$((time bin/blk_seq_ijk data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"
cal_t=$((time bin/seq_blas data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "BLAS                         $cal_t"

echo "1536 x 1536 ..........................."
cal_t=$((time bin/seq_ijk data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "ijk algorithm                $cal_t"
cal_t=$((time bin/blk_seq_ijk data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"
cal_t=$((time bin/seq_blas data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "BLAS                         $cal_t"

echo "2048 x 2048 ..........................."
cal_t=$((time bin/seq_ijk data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "ijk algorithm                $cal_t"
cal_t=$((time bin/blk_seq_ijk data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"
cal_t=$((time bin/seq_blas data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "BLAS                         $cal_t"

echo "2560 x 2560 ..........................."
cal_t=$((time bin/seq_ijk data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "ijk algorithm                $cal_t"
cal_t=$((time bin/blk_seq_ijk data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"
cal_t=$((time bin/seq_blas data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "BLAS                         $cal_t"

echo "3072 x 3072 ..........................."
cal_t=$((time bin/seq_ijk data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "ijk algorithm                $cal_t"
cal_t=$((time bin/blk_seq_ijk data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"
cal_t=$((time bin/seq_blas data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "BLAS                         $cal_t"

echo "3584 x 3584 ..........................."
cal_t=$((time bin/seq_ijk data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "ijk algorithm                $cal_t"
cal_t=$((time bin/blk_seq_ijk data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"
cal_t=$((time bin/seq_blas data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "BLAS                         $cal_t"

echo "4096 x 4096 ..........................."
cal_t=$((time bin/seq_ijk data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "ijk algorithm                $cal_t"
cal_t=$((time bin/blk_seq_ijk data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"
cal_t=$((time bin/seq_blas data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "BLAS                         $cal_t"
