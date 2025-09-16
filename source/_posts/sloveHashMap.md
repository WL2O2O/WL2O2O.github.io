---
title: 再也不怕面试问到 HashMap
tags:
  - 八股文
  - 面试逆袭
  - Java基础
categories:
  - Blog
excerpt: 怎么理解 HashMap 的数据结构？怎么解决 hash 冲突？哈希表负载因子是多少？哈希表怎么扩容？
abbrlink: 4a30f0e6
date: 2024-01-01 23:31:00
---

---
![2024一起卷吧](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202401012339709.png)

<font face="STCAIYUN">
<b> 
见者有缘，缘来好运🍀诚邀各位围观我的博客【CS_GUIDER】👇
</b>
</font>
<br>
<font color=#758ef1>
<b>
🧑‍💻个人主页：
<a href="https://github.com/wl2o2o">wl2o2o</a>
<br>
✒️博客主页：
<a href="https://wlei224.gitee.io"> CS_GUIDER(好玩)</a>
<a href="https://wl2o2o.github.io"> CS_GUIDER(实用)</a>
<br>
⭐八股专栏：
<a href="https://csguider.icu"> JavaU8G(内置MusicPlayer)</a>
</b>
</font>
<br>
<font color=#fc1944>
<b>我的开源博客涵盖了八股文、设计模式、网站搭建、数据库、Linux系统的教程和笔记。我致力于为您提供Java编程的实用指南和资源，包括Java框架、JVM、微服务以及Git。无论您是初学者还是经验丰富的开发人员，都可以从中获益。谢谢您的光临！</b>
</font>

---
# 官方介绍
![什么是 HashMap](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202401012338127.png)

# 我的理解
`HashMap`又称哈希表，又称散列表。首先，`HashMap`的数据结构是基于数组和链表的，如图：

![HashMap数据结构](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202401012338628.png)
## 特点
so，既然是基于数组和链表的，那就说明数组和链表的特点也就是`HashMap`的特点：

- **数组：寻址快，直接根据索引访问元素，插入和删除慢；**

- **链表：寻址慢，需要从头节点开始遍历，插入和删除快。**

说到`HashMap`就要说到 Java 8 了，Java 8 之前，`HashMap`使用一个数组加链表的结构来存储 【K，V】 键值对。

如果发生 hash 冲突，那么，

这必将导致在处理 hash 冲突的时候性能不高，尤其是链表很长的时候。因此，Java 8 中的`HashMap`引入了红黑树来替代链表，这样当链表变长的时候，会自动转换为红黑树，从而提高了增删改查的性能。



## 什么是 Hash 冲突？怎么解决？

哈希冲突就是不同的数据经过哈希计算之后，得到的
`hash`值相同，然后被映射到了哈希表中的同一个位置，这就是哈希冲突。

**解决方法：**

1. 开放寻址法
   意思就是，一旦发生冲突的话，就去按线性顺序寻找下一个空的散列地址，知道找到存放位置；
2. 链地址法
   就是将哈希表数组的元素作为链表的头结点（这个链表的所有元素构成一个近义词链表，因为经过`hash`计算值相同），一旦哈希冲突，就把该关键字链接到该结点的尾部；
3. 再哈希法
   顾名思义，就是再次通过另一个`hash`函数计算，得到另外的散列地址，直到冲突不发生；
4. 建立公共溢出区
   将哈希表分为`基本表`与`溢出表`，发生冲突的元素放入溢出表中。

## 负载因子为什么是 0.75 ？
对于开放寻址法，荷载因子是特别重要因素，应严格限制在0.7-0.8以下。超过0.8，查表时的CPU缓存不命中（cache missing）按照指数曲线上升。因此，一些采用开放寻址法的hash库，如Java的系统库限制了荷载因子为0.75，超过此值将resize散列表。



## 如何进行扩容？





待完善···
