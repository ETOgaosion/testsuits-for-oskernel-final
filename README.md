# Testsuits for OS Kernel

尽力支持busybox, lua, lmbench三个示例程序。

[busybox cmd](docs/busybox_cmd.txt)里给出了50个常用或容易支持的命令，可以先试着支持这50个命令。这些命令所使用的系统调用请参考[这个目录](docs/busybox_cmd_syscalls)所对应的文件，这些命令所依赖的系统调用都是用`strace -f -c`命令得到的。

获取lua所使用的系统调用的两个例子：

```
# 例子一，让lua执行一个字符串：
strace -f -c -o lua_print_syscall.txt ./lua -e 'print("Hello World!")'

# 例子二，让lua执行一个脚本：
strace -f -c -o lua_print_syscall.txt ./lua print.lua
```

print.lua的内容如下：

> print("Hello World!")

lmbench依次执行了一些小程序来测试系统的性能，可分析`bin/lmbench`来依次执行这些小程序，以达到对lmbench逐步的支持。

## 示例程序所包含的系统调用
文档每行中前半部分`li a7,[NUM]`是二进制文件里使用系统调用时，系统调用号所对应的那条指令。后半部分`__NR_xxx [NUM]` 是头文件`unistd.h`里系统调用的名称及编号。

[busybox使用的系统调用](docs/busybox_musl_static_syscall.txt)

[lua使用的系统调用](docs/lua_musl_static_syscalls.txt)

[lmbench使用的系统调用](docs/lmbench_libc_syscall.txt)

```
# 从二进制文件中获取系统调用号
objdump -d objfile | grep -B 9 ecall | grep "li.a7" | tee syscall.txt
```



## 示例程序运行环境
示例程序的运行环境是Debian on Qemu RV64，搭建过程如下：

1. 在[https://people.debian.org/~gio/dqib/](https://people.debian.org/~gio/dqib/)点击[Images for riscv64-virt](https://gitlab.com/api/v4/projects/giomasce%2Fdqib/jobs/artifacts/master/download?job=convert_riscv64-virt)下载artifacts.zip。
2. 解压。`unzip artifacts.zip`
3. 安装`qemu-sysstem-riscv64`，`opensib`和`u-boot-qemu`。
4. 参考`artifacts/readme.txt`里的指令启动debian。

> 也可选择使用搭建好的镜像，下载地址：[debian-oscomp](https://cloud.tsinghua.edu.cn/f/1ffc4bc9149645a896ea/?dl=1)
>
> 执行`./run.sh`进入系统，登陆用户名：root，密码：root

## 示例程序编译过程

编译环境的准备

```bash
# 安装必要的软件
sudo apt install build-essentials
sudo apt install musl-tools

# gcc是到gcc-10的链接，现在要让它变成musl-gcc的链接
rm /usr/bin/gcc	
ln -s /usr/bin/musl-gcc /usr/bin/gcc
# musl-gcc使用了cc，要让cc链接到正确的编译器gcc-10
rm /usr/bin/cc	
ln -s /usr/bin/gcc-10 /usr/bin/cc
```

编译busybox

```bash
# 需要包含一些linux头文件
ln -s /usr/include/linux /usr/include/riscv-linux-musl/
ln -s /usr/include/asm-generic /usr/include/riscv-linux-musl/asm
ln -s /usr/include/mtd /usr/include/riscv-linux-musl/
cp /usr/include/riscv64-linux-gnu/asm/byteorder.h /usr/include/asm-generic

# 编译busybox
 cd busybox
vi menuconfig	# 把"CC = gcc"改为"CC = gcc-10"，为了使下一条命令正确执行
make menuconfig	# 默认动态编译，如需静态编译则设置CONFIG_STATIC=y
vi menuconfig	# 把"CC = gcc-10"改为"CC = gcc"，为了基于musl库编译busybox
make
```

编译lua

```bash
cd lua
make posix	# 动态编译。由于之前的准备，现在gcc就是musl-gcc
make posix CC="gcc -static"	# 静态编译
```

编译lmbench

```bash
cd lmbench
make results CC="gcc-10"	# 动态编译并执行
make results CC="gcc-10 -static"	# 静态编译并执行
make see CC="gcc-10"		# 查看结果
```

