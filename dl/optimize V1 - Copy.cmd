@echo off
chcp 65001>nul
setlocal enabledelayedexpansion

set "logfile=%~dp0optimization_log.txt"
echo Optimization Log > %logfile%

if not exist "%~dp0language.txt" (
    call :choose_language
) else (
    set /p language=<"%~dp0language.txt"
)

call :get_system_info

:menu
cls
call :display_menu_%language%
set /p choice="Choose an option (1-18): "
if "%choice%"=="1" goto stop_services
if "%choice%"=="2" goto free_ram
if "%choice%"=="3" goto optimize_disk
if "%choice%"=="4" goto high_performance
if "%choice%"=="5" goto disable_windows_update
if "%choice%"=="6" goto start_printer
if "%choice%"=="7" goto stop_printer
if "%choice%"=="8" goto enable_defender
if "%choice%"=="9" goto disable_defender
if "%choice%"=="10" goto remove_bloatware
if "%choice%"=="11" goto remove_edge
if "%choice%"=="12" goto enable_gaming_mode
if "%choice%"=="13" goto stop_fax_service
if "%choice%"=="14" goto optimize_network
if "%choice%"=="15" goto disable_tpm_check
if "%choice%"=="16" goto restart
if "%choice%"=="17" goto change_language
if "%choice%"=="18" goto exit
goto menu

:choose_language
cls
echo Select language / Выберите язык / Chọn ngôn ngữ:
echo 1. English
echo 2. Русский
echo 3. Tiếng Việt
set /p lang_choice="Enter your choice (1-3): "
if "%lang_choice%"=="1" set language=english
if "%lang_choice%"=="2" set language=russian
if "%lang_choice%"=="3" set language=vietnamese
echo %language%>"%~dp0language.txt"
exit /b

:get_system_info
for /f "tokens=2 delims==" %%a in ('wmic os get Caption /value') do set "os_name=%%a"
for /f "tokens=2 delims==" %%a in ('wmic os get Version /value') do set "os_version=%%a"
for /f "tokens=2 delims==" %%a in ('wmic cpu get Name /value') do set "cpu_name=%%a"
for /f "tokens=2 delims==" %%a in ('wmic computersystem get Model /value') do set "model=%%a"
for /f "tokens=2 delims==" %%a in ('wmic computersystem get Manufacturer /value') do set "manufacturer=%%a"
for /f "tokens=2 delims==" %%a in ('wmic bios get SerialNumber /value') do set "serial_number=%%a"
for /F "tokens=*" %%A in ('systeminfo ^| find "Total Physical Memory"') do set RAM=%%A
for /f "tokens=2 delims==" %%a in ('wmic path win32_VideoController get Name /value') do set "gpu_name=%%a"
exit /b

:display_menu_vietnamese
cls
echo ========================================
echo          Thông Tin Hệ Thống              
echo ========================================
echo Tên máy tính: %COMPUTERNAME%
echo Nhà sản xuất: %manufacturer%
echo Model máy tính: %model%
echo Số sê-ri: %serial_number%
echo Hệ điều hành: %os_name%
echo Phiên bản: %os_version%
echo CPU: %cpu_name%
echo %RAM%
echo GPU: %gpu_name%
echo ========================================
echo        DWL Optimization Menu V1       
echo ========================================
echo 1. Tắt các dịch vụ không cần thiết
echo 2. Giải phóng RAM
echo 3. Tối ưu dung lượng ổ cứng
echo 4. Bật chế độ hiệu suất cao
echo 5. Tắt Windows Update đến năm 2050
echo 6. Bật máy in
echo 7. Tắt máy in
echo 8. Bật Windows Defender
echo 9. Tắt Windows Defender
echo 10. Xóa bloatware
echo 11. Xóa Microsoft Edge
echo 12. Bật Game Mode
echo 13. Tắt dịch vụ Fax
echo 14. Tối ưu mạng
echo 15. Tắt kiểm tra TPM (cho Windows 11)
echo 16. Khởi động lại máy
echo 17. Thay đổi ngôn ngữ
echo 18. Thoát
echo ========================================
exit /b

