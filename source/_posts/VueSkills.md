---
title: VueSkills
sticky: 100
hide: true
description: ⭐⭐⭐分享毕生积累的 Vue 语法以及至臻小技巧
categories:
  - 前端
tags:
  - Vue3
index_img: >-
  https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/VueSkills-2024-05-08-10-27-38.png
abbrlink: 28861
date: 2024-05-08 10:21:52
---
## export default 问题
当使用setup语法糖时，不需要使用export default 导出组件，否则会报错，如下图所示：
![Vue中setup语法糖](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/VueSkills-2024-05-08-10-28-55.png)

### 原因
> 在 Vue 3 中使用 `<script setup>` 语法糖时，通常不需要显式地使用 export default 来导出组件选项，因为 `<script setup>` 会自动收集顶级声明（如变量、函数等）并暴露给模板。但是，如果你在 `<script setup>` 中还包含了一个传统的 export default 块，这通常会导致编译错误，因为这与 `<script setup>` 的设计初衷相冲突。

### 解决方案
```vue
  <script setup lang="ts">
  </script>
```

## 居中问题
调整居中，只会通过`left: -500px;`这样来调整距离，但是这样并不完美，当改变窗口尺寸的时候，会出现问题

### 解决方案
要想优雅地居中显示，可以利用 CSS 的 Flexbox 或 Grid 布局特性，而不是直接设置 left 的负值。考虑到你可能是在某个容器内希望居中这个按钮，这里提供两种方法来实现这一目标，假设这个按钮位于一个打算用于布局的父容器中。
方法 1: 使用 Flexbox
修改父容器的样式，使其成为 Flex 容器，并居中其内容。
```vue
<!-- 父容器应用 Flexbox 布局 -->
<div style="display: flex; justify-content: center;">
  <a-button
    type="primary"
    :loading="loading1"
    @click="handleClick1"
    >toSubmit</a-button
  >
</div>
```
方法 2: 使用 Grid
如果更倾向于使用 Grid 布局，也可以通过以下方式实现居中：
```vue
<!-- 父容器应用 Grid 布局 -->
<div style="display: grid; place-items: center;">
  <a-button
    type="primary"
    :loading="loading1"
    @click="handleClick1"
    >toSubmit</a-button
  >
</div>
```
在这两个方法中，我们都没有直接在按钮上设置位置属性，而是通过调整其父元素的布局模式来实现居中对齐。这样可以确保按钮在不同屏幕尺寸和分辨率下都能保持良好的居中效果，同时也让代码更加简洁和响应式。

### 方法介绍
这两种布局是现代 CSS 中非常重要的布局模型，它们提供了更强大和灵活的页面元素定位方式，特别是对于响应式设计和复杂的界面布局。
Flexbox (Flexible Box)
用途：Flexbox 是一种一维布局模型，主要用于处理容器内元素的线性布局，如行或列。它擅长处理单轴布局，比如水平或垂直排列的元素，以及元素之间的对齐和填充。

主要属性：
- display: flex：启用 Flexbox 布局。
- flex-direction：控制主轴的方向（行或列）。
- justify-content：控制元素在主轴上的对齐方式。
- align-items：控制元素在交叉轴上的对齐方式。
- flex-wrap：决定元素是否换行。
- flex-grow, flex-shrink, flex-basis：控制元素的伸缩比例和基础大小。

优点：易于实现单行或单列的弹性布局，如导航栏、页脚、列表项等。
兼容性：在现代浏览器中广泛支持，包括 IE10+。

CSS Grid (Grid Layout)
用途：Grid 是一个二维布局模型，它允许你创建复杂的网格系统，非常适合页面的全面布局，如网页的行和列。它可以同时处理行和列，因此非常适合构建响应式网格。

主要属性：
- display: grid：启用 Grid 布局。
- grid-template-columns 和 grid-template-rows：定义网格的列和行。
- grid-gap：设置网格项之间的间距。
- grid-template-areas：用于命名和指定网格区域。
- grid-auto-flow：控制网格项如何自动填充网格。
- align-items, justify-items，以及 align-self, justify-self：控制网格项在各自单元格内的对齐。

优点：能够精确控制元素的位置和大小，适用于复杂的多列布局和响应式设计。

兼容性：在现代浏览器中支持良好，包括 IE10+（但需要使用 -ms- 前缀）。

通常，开发者会根据具体的需求和场景来选择使用 Flexbox 还是 Grid。对于简单的布局和对齐，Flexbox 可能更合适；而对于复杂的二维布局和整体页面结构，Grid 则更为强大。在某些情况下，两者可以结合使用，以充分利用各自的优点。