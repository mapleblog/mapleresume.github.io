#!/bin/bash

read -p "Please insert your username: " username
read -p "Please insert your email: " email

git config --global user.name $username
git config --global user.email $email

git config -l

read -p "Press any key to continue..."

ssh-keygen -t rsa -C $email

explorer.exe C:\\Users\\chris\\.ssh

read -p "Please configure your ssh key into your github account..."

ssh -T git@github.com

read -p "Done, Please create new repository in your github..."

