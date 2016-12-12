
## 为组件添加PropTypes接口约束

代码清单；`app/components/Notes/Notes.jsx`

```
import React, { Component, PropTypes } from 'react';
import NoteList from './NoteList.jsx';

export default class Notes extends Component {
  static propTypes = {
    username: PropTypes.string.isRequired,
    notes: PropTypes.array.isRequired
  }
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

代码清单；`app/components/UserRepos/UserRepos.jsx`

```
import React, { Component, PropTypes } from 'react';

export default class UserRepos extends Component {
  static propTypes = {
    username: PropTypes.string.isRequired,
    repos: PropTypes.array.isRequired
  }
  render(){
    return (
      <div>
        <p> GIT仓库 </p>
        <p> REPOS: {this.props.repos}</p>
      </div>
    )
  }
}

```

代码清单；`app/components/UserProfile/UserProfile.jsx`

```
import React, { Component, PropTypes } from 'react';

export default class UserProfile extends Component {
  static propTypes = {
    username: PropTypes.string.isRequired,
    bio: PropTypes.object.isRequired
  }
  render(){
    return (
      <div>
        <p> 基本信息 </p>
        <p> 姓名: {this.props.username} </p>
        <p> 介绍：{this.props.bio.name}</p>
      </div>
    )
  }
}

```
