---
title: 速解小册 nodejs篇
tags:
  - nodejs
categories:
  - 速解小册
date: 2025-07-23 16:59:13
---

# 网址列表

[官网 node 版本一览](https://nodejs.org/en/download/releases)：https://nodejs.org/en/download/releases
[非官方构建版本](https://unofficial-builds.nodejs.org/download/release/v20.10.0/)：https://unofficial-builds.nodejs.org/download/release/v20.10.0/
# `NVM`常见问题

## 错误卸载nodejs，导致`nvm use`切换失败
**问题剖析：**

卸载的时候直接删除了nvm文件夹下正在使用的nodejs，导致nvm当前指向版本丢失

**解决方案：**

按照如下图所示的顺序正确卸载

![nvm use失败](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202408251824551.png)

## `Linux`使用`nvm install`自动切换的问题
**背景剖析：**
因为我们一般使用Linux系统习惯直接用管理员，所以在我们进行nvm install的时候，会直接切换到下载的版本。这时当我们进行多个项目且使用不同版本进行开发时，就很麻烦。而且很多开源项目在readme中并不会说明node版本，这就非常容易出现因node版本不匹配，导致依赖下载失败的问题。

**解决方案：**
（前提是Linux系统，windows系统不适用，已验证！）
1、首先下载NVM（Node Version Manager）；
2、在项目的根目录创建一个配置文件，命名为：`.nvmrc`；
3、写入node版本号。

```bash
# 1、定义一个默认版本16.18.1
nvm alias default 16.18.1
# 2、在我们的项目中创建一个配置文件，命名为：.nvmrc
touch .nvmrc
# 3、写入版本号
echo "16.18.1" > .nvmrc
# 4、手动 use 切换版本
nvm use
# 5、如果是使用 vscode 进行开发的话，可以安装一个`vsc-nvm`插件（也仅仅适用于Linux OS），当我们打开项目终端，会根据`.nvmrc`配置文件读取版本号，自动切换到对应的版本。
```

# NVM专业安装

## **`Windows platform`**

[nvm专业安装教程（选择配置切换node版本后全局安装失效问题）](https://juejin.cn/post/7369027991442030643)

```bash
# nvm 配置镜像源
node_mirror: http://npmmirror.com/mirrors/node/
npm_mirror: http://registry.npmmirror.com/mirrors/npm/
```

## **`Linux platform`**

[官方专业教程](https://github.com/nvm-sh/nvm/blob/master/README.md#installing-and-updating)

[网络问题解决，点击跳转](#浅析域名解析被污染问题，以及解决方案)

```bash
## 方式 1 --网络情况解决方案：宿主机下载然后上传 Linux or 配置DNS
# 1. 使用 curl 或者 weget 命令，获取 nvm 安装脚本并执行，执行过程中会自动向配置文件中添加环境变量

# 小写的字母o
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
# 大写的字母O  --如果wget不存在 执行yum -y install wget
wget -O- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# 2. 查看是否自动添加了环境变量（看自己的环境变量在哪个文件中，接下来就配置并激活哪个）
cat ~/.bashrc     # bash 
cat ~/.zshrc      # zsh 
cat ~/.profile    # ksh

# 3. 配置国内镜像源到配置文件
echo 'export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node/' >> ~/.bashrc
echo 'export NVM_IOJS_ORG_MIRROR=https://npmmirror.com/mirrors/npm/' >> ~/.bashrc

# 3. 激活环境变量
source ~/.bashrc  # bash 
source ~/.zshrc   # zsh 
. ~/.profile      # ksh

# 4. 查看 nvm 版本
nvm -v



## 方式2 --解压操作

# 1. 从 github 下载压缩包 
wget https://github.com/nvm-sh/nvm/archive/refs/tags/v0.38.0.tar.gz

# 2. 创建一个 .nvm 文件夹 并 解压压缩包到该文件夹（以下命令可拆分执行）
mkdir -p /root/.nvm && tar -zxvf v0.38.0.tar.gz -C /root/.nvm

# 3. 看自己的环境变量在哪个文件中，接下来就配置并激活哪个
bash: cat ~/.bashrc
zsh: cat ~/.zshrc
ksh: cat ~/.profile

# 4. 配置环境变量（复制以下全部命令直接粘贴到终端执行）
echo '
export NVM_DIR="$HOME/.nvm/nvm-0.38.0"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
' >> ~/.bashrc

# 5. 配置国内镜像源
echo 'export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node/' >> ~/.bashrc
echo 'export NVM_IOJS_ORG_MIRROR=https://npmmirror.com/mirrors/npm/' >> ~/.bashrc

# 6. 激活配置文件
source ~/.bash_profile
```

# `nodejs`常见问题

## PowerShell 无法加载`ps1`脚本
> PowerShell 的 ExecutionPolicy 是分层的，优先级从高到低依次为：
> 
> 
> MachinePolicy（组策略设置）
> UserPolicy（组策略设置）
> Process（当前进程范围）
> CurrentUser（当前用户范围）
> LocalMachine（本地计算机范围）
> 如果 MachinePolicy 或 UserPolicy 设置为更严格的策略（例如 Restricted），它们会覆盖 LocalMachine 的设置。你可以通过以下命令检查这些范围的设置：
> Get-ExecutionPolicy -List

```bash
## 更改脚本执行策略需要以管理员权限打开 PowerShell 窗口执行命令
# 查看策略
Get-ExecutionPilicy -List

# 默认设置，不允许任何脚本运行
Set-ExecutionPolicy Restricted
# 只能运行由可信发布者签名的脚本
Set-ExecutionPolicy AllSigned
# 运行本地未签名的脚本，以及由可信发布者签名的远程脚本
Set-ExecutionPolicy RemoteSigned
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## CentOS7不支持安装nodejs18以上版本

> **问题剖析：**
> 从nodejs18开始就不支持Centos7了，这是因为centos7的gilbc版本比较低
> **解决方案：**
> 1、升级 glibc 版本（不推荐，按照网上教程一般解决不了）
> 2、安装非官方构建的 nodejs 版本（推荐⭐⭐⭐）
> **注意：**
> 如果 npm 安装的包依赖于 glibc，那得改用 docker 或者升级系统

1. 非官方发布版本网站下载压缩包
[非官方构建版本](https://unofficial-builds.nodejs.org/download/release/v20.10.0/)：https://unofficial-builds.nodejs.org/download/release/v20.10.0/
**离线环境：**
使用 ftp 将文件上传到服务器

**在线环境：**
```bash
wget https://unofficial-builds.nodejs.org/download/release/v20.10.0/node-v20.10.0-linux-x64-glibc-217.tar.gz
```

2. 解压、配置环境变量
```bash
# 解压
tar -zxvf node-v20.10.0-linux-x64-glibc-217.tar.gz
# 简化文件夹名字
mv node-v20.10.0-linux-x64-glibc-217 node-v20.10.0
# 删除压缩包
rm node-v20.10.0-linux-x64-glibc-217.tar.gz
# 设置软路由
ln -s /root/node-v20.10.0/bin/node /usr/local/bin/node
ln -s /root/node-v20.10.0/bin/npm /usr/local/bin/npm

# 查看自己的环境变量在哪个文件中，接下来就配置并激活哪个
cat ~/.bashrc     # bash 
cat ~/.zshrc      # zsh 
cat ~/.profile    # ksh

# 配置环境变量
echo 'export NODE_HOME=/your_path/node-v20.10.0' >> ~/.bashrc
echo 'export PATH=$PATH:$NODE_HOME/bin' >> ~/.bashrc

# 激活环境变量
source ~/.bashrc  # bash 
source ~/.zshrc   # zsh 
source ~/.profile      # ksh

# 查看 nodejs 版本
node -v

# 配置 npm 镜像源
npm config set registry=https://registry.npmmirror.com
```

## Linux 卸载全局安装的nodejs
```bash
# 1. 查找node安装目录
which node
# 2. 删除相关目录
sudo rm /usr/local/bin/npm
sudo rm /usr/local/share/man/man1/node.1
sudo rm /usr/local/lib/dtrace/node.d
sudo rm -rf ~/.npm
sudo rm -rf ~/.node-gyp
sudo rm /opt/local/bin/node
sudo rm /opt/local/include/node
sudo rm -rf /opt/local/lib/node_modules
# 3. 检查node命令是否还存在
node -v
```
[参考链接](https://www.runoob.com/w3cnote/nvm-manager-node-versions.html)


## npm安装之后不出现版本号
1. 确认全局安装路径：
首先确认全局模块的安装位置，你可以通过运行以下命令来查看：
``` bash
# 返回**全局模块**的安装目录
npm config get prefix

# 如果不是nvm，通常会得到C:\Users\xxxxx\AppData\Roaming\npm
```

2. 检查环境变量：
确认你的系统环境变量中的 Path 变量包含了上述全局模块的安装目录。你可以通过以下步骤检查：
打开“控制面板” > “系统与安全” > “系统” > “高级系统设置” > “环境变量”。
在“系统变量”区域找到 Path 变量并点击“编辑”按钮。
确保列表中包含全局模块的安装目录（例如 C:\Users\xxxxx\AppData\Roaming\npm）。
3. 重启命令提示符重新验证

## npm安装cnpm出现operation not permitted问题
***接单经验：加上版本号。***
例如：
npm install -g cnpm@latest  或者  npm install -g cnpm@7.1.0

1. 全局模块安装路径的问题：
确保全局模块的安装路径不在受保护的位置，如 C:\Program Files 或 C:\Windows。
你可以通过运行 npm config get prefix 查看全局模块的安装位置。

2. 环境变量中的路径问题：
检查环境变量中的 Path 是否指向了一个受限的目录。
确认 Path 中的条目是否正确。

3. 防病毒软件或防火墙的干扰：
有些防病毒软件或防火墙可能会阻止某些操作。
尝试暂时禁用防病毒软件或防火墙，然后再次尝试安装。

4. 使用 --unsafe-perm 标志：
有时，添加 --unsafe-perm 标志可以绕过权限问题。但是请注意，这会降低安全性。
尝试使用 npm install -g --unsafe-perm cnpm 安装。

5. 使用 sudo 命令：
对于 Linux 或 macOS 用户，可以使用 sudo 命令提升权限。但在 Windows 上，这并不适用。

6. 更改全局安装路径：
你可以将全局模块的安装路径更改为一个非受限的目录，比如 C:\Users\xxxxx\AppData\Roaming\npm。

7. 使用以下命令更改全局安装路径：
```bash
npm config set prefix "C:\Users\xxxxx\AppData\Roaming\npm"
```

## npm安装node-sass问题

[node-sass安装报错参考链接](https://www.kancloud.cn/han88829/book/1048622)

```bash
# 删除 package-lock.json
rm -rf package-lock.json

# 删除已经下载的 node_modules
rm -rf node_modules

# 配置国内 npm 镜像源 或者只配置 sass 镜像源
npm config set registry https://registry.npmmirror.com   （推荐）
or
npm config set sass-binary-site https://registry.npmmirror.com/mirrors/node-sass
or
npm set sass_binary_site https://registry.npmmirror.com/mirrors/node-sass

# 清除 npm 缓存
npm cache clean --force

# 下载依赖
npm install --unsafe-perm --force

# 如果有梯子，可以设置代理
npm config set proxy http://127.0.0.1:1080
npm i node-sass

# 下载完成后删除 http 代理
npm config delete proxy

# 如果没有梯子
# github 下载地址：https://github.com/sass/node-sass/releases
example：
$ npm install --save-dev node-sass
> node-sass@5.0.0 install D:\WorkSpace\node-sass-test\node_modules\gulp-sass\node_modules\node-sass
> node scripts/install.js

Downloading binary from http://registry.npmmirror.com/mirrors/node-sass/v5.0.0/win32-x64-72_binding.node
---
npm i -D node-sass@5.0.0 --sass_binary_path=D:\files\win32-x64-72_binding.node


node -p "[process.platform, process.arch, process.versions.modules].join('-')"

https://github.com/sass/node-sass/releases ctrl+f sousuo
```


## 单独的前端静态文件怎么启动
```bash
npm config set registry https://registry.npmmirror.com
npm i -g http-server

http-server  -c-1
```


# 浅析域名解析被污染问题，以及解决方案

## 解决方案

### 方案一、修改DNS

1. [**查询 IP 地址**](https://www.ipaddress.com/reverse-ip-lookup)
2. **修改 `/etc/hosts` 文件**：将查询到的 IP 地址添加到 `/etc/hosts` 文件中

```bash
tee -a /etc/hosts << EOF
185.199.109.133 raw.githubusercontent.com
EOF
```

### 方案二、使用代理

[参考链接](https://zhuanlan.zhihu.com/p/702343946)

## 浅析

域名解析被污染（DNS poisoning 或 DNS cache poisoning）是指 DNS（Domain Name System，域名系统）服务器的缓存中存储了错误的或恶意的 DNS 记录。这种现象会导致用户在访问合法网站时被重定向到恶意网站或其他错误的地址。下面是一些常见的域名解析被污染的原因：

1. 黑客攻击

黑客可能会利用 DNS 服务器的漏洞或通过中间人攻击（Man-in-the-Middle Attack, MITM）来篡改 DNS 记录。这种攻击的目标是将合法网站的 IP 地址替换为恶意网站的 IP 地址，从而让用户误以为他们正在访问合法网站。

2. ISP（Internet Service Provider）干预

有时，ISP 可能会故意或意外地修改 DNS 记录。例如，当用户试图访问不存在的网站时，ISP 可能会返回一个广告页面，而不是正常的 “Not Found” 错误页面。这种做法被称为 DNS hijacking。

3. 配置错误

DNS 服务器的配置错误也可能导致域名解析被污染。例如，如果 DNS 服务器被配置为使用错误的权威 DNS 服务器，或者配置了错误的 DNS 记录，这都会导致解析结果出错。

4. 恶意软件

恶意软件或病毒可能感染用户的计算机或网络设备，并修改 DNS 设置，导致用户访问恶意网站。

5. DNS 服务器故障

DNS 服务器本身可能出现故障，导致无法正确解析域名。虽然这不是典型的域名解析被污染，但它可能导致类似的效果，比如用户无法访问特定的网站。

6. 政府或监管机构干预

在某些国家和地区，政府或监管机构可能会干预 DNS 解析，以阻止用户访问某些网站或内容。这通常通过修改 DNS 记录来实现，从而达到审查的目的。

解决方法

- **使用安全的 DNS 服务器**：使用信誉良好的公共 DNS 服务器，如 Google Public DNS（8.8.8.8 和 8.8.4.4）或 Cloudflare DNS（1.1.1.1）。
- **定期更新 DNS 服务器软件**：确保 DNS 服务器的软件是最新的，并修复了已知的安全漏洞。
- **使用加密的 DNS 协议**：使用 DNS over HTTPS (DoH) 或 DNS over TLS (DoT) 等加密协议，以防止中间人攻击。
- **手动修改 `/etc/hosts` 文件**：如果某个域名解析出现问题，可以手动在 `/etc/hosts` 文件中添加正确的 IP 地址，绕过 DNS 解析。
- **刷新 DNS 缓存**：定期刷新 DNS 缓存，以确保使用的 DNS 记录是最新的。

## 总结

域名解析被污染是一种严重的安全威胁，可能导致用户访问恶意网站或无法访问合法网站。通过采取适当的预防措施和使用安全的 DNS 解决方案，可以减少被污染的风险。



# 浅析curl和wget的参数

当我们使用 `curl -o - http://example.com/file.txt | bash` 命令时，这里发生了两件事：

1. `curl -o - http://example.com/file.txt`: 这个部分使用 `curl` 命令从 `http://example.com/file.txt` 下载文件的内容，并将其输出到标准输出（stdout），即终端。
2. `| bash`: 这个部分将 `curl` 命令的输出作为输入传递给 `bash`，使得 `bash` 将接收到的数据当作一个脚本来执行。

### 详细解释
- `-o -`: 这里的 `-o -` 指定 `curl` 应该将输出发送到标准输出（stdout），而不是一个文件。这里的 `-` 代表标准输出。
- `|`: 这个符号表示管道（pipe），它将一个命令的输出作为另一个命令的输入。
- `bash`: 这个命令将从管道接收数据，并将其当作脚本来执行。

### 总结
`curl -o - http://example.com/file.txt | bash` 命令的意思是：
- 使用 `curl` 从 `http://example.com/file.txt` 下载文件的内容。
- 将下载的内容直接输出到标准输出。
- 通过管道 (`|`) 将输出传递给 `bash`。
- `bash` 将接收到的数据当作脚本执行。

### 示例
假设 `http://example.com/file.txt` 包含了一个简单的脚本，例如：
```bash
#!/bin/bash
echo "Hello, World!"
```

当你运行 `curl -o - http://example.com/file.txt | bash` 时，`curl` 会下载这个文件的内容，并将其传递给 `bash`，`bash` 会执行这个脚本，最终输出 "Hello, World!"。

### 注意事项
- 确保从可信的来源下载脚本，因为这涉及执行未知代码的安全性问题。
- 如果脚本需要执行权限，你可能需要在执行前加上 `chmod +x` 来赋予脚本执行权限。
- 使用管道将脚本直接传递给 `bash` 执行时，确保你知道脚本的内容和来源，以免引入安全风险。

### 结论
`curl -o - http://example.com/file.txt | bash` 命令是正确的，`-` 在这里不是重复的，而是表示标准输出。这个命令用于下载一个文件并立即执行其内容。