
## 剖析applyMiddleware.js

现在咱们已经知道Redux中间件是个啥，并且也掌握了足够的函数式编程知识，那就让我们再次尝试阅读`applyMiddleware.js`的源码来探个究竟吧。这次感觉比较好理解了吧：

	export default function applyMiddleware(...middlewares) {    		return (next)  =>

    		(reducer, initialState) => {

      			var store = next(reducer, initialState);
      			var dispatch = store.dispatch;
      			var chain = [];

      			var middlewareAPI = {
        			getState: store.getState,
        			dispatch: (action) => dispatch(action)
      			};

      			chain = middlewares.map(middleware =>
                    			middleware(middlewareAPI));

      			dispatch = compose(...chain, store.dispatch);
      			return {
        			...store,
        			dispatch
      			};
   			};
	}

`applyMiddleware`可能应该起一个更好一点的名字，谁能告诉我这是为谁来“申请中间件”？我觉得可以这么叫：`applyMiddlewareToStore`，这样是不是更加明确一些？

我们来一行一行分析代码，首先我们看方法签名：

	export default function applyMiddleware(...middlewares)

注意这里有个很有趣的写法，参数：`...middlewares`，这么定义允许我们调用时传入任意个数的中间件函数作为参数。接下来函数将返回一个接受`next`作为参数的函数：

	return (next) => (reducer, initialState) => {...}

`next`参数是一个被用来创建store的函数，你可以看一下[createStore.js](https://github.com/rackt/redux/blob/master/src/createStore.js)源码的实现细节。最后这个函数返回一个类似`createStore`的函数，不同的是它包含一个由中间件加工过的dispatch实现。

接下来我们通过调用`next`拿到store对象（译者注："Next we assign the store implementation to the function responsible for creating the new store (again see createStore.js). "这句实在翻译不来～）。我们用一个变量保存原始的dispatch函数，最后我们声明一个数组来存储我们创建的中间件链：

	var store = next(reducer, initialState);
	var dispatch = store.dispatch;
	var chain = [];

接下来的代码将`getState`和调用原始的`dispatch`函数注入给所有的中间件：

	var middlewareAPI = {
  		getState: store.getState,
  		dispatch: (action) => dispatch(action)
	};

	chain = middlewares.map(middleware =>
                    middleware(middlewareAPI));

然后我们根据中间件链创建一个加工过的dispatch实现：

	dispatch = compose(...chain, store.dispatch);

最tm精妙的地方就是上面这行，Redux提供的`compose`工具函数组合了我们的中间件链，`compose`实现如下：

	export default function compose(...funcs) {
 		return funcs.reduceRight((composed, f) => f(composed));
	}

碉堡了！上面的代码展示了中间件调用链是如何创建出来的。中间件调用链的顺序很重要，调用链类似下面这样：

	middlewareI(middlewareJ(middlewareK(store.dispatch)))(action)

现在知道为啥我们要掌握复合函数和柯里化概念了吧？最后我们只需要将新的store和调整过的dispatch函数返回即可：

	return {
 		...store,
 		dispatch
	};

上面这种写法意思是返回一个对象，该对象拥有store的所有属性，并增加一个dispatch函数属性，store里自带的那个原始dispatch函数会被覆盖。这种写法会被[Babel](https://babeljs.io/repl/)转化成：

	return _extends({}, store, { dispatch: _dispatch });

现在让我们将我们的logger中间件注入到dispatch中：

	import { createStore, applyMiddleware } from ‘redux’;
	import loggerMiddleware from ‘logger’;
	import rootReducer from ‘../reducers’;

	const createStoreWithMiddleware =
  		applyMiddleware(loggerMiddleware)(createStore);

	export default function configureStore(initialState) {
  		return createStoreWithMiddleware(rootReducer, initialState);
	}

	const store = configureStore();

## 6.异步中间件

我们已经会写基础的中间件了，我们就要玩儿点高深得了，整个能处理异步action的中间件咋样？让我们来看一下[redux-thunk](https://github.com/gaearon/redux-thunk)的更多细节。我们假设有一个包含异步请求的action，如下：

	function fetchQuote(symbol) {
   		requestQuote(symbol);
   		return fetch(`http://www.google.com/finance/info?q=${symbol}`)
      			.then(req => req.json())
      			.then(json => showCurrentQuote(symbol, json));
	}

上面代码并没有明显的调用dispatch来分派一个返回promise的action，我们需要使用redux-thunk中间件来延迟dipatch的执行：

	function fetchQuote(symbol) {
  		return dispatch => {
    		dispatch(requestQuote(symbol));
    		return fetch(`http://www.google.com/finance/info?q=${symbol}`)
      				.then(req => req.json())
      				.then(json => dispatch(showCurrentQuote(symbol, json)));
  		}
	}

注意这里的`dipatch`
和`getState`是由`applyMiddleware`函数注入进来的。现在我们就可以分派最终得到的action对象到store的reducers了。下面是类似redux-thunk的实现：

	export default function thunkMiddleware({ dispatch, getState }) {
  		return next =>
     			action =>
       				typeof action === ‘function’ ?
         				action(dispatch, getState) :
         				next(action);
	}

这个和你之前看到的中间件没什么太大不同。如果得到的action是个函数，就用`dispatch`和`getState`当作参数来调用它，否则就直接分派给store。你可以看一下Redux提供的更详细的[异步示例](https://github.com/rackt/redux/tree/master/examples)。另外还有一个支持promises的中间件是[redux-promise](https://github.com/acdlite/redux-promise)。我觉得选择使用哪个中间件可以根据性能来考量。
