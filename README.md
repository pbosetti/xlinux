# Cross-compile for x86_64/am64 on Apple Silicon

This repo provides a docker image that can be used for cross-compiling binaries for Intel linux when working on M1/M2 (aka Silicon) Macs.

## Motivation

On Intel Macs it was possible to compile binaries for Linux in different ways, typically by means of virtualization: via VMWare/Parallels (GUI), via Ubuntu Multipass (CLI), via a Docker container (CLI).

On Macs with Apple Silicon chips (M1 or M2), only arm64 (aka aarch64) platforms can be virtualized, so a virtualized system (via VMware, Parallels or Multipass), can only be used for compiling binaries for linux **running on arm64** processors.

Luckily, Docker allows to execute images in multiple architectures, by passing the option `--platform`. In this way you can create a Docker image of the target architecture (i.e. amd64) that works on the M1 Mac, and run a compiler in it to create amd64 binaries.

This repo makes this process easy.

## Usage

### First step: customize needed packages

Edit the `Dockerfile` by adding (or removing) apt packages needed for compiling your software in the `RUN` block. Put one or more apt package per line separated by spaces, and remember to end each line with a backslash.

### Second step: build the image. 

Run `docker build`: 
```sh
$ docker build -t xlinux .
```
**NOTE**: the image tag must be `xinux`. If you want to use a different name, also change the value of `CROSSCOMPILE_IMAGE` environment variable in the `Dockerfile`.

By default, an image based on Ubuntu 20.04 is created. If you need an older or newer Ubuntu version, use the following syntax (in this case for 18.04):

```sh
$ docker build --build-arg release=18.04 -t xlinux .
```

### Third step: create the cross-compile command

The cross-compile command can be created by running the image with no arguments:

```sh
$ docker run --platform=linux/amd64 --rm xlinux > xlinux
$ chmod a+x xlinux
```

### Fourth step: use it!

From now on, the `xlinux` command can be used for cross-compiling by simply prepending it to any regular `clang/gcc/c++/make/cmake` command:

```sh
$ ./xlinux clang -o test src/main.c
$ ./xlinux strip test
$ ./xlinux file test
test: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=0941361def676546738e5969daba6d90227869fe, for GNU/Linux 3.2.0, stripped
```

Or:

```sh
$ ./xlinux cmake -B xbuild
$ ./xlinux cmake --build xbuild
```

## Pre-compiled images

The multiplatform image is also built and uploaded on Docker Hub. You can use it straight away as:

```sh
docker run --rm p4010/xlinux:latest > xlinux
chmod a+x xlinux
```

It will automatically pull your native image.

## Author

Paolo Bosetti (paolo dot bosetti at unitn dot it)

## License

This code is provided in open domain.