@echo off
del /Q SCW.exe
if not %errorlevel% == 0 (
	echo;
	echo アップデートに失敗しました。
	echo;
	pause
	exit
)
copy /Y rem ---userdcm---Update\SCW.exe %~dp0
if not %errorlevel% == 0 (
	echo;
	echo アップデートに失敗しました。
	echo;
	pause
	exit
) else (
	echo;
	echo アップデートが完了しました。
	echo;
	pause
	exit
)