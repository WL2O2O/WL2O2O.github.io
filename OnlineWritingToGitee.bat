@echo off

git --version

echo "Pull latest[Remote] --> [LocalRepo]..."

git pull origin hexoBlog

echo "pull over!"

echo "Sync latest --> [GiteeRepo]..."

git push gitee hexoBlog

echo "local --> [GiteeRepo] Done!"

echo "deploy to gitee pages"

hexo cl && call hexo g && hexo d -m "autoDeploy"

echo "Deploy Done!"

timeout /t 3