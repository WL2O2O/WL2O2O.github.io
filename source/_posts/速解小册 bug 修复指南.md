---
title: 速解小册 bug 修复指南
tags:
  - Bugs
categories:
  - 速解小册
date: 2025-09-12 16:02:12
---

# 技术问题分类整理

## 一、前端相关问题
### 问题1: PostCSS处理SCSS文件异常
**报错信息**：
```bash
Syntax Error: Error: PostCSS received undefined instead of CSS string
ERROR  Failed to compile with 1 error
error  in ./src/assets/css/style.scss
```
**解释**: PostCSS处理SCSS文件时接收到未定义的CSS字符串，通常由于Node版本与项目依赖不兼容导致。  
**解决方案**:  
1. 切换Node版本至项目兼容版本  
2. 删除`node_modules`和`package-lock.json`，重新安装依赖  
3. 若控制台提示，执行`npm rebuild node-sass`  
4. 安装兼容版本的依赖：  
```bash
npm install element-ui@2.15.13 sass-loader@10.1.1 node-sass@4.14.1 --save
```

**补充说明**：  
- 方案4适用于因特定依赖版本冲突导致的问题（如`sass-loader`与`node-sass`版本不匹配）。  
- 若方案1-3无法解决，可尝试方案4锁定依赖版本。

### 问题2: Node Sass模块缺失
**报错信息**：
```bash
Module build failed: Error: Cannot find module 'node-sass'
```
**解释**: 项目缺少Node Sass依赖，或版本与Node.js不兼容。  
**解决方案**: 执行`npm install node-sass --save-dev`安装依赖，确保Node版本符合要求。  


### 问题3: Vite启动时报crypto.getRandomValues函数不存在
**报错信息**：
```bash
error when starting dev server:
TypeError: crypto$2.getRandomValues is not a function
```
**解释**：  
Vite 3.0+ 要求 Node.js 版本 ≥14.18，低版本 Node.js 未完全实现 `crypto.getRandomValues` API。  
**解决方案**：  
1. 升级 Node.js 至 14.18+ 或 16+ 版本  
2. 若需使用低版本 Node.js，可降级 Vite 至 2.x 系列  


### 问题4: Axios请求404错误（前端运行时）
**报错信息**：
```javascript
Uncaught runtime errors: ERROR Request failed with status code 404
AxiosError: Request failed with status code 404
```
**解释**：  
前端请求的接口路径不存在或后端服务未启动。  
**解决方案**：  
1. 首先检查后端服务是否正常运行  
2. 若不是后端未启动的问题，在 Vite/ webpack 配置中添加 devServer 代理（示例）：  
```javascript
  devServer: {
    client: {
      //当出现编译错误或警告时，在浏览器中是否显示全屏覆盖。  示例为只显示错误信息
      overlay: {
        runtimeErrors: false,
      },
    },
  },
```


## 二、MySQL相关问题
### 问题1: JDBC连接失败
**报错信息**：
```java
Error querying database.  Cause: org.springframework.jdbc.CannotGetJdbcConnectionException: Could not get JDBC Connection
```
**解释**: 无法获取JDBC连接，通常由数据库连接URL配置错误导致。  
**解决方案**: 检查`jdbc:mysql://`后的URL地址、端口、数据库名是否正确。  

### 问题2: 客户端认证协议不支持
**报错信息**：
```java
com.mysql.jdbc.exceptions.jdbc4.MySQLNonTransientConnectionException: Client does not support authentication protocol requested by server
```
**解释**: MySQL服务端使用的认证协议不被客户端支持（如新版MySQL使用caching_sha2_password）。  
**解决方案**: 登录MySQL执行`ALTER USER '用户'@'%' IDENTIFIED WITH mysql_native_password BY '密码';`，将认证方式改为`mysql_native_password`。  

### 问题3: 公钥检索不允许
**报错信息**：
```java
java.sql.SQLNonTransientConnectionException: Public Key Retrieval is not allowed
```
**解释**: 与SSL配置或URL参数缺失有关，MySQL 8.0默认采用caching_sha2_password认证，需配置公钥检索相关参数。  
**解决方案**: 
1. 在JDBC URL中添加`allowPublicKeyRetrieval=true`参数  
2. 在JDBC URL中添加`useSSL=false`参数  
3. 将用户认证方式改为`mysql_native_password`  

### 问题4: 时区值不被识别
**报错信息**：
```java
The server time zone value 'xxx' is unrecognized...
```
**解释**: JDBC驱动无法识别数据库服务器的时区值。  
**解决方案**: 在JDBC URL中添加时区参数（如`&serverTimezone=GMT%2B8`或`&serverTimezone=Asia/Shanghai`）。  

