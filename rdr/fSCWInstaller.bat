@echo off
rem -----fS Clock Widget Installer - Version 1.0+210410-----
rem Created by Milkeyyy
set version=1.0+210410
rem �����̊m�F
if "%1"=="update" (goto update) else (goto install)

rem �C���X�g�[���菇
:install
cd /d %~dp0
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas -ArgumentList '%1 %2'"
exit
)

rem ---�ϐ��̐ݒ�---
rem �C���X�g�[������v���O�����̃^�C�g��
set prname=fS Clock Widget
rem �C���X�g�[������v���O�����̃��C�����s�t�@�C��
set mainexe=fSCW.exe
rem �C���X�g�[������o�[�W����
set dlver=1.2.6-release
rem �_�E�����[�h����p�b�P�[�W�̃t�@�C����
set filename=fSCWPackage.zip
rem �_�E�����[�hURL
set dlurl=https://github.com/Milkeyyy/simpleclockwidget/releases/download/%dlver%/%filename%

title "%prname% Installer v%version% (Mode: Install)"
echo %prname% Installer v%version% (Mode: Install) - �C���X�g�[���o�[�W����: %dlver%
echo.
echo �����L�[�������� %prname% �̃C���X�g�[�����J�n���܂��B
pause
echo.

rem ���ɃC���X�g�[������Ă��邩�̊m�F
if exist "C:\%prname%\%mainexe%" (
	echo ���� %prname% ���C���X�g�[������Ă��܂��B�C���X�g�[���𑱍s����ɂ͉����L�[�������Ă��������B
	pause
	)

:start
echo.
md "C:\%prname%"
echo.
echo �p�b�P�[�W���_�E�����[�h...
timeout /t 1 /nobreak >nul
bitsadmin /transfer dlpackage "%dlurl%" "C:\%prname%\%filename%"
echo.
echo �p�b�P�[�W����...
powershell -command "Expand-Archive -Force 'C:\%prname%\%filename%' 'C:\%prname%'"
echo.
del "C:\%prname%\%filename%"
if exist "C:\%prname%\%mainexe%" (goto ifiletrue) else (goto ifilefalse)

:ifiletrue
echo ---------------- �C���X�g�[�����������܂����B ----------------
echo �C���X�g�[�������o�[�W����: %dlver%
echo �C���X�g�[�������f�B���N�g���[: C:\%prname%
echo --------------------------------------------------------------
echo.
goto end
:ifilefalse
echo ------ �t�@�C����������܂���B�C���X�g�[���Ɏ��s�����\��������܂��B ------
echo.
goto end

rem �A�b�v�f�[�g�菇
:update
cd /d %~dp0
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas -ArgumentList '%1 %2'"
exit
)

rem ---�ϐ��̐ݒ�---
rem �C���X�g�[������v���O�����̃^�C�g��
set prname=fS Clock Widget
rem �A�b�v�f�[�g����o�[�W���� (����)
set dlver=%2
rem �_�E�����[�h����p�b�P�[�W�̃t�@�C����
set filename=fSCWPackage.zip
rem �_�E�����[�hURL
set dlurl=https://github.com/Milkeyyy/simpleclockwidget/releases/download/%dlver%/%filename%
if "%prname%"=="" (set prname=PleaseInputProgramName)

title "%prname% Installer v%version% (Mode: Update)"
echo %prname% Installer v%version% (Mode: Update) - �A�b�v�f�[�g�o�[�W����: %dlver%
echo.
echo �t�@�C�����폜...
del /Q "C:\%prname%\*"
echo.
echo �p�b�P�[�W���_�E�����[�h...
timeout /t 1 /nobreak >nul
bitsadmin /transfer dlpackage "%dlurl%" "C:\%prname%\%filename%"
echo.
echo �p�b�P�[�W����...
powershell -command "Expand-Archive -Force 'C:\%prname%\%filename%' 'C:\%prname%'"
echo.
del "C:\%prname%\%filename%"
if exist "C:\%prname%\%mainexe%" (goto ufiletrue) else (goto ufilefalse)

:ufiletrue
echo ---------------- �A�b�v�f�[�g���������܂����B ----------------
echo �A�b�v�f�[�g�o�[�W����: %dlver%
echo --------------------------------------------------------------
echo.
timeout /t 3 /nobreak >nul
exit

:ufilefalse
echo ------ �t�@�C����������܂���B�A�b�v�f�[�g�Ɏ��s�����\��������܂��B ------
echo.
goto end

:end
pause
exit