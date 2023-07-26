NPROC = 16
MUSL_PREFIX = riscv64-linux-gnu
MUSL_GCC = $(MUSL_PREFIX)-gcc
MUSL_STRIP = $(MUSL_PREFIX)-strip
CFLAGS = -g

build_all: busybox lua lmbench libctest iozone libc-bench netperf iperf unix-bench cyclictest time-test test_all true copy-file-range-test interrupts-test

busybox: .PHONY
	cp busybox-config busybox/.config
	make -C busybox CC="$(MUSL_GCC) -static -g" STRIP=$(MUSL_STRIP) -j$(NPROC)
	cp busybox/busybox sdcard/
	cp scripts/busybox/* sdcard/

lua: .PHONY
	make -C lua CC="$(MUSL_GCC) -static -g" -j $(NPROC)
	cp lua/src/lua sdcard/
	cp scripts/lua/* sdcard/

lmbench: .PHONY
	make -C lmbench build CC="riscv64-linux-gnu-gcc -static -g" OS=riscv64 -j $(NPROC)
	cp lmbench/bin/riscv64/lmbench_all sdcard/
<<<<<<< HEAD
<<<<<<< HEAD
	cp lmbench/bin/riscv64/hello sdcard/
=======
	cp lmbench/bin/riscv64/hello sd
>>>>>>> bed6afa (update)
=======
	cp lmbench/bin/riscv64/hello sdcard/
>>>>>>> 11a8d79 (update Makefile)
	cp scripts/lmbench/* sdcard/

libctest: .PHONY
	make -C libc-test disk -j $(NPROC)
	cp libc-test/disk/* sdcard/
	mv sdcard/run-all.sh sdcard/libctest_testcode.sh

iozone: .PHONY
	make -C iozone linux CC="$(MUSL_GCC) -static -g" -j $(NPROC)
	cp iozone/iozone sdcard/
	cp scripts/iozone/* sdcard/

libc-bench: .PHONY
	make -C libc-bench CC="$(MUSL_GCC) -static -g" -j $(NPROC)
	cp libc-bench/libc-bench sdcard/libc-bench

unix-bench: .PHONY
<<<<<<< HEAD
	make -C UnixBench -j $(NPROC) all
=======
	make -C UnixBench CC="riscv64-linux-gnu-gcc" ARCH=riscv64 -j $(NPROC) all
>>>>>>> bed6afa (update)
	cp UnixBench/pgms/* sdcard
	cp scripts/unixbench/*.sh sdcard
	cp scripts/unixbench/sort.src sdcard

netperf: .PHONY
	cd netperf && ./autogen.sh
	cd netperf && ac_cv_func_setpgrp_void=yes ./configure --host riscv64 CC=$(MUSL_GCC) CFLAGS="-static -ggdb3 -O0"
	cd netperf && make -j $(NPROC)
	cp netperf/src/netperf netperf/src/netserver sdcard/
	cp scripts/netperf/* sdcard/

iperf: .PHONY
	cd iperf &&	./configure --host=riscv64-linux-musl CC="$(MUSL_GCC) -g" CFLAGS="$(CFLAGS)" --enable-static-bin --without-sctp && make
	cp iperf/src/iperf3 sdcard/
	cp scripts/iperf/iperf_testcode.sh sdcard/

<<<<<<< HEAD
cyclictest: .PHONY
	make -C rt-tests cyclictest hackbench
	cp rt-tests/cyclictest rt-tests/hackbench sdcard/
	cp scripts/cyclictest/cyclictest_testcode.sh sdcard/

=======
>>>>>>> 984613c (add iperf testcode)
time-test: .PHONY
	make CC="$(MUSL_GCC) -g" -C time-test all
	cp time-test/time-test sdcard

test_all: .PHONY
	cp scripts/test_all.sh sdcard/test_all.sh

true: .PHONY
	make CC=$(MUSL_GCC) -C true
	$(MUSL_STRIP) true/true
	mkdir -p sdcard/bin
	cp true/true sdcard/bin/

copy-file-range-test: .PHONY
	make CC=$(MUSL_GCC) -C $@
	$(MUSL_STRIP) $@/$@-*
	cp $@/$@-* sdcard/

interrupts-test: .PHONY
	make CC=$(MUSL_GCC) -C $@
	$(MUSL_STRIP) $@/$@-*
	cp $@/$@-* sdcard/

unix-bench: .PHONY
	make -C UnixBench -j $(NPROC) all
	cp UnixBench/pgms/* sdcard
	cp scripts/unixbench/*.sh sdcard

sdcard: build_all

test_all: .PHONY
	cp scripts/test_all.sh sdcard/test_all.sh

sdcard: build_all .PHONY
	dd if=/dev/zero of=sdcard.img count=62768 bs=1K
	mkfs.vfat -F 32 sdcard.img
	mkdir -p mnt
	mount -t vfat -o user,umask=000,utf8=1 --source sdcard.img --target mnt
	cp -r sdcard/* mnt
	mkdir mnt/strace
	umount mnt

qemu: .PHONY
	cd oscomp-debian && ./run.sh

clean: .PHONY
	make -C busybox clean
	make -C lua clean
	make -C lmbench clean
	make -C libc-test clean
	make -C iozone clean
	make -C libc-bench clean
	make -C netperf clean
	make -C iperf clean
	make -C UnixBench clean
	make -C time-test clean
<<<<<<< HEAD
	make -C rt-tests clean
	make -C copy-file-range-test clean
	make -C interrupts-test clean
	make -C UnixBench clean
=======
>>>>>>> 11a8d79 (update Makefile)
	- rm sdcard/*
	- rm sdcard.img
	- rm sdcard.img.gz

.PHONY:
