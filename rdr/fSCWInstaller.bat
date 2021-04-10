@echo off
rem -----fS Clock Widget Installer - Version 1.0+210410-----
rem Created by Milkeyyy
set version=1.0+210410
rem 引数の確認
if "%1"=="update" (goto update) else (goto install)

rem インストール手順
:install
cd /d %~dp0
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas -ArgumentList '%1 %2'"
exit
)

rem ---変数の設定---
rem インストールするプログラムのタイトル
set prname=fS Clock Widget
rem インストールするプログラムのメイン実行ファイル
set mainexe=fSCW.exe
rem インストールするバージョン
set dlver=1.2.6-release
rem ダウンロードするパッケージのファイル名
set filename=fSCWPackage.zip
rem ダウンロードURL
set dlurl=https://github.com/Milkeyyy/simpleclockwidget/releases/download/%dlver%/%filename%

title "%prname% Installer v%version% (Mode: Install)"
echo %prname% Installer v%version% (Mode: Install) - インストールバージョン: %dlver%
echo.
echo 何かキーを押すと %prname% のインストールを開始します。
pause
echo.

rem 既にインストールされているかの確認
if exist "C:\%prname%\%mainexe%" (
	echo 既に %prname% がインストールされています。インストールを続行するには何かキーを押してください。
	pause
	)

:start
echo.
md "C:\%prname%"
echo.
echo パッケージをダウンロード...
timeout /t 1 /nobreak >nul
bitsadmin /transfer dlpackage "%dlurl%" "C:\%prname%\%filename%"
echo.
echo パッケージを解凍...
powershell -command "Expand-Archive -Force 'C:\%prname%\%filename%' 'C:\%prname%'"
echo.
del "C:\%prname%\%filename%"
if exist "C:\%prname%\%mainexe%" (goto ifiletrue) else (goto ifilefalse)

:ifiletrue
echo ---------------- インストールが完了しました。 ----------------
echo インストールしたバージョン: %dlver%
echo インストールしたディレクトリー: C:\%prname%
echo --------------------------------------------------------------
echo.
goto end
:ifilefalse
echo ------ ファイルが見つかりません。インストールに失敗した可能性があります。 ------
echo.
goto end

rem アップデート手順
:update
cd /d %~dp0
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas -ArgumentList '%1 %2'"
exit
)

rem ---変数の設定---
rem インストールするプログラムのタイトル
set prname=fS Clock Widget
rem アップデートするバージョン (引数)
set dlver=%2
rem ダウンロードするパッケージのファイル名
set filename=fSCWPackage.zip
rem ダウンロードURL
set dlurl=https://github.com/Milkeyyy/simpleclockwidget/releases/download/%dlver%/%filename%
if "%prname%"=="" (set prname=PleaseInputProgramName)

title "%prname% Installer v%version% (Mode: Update)"
echo %prname% Installer v%version% (Mode: Update) - アップデートバージョン: %dlver%
echo.
echo ファイルを削除...
del /Q "C:\%prname%\*"
echo.
echo パッケージをダウンロード...
timeout /t 1 /nobreak >nul
bitsadmin /transfer dlpackage "%dlurl%" "C:\%prname%\%filename%"
echo.
echo パッケージを解凍...
powershell -command "Expand-Archive -Force 'C:\%prname%\%filename%' 'C:\%prname%'"
echo.
del "C:\%prname%\%filename%"
if exist "C:\%prname%\%mainexe%" (goto ufiletrue) else (goto ufilefalse)

:ufiletrue
echo ---------------- アップデートが完了しました。 ----------------
echo アップデートバージョン: %dlver%
echo --------------------------------------------------------------
echo.
timeout /t 3 /nobreak >nul
exit

:ufilefalse
echo ------ ファイルが見つかりません。アップデートに失敗した可能性があります。 ------
echo.
goto end

:end
pause
exit