---
title: css
index_img: >-
  https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202309120849257.png
categories:
  - Frontend
tags:
  - CSS
abbrlink: 52116
date: 2021-09-10 12:14:21
---

<div style="background-image: url('https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202308211955549.jpg'); background-position: center center; background-repeat: no-repeat; background-size: cover; padding: 20px; opacity: 0.7; color: purple; line-height: 2; margin-top: 20px; margin-bottom: 20px;font-size: 15px;">    
    <div style="text-align: right; color: purple; line-height: 1.5; font-size: 15px;">
        右对齐<br>
        厉害了<br>
        我是一个html代码段
    </div>
</div>




<!DOCTYPE html>
<html>
<head>
  <title>前端博客</title>
  <style>
    /* 设置整个页面的字体样式为 Arial 或 sans-serif */
    body {
      font-family: Arial, sans-serif;
      /* 设置页面的背景颜色为 #f2f2f2 */
      background-color: #f2f2f2;
      /* 清除页面的默认边距 */
      margin: 0;
      /* 设置页面内容与边框的间距为 20px */
      padding: 20px;
    }
    /* 设置标题文本的颜色为 #333 */
    h1 {
      color: #333;
      /* 设置标题居中对齐 */
      text-align: center;
    }
    /* CSS 样式 */
    .article {
      /* 设置文章容器的背景颜色为 #fff */
      background-color: #fff;
      /* 设置文章容器的边框为 1px 实线，颜色为 #ccc */
      border: 1px solid #ccc;
      /* 设置文章容器的圆角边框为 5px */
      border-radius: 5px;
      /* 设置文章容器的内边距为 20px */
      padding: 20px;
      /* 设置文章容器与下方元素的间距为 20px */
      margin-bottom: 20px;
    }
    /* 设置文章标题文本的颜色为 #555 */
    .article h2 {
      color: #555;
    }
    /* 设置文章段落文本的颜色为 #777，行高为 1.5 */
    .article p {
      color: #777;
      line-height: 1.5;
    }
    /* 设置作者文本的颜色为 #888，字体大小为 12px */
    .article .author {
      color: #888;
      font-size: 12px;
    }
  </style>
</head>
<body>
  <!-- 页面标题 -->
  <h1>前端博客</h1>
  <div class="article">
    <!-- 文章标题 -->
    <h2>如何学习前端开发</h2>
    <!-- 文章段落 -->
    <p>前端开发是构建用户界面的过程，它涉及 HTML、CSS 和 JavaScript 的使用。要学习前端开发，你可以按照以下步骤进行：</p>
    <ol>
      <!-- 有序列表 -->
      <li>学习 HTML：HTML 是用于创建网页结构的标记语言。</li>
      <li>掌握 CSS：CSS 用于为网页添加样式和布局。</li>
      <li>深入学习 JavaScript：JavaScript 为网页添加交互和动态功能。</li>
    </ol>
    <!-- 文章作者 -->
    <p class="author">作者：CSGUIDER</p>
  </div>
  <div class="article">
    <h2>CSS 基础入门</h2>
    <p>CSS 是层叠样式表的缩写，它用于为 HTML 元素添加样式。以下是一些 CSS 的基础概念：</p>
    <ul>
      <!-- 无序列表 -->
      <li>选择器：用于选择要应用样式的 HTML 元素。</li>
      <li>属性：用于定义元素的样式，如颜色、字体大小、边框等。</li>
      <li>盒模型：指元素的内容、内边距、边框和外边距的组合。</li>
    </ul>
    <!-- 文章作者 -->
    <p class="author">作者：CSGUIDER</p>
  </div>
</body>
</html>



<!DOCTYPE html>
<html>
<head>
  <title>My Page</title>
  <style>
      .container {
      width: 100%;
      /* 清除浮动 */
      overflow: hidden; 
      }
    .box {
      width: 50%;
      float: left;
      /* 计算边框在宽度内 */
      box-sizing: border-box;
      border: 1px solid black;
      padding: 10px;
      /* 设置圆角半径 */
      border-radius: 10px; 
    }
  </style>
</head>
<body>
  <!-- HTML 内容 -->
  <div class="container">
    <div class="box">Box 1</div>
    <div class="box">Box 2</div>
  </div>
</body>
</html>
