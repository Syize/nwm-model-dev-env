# 数值模式开发容器环境

这个目录用于构建和运行一个面向数值模式开发的 Docker 容器。当前环境基于 Ubuntu 22.04，预装了常用编译工具、OpenSSH、Intel oneAPI 编译器和 MPI、Lmod，以及 `syize` 用户的基础 shell 配置。

## 目录说明

- [Dockerfile](Dockerfile)：镜像定义。
- [docker-compose.yml](docker-compose.yml)：容器启动配置。
- [docker-compose.mounts.yml](docker-compose.mounts.yml)：由脚本生成的额外挂载配置。
- [build.sh](build.sh)：构建镜像脚本。
- [generate-mounts.sh](generate-mounts.sh)：根据挂载清单生成 compose override 文件。
- [run.sh](run.sh)：启动容器并打印状态与日志。
- [configs](configs)：写入镜像的配置文件。
- [mount](mount)：挂载到容器内、用于持久化的目录。

## 当前行为

- 镜像名称：`numerical-model-dev`
- 容器名称：`nwm-dev`
- SSH 端口映射：宿主机 `8022` -> 容器 `22`
- 容器启动命令：`/usr/local/bin/start-sshd.sh`
- 容器内开发用户：`syize`

`start-sshd.sh` 会在容器启动时检查 SSH host keys；如果挂载目录中不存在，就自动生成并复用，避免容器重建后出现 `REMOTE HOST IDENTIFICATION HAS CHANGED`。

额外的挂载点由 [generate-mounts.sh](generate-mounts.sh) 根据 [mount/mount-list](mount/mount-list) 动态生成 [docker-compose.mounts.yml](docker-compose.mounts.yml)。

## 挂载目录

`docker-compose.yml` 当前使用了这些挂载：

- `/home/syize/Documents/docker-share/ubuntu:/share`
- `./mount/dot-config:/home/syize/.config`
- `./mount/dot-local:/home/syize/.local`
- `./mount/ssh-host-keys:/etc/ssh/keys`
- `./mount/libraries/compiled:/opt/local/apps`

其中：

- `mount/dot-config` 和 `mount/dot-local` 用于保留用户级配置和 Python `--user` 安装内容。
- `mount/ssh-host-keys` 用于持久化 OpenSSH host keys。
- `mount/libraries/compiled` 用于保存手动安装的第三方库和 modulefiles。
- `mount/mount-list` 用于声明额外要挂到容器 `/home/syize/Apps` 下的本地源码或目录。

## 动态源码挂载

在 [mount/mount-list](mount/mount-list) 中，每行写一个宿主机上的绝对路径。脚本会把它挂到容器中的 `/home/syize/Documents/<basename>`。

例如：

```text
/home/syize/Documents/Python/wrfrun
/home/syize/Documents/Fortran/ARPS/arps-source-code
```

会生成等价于下面内容的额外挂载：

```yaml
services:
  numerical-model-dev:
    volumes:
      - /home/syize/Documents/Python/wrfrun:/home/syize/Documents/wrfrun
      - /home/syize/Documents/Fortran/ARPS/arps-source-code:/home/syize/Documents/arps-source-code
```

空行和以 `#` 开头的行会被忽略；如果某个路径不存在，生成脚本会直接报错并停止。

## 构建与启动

首先将你要放到容器内的 SSH public key 内容放到 [configs/ssh/public_key](configs/ssh/public_key) 中，并将要编译和使用的数值模式源码放在当前目录上层的 `models` 目录下，再把需要挂载的本地开发目录写入 [mount/mount-list](mount/mount-list)。

在当前目录下执行：

```bash
./build.sh
./run.sh
```

等价的手动命令是（有可能需要 root 权限）：

```bash
docker build --network=host -t numerical-model-dev .
./generate-mounts.sh
docker compose -f docker-compose.yml -f docker-compose.mounts.yml up -d --force-recreate
```

## 查看状态和日志

```bash
docker compose -f docker-compose.yml -f docker-compose.mounts.yml ps
docker compose -f docker-compose.yml -f docker-compose.mounts.yml logs
docker compose -f docker-compose.yml -f docker-compose.mounts.yml logs -f numerical-model-dev
```

## SSH 登录

容器镜像会把 [configs/ssh/public_key](configs/ssh/public_key) 写入 `/home/syize/.ssh/authorized_keys`。启动后可以从宿主机通过下面的方式登录：

```bash
ssh -p 8022 syize@127.0.0.1
```

如果替换了 `configs/ssh/public_key`，需要重新构建镜像并重建容器。

## 备注

- oneAPI APT 源配置位于 [configs/apt/oneAPI.list](configs/apt/oneAPI.list)。
- Python 包在镜像构建时以 `syize` 用户通过 `pip --user` 安装到 `~/.local`。
- 当前容器配置不再包含 Spack 的安装、配置或挂载逻辑。
