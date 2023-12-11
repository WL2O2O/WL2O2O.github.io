@echo off

E:

cd E:\CS_GUIDER\hexo

echo "Pull the latest code from github..."

git pull origin master

echo "pull latest code over!"

echo "deploy to gitee pages"

hexo cl && call hexo g && hexo d -m "autoDeploy"