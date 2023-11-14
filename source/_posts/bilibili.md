---
title: 仿哔哩哔哩项目
index_img: >-
  https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202309120915505.png
categories:
  - Project
tags:
  - SpringBoot
  - Mysql
  - MyBatis
  - Maven
abbrlink: 45290
date: 2022-12-23 20:23:01
---
### 从项目角度和技术角度两个维度来看：

> 项目角度：规模大、不同种类的用户群体、高流量、个性化功能针对不同的用户；
>
> 技术角度：经典高并发与异步问题、视频流+弹幕定制化功能。

### 项目大纲：（[课程链接](https://coding.imooc.com/class/556.html)）

> 第一章：项目整体介绍、课程设计逻辑、学习方法
>
> 第二章：项目架构、环境搭建、效果展示
>
> 第三章：通用配置、用户相关功能
>
> 第四章：视频流+弹幕加载、性能优化
>
> 第五章：全局搜索、系统广播、数据统计、智能推荐
>
> 第六章：总结复盘、切面编程、自动化部署、负载均衡

## 从搭建环境开始你的仿哔哩哔哩项目（初入江湖）

### **项目架构：**

基本过程：需求分析--》功能设计--》全局架构（承载、可复用）

### **业务（功能架构）：**

顶层：用户服务，如注册登录、大会员权限、查找感兴趣视频等

中间层：在线视频播放设置、实施弹幕

底层：管理后台，如：视频上传、数据统计、系统消息推送

### **技术架构：**

技术选型：`SpringBoot2.x`+ `Mysql` + `MyBatis` + `Maven`

开发模式：项目采用经典`MVC`，模式控制层（`Controller层`）、服务层（`Service层`）、数据层（`Dao层`）

### **部署架构:**

前端：服务转发 + 负载均衡

后端：业务处理 + 功能实现

工具：缓存 + 队列

### **开发环境：**

`OS`：`Java`的跨平台，任意OS即可

开发工具：`IntelliJ IDEA`，推荐版本2018及以后

必备：`JDK1.8`、`Maven`

### **创建多模块、多环境项目：**

多模块：经典MVC

多环境：添加不同的properties配置文件（测试、部署）

配置好项目的JDK版本与Maven仓库

### **项目运行:**

在`pom.xml`文件中加入`SpringBoot`框架依赖:

```xml
<parent>
    <artifactId>spring-boot-starter-parent</artifactId>
    <groupId>org.springframework.boot</groupId>
    <version>2.5.1</version>
</parent>

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <version>2.5.1</version>
</dependency>
```

在子模块`pom.xml`文件中添加模块间依赖关系:

```xml
<!--配置模块间的依赖关系-->
<dependency>
    <groupId>org.example</groupId>
    <artifactId>imooc-bilibili-dao</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
```

添加启动入口，启动项目：

```java
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

/**
 * @author WLei224
 * @create 2023/4/28 21:34
 */
@SpringBootApplication
public class ImoocBilibiliApp {
    public static void main(String[] args) {
        ApplicationContext app = SpringApplication.run(ImoocBilibiliApp.class, args);
    }
}
```

多环境配置：

在Service包下创建一个`application.properties`配置文件:

在Controller包下创建多个生产环境：`application-test.properties`、`application-online.properties`

```properties
#profiles可用于切换生产环境
spring.profiles.active=test
```

### **数据库的搭建与持久层框架：**

配置`MySQL`数据库:

引入`MySQL`数据库和持久层`Mybatis`依赖：（`Mybatis`特点：XML形式管理，支持动态`sql`）

```xml
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.27</version>
</dependency>
<dependency>     		     
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>2.2.0</version>
</dependency>
```

将数据库连接写入`application.properties`配置文件：

