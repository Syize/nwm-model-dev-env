# 数值模式开发容器环境

这个仓库用于存储生成和启动用于开发数值模式的 docker 镜像和容器。文件目录，以及他们的作用如下：

- [Dockerfile](Dockerfile)：定义生成镜像时需要进行的设置
- [docker-compose](docker-compose.yml)：定义启动容器时需要进行的设置
- [configs](configs)：存放用于放到容器中的配置文件
- [mount](mount)：用于挂载到容器中的仅与容器环境相关的目录

当前仓库里还没有 `docker-compose.yml`。现阶段可以先在 `dev-env/` 目录中直接构建镜像：

```bash
cd dev-env
docker build -t numerical-model-dev .
```
