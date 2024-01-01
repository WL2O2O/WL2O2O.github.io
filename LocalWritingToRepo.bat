@echo off

E:

cd E:\CS_GUIDER\hexo

echo "upload source code to remoteRepo..."

@REM 跟踪文件
echo "--- ---trucking files--- ---"
git add .
echo "--- ---trucking files over--- ---"

@REM 提交文件
echo "--- ---commit files--- ---"
git commit -m "feat: auto synchronized."
echo "--- ---commit over--- ---"

@REM 推送到 GitHub
echo "--- ---push to github--- ---"
git push origin hexoBlog
echo "--- ---Deploy Done!--- ---"

@REM 推送源码到 Gitee
echo "--- ---Sync latest --> [GiteeRepo]...--- ---"
git push gitee hexoBlog
echo "--- ---[Local] --> [GiteeRepo] Done!--- ---"

@REM 构建文章到 Gitee
echo "--- ---deploy to gitee pages--- ---"
hexo cl && call hexo g && hexo d -m "autoDeploy"
echo "--- ---Deploy Done!--- ---"

timeout /t 3
