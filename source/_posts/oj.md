---
title: 基于Spring Boot的在线编程判题系统
index_img: https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202311151627634.png
banner_img: https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202311151640352.png
hide: true
categories:
  - Project
tags:
  - Spring Boot
  - MySQL
abbrlink: 6280
date: 2023-08-21 08:12:32
---

# Smart OJ

> ## 复习一下项目开发流程
>
> 1. 项目简介、项目调研、项目需求分析
>
> 2. 核心业务流程
>
> 3. 项目功能模块
>
> 4. 技术选型
>
> 5. 项目初始化
>
> 6. 项目开发
>
> 7. 测试
>
> 8. 优化
>
>    （代码提交、代码审核、产品验收）
>
> 9. 上线
>
> 在此过程中，也是要不断写文档、持续调研、沉淀知识的



## 项目简介

OJ ： Online Judge（在线判题评测系统）

用户可以选择题目练习，在线编写代码，测试代码，提交代码，系统会根据设置好的答案对用户提交的代码进行评测，给出评测结果！

#### 项目亮点

1. 项目新颖，重复度低，写简历有区分度
2. 区别于常见的`CRUD`项目，偏向于架构设计、编程思想之类的知识
3. 项目复杂度高，可扩展性强

#### OJ系统的常用概念

ac 表示你的题目通过，结果正确
题目限制：时间限制、内存限制
题目介绍
题目输入
题目输出
题目输入用例
题目输出用例

#### **难点**:判题系统

普通测评：管理员设置题目的输入和输出用例，比如我输入 A，你要输出 B 才是正确的；交给判题机去执行用户的代码，给用户的代码喂输入用例，比如 A，看用户程序的执行结果是否和标准答案的输出一致。
（比对用例文件）

特殊测评（SPJ）：管理员设置题目的输入和输出，比如我输入 1，用户的答案只要是 > 0 或 < 2 都是正确的；特判程序，不是通过对比用例文件是否一致这种死板的程序来检验，而是要专门根据这道题目写一个特殊的判断程序，程序接收题目的输入（1）、标准输出用例（2）、用户的结果（1.5） ，特判程序根据这些值来比较是否正确。

交互测评：让用户输入一个例子，就给一个输出结果，交互比较灵活，没办法通过简单的、死板的输入输出文件来搞定

***不能让用户随便引入包、随便遍历、暴力破解，需要使用正确的算法。 => 安全性***

***判题过程是异步的 => 异步化***

***提交之后，会生成一个提交记录，有运行的结果以及运行信息（时间限制、内存限制）***



## 项目调研

https://github.com/HimitZH/HOJ(适合学习)
https://github.com/QingdaoU/OnlineJudge(python,不好学，很成熟)
https://github.com/hzxie/Noj(星星没那么多，没那么成熟，但相对好学)
https://github.com/vfleaking,/uoj(php实现的)



## 项目需求分析



#### 实现核心

1. 权限校验

2. 代码沙箱（安全沙箱 -- 防止代码藏毒）

   代码安全：设置安全的、隔离的沙箱，以确保用户的代码不会影响到系统的安全

   

3. 判题规则

   题目用例的比对，结果的验证

4. 任务调度

   资源分配：防止用户疯狂占用资源，措施：异步化处理，服务资源有限，按照用户提交顺序进行判题

#### 核心业务流程

![image-20231122184857284](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202311221849444.png)

时序图：

![image-20231115164047376](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202311151640352.png)

#### 功能

1. 题目模块

   a. 管理员：创建、删除、修改

   b. 用户：搜索题目

   c. 在线做题、提交题目代码

2. 用户模块

   a. 注册与登录

3. 判题模块

   a. 提交判题（结果是否正确与错误）

   b. 错误处理（内存溢出、安全性、超时）

   c. 自主实现代码沙箱（安全、隔离的一个环境）

   d. 开放接口



#### 扩展思路

1. 支持多种语言
2. 远程评测
3. 完善的评测功能：普通评测、特殊评测、交互评测、在线自测、文件IO
4. 统计分析判题记录
5. 权限校验



## 技术选型

#### 前端：

`Vue3、手撸Umi项目模板、AcroDesign组件库、在线代码编辑器、在线文档浏览`

#### 后端：

`Java进程控制、Java安全管理、部分JVM知识点、虚拟机、Docker、Spring Cloud微服务、消息队列`

## 架构设计

