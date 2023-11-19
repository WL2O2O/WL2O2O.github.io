---
title: Educoder
index_img: https://cs-wlei224.obs.cn-south-1.myhuaweicloud.com/blog-imgs/202311151627635.png
categories:
  - Java notes
tags:
  - educoder
abbrlink: 6873
date: 2022-09-07 14:07:56
---

* *写在前面：*

​				【免责声明：】本笔记发表在hexo博客只便于个人学习使用，若涉及到版权，请联系个人，谢谢！

# educoder头歌Java笔记



## *Coding中遇到的问题合集：*

““.equals(name) 和name.equals(““) 的区别：

​		两个都是比较“”的地址和name的地址是否指向同一个地址，即判断name是否为“”；建议用前者，因为name可能是null，此时name.equals("")就会报错，而前者则会避免这个问题

避免了抛出空指针异常NullPointerException。



leetcode回文数：

* (s.charAt(i)).get(map)  &&  map.get(s.charAt(i))，问题同上；出现了抛出空指针异常的问题，使用前者后，测试通过。
* 遇到了char与string的类型不匹配的情况，不可强制转换，最后利用string类的replace方法替换字符串，得到了解决。

​		

##  对象的构造方法实例

```Java
import java.util.Scanner;

public class Test {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String name = sc.next();
		String sex = sc.next();
		/****** Begin ******/
		//分别使用两种构造器来创建Person对象  
		Person a=new Person();
		Person b=new Person(name,sex);
		/****** End ******/
	}
}
//创建Person对象，并创建两种构造方法
/****** Begin ******/
class Person{																	class swap{
	public Person(){																public swap(int a,int b,int c){
		System.out.println("一个人被创建了");							c=a;a=b;b=c;

​	}
​	public Person(String name,String sex){
​		System.out.println("姓名："+name+"，性别："+sex+"，被创建了");
​	}
}
/****** End ******/
```

千万注意！！！！！
变量名字一定看清楚，上面的代码中，误将name写成了neme!!!!!

![image-20220617145157883](C:\Users\WLei224\AppData\Roaming\Typora\typora-user-images\image-20220617145157883.png)

`JAVA`中`变量`的命名和前面第一章所学的`标识符`命名规则是一样的，不过还是有一些不同，总结下来规则与规范一共有六点：

1. 由字母，下划线，美元符号（$），数字组成，但第一个字符不能是数字。

2. 如果变量名是复合型的那么我们采用驼峰式，或者蛇形式的方式。
   驼峰式：`teaCup`（表示茶杯的意思），`stuAge`（学生年龄）
   蛇形式：`tea_cup`，`stu_age`

3. 如果是单个单词就全小写就行了。

4. 千万不要用中文拼音来表达：例如学生年龄：`xueShengNianling`。

5. 在一个方法中变量名不能重复。

6. 变量一定要给自己一个确定的类型。

   ## JAVA中的数据类型

   `Java`基本类型共有八种，基本类型可以分为三类，字符类型`char`，布尔类型`boolean`以及数值类型`byte、short、int、long、float、double`。数值类型又可以分为整数类型`byte、short、int、long`和浮点数类型`float、double`。  

   `基本类型不包括String`

   ## java类型转换

   ![image-20220617152252543](C:\Users\WLei224\AppData\Roaming\Typora\typora-user-images\image-20220617152252543.png)



强制类型转换就是将：**表数范围大的数向表数范围小的进行转换**。  

## ![image-20220617152333029](C:\Users\WLei224\AppData\Roaming\Typora\typora-user-images\image-20220617152333029.png)	

## 怎么使用Scanner

​		第一种方法：

1. 在类的声明之前，引入扫描仪（`Scanner`）：

   `import java.util.Scanner;`

2. 在方法中创建一个扫描仪 

   `Scanner input = new Scanner(System.in);`

   

   第二种方法：

   引入并创建扫描器：`java.util.Scanner s = new java.util.Scanner(System.in); `

   