```properties
#datasource
spring.datasource.url=jdbc:mysql://localhost:3306/imooc_bilibili
spring.datasource.username=root
spring.datasource.password=root(你的密码)
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

将`Mybatis`配置写入可复用的`application.properties`配置文件中：

```properties
#mybatis
mybatis.mapper-locations=classpath:mapper/*.xml
#项目启动时，告诉SpringBoot扫描class、interface的路径，统一实例化，然后与mapper进行关联
mybatis.type-aliases-package=com.imooc.bilibili.dao
```

**开发一个小Demo：**（在持久层`Dao`层进行）

首先要将`mapper`与`dao`层实体类进行关联：(`Demo.xml`)

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD MAPPER 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!--namespace对应着dao层Java实体类文件-->
<mapper namespace="com.imooc.bilibili.dao.DemoDao">

    <select id="query" parameterType="java.lang.Long" resultType="java.lang.Long">
        select id from t_demo where id = #{id}
    </select>

</mapper>
```

`Controller:` 

```java
package com.imooc.bilibili.api;
import com.imooc.bilibili.service.DemoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author WLei224
 * @create 2023/4/29 1:50
 */
@RestController
public class DemoApi {

    @Autowired
    private DemoService demoService;


    @GetMapping("/query")
    public Long query(Long id){
        return demoService.query(id);
    }

}
```

`Service:`

```java
package com.imooc.bilibili.service;

import com.imooc.bilibili.dao.DemoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author WLei224
 * @create 2023/4/29 1:33
 */
@Service
public class DemoService {

    @Autowired
    private DemoDao demoDao;

    public Long query(Long id){
        return demoDao.query(id);
    }
}
```

`Dao:`

```java
package com.imooc.bilibili.dao;

import org.apache.ibatis.annotations.Mapper;

/**
 * @author WLei224
 * @create 2023/4/29 1:04
 */
//如何将DemoDao与mapper对应起来呢？ 为什么声明成为接口呢?因为@mapper注解在启动时会自动匹配，把dao的文件封装成一个实体类，从而实现自动实例化的操作
@Mapper
public interface DemoDao {
    public Long query(Long id);
}
```

### 效率提升：实现热部署：

> 热部署：热部署就是当应用程序正在运行的时候升级软件或修改某一部分代码、配置文件时，无需手动重启应用，即可使修改的部分生效
>
> 配置方法：`spring-boot-devtools`依赖工具+IDEA配置

1、`IDEA:`Files-->Settings-->Compiles-->Build Project Automately

2、`IDEA注册表：Ctrl+Alt+Shift+/`打开`compiler document save enabled`和`compiler automake allow when app runing`

3、编辑启动类的配置：![image-20230429132152997](http://images.rl0206.love/202304291326170.png)

4、引入全局`pom.xml`依赖：

```xml
<!-- 热部署 -->
<dependency>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-devtools</artifactId>
     <version>2.0.4.RELEASE</version>
     <!-- 启用 -->
     <optional>true</optional>
</dependency>
```

热部署已完成。
## 3从用户功能体验后端经典开发模式（窥得门路）

### 用户模块开发概要与接口设计

> **`RESTful`风格接口设计：**
>
> RESTful架构、HTTP方法语义、HTTP方法幂等性、RESTful接口设计原则
>
> **用户模块开发概要：**通用功能与通用配置、用户相关功能

### RESTful接口

> REST全称是：Representational State Transfer，中文为表述性状态转移，REST指的是一组架构约束条件和原则
>
> RESTful表述的是资源的状态转移，在Web中资源就是URI(Uniform Resource Identifier)
>
> 如果一个架构符合REST的约束条件和原则，我们就称它为RESTful架构，HTTP是目前与REST相关的唯一实例
>
> RESTful架构应该遵循统一的接口原则，应该使用标准的HTTP方法，如GET和POST，并且遵循这些方法的语义

### HTTP方法的语义

![image-20230429164253420](http://images.rl0206.love/202304291643114.png)

### POST和PUT的区别

这两个概念非常容易混淆，POST通常被认为创建资源，PUT通常被认为更新资源，而实际上，二者均可用于创建资源，更为本质的差别实在幂等性方面。

> 所谓幂等性，如果一个操作执行一次和执行多次的后果是一样的，那么这个操作就具有幂等性。
>
> 例如：GET获取多次，   无副作用，  具有幂等性
>
> ​	 DELETE删除多次，无副作用，  具有幂等性
>
> ​	 POST提交会创建不同的资源，  不具有幂等性（实例如下图）
>
> ​	 PUT是创建或更新，无副作用，  具有幂等性

![image-20230429165143109](http://images.rl0206.love/202304291651182.png)

`Demo：RESTfulApi:`

```java
package com.imooc.bilibili.api;

