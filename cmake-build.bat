@echo off
setlocal EnableExtensions EnableDelayedExpansion

pushd "%~dp0"

set "BUILD_CONFIG=%~1"
if not defined BUILD_CONFIG (
	set "BUILD_CONFIG=Debug"
)

echo Compilando configuracao "%BUILD_CONFIG%".
cmake --build build --config "%BUILD_CONFIG%" -j16
if errorlevel 1 (
	popd
	exit /b %errorlevel%
)

set "CANLIB_DLL="
if exist "C:\Tools\Kvaser\Canlib\bin_x64\canlib32.dll" (
	set "CANLIB_DLL=C:\Tools\Kvaser\Canlib\bin_x64\canlib32.dll"
) else if exist "C:\Tools\Kvaser\Canlib\Bin\canlib32.dll" (
	set "CANLIB_DLL=C:\Tools\Kvaser\Canlib\Bin\canlib32.dll"
) else if exist "%~dp0hardware_integration\lib\Windows\canlib32.dll" (
	set "CANLIB_DLL=%~dp0hardware_integration\lib\Windows\canlib32.dll"
)

if not defined CANLIB_DLL (
	echo Aviso: canlib32.dll nao encontrada na instalacao da Kvaser nem no repositorio.
	popd
	exit /b 0
)

echo Usando canlib32.dll de "%CANLIB_DLL%".
set /a COPIED_COUNT=0

for /r "build" %%F in (*.exe) do (
	set "TARGET_DIR=%%~dpF"
	if /I "!TARGET_DIR:\CMakeFiles\=!"=="!TARGET_DIR!" (
		if /I not "!TARGET_DIR:\%BUILD_CONFIG%\=!"=="!TARGET_DIR!" (
			copy /Y "%CANLIB_DLL%" "%%~dpFcanlib32.dll" >nul
			if not errorlevel 1 (
				set /a COPIED_COUNT+=1
				echo Copiada canlib32.dll para %%~dpF
			)
		)
	)
)

if !COPIED_COUNT! EQU 0 (
	echo Aviso: nenhum executavel foi encontrado em build para receber a DLL.
)

popd
exit /b 0

rem ctest
