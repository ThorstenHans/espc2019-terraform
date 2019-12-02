#!/bin/zsh

git status
echo -n "Provide a commit message and hit [ENTER]"
read msg
git add .
git commit -m $msg
git push
