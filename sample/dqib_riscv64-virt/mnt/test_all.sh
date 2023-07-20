#!/bin/bash
PATH="$(pwd)/:$PATH"
cp libc.so /lib/ld-musl-riscv64-sf.so.1
mkdir -p /code/lmbench/riscv64/bin
cp lmbench_all /code/lmbench/riscv64/bin

busybox echo "run time-test"
strace -o strace/time.txt ./time-test
strace -c -o strace/time-list.txt ./time-test
busybox echo "run busybox_testcode.sh"
strace -o strace/busybox.txt ./busybox_testcode.sh
strace -c -o strace/busybox-list.txt ./busybox_testcode.sh
busybox echo "run iozone_testcode.sh"
strace -o strace/iozone.txt ./iozone_testcode.sh
strace -c -o strace/iozone-list.txt ./iozone_testcode.sh
busybox echo "run libctest_testcode.sh"
strace -o strace/libctest.txt ./libctest_testcode.sh
strace -c -o strace/libctest-list.txt ./libctest_testcode.sh
busybox echo "run lmbench_testcode.sh"
strace -o strace/lmbench.txt ./lmbench_testcode.sh
strace -c -o strace/lmbench-list.txt ./lmbench_testcode.sh
busybox echo "run lua_testcode.sh"
strace -o strace/lua.txt ./lua_testcode.sh
strace -c -o strace/lua-list.txt ./lua_testcode.sh
busybox echo "run unixbench_testcode.sh"
strace -o strace/unixbench.txt ./unixbench_testcode.sh
strace -c -o strace/unixbench-list.txt ./unixbench_testcode.sh
busybox echo "run netperf_testcode.sh"
strace -o strace/netperf.txt ./netperf_testcode.sh
strace -c -o strace/netperf-list.txt ./netperf_testcode.sh
busybox echo "run iperf_testcode.sh"
strace -o strace/iperf.txt ./iperf_testcode.sh
strace -c -o strace/iperf-list.txt ./iperf_testcode.sh
busybox echo "run cyclictest_testcode.sh"
strace -o strace/cyclic.txt ./cyclictest_testcode.sh
strace -c -o strace/cyclic-list.txt ./cyclictest_testcode.sh