@echo off

E:

cd E:\CS_GUIDER\hexo

echo "start autoDeploy.bat"

hexo cl && call hexo g && hexo d -m "autoDeploy"
