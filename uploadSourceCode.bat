@echo off

E:

cd E:\CS_GUIDER\hexo

echo "Synchronize source code to remoteRepo..."

git add .

echo "truck files..."

git commit -m "feat: auto synchronized🎉"

echo "commit over"

echo "push to github"

git push origin hexoBlog

echo "push gitee"

git push gitee hexoBlog
