---
title: API开放平台
tags:
  - Ant Design Pro
  - React
  - Ant Design Pro Components
  - Umi
  - Umi Request
  - Spring Boot
  - SDK开发
categories:
  - Project
excerpt: >-
  项目介绍：前端开发的时候有有时会需要后端的接口，如果此时有一个 API 接口可以使用，那么就无需后端接口了。本项目是一个提供 API
  接口调用的平台，用户可以注册与登录，开通接口的调用权限，用户可以使用接口，每次调用会进行次数统计。管理院可以发布接口、下线接口、接入接口，以及可视化接口的调用情况。
abbrlink: c40430e5
date: 2023-06-03 12:34:12
---

# API开放平台

> 写在最前面：
>
> ​	学到的知识与收到的建议：
>
> 	1. 把自己所有的数据库建表语句总结到一起，后续有用；
> 	1. 记录Bug文档
> 	1. 多记录一些需求的解决方案、提高自己的架构能力

## 项目介绍

> 前端开发的时候有有时会需要后端的接口，如果此时有一个API接口可以使用，那么就无需后端借口了

一个提供API接口调用的平台，用户可以注册与登录，开通接口的调用权限，用户可以使用接口，每次调用会进行次数统计。管理院可以发布接口、下线接口、接入接口，以及可视化接口的调用情况。



一个API接口平台：

1. 防止攻击
2. 使用限制
3. 统计调用次数
4. 计费
5. 流量保护
6. API接入

## 预计完成时间

5-6周

## 业务流程

前台、SDK、API网关、模拟接口、后台    共五个子模块

**难点**：思想

## 技术选型

* 前端
  * Ant Design Pro
  * React
  * Ant Design Pro Components
  * Umi
  * Umi Request（Axios的封装）--请求库（前后端联调）
* 后端
  * Spring Boot
  * Spring Boot Stater（SDK开发）--可以发布到maven仓库----**简历亮点**
  * ？？？？？？（网关、限流、日志实现）

## 项目计划

### Day01--项目初始化

项目介绍、设计、技术选型

基础项目的搭建

接口管理

用户查看接口的权限



### Day02--接口调用

1. 继续开发接口管理前端页面 15min
2. 开发模拟API接口 5min
3. 开发调用接口的代码 10-20min
4. 保证调用的安全性（API签名认证） 15min
5. 客户端SDK的开发 15min
6. 管理员接口的发布与调用 15min
7. 接口文档的展示、接口在线调用 15min



### Day03--接口计费与保护

统计用户调用次数

限流

计费

日志

开通

### Day04--管理员统计分析

提供可视化平台，展示所有接口的调用情况，便于管理价格

接口预警





## Day01 需求分析

1. 管理员可以对接口信息进行增删改查

2. 用户可以访问前台，查看接口信息

### 今日计划

1. 项目脚手架搭建（初始化项目）10分钟前端、5-10分钟后端 
1. 管理员可以对接口信息进行增删改查
1. 用户可以访问前台，查看接口的信息









### 项目初始化（前后端）

* ### 前端

1. 使用Ant Design Pro提供的`pro-cli`来快速的初始化脚手架。

   ```bash
   # 查看node和npm版本
   建议16和8
   # 使用 npm
   npm i @ant-design/pro-cli -g
   pro create myapi-frontend
   # 下载项目所需要的依赖
   yarn
   此时可能会遇到node版本要求的问题，因为版本更新迭代的原因，我当时要求的是使用16.14.0的node版本，
   如果感觉切换node版本麻烦的话，这里推荐使用nvm（node的版本管理工具），使用方法自行百度
   ```

2. 项目瘦身

	遇到了一个大坑，星球的球友们也都遇到了，下面是球友的解决方法，亲测有效。

   ```bash
   # 关闭ESLint中与Prettier重复的规则，确保代码格式化的一致性
   yarn add eslint-config-prettier --dev
   # 用于检查和修复JavaScript代码中的常见问题
   yarn add eslint-plugin-unicorn --dev
   ```
### 项目去除国际化存在问题的解决方法

![image-20230630231124235](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307010940465.png)

​	jest脚本命令中有`jest`不知道是否需要删掉，鱼皮的文件中没有出现，可能是跟某些版本有关，奇奇妙妙，记录一下

![image-20230630233743871](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307010940466.png)

* ### 后端

3. 后端项目初始化

​	直接使用鱼总提供的万能模板`springboot-init`,改成项目的名字，然后全局搜索关键字进行替换

​	连接数据库

​	测试运行

4. 数据库库表设计

​	**接口信息表**

```sql
# 数据库初始化
# @author <a href="https://github.com/liyupi">程序员鱼皮</a>
# @from <a href="https://yupi.icu">编程导航知识星球</a>
-- 创建库
create database if not exists myapi;

-- 切换库
use myapi;

-- 用户表
create table if not exists user
(
    id           bigint auto_increment comment 'id' primary key,
    userName     varchar(256)                           null comment '用户昵称',
    userAccount  varchar(256)                           not null comment '账号',
    userAvatar   varchar(1024)                          null comment '用户头像',
    gender       tinyint                                null comment '性别',
    userRole     varchar(256) default 'user'            not null comment '用户角色：user / admin',
    userPassword varchar(512)                           not null comment '密码',
    `accessKey` varchar(512) not null comment 'accessKey',
    `secretKey` varchar(512) not null comment 'secretKey',
    createTime   datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime   datetime     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete     tinyint      default 0                 not null comment '是否删除',
    constraint uni_userAccount
        unique (userAccount)
) comment '用户';

-- 接口信息
create table if not exists myapi.`interface_info`
(
    `id` bigint not null auto_increment comment '主键' primary key,
    `name` varchar(256) not null comment '名称',
    `description` varchar(256) null comment '描述',
    `url` varchar(512) not null comment '接口地址',
    `requestHeader` text null comment '请求头',
    `responseHeader` text null comment '响应头',
    `status` int default 0 not null comment '接口状态（0-关闭，1-开启）',
    `method` varchar(256) not null comment '请求类型',
    `userId` bigint not null comment '创建人',
    `createTime` datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    `updateTime` datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    `isDelete` tinyint default 0 not null comment '是否删除(0-未删, 1-已删)'
) comment  '接口信息';

-- 用户调用接口关系表
create table if not exists myapi.`user_interface_info`
(
    `id` bigint not null auto_increment comment '主键' primary key,
    `userId` bigint not null comment '调用用户 id',
    `interfaceInfoId` bigint not null comment '接口 id',
    `totalNum` int default 0 not null comment '总调用次数',
    `leftNum` int default 0 not null comment '剩余调用次数',
    `status` int default 0 not null comment '0-正常，1-禁用',
    `createTime` datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    `updateTime` datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    `isDelete` tinyint default 0 not null comment '是否删除(0-未删, 1-已删)'
) comment '用户调用接口关系';

insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('许擎宇', '薛聪健', 'www.cary-king.net', '潘博涛', '谭聪健', 0, '石炫明', 9500534531);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('陆弘文', '白志强', 'www.leslee-kuhn.net', '潘懿轩', '马鸿涛', 0, '陈峻熙', 3982575846);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('毛建辉', '罗文', 'www.rosaria-kilback.io', '冯子默', '彭哲瀚', 0, '赵远航', 121776355);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('彭雨泽', '蔡煜祺', 'www.norris-bergstrom.biz', '董思源', '田晓博', 0, '潘擎宇', 740);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('傅志强', '陈梓晨', 'www.jordan-reinger.com', '金志强', '熊锦程', 0, '邓睿渊', 35542559);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('吕黎昕', '孔越彬', 'www.fe-okon.info', '万伟宸', '林昊然', 0, '孟荣轩', 1445);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('夏雪松', '许子骞', 'www.lashawna-legros.co', '蔡昊然', '胡鹏涛', 0, '钟立辉', 34075514);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('严钰轩', '阎志泽', 'www.kay-funk.biz', '莫皓轩', '郭黎昕', 0, '龚天宇', 70956);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('萧嘉懿', '曹熠彤', 'www.margarette-lindgren.biz', '田泽洋', '邓睿渊', 0, '梁志强', 98);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('杜驰', '冯思源', 'www.vashti-auer.org', '黎健柏', '武博文', 0, '李伟宸', 9);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('史金鑫', '蔡鹏涛', 'www.diann-keebler.org', '徐烨霖', '阎建辉', 0, '李烨伟', 125);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('林炫明', '贾旭尧', 'www.dotty-kuvalis.io', '梁雨泽', '龙伟泽', 0, '许智渊', 79998);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('何钰轩', '赖智宸', 'www.andy-adams.net', '崔思淼', '白鸿煊', 0, '邵振家', 7167482751);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('魏志强', '于立诚', 'www.ione-aufderhar.biz', '朱懿轩', '万智渊', 0, '唐昊强', 741098);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('严君浩', '金胤祥', 'www.duane-boyle.org', '雷昊焱', '侯思聪', 0, '郝思', 580514);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('姚皓轩', '金鹏', 'www.lyda-klein.biz', '杜昊强', '邵志泽', 0, '冯鸿涛', 6546);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('廖驰', '沈泽洋', 'www.consuelo-sipes.info', '彭昊然', '邓耀杰', 0, '周彬', 7761037);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('赖智渊', '邓志泽', 'www.emerson-mann.co', '熊明哲', '贺哲瀚', 0, '田鹏', 381422);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('许涛', '陆致远', 'www.vella-ankunding.name', '贾哲瀚', '莫昊焱', 0, '袁越彬', 4218096);
insert into myapi.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('吕峻熙', '沈鹏飞', 'www.shari-reichel.org', '郭鸿煊', '覃烨霖', 0, '熊黎昕', 493);

```



