<h1 align="center">TinyOS</h1>
<h3 align="center">TinyOS is a simple OS made in C</h3>

## How to run

### Prerequisites

- [Docker](https://www.docker.com/) for creating our build environment.
- [Qemu](https://www.qemu.org/) for emulating the operating system.

### Setup

First build an environment

```sh
docker build buildenv -t tinyos
```

### Build

Enter build environment:

- Linux or MacOS:

```sh
docker run --rm -it -v "$(pwd)":/root/env tinyos
```

- Windows (CMD):

```sh
docker run --rm -it -v "%cd%":/root/env tinyos
```

- Windows (PowerShell):

```sh
docker run --rm -it -v "${pwd}:/root/env" tinyos
```

Build for x86 (other architectures may come in the future):

```sh
make build-x86_64
```

exit the environment using `exit`

### Emulate

To emulate the OS with Qemu run: ([Qemu should be in path](https://dev.to/whaleshark271/using-qemu-on-windows-10-home-edition-4062))

```sh
qemu-system-x86_64 -cdrom dist/x86_64/kernel.iso
```
