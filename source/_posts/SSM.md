---
title: 什么是SSM
index_img: >-
  https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202309120923205.png
categories:
  - Java notes
tags:
  - SSM
abbrlink: 14117
date: 2021-12-27 07:14:23
---

# 什么是SSM?
SSM框架是Spring、Spring MVC和MyBatis框架的整合，是标准的MVC模式。它是目前主流的Java EE企业级框架，适用于搭建各种大型的企业级应用系统。SSM框架集由Spring、MyBatis两个开源框架整合而成，其中SpringMVC是Spring中的部分内容。

标准的SSM框架有四层，分别是DAO层（Mapper）、Service层、Controller层和View层。其中，持久层的DAO层（Mapper）主要负责与数据库进行联络的一些任务，如数据持久化等，而Service层提供业务逻辑处理的服务，Controller层负责接收请求并进行处理，View层则负责展示数据。

在SSM框架中，Spring主要用来实现业务对象管理，包括对象的创建和销毁、依赖注入等。MyBatis则作为数据对象的持久化引擎，负责将Java对象映射到数据库表中。Spring MVC则负责请求的转发和视图管理[[0\SSM框架是Spring、Spring MVC和MyBatis框架的整合，是标准的MVC模式。它是目前主流的Java EE企业级框架，适用于搭建各种大型的企业级应用系统。SSM框架集由Spring、MyBatis两个开源框架整合而成，其中SpringMVC是Spring中的部分内容。

标准的SSM框架有四层，分别是DAO层（Mapper）、Service层、Controller层和View层。其中，持久层的DAO层（Mapper）主要负责与数据库进行联络的一些任务，如数据持久化等，而Service层提供业务逻辑处理的服务，Controller层负责接收请求并进行处理，View层则负责展示数据。

在SSM框架中，Spring主要用来实现业务对象管理，包括对象的创建和销毁、依赖注入等。MyBatis则作为数据对象的持久化引擎，负责将Java对象映射到数据库表中。Spring MVC则负责请求的转发和视图管理。

使用SSM框架搭建项目的步骤如下:

1. 搭建整合的环境。
2. 搭建Spring的配置。
3. 使用Spring整合Spring MVC框架。
4. 使用Spring整合MyBatis框架。

SSM框架的优点是易于复用和简化开发，同时也提高了代码的可维护性和可扩展性。使用SSM框架可以让开发人员更加专注于业务逻辑的实现，而无需关注底层的技术实现。

使用SSM框架搭建项目的步骤如下:

1. 搭建整合的环境。
2. 搭建Spring的配置。
3. 使用Spring整合Spring MVC框架。
4. 使用Spring整合MyBatis框架。

SSM框架的优点是易于复用和简化开发，同时也提高了代码的可维护性和可扩展性。使用SSM框架可以让开发人员更加专注于业务逻辑的实现，而无需关注底层的技术实现。