> 留一个小bug，数据库建表语句直接套用的最终建表语句，user表中涉及到两个关于key的字段，手动改成了可以为空，若有问题，后续再做出更改

> 利用`MyBatisX`插件生成接口管理的增删改查代码

将生成的代码逻辑复制到项目的dao、service、mapper包里，

然后还剩一个controller层，直接复制一份模板中的controller层的代码，进行复用

注意此时模糊查询使用的字段不是content，而是description，进行相应的更改。

此时，增删改查操作已完成，就这么简单 

跑通后端

* ### 前端

使用oneapi插件自动生成（openapi规范）

![image-20230701235258820](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307012353984.png)



> 先前，我们登陆时是采用的start假数据进行登录，此时使用dev，登陆页面是存在问题的，因为脚手架自动生成的页面会强制要求登录，此时的登录接口与我们oneapi自动生成的接口对应不上，需要手动进行更改User》》Login》》index.tsx
>

因为没有开发注册页面，可以从注册中心项目中复制一个过来

为了便捷的进行开发，先从swagger注册一个账号，然后登录发现没有进行跳转，通过分析得出，是因为前端没有记录用户的登录状态，所以要进一步进行完善，在typings.d.ts中进行定义全局登录态



改造页面，将前端展示的表格，用来展示自己的数据





## Day02 接口调用开发（前端）

> 首先发现一个问题，使用后端swagger进行user密码更改的时候，密码没有进行加密，会导致前端进行校验的时候返回用户名或者密码不正确的信息

* ### 优化前端展示页面（改路由，先不删）

  * 保持前后端组件名一致
  * 优化页面代码
  * 首页没有页面，后续进行开发一个非管理员用户可以看到的页面
  * 调整导航栏的位置，可以先使用antDesignPro框架提供的切换导航布局小设置
  
* ### 新建模态框的编写真的很搞心态，最后的原因竟然是因为一个小的错误（静下心来）（血泪教训，做完项目过一遍react）

* ### 完善修改框

  * 此处设计到React的核心知识点，也是重中之重（useEffect、useRef）

  * ```tsx
    const formRef = useRef<ProFormInstance>();
    
    useEffect(() => {
      if(formRef){
        formRef.current?.setFieldsValue(values);
      } 
    }, [values])
    
    return (
        <Modal visible={visible} footer={null} onCancel={() => onCancel?.()}>
          <ProTable
            type="form"
            columns={columns}
            // 因为这里使用的form组件，只会初始化一次，所以会造成点击修改按钮进行修改的话，数据是不会变的
            // form={{
            //   initialValues: values
            // }}
            
            // 所以此处用到了监听
            formRef={formRef}
            
            onSubmit={async (value) => {
              onSubmit?.(value);
            }}
          />
        </Modal>
      );
    ```

  * > 此处有Bug，后端报空指针


* ### 完善删除框

  * 仿照以上步骤完成

  * > 此时发现进行相关操作之后数据不会自动更新，所以我们引入actionRef，它可以拿到proTable的控制权，使用actionRef.current?.reload()





### 模拟接口项目（smartapi-interface）（后端）

提供三个模拟接口

1. GET接口
2. POST接口（url传参）
3. POST接口（Restful）





### 开始开发模拟接口项目部分

采用创建几个controller控制层小接口，前端传参进行调用，但是这样不符合逻辑，所以我们要通过后端来进行传参！



### 开发调用接口

几种HTTP调用方式

	1. HttpClient
	1. RestTemplete
	1. 工具（OKHttp、HuTool）

