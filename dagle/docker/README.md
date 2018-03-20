# Docker部署说明

## 必要条件

- 安装并启动了Docker，下载安装参考https://www.docker.com
- cms-templates和dagle两个项目在同一个目录
- 编译之前，保证git status返回的结果没有指出有未签入文件，否则未签入的文件都会被编译进镜像
- 本地安装了kubectl命令行，用户部署到k8s集群系统。下载参考https://kubernetes.io/docs/tasks/tools/install-kubectl/
- 本地已经有了部署的token，并存储在`~/.kube/config`中。

## 编译dagle的镜像

    $ cd dagle
    $ docker/build-image.sh

编译成功后，会出现这样的输出：

    Successfully tagged docker.corp.tanmer.com/tanmer/dagle:imolin_diamond-20171223133830


    you can push image to out reigistry with this command:

        docker tag docker.corp.tanmer.com/tanmer/dagle:{imolin_diamond-20171223133830,latest}
        docker push docker.corp.tanmer.com/tanmer/dagle:latest

这时，执行下面代码，把镜像提交的服务器

    $ docker push docker.corp.tanmer.com/tanmer/dagle:imolin_diamond-20171223133830

注意，这里`docker.corp.tanmer.com/tanmer/dagle:`后面的文字是动态的，根据编译的分支和时间而变化

## 编译cms-templates的镜像

    $ cd cms-templates
    $ ./build-docker.sh

编译成功之后的输出，和dagle差不多，这时提交镜像到服务器

    docker push docker.corp.tanmer.com/tanmer/cms-templates:20171223132743

## 部署到k8s集群（production 环境）

先获得最新的部署文件, 进入项目的部署文件夹，如cn-imolin

    $ git clone https://gitlab.tanmer.com/tanmer-admin/deploy
    $ cd deploy/cn-imolin

每个文件对应的功能是：

    deploy-all.sh                    ** 部署所有服务
    k8s.imolin-admin.deploy.yml     *** 部署admin端
    k8s.imolin-api.deploy.yml       *** 部署API
    k8s.imolin-backend.deploy.yml   *** 部署sidekiq后台任务
    k8s.imolin-cable.deploy.yml     *** 部署cable服务
    k8s.imolin.cm.yml                 * 部署项目配置文件application.yml和settings.xxx.yml
    k8s.imolin.ing.yml                  部署域名与服务的绑定（外网可以访问服务的地址）
    k8s.imolin.lr.yml                   对服务的CPU、内存限制，超出限制，服务将重启
    k8s.imolin.ns.yml                   项目命名空间
    k8s.imolin.pv.yml                   持久化文件存储卷
    k8s.imolin.pvc.yml                  申请持久化文件存储卷
    restart-all.sh                   ** 重启所有服务

- 没有星号的，基本上运行一次就不用再运行了
- 打1个星号的，根据情况会修改，但修改不频繁
- 打2个星号的，不用修改内容，平时部署都需要执行的脚本
- 打3个星号的，每次编译了新的dagle镜像，都需要修改对应的镜像版本，如上面的版本号是`imolin_diamond-20171223133830`

如果是首次部署：

    $ ./deploy-all.sh

如果是更新服务：

    $ ./upgrade-svc.sh

如果是更新了配置文件：

    $ kubectl apply -f k8s.imolin.cm.yml

## 查看部署状态

部署命令执行完后，服务不会马上可以，可通过下面命令查看状态：

    $ kubectl -n imolin get po --watch
    NAME                       READY     STATUS        RESTARTS   AGE
    admin-76c966f64c-j7l2n     0/1       Init:0/1      0          3s
    admin-76c966f64c-m796m     0/1       Init:0/1      0          3s
    admin-7bb7456cbd-d9ghm     1/1       Terminating   0          1m
    admin-7bb7456cbd-j88r2     1/1       Running       0          1m
    api-6c4cf54998-2lb8c       1/1       Running       0          12m
    api-6c4cf54998-px65z       1/1       Running       0          12m
    backend-646d5c88c6-bqxjd   1/1       Running       0          12m
    cable-5c469dfd8d-t4zwc     1/1       Running       0          12m
    cable-5c469dfd8d-xr2qn     1/1       Running       0          12m

上面的`Terminating`代表服务正在中止，`Init:0/1`表示正在初始化，`Running`表示已经准备好了。

这是，可以用以下命令查看准备好的服务输出的日志：

    $ kubectl -n imolin logs cable-5c469dfd8d-xr2qn
    ...
    * Environment: production
    * Listening on tcp://0.0.0.0:5000
    Use Ctrl-C to stop

 查看rails的日志输出：

    $ kubectl -n imolin exec cable-5c469dfd8d-xr2qn -- tail -f log/production.log

## 登录到每个服务

通过这个命令可以获得当前正在执行的服务：

    $ kubectl -n imolin get po
    NAME                       READY     STATUS    RESTARTS   AGE
    admin-6b996448ff-r6mh6     1/1       Running   0          5m
    admin-6b996448ff-zkcwd     1/1       Running   0          5m
    api-6c4cf54998-2lb8c       1/1       Running   0          5m
    api-6c4cf54998-px65z       1/1       Running   0          5m
    backend-646d5c88c6-bqxjd   1/1       Running   0          5m
    cable-5c469dfd8d-t4zwc     1/1       Running   0          5m
    cable-5c469dfd8d-xr2qn     1/1       Running   0          5m

要进入admin服务，就执行：

    $ kubectl -n imolin exec -it admin-6b996448ff-r6mh6 bash

更快捷地进入某个服务，还可以这样：

    kubectl -n imolin exec -it $(kubectl -n imolin get po -l app=admin -o jsonpath="{.items[0].metadata.name}") bash

修改`admin`为`api`就可以进入api服务

    kubectl -n imolin exec -it $(kubectl -n imolin get po -l app=api -o jsonpath="{.items[0].metadata.name}") bash
