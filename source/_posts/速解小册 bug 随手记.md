---
title: 速解小册 bug 随手记
tags:
  - Bugs
categories:
  - 速解小册
date: 2025-06-24 21:21:52
---

# 随手记（待整理）

## 前端
```bash
Syntax Error: Error: PostCSS received undefined instead of CSS string

 ERROR  Failed to compile with 1 error                                                                                                      18:36:31

 error  in ./src/assets/css/style.scss

Syntax Error: Error: PostCSS received undefined instead of CSS string


 @ ./src/assets/css/style.scss 4:14-234 15:3-20:5 16:22-242
 @ ./src/main.js
 @ multi (webpack)-dev-server/client?http://192.168.137.245:8081&sockPath=/sockjs-node (webpack)/hot/dev-server.js ./src/main.js

```
问题根源：
运行环境的node版本与项目的依赖包版本不匹配。
解决方法：
1. 切换node版本 
2. 删掉node_modules文件夹，删掉package-lock.json文件，然后重新下载项目依赖
3. 注意控制台打印url之后，打开**可能会**提示需要`npm rebuild node-sass`
## 后端

1. Error querying database.  Cause: org.springframework.jdbc.CannotGetJdbcConnectionException: Could not get JDBC Connection; nested exception is org.apache.tomcat.dbcp.dbcp.SQLNestedException: Cannot create JDBC driver of class


-- url 信息写错了
2. Mysql数据库连接时出现异常：com.mysql.jdbc.exceptions.jdbc4.MySQLNonTransientConnectionException: Client does not support authentication protocol requested by server; consider upgrading MySQL client

-- 更改用户的认证方式更改为 “mysql_native_password”。

3. java.sql.SQLNonTransientConnectionException: Public Key Retrieval is not allowed

Sat Dec 14 23:22:31 CST 2024 WARN: Establishing SSL connection without server's identity verification is not recommended. According to MySQL 5.5.45+, 5.6.26+ and 5.7.6+ requirements SSL connection must be established by default if explicit option isn't set. For compliance with existing applications not using SSL the verifyServerCertificate property is set to 'false'. You need either to explicitly disable SSL by setting useSSL=false, or set useSSL=true and provide truststore for server certificate verification.
2024-12-14 23:22:31 -2495 [Druid-ConnectionPool-Create-405095413] ERROR   - create connection error, url: jdbc:mysql://127.0.0.1:3306/nongchanpincangkuguanli?useUnicode=true&characterEncoding=UTF-8&tinyInt1isBit=false, errorCode 0, state 08S01
com.mysql.jdbc.exceptions.jdbc4.CommunicationsException: Communications link failure

-- useSSL=false


5. 2024-12-14 23:27:54 -2221 [Druid-ConnectionPool-Create-1140560211] ERROR   - create connection error, url: jdbc:mysql://127.0.0.1:3306/nongchanpincangkuguanli?useSSL=false&useUnicode=true&characterEncoding=UTF-8&tinyInt1isBit=false, errorCode 0, state 01S00
java.sql.SQLException: The server time zone value '脰脨鹿煤卤锚脳录脢卤录盲' is unrecognized or represents more than one time zone. You must configure either the server or JDBC driver (via the serverTimezone configuration property) to use a more specifc time zone value if you want to utilize time zone support.

-- &serverTimezone=GMT%2B8
-- &serverTimezone=GMT+8
-- serverTimezone=Asia/Shanghai

allprojects {
    repositories {
        mavenLocal()
        maven { name "Alibaba" ; url "https://maven.aliyun.com/repository/public" allowInsecureProtocol = true}
        maven { name "Bstek" ; url "http://nexus.bsdn.org/content/groups/public/" allowInsecureProtocol = true}
        mavenCentral()
    }

    buildscript { 
        repositories { 
            maven { name "Alibaba" ; url 'https://maven.aliyun.com/repository/public' allowInsecureProtocol = true}
            maven { name "Bstek" ; url 'http://nexus.bsdn.org/content/groups/public/' allowInsecureProtocol = true}
            maven { name "M2" ; url 'https://plugins.gradle.org/m2/' allowInsecureProtocol = true}
        }
    }
}

6. eclipse  java.sql.Connection爆红

-- windows->preference->Java->Installed JREs->Add->Standard VM->Directory->选择jdk安装目录->Finish
-- 右键项目->properties->Java Build Path->Libraries->Add Library->JRE System Library->Next->Installed JREs->Add->Standard VM->Directory->选择jdk安装目录->Finish

7. java: 编译失败: 内部 java 编译器错误、运行配置停止之前未连接应用程序服务器,原因:无法在localhost:1099处ping服务器

