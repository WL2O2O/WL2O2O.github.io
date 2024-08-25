---
title: 前后端项目上线教程
sticky: 100
description: 项目如何上线，教你用三种方式轻松上线
excerpt: 我的职业生涯中上线项目的三种方式————典藏版（无坑）
categories:
  - Project
tags:
  - 八股文
  - 上线项目
index_img: 'https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/online.png'
banner_img: 'https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/online.png'
abbrlink: 8932
date: 2024-08-18 18:36:43
---

# 上线项目的3种方式

## 环境准备

***注意：使用哪种方式上线，就准备对应需要的环境***

### 方式一、使用常规方式上线

- `Nginx`和`jdk`的安装与配置
  [Nginx安装配置的参考链接：](https://zhuanlan.zhihu.com/p/425790769)https://zhuanlan.zhihu.com/p/425790769
   ```bash
   # nginx 默认配置
   user  nginx;
   worker_processes  auto;
  
   error_log  /var/log/nginx/error.log notice;
   pid        /var/run/nginx.pid;
   events {
       worker_connections  1024;
   }
   http {
       include       /etc/nginx/mime.types;
       default_type  application/octet-stream;
   
       log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                       '$status $body_bytes_sent "$http_referer" '
                       '"$http_user_agent" "$http_x_forwarded_for"';
       access_log  /var/log/nginx/access.log  main;
       sendfile        on;
       #tcp_nopush     on;
   
       keepalive_timeout  65;
   
       #gzip  on;
   
       include /etc/nginx/conf.d/*.conf;
  }
    
  # 使用yum来安装jdk，免配置环境变量
  yum install -y java-1.8.0-openjdk*
   ```
### 方式二、使用宝塔面板上线

- 首先，直接建议打一个快照，标记这是安装宝塔面板之前的快照，便于我们重装系统

- 使用宝塔面板上线
  [官网教程：](https://www.bt.cn/new/download.html)https://www.bt.cn/new/download.html

### 方式三、使用`Docker`容器上线

- `Docker`的安装与配置
  [参考链接：](https://www.51cto.com/article/715012.html)https://www.51cto.com/article/715012.html

    ```bash
    # 打开配置文件
    vi /etc/docker/daemon.json
    # 原来的配置
    {
    "registry-mirrors": ["https://y5u7p3c7.mirror.aliyuncs.com"]
    }
  
    # 换用下面的配置，目前2024.08.18可用
    {
    "registry-mirrors": [
        "https://docker.m.daocloud.io"
    ]
    }
    ```

## 常见问题

1、需要更换yum源。[参考链接：](https://blog.csdn.net/qq_52545155/article/details/137229782)https://blog.csdn.net/qq_52545155/article/details/137229782


## 前端部署

### 普通上线

1、上传前端打包好的`dist`文件夹到服务器

> 一般都是直接使用本地的打包好的`dist`文件夹，如果想在服务器进行打包，可以使用`npm run build`命令，但是前提是需要在服务器进行安装`node`和`npm`，可以参考这篇文章。[专业安装NVM教程（链接待补充）](https://wl2o2o.github.io)

2、配置Nginx

```bash
# 首先进入 nginx 的配置文件目录
cd /usr/local/nginx/conf # 默认在/usr/local/nginx/conf, 也可能在 /etc/nginx
# 备份一份默认的配置文件，避免出现配置错误
cp nginx.conf nginx.conf.bak
# 编辑配置文件
vim nginx.conf
# 编写配置
## 需要改动的地方 1：更改启动用户名为root
#user  nobody;
user  root;
    ## 需要改动的地方 2：更改项目名以及遍历查找index.html
    server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {   
            # 将dist目录重命名为项目名（非必须，出于好进行管理）
            root   /root/services/smartapi-frontend;   
            index  index.html index.htm;
            # 增加一行可以遍历 root 多级目录的配置，如果没有配置只会在根目录中寻找
            try_files $uri $uri/ /index.html;
        }
    }
```

跨域解决：
```bash
location ^~ /api/ {
    # 代理到后端服务
    proxy_pass http://localhost:9000/api/;
    add_header 'Access-Control-Allow-origin' $http_origin;
    add_header 'Access-Control-Allow-Credentials' 'true';
    add_header Access-Control-Allow-Methods 'GET, POST, OPTIONS';
    add_header Access-Control-Allow-Headers '*';
    if ($request_method = 'OPTIONS') {
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Access-Control-Allow-origin' $http_origin;
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-with,If-Modified-since,Cache-Control,Content-Type,Range';
        add_header 'Access-Control-Max-Age' 1728000;
        add_header 'Content-Type' 'text/plain; charset=utf-8';
        add_header 'Content-Length' 0;
        return 204;
    }
}
```
3、重启Nginx

```bash
nginx -s reload
```

4、检查防火墙以及安全组是否开放端口，然后测试访问

### 宝塔面板

1、打开`软件商店`安装必须的环境：`jdk`、`nginx`、`mysql`等

2、打开`网站`菜单，添加站点

![添加站点](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202408182042155.png)
3、进入站点目录，上传打包好的前端`dist`

4、测试访问（有需要的话，可以手动配置nginx的配置文件）

### Docker容器

1、在服务器的根目录下创建一个`services`文件夹，然后创建对应的项目文件夹

2、使用`git`拉取后端项目源码，或者直接打包上传

3、在当前前端项目的根目录，创建一个`Dockerfile`文件，内容如下：

```dockerfile
FROM nginx

WORKDIR /usr/share/nginx/html/
USER root

COPY ./docker/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./dist  /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

4、在前端项目根目录创建一个`docker`文件夹，然后创建一个`nginx.conf`配置文件

```nginx
server {
    listen 80;

    # gzip config
    gzip on;
    gzip_min_length 1k;
    gzip_comp_level 9;
    gzip_types text/plain text/css text/javascript application/json application/javascript application/x-javascript application/xml;
    gzip_vary on;
    gzip_disable "MSIE [1-6]\.";

    root /usr/share/nginx/html;
    include /etc/nginx/mime.types;

    location / {
        try_files $uri /index.html;
    }
}
```

5、使用`docker build`命令构建镜像并运行

```bash
docker build -t smartapi-frontend .
docker run -d -p 80:80 --name xxx-frontend xxx-frontend
docker ps -a
```

6、测试访问

## 后端部署

### 普通上线

1、在本地使用`Maven`打`jar`包，或者在服务器使用`git`拉取源码，然后使用Maven命令打包

```bash
mvn clean package -Dmaven.test.skip=true
```

2、上传打包好的`jar`包到服务器

3、运行 jar 包，启动命令如下：

```bash
# 先以直观的模式启动
java -jar xxx-backend-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
# 查看是否启动成功，若启动成功，然后再次运行jar包，以后台模式运行
java -jar xxx-backend-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod > log.out 2>&1 &
```

### 宝塔面板

1、打开`文件`菜单，在`www/wwwroot`目录下创建一个`services`目录，再创建一个后端项目名字的文件夹，然后上传打包好的`jar`包到该目录下

2、打开`网站`文件夹
![添加Java项目](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202408182042157.png)

```bash
# 项目的执行命令
/usr/bin/java -jar -Xmx1024M -Xms256M  /www/wwwroot/user-center-backend/user-center-backend-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

3、测试是否启动成功

### Docker容器

1、个人习惯在服务器的根目录下创建一个`services`文件夹，然后创建对应的项目文件夹

2、使用git拉取后端项目源码，或者直接打包上传

3、在当前项目根目录编写`DockerFile`

```dockerfile
FROM maven:3.5-jdk-8-alpine as builder

# Copy local code to the container image.
WORKDIR /app
COPY pom.xml .
COPY src ./src

# Build a release artifact.
RUN mvn package -DskipTests

# Run the web service on container startup.
CMD ["java","-jar","/app/target/user-center-backend-0.0.1-SNAPSHOT.jar","--spring.profiles.active=prod"]
```

3、使用`docker build`命令构建镜像并运行

```bash
docker build -t user-center-backend:latest .
docker run -d -p 8080:8080 --name user-center-backend user-center-backend:latest
docker ps -a
```

4、测试是否启动成功

## 场景模拟
### 场景一：多`war`包部署

#### 场景描述
在不影响服务器上正常运行的基础上，将多个`war`包部署到同一个服务器上，并使用`nginx`进行负载均衡。

#### 解决方案
1、使用Docker：

- 使用`docker`创建多个`tomcat`容器，分别部署多个`war`包，并使用`nginx`进行负载均衡。

2、不使用Docker：

- 首先，复制一份tomcat

- 进入到 tomcat 的目录下, 将其中的 webapps 文件夹进行一份拷贝, 用于第二个应用的部署

- 进入到 tomcat 的服务配置文件下面, 打开 server.xml 配置文件, 填充第二个应用部署时的相关配置信息
```
  <!-- 第二个项目配置 -->
  <Service name="Catalina1">
      
    <!-- 为避免冲突, 修改端口 -->
    <Connector port="8081" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
  
    <!-- Tomcat默认使用8009端口, 避免冲突, 修改 -->
    <Connector port="8010" protocol="AJP/1.3" redirectPort="8443"/>
  	
    <!-- Engine 节点, name 修改为 Catalina1 -->
    <!-- 服务启动后会在 conf 下生成相应的引擎文件夹, 名称保持一致. -->
    <Engine name="Catalina1" defaultHost="localhost">
      <Realm className="org.apache.catalina.realm.LockOutRealm">
        <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
               resourceName="UserDatabase"/>
      </Realm>
  
      <!-- 修改Host节点，appBase修改为需要进行发布的文件位置, 也就是第一步复制的 webapps1 -->
      <Host name="localhost"  appBase="webapps1"
            unpackWARs="true" autoDeploy="true">
  
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log" suffix=".txt"
               pattern="%h %l %u %t &quot;%r&quot; %s %b" />
  
      </Host>
    </Engine>
  </Service>
```

- 配置nginx负载均衡，记得`nginx -s reload`

- 脚本启动tomcat，记得`start.sh`