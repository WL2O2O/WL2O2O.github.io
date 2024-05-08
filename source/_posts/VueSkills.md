---
title: VueSkills
sticky: 100
hide: true
description: ⭐⭐⭐分享毕生积累的 Vue 语法以及至臻小技巧
categories:
  - 前端
tags:
  - Vue3
date: 2024-05-08 10:21:52
index_img: https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/VueSkills-2024-05-08-10-27-38.png
---
## 遇到的小错误
当使用setup语法糖时，不需要使用export default 导出组件，否则会报错，如下图所示：
![Vue中setup语法糖](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/VueSkills-2024-05-08-10-28-55.png)

### 错误原因
> 在 Vue 3 中使用 `<script setup>` 语法糖时，通常不需要显式地使用 export default 来导出组件选项，因为 `<script setup>` 会自动收集顶级声明（如变量、函数等）并暴露给模板。但是，如果你在 `<script setup>` 中还包含了一个传统的 export default 块，这通常会导致编译错误，因为这与 `<script setup>` 的设计初衷相冲突。