---
title: 面试官的突袭问题：解密多态，让你从懵逼到彻底掌握！
index_img: https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202311151627635.png
excerpt: 面试官的突袭问题：解密多态，让你从懵逼到彻底掌握！
categories:
  - Blog
tags:
  - Polymorphism
abbrlink: 47559
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

