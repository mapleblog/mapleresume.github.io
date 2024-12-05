#!/bin/bash

npm install -g hexo-cli && hexo -v

hexo -v

read -p "Press any key to continue..."

hexo init
npm i

hexo cl && hexo s

start http://localhost:4000

read -p "Press any key to continue..."