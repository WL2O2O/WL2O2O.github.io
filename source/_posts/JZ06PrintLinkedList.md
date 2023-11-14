---
title: 001-JZoffer
index_img: >-
  https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202309111618303.png
categories:
  - 算法
tags:
  - 链表
  - 递归
  - ArrayList
abbrlink: 14851
date: 2023-06-01 09:56:58
---

> `JZ6 从尾到头打印链表`
> 
> 简单 通过率：29.17% 时间限制：1秒 空间限制：64M
>
> 知识点[链表](https://www.nowcoder.com/exam/oj/ta?page=1&tpId=13&type=13?tag=580)
>
> ## 描述
>
> 输入一个链表的头节点，按链表从尾到头的顺序返回每个节点的值（用数组返回）。
>
> 如输入{1,2,3}的链表如下图:
>
> ![img](https://uploadfiles.nowcoder.com/images/20210717/557336_1626506480516/103D87B58E565E87DEFA9DD0B822C55F)
>
> 返回一个数组为[3,2,1]
>
> 0 <= 链表长度 <= 10000
>
> ## 示例1
>
> 输入：
>
> ```
>{1,2,3}
> ```
> 
> 返回值：
>
> ```
>[3,2,1]
> ```
> 
> ## 示例2
>
> 输入：
>
> ```
>{67,0,24,58}
> ```
> 
> 返回值：
>
> ```
>[58,24,0,67]
> ```

`技巧：`

​	出入栈或者递归

​	递归方法 + ArrayList的头结点添加元素实现链表逆序

`思路：`

​	涉及到递归的思想：递归是一个过程或函数在其定义或说明中有直接或间接调用自身的一种方法，它通常把一个大型复杂问题层层转化为一个与原问题相似的小问题来求解。因此，所谓递归就是将一个复杂的问题细化为一个个子问题，这就是递归！

​	下面说说这个题目：

​	我们都知道链表无法进行逆序访问，那肯定无法直接遍历链表得到从头到尾的逆序结果。但是我们都知道递归是**到达底层**之后才会**往上层回溯**，因此我们可以考虑递归遍历链表：

​	step1:从表头开始往后递归进入每一个节点。

​	step2:每次返回添加一个值到新的数组中，直到遇到尾节点（head.next == null）

​	官方题解思路：

![image-20230721101906413](https://cdn.jsdelivr.net/gh/wl2o2o/blogCdn/img/202307211019432.png)

`code：`

```java
import java.util.*;
/**
*    public class ListNode {
*        int val;
*        ListNode next = null;
*
*        ListNode(int val) {
*            this.val = val;
*        }
*    }
*
*/
import java.util.ArrayList;

public class Solution {
    public ArrayList<Integer> printListFromTailToHead(ListNode listNode) {
        ArrayList<Integer> res = new ArrayList<>();
        Stack<Integer> s = new Stack<>();
        while(listNode != null){
            s.push(listNode.val);
            listNode = listNode.next;
        }
        while(!s.isEmpty()){
            res.add(s.pop());
        }
        return res;
    }
}
```



```java
import java.util.ArrayList;
public class Solution {
    //递归函数
    public void recursion(ListNode head, ArrayList<Integer> res){ 
        if(head != null){
            //先往链表深处遍历
            recursion(head.next, res); 
            //再填充到数组就是逆序
            res.add(head.val); 
        }
    }
    public ArrayList<Integer> printListFromTailToHead(ListNode listNode) {
        ArrayList<Integer> res = new ArrayList<Integer>();
        //递归函数解决
        recursion(listNode, res);
        return res;
    }
}
```

`结束语：`

​	本题考查的就是链表的逆向输出，要想逆向输出，

1. 可以遍历链表然后存储到数组中，再利用数组的reverse()方法，直接反序；
2. 官方题解中的链表递归，其实这个考察的就是递归的思想，递归是**到达底层**之后才会**往上层回溯**（先递进，再回归！可以这么理解）
3. 既然涉及到链表的反序输出，那么为什么不利用栈呢？先入后出==>逆向输出。

​	

好久没写算法题，太生疏了！！！每日一题，没有退路，继续加油！