:display_menu_english
cls
echo ========================================
echo          System Information              
echo ========================================
echo Computer Name: %COMPUTERNAME%
echo Manufacturer: %manufacturer%
echo Computer Model: %model%
echo Serial Number: %serial_number%
echo Operating System: %os_name%
echo Version: %os_version%
echo CPU: %cpu_name%
echo %RAM%
echo GPU: %gpu_name%
echo ========================================
echo        DWL Optimization Menu V1       
echo ========================================
echo 1. Stop unnecessary services
echo 2. Free up RAM
echo 3. Optimize disk space
echo 4. Enable high performance mode
echo 5. Disable Windows Update until 2050
echo 6. Start printer
echo 7. Stop printer
echo 8. Enable Windows Defender
echo 9. Disable Windows Defender
echo 10. Remove bloatware
echo 11. Remove Microsoft Edge
echo 12. Enable Game Mode
echo 13. Stop Fax service
echo 14. Optimize network
echo 15. Disable TPM check (for Windows 11)
echo 16. Restart computer
echo 17. Change language
echo 18. Exit
echo ========================================
exit /b

:display_menu_russian
cls
echo ========================================
echo          Информация о системе            
echo ========================================
echo Имя компьютера: %COMPUTERNAME%
echo Производитель: %manufacturer%
echo Модель компьютера: %model%
echo Серийный номер: %serial_number%
echo Операционная система: %os_name%
echo Версия: %os_version%
echo Процессор: %cpu_name%
echo %RAM%
echo Видеокарта: %gpu_name%
echo ========================================
echo        DWL Меню оптимизации V1       
echo ========================================
echo 1. Остановить ненужные службы
echo 2. Освободить ОЗУ
echo 3. Оптимизировать дисковое пространство
echo 4. Включить режим высокой производительности
echo 5. Отключить Windows Update до 2050 года
echo 6. Запустить принтер
echo 7. Остановить принтер
echo 8. Включить Windows Defender
echo 9. Отключить Windows Defender
echo 10. Удалить bloatware
echo 11. Удалить Microsoft Edge
echo 12. Включить игровой режим
echo 13. Остановить службу факса
echo 14. Оптимизировать сеть
echo 15. Отключить проверку TPM (для Windows 11)
echo 16. Перезагрузить компьютер
echo 17. Изменить язык
echo 18. Выход
echo ========================================
exit /b

:stop_services
if "%language%"=="english" (echo Stopping unnecessary services...) else if "%language%"=="russian" (echo Остановка ненужных служб...) else (echo Đang dừng các dịch vụ không cần thiết...)
net stop "Windows Search" 2>>%logfile% & net stop "SysMain" 2>>%logfile% & net stop "DiagTrack" 2>>%logfile% & net stop "WerSvc" 2>>%logfile%
if "%language%"=="english" (echo Services have been stopped.) else if "%language%"=="russian" (echo Службы остановлены.) else (echo Các dịch vụ đã được dừng.)
pause & goto menu

:free_ram
if "%language%"=="english" (
    set "msg1=Freeing up RAM and optimizing performance..."
    set "msg2=RAM has been freed and performance optimized."
    set "msg3=Non-essential services have been stopped."
    set "msg4=System file cache has been cleared."
    set "msg5=Working set of running processes has been trimmed."
) else if "%language%"=="russian" (
    set "msg1=Освобождение ОЗУ и оптимизация производительности..."
    set "msg2=ОЗУ освобождена и производительность оптимизирована."
    set "msg3=Неважные службы были остановлены."
    set "msg4=Кэш системных файлов был очищен."
    set "msg5=Рабочий набор запущенных процессов был сокращен."
) else (
    set "msg1=Đang giải phóng RAM và tối ưu hóa hiệu suất..."
    set "msg2=RAM đã được giải phóng và hiệu suất đã được tối ưu hóa."
    set "msg3=Các dịch vụ không cần thiết đã bị dừng."
    set "msg4=Bộ nhớ đệm tệp hệ thống đã được xóa."
    set "msg5=Bộ làm việc của các quy trình đang chạy đã được cắt giảm."
)
echo %msg1%

net stop "Windows Search" 2>nul
net stop "SysMain" 2>nul
net stop "DiagTrack" 2>nul
net stop "WerSvc" 2>nul

echo.>%temp%\empty.tmp
echo Y|cacls %temp%\empty.tmp /G Everyone:F >nul
type %temp%\empty.tmp > %windir%\temp\flush.tmp
del %temp%\empty.tmp %windir%\temp\flush.tmp

%windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-Process | Where-Object {$_.Name -notlike 'svchost*' -and $_.Name -ne 'explorer' -and $_.Name -ne 'cmd'} | ForEach-Object { $_.WorkingSet64 = 0 }"

powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
wmic process where name="explorer.exe" CALL setpriority "below normal"

echo %msg2%
echo %msg3%
echo %msg4%
echo %msg5%
pause & goto menu

