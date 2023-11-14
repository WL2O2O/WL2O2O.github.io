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