3. 通过扫描仪获取从键盘输入的数据 

   `int i = input.nextInt();`

   `String s = input.next();`

   

   #### 三目运算符之判断是否闰年？

   

result=(year%400==0 || year%4==0 && year%100!=0)? true:false;

​    System.out.println(year + "年是否为闰年:" + result);



#### 运算符优先级别排序正确的是()

A、 由高向低分别是:()、 ! 、算术运算符、关系运算符、逻辑运算符、赋值 运算符;



## 循环综合练习：

**Java中的两种循环：**

在 Java 语言中，用于循环的语句有两个，一个是 for 循环，一个是 while 循环。而 for 循环其实还有两种实现方法，对于初学者来说，或许仅知道一般的 for 循环，即：

```Java
for(初始化条件; 限制条件; 迭代语句) {
    // 循环体
}
```

而不太了解高级的 for 循环，即：

```Java
for(变量类型 变量名 : 集合) {
    // 循环体
}
```

在本文中，咱们就一起来了解了解这两种 for 循环的使用方法以及区别。
**demo示例：**

```Java
import java.util.Arrays;

/**
 * @author 维C果糖
 * @create 2017-03-31-上午9:30
 */

public class ForDemo {
    public static void main(String[] args) {

        int[] arr = new int[]{2, 0, 1, 5, 11, 20};

        System.out.println("第一种 for 循环方法：");

        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }

        System.out.println();

        System.out.println("高级的 for 循环方法：");

        for (int i : arr){
            System.out.print(i + " ");

        }

        System.out.println();

        System.out.println("用 Arrays 的 toString() 方法打印数组：");

        System.out.println(Arrays.toString(arr));
    }
}
```

**运行结果：**

