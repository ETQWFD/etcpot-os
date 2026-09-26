@echo off
REM ==============================================
REM  EtcPot OS - one-click installer (Windows)
REM  Requires: android-platform-tools (fastboot.exe in PATH)
REM ==============================================
setlocal

set IMAGE=%1
if "%IMAGE%"=="" set IMAGE=out\target\product\etcpot\etcpot-1.0-image.zip

echo ==============================================
echo   EtcPot OS 一键安装程序 (Windows)
echo ==============================================

where fastboot >nul 2>&1
if errorlevel 1 (
  echo [!] 未找到 fastboot，请先安装 android-platform-tools。
  exit /b 1
)

echo [1/6] 检测设备...
fastboot devices
if errorlevel 1 (
  echo [!] 未检测到设备，请手机进入 fastboot 模式。
  exit /b 1
)

echo [2/6] 解锁 bootloader...
fastboot flashing unlock

echo [3/6] 清空 userdata...
fastboot -w

echo [4/6] 刷写 EtcPot 镜像...
if exist "%IMAGE%" (
  fastboot update "%IMAGE%"
) else (
  echo [!] 镜像未找到，尝试刷写占位镜像...
  fastboot flash boot boot.img
  fastboot flash system system.img
  fastboot flash vendor vendor.img
)

echo [5/6] 重启设备...
fastboot reboot

echo [6/6] 完成。首次开机约 2-3 分钟。
endlocal
