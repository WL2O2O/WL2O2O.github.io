@echo off

git --version


@REM 拉取 GitHub 在线编辑内容到本地
echo "--- ---Pull latest[Remote] --> [LocalRepo]...--- ---"
git pull origin hexoBlog
echo "--- ---pull over!--- ---"

@REM 推送源码到 Gitee
echo "--- ---Sync latest --> [GiteeRepo]...--- ---"
git push gitee hexoBlog
echo "--- ---local --> [GiteeRepo] Done!--- ---"

@REM 构建文章到 Gitee
echo "--- ---deploy to gitee pages--- ---"
hexo cl && call hexo g && hexo d -m "autoDeploy"
echo "--- ---Deploy Done!--- ---"


call timeout /t 3