这里我们使用HuTool来进行调用[HuTool](https://hutool.cn/docs/#/)



参考文档是一个好东西，利用好



那么现在已经开发好调用接口了，但是用户调用你的接口，或者黑客黑你的接口，所以需要对调用者进行一个调用限制，那么如何加以限制？

这时可以联想一下我们平时调用第三方接口时，都会有一些key



### API 签名认证（客户端与服务端有点迷惑，后续捋顺）



**本质：**

1. 签发签名

	2. 使用签名(校验签名)



**为什么需要？**

1. 保证安全性，不能随便一个人就可以调用



**怎么实现？（复杂、无序、无规律）**

通过http request header头传递参数。

参数1：assesKey：调用的标识（一串无规则字符串） User A、B

参数2：secretKey：相当于密码

也就是用户名和密钥，区别就是ak、sk是无状态的

在服务端数据库表中新增以上两个字段，用户客户端进行校验。





但是这样的方法时容易被拦截的，不能把密钥直接在服务器之间进行传递，要进行加密。所以要对密码进一步进行加密。



参数3：用户请求参数（更严格）



参数4：sign

加密方式：对称机密、非对称加密、不可解密加密（MD5）



用户参数 + 密钥 ==》 **签名生成算法** ==》不可解密的值

wl + abcdefgh ==》afdasfafszv（通过签名算法加密）

那么如何知道这个签名是否正确？

**服务端会通过用一摸一样的参数和算法去生成签名，只要和用户才能属的签名一致，则正确!**





**怎么防重放？**

参数5：加nonce随机数，保证只能用一次，但是服务端也要保存随机数

参数6：timestamp时间戳（加上时间戳可以保证随机数可以清除）

**API签名认证是一个很灵活的设计，具体要有哪些参数、参数名一定要根据实际场景来（比如userId、appId、version、固定值等）**



思考：难道开发者每次调用接口都需要自己来写签名算法吗？









### 开发一个简单易用的SDK



理想情况：开发者只需要关心调用哪些接口、传递哪些参数，就跟调用自己的代码一样简单。



开发stater的好处：

1. 开发者引入之后，可以直接在application.yml中写配置，自动创建客户端。



### 创建SDK项目（开发starter）（简历亮点）

引入依赖：

1. lombook
2. Spring Configuration Processor（自动生成配置文件写代码的提示）



改造pom依赖，一定要删掉build标签内的代码，因为我们在进行构建依赖包，不是要直接运行的jar的项目





尝试把打好的包发布到maven中









## Day03 接口保护与优化



> 此时，我们发现鱼总的后端项目模块中已经包含前面单独创建好的SDK和interface模拟接口项目了，那么我们如何把这两个添加到后端的项目中呢？
>
> 方案一：
>
> ​	受尚医通项目的影响，我想应该可以通过增加子模块的方法拉进行添加，但是添加之后好像是不太行，跟鱼总的不一样，这种方法应该是可以使多个项目在同一个窗口中打开（解决了之前我的疑虑）
>
> 方案二：
>
> ​	我们看到鱼总的后端项目中，另外两个项目（SDK和interface）是两个目录的标识，于是我就直接复制粘贴到后端项目的文件夹中了，然后Java源文件会变成红J，可以通过右键rsc下main下的Java文件夹，然后mark Directory as--》Sources Root，将Java文件夹标记为源码根目录，如图所示：
>
> ![image-20230708205543307](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307092023528.png)
>
> 然后我们发现maven的pom依赖文件的图标也不对，也通过桐言的方法，右键--》add maven project标记为maven项目，大功告成！

1.开发接口发布/下线的功能（管理员）

2.前端浏览接口，查看 接口文档，申请签名（注册）

3.在线测试（用户）

4.统一用户调用接口次数

5.优化系统-API网关

### 开发接口发布/下线的功能（仅管理员） 

> 此处又涉及到了一个待学知识点：
>
> Spring的AOP切面应用
>
> 可以用来通过注解的方式进行权限管理。

### 后端接口： 

**发布接口**（仅管理员） 

1.校验该接口是否存在

2.判断接口是否可以被调用

​	利用开发好的SDK，通过调用接口看是否能够进行调用的通

​	第一步：启动smartapi-interface项目

​	第二步：在smartapi-backend中引入SDK的依赖

​	第三步：在application.yml中写入ak、sk

​	第四步：在接口中引入客户端的实例

​			@Resource

​			private SmartApiClient smartapiclient

> TODO:
>
> > >  1. 判断接口是否可以调用时，由固定方法名改为可以根据测试地址进行调用
> > >  2. 用户测试接口判断接口是否可以调用时，由固定方法名改为可以根据测试地址进行调用

3.修改数据库接口字段为1

**下线接口**（仅管理员） 

1.校验该接口是否存在

2.修改数据库接口字段为 0

按钮已添加并完善。测试中出现一个经典问题，如图所示：

![image-20230710000821503](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307100008989.png)



> 待办事件：
>
> 流程：
>
> 
>
> **前端**添加上线、下线按钮、√、增加用户浏览页面、查看接口文档、申请签名
>
> **后端**申请签名（更改完善数据库写生成签名的算法）
>
> **前端**
>
> 新增在线调用的按钮
>
> **后端**
>
> 开发在线调用的接口
>
> 







### 前端浏览接口

```react
import { PageContainer } from '@ant-design/pro-components';
import React, {useEffect, useState} from 'react';
import {List, message} from "antd";
import {
  listInterfaceInfoByPageUsingGET
} from "@/services/smartapi-backend/interfaceInfoController";


/**
 * 主页
 * @constructor
 */
const Index: React.FC = () => {

  const [loading, setLoading] = useState(false);
  const [list, setList] = useState<API.InterfaceInfo[]>([]);
  const [total ,setTotal] = useState<number>(0);

  const loadData = async (current=1 , pageSize = 8 ) =>{
    setLoading(true);
    try {
      const res = await listInterfaceInfoByPageUsingGET({
        current,pageSize
      });
      setList(res?.data?.records ?? []);
      setTotal(res?.data?.total ?? 0);

    } catch (error: any) {

      message.error('请求失败,'+error.message);
      return false;
    }
    setLoading(false);
  }
  useEffect(() => {
    loadData();
  },[])


  return (
    <PageContainer title="在线接口开放平台">
      <List
        className="my-list"
        loading={loading}
        itemLayout="horizontal"
        dataSource={list}
        renderItem={item => {

          const apiLink =`/interface_info/${item.id}`;
          return(
            <List.Item
              actions={[<a key={item.id} href={apiLink}>查看</a>]}
            >
              <List.Item.Meta
                title={<a href={apiLink}>{item.name}</a>}
                description={item.description}
              />
            </List.Item>
          )
        }

        }
        pagination ={
          {
            // eslint-disable-next-line @typescript-eslint/no-shadow
            showTotal(total: number){
              return '总数：' +total;
            },
            pageSize: 8,
            total,
            onChange(page,pageSize){
              loadData(page,pageSize);
            }
          }
        }
      />
    </PageContainer>
  );
};

export default Index;
```

### 查看接口文档

```react
import { PageContainer } from '@ant-design/pro-components';
import React, {useEffect, useState} from 'react';
import {Card, Descriptions, message} from "antd";
import {
  getInterfaceInfoByIdUsingGET,

} from "@/services/smartapi-backend/interfaceInfoController";
import { useParams} from "@@/exports";


/**
 * 主页
 * @constructor
 */
const Index: React.FC = () => {

  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<API.InterfaceInfo>();
  const params  = useParams();

  const loadData = async () =>{
    if (!params.id){
      message.error('参数不存在');
      return ;
    }
    setLoading(true);
    try {
      const res = await getInterfaceInfoByIdUsingGET({
        id: Number(params.id)
      });
      setData(res.data);

    } catch (error: any) {

      message.error('请求失败,'+error.message);
      return false;
    }
    setLoading(false);
  }
  useEffect(() => {
    loadData();
  },[])

  return (
    <PageContainer title="查看接口文档">
      <Card>
        {
          data?(
            <Descriptions title={data.name} column={1}>
              <Descriptions.Item label="描述">{data.description}</Descriptions.Item>
              <Descriptions.Item label="接口状态">{data.status? '正常': '关闭'}</Descriptions.Item>
              <Descriptions.Item label="请求地址">{data.url}</Descriptions.Item>
              <Descriptions.Item label="请求方法">{data.method}</Descriptions.Item>
              <Descriptions.Item label="请求头">{data.requestHeader}</Descriptions.Item>
              <Descriptions.Item label="响应头">{data.responseHeader}</Descriptions.Item>
              <Descriptions.Item label="创建时间">{data.createTime}</Descriptions.Item>
              <Descriptions.Item label="更新时间">{data.updateTime}</Descriptions.Item>
            </Descriptions>
          ):(
            <>接口不存在</>
          )}
      </Card>
    </PageContainer>
  );
};

export default Index;
```

### 申请签名（注册） 

通过数据库新增字段、更改用户注册的逻辑（使用DigestUtil加密算法生成ak、sk，然后加入数据库）

> 留一个小作业:
>
> 新增一个小拓展功能：用户可以手动更改自己的ak、sk

### 新建真实数据（前端）

**新建这些真实的数据**

```text
getUsernameByPost,

获取用户名,

http://localhost:8123/name/user,

{”Content-Type“: ”application/json“},

{”Content-Type“: ”application/json“},

```

oh my god，此时发现遗忘了一个重要的请求参数字段，于是通过建表语句、IDEA客户端modify table，来增加这么一个字段。

修改相应的model实体包中的字段信息以及向mybatisplus.xml中添加这个字段。

重启项目---》前端重新使用openai插件生成接口

前端也需要完善修改组件的表单列名，新增一个requestParams

完成！

**完善接口信息的请求参数信息**

**在线调用**

前端界面的编写，通过ant design组件库利用现成的表单组件来完成在线按钮的添加与请求参数的基本表单。

![image-20230710023831281](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307100238354.png)

请求参数的类型（JSON类型）

> 又一个小作业：
>
> 在线调用的扩展点：
>
> 先跑通整个流程，然后根据请求头和请求类型的不同设计不同的表单和界面，增强用户体验



### 后端调用流程

![image-20230710024253445](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307100242406.png)

按照标准的企业开发流程来说：

一定会选择第一种开发方式，不然后期的网关与计费就毫无作用，

第二种方式可以用来自己调用测试。



流程：

1. 前端将用户输入的请求参数与要进行测试的接口id发给平台后端
2. 在调用前进行一些校验
3. 平台后端去调用模拟接口

```Java
/**
     * 测试调用
     *
     * @param interfaceInfoInvokeRequest
     * @param request
     * @return
     */
    @PostMapping("/invoke")
    public BaseResponse<Object> invokeInterfaceInfo(@RequestBody InterfaceInfoInvokeRequest interfaceInfoInvokeRequest,
                                                    HttpServletRequest request) {
        if (interfaceInfoInvokeRequest == null || interfaceInfoInvokeRequest.getId() <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        long id = interfaceInfoInvokeRequest.getId();
        String userRequestParams = interfaceInfoInvokeRequest.getUserRequestParams();
        // 判断是否存在
        InterfaceInfo oldInterfaceInfo = interfaceInfoService.getById(id);
        if (oldInterfaceInfo == null) {
            throw new BusinessException(ErrorCode.NOT_FOUND_ERROR);
        }
        if (oldInterfaceInfo.getStatus() == InterfaceInfoStatusEnum.OFFLINE.getValue()) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "接口已关闭");
        }
        User loginUser = userService.getLoginUser(request);
        String accessKey = loginUser.getAccessKey();
        String secretKey = loginUser.getSecretKey();
        MyClient tempClient = new MyClient(accessKey, secretKey);
        Gson gson = new Gson();
        com.wl.smartapiclientsdk.model.User user = gson.fromJson(userRequestParams, com.wl.smartapiclientsdk.model.User.class);
        String usernameByPost = tempClient.getUserNameByPost(user);
        return ResultUtils.success(usernameByPost);
    }
```

后端调用逻辑已完成

现在继续完善前端的接口，将前端点击调用按钮后改为我们刚才通过后端实现的真实的功能。

```
const onFinish = (values: any) => {
    if (!params.id){
      message.error('接口不存在');
      return ;
    }
    try {
      invokeInterfaceInfoUsingPOST({
        id: params.id,
        ...values
      })
      message.success('请求成功');
      return true;
    } catch (error: any) {
      message.error('请求失败，' + error.message);
    }
  };
```

逻辑打通之后还要进行回显数据：

```
// async 是设置同步的意思

 const onFinish = async (values: any) => {
    if (!params.id){
      message.error('接口不存在');
      return ;
    }
    try {
// 等待

      const res = await invokeInterfaceInfoUsingPOST({
        id: params.id,
        ...values
      })
// 将res.data赋给setInvokeRes

      setInvokeRes(res.data);
      message.success('请求成功');
      return true;
    } catch (error: any) {
      message.error('请求失败，' + error.message);
    }
  };
```

然后在表单处新增一个卡片，用于接收invokeRes进行数据回显。

已完成，测试通过！

并且完善了一个缓冲显示的loading



TODO:

> >  1. 判断接口是否可以调用时，由固定方法名改为可以根据测试地址进行调用
> >  2. 用户测试接口判断接口是否可以调用时，由固定方法名改为可以根据测试地址进行调用
> >  3. 此时任何人调用模拟接口都是可以的，因为我们的SDK是写死在配置文件中的，所以后续再进行完善，从数据库中进行校验！



over！

下面我们的网关用Spring Cloud GateWay实现



## Day04 

1. 开发接口调用次数统计  20min

2. 优化系统的架构---学习架构设计、接触应用场景==>面对一个需求就会自然而然地提高开发效率。 60min

   （怎么把一个项目的架构设计做的更加合理，涉及到API网关的知识）

   * 网关是什么？
   * 网关的作用？
   * 网关的应用场景以及实现？
   * 结合业务去应用网关

### 接口调用次数统计

需求：

	1. 用户每次调用接口成功，次数加1（或者设定一定的调用次数，每次减1）
	1. 给用户分配或者用户自助申请接口调用次数

> 业务流程：
>
> 1. 用户调用接口（之前已完成）
> 2. 修改数据库，调用次数（加1或者减1）

设计库表：

> 哪个用户？哪个接口？
>
> 用户 => 接口（多对多）

用户接口关系表：

```
-- 用户调用接口关系表
create table if not exists smartapi.`user_interface_info`
(
    `id` bigint not null auto_increment comment '主键' primary key,
    `userId` bigint not null comment '调用用户 id',
    `interfaceInfoId` bigint not null comment '接口 id',
    `totalNum` int default 0 not null comment '总调用次数',
    `leftNum` int default 0 not null comment '剩余调用次数',
    `status` int default 0 not null comment '0-正常，1-禁用',
    `createTime` datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    `updateTime` datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    `isDelete` tinyint default 0 not null comment '是否删除(0-未删, 1-已删)'
) comment '用户调用接口关系';
```

### 步骤：

1. 开发基本的增删改查（给管理员使用）

   > 直接使用Mybatis-X生成相关的实体类（注意在删除字段上米娜加上逻辑删除@TableLogic）、mapper、service实现类没然后移动到项目对应的包中。
   >
   > 复制写好的Controller，改那些增删改查！ 完成√

2. 开发用户调用接口次数加1（或者减1）

   问：如果每个接口的方法，都写调用次数 + 1，是不是比较麻烦，如果在本项目中，将这个调用次数+ 1，封装成一个方法，也是可以的，但是`代码侵入性很强！`

   致命问题是：接口开发者需要自己进行调用！

   解决方法：

   1. Spring中的AOP（推荐，是Spring的一个核心特性）
   2. Servelet中的拦截器、过滤器（Fillter）
   3. 通用的方法（缺点：代码侵入性强，需要自己调用）
   4. 网关



简单说一下AOP切面的基本过程：

> 先说一下AOP切面的作用：
>
> 就相当于在接口或者方法调用前或者调用之后帮你做一些事情，其底层的原理就是动态代理。
>
> 使用AOP切面的
>
> 优点：
>
> 独立于接口，在每个接口调用前后加 1
>
> 缺点：
>
> 只存在于单个项目中，如果每个团队都要写一个自己的切面
>
> // TODO：下去看一下AOP的流程，熟悉一下



我们在这个项目中使用网关来实现接口调用次数。

网关就当与在所有接口的入口前加了一层检票口，如图所示：

![image-20230716015231451](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307160152994.png)

因为网关实现的有调用次数的统计，所以开发者可以通关网关来查看，而用户调用接口时直接输入请求参数、请求地址即可。

### 网关：

这里为什么写这么多理论呢？写代码不一定是最重要的，重要的是思想！逻辑思想明白之后，无非就是看文档、百度实现。

> 什么是网关呢？就相当于车票检票口，统一去检票。
>
> 优点？统一去进行一些操作、处理一些问题。
>
> 作用？
>
> 1. 路由
>
> 2. 负载均衡
>
> 3. 统一鉴权
>
> 4. 统一处理跨域
>
> 5. 统一业务处理（缓存）
>
> 6. 访问控制
>
> 7. 发布控制（灰度发布，也就是慢慢控制接口的流量，不断开放给更多用户，然后达到升级接口的目的）
>
> 8. 流量染色（给流量添加一些标识，比如新的请求头信息）
>
> 9. 统一接口保护 
>
>    1. 限制请求
>
>    2. 信息脱敏（网关可以操作你的请求口，进而抹去敏感信息）
>
>    3. 降级（熔断，保险起见，接口下线后，可以返回一些提示信息）
>
>    4. 限流
>
>       （// TODO：学习令牌桶算法，学习露桶算法，学习一下）
>
>    5. RedislimitHandler
>
>    6. 超时时间
>
>    7. 重试（业务保护）
>
> 10. 统一日志
>
> 11. 统一文档（将下游项目的文档统一聚合，展示到一个页面）



### 路由

起到转发的作用，比如有接口A和接口B,网关会记录这些信息，根据用户访问的地址和参数，转发请求到对应的接口（服务器/集群）

用户a调用接口A

/a=>接口A /b=>接口B

https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#gateway-request-predicates-factories

### 负载均衡 

在路由的基础上可以转发到某一个服务器

/c => 服务A/ 集群A（随机转发到其中的某一个机器）

uri从固定地址改成b:xx

### 统一鉴权 

判断用户是否有权限进行操作，无论访问什么接口，我都统一去判断权限，不用重复写

### 统一处理跨域 

网关统一处理跨域，不用在每个项目单独处理

https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#cors-configuration

### 统一业务处理 

把每个项目中都要做的通用逻辑放到上层（网关），统一处理，比如本项目的次数统计

### 访问控制 

黑白名单，比如限制ddos ip

### 发布控制 

灰度发布，比如上线新接口，先给新接口分配 20%流量，老接口80% ,再慢慢调整比例

https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-weight-route-predicate- factory

### 流量染色 

区分用户来源

给请求（流量）添加一些标识，一般是设置请求头中，添加新的请求头 https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-addrequestheader-gatewayfilter-factory

全局染色：https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#default-filters

### 接口保护 

1 限制请求 https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#requestheadersiz-gatewayfilter-factory 

2 信息脱敏 https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-removerequestheader-gatewayfilter-factory 

3 降级（熔断） 进行兜底 https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#fallback-headers 

4 限流 https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-requestratelimiter-gatewayfilter-factory 

5 超时时间   超时就中断 https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#http-timeouts-configuration 

6 重试（业务保护）： https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-retry-gatewayfilter-factory 

### 统一日志 

统一的请求，响应信息记录

### 统一文档 

将下游项目的文档进行聚合，在一个页面统一查看

建议用：https://doc.xiaominfo.com/docs/middleware-sources/,aggregation-introduction


### 网关的分类

1. 全局网关（接入层网关）：作用是负载均衡、请求日志，不和业务逻辑绑定

2. 业务网关（微服务网关：会有一些业务逻辑）：作用是根据不同的请求转发到不同的项目接口

   参考文章：https://blog.csdn.net/qq21040559/article/,details/,122961395

### 实现

1. Nginx（推荐的全局型网关）

2. Kong网关（适合API网关）--收费！！

3. `Spring Cloud Gateway`（取代了Zuul，因为架构设计并不太好，并发量也有限）

   > 优点：用到了NIO、多路复用、底层Netty、React模型；
   >
   > 最大的亮点：可以用Java代码写逻辑，其他网关都需要学习一些其他语言（Nginx需要学到一些Lua脚本）

网关技术选型：https://zhuanlan.zhihu.com/p/500587132

### Spring Cloud Gateway用法

官网是最好的老是去看官网

去看官网：https://spring.io/projects/spring-cloud-gateway

官方文档：https://docs.spring.io/spring-cloud-gateway/docs/current/reference//html/





### 创建一个Gateway项目

小作业：完成官网的小demo（编程式demo）





## Day05 把API网关应用到项目中

任务：

1. 完成统一的用户鉴权、统一的接口调用次数统计（API网关应用）
2. 完善功能



### 将用到的特性

1. 路由（转发请求到模拟接口项目）

2. ~~负载均衡（需要用到注册中心）~~
3. 统一鉴权(accessKey，secretKey)
4. 统一处理跨域
5. 统一业务处理（每次请求接口后，接口调用次数+1）
6. 访问控制（黑白名单）
7. ~~发布控制~~
8. 流量染色(记录请求是否为网关来的)
9. ~~统一接口保护~~ 
   1. 限制请求
   2. 信息脱敏
   3. 降级（熔断）
   4. 限流 学习令牌桶算法，学习露桶算法，学习一下RedislimitHandler
   5. 超时时间
   6. 重试（业务保护）
10. 统一日志(记录每次的请求和响应)
11. ~~统一文档~~



### 业务逻辑

> 为什么会用到API网关？
>
> 结合架构图来说，简单来说也就是加一个检票口，同时也可以添加流量染色、链路追踪的功能、灰度发布等等。。。

1. 用户发送请求到API网关（请求转发）
2. *请求日志*
3. *黑白名单*
4. 用户鉴权（如何？判断ak、sk）
5. 请求的模拟接口是否存在？
6. 请求转发，调用模拟接口
7. 响应日志
8. 调用成功，接口调用次数 + 1
9. 调用失败，返回规范错误码



### 实现

1. **请求转发**

   [使用前缀匹配断言](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-path-route-predicate-factory)

   所有路径为：`/api/**` 的请求转发，转发到http://localhost:8123/api/**

   比如：

   请求于http://localhost:8090/api/name/get?/name=wlei224

   转发到http://localhost:8123/api/name/get?/name=wlei224

```yaml
spring:
  cloud:
    gateway:
      routes:
      - id: path_route
        uri: https://example.org
        predicates:
        - Path=/red/{segment},/blue/{segment}
```

2. 其他业务逻辑

> ​	todo：Spring注解	  @component

​	使用Spring Cloud Gateway中的GlobalFilter实现请求拦截处理（类似于AOP）

​	![image-20230725194819206](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307251948339.png)

​	[GlobalFilter](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#gateway-combined-global-filter-and-gatewayfilter-ordering)直接复制代码到网关项目的全局异常类中。

​	验证通过√

2. 正式开始写业务逻辑

> 1. 用户发送请求到API网关（请求转发）√
>
>    代码能运行到这个controller业务逻辑层，就说明用户已经发送了请求
>
> 2. *请求日志*
>
>    ![image-20230728115938432](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307281159504.png)
>
>    我们发现请求参数中含有一个交换机，于是可以试着从这里找到request请求，拿到请求头中的信息；
>
>    添加`@Slf4j`注解，用log.info在控制台输出请求头日志；
>
> 3. *黑白名单*
>
>    在权限管理业务中一般设置的是白名单，这样只有允许的才可以进行访问，更加安全！
>
>    在IDEA中直接敲`prsf`写一个白名单常量。
>
>    ```Java
>    // 2. 访问控制 -- 设置黑白名单（可以用设置响应状态码来实现）
>    ServerHttpResponse response = exchange.getResponse();
>    if(!IP_WHITE_LIST.contains(sourceAdress)) {
>        // handleNoAuth(response);
>        response.setStatusCode(HttpStatus.FORBIDDEN);
>    	return response.setComplete();
>    }
>    ```
>
>    
>
> 4. 用户鉴权（如何？判断ak、sk）
>
>    ```java
>    //  用户鉴权（如何？判断ak、sk）
>    HttpHeaders headers = request.getHeaders();
>    String accessKey = headers.getFirst("accessKey");
>    String nonce = headers.getFirst("nonce");
>    String timeStamp = headers.getFirst("timeStamp");
>    String sign = headers.getFirst("sign");
>    String body = headers.getFirst("body");
>    // TODO 要去数据库中查询
>    // 为了方便进行校验，直接进行判断数据，正规来说应该从数据库中进行校验数据
>    if (!"wl".equals(accessKey)){
>        // throw new RuntimeException("无权限！");
>        // 封装了一个方法，专门用于处理异常请求
>        return handleNoAuth(response);
>    }
>    if (Long.parseLong(nonce) > 10000L){
>    	return handleNoAuth(response);
>    }
>                                                                                                                   
>    //  时间戳校验自己实现，时间和当前时间不能超过5min
>    Long currentTime = System.currentTimeMillis() / 1000;
>    Long FIVE_MINUTES = 60 * 5L;
>    if ((currentTime-Long.parseLong(timeStamp)) >= FIVE_MINUTES) {
>    	return handleNoAuth(response);
>    }
>                                                                                                                   
>    // TODO 要去数据库中查询
>    String serverSign = SignUtils.getSign(body, "abcdefgh");
>    if (!serverSign.equals(sign)) {
>    	throw new RuntimeException("无权限！");
>    }
>    ```
>
>    
>
> 5. 请求的模拟接口是否存在？
>
>    // TODO 从数据库中进行查询接口是否存在，以及请求方法是否匹配（严格的话可以再校验一下请求参数，但是业务层面的请求参数不建议放到全局请求网关里面）
>    // 因为数据库的访问方法已经再backend中已经写过，操作较为复杂的话不建议重复写，所以我们可以采用远程调用的方式（也就是可以说是微服务，这个项目完全可以写成微服务：`OpenFeigh`，目前项目的定位还是`分布式项目`结合微服务的远程调用，避免重复写业务逻辑）
>
>    
>
> 6. 请求转发，调用模拟接口
>
>    ```java
>    Mono<Void> filter = chain.filter(exchange);
>    ```
>
>    
>
> 7. 响应日志
>
>    ```java
>    log.info("响应：" + response.getStatusCode());
>    ```
>
>    
>
> 8. 调用成功，接口调用次数 + 1
>
>    ```java
>    // TODO invokeCount
>    ```
>
> 9. 调用失败，返回规范错误码
>
>    ```Java
>    // 用户鉴权异常
>        public Mono<Void> handleNoAuth(ServerHttpResponse response) {
>            response.setStatusCode(HttpStatus.FORBIDDEN);
>            return response.setComplete();
>        }
>        // 自定义错误异常
>        public Mono<Void> handleInvokeError(ServerHttpResponse response) {
>            response.setStatusCode(HttpStatus.INTERNAL_SERVER_ERROR);
>            return response.setComplete();
>        }
>    ```
>
>    
>

* 为了方便进行业务逻辑的编写，我们可以向上面一样，将提前编写好的业务流程粘贴到类文件中。



### 测试

通过测试我们发现，通过http://127.0.0.1:8090/api/name/get?name=wl进行访问时，还是会遭到拒绝，为什么呢？此时不是请求头丢失，而是我们根本就没写请求头，跑通这个逻辑的话，可以从前端进行调用测试。

![image-20230803025109861](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202308030251719.png)

### 🧑‍💻业务逻辑预期结果：

等模拟接口调用完成，才记录响应日志、统计调用次数。

### 存在问题：

> 虽然上述代码可以跑通，但是还存在一个问题，我们通过debug模式可以看到，代码在执行到请求转发的`Mono<Void> filter = chain.filter(exchange);`方法后，并没有进入到方法中，反而是继续执行下面的代码，直到`chain.filter`方法之后才进入模拟接口方法中。
>
> `原因：`
>
> chain.filter是个异步操作，可以理解为前端的promise
>
> `解决方案：`
>
> 利用Spring Cloud Gateway提供的自定义响应装饰器中的response装饰者，以次增强原有response的处理能力
>
> 引申：什么叫装饰者设计模式？
>
> ​	作用就是：在原本类的基础上对原有类的能力的增强，也就可以理解为给response买了一件装备，拥有了更多的能力。解释成代码语言意思就是，增写response部分代码，实现需要的功能。
>
> `参考博客：` 
>
> https://blog.csdn.net/qq_19636353/article/details/126759522  (以这个为主) 
>
> `其他参考：` 
>
> https://blog.csdn.net/m0_67595943/article/details/124667975 
>
> https://blog.csdn.net/weixin_43933728/article/details/121359727?spm=1001.2014.3001.5501 
>
> https://blog.csdn.net/zx156955/article/details/121670681 https://blog.csdn.net/qq_39529562/article/details/108911983

```java
public Mono<Void> handleResponse(ServerWebExchange exchange, GatewayFilterChain chain){  

    try {  
        //从交换寄拿响应对象  
        ServerHttpResponse originalResponse = exchange.getResponse();  
        //缓冲区工厂，拿到缓存数据  
        DataBufferFactory bufferFactory = originalResponse.bufferFactory();  
        //拿到响应码  
        HttpStatus statusCode = originalResponse.getStatusCode();  
        if(statusCode == HttpStatus.OK){  
            //装饰，增强能力  
            ServerHttpResponseDecorator decoratedResponse = new ServerHttpResponseDecorator(originalResponse) {  
            //等调用完转发的接口后才会执行
                @Override  
                public Mono<Void> writeWith(Publisher<? extends DataBuffer> body) {  
                    log.info("body instanceof Flux: {}", (body instanceof Flux));  
                    //对象是响应式的  
                    if (body instanceof Flux) {  
                        //我们拿到真正的body  
                        Flux<? extends DataBuffer> fluxBody = Flux.from(body); 
                        //往返回值里面写数据  
                        //拼接字符串  
                        return super.writeWith(fluxBody.map(dataBuffer -> { 
                            // 7. TODO 调用成功，接口调用次数 + 1 invokeCount
                            byte[] content = new byte[dataBuffer.readableByteCount()];  
                            dataBuffer.read(content);  
                            DataBufferUtils.release(dataBuffer);//释放掉内存  
                            // 构建日志  
                            StringBuilder sb2 = new StringBuilder(200);  
                            sb2.append("<--- {} {} \n");  
                            List<Object> rspArgs = new ArrayList<>();  
                            rspArgs.add(originalResponse.getStatusCode());  
                            //rspArgs.add(requestUrl);  
                            String data = new String(content, StandardCharsets.UTF_8);//data 
                            sb2.append(data);  
                            log.info(sb2.toString(), rspArgs.toArray());//log.info("<-- {} {}\n", originalResponse.getStatusCode(), data);  
                           return bufferFactory.wrap(content);  
                        }));  
                    } else {  
                        // 8. 调用失败，fan'hui一个规范的
                        log.error("<--- {} 响应code异常", getStatusCode());  
                    }  
                    return super.writeWith(body);  
                }  
            };  
            //设置 response 对象为装饰过的  
            return chain.filter(exchange.mutate().response(decoratedResponse).build());  
        }  
        return chain.filter(exchange);//降级处理返回数据  
    }catch (Exception e){
        log.error("gateway log exception.\n" + e);  
        return chain.filter(exchange);
    }
}
```

## Day06 完善网关的业务逻辑

### 今日计划

1. 补充完整网关的业务逻辑（如何操作数据库?如何服用之前写过的方法？RPC）
2. 完善系统的TODO和其他功能，并开发一个管理员的监控统计功能



### 网关业务逻辑

问题：之前的项目已经写过了调用数据库的那些mybatis的业务逻辑，复制粘贴太麻烦

解决：用一个可以直接调用的解决方法：RPC



### 如何调用其他项目的方法

1. 复制粘贴代码和相关依赖
2. HTTP请求（提供接口，供其他项目进行调用）
3. jar包调用
4. 把公共代码达成jar包，其他项目直接引用

### HTTP请求怎么调用

1. 提供方开发一个接口（地址、请求方法、参数、返回值）
2. 调用方使用`HTTP Client`之类的代码取发送HTTP请求



### RPC（remote produce call）

**作用：像调用本地方法一样去调用远程方法**

优点：

	1. 对开发者更加透明，减少了调用见的沟通成本
	1. RPC向远程服务器发送请求时，未必要使用HTTP协议，比如：TCP/IP、或者自己封装的协议。（内部服务更加适用）

### `Feign && RPC`

> Feign底层用的HTTP协议，虽然也可以很方便的进行调用，但是区别在于Feign只是让请求过程更加精简,HTTP请求其实可以做到和RPC一样的事情，但是还有区别：RPC向远程服务器发送请求时，未必要使用HTTP协议，比如：TCP/IP、或者自己封装的协议。

HTTP协议是一个7层协议，如果想要接口的性能更高，可以使用TCP/IP协议，更加原生的协议。

一般来说微服务项目内部的接口，用`RPC`的性能可能会更加高一点，协议可选项更加多一点。

`工作流程图：`

![image-20230729232829504](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307292328515.png)

🆗，现在模型已经搭建好了，那么如何进行实现呢？使用Dubbo框架（如何学习？看官方文档）

### Dubbo框架（RPC实现）（阿里公司的）

其它类似的框架还有`GRPC`（Google公司的）、`TRPC`（腾讯公司的）

最好的学习方式：[阅读官方文档！](https://cn.dubbo.apache.org/zh-cn/overview/mannual/java-sdk/quick-start/spring-boot/)



### 两种使用方式

1. Spring Boot代码（注解+编程式）：写Java接口，服务提供者和消费者都去引用这个接口 偏程导

2. IDL(接口调用语言)：创建一个公共的接口定义文件，服务提供者和消费者读取这个文件。

   优点：

   * 跨语言，所有的框架都认识

   * 底层是Triple（自定义封装协议，优点见[官文](https://cn.dubbo.apache.org/zh-cn/overview/mannual/java-sdk/reference-manual/protocol/triple/)）

     ![image-20230730003800623](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307300038465.png)

### 示例项目学习

```
git clone -b master https://github.com/apache/dubbo-samples.git
```

zookeeper注册中心：通过内嵌的方式运行，更方便

最先启动注册中心，先启动服务提供者，再启动服务消费者

### 整合应用

1. 服务提供者：backend

   a. 实际情况应该是去数据库中查是否已分配给用户

   b. 从数据库中查询模拟接口是否存在，以及请求方法是否匹配（还可以校验请求参数）

   c. 调用成功，接口调用次数+1 invokeCount

2. gateway项日作为服务调用者，调用这3个方法



> 整合步骤：
>
> 1. 依赖引入  视频事件：`00:52`
>
>    ```
>                                                                                                                
>    ```
>
>    
>
> 2. 将官方示例代码中的privider包粘到backend中









## Day07 完善网关业务与上线

### 今日计划

1. 完善网关的业务
2. 开发管理员的分析功能
3. 项目上线



### 整合nacos

> 遇到一个`nocos`小BUG：
>
> Dubbo整合nocos的时候，提供者与消费者的包名不一样，这时，提供者将接口的信息注册到nacos文档时，用到的是provider的包名路径，如果出现消费者的包名路径与提供者的包名不同的时候，这时消费者就会报错找不到提供者的Service服务，如图：
>
> ![image-20230731193204173](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307311932647.png)



### 重新梳理网关的业务逻辑

1. 实际情况应该是去数据库中查是否已分配给用户

   a 先根据 accessKey 判断用户是否存在，查到 secretKey
   b 对比 secretKey 和用户传的加密后的 secretKey 是否一致

2. 从数据库中查询模拟接口是否存在，以及请求方法是否匹配（还可以校验请求参数）

3. 调用成功，接口调用次数+1 invokeCount



### 公共服务

> 目的是让方法、实体在多个项目中进行复用，避免重复编写

* 业务分析

  * 1. 数据库中是否已分配给用户密钥（accesskey、secretkey，返回用户信息，为空表示不存在）√
    2. 从数据库中查询模拟接口是否存在（请求路径、请求方法、请求参数，返回接口信息，为空表示不存在）
    3. 接口调用次数 + 1 `invokeCount`（ak、sk、请求接口路径）√




* 使用步骤：
  * 1. 新建干净的 maven 项目，只保留必要的公共依赖
  
  * 2. 抽取 service 和实体类
  
  * 3. install 本地 maven 包
  
  * 4. 让服务提供者引入 common 包，测试是否正常运行（出现Bug，backend包中的实现类一直报错：
  
       > `'getBaseMapper()' in 'com.baomidou.mybatisplus.extension.service.impl.ServiceImpl' clashes with 'getBaseMapper()' in 'com.baomidou.mybatisplus.extension.service.IService'; attempting to use incompatible return type`
       >
       > 原因是`UserInterfaceInfoMapper`类中，忘记更改引入的实体类路径。
       >
       > 小技巧：![image-20230803051309362](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202308030513641.png)
       >
       > 可以通过这种方式快速实现外部提供的的接口。
  
  * 5. 让服务消费者引入 common 包

* 业务流程

  * 1. 新建干净的 maven 项目，只保留必要的公共依赖

  * 2. 抽取 service 和实体类

  * 3. install 本地 maven 包
  
  * 4. 让服务提供者引入 common 包，测试是否正常运行，加上@DubboService，以便供其它类使用

    ```java
    // mybatisplus真好用！业务crud手到擒来！
    /**
     * @author WLei224
     * @create 2023/8/3 5:15
     */
    public class InnerInterfaceInfoServiceImpl implements InnerInterfaceInfoService {
        @Resource
        private InterfaceInfoMapper interfaceInfoMapper;
        @Override
        public InterfaceInfo getInterfaceInfo(String url, String method) {
            if (StringUtils.isAnyBlank(url,method)){
                throw new BusinessException(ErrorCode.PARAMS_ERROR);
            }
            QueryWrapper<InterfaceInfo> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("url",url);
            queryWrapper.eq("method",method);
            return interfaceInfoMapper.selectOne(queryWrapper);
        }
    }
    ```

   * 5. 让服务消费者引入 common 包
  
     > 1. API网关项目中引入 common 依赖
     >
     > 2. 使用服务提供者提供的服务（@DubboService和@DubboReference）
     >
     >    通过@DubboReference注入公共模块中编写好的三个服务
     >
     > 3. 完善网关中的todo标签，完善业务逻辑
  
  ### 问题
  
  ​	项目调试中存在一个问题：需要手动对接口的调用次数进行分配，这里考虑可以增加一个管理调用次数的接口。

### 统计分析功能

#### 需求

各个接口的总调用次数的占比图（饼图），取调用次数最多的三个接口，从而进行分析出哪个接口还没有人进行调用，进而对其降低资源或者下线，高频接口（增加资源、提高收费）

#### 实现

* **前端**

  * 强烈推荐使用现成的库

    * Echarts：https://echarts.apache.org/zh/index.html（推荐）

    * AntV：https://antv.vision/zh（推荐）

    * BizCharts

    * 如果是 React 项目，用这个库：https://github.com/hustcc/echarts-for-react

    * > 怎么用？
      >
      > 1. 看官网
      > 2. 找到快速入门、按文档去引入库
      > 3. 进入示例页面
      > 4. 找到你要的图
      > 5. 在线调试
      > 6. 复制代码
      > 7. 改为真实数据

* **后端**

  * 写一个接口，得到下列示例数据：
    接口 A：2次
    接口 B：3次

  * 步骤：

    1. SQL 查询调用数据：

       ```sql
       select interfaceInfoId, sum(totalNum) as totalNum from user_interface_info group by interfaceInfoId order by totalNum desc limit 3;
       ```

    2. 业务层去关联查询接口信息。
    
       `controller`:（就不写Service了，直接写业务逻辑）
    
       ```java
       /**
        * 分析控制器
        * @author yupi
        */
       @RestController
       @RequestMapping("/analysis")
       @Slf4j
       public class AnalysisController {
       
           @Resource
           private UserInterfaceInfoMapper userInterfaceInfoMapper;
       
           @Resource
           private InterfaceInfoService interfaceInfoService;
       
           @GetMapping("/top/interface/invoke")
           @AuthCheck(mustRole = "admin")
           public BaseResponse<List<InterfaceInfoVO>> listTopInvokeInterfaceInfo() {
               List<UserInterfaceInfo> userInterfaceInfoList = userInterfaceInfoMapper.listTopInvokeInterfaceInfo(3);
       
               Map<Long, List<UserInterfaceInfo>> interfaceInfoIdObjMap = userInterfaceInfoList.stream()
                       .collect(Collectors.groupingBy(UserInterfaceInfo::getInterfaceInfoId));
       
               QueryWrapper<InterfaceInfo> queryWrapper = new QueryWrapper<>();
               queryWrapper.in("id", interfaceInfoIdObjMap.keySet());
               List<InterfaceInfo> list = interfaceInfoService.list(queryWrapper);
       
               if (CollectionUtils.isEmpty(list)) {
                   throw new BusinessException(ErrorCode.SYSTEM_ERROR);
               }
               List<InterfaceInfoVO> interfaceInfoVOList = list.stream().map(interfaceInfo -> {
                   InterfaceInfoVO interfaceInfoVO = new InterfaceInfoVO();
                   BeanUtils.copyProperties(interfaceInfo, interfaceInfoVO);
                   int totalNum = interfaceInfoIdObjMap.get(interfaceInfo.getId()).get(0).getTotalNum();
                   interfaceInfoVO.setTotalNum(totalNum);
                   return interfaceInfoVO;
               }).collect(Collectors.toList());
               return ResultUtils.success(interfaceInfoVOList);
           }
       }
       ```
    
       `封装类`：
    
       ```java
       /**
        * 接口信息封装视图
        * @TableName product
        */
       @EqualsAndHashCode(callSuper = true)
       @Data
       public class InterfaceInfoVO extends InterfaceInfo {
       
           /**
            * 调用次数
            */
           private Integer totalNum;
       
           private static final long serialVersionUID = 1L;
       }
       ```
    
       `UserInterfaceInfoMapper`:
    
       ```java
       /**
        * @Entity com.wl.smartapicommon.model.entity.UserInterfaceInfo
        */
       public interface UserInterfaceInfoMapper extends BaseMapper<UserInterfaceInfo> {
       
           // 获取前几个调用次数最多的接口
           List<UserInterfaceInfo> listTopInvokeInterfaceInfo(int limit);
       
       }
       ```
    
       `xml中添加sql语句`：
    
       ```xml
       <select id="listTopInvokeInterfaceInfo" resultType="com.wl.smartapicommon.model.entity.UserInterfaceInfo">
           select interfaceInfoId, sum(totalNum) as totalNum
           from user_interface_info
           group by interfaceInfoId
           order by totalNum
           desc limit #{limit};
       </select>
       ```
    

## 上线计划

* 前端：参考之前用户中心或伙伴匹配系统的上线方式
* 后端：
  * backend 项目：web 项目，部署 spring boot 的 jar 包（对外的）
  * gateway 网关项目：web 项目，部署 spring boot 的 jar 包（对外的）
  * interface 模拟接口项目：web 项目，部署 spring boot 的 jar 包（不建议对外暴露的）

***关键：网络必须要连通***

>如果自己学习用：单个服务器部署这三个项目就足够。
>如果你是搞大事，多个服务器建议在 同一内网 ，内网交互会更快、且更安全。



#### 上线环境准备

1. docker安装

   ```shell
   curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
   systemctl start docker 
   systemctl enable docker
   systenctl restart docker
   ```

2. 宝塔面板

   ```shell
   # 安装命令
   yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && sh install.sh
   # 卸载命令
   systemct stop bt
   rm -rf /www/server/panel
   rm -f /etc/init.d/bt
   
   rm -rf /root/.pyenv/versions/3.7.0/envs/btpanel/lib/python3.7/site-packages/pycache
   rm -rf /root/.pyenv/versions/3.7.0/envs/btpanel/lib/python3.7/site-packages/btpanel/__pycache__
   rm -rf /root/.pyenv/versions/3.7.0/envs/btpanel/lib/python3.7/site-packages/panelApp/__pycache__
   
   rm -rf /www/server/panel/logs/*
   ```

3. [Docker 安装 Nginx](https://blog.csdn.net/u010148813/article/details/126172372)

   ```shell
   # 拉取官方的最新版本的镜像
   $ docker pull nginx
   
   # 使用以下命令来运行 nginx 容器
   $ docker run --name nginx -p 80:80 -d nginx
   
   # 在宿主机家目录创建用于放配置文件的文件夹
   $ mkdir -p /root/docker-nginx/{conf,html,logs}
   
   # 从容器nginx中复制nginx.conf文件到宿主机
   $ docker cp nginx:/etc/nginx/nginx.conf /root/docker-nginx       
   $ docker cp nginx:/etc/nginx/conf.d/default.conf /root/docker-nginx/conf/
   $ docker cp nginx:/usr/share/nginx/html/ /root/docker-nginx/
   
   
   ----------------------------------------------
   说明：
   宿主机：就是你的云服务器或者虚拟机。
   ~ 目录，也就是我们常说的家目录/home/your_username.(如果是云服务器，且没有创建普通用户，那么家目录就是 /root 了，也就是我们说的管理员用户，拥有最高权限，所以命令就不用加上 sudo 了)
   
   刚才的操作是把你在docker中拉取的 Nginx 的镜像配置文件复制了一份到家目录，这样可以便于后续对 nginx 的配置，say Why?，因为我们接下来会通过映射，将我们复制到宿主机的配置文件直接映射到 docker 容器中的 Nginx 中，是不是很方便，下次若需要配置，就可以直接在宿主机中进行配置了，否则还需要通过 `$ docker exec -it nginx bash` 命令进入到 Nginx 的镜像之中。
   ```
   
   
   
   - 打包一下复制好的配置文件（备份，以免操作失误可补救）
   
   ```shell
   # 删掉 nginx 容器
   $ docker stop nginx
   $ docker rm nginx
   
   # 重新运行容器，并加上配置文件的映射
   $ docker run -p 80:80 \
   -v /root/docker-nginx/nginx.conf:/etc/nginx/nginx.conf \
   -v /root/docker-nginx/logs:/var/log/nginx \
   -v /root/docker-nginx/html:/usr/share/nginx/html \
   -v /root/docker-nginx/conf:/etc/nginx/conf.d \
   --name nginx \
   --privileged=true \
   --restart=always \
   -d nginx
   
   ----------------------------------------------
   终于完成！如遇到403或者无法访问此网站等其他问题，首先去你购买的云服务器的安全组新增 80 端口，如果你开了代理，试着重启或者注销电脑。
   参考链接：https://blog.csdn.net/l123lgx/article/details/122619851
   
   server {
       listen 80;
       server_name localhost;
       #charset koi8-r;
       #access_log logs/host.access.log main;
       location / {
           root html;
           index index.html index.htm;
   	}
       #error_page 404 /404.html;
       # redirect server error pages to the static page /50x.html
       #
       error_page 500 502 503 504 /50x.html;
       location = /50x.html {
       	root html;
       }
       # proxy the PHP scripts to Apache listening on 127.0.0.1:80
       #
       #location ~ \.php$ {
       # proxy_pass http://127.0.0.1;
       #}
       # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
       #
       #location ~ \.php$ {
       # root html;
       # fastcgi_pass 127.0.0.1:9000;
       # fastcgi_index index.php;
       # fastcgi_param SCRIPT_FILENAME /scripts$fastcgi_script_name;
       # include fastcgi_params;
       #}
       # deny access to .htaccess files, if Apache's document root
       # concurs with nginx's one
       #
       #location ~ /\.ht {
       # deny all;
       #}
   }
       # another virtual host using mix of IP-, name-, and port-based configuration
       #
       #server {
       # listen 8000;
       # listen somename:8080;
       # server_name somename alias another.alias;
       # location / {
       # root html;
       # index index.html index.htm;
       # }
       #}
       # HTTPS server
       #
       #server {
       # listen 443 ssl;
       # server_name localhost;
       # ssl_certificate cert.pem;
       # ssl_certificate_key cert.key;
       # ssl_session_cache shared:SSL:1m;
       # ssl_session_timeout 5m;
       # ssl_ciphers HIGH:!aNULL:!MD5;
       # ssl_prefer_server_ciphers on;
       # location / {
       # root html;
       # index index.html index.htm;
       # }
       #}
   
   ```
   
   复习一下`tar`命令的用法：
   
   <img src="https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308260050797.png" alt="image-20230826005051120" style="zoom:50%;" />
   
   解压的话亦是同理：
   
   > 解压 tar 存档文件的常用命令是 `tar -xzvf`。下面是对这些参数的解释：
   >
   > - `-x`：表示从存档文件中提取（解压）文件。
   > - `-z`：表示使用 gzip 压缩算法进行解压缩。使用此参数可以解压被 gzip 压缩的 tar 存档文件。
   > - `-v`：表示在命令执行过程中显示详细信息，即显示提取的文件列表。
   > - `-f`：指定要提取的存档文件的名称。紧跟在 `-f` 参数后面的是存档文件的名称。
   
   4. `docker`安装`MySQL`
   
      ```shell
      docker pull mysql
      
      # 在宿主机家目录创建用于放配置文件的文件夹
      $ mkdir -p /root/docker-mysql/{conf,data,log}
      
      # 在配置文件目录:/root/docker-mysql/conf新建一个my.cnf配置文件，写入下面内容，设置客户端和mysql服务器端编码都为utf8
      [client]
      default_character_set=utf8
      [mysqld]
      collation_server=utf8_general_ci
      character_set_server=utf8
      
      docker run -p 3306:3306 \
      --privileged=true \
      -v /root/docker-mysql/log:/var/log/mysql \
      -v /root/docker-mysql/data:/var/lib/mysql \
      -v /root/docker-mysql/conf:/etc/mysql/conf.d \
      -e MYSQL_ROOT_PASSWORD=你的MySQL密码 \
      --name mysql \
      -d mysql
      
      docker exec -it mysql bash
      
      mysql -u root -p
      
      如果遇到`Navicat`连接不上的问题，请看下面的链接。
      ```
   
      记录一个大坑，宝塔面板添加3306端口号，被腾讯云服务器拦截了，无语了，还是通过云服务器控制台（推荐✨）或者防火墙命令来添加端口吧。
   
      参考链接：https://www.cnblogs.com/--eric/p/17145834.html
   
   
   
   5. `JDK`安装
   
      ```shell
      # yum 安装免环境变量的配置
      $ yum install -y java-1.8.0-openjdk*
      ```
   
   6. `maven`安装
   
      ```shell
      通过以下命令获取安装包或者通过本地浏览器下载到主机，然后通过 ftp 传输到 Linux 服务器
      curl -O https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz
      
      tar -zxvf apache-maven-3.8.8-bin.tar.gz
      
      vim /etc/profile
      
      文件空白处增加两行内容：
      export MAVEN_HOME=/root/services/apache-maven-3.8.8
      export PATH=$MAVEN_HOME/bin:$PATH
      
      source /etc/profile
      
      mvn --version
      
      ```
   
      
   
   7. `redis`安装
   
      ```shell
      docker pull redis
      
      mkdir -p /root/docker-redis/conf
      
      # 入redis配置文件夹
      cd /root/docker-redis/conf  
      
      # 下载redis配置文件
      wget http://download.redis.io/redis-stable/redis.conf   
      
      vim redis.conf  // 修改配置文件
      1. appendonly yes    启动Redis持久化功能 (默认 no , 所有信息都存储在内存 [重启丢失] 。设置为 yes , 将存储在硬盘 [重启还在])
      2. protected-mode no    关闭protected-mode模式，此时外部网络可以直接访问
      3. bind 0.0.0.0    设置所有IP都可以访问
      4. requirepass 密码    设置密码
      如果你设置了密码,需要通过如下命令进入Redis控制台
      ## 进入Redis容器
              docker exec -it redis bash
      ## 通过密码进入Redis控制台
              redis-cli -h 127.0.0.1 -p 6379 -a [你的密码]
              
      mkdir -p /root/docker-redis/data
      
      docker run -p 6379:6379 \
      -v /root/docker-redis/conf/redis.conf:/etc/redis/redis.conf \
      -v /root/docker-redis/data:/data \
      -e REDIS_ROOT_PASSWORD=你的Redis密码 \
      --restart=always \
      --name redis \
      -d redis
      
      
      不要忘记打开防火墙6379端口，通过宝塔面板或者命令，或者云服务器控制台
      ```
   
      
   
   8. `nacos`安装
   
      ```shell
      docker pull nacos/nacos-server
      
      # 在宿主机家目录创建用于放配置文件的文件夹
      $ mkdir -p /root/docker-nacos/nacos/{init.d,logs}
      
      vim /root/docker-nacos/nacos/init.d/application.properties 
      
      server.contextPath=/nacos
      server.servlet.contextPath=/nacos
      server.port=8848
       
      spring.datasource.platform=mysql
      db.num=1
      db.url.0=jdbc:mysql://xx.xx.xx.x:3306/nacos_devtest_prod?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true
      db.user=user
      db.password=pass
       
      nacos.cmdb.dumpTaskInterval=3600
      nacos.cmdb.eventTaskInterval=10
      nacos.cmdb.labelTaskInterval=300
      nacos.cmdb.loadDataAtStart=false
      management.metrics.export.elastic.enabled=false
      management.metrics.export.influx.enabled=false
      server.tomcat.accesslog.enabled=true
      server.tomcat.accesslog.pattern=%h %l %u %t "%r" %s %b %D %{User-Agent}i
      nacos.security.ignore.urls=/,/**/*.css,/**/*.js,/**/*.html,/**/*.map,/**/*.svg,/**/*.png,/**/*.ico,/console-fe/public/**,/v1/auth/login,/v1/console/health/**,/v1/cs/**,/v1/ns/**,/v1/cmdb/**,/actuator/**,/v1/console/server/**
      nacos.naming.distro.taskDispatchThreadCount=1
      nacos.naming.distro.taskDispatchPeriod=200
      nacos.naming.distro.batchSyncKeyCount=1000
      nacos.naming.distro.initDataRatio=0.9
      nacos.naming.distro.syncRetryDelay=5000
      nacos.naming.data.warmup=true
      nacos.naming.expireInstance=true
      
      
      docker run -p 8848:8848 \
      -e JVM_XMS=256m \
      -e JVM_XMX=256m \
      -e MODE=standalone \
      -e PREFER_HOST_MODE=hostname \
      -v /root/docker-nacos/nacos/logs:/home/nacos/logs \
      -v /root/docker-nacos/nacos/init.d/application.properties:/home/nacos/init.d/application.properties \
      --name nacos \
      --privileged=true \
      --restart=always \
      -d nacos/nacos-server
      ```
   
      参考链接：https://blog.csdn.net/yexiaomodemo/article/details/123355202
   
      
   
   9. `rabbitmq`安装
   
      ```shell
      docker pull rabbitmq
      
      docker run -p 5672:5672 -p 15672:15672 \
      -v /root/docker-rabbitmq/config/:/etc/rabbitmq/ \
      -e RABBITMQ_DEFAULT_USER=admin \
      -e RABBITMQ_DEFAULT_PASS=admin \
      --hostname myRabbit \
      --name rabbitmq \
      --restart=always \
      -d rabbitmq
      
      docker exec -it rabbitmq bash
      
      # 启动可视化插件
      rabbitmq-plugins enable rabbitmq_management
      
      使用浏览器打开web管理端：http://Server-IP:15672 
      ```
   

  	参考链接：

​	  https://blog.csdn.net/qq_42977003/article/details/128107521
​	  https://blog.csdn.net/feritylamb/article/details/128434465

#### 一、原始部署

​	缺点：需要一个个配置环境，安装必须软件

#### 二、宝塔面板部署

​	优点：可视化安装与配置

#### 三、docker部署

> Docker是一种开源的容器化平台，用于构建、发布和运行应用程序。通过使用Docker，您可以将应用程序及其依赖项打包到一个称为容器的独立单元中，以便在任何环境中运行，而无需担心环境差异或依赖问题。
>
> 以下是一些与Docker相关的常用概念和命令：
>
> 1. 镜像（Image）：镜像是Docker容器的基础，它包含了运行应用程序所需的一切，包括代码、运行时环境、库和依赖项。您可以通过构建自定义镜像或从Docker Hub等镜像仓库中获取现有的镜像。
> 2. 容器（Container）：容器是基于镜像创建的运行实例，它是一个独立、隔离的执行环境。容器可以启动、停止、重启和删除，每个容器都具有自己的文件系统、进程空间和网络接口。
> 3. Dockerfile：Dockerfile是用于定义镜像构建过程的文本文件。它包含一系列指令，用于指定基础镜像、安装软件、复制文件、设置环境变量等。
> 4. Docker Compose：Docker Compose是一个用于定义和运行多个容器应用的工具。它使用一个YAML文件来定义各个服务及其依赖关系，并可以一键启动、停止和管理整个应用程序的容器群。
>
> 一些常用的Docker命令包括：
>
> - `docker build`：根据Dockerfile构建镜像。
> - `docker run`：创建并运行一个新的容器。
> - `docker stop`：停止一个正在运行的容器。
> - `docker start`：启动已经停止的容器。
> - `docker rm`：删除一个或多个容器。
> - `docker images`：列出本地已下载的镜像。
> - `docker pull`：从镜像仓库下载镜像。
> - `docker push`：将本地镜像推送到镜像仓库。
>
> 这只是Docker的一小部分功能和命令，Docker还提供了许多其他功能，如网络配置、数据卷、容器编排等。如果您想更深入了解Docker的使用，请参考官方文档或相关教程。
>
> 
>
> docker如何打包一个镜像，命令是什么?
>
> 
>
> 要打包一个Docker镜像，您需要编写一个Dockerfile，其中包含构建镜像所需的指令和配置。然后，使用`docker build`命令来构建镜像。以下是基本的步骤和相应的命令：
>
> 1. 创建一个Dockerfile：在您的项目目录中创建一个名为`Dockerfile`的文本文件，可以使用任何文本编辑器打开并编辑它。
>
> 2. 在Dockerfile中定义镜像构建过程：Dockerfile包含一系列指令，用于指定基础镜像、安装软件、复制文件、设置环境变量等。根据您的应用程序需求，编写适当的指令。
>
>    以下是一个简单的Dockerfile示例：
>
>    ```dockerfile
>    # 使用官方的 Node.js 作为基础镜像
>    FROM node:14
>
>    # 设置工作目录
>    WORKDIR /app
>
>    # 复制应用程序代码到容器中
>    COPY . .
>
>    # 安装应用程序依赖
>    RUN npm install
>
>    # 暴露应用程序的端口
>    EXPOSE 3000
>
>    # 定义启动容器时运行的命令
>    CMD ["npm", "start"]
>
>    这个示例中，我们使用了官方的Node.js 14镜像作为基础镜像，将应用程序代码复制到容器中，安装依赖项，暴露端口3000，并在容器启动时运行`npm start`命令。
>    ```
>
> 3. 构建镜像：在终端中，切换到包含Dockerfile的目录，并运行以下命令来构建镜像：
>
>    ```
>    docker build -t image_name:tag .
>    ```
>
>    - `-t`参数用于指定镜像的名称和标签。您可以根据需要自定义名称和标签。
>    - `.`表示Dockerfile所在的当前目录。确保在运行命令之前，您已经切换到正确的目录。
>
>    例如，要构建一个名为`myapp`的镜像，标签为`v1.0`，可以运行以下命令：
>
>    ```
>    docker build -t myapp:v1.0 .
>    ```
>
> 4. 等待构建完成：Docker将执行Dockerfile中的每个指令，并构建镜像。这可能需要一些时间，取决于您的镜像大小和复杂性。
>
> 5. 查看构建的镜像：构建完成后，可以使用以下命令查看本地的镜像列表：
>
>    ```
>    docker images
>    ```
>
>    您将看到刚刚构建的镜像以及其名称、标签和大小等信息。
>
> 通过以上步骤，您就可以使用Dockerfile和`docker build`命令来打包构建自己的Docker镜像。请根据您的应用程序需求和环境配置适当地编辑Dockerfile。

##### 前端部署例子：

`dockerfile`文件：

```dockerfile
FROM nginx

WORKDIR /usr/share/nginx/html/
USER root

COPY ./docker/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./dist  /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

`nginx.conf`文件：

```nginx
server {
    listen 80;

    # gzip config
    gzip on;
    gzip_min_length 1k;
    gzip_comp_level 9;
    gzip_types text/plain text/css text/javascript application/json application/javascript application/x-javascript application/xml;
    gzip_vary on;
    gzip_disable "MSIE [1-6]\.";

    root /usr/share/nginx/html;
    include /etc/nginx/mime.types;

    location / {
        try_files $uri /index.html;
    }

}
```



### 项目扩展思路

1. 用户自己可以申请更换签名

2. 怎么让其他用户也能上传接口？

   > * 需要提供一个机制（一个页面），让用户来输入自己的接口host（都武器的地址）、接口信息、将接口写入数据库；
   > * 可以在interfaceInfo表中加个host字段，以次区分服务器地址，让接口提供者更灵活的接入系统；
   > * 将接口信息入库前，要对接口进行校验，比如检查地址是否遵循规则、是否可以正常调用,并遵循甲方要求（使用SDK）

3. 网关校验是否还有调用次数

   需要考虑并发的问题，防止瞬间调用超频。

4. 网关优化

   比如增加限流、降级保护、提高性能等。还可以考虑搭配Nginx网关使用。

5. 功能增强

   可以针对不同的请求头或者接口类型来设计前端界面和表单，百年与用户进行调用，增强体验。

   （可以参考swagger、postman、kniffj的界面）



## 项目优化

### 扩展思路

 1. 用户可以申请更换签名
 2. 怎么让其他用户也上传接口？ 
需要提供一个机制（界面），让用户输入自己的接口 host（服务器地址）、接口信息，将接口信息写入数据库。
可以在 interfaceInfo 表里加个 host 字段，区分服务器地址，让接口提供者更灵活地接入系统。
将接口信息写入数据库之前，要对接口进行校验（比如检查他的地址是否遵循规则，测试调用），保证他是正常的。
将接口信息写入数据库之前遵循咱们的要求（并且使用咱们的 sdk），
在接入时，平台需要测试调用这个接口，保证他是正常的。
 3. 网关校验是否还有调用次数 
需要考虑并发问题，防止瞬间调用超额。
 4. 网关优化 
比如增加限流 / 降级保护，提高性能等。还可以考虑搭配 Nginx 网关使用。
 5. 功能增强 
可以针对不同的请求头或者接口类型来设计前端界面和表单，便于用户调用，获得更好的体验。
可以参考 swagger、postman、knife4j 的页面。