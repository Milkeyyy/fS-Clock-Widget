@echo off
set AppTitle=fS Clock Widget
set ScriptTitle=%AppTitle% Builder
set ScriptVer=1
cd %~dp0

title %ScriptTitle% Version %ScriptVer%

echo %ScriptTitle% - v%ScriptVer%
echo.

echo ビルド情報を記録
del /q BuildDate.txt
del /q BuildVersion.txt

set builddate=%date%
set tmptime=%time: =0%
echo %builddate%>> BuildDate.txt
set buildtime=%date:~0,4%%date:~5,2%%date:~8,2%.%tmptime:~0,2%%tmptime:~3,2%%tmptime:~6,2%
echo %buildtime%>> BuildVersion.txt
echo.

echo コンパイルを開始
echo.
"C:\Users\Milkeyyy\AppData\Local\Programs\Produire\rdrc.exe" fSCW.rdrproj
timeout /t 2 /nobreak >nul

