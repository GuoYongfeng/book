
## 评论列表组件NoteList

评论的数据拿到了，我们创建一个展示评论数据的组件NoteList，并且在Notes组件中调用
```
$ cd app/components/Notes && touch NoteList.jsx
```

ok，我们在Notes组件中使用NoteList，并将获取的notes数据传给它；
```
import React, { Component } from 'react';
import NoteList from './NoteList.jsx';

export default class Notes extends Component {
  render(){
    console.log('notes:', this.props.notes);

    return (
      <div>
        <p> 对{this.props.username}评论： </p>
        <NoteList notes={this.props.notes} />
      </div>
    )
  }
}

```

然后封装NoteList组件
```
import React, { Component } from 'react';

export default class NoteList extends Component {
  render(){
    let notes = this.props.notes.map((note, index) => {
      return <li className="list-group-item" key={index}>{note['.value']}</li>
    })
    return (
      <ul className="list-group">
        {notes}
      </ul>
    )
  }
}

```

现在，我们可以在浏览器中看到展示真实数据的Notes组件

<img src="../images/notetaker/notelist.png" />
