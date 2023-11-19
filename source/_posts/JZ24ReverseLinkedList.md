---
title: 002-JZoffer
index_img: https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202311151627628.png
categories:
  - 算法
tags:
  - 链表反转
  - 迭代
  - 递归
abbrlink: 51735
date: 2023-06-01 09:56:58
---

#  JZ24 反转链表

> 简单 通过率：38.87% 时间限制：1秒 空间限制：256M
>
> 知识点[链表](https://www.nowcoder.com/exam/oj/ta?page=1&tpId=13&type=13?tag=580)
>
> ## 描述
>
> 给定一个单链表的头结点pHead(该头节点是有值的，比如在下图，它的val是1)，长度为n，反转该链表后，返回新链表的表头。
>
> 数据范围： 0≤n≤1000
>
> 要求：空间复杂度 O(1) ，时间复杂度 O(n) 。
>
> 如当输入链表{1,2,3}时，
>
> 经反转后，原链表变为{3,2,1}，所以对应的输出为{3,2,1}。
>
> 以上转换过程如下图所示：
>
> ![img](https://uploadfiles.nowcoder.com/images/20211014/423483716_1634206291971/4A47A0DB6E60853DEDFCFDF08A5CA249)
>
> ## 示例1
>
> 输入：
>
> ```
> {1,2,3}
> ```
>
> 返回值：
>
> ```
> {3,2,1}
> ```
>
> ## 示例2
>
> 输入：
>
> ```
> {}
> ```
>
> 返回值：
>
> ```
> {}
> ```
>
> 说明：
>
> ```
> 空链表则输出空                 
> ```

## 我的题解

>  技巧： 
>
>  	出入栈
>  			
>  	要明白ListNode创建的是结点，所以需要另外创建一个curr指针，来指向结点，进而完成对链表的操作。
>
>  思路： 
>
>  ```
>  思路一：
>  	顺序压栈，然后指定新的头（newHead），然后while循环弹栈；
>  
>  思路二：
>  	迭代的思想（代码见官方题解方法一），反转指针指向，curr.next = pre;
>  ```
>
>  思路一：
>
>  ```java
>  import java.util.*;
>  
>  /*
>   * public class ListNode {
>   *   int val;
>   *   ListNode next = null;
>   *   public ListNode(int val) {
>   *     this.val = val;
>   *   }
>   * }
>   */
>  
>  
>  public class Solution {
>      /**
>       * 代码中的类名、方法名、参数名已经指定，请勿修改，直接返回方法规定的值即可
>       *
>       *
>       * @param head ListNode类
>       * @return ListNode类
>       */
>      public ListNode ReverseList (ListNode head) {
>          // write code here
>          Stack<ListNode> s = new Stack<>();
>          // 入栈
>          while (head != null) {
>              s.push(head);
>              head = head.next;
>          }
>          if(s.isEmpty()) return null;
>  
>          // 出栈
>          ListNode newHead = s.pop(); // 反转后的链表头节点
>          ListNode curr = newHead;
>          // 出栈并连接节点
>          while (!s.isEmpty()) {
>              curr.next = s.pop();
>              curr = curr.next;
>          }
>          curr.next = null; // 将最后一个节点的next指针置空
>  
>          return newHead; // 返回反转后的链表头节点
>      }
>  }
>  ```
>
>  

## 官方题解思路

### 方法一：迭代（推荐使用）

**思路：**

将链表反转，就是将每个表元的指针从向后变成向前，那我们可以遍历原始链表，将遇到的节点一一指针逆向即可。指针怎么逆向？不过就是断掉当前节点向后的指针，改为向前罢了。

```
cur.next = pre
```

**具体做法：**

- step 1：优先处理空链表，空链表不需要反转。
- step 2：我们可以设置两个指针，一个当前节点的指针，一个上一个节点的指针（初始为空）。
- step 3：遍历整个链表，每到一个节点，断开当前节点与后面节点的指针，并用临时变量记录后一个节点，然后当前节点指向上一个节点，即可以将指针逆向。
- step 4：再轮换当前指针与上一个指针，让它们进入下一个节点及下一个节点的前序节点。

**图示：** ![alt](https://uploadfiles.nowcoder.com/images/20211001/397721558_1633084777359/E53A90674EDC6B8D31549D8DF4E7B38E)

**Java实现代码：**

[复制代码](https://www.nowcoder.com/practice/75e878df47f24fdc9dc3e400ec6058ca?tpId=13&tqId=23286&ru=/exam/oj/ta&qru=/ta/coding-interviews/question-ranking&sourceUrl=%2Fexam%2Foj%2Fta%3Fpage%3D1%26tpId%3D13%26type%3D13#)

```java
public class  Solution {
	public   ListNode ReverseList(ListNode head) { 
    //处理空链表        
    if (head ==   null)   return   null  ;    
        
    ListNode cur = head;        
    ListNode pre =   null  ;    
    
    while  (cur !=   null  ){          
    	//断开链表，要记录后续一个          
    	ListNode temp = cur.next;  
        
    	//当前的next指向前一个          
    	cur.next = pre;     
        
    	//前一个更新为当前          
    	pre = cur;       
        
    	//当前更新为刚刚记录的后一个          
    	cur = temp;        
    }        
    return   pre;      
    }   
}
```

##### 方法二：递归（扩展思路）

**思路：**

从上述方法一，我们可以看到每当我们反转链表的一个节点以后，要遍历进入下一个节点进入反转，相当于对后续的子链表进行反转，这可以看成是一个子问题，因此我们也可以使用递归，其三段式模版为：

- **终止条件：** 当到达链表尾，要么当前指针是空，要么下一个指针是空，就返回。
- **返回值：** 每一级返回反转后的子问题的头节点。
- **本级任务：** 先进入后一个节点作为子问题。等到子问题都反转完成，再将本级节点与后一个的指针反转。

**具体做法：**

- step 1：对于每个节点我们递归向下遍历到最后的尾节点。
- step 2：然后往上依次逆转两个节点。
- step 3：将逆转后的本层节点，即反转后这后半段子链表的尾，指向null，返回最底层上来的头部节点。

**Java实现代码：**

```Java
public   class   Solution {
	public   ListNode ReverseList(ListNode head) { 
    	//递归结束条件        
    	if  (head ==   null   || head.next ==   null  ) 
        	return   head;        
        	
        //反转下一个        
        ListNode newHead = ReverseList(head.next);        
        
        //逆转本级节点        
        head.next.next = head;        
        
        //尾部设置空节点        
        head.next =   null  ;        
        
        return   newHead；
            
    }  
}
```



总结：对于重复的子问题，可以使用递归的方法。
