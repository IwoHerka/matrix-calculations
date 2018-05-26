#!/bin/bash

echo "Hardware statistics ................."
lscpu | grep -E '^Thread|^Core|^Socket|^CPU\('

echo "Compiling ..........................."
echo

echo "Compiling blocked sequential ijk"
make blk_seq_ijk 1>/dev/null
echo "Compiling blocked sequential kij"
make blk_seq_kij 1>/dev/null

echo

echo "Running tests ......................."
echo

BLKSIZE=32

echo "Block = 32 .........................."
echo "512 x 512 ..........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1024 x 1024 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1536 x 1536 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2048 x 2048 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2560 x 2560 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3072 x 3072 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3584 x 3584 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "4096 x 4096 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

BLKSIZE=64

echo "Block = 64 .........................."
echo "512 x 512 ..........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1024 x 1024 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1536 x 1536 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2048 x 2048 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2560 x 2560 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3072 x 3072 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3584 x 3584 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "4096 x 4096 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

BLKSIZE=128

echo "Block = 128 ........................."
echo "512 x 512 ..........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1024 x 1024 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1536 x 1536 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2048 x 2048 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2560 x 2560 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3072 x 3072 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3584 x 3584 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "4096 x 4096 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

BLKSIZE=256

echo "Block = 256 ........................."
echo "512 x 512 ..........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1024 x 1024 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1536 x 1536 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2048 x 2048 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2560 x 2560 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3072 x 3072 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3584 x 3584 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "4096 x 4096 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

BLKSIZE=512

echo "Block = 512 ........................."
echo "512 x 512 ..........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1024 x 1024 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1536 x 1536 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2048 x 2048 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2560 x 2560 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3072 x 3072 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3584 x 3584 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "4096 x 4096 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

BLKSIZE=1024

echo "Block = 1024 ........................"
echo "512 x 512 ..........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/512x512a.txt data/512x512b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1024 x 1024 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1024x1024a.txt data/1024x1024b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "1536 x 1536 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/1536x1536a.txt data/1536x1536b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2048 x 2048 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2048x2048a.txt data/2048x2048b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "2560 x 2560 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/2560x2560a.txt data/2560x2560b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3072 x 3072 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3072x3072a.txt data/3072x3072b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "3584 x 3584 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/3584x3584a.txt data/3584x3584b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"

echo "4096 x 4096 ........................."
cal_t=$((time bin/blk_seq_ijk $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked ijk algorithm        $cal_t"
cal_t=$((time bin/blk_seq_kij $BLKSIZE data/4096x4096a.txt data/4096x4096b.txt)  2>&1 > /dev/null | grep real | awk '{print $2}')
echo "Blocked kij algorithm        $cal_t"
