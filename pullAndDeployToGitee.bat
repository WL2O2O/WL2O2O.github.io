@echo off

E:

cd E:\CS_GUIDER\hexo

echo "Pull the latest code from remote repo..."

git pull origin hexoBlog

git pull gitee hexoBlog

echo "pull latest code over!"

echo "deploy to gitee pages"

hexo cl && call hexo g && hexo d -m "autoDeploy"

echo "Done!"

timeout /t 3