import org.springframework.web.bind.annotation.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
/**
 * @author WLei224
 * @create 2023/4/30 11:01
 */
@RestController
public class RESTfulApi {
    private final Map<Integer,Map<String,Object>> dataMap;
    // 声明一个构造方法，同时初始化datamap，进行传参
    public RESTfulApi() {
        dataMap = new HashMap<>();

        for (int i = 1; i < 3; i++) {
            Map<String,Object> data = new HashMap<>();
            data.put("id",i);
            data.put("name","name"+i);
            dataMap.put(i,data);
        }
    }
    // 开始写RESTful的相关方法
    @GetMapping("objects/{id}")
    public Map<String,Object> getData(@PathVariable Integer id){
        return dataMap.get(id);
    }

    @DeleteMapping("objects/{id}")
    public String deleteData(@PathVariable Integer id){
        dataMap.remove(id);
        return "Success";
    }

    @PostMapping("objects")
    public String postData(@RequestBody Map<String,Object> data){
        Integer[] idArray = dataMap.keySet().toArray(new Integer[0]);
        Arrays.sort(idArray);
        int nextId = idArray[idArray.length-1] + 1;
        // data.put("id",nextId);
        // data.put("name","name" + nextId);
        dataMap.put(nextId,data);
        return "Success!";
    }
	// 区别就在于幂等性，存在则更新，不存在则新增
    @PutMapping("objects")
    public String putData(@RequestBody Map<String,Object> data){
        Integer id = Integer.valueOf(String.valueOf(data.get("id")));
        Map<String,Object> hasData = dataMap.get(id);
        if (hasData == null) {
            Integer[] idArray = dataMap.keySet().toArray(new Integer[0]);
            Arrays.sort(idArray);
            int nextId = idArray[idArray.length-1] + 1;
            // data.put("id",nextId);
            // data.put("name","name" + nextId);
            dataMap.put(nextId,data);
        } else {
            dataMap.put(id,data);
        }
        return "Success!";
    }
}
```

### RESTful接口URL命名原则：

> 1、HTTP方法后跟的URL必须是名词的复数形式
>
> 2、URL总不采用大小写混合的驼峰命名，尽量全部小写，如果涉及多个单词，可用”-“连接
>
> 3、示例：/users、/users-fans、 反例：/getUser、/getUserFans

### RESTful接口URL分级原则

> 1、一级用来定位资源分类，如：/users表示需要定位到用户相关资源
>
> 2、二级仍用来定位具体某个资源，如：/users/20/fans/1表示id为20的用户的id为1的粉丝

### RESTful接口命名示例

![image-20230430153315090](http://images.rl0206.love/202304301533812.png)

![image-20230430153406940](http://images.rl0206.love/202304301534235.png)

###  通用功能与配置

#### **通用功能：**

加解密工具（`AES`、`RSA`、`MD5`）、json数据返回类

顶层POM.xml添加commons-codec依赖，

添加对应的工具包到service包的util包下

>  `什么是AES加密`

`AES:`

*Advanced Encryption Standard*高级加密标准，是最常见的对称加密算法，对称加密即加解密只有一个密钥，可使用密钥恢复明文，加密速度非常快。

`使用场景：`

适合发送大量数据的场合。

`看下源码：`

![image-20230519170635001](http://images.rl0206.love/202305191736417.png)

> `什么是RSA加密？`

`RSA:`

是一种非对称加密，即：有公钥与私钥之分，公钥用于数据加密，私钥用于数据解密，同样是可逆的，即可以通过私钥进行解密。公钥提供给外部进行使用，私钥放在服务器，保护数据安全。

`特点：`

加密安全性很高，但是加密速度非常之慢。

`使用场景：`

由特点可知，加密慢，但是安全。因此适合对加密次数要求较少的场景。例如：用户的登陆，加密一次，便不用加密，而且安全性还较高。

`拓展：非对称加密的流程是什么，在实际应用中是如何进行加密的？`

下面以用户注册登录场景为例，来说一下非对称加密在实际中的应用：

因为RSA加密中的公钥是提供给外部进行加密使用的，用户在前端注册登录时，为了保证输入的密码其安全性（防止拦截后密码泄露），将公钥返回到前端，前端使用公钥进行加密，加密后的暗文通过接口然后传给后端，后端再通过私钥进行解密，得到密码。

`加解密源码：`

```java
public static String encrypt(String source) throws Exception {
	byte[] decoded = Base64.decodeBase64(PUBLIC_KEY);
	RSAPublicKey rsaPublicKey = (RSAPublicKey) KeyFactory.getInstance("RSA")
			.generatePublic(new X509EncodedKeySpec(decoded));
	Cipher cipher = Cipher.getInstance("RSA");
	cipher.init(1, rsaPublicKey);
	return Base64.encodeBase64String(cipher.doFinal(source.getBytes(StandardCharsets.UTF_8)));
}
public static String decrypt(String text) throws Exception {
	Cipher cipher = getCipher();
	byte[] inputByte = Base64.decodeBase64(text.getBytes(StandardCharsets.UTF_8));
	return new String(cipher.doFinal(inputByte));
}
```

`最后说一下MD5加密：`

`MD5：`

非对称加密，即不可逆，无法看到加密前的明文。

`特点：`

加密速度快，无需密钥，但是安全性不高需要搭配随机盐值使用。随机盐就是一个随机数，防止黑客将加密后的MD5还原回去。

#### **通用配置：**

`Json信息转换配置 && 全局异常处理配置`

> `JSON返回数据配置：`

`什么是JSON？：JSON就是一种轻量化数据交换格式。`

`为什么会用到JSON返回数据类和数据类转换呢？因为JSON轻量化，前端需要展示不同的数据格式时，这就需要用到JSON信息转换了。`

如何新建JSON信息转换配置？

Service包下新建config包，用于放以后所有的配置类。

此处涉及到Spring Boot相关的注解名，下面来说一下常见的注解：

```txt
@Configuration：标志着Java文件是一个配置类，经常搭配@Bean使用，表示向上下文注入实体类，使其生效；
@Component：是@Configuration注解的内部注解，在Spring Boot启动阶段，自动的将Configuration
对应的文件注入到Sping Boot上下文；
@Bean：表示向上下文注入实体类，使其生效；
```

`HttpMessageConverters：`是一个对Http方法，接收请求，或做转换的一个工具类框架，返回的就是一个@Bean类型，因为此方法是一个JSON类型，所以要引入一个fastJson依赖（目前世界行公认效率最高的工具包）。

```xml
<dependency>
	<groupId>com.alibaba</groupId>
	<artifactId>fastjson</artifactId>
	<version>1.2.78</version>
