
## 基本介绍

React 已经帮我们在视图层解决了禁止异步和直接操作 DOM 等问题，让页面的高效渲染和组件化开发成为了可能。美中不足的是，React 依旧把处理 state 中数据的问题留给了你，那么，Redux的出现就是为了帮你解决这个问题。

### Flux & Redux

最初，Facebook官方提出了FLUX思想管理数据流，同时也给出了自己的实现方案[flux](https://github.com/facebook/flux)来管理React应用。

<img src="/img/redux/flux.jpg" />

**看图说话：**<br>
1.在view中触发action中的方法后<br>
2.action发送dispatch<br>
3.store接收新的数据进行合并，然后触发View中绑定在store上的方法<br>
4.最后通过修改局部state来改变view的展示<br>

<img src="/img/redux/redux.jpg" />

**看图说话：**<br>
1.view直接触发dispatch<br>
2.dispatch将action发送到reducer中后，根节点上会更新props，改变全局view。<br>
3.redux将view和store的绑定从手动编码中提取出来，放在了统一规范放在了自己的体系中。<br>

> 相对于Flux而言，Redux的实现更简单，思路更清晰，写的代码也相对更少；只维护单一的 store；在github上收货了16000+的star，广受欢迎...

### 对 Redux 的介绍

- Redux 是 State 容器，提供可预测化的状态管理
- 它可以让你构建一致化的应用，运行于不同的环境（客户端、服务器、原生应用），并且易于测试
- 还提供 redux-devtools 让开发者享受超爽的开发体验
- 体小精悍（只有2kB）且没有任何依赖
- 拥有丰富的生态圈：教程、开发者工具、路由、组件、中间件、工具集...
