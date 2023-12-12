@echo off

E:

cd E:\CS_GUIDER\hexo

echo "upload source code to remoteRepo..."

echo "trucking files"

git add .

echo "trucking files over"

echo "commit files"

git commit -m "feat: auto synchronized."

echo "commit over"

echo "push to github"

git push origin hexoBlog

echo "push gitee"

git push gitee hexoBlog

echo "Done!"

timeout /t 3
