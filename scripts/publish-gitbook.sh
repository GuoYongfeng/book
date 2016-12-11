#!/bin/bash

# cp -a content gitbook
# cd gitbook
#
# rm -rf _book
# rm -rf node_modules
#
# git init

git add .
git commit -m "Publish to GitBook"

# git remote add origin git@github.com:GuoYongfeng/course-book.git

git push origin master

# cd ..
# rm -rf gitbook
