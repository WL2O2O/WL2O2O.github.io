---
title: abstract class && interface
tags:
  - Java基础
categories:
  - Java notes
excerpt: 你知道抽象类(abstract class)和接口(interface)有什么区别吗？
abbrlink: d784ab99
date: 2023-10-07 08:58:32
---

## 抽象类(abstract class)和接口(interface)有什么区别？

### 代码示例：

```java
// 抽象类
public abstract class Animal {
    // 非抽象方法
    public void eat() {
        System.out.println("Animal is eating.");
    }

    // 抽象方法
    public abstract void makeSound();
}

// 实现抽象类的子类
public class Dog extends Animal {
    // 实现抽象方法
    public void makeSound() {
        System.out.println("Dog is barking.");
    }
}

// 接口
public interface Shape {
    // 接口中的常量
    public static final double PI = 3.14;

    // 抽象方法
    public double getArea();

    // 抽象方法
    public double getPerimeter();
}

// 实现接口的类
public class Circle implements Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    // 实现接口的抽象方法
    public double getArea() {
        return PI * radius * radius;
    }

    // 实现接口的抽象方法
    public double getPerimeter() {
        return 2 * PI * radius;
    }
}
```

### 区别：

抽象类：

- 可以包含非抽象方法和抽象方法；
- 可以包含属性和构造方法；
- 可以被继承，且一个类只能继承一个抽象类；
- 抽象方法必须被子类实现；
- 可以有访问修饰符和static、final等修饰符。

接口：

- 只能包含抽象方法和常量；
- 可以被类实现，一个类可以实现多个接口；
- 接口中的方法默认为public，且不能有方法体；
- 接口中的属性默认为public static final，且不能被修改；
- JDK8之后，接口中可以有默认方法和静态方法。
- JDK9 在接⼝中引⼊了私有⽅法和私有静态⽅法。

从设计层面来说：

- 抽象类是对类的抽象，是一种模板设计；
- 接口是对行为的抽象，是一种行为的规范。
