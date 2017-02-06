
## Proxies

Proxy可以监听对象身上发生了什么事情，并在这些事情发生后执行一些相应的操作。一下子让我们对一个对象有了很强的追踪能力，同时在数据绑定方面也很有用处。

```
//定义被侦听的目标对象
var engineer = { name: 'Joe Sixpack', salary: 50 };

//定义处理程序
var interceptor = {
  set: function (receiver, property, value) {
    console.log(property, 'is changed to', value);
    receiver[property] = value;
  }
};

//创建代理以进行侦听
engineer = Proxy(engineer, interceptor);
//做一些改动来触发代理
engineer.salary = 60;//控制台输出：salary is changed to 60
```

上面代码我已加了注释，这里进一步解释。对于处理程序，是在被侦听的对象身上发生了相应事件之后，处理程序里面的方法就会被调用，上面例子中我们设置了`set`的处理函数，表明，如果我们侦听的对象的属性被更改，也就是被`set`了，那这个处理程序就会被调用，同时通过参数能够得知是哪个属性被更改，更改为了什么值。