采用分层架构：用户层、接入层、业务层、服务层、存储层、资源层

![image-20231122192355366](E:/Master/TyporaImages/oj/image-20231122192355366.png)

## 项目排期

1. 项目简介、项目调研、需求分析、技术选型、架构设计、现有`OJ`主流实现方案
2. 前后端项目初始化、前端通用项目模板的搭建
3. 主业务流程的前后端开发（争取把代码沙箱之外的全部搞定）
4. 专攻代码沙箱（自主实现，不止一种实现方案，层层递进，通过实战用例来进行安全优化）
5. 系统优化（微服务改造、系统扩展思路）



## 主流OJ实现方案

1. 用现成的`OJ`系统 

网上有很多开源的`OJ`项目，比如`青岛OJ`、`HustOJ`等，可以直接下载开源代码自己部署。

比较推荐的是`judge0`，这是一个非常成熟的`商业OJ`项目，支持 60 多种编程语言！

> 代码：https://github.com/judge0/judge0

2. 用现成的服务 

如果你不希望完整部署一套大而全的代码，只是想复用他人已经实现的、最复杂的判题逻辑，那么可以直接使用现成的 判题`API`、或者现成的 代码沙箱 等服务。

比如`judge0`提供的`判题API`，非常方便易用。只需要通过 HTTP 调用`submissions`判题接口，把用户的代码、输入值、预期的执行结果作为请求参数发送给`judge0`的服务器，它就能自动帮你编译执行程序，并且返回程序的运行结果。

`API`的作用：接受代码、返回执行结果

> `Judge0 API`地址：https://rapidapi.com/judge0-official/api/judge0-ce
>
> 官方文档：https://ce.judge0.com/#submissions-submission-post

>  流程 
>
> 1先注册
>
> 2再开通订阅
>
> 3然后测试 language 接口
>
> 4测试执行代码接口 submissions

3. **自主开发**✨✨✨--我的方案

自主实现判题服务和代码沙箱，适合学习，但不适用于商业项目。



4. 把 AI 来当做代码沙箱 

现在 AI 的能力已经十分强大了，我们可以把各种本来很复杂的功能直接交给 AI 来实现。

只要脑洞够大，AI + 编程 = 无限的可能~



5. 移花接木 

这种方式最有意思、也最 “缺德”。很多同学估计想不到。

那就是可以通过让程序来操作模拟浏览器的方式，用别人已经开发好的 OJ 系统来帮咱们判题。

比如使用 Puppeteer + 无头浏览器，把咱们系统用户提交的代码，像人一样输入到别人的 OJ 网页中，让程序点击提交按钮，并且等别人的 OJ 系统返回判题结果后，再把这个结果返回给我们自己的用户。

这种方式的缺点就是把核心流程交给了别人，如果别人服务挂了，你的服务也就挂了；而且别人 OJ 系统不支持的题目，可能你也支持不了。





# 后端项目笔记

## 项目初始化

### 五步走：

1. 选中项目全局搜索替换springboot-init为新项目名
2. 选中包，全局更改替换包名springbootinit
3. 更改包名
4. 本地新建数据库，直接执行sql/create table.sql脚本，修改库名为yuoj,执行即可
5. 改application.yml配置，修改MySQL数据库的连接库名、账号密码，端口号



### 初始化模板待完善的地方：

1. 日志：根据错误类型分类，分级归档
2. 扩展：引入分布式锁、多线程、线程池



## 项目模板复习

**1)先阅读README.md**

**2)sql/create table.sql定义了数据库的初始化建库建表语句**

**3)sql/post_es mapping,json帖子表在ES中的建表语句**

**4)aop:用于全局权限校验、全局日志记录**

**5)common:万用的类，比如通用响应类**

**6)config:用于接收application.yml中的参数，初始化一些客户端的配置类（比如对象存储客户端）**

**7)constant:定义常量**

**8)controller:接受请求**

**9)esdao:类似mybatis的mapper,用于操作ES**

**10)exception:异常处理相关**

**11)job:任务相关（定时任务、单次任务）**

**12)manager:服务层（一般是定义一些公用的服务、对接第三方APl等）**

**13)mapper:mybatis的数据访问层，用于操作数据库**

**14)model:数据模型、实体类、包装类、枚举值**

**15)service:服务层，用于编写业务逻辑**

**16)utils:工具类，各种各样公用的方法**

**17)wxmp:公众号相关的包**

**18)test:单元测试**

