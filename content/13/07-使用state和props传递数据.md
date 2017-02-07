
## 使用state和props传递数据

我们在Profile组件预设部分初始state，并且使用state和props将数据传递给三个子组件。

代码清单：`app/containers/Profile/Profile.jsx`

```
import React, { Component } from 'react';
import { UserProfile, UserRepos, Notes } from '../../components';

class Profile extends Component {
  state = {
    notes: ['1', '2', '3'],
    bio: {
      name: 'guoyongfeng'
    },
    repos: ['a', 'b', 'c']
  }
  render(){
    console.log(this.props);
    return (
      <div className="row">
        <div className="col-md-4">
          <UserProfile
            username={this.props.params.username}
            bio={this.state.bio} />
        </div>
        <div className="col-md-4">
          <UserRepos repos={this.state.repos} />
        </div>
        <div className="col-md-4">
          <Notes notes={this.state.notes} />
        </div>
      </div>
    )
  }
}

export default Profile

```

在三个子组件里面分别拿到这些数据进行展示。

代码清单：`app/components/UserProfile/UserProfile.jsx`

```
import React, { Component } from 'react';

export default class UserProfile extends Component {
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

代码清单：`app/components/UserRepos/UserRepos.jsx`

```
import React, { Component } from 'react';

export default class UserRepos extends Component {
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

代码清单：`app/components/Notes/Notes.jsx`

```
import React, { Component } from 'react';

export default class Notes extends Component {
  render(){
    return (
      <div>
        <p> 评论 </p>
        <p> Notes: {this.props.notes} </p>
      </div>
    )
  }
}

```
