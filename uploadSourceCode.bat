@echo off

E:

cd E:\CS_GUIDER\hexo

echo "Synchronize source code to remoteRepo..."

git add .

git commit -m "feat: auto synchronized🎉"

git push origin hexoBlog

git push gitee hexoBlog
