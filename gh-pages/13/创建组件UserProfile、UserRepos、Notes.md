
## 创建组件UserProfile、UserRepos、Notes

创建三个组件

```
$ cd app/components && mkdir UserProfile UserRepos Notes
$ cd UserProfile && touch UserProfile.jsx
$ cd ../UserRepos && touch UserRepos.jsx
$ cd ../Notes && touch Notes.jsx
```

现在我们先简单的给这三个组件添加示意性的逻辑

代码清单：`app/components/UserProfile/UserProfile.jsx`

```
import React, { Component } from 'react';

export default class UserProfile extends Component {
  render(){
    return (
      <div> UserProfile </div>
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
      <div> UserRepos </div>
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
      <div> Notes </div>
    )
  }
}

```

接下来更新一下组件维护列表，代码清单：`app/components/index.js`

```
'use strict';

export TestDemo from './TestDemo/TestDemo.jsx';
export SearchGithub from './SearchGithub/SearchGithub.jsx';
export UserProfile from './UserProfile/UserProfile.jsx';
export UserRepos from './UserRepos/UserRepos.jsx';
export Notes from './Notes/Notes.jsx';

```

ok，我们在Profile组件使用这三个组件，代码清单：`app/containers/Profile/Profile.jsx`

```
import React, { Component } from 'react';
import { UserProfile, UserRepos, Notes } from '../../components';

class Profile extends Component {
  render(){
    return (
      <div className="row">
        <div className="col-md-4">
          基本信息
          <UserProfile />
        </div>
        <div className="col-md-4">
          代码仓库
          <UserRepos />
        </div>
        <div className="col-md-4">
          笔记
          <Notes />
        </div>
      </div>
    )
  }
}

export default Profile

```

在浏览器中查看效果。