:optimize_disk
if "%language%"=="english" (echo Optimizing disk space...) else if "%language%"=="russian" (echo Оптимизация дискового пространства...) else (echo Đang tối ưu hóa không gian đĩa...)
start /wait cleanmgr /sagerun:1
if "%language%"=="english" (echo Disk space has been optimized.) else if "%language%"=="russian" (echo Дисковое пространство оптимизировано.) else (echo Không gian đĩa đã được tối ưu hóa.)
pause & goto menu

:high_performance
if "%language%"=="english" (echo Enabling high performance mode...) else if "%language%"=="russian" (echo Включение режима высокой производительности...) else (echo Đang bật chế độ hiệu suất cao...)
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
if "%language%"=="english" (echo High performance mode has been enabled.) else if "%language%"=="russian" (echo Режим высокой производительности включен.) else (echo Chế độ hiệu suất cao đã được bật.)
pause & goto menu

:disable_windows_update
if "%language%"=="english" (echo Disabling Windows Update until 2050...) else if "%language%"=="russian" (echo Отключение Windows Update до 2050 года...) else (echo Đang tắt Windows Update đến năm 2050...)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
if "%language%"=="english" (echo Windows Update has been disabled until 2050.) else if "%language%"=="russian" (echo Windows Update отключен до 2050 года.) else (echo Windows Update đã bị tắt đến năm 2050.)
pause & goto menu

:start_printer
if "%language%"=="english" (echo Starting printer...) else if "%language%"=="russian" (echo Запуск принтера...) else (echo Đang khởi động máy in...)
net start Spooler
if "%language%"=="english" (echo Printer has been started.) else if "%language%"=="russian" (echo Принтер запущен.) else (echo Máy in đã được khởi động.)
pause & goto menu

:stop_printer
if "%language%"=="english" (echo Stopping printer...) else if "%language%"=="russian" (echo Остановка принтера...) else (echo Đang dừng máy in...)
net stop Spooler
if "%language%"=="english" (echo Printer has been stopped.) else if "%language%"=="russian" (echo Принтер остановлен.) else (echo Máy in đã được dừng.)
pause & goto menu

:enable_defender
if "%language%"=="english" (echo Enabling Windows Defender...) else if "%language%"=="russian" (echo Включение Windows Defender...) else (echo Đang bật Windows Defender...)
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f 2>>%logfile%
if "%language%"=="english" (echo Windows Defender has been enabled.) else if "%language%"=="russian" (echo Windows Defender включен.) else (echo Windows Defender đã được bật.)
pause & goto menu

:disable_defender
if "%language%"=="english" (echo Disabling Windows Defender...) else if "%language%"=="russian" (echo Отключение Windows Defender...) else (echo Đang tắt Windows Defender...)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
if "%language%"=="english" (echo Windows Defender has been disabled.) else if "%language%"=="russian" (echo Windows Defender отключен.) else (echo Windows Defender đã bị tắt.)
pause & goto menu

:remove_bloatware
if "%language%"=="english" (echo Removing bloatware...) else if "%language%"=="russian" (echo Удаление bloatware...) else (echo Đang xóa bloatware...)
powershell -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *Getstarted* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *WindowsCamera* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *bing* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *OneNote* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *people* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *WindowsPhone* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *photos* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *SkypeApp* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *solit* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *WindowsSoundRecorder* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage" 2>>%logfile% & powershell -Command "Get-AppxPackage *zune* | Remove-AppxPackage" 2>>%logfile%
if "%language%"=="english" (echo Bloatware has been removed.) else if "%language%"=="russian" (echo Bloatware удален.) else (echo Bloatware đã được xóa.)
pause & goto menu

