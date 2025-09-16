---
title: netblog
tags:
  - 网站搭建
categories:
  - Blog
abbrlink: f3dfbe7f
date: 2023-08-22 01:23:17
---

# 博客上云

> 博客的访问速度实在是太慢了，准备尝试把博客部署到华为云ECS。
>
> 环境：
>
> 华为云CentOS

新鲜事第一步：打开官方文档

​	[Hexo博客的官方文档](https://hexo.io/zh-cn/docs/)

## 安装前提

安装 Hexo 相当简单，只需要先安装下列应用程序即可：

- [Node.js](http://nodejs.org/) (Node.js 版本需不低于 10.13，建议使用 Node.js 12.0 及以上版本)
- [Git](http://git-scm.com/)

如果您的电脑中已经安装上述必备程序，那么恭喜您！你可以直接前往 [安装 Hexo](https://hexo.io/zh-cn/docs/#安装-Hexo) 步骤。

### Node的安装

为了后续排错方便，我们使用 NVM 来进行 Node 的安装。

```
# 安装NVM
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/

# 激活配置
$ source ~/.bashrc
```

![image-20230822013352104](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308220133637.png)

#### Node.js 版本限制

如果你坚持使用旧的 Node.js，你可以考虑安装 Hexo 的过去版本。

请注意，我们不提供对过去版本 Hexo 的错误修复。

我们强烈建议永远安装 [最新版本](https://www.npmjs.com/package/hexo?activeTab=versions) 的 Hexo，以及 [推荐的 Node.js 版本](https://hexo.io/zh-cn/docs/#安装前提)。

| Hexo 版本   | 最低版本 (Node.js 版本) | 最高版本 (Node.js 版本) |
| :---------- | :---------------------- | :---------------------- |
| 6.2+        | 12.13.0                 | latest                  |
| 6.0+        | 12.13.0                 | 18.5.0                  |
| 5.0+        | 10.13.0                 | 12.0.0                  |
| 4.1 - 4.2   | 8.10                    | 10.0.0                  |
| 4.0         | 8.6                     | 8.10.0                  |
| 3.3 - 3.9   | 6.9                     | 8.0.0                   |
| 3.2 - 3.3   | 0.12                    | 未知                    |
| 3.0 - 3.1   | 0.10 或 iojs            | 未知                    |
| 0.0.1 - 2.8 | 0.10                    | 未知                    |

### Git的安装

```
yum install git-core
```

![image-20230822013716334](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308220137246.png)

安装完毕！！！

**开始搭建Git服务器：**

1. 添加一个git用户

```
# 添加git用户
$ adduser git 

# 改变sudoers文件的权限为文件所有者可写
$ chmod 740 /etc/sudoers
$ vim /etc/sudoers

# 添加一行内容,按esc,再按:wq退出编辑
将 git ALL=(ALL) ALL 添加到root ALL=(ALL) ALL下方

# 将sudoers文件的权限改回文件所有者可读
$ chmod 400 /etc/sudoers 

# 设置服务器的git密码，用于git连接。输入时看不到任何显示，输入完成回车即可
$ sudo passwd git 
```

2. 给服务器和主机的Git配置SSH密钥

* 如果你的本地电脑中已有ssh密钥则跳过这一步，直接到`C:\Users\你的用户名\.ssh`中找到`id_rsa.pub`通过宝塔面板或者FTP将`id_rsa.pub`上传到`/home/git/.ssh`。

> 注意，如果**你是云服务器的话**这里一定要将密钥上传到 `/home/git/.ssh` 这个路径，不然是不生效的，为什么不生效，这里就相当于什么呢？！就是相当于你把你服务器中的密钥添加到了 git 中，其中 git 的路径为/home/git ,所以肯定要添加到这个地方。
>
> 如果**你是在虚拟机中**，那么.ssh是有一个默认路径的，一般为：`/root/.ssh`,直接把生成的公钥放到这个位置或者通过 ssh 上传即可。
>
> 究其原因，你在你的Windows电脑上，需要将一个项目或者文件上传到GitHub（或者Gitee），然后通过仓库的https链接很多时候会报网络超时的错误，相信很多时候大家都会遇到，于是，我们发现GitHub官方还给出了仓库的ssh链接：`git@github.com:username/repositoryname`，就是这个样子，然后要是用这个的话，你就需要在本地生成一个密钥对，生成方法和下面的方法一样，然后就可以在电脑的`C:\Users\你的用户名\.ssh`这个路径下看到已经生成的id_rsa（私钥）、id_ras.pub（公钥）。然后你需要将生成的公钥添加到GitHub的设置中，如图：
>
> ![image-20230824204900135](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308242054482.png)
>
> 同理以上操作就相当于 Linux 系统的操作，只是系统不同罢了，知识点 + 1.

* 如果你本地电脑`C:\Users\你的用户名\.ssh`中没有生成过ssh密钥，可以按照如下步骤生成密钥：

  ```
  用户
  git config --global user.name "你要设置的git软件的用户名"
  git config --global user.email "你要设置的邮箱"
  
  ssh-keygen -t rsa -C "你刚刚设置的邮箱"
  ```

 **为什么要进行通过配置ssh密钥？**

这样主机和服务器的git连接时无需密码即可，更加方便。

3. 在服务器中新建仓库

   ```
   cd /home/git
   git init --bare hexoblog.git #在/home/git下初始化一个名为hexoblog的仓库
   ```

4. 配置钩子实现自动部署

    找到`/home/git/hexoblog.git/hooks`下的`post-receive`文件，如果没有则新建一个该文件，将其内容改为

   ```sh
   #!/bin/sh
   git --work-tree=/home/www/xxx --git-dir=/home/git/hexoblog.git checkout -f
   ```

   以上内容是一条命令，前者`/home/www/xxx`为网页资源目录，后者`/home/git/hexoblog.git`为云git仓库。意为当主机将静态文件推给服务器的git仓库后，自动触发hooks文件下的脚本，服务器能够自动将文件部署到网页资源目录，也就是什么呢，相当于Windows系统中 GitHub 网站的 Action，或者也就是`Git pages`部署，只不过在 Linux 系统中，操作麻烦一点。

5. **然后设置网页资源目录的IO权限，否则git没有权限修改网页资源目录的内容，无法实现自动部署！！！**

```shell
sudo chmod +x /home/git/hexoblog.git/hooks/pre-receive #赋予其可执行权限
sudo chown -R git:git /home/git/ #仓库目录的所有者改为git
sudo chown -R git:git /home/www/ #站点文件夹所有者改为git
```

## Hexo脚手架安装

### 直接全局安装：

```
$ npm install -g hexo-cli
```

安装很慢的话，可以先设置npm的淘宝镜像：

```
$ npm config set registry https://registry.npm.taobao.org
```

官网也给出了进阶局部安装方法，如下：

### 进阶安装和使用

> 对于熟悉 npm 的进阶用户，可以仅局部安装 `hexo` 包。
>
> ```
> $ npm install hexo
> ```
>
> 安装以后，可以使用以下两种方式执行 Hexo：
>
> 1. `npx hexo <command>`
>
> 2. Linux 用户可以将 Hexo 所在的目录下的 `node_modules` 添加到环境变量之中即可直接使用 `hexo <command>`：
>
>    ```
>    echo 'PATH="$PATH:./node_modules/.bin"' >> ~/.profile
>    ```

## 本地跑一个hexo博客Demo

直接参考[官方文档](https://hexo.io/zh-cn/),初始化一个博客，已经有hexo博客的话就直接跳过。

在你的博客目录下面的.config.yml中添加远程git仓库的地址，也就是上面我们在服务器中新建的仓库地址，如图：

![image-20230824210942989](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308242109919.png)

然后就可以愉快的`hexo deploy`了。

推荐一起使用：`hexo cl && hexo g && hexo d`

## 怎么访问部署到云服务器的博客呢？

`云服务器IP:`+ 端口号进行访问

### 在宝塔面板添加站点

 由于云服务器在域名没有备案的情况下不开放80端口，所以手动设置一个空闲的32端口用于访问网页。

![img](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308242124448.png)

 将网站目录设置为如下（自定义即可）

![img](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308242124720.png)

这里使用的是宝塔面板，也可以使用`nginx`进行配置,参考文章：https://blog.csdn.net/weixin_56301399/article/details/129270887

## 全网最全SEO强化篇之怎么让百度、谷歌、必应各大搜索引擎收录自己的文章

- 百度
  - 是需要域名备案的，前提是拥有一台云服务器，所以我先搁置，后续补充

- [谷歌：Google Search Console](https://search.google.com/search-console/welcome)

  - 如何进行验证？

  ![image-20230825013409616](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308250135183.png)
