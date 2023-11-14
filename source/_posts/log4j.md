---
title: 一篇文章搞懂 log4j 的使用方法
categories:
  - 框架
tags:
  - MyBatis
  - Logging Services
abbrlink: 11624
date: 2023-09-22 00:33:33
---

# 一篇文章搞懂 MyBatis 配置 log4j 的使用方法

> [Log4j](https://logging.apache.org/log4j/2.x/index.html)是 Apache 的一个开源项目，通过使用Log4j，我们可以控制日志信息输送的目的地是控制台、文件、GUI组件，甚至是套接口服务器、NT的事件记录器、UNIX Syslog 守护进程等；我们也可以控制每一条日志的输出格式；通过定义每一条日志信息的级别，我们能够更加细致地控制日志的生成过程。最令人感兴趣的就是，这些可以通过一个配置文件来灵活地进行配置，而不需要修改应用的代码。
>
> ​									——————摘自百度百科

## 一、引入依赖

```xml
<dependency>
            <groupId>log4j</groupId>
            <artifactId>log4j</artifactId>
            <version>1.2.12</version>
</dependency>
```

## 二、在`mybatis-config.xml`文件加入 setting 标签

```xml
<!--设置使用的日志类型-->
<settings>
    <setting name="logImpl" value="LOG4J"/>
</settings>
```

### `mybatis-config.xml`文件模板:

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">

<!--MyBatis配置-->
<configuration>

    <!--添加properties配置文件路径(外部配置、动态替换)-->
    <properties resource="database.properties" />

    <!--设置使用的日志类型-->
    <settings>
        <setting name="logImpl" value="LOG4J"/>
    </settings>

    <!--JDBC环境配置、选中默认环境-->
    <environments default="MySqlDB">
        <!--MySql数据库环境配置-->
        <environment id="MySqlDB">
            <!--事务管理-->
            <transactionManager type="JDBC"/>
            <!--连接池-->
            <dataSource type="POOLED">
                <property name="driver" value="${driver}"/>
                <property name="url" value="${url}"/>
                <property name="username" value="${username}"/>
                <property name="password" value="${password}"/>
            </dataSource>
        </environment>
    </environments>



    <!--Mapper注册-->
    <mappers>
        <!--注册Mapper文件的所在位置-->
        <mapper resource="mapper/UserMapper.xml"/>
    </mappers>
</configuration>
```

### `database.properties`配置文件模板：

```properties
#key=value
driver=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
username=root
password=root
```



## 三、在 resources 目录下创建log4j.properties并写入：

```properties
#将等级为DEBUG的日志信息输出到console和file这两个目的地，console和file的定义在下面的代码
log4j.rootLogger=DEBUG,console,file
 
#控制台输出的相关设置
log4j.appender.console = org.apache.log4j.ConsoleAppender
log4j.appender.console.Target = System.out
log4j.appender.console.Threshold=DEBUG
#布局
log4j.appender.console.layout = org.apache.log4j.PatternLayout
#日志格式
log4j.appender.console.layout.ConversionPattern=[%c]-%m%n
 
#文件输出的相关设置
log4j.appender.file = org.apache.log4j.RollingFileAppender
#生成文件的名字
log4j.appender.file.File=./log/shao.log
#文件最大大小
log4j.appender.file.MaxFileSize=10mb
log4j.appender.file.Threshold=DEBUG
log4j.appender.file.layout=org.apache.log4j.PatternLayout
log4j.appender.file.layout.ConversionPattern=[%p][%d{yy-MM-dd}][%c]%m%n
 
#日志输出级别
log4j.logger.org.mybatis=DEBUG
log4j.logger.java.sql=DEBUG
log4j.logger.java.sql.Statement=DEBUG
log4j.logger.java.sql.ResultSet=DEBUG
log4j.logger.java.sql.PreparedStatement=DEBUG
```

## 四、运行测试

![测试成功](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202309220052332.png)

over！