:remove_edge
if "%language%"=="english" (echo Removing Microsoft Edge...) else if "%language%"=="russian" (echo Удаление Microsoft Edge...) else (echo Đang xóa Microsoft Edge...)
taskkill /F /IM msedge.exe >nul 2>&1
echo *** Removing Microsoft Edge ***
call :killdir C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe
call :killdir "C:\Program Files (x86)\Microsoft\Edge"
call :killdir "C:\Program Files (x86)\Microsoft\EdgeUpdate"
call :killdir "C:\Program Files (x86)\Microsoft\EdgeCore"
call :killdir "C:\Program Files (x86)\Microsoft\EdgeWebView"
echo *** Modifying registry ***
call :editreg
echo *** Removing shortcuts ***
call :delshortcut "C:\Users\Public\Desktop\Microsoft Edge.lnk"
call :delshortcut "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
call :delshortcut "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"
rmdir /s /q "C:\Program Files (x86)\Microsoft\Edge"
rmdir /s /q "C:\Program Files (x86)\Microsoft\EdgeCore"
rmdir /s /q "C:\Program Files (x86)\Microsoft\EdgeWebView"
rmdir /s /q "C:\Program Files (x86)\Microsoft\Temp"
for /f "delims=" %%a in ('dir /b "C:\Users"') do (
del /S /Q "C:\Users\%%a\Desktop\edge.lnk" >nul 2>&1
del /S /Q "C:\Users\%%a\Desktop\Microsoft Edge.lnk" >nul 2>&1)
if exist "C:\Windows\System32\MicrosoftEdgeCP.exe" (
for /f "delims=" %%a in ('dir /b "C:\Windows\System32\MicrosoftEdge*"') do (
takeown /f "C:\Windows\System32\%%a" > NUL 2>&1
icacls "C:\Windows\System32\%%a" /inheritance:e /grant "%UserName%:(OI)(CI)F" /T /C > NUL 2>&1
del /S /Q "C:\Windows\System32\%%a" > NUL 2>&1))
echo Finished!
pause & goto menu
:killdir
echo|set /p=Removing dir %1
if "%language%"=="english" (
    echo Stopping unnecessary services...
) else if "%language%"=="russian" (
    echo Остановка ненужных служб...
) else (
    echo Đang dừng các dịch vụ không cần thiết...
)
net stop "Windows Search" 2>nul
net stop "SysMain" 2>nul
net stop "DiagTrack" 2>nul
net stop "WerSvc" 2>nul
if "%language%"=="english" (
    echo Services have been stopped.
) else if "%language%"=="russian" (
    echo Службы остановлены.
) else (
    echo Các dịch vụ đã được dừng.
)
pause
goto menu

:free_ram
echo Freeing up RAM...
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
ipconfig /flushdns > nul
del /f /s /q %temp%\*.* > nul 2>&1
del /f /s /q %systemroot%\temp\*.* > nul 2>&1
for /f "skip=3 tokens=1" %%i in ('tasklist') do wmic process where name="%%i" call EmptyWorkingSet > nul 2>&1
start /wait cleanmgr /sagerun:1 /verylowdisk
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=0,MaximumSize=0
echo RAM has been freed and optimized.
pause
goto menu

:optimize_disk
if "%language%"=="english" (
    echo Optimizing disk space...
) else if "%language%"=="russian" (
    echo Оптимизация дискового пространства...
) else (
    echo Đang tối ưu hóa không gian đĩa...
)
start /wait cleanmgr /sagerun:1
if "%language%"=="english" (
    echo Disk space has been optimized.
) else if "%language%"=="russian" (
    echo Дисковое пространство оптимизировано.
) else (
    echo Không gian đĩa đã được tối ưu hóa.
)
pause
goto menu

:high_performance
if "%language%"=="english" (
    echo Enabling high performance mode...
) else if "%language%"=="russian" (
    echo Включение режима высокой производительности...
) else (
    echo Đang bật chế độ hiệu suất cao...
)
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
if "%language%"=="english" (
    echo High performance mode has been enabled.
) else if "%language%"=="russian" (
    echo Режим высокой производительности включен.
) else (
    echo Chế độ hiệu suất cao đã được bật.
)
pause
goto menu

:disable_windows_update
if "%language%"=="english" (
    echo Disabling Windows Update until 2050...
) else if "%language%"=="russian" (
    echo Отключение Windows Update до 2050 года...
) else (
    echo Đang tắt Windows Update đến năm 2050...
)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
if "%language%"=="english" (
    echo Windows Update has been disabled until 2050.
) else if "%language%"=="russian" (
    echo Windows Update отключен до 2050 года.
) else (
    echo Windows Update đã bị tắt đến năm 2050.
)
pause
goto menu

:start_printer
if "%language%"=="english" (
    echo Starting printer...
) else if "%language%"=="russian" (
    echo Запуск принтера...
) else (
    echo Đang khởi động máy in...
)
net start Spooler
if "%language%"=="english" (
    echo Printer has been started.
) else if "%language%"=="russian" (
    echo Принтер запущен.
) else (
    echo Máy in đã được khởi động.
)
pause
goto menu

:stop_printer
if "%language%"=="english" (
    echo Stopping printer...
) else if "%language%"=="russian" (
    echo Остановка принтера...
) else (
    echo Đang dừng máy in...
)
net stop Spooler
if "%language%"=="english" (
    echo Printer has been stopped.
) else if "%language%"=="russian" (
    echo Принтер остановлен.
) else (
    echo Máy in đã được dừng.
)
pause
goto menu