-- jdk版本不匹配


解决：java.sql.SQLException: Unknown system variable ‘query_cache_size‘

-- 修改pomMySQL版本或者jar包版本


ERR Client sent AUTH, but no password is set.

-- redis配置文件中密码和本地不一致

idea 编译时 找不到符号 变量 log, idea进行项目编译的时候报找不到符号 变量 log,对lombok进行了各种配置后发现还是无效后，最后进行complier配置

-- 添加-Djps.track.ap.dependencies=false
![配置](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/bugs-2024-12-20-14-48-39.png)


java.sql.SQLException: Operation not allowed for a result set of type ResultSet.TYPE_FORWARD_ONLY.

-- PreparedStatement pre = conn.prepareStatement(sql);
改为：PreparedStatement pre = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);



java.sql.SQLException: Unknown initial character set index '255' received from server. Initial client character set can be forced via the 'characterEncoding' property.






严重: Servlet.service() for servlet [jsp] in context with path [/zqq] threw exception [The absolute uri: http://java.sun.com/jstl/core_rt cannot be resolved in either web.xml or the jar files deployed with this application] with root cause
org.apache.jasper.JasperException: The absolute uri: http://java.sun.com/jstl/core_rt cannot be resolved in either web.xml or the jar files deployed with this application


<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>


HTTP Status 500 - The absolute uri: http://java.sun.com/jsp/jstl/core cannot be resolved in either web.xml or the jar files deployed with this application


<servlet>
		<servlet-name>MyServlet</servlet-name>
		<servlet-class>com.servlet.MyServlet</servlet-class>
	</servlet>



    java: Compilation failed: internal java compiler error



    java.lang.IllegalArgumentException: Timestamp format must be yyyy-mm-dd hh:mm:ss[.fffffffff]
    java.sql.Timestamp.valueOf(Timestamp.java:237)
    com.wzy.controller.DateView.list(DateView.java:250)
    sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)


    java: 无效的标记: --enable-preview



    (?<!#F)FFFFF(?!F)



​	

    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple



    java.sql.SQLException: Unknown character set index for field '255' received from server.

SET GLOBAL sql_mode='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';



Unable to load io.netty.resolver.dns.macos.MacOSDnsServerAddressStreamProvider, fallback to system defaults. This may result in incorrect DNS resolutions on MacOS. Check whether you have a dependency on 'io.netty:netty-resolver-dns-native-macos'


MacOS M1 nacos 2.3.1

Module build failed: Error: Cannot find module 'node-sass'

错误: 找不到或无法加载主类 org.jetbrains.idea.maven.server.RemoteMavenServer36

error while loading shared libraries: libaio.so.1: cannot open shared object file: No such file or directory

./bin/mysqld: error while loading shared libraries: libaio.so.1: cannot open shared object file: No such file or directory



java.sql.SQLNonTransientConnectionException: CLIENT_PLUGIN_AUTH is required


2024-12-30T09:48:17.332517Z 0 [ERROR] [MY-013183] [InnoDB] Assertion failure: dict0dict.cc:5283:error == DB_SUCCESS thread 7844



---

    C:\Users\Make>netstat -ano | findstr 8187
  TCP    0.0.0.0:8187           0.0.0.0:0              LISTENING       22496
  TCP    [::]:8187              [::]:0                 LISTENING       22496

C:\Users\Make>taskkill /pid 22496 /f
成功: 已终止 PID 为 22496 的进程。

---
问题描述： package报错
[WARNING] Error injecting: org.apache.maven.plugin.war.WarMojo

com.google.inject.ProvisionException: Unable to provision, see the following errors:

1) Error injecting constructor, java.lang.ExceptionInInitializerError: Cannot access defaults field of Properties

  at org.apache.maven.plugin.war.WarMojo.<init>(Unknown Source)

  while locating org.apache.maven.plugin.war.WarMojo

1 error

    at com.google.inject.internal.InternalProvisionException.toProvisionException (InternalProvisionException.java:226)
    
    at com.google.inject.internal.InjectorImpl$1.get (InjectorImpl.java:1053)


解决方法：

1） 在pom.xml文件中增加

<build>
<plugins>
<plugin>
<groupId>org.apache.maven.plugins</groupId>
<artifactId>maven-war-plugin</artifactId>
<version>3.3.1</version>
</plugin>
</plugins>
</build>


---

Error occurred during initialization of VM
Unable to allocate 113600KB bitmaps for parallel garbage collection for the requested 3635200KB heap.

修改idea的xms和xmx

---

Syntax Error: Error: PostCSS received undefined instead of CSS string

npm install element-ui@2.15.13 sass-loader@10.1.1 node-sass@4.14.1 --save

