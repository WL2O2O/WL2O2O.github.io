---
title: 聚合搜索中台
index_img: >-
  https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202309120915504.png
excerpt: >-
  聚合搜索就是输入一个关键字，对于用户可以使用户在同一个入口搜索到不同的内容分类，不同形式的内容，提升用户的检索效率；对于企业来说无需对每一个项目进行搜索功能的开发，当有新的内容或者新的网站，可以进行复用，提高开发效率。后端：Spring
  Boot、MySQL、ES、数据抓取、数据同步（Logstash、Canal）
categories:
  - Project
tags:
  - Vue
  - Ant Design Vue
  - Lodash
  - Spring Boot
  - MySQL
  - ES
abbrlink: 23054
date: 2023-08-01 10:21:14
---

# 聚合搜索项目

## 项目介绍

> 聚合搜索就是输入一个关键字，对于用户可以使用户在同一个入口搜索到不同的内容分类，不同形式的内容，提升用户的检索效率；对于企业来说无需对每一个项目进行搜索功能的开发，当有新的内容或者新的网站，可以进行复用，提高开发效率。

## 技术栈

前端：

* Vue
* Ant Design Vue
* Lodash

后端：

* Spring Boot
* MySQL
* ES
* 数据抓取
* 数据同步（Logstash、Canal）
* Guava Retrying
* 怎么保证API的稳定性？

## 业务流程

1. 先得到不同分类的数据
2. 提供一个搜索页面
3. 业务优化（关键词高亮、防抖节流）

> `package.json`

```
{
  "name": "yuso-frontend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "serve": "vue-cli-service serve",
    "build": "vue-cli-service build",
    "lint": "vue-cli-service lint"
  },
  "dependencies": {
  	// "^4.0.0-rc.5"这个版本不行：Can't resolve 'ant-design-vue/dist/antd.css' 
    "ant-design-vue": "^3.3.0-beta.4",
    "axios": "^1.3.4",
    "core-js": "^3.8.3",
    "vue": "^3.2.13",
    "vue-router": "^4.0.3"
  },
  "devDependencies": {
    "@typescript-eslint/eslint-plugin": "^5.4.0",
    "@typescript-eslint/parser": "^5.4.0",
    "@vue/cli-plugin-babel": "~5.0.0",
    "@vue/cli-plugin-eslint": "~5.0.0",
    "@vue/cli-plugin-router": "~5.0.0",
    "@vue/cli-plugin-typescript": "~5.0.0",
    "@vue/cli-service": "~5.0.0",
    "@vue/eslint-config-typescript": "^9.1.0",
    "eslint": "^7.32.0",
    "eslint-config-prettier": "^8.3.0",
    "eslint-plugin-prettier": "^4.0.0",
    "eslint-plugin-vue": "^8.0.3",
    "prettier": "^2.4.1",
    "typescript": "~4.5.5"
  }
}
```

## `Day01` 开发计划

* 前端初始化
* 后端初始化
* 前端搜索页面开发
* 整合`Axios`
* 后端搜索接口开发



### 前端开发

用URL来记录用户的搜索状态，以便于进行分享。也就是将URL状态与页面状态同步

核心小技巧：把同步状态改成单向的，即只允许URL改变页面状态，不允许反向修改

**步骤分析：**

1. 用户进行页面搜索的时候，URL地址跟着同步改变；
2. 当URL变动时，页面状态也随之改变（监听URL的变动）



### 后端开发

直接套用模板



### 前后端联调

前端整合Axios，自定义Axios实例，完成请求https://www.axios-http.cn/docs/intro

## `Day02`数据分析

### 获取多种不同的数据源

	1. 获取文章（内部）

​	抓取网站的内容，例如抓取文章等。。。

​	**数据抓取的几种方式：**

​		直接访问数据接口（最方便）

​		等网页渲染完毕出明文，从前端内容进行抓取

​		有一种网站是动态请求的，，不会一次加载，例如会用验证码来验证是否是真人（相对复杂，如何解决？后台通过程序控制浏览器，以代替人工继续验证等）selenium、nodejs、puppetter

​		

​		

​	用户（内部）

​	图片（外部，不是我们自己的项目）

2. 前后端接口联调，跑通整个页面（至此完全可以应付毕设）
3. 分析项目的问题，进一步优化，聚合接口的开发
4. 安装ES

> 断更，待完成！！！

