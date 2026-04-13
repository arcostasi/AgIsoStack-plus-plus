@echo off
setlocal

set "KVASER_CANLIB_LIB=C:\Tools\Kvaser\Canlib\Lib\x64\canlib32.lib"

if exist "%KVASER_CANLIB_LIB%" (
	echo Kvaser CANlib encontrada em "%KVASER_CANLIB_LIB%".
) else (
	echo Aviso: CANlib nao encontrada em "%KVASER_CANLIB_LIB%".
	echo O projeto continuara usando a copia do repositorio em hardware_integration\lib\Windows.
)

cmake -S . -B build -DCAN_DRIVER=WindowsCANlib -DBUILD_EXAMPLES=ON -DBUILD_TESTING=ON -Wno-dev
exit /b %errorlevel%