</dependency>
```

然后配置一些和fastjson相关的配置类。

例如：配置相关的数据返回类型的时间格式、序列化的相关配置、

```java
fastJsonConfig.setSerializerFeatures(
                // 格式化输出
                SerializerFeature.PrettyFormat,
                // 如果输出的数据是空的，那么系统会直接把这个数据去掉，不会在前端进行显示，这个配置项可以显示出一个空串
                SerializerFeature.WriteNullStringAsEmpty,
                // 功能同上，列表
                SerializerFeature.WriteNullListAsEmpty,
                // 同上，集合
                SerializerFeature.WriteMapNullValue,
                // 升序排列
                SerializerFeature.MapSortField,
                // 进制循环引用（防止循环引用后，输出多余的引用字符串） 非常有用的一个配置
                SerializerFeature.DisableCircularReferenceDetect
);
```

循环引用：

![image-20230520144308894](http://images.rl0206.love/202305201545971.png)

> `全局异常处理配置：`

放在Service包下的handle包中，命名为全局异常处理类（`CommonGlobalExceptionHandler.class`）：

```Java
package com.imooc.bilibili.service.handler;

import com.imooc.bilibili.dao.damain.JsonResponse;
import com.imooc.bilibili.dao.damain.exception.ConditionException;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * @author WLei224
 * @create 2023/5/20 16:38
 */
@ControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE) // 最高优先级
public class CommonGlobalExceptionHandler {

    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public JsonResponse<String> commonExceptionHandler(HttpServletRequest request, Exception e){
        String errorMsg = e.getMessage();
        if(e instanceof ConditionException){
            String errorCode = ((ConditionException) e).getCode();
            return new JsonResponse<>(errorCode,errorMsg);
        }else{
            return new JsonResponse<>("500",errorMsg);
        }
    }
}
```

在此之前，我定义了一个条件异常，并添加了状态码等信息，然后这个类的代码功能就是，抓取条件异常信息，然后通过`json数据返回类型jsonResponse`返回异常信息。 

### 用户注册与登录

数据库库表设计：用户表、用户信息表

```sql
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮箱',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '密码',
  `salt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '盐值',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

CREATE TABLE `t_user_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户id',
  `nick` varchar(100) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `sign` text COMMENT '签名',
  `gender` varchar(2) DEFAULT NULL COMMENT '性别：0男 1女 2未知',
  `birth` varchar(20) DEFAULT NULL COMMENT '生日',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户基本信息表';
```

相关接口（API）：获取RSA公钥、用户注册、用户登录

> 项目编写步骤：
>
> entity(domain)->dao（@Mapper交给MyBatis）->service(注入dao)->api(controller)注入service[先留一个bug]
>
> 
>
> 项目整体的逻辑：
>
> 前端访问到我们的api接口层（也就是控制层）之后，会跳转到相关的业务逻辑层（service），在业务实现逻辑层中可能会用到与数据库之间的交互，那么service就会去访问dao层（数据持久层，放的是与数据库进行交互的接口），dao层通过@Mapper注解与MyBatis产生关联，通过MyBatis进行交互，交互的结果返回给service业务逻辑层，业务逻辑层返回给控制层接口，然后在前端体现了出来。
>
> 以上层层嵌套的架构，可以让代码更加清晰、优雅。

🆗，通过以上步骤，实体类已经新建好了，下面进行相关接口的业务逻辑书写

* 获取RSA公钥

@GetMapping

* 用户注册

@PostMapping

同样是按照接口的编写顺序来进行coding，在@Api中写接口，service中写实现，

* 用户登录





### 基于JWT的用户token验证

`JWT`:`JSON Web Token`，`JWT`是一个规范，用于在空间受限环境下安全传递"声明"。

**什么是声明呢？**

声明分为三个部分：

一、头部（header）

​	声明的类型、声明的加密算法（通常使用SHA256）

二、载荷（payload）

​	用于存放有效信息的，一般包含签发者、所面向的用户、接受方、过期时间、签发时间以及唯一身份标识（userId）

三、签名（signature）

​	主要由头部、载荷、以及密钥组成加密而成

JWT的优点：

跨语言支持（因为`JWT`使用的是`JSON`数据格式，所以多语言都支持）、便于传输（见定义：空间受限的环境之下，说明`JWT`是数据量很小的，因此便于传输）、易于扩展（因为`JWT`有`payload`的部分，因为数据的分类很多、定制化强，可以通过`payload`进行数据添加，所以易于扩展）



说到session之前，先来说一下基于session的用户验证：

* 基于session的用户身份验证
* 验证过程：服务端验证浏览器携带的用户名和密码，验证通过后生成用户凭证保存在服务端（session），浏览器再次访问时，服务端查询session，实现登陆状态保持。
* 缺点：随着用户的增多，服务端的压力增大；若浏览器的cookie被第三方或者攻击者拦截，容易受到跨站请求伪造攻击；分布式系统下扩展不强（多台服务器部署应用，用户在不同的服务器进行访问，因为session不会共享，所以不会进行自动登录）。

说到session验证，再来说一下token验证：

* 基于token的用户验证
* 验证过程：服务器端验证浏览器携带的用户名和密码，验证通过后，生成用户令牌（token），不同于session的一点是，服务端不会保存token，而会返回给浏览器，浏览器接收到token之后，进而写在浏览器的localstory中，那么什么是local story呢？localstory不同于cookie，它可以保存在本地，大小也比cookie大很多，所以在请求时就可以不用把token放在cookie中请求服务器，可以放在请求头中或者body中，这样就可以降低跨站请求拦截的风险，最后服务端拿到token之后进行校验是否正确，正确就证明是合法用户。
* 优点：token不存储在服务器，不会造成服务器的压力；token可以存储在非cookie中的（local story），安全性更高；分布式系统下扩展性较强（token生成之后返回前端，前端拿到之后在请求服务端，服务端再对token进行验证即可）。

