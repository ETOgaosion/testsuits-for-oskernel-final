#!/bin/bash
PATH="$(pwd)/:$PATH"
cp libc.so /lib/ld-musl-riscv64-sf.so.1
mkdir -p /code/lmbench/riscv64/bin
cp lmbench_all /code/lmbench/riscv64/bin

busybox echo "run time-test"
./time-test
busybox echo "run busybox_testcode.sh"
./busybox_testcode.sh
busybox echo "run iozone_testcode.sh"
./iozone_testcode.sh
busybox echo "run libctest_testcode.sh"
./libctest_testcode.sh
busybox echo "run lmbench_testcode.sh"
./lmbench_testcode.sh
busybox echo "run lua_testcode.sh"
./lua_testcode.sh
busybox echo "run unixbench_testcode.sh"
./unixbench_testcode.sh
busybox echo "run netperf_testcode.sh"
./netperf_testcode.sh
busybox echo "run iperf_testcode.sh"
./iperf_testcode.sh
busybox echo "run cyclictest_testcode.sh"
./cyclictest_testcode.sh
