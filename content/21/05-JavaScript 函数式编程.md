<h1 style="font-size: 40px;text-align:center;color: #007cdc;">JavaScript 函数式编程 (ES6)</h1>

**什么是函数式编程**

函数式编程是一种编程范式，我们常见的编程范式有命令式编程（Imperative programming），函数式编程，逻辑式编程，常见的面向对象编程是也是一种命令式编程。在函数式编程世界里，函数是一等公民。谈及函数式编程，你可能会想到它们：Haskell 和 Lisp这两门函数式编程语言。

**函数式编程给我们带来了什么好处**

由于命令式编程语言也可以通过类似函数指针的方式来实现高阶函数，函数式的最主要的好处主要是不可变性带来的。没有可变的状态，函数就是引用透明（Referential transparency）的和没有副作用（No Side Effect）。

好处：函数即不依赖外部的状态也不修改外部的状态，函数调用的结果不依赖调用的时间和位置，这样写的代码容易进行推理，不容易出错。这使得单元测试和调试都更容易。

> 我们今天不玩虚的，不玩概念，只求实实在在的学一下函数式编程在Javascript语言中的简单应用及带来的改变。

## 1.纯函数式

> 什么是纯函数：相同的参数返回相同的结果，它的执行不依赖于系统的状态

函数式编程的核心就是借助形式化数学来描述逻辑：lambda 运算。数学家们喜欢将程序描述为数据的变换，这也引入了第一个概念：纯函数。纯函数无副作用，仅仅依赖于函数的输入，并且当输入相同时输出保持一致。

1) 非纯净的

```javascript
let number = 1;

const increment = () => number += 1;

increment();
// 2
```

2) 纯净的

```javascript
const increment = n => n + 1;

increment(1);
// 2
```

## 2.高阶函数
函数把其他函数当做参数传递使用或者返回一个函数
1) 加法

```javascript
const sum = (x, y) => x + y;

const calculate = (fn, x, y) => fn(x, y);

calculate(sum, 1, 2);
// 3
```

2) filter

```javascript
let students = [
    {name: 'Anna', grade: 6},
    {name: 'John', grade: 4},
    {name: 'Maria', grade: 9}
];

const isApproved = student => student.grade >= 6;

students.filter(isApproved);
// [ { name: 'Anna', grade: 6 }, { name: 'Maria', grade: 9 } ]
```

3) Map

```javascript
const byName = obj => obj.name;

students.map(byName);
// [ 'Anna', 'John', 'Maria' ]
```

4) 链式

```javascript
let students = [
    {name: 'Anna', grade: 6},
    {name: 'John', grade: 4},
    {name: 'Maria', grade: 9}
];

const isApproved = student => student.grade >= 6;

const byName = obj => obj.name;

students.filter(isApproved).map(byName);
// ['Anna', 'Maria']
```

5) Reduce

```javascript
const totalGrades = students.reduce((sum, student) => sum + student.grade, 0);

totalGrades
// 19
```

## 3.递归

当一个函数调用它自己的时候，就创造了一个循环

1) 递减

```javascript
const countdown = num => {
    if (num > 0) {
        console.log(num);
        countdown(num - 1);
    }
}

countdown(5);
/*
5
4
3
2
1
*/
```

2) 阶乘

```javascript
const factorial = num => {
    if (num <= 0) {
        return 1;
    } else {
        return (num * factorial(num - 1));
    }
}

factorial(5);
//120
```

## 4.Functor
有 map 方法的对象。functor 的 map 方法通过 map 回调函数调用自己的内容，然后返回一个新的 functor.

1) 给数组所有的元素添加一个值

```javascript
const plus1 = num => num + 1;

let numbers = [1, 2, 3];
numbers.map(plus1);
// [2, 3, 4]
```

## 5.组合

通过组合两个或更多的函数生成一个新的函数

1) 组合两个函数生成一个新的函数

```javascript
const compose = (f,g) => x => f(g(x));

const toUpperCase = x => x.toUpperCase();
const exclaim = x => `${x}!`;

const angry = compose(exclaim, toUpperCase);

angry("stop this");
// STOP THIS!
```

2) 组合三个函数生成一个新的

```javascript
const compose = (f,g) => x => f(g(x));

const toUpperCase = x => x.toUpperCase();
const exclaim = x => `${x}!`;
const moreExclaim = x => `${x}!!!!!`;

const reallyAngry = compose(exclaim, compose(toUpperCase, moreExclaim));

reallyAngry("stop this");
// STOP THIS!!!!!!
```

## 6.解构

从数组中提取数据或对象使用一种语法混合数组和对象文本的建设。或“模式匹配”。

1) Select from pattern

```javascript
const foo = () => [1, 2, 3];

const [a, b] = foo();
console.log(a, b);
// 1 2
```

2) 接收 rest 值

```javascript
const [a, ...b] = [1, 2, 3];
console.log(a, b);
// 1 [2, 3]
```

3) 可选参数

```javascript
const ajax = ({ url = "localhost", port: p = 80}, ...data)  =>
    console.log("Url:", url, "Port:", p, "Rest:", data);

ajax({ url: "someHost" }, "additional", "data", "hello");
// Url: someHost Port: 80 Rest: [ 'additional', 'data', 'hello' ]

ajax({ }, "additional", "data", "hello");
// Url: localhost Port: 80 Rest: [ 'additional', 'data', 'hello' ]
```

## 7.柯里化

一个函数有多个参数,把每个参数通过链式的形式返回下一个函数,直到最后返回结果。


1) 对象柯里化

```javascript
const student = name => grade => `Name: ${name} | Grade: ${grade}`;

student("Matt")(8);
// Name: Matt | Grade: 8
```

2) 加法函数柯里化

```javascript
const add = x => y => x + y;

const increment = add(1);
const addFive = add(5);

increment(3);
//4

addFive(10);
// 15
```

## 参考资源

- https://www.zhihu.com/question/28292740
- https://github.com/js-functional/js-funcional
- https://zhuanlan.zhihu.com/p/20824527
