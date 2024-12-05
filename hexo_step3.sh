#!/bin/bash

npm install hexo-deployer-git --save

read -p "Insert your Hexo directory (etc: D:\\folder\\): " path

notepad $path_config.yml

read -p "Press any key to continue..."

hexo cl; hexo g; hexo d