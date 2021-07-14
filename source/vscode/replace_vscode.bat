@echo off
echo Windows下替换VScode中bat和shell的语法高亮配置文件,实现GMT语法高亮
echo 需要安装 gawk
where code | gawk -F"bin" "{print $1}" > tmp121212.txt
set /p T1=<tmp121212.txt
copy batchfile.tmLanguage.json "%T1%"\resources\app\extensions\bat\syntaxes\batchfile.tmLanguage.json
copy shell-unix-bash.tmLanguage.json "%T1%"\resources\app\extensions\shellscript\syntaxes\shell-unix-bash.tmLanguage.json
del tmp121212.txt 
echo 请重新启动 Vscode！
pause