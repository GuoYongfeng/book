# redux-logger的应用和理解

我们将会通过自己动手实现logger中间件以及使用第三方的redux-logger两个层面来深入理解和使用中间件。

## 实现

> 写一个自己的logger中间件，记录每一步操作的信息

```
const loggerMiddleware = store => next => action => {
  const dispatch = store.dispatch
  const getState = store.getState

  console.group( action.type )
  console.log('dispatching: ', action)
  console.log('previous state: ', getState())

  let res = next(action)

  console.log('next state: ', getState())
  console.groupEnd(action.type)

  return res
}

export default loggerMiddleware

```

## redux-logger 的使用

使用 `redux-logger` 中间件实现前端 `log` 日志打印功能。

下载
```
$ npm install redux-logger --save
```
