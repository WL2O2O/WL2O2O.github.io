@echo off

E:

cd E:\CS_GUIDER\hexo

echo "拉取最新代码中... ..."

git pull origin hexoBlog

echo "run autoDeploy.bat"

hexo cl && call hexo g && hexo d -m "autoDeploy"

echo "同步源码到远仓中"

git add .

git commit -m "feat: auto synchronized🎉"

git push origin hexoBlog

git push gitee hexoBlog
