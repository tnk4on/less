# less(pager): Container image

This container image is used to build "less" from the source and run it as a container.

## Build

```
$ git clone https://github.com/tnk4on/less.git
$ cd less
$ podman build -t tnk4on/less .
```
- You can edit the version of the less in the Containerfile as necessary.
- This line: `ENV VERSION=594`

## Run

```
$ podman run --rm tnk4on/less --version | head -n 1
less 594x (POSIX regular expressions)
$ podman run --rm -it -v .:/tmp tnk4on/less <FILENAME>
```

## Copy the pre-built binary from inside the container

```
$ podman create --name less less
$ podman cp less:/root/usr/bin/less .
$ podman rm less
$ ./less --version |head -n 1
less 594x (POSIX regular expressions)
```
Note: Built with UBI by default, so RHEL or CentOS Stream may work.

## Usage: less header option

```
less --header 1
less -h 1
```