### 问题5: 系统变量已弃用
**报错信息**：
```java
java.sql.SQLException: Unknown system variable 'query_cache_size'
```
**解释**: `query_cache_size`参数在新版本MySQL中已被弃用，旧版本驱动或配置未适配。  
**解决方案**: 更新MySQL驱动版本至8.x+，或移除相关无效配置。  

### 问题6: 安全更新模式限制
**报错信息**：
```sql
14:53:51 UPDATE `user` SET password = 'asd123' Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
```
**解释**: MySQL安全更新模式要求`UPDATE`或`DELETE`操作必须包含基于主键或索引列的`WHERE`条件。  
**解决方案**: 执行`SET SQL_SAFE_UPDATES = 0;`临时禁用安全更新模式，或添加符合要求的`WHERE`条件。  

### 问题7: SSL连接错误（MySQL终端）
**报错信息**：
```sql
ERROR 2026 (HY000): SSL connection error: unknown error number
```
**解释**: MySQL连接时SSL验证失败，或公钥检索功能被禁用，常见于MySQL 8.0连接MySQL 5.7的场景。  
**解决方案**:  
1. 使用`mysql -h127.0.0.1 -P3306 -uroot -p --ssl-mode=DISABLED`禁用SSL验证  
2. 确保MySQL服务端与客户端SSL配置一致  


## 三、后端知识相关问题
### 问题1: Redis认证失败
**报错信息**：
```java
ERR Client sent AUTH, but no password is set.
```
**解释**: Redis客户端发送认证请求，但服务端未配置密码或密码不匹配。  
**解决方案**: 检查Redis配置文件（`redis.conf`）中的`requirepass`参数，确保与代码中配置的密码一致。  

### 问题2: 结果集滚动操作不支持
**报错信息**：
```java
java.sql.SQLException: Operation not allowed for a result set of type ResultSet.TYPE_FORWARD_ONLY
```
**解释**: 使用仅向前的结果集（TYPE_FORWARD_ONLY）执行滚动操作（如`previous()`）。  
**解决方案**: 创建`PreparedStatement`时指定可滚动结果集类型：  
```java
PreparedStatement pre = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
```

### 问题3: 字符集索引未知
**报错信息**：
```java
java.sql.SQLException: Unknown initial character set index '255' received from server
```
**解释**: 数据库返回的字符集索引未被驱动识别，通常因字符集配置不一致导致。  
**解决方案**: 在JDBC URL中显式指定字符集（如`&characterEncoding=utf8`）。  

### 问题4: JSTL标签库无法解析
**报错信息**：
```java
The absolute uri: http://java.sun.com/jstl/core_rt cannot be resolved...
```
**解释**: 项目缺少JSTL标准标签库依赖，或版本不兼容。  
**解决方案**: Maven中引入`jstl`和`standard`库，确保`web.xml`和标签库路径正确。  

### 问题5: 内部Java编译器错误
**报错信息**：
```java
java: 编译失败: 内部 java 编译器错误
```
**解释**: IDE（如IDEA）的Java编译器与项目JDK版本不兼容或配置异常。  
**解决方案**:  
1. 检查项目JDK版本与IDE配置是否一致  
2. 添加编译参数`-Djps.track.ap.dependencies=false`（IDEA需在Compiler设置中配置）  

### 问题6: InnoDB升级不支持快速关闭模式
**报错信息**：
```sql
[ERROR] [MY-012526] [InnoDB] Upgrade is not supported after a crash or shutdown with innodb_fast_shutdown = 2
```
**解释**: MySQL升级时，InnoDB存储引擎因快速关闭（`innodb_fast_shutdown=2`）导致日志残留，无法直接升级。  
**解决方案**:  
1. 备份数据后，删除InnoDB日志文件（`ib_logfile*`）  
2. 重新初始化数据库或使用兼容模式升级  

### 问题7: 类强制转换异常（BigInteger转Long）
**报错信息**：
```java
java.lang.ClassCastException: java.math.BigInteger cannot be cast to java.lang.Long
```
**解释**: 从数据库查询数值类型时，结果类型（如BigInteger）与代码中期望的Long类型不匹配。  
**解决方案**:使用`Long.valueOf(bigInteger.toString())`显式转换，或调整SQL查询结果类型。  

### 问题8: 驱动无法加载本地库（libaio.so.1缺失）
**报错信息**：
```bash
error while loading shared libraries: libaio.so.1: cannot open shared object file
```
**解释**: Linux系统缺少`libaio`库，导致MySQL服务或客户端无法启动。  
**解决方案**: 安装`libaio`依赖（如`yum install libaio`或`apt-get install libaio1`）。  

### 问题9: 时间戳格式不正确
**报错信息**：
```java
java.lang.IllegalArgumentException: Timestamp format must be yyyy-mm-dd hh:mm:ss[.fffffffff]
```
**解释**: 使用`java.sql.Timestamp.valueOf()`时传入的字符串格式不符合要求。  
**解决方案**: 确保时间字符串格式为`yyyy-MM-dd HH:mm:ss`（注意大小写和分隔符）。  

