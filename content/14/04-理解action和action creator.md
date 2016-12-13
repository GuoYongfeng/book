
### Action & Action Creator

在 Redux 中，改变 State 只能通过 action，它是 store 数据的唯一来源。一般来说你会通过 store.dispatch() 将 action 传到 store。。并且，每一个 action 都必须是 Javascript 的简单对象，例如：

```
{
  type: 'ADD_TODO',
  text: 'Learn Redux'
}
```
Redux 要求 action 是可以被序列化的，使这得应用程序的状态保存、回放、Undo 之类的功能可以被实现。因此，action 中不能包含诸如函数调用这样的不可序列化字段。

action 的格式是有建议规范的，可以包含以下字段：
```
{
  type: 'ADD_TODO',
  payload: {
    text: 'Do something.'
  },
  `meta: {}`
}
```
如果 action 用来表示出错的情况，则可能为：
```
{
  type: 'ADD_TODO',
  payload: new Error(),
  error: true
}
```
type 是必须要有的属性，其他都是可选的。完整建议请参考 [Flux Standard Action(FSA)](https://github.com/acdlite/flux-standard-action) 定义。已经有不少第三方模块是基于 FSA 的约定来开发了。

**Action Creator**

事实上，创建 action 对象很少用这种每次直接声明对象的方式，更多地是通过一个创建函数。这个函数被称为Action Creator，例如：
```
function addTodo(text) {
  return {
    type: ADD_TODO,
    text
  };
}
```
Action Creator 看起来很简单，但是如果结合上 Middleware 就可以变得非常灵活，后面会专门讲 Middleware 。
