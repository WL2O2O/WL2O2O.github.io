---
title: 面试官的突袭问题：解密多态，让你从懵逼到彻底掌握！
tags:
  - Polymorphism
categories:
  - Blog
excerpt: 面试官的突袭问题：解密多态，让你从懵逼到彻底掌握！
abbrlink: 6d0283c9
date: 2023-10-16 08:57:50
---

# Java多态揭秘：从疑惑到真正掌握！面试官的突袭问题让你茫然？解开多态的魔法！

> 无论是在课堂上、面试中还是与朋友交谈时，当被问到是否理解多态时，我们可能都感到无从下手。这时候，让我通过一个生动的例子，为你彻底解析多态的奥秘！在这个秋招季，面试官的提问可能让你措手不及。但别担心，让我们一起揭开这个问题，带你从茫然到彻底掌握！

本文已发表在`CSDN`,[阅读链接](http://t.csdnimg.cn/x02pb)

## 继承与重写

假设我们有一个Animal类，它有一个makeSound()方法，用于输出动物发出的声音。现在，我们再创建一个Dog类，继承自Animal类，并重写makeSound()方法，让它输出狗狗特有的吠声。

```java
class Animal {
    public void makeSound() {
        System.out.println("Animal makes sound");
    }
}

class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Dog barks");
    }
}
```

## 向上转型

现在，让我们来看看这段代码中隐藏的多态之美！

```java
Animal animal = new Dog();
animal.makeSound();  // 输出: "Dog barks"
```

在这段代码中，我们创建了一个Animal类型的引用变量animal，并将其指向一个Dog对象。这就是向上转型，让我们能够使用父类类型的引用来引用子类对象。

当我们调用animal的makeSound()方法时，输出的却是"Dog barks"，而不是我们在Animal类中定义的"Animal makes sound"。这就是多态的奇妙之处！

在编译时，编译器只知道animal的类型是Animal，因此它只能访问Animal类中定义的方法和属性。但在运行时，实际执行的却是Dog类中重写的makeSound()方法。这是因为Java的运行时系统会根据实际对象的类型来动态决定调用哪个类的方法。

通过这种方式，我们可以根据实际对象的类型，在运行时决定调用哪个类的方法，实现了多态性。这种灵活性和可扩展性使我们能够编写更通用、灵活的代码，同时提高代码的可维护性和可复用性。

掌握**继承、重写和向上转型**这三个必要条件，你就能够在面试中从容应对关于多态性的问题。多态性是面向对象编程中不可或缺的核心概念，它为我们打开了编程世界的大门。

所以，别再为面试官的突袭问题而困惑了！现在，你已经揭开了多态的魔法，让多态性成为你的利器，展现你对Java编程的真正掌握！



附图：

![由一张图片引发的深思](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202310160943256.png)



# 精简版

> 什么是多态？

多态就是，对于同一个父类，指向不同子类对象的同一个行为，运行出来结果不同。

> 怎么理解多态？

例如伪代码：

```java
class Animals {
    public void sleep() {
        sout("坐着睡！");
    }
}

class Dog extends Animals {
    @Override
    public void sleep() {
        sout("站立着睡！");
    }
}

class Cat extends Animals {
    @Override
    public void sleep() {
        sout("睁眼睡！");
    }
}
// 同一个父类 Animals，指向不同子类 Dog、Cat
Animals animals1 = new Dog();
Animals animals2 = new Cat();
```

对于`animals1.sleep()`和`animals2.sleep()`，最后运行出来可能会有不用的结果，但是这取决于几个条件：

- 继承类或实现接口

- 子类重写方法

- 同一个父类，指向不同子类

> 重载与重写什么区别？

引用 Wiki 百科：

> ## 函数重载规则
>
> - 多个函数定义使用相同的函数名称
> - 函数参数的数量或类型必须有区别
>
> 函数重载是静态多态的一种类别，其使用某种“最佳匹配”算法解析函数调用，通过找到形式参数类型与实际参数类型的最佳匹配来解析要调用的具体函数。该算法的细节因语言而异。
>
> 函数重载通常与[静态类型](https://zh.wikipedia.org/wiki/類型系統)编程语言（在[函数调用](https://zh.wikipedia.org/wiki/子程序)中强制执行[类型检查](https://zh.wikipedia.org/wiki/類型系統#型別檢查)）有关。重载函数实际上只是一组具有相同名称的不同函数。具体调用使用哪个函数是在[**编译期**](https://zh.wikipedia.org/wiki/编译期)决定的。
>
> 在 [Java](https://zh.wikipedia.org/wiki/Java) 中，函数重载也被称为编译时多态和静态多态。
>
> 函数重载不应与在运行时进行选择的[多态](https://zh.wikipedia.org/wiki/多态_(计算机科学))形式混淆，例如通过[虚函数](https://zh.wikipedia.org/wiki/虚函数)而不是静态函数。



因此我们大概明白：

- 重载是编译时重载的，编译时根据参数，决定调用哪个方法
- 重写是运行期重写的，运行时根据父类指向的子类，调用方法



**总结：**

重载和重写都是多态的体现，维基百科中也有说明[多态分为动态多态和静态多态](https://zh.wikipedia.org/wiki/%E5%A4%9A%E6%80%81_(%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A7%91%E5%AD%A6))

如图：

![image-20231214103612773](https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202312141036730.png)



那么我们不妨理解为重载为静态动态（编译器决定）、重写为运行期决定的，为动态多态。
