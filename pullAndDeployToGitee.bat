@echo off

E:

cd E:\CS_GUIDER\hexo

echo "Pull the latest code from github..."

echo "pull source code..."

git pull origin hexoBlog

echo "pull source code over!"

echo "deploy to gitee pages"

hexo cl && call hexo g && hexo d -m "autoDeploy"