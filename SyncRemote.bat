@echo off

git --version

echo "Pull latest[Remote] --> [LocalRepo]..."

git pull origin hexoBlog

echo "pull over!"

echo "deploy to gitee pages"

hexo cl && call hexo g && hexo d -m "autoDeploy"

echo "Deploy Done!"

echo "Sync latest --> [GiteeRepo]..."

git push gitee hexoBlog

echo "Done!"

timeout /t 3