### 问题10: 无效的标记（--enable-preview）
**报错信息**：
```bash
java: 无效的标记: --enable-preview
```
**解释**: 使用Java预览功能（如Lambda表达式预览版）时，编译参数未正确配置。  
**解决方案**:  
1. 确认JDK版本支持预览功能（如JDK 12+）  
2. 添加编译参数`--enable-preview --release 版本`（如`--release 17`）  

### 问题11: Netty DNS解析器缺失（MacOS）
**报错信息**：
```java
Unable to load io.netty.resolver.dns.macos.MacOSDnsServerAddressStreamProvider
```
**解释**: Netty在MacOS上缺少本地DNS解析器依赖，可能导致DNS解析异常。  
**解决方案**: 添加Netty原生依赖（如`io.netty:netty-resolver-dns-native-macos`）。  


## 四、项目运行相关问题
### 问题1: Spring WebApplicationContext未注册
**报错信息**：
```java
java.lang.IllegalStateException: No WebApplicationContext found: no ContextLoaderListener registered?
```
**解释**: 程序运行时无法找到`WebApplicationContext`，因为未注册`ContextLoaderListener`。  
**解决方案**: 在`web.xml`文件中添加以下配置：
```xml
<listener>
    <listener-class>
            org.springframework.web.context.ContextLoaderListener
    </listener-class>
</listener>
```

### 问题2: 类文件版本不兼容（MyBatis-Spring）
**报错信息**：
```
无法访问org.mybatis.spring.annotation.MapperScan 错误的类文件: /D:/JAVA/developer_tools/Maven/maven-repo/org/mybatis/mybatis-spring/3.0.2/mybatis-spring-3.0.2.jar!/org/mybatis/spring/annotation/MapperScan.class 类文件具有错误的版本 61.0, 应为 52.0
```
**解释**: `mybatis-spring`依赖版本（3.0.2）的类文件版本（61.0）与运行环境要求版本（52.0）不兼容。  
**解决方案**: 将`mybatis-spring`依赖版本从3.x降低至2.x。  

### 问题3: 主类无法加载
**报错信息**：
```java
Error: Could not find or load main class com.example.Application
Caused by: java.lang.ClassNotFoundException: com.example.Application
```
**解释**: 程序无法找到或加载主类 `com.example.Application`，可能由于类路径配置错误、类文件缺失或打包问题导致。  
**解决方案**:  
1. 检查项目的类路径配置，确保主类所在包路径正确。  
2. 确认主类存在且类名、包名与配置一致。  
3. 若为打包后运行，检查打包配置是否正确包含主类文件。  

### 问题4: 静态资源配置差异
**问题描述**：对比三种Spring静态资源配置的区别及访问URL：
1. `resources: static-locations: classpath:static/,file:static/`
2. `spring: mvc: static-path-pattern: /upload/** resources: static-locations: file:src/main/resources/static`
3. `spring: mvc: static-path-pattern: /upload/** resources: static-locations: classpath:static/,file:static/`
**解释**:  
- 配置1：同时支持类路径和文件系统的静态资源目录，直接访问文件名。  
- 配置2：指定路径前缀`/upload/**`，仅使用文件系统中`src/main/resources/static`目录。  
- 配置3：结合前两者，通过`/upload`路径访问，资源可来自类路径或文件系统。  
**解决方案**:  
- 需同时使用类路径和文件系统资源，选配置1或3。  
- 需指定路径前缀且仅用文件系统资源，选配置2。  
- 根据需求调整 `static-path-pattern` 和 `static-locations`。  

### 问题5: Redis连接异常
**报错信息**：
```java
org.redisson.client.RedisConnectionException: Unable to connect to Redis server: localhost:6379
```
**解释**: Redis服务未启动，或连接地址、端口、密码错误。  
**解决方案**:  
1. 确认Redis服务已运行  
2. 检查配置文件中的`host`、`port`、`password`是否正确  


### 问题6: Redis认证失败
**报错信息**：
```java
ERR Client sent AUTH, but no password is set.
```
**解释**: Redis客户端发送认证请求，但服务端未配置密码或密码不匹配。  
**解决方案**:  
1. 检查Redis配置文件（`redis.conf`）中的`requirepass`参数是否正确设置  
2. 确保代码中配置的密码与Redis服务端一致  
3. 若无需密码认证，移除客户端代码中的认证配置  

**补充说明**：  
- Redis服务端需重启后配置修改才会生效  
- 若使用Docker部署Redis，需检查容器启动参数是否覆盖了配置文件

