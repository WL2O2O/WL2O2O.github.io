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

echo "Deploy Done!"

echo "Sync latest --> [GiteeRepo]..."

git push gitee hexoBlog

echo "[Local] --> [GiteeRepo] Done!"

echo "deploy to gitee pages"

hexo cl && call hexo g && hexo d -m "autoDeploy"

echo "Deploy Done!"

timeout /t 3
