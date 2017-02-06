
## Template Strings 字符串模板

字符串模板相对简单易懂些。ES6中允许使用反引号 ` 来创建字符串，此种方法创建的字符串里面可以包含由美元符号加花括号包裹的变量${vraible}。如果你使用过像C#等后端强类型语言的话，对此功能应该不会陌生。

```
//产生一个随机数
var num = Math.random();
//将这个数字输出到console
console.log(`your num is ${num}`);

let name = 'guoyongfeng';
let age = 18;

console.log(`${name} was ${age}`)

```