![for](https://img-blog.csdn.net/20170331095210507?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvcXFfMzUyNDY2MjA=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```Java
ATM经典案例：

package step4;

import java.util.Scanner;

public class ForPractice4 {

  public static void main(String[] args) {

​    /*****start*****/

​    Scanner input = new Scanner(System.in);     

   

​    System.out.println("欢迎使用中国人民银行ATM取款机");     //在循环体外，只输出一次  

​    

​    int capital = 1000;   //总资金  

​    

​    while(true) {                    //循环体设为true，无限循环

​      System.out.println("输入取款金额：");     //循环外层控制“输入金额”

​      int a = input.nextInt();                  //准备接收输入数据

​    

​      if(a > capital) {                        //执行判断语句，如果输出金额大于总金额，则返回返回外层循环

​        System.out.println("目前余额："+capital+"无法满足您的取款需求！");   

​        continue;                          //返回外层循环

​        

​      }else {                           //如果“输入金额”小于capital，则，分支判断开始

​          capital = capital - a;

​          

​          System.out.println("剩余金额："+capital+"，是否继续（'1'：结束，'2'：继续）：");

​            //资金等于总资金 - 取款额度

​          

​          int change = input.nextInt();      //控制输入“1”，“2”，判断是否结束程序

​          if (change == 1) {

​            System.out.println("取款结束！");    //如果为1，程序终止

​            break;

​            

​          }else {                         //如果为其他，则返回外层循环

​            continue;

​          }

​      }

​    

​    }

​    /*****end*****/

  }

}
```



## 第1关：将给定的整数进行由小至大排序

```
 int a;

​    if(x>y){

​      a=y;

​      y=x;

​      x=a;

​    }

​    

​    if(x>z){

​      a=x;

​      x=z;

​      z=a;

​    }

​    if(y>z){

​      a=z;

​      z=y;

​      y=a;

​    }
```



## 关于质数：（难度级别：⭐⭐⭐）

级别1：解题代码2022-07-02 23:30已解锁

```java
package step2;
public class FindZhiShu {
    public static void main(String[] args) {
        /**********begin**********/
//由于偶数中只有2是质数，此处直接将2的值进行输出，如下代码中查找质数时，只需考虑奇数即可
        System.out.print(2+" ");
        //定义标签
        OUT:
        //1不是质数，2是质数但是已经打印输出，因此循环中i的值从3开始即可，i+=2是因为在循环中我们不再考虑偶数
        for (int i = 3; i <= 1000; i+=2) {
        //请补充程序判断i是否是质数并打印i，如果是质数按照 System.out.print(i+" "); 格式进行打印 
            for (int j = 2; j < i; j++) {
                if(i % j == 0) {
        //如果i对j求余数等于0说明i不是质数
                    continue OUT;
               }  
           }            
            //说明i是质数 
           System.out.print(i+" "); 
       } 
        /**********end**********/ 
    }  
```



```java
package step2;
public class FindZhiShu {
	public static void main(String[] args) {
		   /*
		     打印输出质数的时候务必按照如下格式：System.out.print(质数+" ")；
		     使用print进行打印同时被打印输出的质数后加上一个空格，
		     以便于与平台提供的结果格式保持一致！
            */   
		   /**********begin**********/
            a:for(int i = 2;i < 1000;i++){		//此循环遍历次数较多，若对代码效率有要求，则可进一步改进代码：如下：
                for(int j = 2;j<i;j++)
                if(i%j==0){
                    continue a;
                }
                System.out.print(i+" ");
            }
           /**********end**********/	
	}
}
		**********************改进之后的代码*********************
package step2;
public class FindZhiShu {
	public static void main(String[] args) {
		   /*
		     打印输出质数的时候务必按照如下格式：System.out.print(质数+" ")；
		     使用print进行打印同时被打印输出的质数后加上一个空格，
		     以便于与平台提供的结果格式保持一致！
            */   
		   /**********begin**********/

	System.out.print("2 ");	//因为2是特殊的质数，又因下面循环会自动跳过偶数，因此先将2打印出来。
	        a:for(int i = 3;i < 1000;i+=2){
	            for(int j = 2;j<i;j++)
	            if(i%j==0){
	                continue a;		//此方法运用了给循环做标记，以此可以对continue和break进行明确的命令指示。
	            }
	            System.out.print(i+" ");
	        }
	       /**********end**********/	
	}

}
```





## 拓展知识：（break与continue）

##### break关键字

先来看一段代码的运行效果，如下：

   ![img](https://data.educoder.net/api/attachments/189112)  

可以发现只要你一直输入`1`程序就会不断的提示你输入选项，可是当你输入`2`的时候程序就会终止，你能根据这个运行结果想到要实现这个效果，需要编写什么代码吗？
可能你已经猜到了，需要使用到`break`关键字，`break`翻译过来是“打断”的意思，放在`Java`程序中的作用就是：**结束整个循环过程**
好了，现在来一起看看刚刚那段效果的源代码吧。

   ![img](https://data.educoder.net/api/attachments/189205)  

现在你应该基本了解`break`的用法了，不过我还有个小秘密要告诉你：

   ![img](https://data.educoder.net/api/attachments/189207)  

如果我们在循环中使用`switch`语句，那么在`switch`语句中`break`就不能结束当前循环了，而只能结束`switch`语句。

##### continue关键字

`continue`关键字的用途是：**结束一次循环事件，开始下一个循环事件**，也就是忽略该语句之后的语句，执行循环体的下一次循环。
例如：  

```
int i = 0;  while(i < 4){  if(i == 2){  i++;  continue;  }  System.out.println(i);  i++;  }
```

输出结果：
`0`
`1`
`3`

##### static关键字

​		关于静态代码块你只需要记住一句话：在**类被加载的时候**运行且**只运行一次**。

​		静态方法不能使用类的非静态变量；

​		静态方法可以直接调用静态方法，但是调用普通方法只能通过对象的实例才能调用。



## 数组的两种初始化方法：

#### 1.静态初始化

**在程序运行前就能确定数组的大小和数组中的初始数据**我们称之为静态初始化。
例如：  

```Java
float[] stuScores = {80.0f,70.0f,90.0f,66.5f};  int[] nums = {80,70, 90,66};  char[] chs = {‘a’,’b’, ‘c’,’d’};  
```

#### 2.动态初始化

**数组的大小或数组中数据在程序运行时才能决定**，且用到`new`这个关键字来确定数组的大小或初始数据我们称之为动态初始化。
定义数组：`变量类型[] 数组名 = new  数据类型 [ 数组长度 ];`  

![img](https://data.educoder.net/api/attachments/189931)

定义数组与初始化分离：  

![img](https://data.educoder.net/api/attachments/189927)

赋值：
初始化之后就可以向数组中放数据了，数组中元素都是通过下标来访问的，例如向 `stuScores`数组中存放学生成绩：  

![img](https://data.educoder.net/api/attachments/189928)

#### 动态创建数组并循环赋值：

```Java
int[] arr = new int[sc.nextInt()];

for(int i = 0 ; i< arr.length ; i++){

   arr[i] = sc.nextInt();

}
```



## 数组基础

#### 如何获取数组的长度：

数组的`length`属性用于记录数组中有多少个元素或存储单元，即记录数组的长度是多少。  

```
int[] nums = new int[10];//声明一个int型数组并动态初始化其大小为10
System.out.println(nums.length);//显示当前数组的大小  
```

输出：`10`



#### 一维数组的遍历:

通俗的理解，遍历数组就是：**把数组中的元素都看一遍**。

示例如下：  

```Java
int[] arr = {1,3,5,7,9};  
for(int i = 0 ; i<arr.length; i++){
	System.out.print(arr[i] + ",");  
}  
//输出：`1,3,5,7,9`
```

#### 二维数组的遍历：

```
for(int i =0;i<scores.length;i++){
            for(int j=0;j<scores[i].length;j++)		//此处要加上遍历的行数，，即j<scores[i].length
            System.out.println(scores[i][j]);
            System.out.println();
        }
```



#### 如何获取数组的最大值：

要求出数组的最大值，是不是很像是打擂台呢？  

![img](https://data.educoder.net/api/attachments/193188)

对于一群人我们不知道谁最厉害，所以我们准备一个擂台，并挑选第一个人为擂主（max），擂台下的人不断的（循环）来挑战擂主。



#### 数据类型强制转换：

测试输入：`5`，`1`，`151`，`12`，`22`，`100`；   预期输出：
`平均值：57.2`
`最大值：151`

提示：  

```
int a = 3;  int b = 2;  System.out.println(a/b);  System.out.println((double)a/b);  
```

输出：
`1`
`1.5`



例题如下：

#### 编程要求

根据提示，在右侧编辑器`Begin-End`处补充代码，计算并输出数组的平均值和最大值。

```java
package step3;

import java.util.Scanner;

public class HelloWorld {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int[] scores = new int[sc.nextInt()];
		
		//循环给数组赋值
		for(int i = 0 ; i< scores.length;i++){
			scores[i] = sc.nextInt();
		}
		/********** Begin **********/
		//在这里计算数组scores的平均值和最大值
		int sum=0,max=0;
        double av=0;//此处是因为提前声明了一个double变量，否则则需要强制类型转换。
        for(int i=0;i<scores.length;i++){
            sum+=scores[i];
        }
        av=sum/scores.length;
        for(int i=0;i<scores.length;i++){
            if(max<scores[i]){
                max=scores[i];
            }
        }
		System.out.println("平均值：" +av ); 
        //若不声明多变量，则用这句强制转换类型。
        //System.out.println("平均值：" +(double)sum/scores.length );
		System.out.println("最大值：" +max );
		/********** End **********/
	}
}

```



#### 获取二维数组的行列长度：

二维数组定义：`int array[][] = new int[3][3];`
获取行数： `int rowLength = array.length;`
获取列数： `int colLength = array[0].length;`

#### 二维数组的遍历

```java
class Test{
	for(int i = 0; i < array.length; i++){
		for(int j = 0; j < array[i].length; j++){		//此处要加上遍历的行数，，即j<scores[i].length
			System.out.println(array[i][j);
		}
	}
}
```



#### *知识拓展*

**for-each**

for-each 循环通常用于遍历数组和集合，它的使用规则比普通的 for 循环还要简单，不需要初始变量，不需要条件，不需要下标来自增或者自减。来看一下语法：



```java
for(元素类型 元素 : 数组或集合){  
// 要执行的代码
}  
```

来看一下示例：



```java
public class ForEachExample {
    public static void main(String[] args) {
        String[] strs = {"沉默王二", "一枚有趣的程序员"};

        for (String str : strs) {
            System.out.println(str);
        }
    }
}
```

输出：



```text
沉默王二
一枚有趣的程序员
```

#### 两数交换:

两个变量数值的交换有三种换发：

（1）借助中间量交换 （开发常用）

理解：三个杯子，两杯装水，其中一个空杯子用作容器。

int x = 10;
int y = 20;
int z = x;
x = y;
y = z;
　（2）位移运算交换 （面试常用）

理解：涉及到了异或运算符的规则：一个数对另一个数位异或两次，该数不变

int x = 10;
int y = 20;
x = x ^ y;
y = x ^ y;
x = x ^ y;
　（3）数值相加减交换

理解：先求得两数的和再进行减运算

int x = 10;
int y = 20;
x = x + y;
y = x - y;
x = x - y;



## 排序

#### 选择排序：

##### 实现过程

为了实现选择排序，我们需要**求出最大值**，并且和相比较的数据**交换位置**：接下来我们对数组`int[] arr = {6,5,8,0,2,9}`来进行**第一趟循环**，将最大值移动到数组的第一位。

![img](https://data.educoder.net/api/attachments/191743)

代码实现：  

```
int[] arr = {6,5,8,0,2,9};for (int i = 0; i < arr.length-1; i++) {      if(arr[0] < arr[i+1]){          int temp = arr[0];          arr[0] = arr[i+1];          arr[i+1] = temp;      }  }  
```

一次循环操作就可以找出数组中的最大值，并将其移动到数组的首位，所以对于一个长度为`6`的数组，我们只需要进行`5`（length-1）次上述操作即可将数组降序排序了。

接下来我们进行**第二趟循环**，求第二大的值，并将其移动到数组的第二个位置。因为我们已经求出了最大值，所以这一次循环，最大值不用参与比较。  

![img](https://data.educoder.net/api/attachments/191767)

代码实现：  

![img](https://data.educoder.net/api/attachments/191770)

结果：`[9, 8, 5, 0, 2, 6]`

可以发现经过两轮循环我们找出了数组中最大的两个值，并且移动他们到了数组的前两位。

现在按照上述步骤就可以实现数组的排序了，不过如果我们照搬上述代码，就会有很多冗余的代码，所以需要你来改进，怎么改进是需要你思考的。

**告诉你一个秘密**：使用`Arrays.toString(数组)`可以直接输出数组中的值哦！
如下：  

![img](https://data.educoder.net/api/attachments/191773)

输出结果：`[6, 5, 8, 0, 2, 9]`

**思考题**：

本关所讲述的选择排序是一个简化版本，如果你想要学习优化版可以根据下列图片，编写出相应代码，然后在评论区贴出来哦。  

![ ](https://data.educoder.net/api/attachments/192416)

上图就是一个使用选择排序将一个数组中数据从小到大排序的过程，请思考如何用代码实现上述过程。

原理：每一次从待排序的数据元素中选出最小的一个元素，存放在序列的起始位置，直到全部待排序的数据元素排完。

------

本关难度较大，但这是学习数组绕不过去的一关，多思考，多尝试，你能成功的，加油！ 