**19)MainApplication:项目启动入口**

**20)Dockerfile:用于构建Docker镜像**



## 基本开发流程

### 库表设计

1. 根据功能设计库表

1. 1. 用户表

字段：id、账号、密码、昵称、头像、简介、用户角色、微信开放平台id、公众号openId、创建时间、修改时间、是否删除（项目全局配置文件中已经配置了 MybatisPlus isDelete 字段为逻辑删除）

1. 1. 题目表

字段：

题目相关：id、标题、内容、标签、答案、提交数量、通过数量、通关率（扩展）；

判题相关：判题用例（judgeCase / json）、判题限制（judgeConfig / json）、判题类型（扩展）；

```
[  {    "input": "1 2",    "output": "3 4"  },  {    "input": "1 3",    "output": "2 4"  } ]``{  "timeLimit": 1000,  "memoryLimit": 1000,  "stackLimit": 1000 }
```

1. 1. 用户-题目提交表

字段：用户id、题目id、语言、代码、判题状态、判题信息（judgeInfo / json）;

```
{  "message": "{$ 判题信息枚举值 $}",  "time": 1000, // 单位：ms  "memory": 1000  // 单位：kb }
```

枚举值信息：

- - - - ACCEPT  					通过
      - WRONG_ANSWER			答案错误
      - COMPILE_ERROR			编译错误
      - MEMORY_LIMIT_EXCEEDED	内存溢出
      - TIME_LIMIT_EXCEETED		超时
      - PRESENTATION_ERROR		展示错误
      - OUTPUT_LIMIT_EXCEEDED		输出溢出
      - WAITING					等待中
      - DANGEROUS_OPERATION		危险操作
      - RUNTIME_ERROR			运行错误
      - SYSTEM_ERROR 			系统错误



数据库表字段存 json 的**前提：**

首先，字段含义相关，属于同一类；

其次，不需要根据 json 中的某一字段进行查询；

最后，字段存储不用占用太多空间。

存 json 的**好处：**

便于扩展，即：不用修改库表结构，就可以直接操作对象内部的字段

小知识（数据库索引）：

什么时候适合加索引？如何给某个字段加上索引？

首先，索引需要建立在有区分度的字段上；

其次，需要从我们的实际业务出发，无论是单个索引，还是联合索引，都需要从实际的查询语句、字段枚举值的区分度、字段的类型考虑，特别是 where 条件指定的字段。

例如：where userId = 1 and questionId = 2，这个时候就可以分别建立索引，或者是联合索引，**如果是数据量不大的话，尽量不用索引，因为索引也需要占用空间。（待考证！！！）**



