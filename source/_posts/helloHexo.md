---
title: Hexo 建站笔记
index_img: https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202309120902040.png
categories:
  - Blog
tags:
  - 网站搭建
abbrlink: 44559
date: 2021-09-07 14:07:56
---
Welcome to [Hexo](https://hexo.io/)! This is your very first post. Check [documentation](https://hexo.io/docs/) for more info. If you get any problems when using Hexo, you can find the answer in [troubleshooting](https://hexo.io/docs/troubleshooting.html) or you can ask me on [GitHub](https://github.com/hexojs/hexo/issues).

> `Hexo`这小子太不厚道了，拉拢`npm`好兄弟一起给我整活，不是包死活下载不了，就是各种奇怪的报错，也或者是本地环境没有问题，结果`GitHub`远仓工作流文件出了问题，我与`Hexo`不共... 啊不对，我与`Hexo`和睦相处！
>
> 
>
> 参考文章：
>
> ```text
> hexo访问速度优化：（三种插件的对比）
> https://blog.csdn.net/qq_29654777/article/details/108222881
> ```
>
> 



## Quick Start

### Create a new post

``` bash
$ hexo new "My New Post"
```

More info: [Writing](https://hexo.io/docs/writing.html)

### Run server

``` bash
$ hexo server
```

More info: [Server](https://hexo.io/docs/server.html)

### Generate static files

``` bash
$ hexo generate
```

More info: [Generating](https://hexo.io/docs/generating.html)

### Deploy to remote sites

``` bash
$ hexo deploy
```

More info: [Deployment](https://hexo.io/docs/one-command-deployment.html)

### merge commend

```bash
$ hexo cl && hexo g && hexo s
$ hexo d
```

### 文件压缩

> 如果安装的时候出现各种报错都没有在`GitHub`提到的`issues`中找到，仔细看报错内容提示，该重启的时候就重启，该上梯子就上梯子（不行就全局模式），卸载依赖：`npm uninstall hexo-all-minifier`；安装依赖：`npm install hexo-all-minifier --save`，这两个命令反复多来几次，就会忽然发现，安装成功了！！！！最后吐槽一句，被墙真不友好！！！

```shell
#---------------------------
# 压缩插件
# 安装插件：npm install hexo-all-minifier --save
# 源码地址：https://github.com/chenzhutian/hexo-all-minifier
#---------------------------

#把以下配置文件添加到 _config.fluid.yml中

#启用all_minifier
all_minifier: true
# html压缩
html_minifier:
  enable: true
  ignore_error: false
  exclude:

# css压缩
css_minifier:
  enable: true
  exclude:
    - '*.min.css'
    
# js压缩
js_minifier:
  enable: true
  mangle: true
  compress:
  exclude:
    - '*.min.js'
js_concator:
  enable: false
  bundle_path: '/js/bundle.js'
  front: false
  silent: false

# 图片优化
image_minifier:
  enable: true
  interlaced: false
  multipass: false
  optimizationLevel: 2
  pngquant: false
  progressive: false
```

**再记录、复盘一下这个插件的问题！！！**

> 事情缘由：想给文章增加一个在线编辑的`Button`，被工作流文件和这个插件折腾了一天多。
>
> 问题所在：本地环境与GitHub环境有所不同，相同的依赖上传到GitHub，在hexo generate构建的时候，也就是npm run build的时候，工作流文件会报错。报错如下：
>
> ```bash
> FATAL {
>   err: Error: spawn /home/runner/work/WL2O2O.github.io/WL2O2O.github.io/node_modules/imagemin-gifsicle/node_modules/gifsicle/vendor/gifsicle ENOENT
>       at ChildProcess._handle.onexit (node:internal/child_process:284:19)
>       at onErrorNT (node:internal/child_process:477:16)
>       at process.processTicksAndRejections (node:internal/process/task_queues:82:21) {
>     errno: -2,
>     code: 'ENOENT',
>     syscall: 'spawn /home/runner/work/WL2O2O.github.io/WL2O2O.github.io/node_modules/imagemin-gifsicle/node_modules/gifsicle/vendor/gifsicle',
>     path: '/home/runner/work/WL2O2O.github.io/WL2O2O.github.io/node_modules/imagemin-gifsicle/node_modules/gifsicle/vendor/gifsicle',
>     spawnargs: [ '--no-warnings', '--no-app-extensions' ],
>     stdout: <Buffer >,
>     stderr: <Buffer >,
>     failed: true,
>     signal: null,
>     cmd: '/home/runner/work/WL2O2O.github.io/WL2O2O.github.io/node_modules/imagemin-gifsicle/node_modules/gifsicle/vendor/gifsicle --no-warnings --no-app-extensions',
>     timedOut: false,
>     killed: false
>   }
> } Something's wrong. Maybe you can find the solution here: %s https://hexo.io/docs/troubleshooting.html
> Error: Process completed with exit code 2.
> ```
>
> 解决方案：
>
> 因为本地是完全没有问题的，而且我的依赖是本地直传GitHub远仓，于是，直接在.gitignore文件中忽略了这个插件涉及到的子插件问题。
>
> ```.gitignore
> node_modules/imagemin-gifsicle/*
> ```
>
> 暂时解决，后续有问题继续更改。
>
> 不足之处：
>
> 工作流文件中缺少在线构建的语句，因为想要与本地保持一致，暂时选择了直接上传，后续若有问题，再继续改进。工作流文件如下：
>
> ```yml
> # name: Deploy # 工作流名称
> # on:
> #   push: # push 事件触发工作流
> #     branches:
> #       - hexoBlog # 只有在 hexoBlog 分支推送时触发工作流
> # jobs:
> #   build: # job1 id
> #     runs-on: ubuntu-latest # 运行环境为最新版 Ubuntu
> #     name: Deploy blog
> #     steps:
> #       - name: Checkout # 步骤1：获取源码
> #         uses: actions/checkout@v2 # 使用 actions/checkout@v2
> 
> #       - name: Cache node modules # 步骤2：缓存 node_modules
> #         uses: actions/cache@v2
> #         with:
> #           path: node_modules
> #           key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
> name: Build and Deploy
> on: [push]
> permissions: # 增加写入仓库分支的写权限，否则在最后一步部署时会出错，提示
>   contents: write
> jobs:
>   build-and-deploy:
>     concurrency: ci-${{ github.ref }} # Recommended if you intend to make multiple deployments in quick succession.
>     runs-on: ubuntu-latest
>     steps:
>       - name: Checkout 🛎️
>         uses: actions/checkout@v3
>         
>       - name: Install Hexo CLI  
>         run: npm install -g hexo-cli@4.3.0
>         env:  
>           CI: false
> 
>       - name: Install Dependencies # 步骤3：安装依赖
>         if: steps.cache.outputs.cache-hit != 'true'
>         run: npm run build
>         env:
>           CI: false
>           
>       - name: Deploy 🚀 # 步骤4：部署
>         # uses: JamesIves/github-pages-deploy-action@releases/v3
>         uses: JamesIves/github-pages-deploy-action@v4
>         with:
>           GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
>           BRANCH: master # 部署到 gh-pages 分支
>           FOLDER: public # 部署 public 文件夹
> ```
>
> [补充部署GitHub pages的一个repository](https://github.com/marketplace/actions/deploy-to-github-pages)
>
> 介绍:
>
> Automatically deploy your project to [GitHub Pages](https://pages.github.com/) with [GitHub Actions](https://github.com/features/actions). This action can be configured to push your production-ready code into any branch you'd like, including **gh-pages** and **docs**. It can also handle cross repository deployments and works with [GitHub Enterprise](https://github.com/enterprise) too.
>
> 官方提供的Action文件：
>
> ```yml
> name: Build and Deploy
> on: [push]
> permissions:
>   contents: write
> jobs:
>   build-and-deploy:
>     concurrency: ci-${{ github.ref }} # Recommended if you intend to make multiple deployments in quick succession.
>     runs-on: ubuntu-latest
>     steps:
>       - name: Checkout 🛎️
>         uses: actions/checkout@v3
> 
>       - name: Install and Build 🔧 # This example project is built using npm and outputs the result to the 'build' folder. Replace with the commands required to build your project, or remove this step entirely if your site is pre-built.
>         run: |
>           npm ci
>           npm run build
> 
>       - name: Deploy 🚀
>         uses: JamesIves/github-pages-deploy-action@v4
>         with:
>           folder: build # The folder the action should deploy.
> ```
>
> 

### 文章置顶

```shell
#---------------------------
# 文章置顶
# 安装时间：2023年10月24日
# 安装插件：npm install hexo-generator-index --save
# 源码地址：https://github.com/hexojs/hexo-generator-index.git
#---------------------------
# 使用方法
sticky: 100（数值越大，优先级越高）
```



### 生成sitemap.xml

```shell
#---------------------------
# 站点地图（sitemap.xml）
# 安装插件：
#   -Google：npm install hexo-generator-sitemap --save
#   -Baidu：npm install hexo-generator-baidu-sitemap --save
#---------------------------

# sitemap
sitemap:
  path: sitemap.xml
baidusitemap:
  path: baidusitemap.xml
```



### 文章链接持久化

```shell
#---------------------------
# 解决文章链接会随标题变动而变动，链接永久化插件
# 安装地址：https://github.com/Rozbo/hexo-abbrlink
# 安装插件：npm install hexo-abbrlink --save
#---------------------------
permalink: posts/:abbrlink.html
# abbrlink config
abbrlink:
  alg: crc32      #support crc16(default) and crc32
  rep: hex        #support dec(default) and hex
  drafts: false   #(true)Process draft,(false)Do not process draft. false(default) 
  # Generate categories from directory-tree
  # depth: the max_depth of directory-tree you want to generate, should > 0
  auto_category:
     enable: true  #true(default)
     depth:        #3(default)
     over_write: false 
  auto_title: false #enable auto title, it can auto fill the title by path
  auto_date: false #enable auto date, it can auto fill the date by time today
  force: false #enable force mode,in this mode, the plugin will ignore the cache, and calc the abbrlink for every post even it already had abbrlink. This only updates abbrlink rather than other front variables.
```

