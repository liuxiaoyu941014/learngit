# 部署

## 准备数据库账号

访问 pgweb.tamigos.com ，创建数据库和用户

创建数据库：

```
create database account
```

创建用户：

```
create user sso with login password 'xxx';
GRANT ALL PRIVILEGES ON DATABASE account to sso;
```

## 创建项目namespace

如果不存在，就创建

```shell
kubectl create namespace tanmer
```

把域名的TLS证书加入secret（如果没有）

> 需要把tanmer.com的证书下载到当前的ssl目录

```shell
kubectl -n tanmer create secret tls tanmer-account-tls --cert=ssl/public.pem --key=ssl/private.key
```

把Docker的用户名密码加入secret（如果没有）

```shell
kubectl -n tanmer create secret docker-registry tanmer-docker --docker-server=docker.corp.tanmer.com --docker-username=rancher --docker-password= --docker-email=rancher@tanmer.com
```

把`config/appliction.yml`的配置加入secret

```shell
kubectl -n tanmer create secret generic sso-config --from-file=./application.yml
```

更新配置：

```shell
kubectl -n tanmer delete secret sso-config
kubectl -n tanmer create secret generic sso-config --from-file=./application.yml
```

## 用Helm部署

修改相应配置信息`values.yml`，，然后执行：

```shell
helm install --name sso --namespace tanmer .
```

注意，执行之前，修改`values.yaml`的`image.tag`值为Docker image最新tag

如果出现如下错误：

```
Error: incompatible versions client[v2.7.2] server[v2.6.1]
```

执行下面命令更新服务器的Tiller

```shell
helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.7.2 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
```

## Helm更新

```
helm upgrade sso --set image.tag=release-20180313 .
```

## 调试Helm配置

```
helm template --name sso --namespace tanmer --set image.tag=release-xxxx .
```
