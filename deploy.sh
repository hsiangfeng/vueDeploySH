
set -e

# https://en.wikipedia.org/wiki/ANSI_escape_code
lgreen='\033[1;32m'
yellow='\033[1;33m'
norm='\033[0m'
bold='\033[1m'

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     machine=Linux;;
  Darwin*)    machine=Mac;;
  CYGWIN*)    machine=Cygwin;;
  MINGW*)     machine=MinGw;;
  *)          machine="UNKNOWN:${unameOut}"
esac

if [ ${machine} = "Mac" ]
then
  osStatus=""
elif [ ${machine} = "MinGw" ]
then
  osStatus="-e"
else
  osStatus=""
fi

echo
echo ${osStatus} "${lgreen}=============================================================="
echo ${osStatus} " 您的執行環境是 ${machine} "
echo ${osStatus} "==============================================================${norm}"

echo
echo ${osStatus} "${lgreen}=============================================================="
echo ${osStatus} " 一鍵部署 5 秒後開始運作 "
echo ${osStatus} " ＊如要停止動作請按下 CRTL + C or Control + C"
echo ${osStatus} "==============================================================${norm}"

sleep 5s

echo
echo ${osStatus} "${yellow}=============================================================="
echo ${osStatus} " 準備取得 Git 遠端 Url..."
echo ${osStatus} "==============================================================${norm}"

sleep 1s
originUrl=$(git config --get remote.origin.url)

echo
echo ${osStatus} "${lgreen}=============================================================="
echo ${osStatus} " 目前遠端分支: ${originUrl} "
echo ${osStatus} "==============================================================${norm}"

sleep 1s
split=${originUrl:0:5}
status='';
if [ $split = 'https' ]
then
  status='HTTPS'
else
  status='SSH'
fi

echo
echo ${osStatus} "${lgreen}=============================================================="
echo ${osStatus} " 傳輸方式將採用 $status "
echo ${osStatus} " 目前遠端分支 URL：$originUrl "
echo ${osStatus} "==============================================================${norm}"

sleep 5s

echo
echo ${osStatus} "${yellow}=============================================================="
echo ${osStatus} " 5 秒後開始編譯 Vue Cli "
echo ${osStatus} " ＊如要停止動作請按下 CRTL + C or Control + C"
echo ${osStatus} "==============================================================${norm}"

sleep 5s
npm run build

echo
echo ${osStatus} "${lgreen}=============================================================="
echo ${osStatus} " 編譯完成 "
echo ${osStatus} "==============================================================${norm}"

echo
echo ${osStatus} "${yellow}=============================================================="
echo ${osStatus} " 移動到編譯完成的資料夾 "
echo ${osStatus} "==============================================================${norm}"

cd dist

echo
echo ${osStatus} "${yellow}=============================================================="
echo ${osStatus} " 初始化 Git 與加入 Commit "
echo ${osStatus} "==============================================================${norm}"

git init
git add .
git commit -m "update `date +'%Y-%m-%d %H:%M:%S'`";

echo
echo ${osStatus} "${yellow}=============================================================="
echo ${osStatus} " 5 秒後部署檔案到遠端分支 "
echo ${osStatus} " ＊如要停止動作請按下 CRTL + C or Control + C"
echo ${osStatus} "==============================================================${norm}"
sleep 5s
git push -f $originUrl master:gh-pages

echo
echo ${osStatus} "${yellow}=============================================================="
echo ${osStatus} " 部署完成 "
echo ${osStatus} "==============================================================${norm}"

echo
echo ${osStatus} "${lgreen}=============================================================="
echo ${osStatus} " 一鍵部署指令結束 "
echo ${osStatus} "==============================================================${norm}"