```sql
# 数据库初始化
# @author <a href="https://github.com/wl2o2o">程序员CSGUIDER</a>
# @from <a href="https://wl2o2o.github.io">CSGUIDER博客</a>

-- 创建库
create database if not exists smartoj;

-- 切换库
use smartoj;

-- 用户表
CREATE TABLE if not exists user (
  id        	     bigint           auto_increment                        		comment 'id'   	             primary key,
  userAccount      varchar(256)  															  not null  		comment '用户账号',
  userPassword     varchar(512)						          						not null    	comment '用户密码',
  userName 		     varchar(256)  								 							 			null 	    comment '用户昵称',
  userAvatar 	     varchar(1024) 								  									null 	   	comment '用户头像',
  userProfile      varchar(512)							 	  										null      comment '用户简介',
  userRole 	 	     varchar(256)     default 'user'			  			not null    	comment '用户角色',
  unionId			 		 varchar(256)								  										null		  comment '微信开放平台id',
  mpOpenId 		     varchar(256)					   										   		null 	    comment '微信公众号id',
  createTime	     datetime         default CURRENT_TIMESTAMP   not null	  	comment '创建时间',
  updateTime       datetime         default CURRENT_TIMESTAMP   not null    	on update CURRENT_TIMESTAMP comment '更新时间',
  isDelete         tinyint          default 0					  				not null  	  comment '逻辑删除',
  index 			 		 idx_unionId      (unionId)
) comment '用户表'  collate = utf8mb4_unicode_ci;


# 字段：
# 题目相关：id、标题、内容、标签、答案、提交数量、通过数量、通关率（扩展）；
# 判题相关：判题用例（judgeCase / json）、判题限制（judgeConfig / json）、判题类型（扩展）；
-- 题目表
CREATE TABLE if not exists question (
  id        	     bigint      	  auto_increment                         			comment '题目id'              primary key,
  userId        	 bigint        															 	not null    	comment '创建用户id',
  title			    	 varchar(256)  								 								not null    	comment '题目标题',
  tags 			     	 varchar(256)				    		 	 								not null    	comment '题目标签',
  content          text							        									  not null    	comment '题目内容',
  answer	 	  	   text				  						 												null 	    comment '题目答案',
  judgeCase	 	     text 								     	 									not null    	comment '判题用例',
  judgeConfig	     text									     												null			comment '判题限制',
  submitNum 	     int 					  default 0					 								null 	    comment '提交数量',
  acceptNum        int         	  default 0	 			  	 							null      comment '通过数量',
  thumbNum 		     int			  		default 0												 	null 	    comment '点赞数量',
  favourNum		     int 	   		  	default 0					 								null 	    comment '收藏数量',
  createTime	     datetime       default CURRENT_TIMESTAMP  		not null	 		comment '创建时间',
  updateTime       datetime       default CURRENT_TIMESTAMP 		not null   		on update CURRENT_TIMESTAMP  comment '更新时间',
  isDelete         tinyint        default 0                 		not null    	comment '逻辑删除',
  index 			 		 idx_userId     (userId)
) comment '题目表'  collate = utf8mb4_unicode_ci;


# 字段：用户id、题目id、语言、代码、判题状态、判题信息（judgeInfo / json）;
-- 题目提交表
CREATE TABLE if not exists question_submit (
  id                bigint          auto_increment                           comment 'id'		primary key,
  userId            bigint                                      not null     comment '创建用户 id',
  questionId        bigint                                      not null     comment '题目 id',
  language          varchar(128)                                not null     comment '编程语言',
  code              text                                        not null     comment '用户代码',
  status            int             default 0                   not null     comment '判题状态（0 - 待判题、1 - 判题中、2 - 成功、3 - 失败）',
  judgeInfo         text                                        		null     comment '判题信息（json 对象）',
  createTime        datetime        default CURRENT_TIMESTAMP   not null     comment '创建时间',
  updateTime        datetime        default CURRENT_TIMESTAMP   not null     on update CURRENT_TIMESTAMP comment '更新时间',
  isDelete          tinyint         default 0                   not null     comment '是否删除',
  index             idx_questionId  (questionId),
  index             idx_userId      (userId)

) comment '题目提交表'  collate = utf8mb4_unicode_ci;
```

### 代码生成方法

1. 使用 MyBatisX 插件，会自动根据库表字段，一键生成业务的基础 CRUD 代码
2. 编写 Controller 层代码（根据模板进行复用，复制逻辑相同代码，替换字段）
3. 编写 DTO、VO、枚举值字段，用于接受前端请求或者业务间传递信息。（复用项目模板）

```java
package com.yupi.yuoj.model.enums;

import org.apache.commons.lang3.ObjectUtils;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 题目提交编程语言枚举
 *
 * @author <a href="https://github.com/liyupi">程序员鱼皮</a>
 * @from <a href="https://yupi.icu">编程导航知识星球</a>
 */
public enum QuestionSubmitLanguageEnum {

    JAVA("java", "java"),
    CPLUSPLUS("c++", "c++"),
    GOLANG("golang", "golang");

    private final String text;

    private final String value;

    QuestionSubmitLanguageEnum(String text, String value) {
        this.text = text;
        this.value = value;
    }

    /**
     * 获取值列表
     *
     * @return
     */
    public static List<String> getValues() {
        return Arrays.stream(values()).map(item -> item.value).collect(Collectors.toList());
    }

    /**
     * 根据 value 获取枚举
     *
     * @param value
     * @return
     */
    public static QuestionSubmitLanguageEnum getEnumByValue(String value) {
        if (ObjectUtils.isEmpty(value)) {
            return null;
        }
        for (QuestionSubmitLanguageEnum anEnum : QuestionSubmitLanguageEnum.values()) {
            if (anEnum.value.equals(value)) {
                return anEnum;
            }
        }
        return null;
    }

    public String getValue() {
        return value;
    }

    public String getText() {
        return text;
    }
}
```

1. 编写一些独立的类，因为以上库表中设计的含有 JSON 字段，为了方便处理 JSON 中的某个字段。

```java
/**
 * 题目用例
 */
@Data
public class JudgeCase {

    /**
     * 输入用例
     */
    private String input;

    /**
     * 输出用例
     */
    private String output;
}
```