---

Uncaught runtime errors:
×
ERROR
Request failed with status code 404
AxiosError: Request failed with status code 404
    at settle (webpack-internal:///./node_modules/axios/dist/browser/axios.cjs:2006:12)
    at XMLHttpRequest.onloadend (webpack-internal:///./node_modules/axios/dist/browser/axios.cjs:2452:7)
    at Axios.request (webpack-internal:///./node_modules/axios/dist/browser/axios.cjs:3219:41)

解决方法：
  devServer: {
    client: {
      //当出现编译错误或警告时，在浏览器中是否显示全屏覆盖。  示例为只显示错误信息
      overlay: {
        runtimeErrors: false,
      },
    },
  },

---


# 整理时间
---
2025年5月22日 21:58:15
上述报错均已整理至速解小册 bug 修复指南中
---

报错：ERROR in Conflict: Multiple assets emit different content to the same filename index.html


1、方案一
该项目文件的上一层命名 存在中文文字；尝试用纯英文命名，避免中文命名的影响(成功解决了问题)；
注意也不要有括号等符号

2、方案二
修改 index.html 文件名称，以及 webpack 的相关配置文件(也成功解决了问题);

1、把 index.html 文件重命名为 index.ejs 文件；
2、在 node_nodules/webpack/bin/webpack.js 中加入 html: { template: ‘./src/index.ejs’ }
代码： html: { template: ‘./src/index.ejs’ }


---



failed to load config from C:\idea_project\smart-electrical\front\vite.config.js
error when starting dev server:
Error [ERR_MODULE_NOT_FOUND]: Cannot find package 'C:\idea_project\smart-electrical\front\node_modules\vite\' imported from C:\idea_project\smart-electrical\front
\node_modules\.vite-temp\vite.config.js.timestamp-1748296112623-c333789d6de09.mjs
Did you mean to import vite/index.cjs?

---


  opensslErrorStack: [
    'error:03000086:digital envelope routines::initialization error',
    'error:0308010C:digital envelope routines::unsupported'
  ],
  library: 'digital envelope routines',
  reason: 'unsupported',
  code: 'ERR_OSSL_EVP_UNSUPPORTED'
}

Node.js v22.14.0

因为加密方式不同，所以修改如下：

"scripts": {
"dev": "SET NODE_OPTIONS=--openssl-legacy-provider && vue-cli-service serve",
  "serve": "SET NODE_OPTIONS=--openssl-legacy-provider && vue-cli-service serve",
  "build": "SET NODE_OPTIONS=--openssl-legacy-provider && vue-cli-service build"
}

---


ERROR 2013 (HY000): Lost connection to MySQL server at 'reading initial communication packet', system error: 0

需要修改`MySQL`的配置文件`my.ini`的某一参数

我是直接用了@速解小册 MySQL篇中的配置文件进行初始化解决的

---

【Android Studio】调试时无法连接模拟器解决办法(被占用Launching app (Waiting for all target devices to comeonline)无限等待

解决方法：
1、关机模拟机并关闭
2、Device manager 中点击"三个点"选择`Wipe data`初始化虚拟设备

---

Error querying database.  Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'farm.jsh_material_extend.id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

解决方法：

直接使用 @速解小册 MySQL篇中的my.ini配置文件的sql_mode部分，添加sql_mode进行服务重启或者初始化
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

---

 ERROR  Failed to compile with 1 error                                                                  03:35:02

 error  in ./src/views/student/ExamResult.vue?vue&type=style&index=0&id=22ca9d2a&scoped=true&lang=scss

Syntax Error: TypeError: this.getOptions is not a function


 @ ./node_modules/vue-style-loader??ref--9-oneOf-1-0!./node_modules/css-loader/dist/cjs.js??ref--9-oneOf-1-1!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/src??ref--9-oneOf-1-2!./node_modules/sass-loader/dist/cjs.js??ref--9-oneOf-1-3!./node_modules/cache-loader/dist/cjs.js??ref--1-0!./node_modules/vue-loader/lib??vue-loader-options!./src/views/student/ExamResult.vue?vue&type=style&index=0&id=22ca9d2a&scoped=true&lang=scss 4:14-482 15:3-20:5 16:22-490
 @ ./src/views/student/ExamResult.vue?vue&type=style&index=0&id=22ca9d2a&scoped=true&lang=scss
 @ ./src/views/student/ExamResult.vue
 @ ./src/router/index.js
 @ ./src/main.js
 @ multi (webpack)-dev-server/client?http://192.168.0.106:8015&sockPath=/sockjs-node (webpack)/hot/dev-server.js ./src/main.js

