---
title: plan-a
tags: plan
abbrlink: 3d6e4b43
date: 2023-08-24 19:55:57
---

# 我的计划

![image-20230824195744464](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308241957304.png)

## 云上博客问题

博客域名一直配置不成功原因：

服务器：华为云

域名：腾讯云

猜想：因为域名解析的问题，所以暂时放弃域名的绑定，等入手新的华为云服务器与域名了再说

果真，来看ChatGPT的回答：

![image-20230824200659385](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308242007222.png)

我去了，你猜怎么着，鹅厂的域名解析的记录值当选择创建A记录时，记录值只能选择本平台购买的云资源，如图：

![image-20230824200857847](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308242008956.png)

不知其他平台也是如此，于是我们可以选择以下方案：

![image-20230824201042315](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308242010823.png)

于是，本人骂骂咧咧的关掉了页面，玩什么花活，老老实实的用IP访问吧！

### 备选方案

测试！！！

**腾讯云服务器**部署**阿里云购买的域名**时，提示需要在阿里云域名解析中添加有关腾讯云的信息：

<img src="https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308232016802.png" alt="image-20230823201603447" style="zoom:50%;" />

<img src="https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308232016852.png" alt="image-20230823201612501" style="zoom:50%;" />

有待验证... ...

## 项目上线问题

发现使用`docker`来进行上线项目极为便捷，上线步骤，为项目编写`Dockerfile`和`nginx`配置文件，然后构建镜像、创建容器，直接运行！

具体上线方案，参考下面这篇文章！

[如何上线自己的项目？必须要氪金买云服务器吗？（保姆级教程！）](https://wl2o2o.github.io/2023/06/03/api/#%E4%B8%89%E3%80%81docker%E9%83%A8%E7%BD%B2)
