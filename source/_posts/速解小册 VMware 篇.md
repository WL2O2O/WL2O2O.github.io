---
title: 速解小册 VMware篇
tags:
  - VMware
categories:
  - 速解小册
date: 2025-05-18 13:33:31
---

# 虚拟机安装

```plain
### 软件秘钥

4A4RR-813DK-M81A9-4U35H-06KND
NZ4RR-FTK5H-H81C1-Q30QH-1V2LA
JU090-6039P-08409-8J0QH-2YR7F
4Y09U-AJK97-089Z0-A3054-83KLA
4C21U-2KK9Q-M8130-4V2QH-CF810
MC60H-DWHD5-H80U9-6V85M-8280D
```

## CentOS7安装

[https://blog.51cto.com/zicl/10459890?articleABtest=0](https://blog.51cto.com/zicl/10459890?articleABtest=0)

## 配置静态IP+虚拟机端口转发宿主机端口

[静态IP配置参考链接](https://blog.csdn.net/H_Rhui/article/details/94439960)  
[网络问题排查参考链接](https://blog.csdn.net/love6a6/article/details/139986665)

### 注意

需要注意先查看宿主机的虚拟机IP网络的网段，虚拟机的静态IP设置要与宿主机保持一致。  
![](https://cdn.nlark.com/yuque/0/2025/png/35457700/1747545914956-3c05110b-c2d9-44b2-a92e-cd7e6a962d73.png)

记住当前VMnet8网卡的网段，如图所示，网段为:192.168.8

### 配置文件地址

```bash
# 编辑网卡配置文件
vi /etc/sysconfig/network-scripts/ifcfg-ens33
# 改为静态IP 
将BOOTPROTO字段修改为static(静态模式)
# 开机自启
ONBOOT字段为no，需要将其改为yes，该字段表示该网卡是否开机自启
# 保存文件后重启网络
service network restart
```
## 配置代理
export https_proxy=http://192.168.8.1:7890
export http_proxy=http://192.168.8.1:7890
export all_proxy=socks5://192.168.8.1:7890


~/.docker/config.json

{
 "proxies":
 {
   "default":
   {
     "httpProxy": "http://192.168.8.1:7890",
     "httpsProxy": "http://192.168.8.1:7890",
     "noProxy": "*.baidu.com,192.168.8.0/16,10.0.0.0/8"
   }
 }
}

localhost, 127.0.0.0/8, ::1


/etc/systemd/system/docker.service.d/http-proxy.conf

[Service]
Environment="HTTP_PROXY=http://192.168.8.1:7890/"
Environment="HTTPS_PROXY=http://192.168.8.1:7890/"