1. 校验 Controller 类，解决报错
2. 编写 Service 代码，完成业务逻辑



**小知识：**

**为什么要加上业务前缀（上述代码中的JudgeCase），什么时候不加？**

首先，增加业务前缀有利于增加区分度，防止多表中重复类名产生冲突；

其次，通常情况下，我们希望抽出一个公用类来共享，这时不需加业务前缀。

**什么是 VO 类？有什么用？**

VO：View Object（显示层对象）—— 专门给前端返回、显示的对象，一般会过滤脱敏掉一些不需要返回给前端的字段，保证安全性，不仅更加方便展示给用户，而且方便展示给前端开发者，还可以节约网络传输大小。

DTO：Data Transfer Object（数据传输对象）

BO：Bussiness Object（业务对象）

**怎么防止爬虫爬取题目？有什么简单的方法？**

建议把题目的 id 生成规则 改为 ASSIGN_ID ，这样就可以通过其底层的雪花算法：ASSIGN_UUID 随机生成一个 32 位的 id，有效避免爬虫对题目的爬取。 

示例：

```
/** * id */ @TableId(type = IdType.ASSIGN_ID) private Long id;
```





### 查询提交信息接口（网站的提交信息实时监控面板）

- 功能：

- - 根据用户 ID 查询
  - 题目 ID 查询
  - 编程语言查询
  - 题目状态查询

- 注意事项：

- - 非管理员和本人，不得观看其他用户的代码

- 实现方案：

- - 查询 ==> 根据权限脱敏
  - 

```
@Override public QuestionSubmitVO getQuestionSubmitVO(QuestionSubmit questionSubmit, User loginUser) {    QuestionSubmitVO questionSubmitVO = QuestionSubmitVO.objToVo(questionSubmit);    // 脱敏：仅本人和管理员能看见自己（提交 userId 和登录用户 id 不同）提交的代码    long userId = loginUser.getId();    // 处理脱敏    if (userId != questionSubmit.getUserId() && !userService.isAdmin(loginUser)) {        questionSubmitVO.setCode(null);    }    return questionSubmitVO; }
```



***todo: 熟悉快速 CRUD 的步骤，过项目模板，充分理解；完善更加通用的 Controller、Service 代码。***



## 代码沙箱开发

为了提高代码沙箱的通用性（便于后期进行扩展 AI 判题或者远程判题），

我们定义代码沙箱为接口，这样就便于后期进行扩展了⭐⭐⭐⭐⭐



1. 定义代码沙箱为接口，提高通用性

这样，我们之后的项目判题模块代码只调用代码沙箱的接口进行判题，不用调用实现类，

这样就可以不用更改代码了（之更改调用的接口）

TODO: 代码沙箱的请求接口中，判题的 timeLimit 可以不加，也或者自行扩展（扩展点）

扩展思路：增加一个代码沙箱状态的接口



1. 定义所种不通风的代码沙箱的实现

示例代码沙箱——打通流程

远程代码沙箱——调用实际的接口

第三方代码沙箱——调用网上现成的代码沙箱（例如：goJudge）





完成示例代码沙箱 ---> 改为远程代码沙箱





## 判题服务完整业务流程开发

**判题服务业务流程：**

1. 传入题目的 id ，获取到对应的题目、提交信息（包含代码、编程语言等）
2. 调用沙箱，获取执行结果
3. 根据执行结果，判断 --> 设置题目判题状态与信息

以上是最基本的判题业务流程，但是还不够完整，存在点击多次、多次判题的 Bug，那么就要给判题设置一个状态了！

**完善后的判题服务业务流程：**

1. 传入题目的 id ，获取到对应的题目、提交信息（包含代码、编程语言等）
2. **if （判题状态不为等待中） 抛出异常;**
3. **更改判题状态为判题中**
4. 调用沙箱，获取执行结果
5. 根据代码沙箱执行结果，判断运行结果是否则正确 --> 设置题目最终的判题状态与信息

**判断逻辑：**

1. 先判断，代码沙箱执行的结果输出数量是否和预期输出数量是否一致
2. 依次判断每一项的预期输出是否相等
3. 判题题目的限制是否符合要求
4. 其他异常





注意：

如果我们的代码沙箱执行程序需要十秒钟，这个时间可能根据编程语言的不同而该变动，那么怎么解决？



A：我们可以采取策略模式，针对不同的情况，定义不同的策略