:enable_defender
if "%language%"=="english" (
    echo Enabling Windows Defender...
) else if "%language%"=="russian" (
    echo Включение Windows Defender...
) else (
    echo Đang bật Windows Defender...
)
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f 2>nul
if "%language%"=="english" (
    echo Windows Defender has been enabled.
) else if "%language%"=="russian" (
    echo Windows Defender включен.
) else (
    echo Windows Defender đã được bật.
)
pause
goto menu

:disable_defender
if "%language%"=="english" (
    echo Disabling Windows Defender...
) else if "%language%"=="russian" (
    echo Отключение Windows Defender...
) else (
    echo Đang tắt Windows Defender...
)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
if "%language%"=="english" (
    echo Windows Defender has been disabled.
) else if "%language%"=="russian" (
    echo Windows Defender отключен.
) else (
    echo Windows Defender đã bị tắt.
)
pause
goto menu

:remove_bloatware
if "%language%"=="english" (
    echo Removing bloatware...
) else if "%language%"=="russian" (
    echo Удаление bloatware...
) else (
    echo Đang xóa bloatware...
)
powershell -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Getstarted* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *WindowsCamera* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *bing* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *OneNote* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *people* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *WindowsPhone* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *photos* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *SkypeApp* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *solit* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *WindowsSoundRecorder* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *zune* | Remove-AppxPackage"
if "%language%"=="english" (
    echo Bloatware has been removed.
) else if "%language%"=="russian" (
    echo Bloatware удален.
) else (
    echo Bloatware đã được xóa.
)
pause
goto menu

:remove_edge
if "%language%"=="english" (
    echo Removing Microsoft Edge...
) else if "%language%"=="russian" (
    echo Удаление Microsoft Edge...
) else (
    echo Đang xóa Microsoft Edge...
)
taskkill /F /IM msedge.exe >nul 2>&1

echo *** Removing Microsoft Edge ***
call :killdir "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"
call :killdir "C:\Program Files (x86)\Microsoft\Edge"
call :killdir "C:\Program Files (x86)\Microsoft\EdgeUpdate"
call :killdir "C:\Program Files (x86)\Microsoft\EdgeCore"
call :killdir "C:\Program Files (x86)\Microsoft\EdgeWebView"

echo *** Modifying registry ***
call :editreg

echo *** Removing shortcuts ***
call :delshortcut "C:\Users\Public\Desktop\Microsoft Edge.lnk"
call :delshortcut "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
call :delshortcut "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"

echo Finished!
pause
goto menu

:killdir
echo|set /p=Removing dir %1
if exist %1 (
    takeown /a /r /d Y /f %1 > NUL
    icacls %1 /grant administrators:f /t > NUL
    rd /s /q %1 > NUL
    if exist %1 (
        echo ...Failed.
    ) else (
        echo ...Deleted.
    )
) else (
    echo ...does not exist.
)
exit /B 0

:editreg
echo|set /p=Editing registry
echo Windows Registry Editor Version 5.00 > RemoveEdge.reg
echo. >> RemoveEdge.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate] >> RemoveEdge.reg
echo "DoNotUpdateToEdgeWithChromium"=dword:00000001 >> RemoveEdge.reg
echo. >> RemoveEdge.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}] >> RemoveEdge.reg

regedit /s RemoveEdge.reg
del RemoveEdge.reg
echo ...done.
exit /B 0

:delshortcut
echo|set /p=Removing shortcut %1
if exist %1 (
    del %1
    echo ...done.
) else (
    echo ...does not exist.
)
exit /B 0

:enable_gaming_mode
echo Enabling Game Mode...
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f
echo Game Mode has been enabled.
pause
goto menu

:stop_fax_service
echo Stopping Fax service...
net stop Fax
sc config Fax start= disabled
echo Fax service has been stopped and disabled.
pause
goto menu

:optimize_network
echo Optimizing network...
ipconfig /flushdns
netsh int ip reset
ipconfig /release
ipconfig /renew
echo Network has been optimized.
pause
goto menu

:disable_tpm_check
echo Disabling TPM check for Windows 11...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d 1 /f
echo TPM check has been disabled.
pause
goto menu

:restart
echo Restarting computer...
shutdown /r /t 0
exit /B

:change_language
cls
echo Select language / Выберите язык / Chọn ngôn ngữ:
echo 1. English
echo 2. Русский
echo 3. Tiếng Việt
set /p lang_choice="Enter your choice (1-3): "
if "%lang_choice%"=="1" set language=english
if "%lang_choice%"=="2" set language=russian
if "%lang_choice%"=="3" set language=vietnamese
echo %language%>"%~dp0language.txt"
goto menu

:exit
exit
