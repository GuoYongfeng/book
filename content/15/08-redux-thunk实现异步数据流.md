## 实战：使用redux-thunk中间件实现异步action操作

> 需求：实现一个异步action的功能场景：**点击加1按钮的时候，延迟2秒再执行**

- `redux-thunk` 的使用
-  `action` 如何定义

redux-thunk源码分析：

```
function createThunkMiddleware(extraArgument) {

  return ({ dispatch, getState }) => next => action => {
	 // fn(){}
    if (typeof action === 'function') {
      return action(dispatch, getState, extraArgument);
    }

	// {}
    return next(action);
  };
}

const thunk = createThunkMiddleware();
thunk.withExtraArgument = createThunkMiddleware;

export default thunk;
```