## 五、其他杂项问题
### 问题1: pip源配置（国内镜像）
**操作命令**：
```bash
pip install -r requirements.txt -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
```
**解释**: 使用国内镜像加速Python包安装，避免网络问题。  
**解决方案**: 全局配置pip源：`pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple`。  

### 问题2：Django 项目运行报错：ModuleNotFoundError: No module named 'distutils'
**操作命令**：
```bash
# 安装 setuptools 以补充 distutils 兼容层
pip install setuptools

# 或升级 Django 到兼容版本
pip install django==4.2.13

# 或降级 Python 到 3.11 及以下（需重新创建虚拟环境）
# 先卸载当前虚拟环境（Windows）
rmdir /s /q venv
# 用 Python 3.11 重新创建虚拟环境
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```
**解释**：Python 3.12 与 Django 3.2.x 版本兼容问题（缺失 distutils 模块），Python 3.12 移除了标准库中的 distutils 模块，而 Django 3.2.x 依赖该模块，导致出现 `ModuleNotFoundError: No module named 'distutils'` 错误。  
**解决方案**：  
1. 安装 setuptools 提供兼容的 distutils 实现；  
2. 升级 Django 到 4.2.x（LTS 版本，支持 Python 3.8+ 包括 3.12）；  
3. 若无法升级 Django，可降级 Python 至 3.11 及以下版本（保留 distutils 模块）。

### 问题3: 端口占用
**报错信息**：
```bash
TCP    0.0.0.0:8187           LISTENING       22496
taskkill /pid 22496 /f
```
**解释**: 端口被其他进程占用，导致服务无法启动。  
**解决方案**:  
1. 使用`netstat -ano | findstr 端口号`查找占用进程  
2. 用`taskkill /pid 进程号 /f`强制终止进程  

### 问题4: HTTP方法名包含非法字符
**报错信息**：
```java
java.lang.IllegalArgumentException: Invalid character found in method name [...]
```
**解释**: Tomcat接收到包含非标准字符的HTTP方法名，可能为恶意请求或协议解析错误。  
**解决方案**:  
1. 检查请求来源，过滤非法请求  
2. 升级Tomcat至最新版本，增强请求解析鲁棒性  

### 问题5: Maven War插件依赖注入异常
**报错信息**：
```java
[WARNING] Error injecting: org.apache.maven.plugin.war.WarMojo
com.google.inject.ProvisionException: Unable to provision...
```
**解释**: Maven War插件版本与当前Maven环境不兼容，导致依赖注入失败。  
**解决方案**: 在`pom.xml`中显式指定兼容的插件版本（如`<version>3.3.1</version>`）。  

### 问题6: 路径包含空格导致命令失败
**报错信息**：
```bash
exit status 1: 'D:\Program' is not recognized as an internal or external command
```
**解释**: 系统命令中路径包含空格，未用引号包裹，导致解析失败。  
**解决方案**: 将路径用英文引号包裹（如`"D:\Program Files\java\bin\java.exe"`）。

### 问题7: 堆内存分配失败（JVM初始化错误）
**报错信息**：
```java
Error occurred during initialization of VM
Unable to allocate ...KB bitmaps for parallel garbage collection...
```
**解释**：  
IntelliJ IDEA 配置的堆内存（Xms/Xmx）超过物理内存限制。  
**解决方案**：  
修改 IDEA 的 `vmoptions` 文件（如 `idea64.exe.vmoptions`），降低 `-Xms` 和 `-Xmx` 参数值，例如：  
```bash
-Xms2048m    # 初始堆内存
-Xmx4096m    # 最大堆内存
```

### 问题8: 颜色值格式错误（5个F）
**报错信息**：
```
[小程序渲染警告] 不合法的颜色值: #FFFFF
[控制台提示] 颜色值应为6位或8位十六进制字符（如#FFFFFF或#FFFFFFFF）
```
**解释**：  
CSS/小程序颜色值需遵循 `#RRGGBB`（6位）或 `#RRGGBBAA`（8位）格式，而 `#FFFFF` 只有5位，导致渲染异常或样式丢失。  

**解决方案**：  
1. **补全颜色值**：将 `#FFFFF` 修正为合法格式（如 `#FFFFFF` 表示白色）
2. 可以直接打开集成开发环境的全局搜索进行查找（打开lambda选项）
```txt
# 下面的正则表达式会匹配“#FFFFF”，只匹配5个F的场景
(?<!#F)FFFFF(?!F)
```

### 问题9: vmware打开ovf文件报错
**报错信息**：
```
SHA digest of file ***.vmdk does not match manifest.
```
**解释**：  
OVF 文件在导入时会校验相关文件的完整性，其中.vmdk 文件的实际 SHA 校验值与.mf 清单文件中记录的对应 SHA 值不匹配，导致验证失败，从而出现报错。

**解决方案**：  
删掉ovf路径下的mf文件，然后重新导入即可。