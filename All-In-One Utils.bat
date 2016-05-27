@echo off
:start
echo Zach's All-In-One Utilities
rem cv is config viewer | nt is nettest | cnf is comp name find | q is quit


:begin
cls
echo Zach's All-In-One Utilities
echo.
echo.
echo Select a utility:
echo =============
echo.
echo 1. Network Utilities
echo 2. System
echo 3. Quit
echo.
echo =============
set /p op=Type option:
if "%op%"=="1" goto netbegin
if "%op%"=="2" goto sysbegin
if "%op%"=="3" goto q
if "%op%"=="4" goto ee1


:ee1
echo You found an Easter Egg, it fills you with Determination
pause
goto begin
color 18


:sysbegin
cls
echo Zach's All-In-One System Utilities
echo.
echo.
echo Select a utility:
echo =============
echo.
echo 1. System Info Viewer
echo 2. 
echo 3. 
echo 4. Quit
echo.
echo =============
set /p opsu=Type option:
if "%opsu%"=="1" goto siv
if "%opsu%"=="4" goto begin


:siv
cls
echo System Info Viewer
echo.
echo.
echo Select a utility:
echo =============
echo.
echo 1. Host Name
echo 2. Domain
echo 3. OS Name + Version
echo 4. System Model + Type
echo 5. Total Physical Memory
echo 6. IP Address
echo 7. Hard Drive Space
echo 8. Service Tag
echo 9. All of the above
echo 10. Quit
echo.
echo =============
set /p ops=Type option:
if "%ops%"=="1" goto hn
if "%ops%"=="2" goto do
if "%ops%"=="3" goto osnv
if "%ops%"=="4" goto sysmt
if "%ops%"=="5" goto ram
if "%ops%"=="6" goto ipa
if "%ops%"=="7" goto hdds
if "%ops%"=="8" goto st
if "%ops%"=="9" goto allabove
if "%ops%"=="10" goto sysbegin

:hn
for /F "usebackq" %%i IN (`hostname`) DO SET hn1=%%i
echo %hn1%
pause
goto siv

:do
echo %userdomain%
pause
goto siv

:osnv
systeminfo | findstr /c:"OS Name" 
systeminfo | findstr /c:"OS Version" 
pause
goto siv

:sysmt
systeminfo | findstr /c:"System Manufacturer"
systeminfo | findstr /c:"System Model"
systeminfo | findstr /c:"System Type"
pause
goto siv

:ram
systeminfo | findstr /c:"Total Physical Memory" 
pause
goto siv

:ipa
ipconfig | findstr IP
pause
goto siv

:hdds
echo Hard Drive Space:
wmic diskdrive get size
pause
goto siv

:st
echo Service Tag:
wmic bios get serialnumber
pause
goto siv

:cpu
echo CPU:
wmic cpu get name
pause
goto siv

:hddfs
echo Hard Drive Free Space:
wmic logicaldisk where "DeviceID='C:'" get FreeSpace
pause
goto siv

REM ==================

:allabove
systeminfo | findstr /c:"Host Name" 


systeminfo | findstr /c:"Domain" 
systeminfo | findstr /c:"OS Name" 
systeminfo | findstr /c:"OS Name" 
systeminfo | findstr /c:"System Manufacturer"
systeminfo | findstr /c:"System Model"
systeminfo | findstr /c:"System Type"
systeminfo | findstr /c:"Total Physical Memory"
ipconfig | findstr IP
echo Hard Drive Space:
wmic diskdrive get size
echo Service Tag:
wmic bios get serialnumber
echo CPU:
wmic cpu get name
echo Hard Drive Free Space:
wmic logicaldisk where "DeviceID='C:'" get FreeSpace
pause
goto siv



:netbegin
cls
echo Zach's All-In-One Network Utilities
echo.
echo.
echo Select a utility:
echo =============
echo.
echo 1. Config Viewer
echo 2. Network Tester
echo 3. Computer Name finder
echo 4. Quit
echo.
echo =============
set /p opn=Type option:
if "%opn%"=="1" goto cv
if "%opn%"=="2" goto nt
if "%opn%"=="3" goto cnf
if "%opn%"=="4" goto begin


echo Please Pick an option:
goto begin




REM Start of CV
REM =============
:cv
cls
echo You have selected Config Viewer
for /f "delims=[] tokens=2" %%a in ('ping %computername% -n 1 -4 ^| findstr "["') do (set cvip4=%%a)
for /f "tokens=1-2 delims=:" %%a in ('ipconfig /all^|find "DNS"') do set cvdns=%%b
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "Default"') do set cvdg=%%b
for /f "delims=[] tokens=2" %%a in ('ping %computername% -n 1 ^| findstr "["') do (set cvip6=%%a)
echo Your IPV4 Address/IP is: %cvip4%
echo Your IPV6 Address/IP is: %cvip6%
echo Your DNS Server is: %cvdns%
echo Your Default Gateway is: %cvdg%
pause
goto netbegin

REM Start of NT
REM ===================
:nt
cls
echo.
echo.
echo Select a utility:
echo =============
echo.
echo 1. General Test
echo 2. Router Test
echo 3. DNS Test 1
echo 4. Quit
echo.
echo =============
set /p op2=Select Option:
if "%op2%"=="1" goto ntstart
if "%op2%"=="2" goto ntrt
if "%op2%"=="3" goto ntdns1
if "%op2%"=="4" goto netbegin



:ntrt
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "Default"') do set ntdg=%%b
echo Checking Router
ping -n 2 %ntdg%|find "Reply from " >NUL
if not errorlevel 1 goto :ntrtsuccess
if     errorlevel 1 goto :ntnetdown

:ntrtsuccess
echo Your internet is working, if you are still having issues, run General Test
pause
goto nt

:ntdns1
for /f "tokens=1-2 delims=:" %%a in ('ipconfig /all^|find "DNS"') do set ntdns=%%b
ping -n 1 %ntdns%|find "Reply from " >nul
if not errorlevel 1 goto :ntdns1yay
if     errorlevel 1 goto :ntdns1no

:ntdns1yay
echo A ping to your DNS Server completed succesfully, if you are still having issues run General Test
pause
goto :nt

:ntdns1no
echo A ping to your DNS Server did not complete succesfully
pause
goto :nt

:ntstart
echo Checking Connection to Google, please wait...
ping -n 1 www.google.com|find "Reply from " >NUL
if not errorlevel 1 goto :ntsuccess
if     errorlevel 1 goto :ntretry

:ntretry
echo Faliure on 1st test!
echo Trying again but to Google DNS
ping -n 1 8.8.4.4|find "Reply from " >NUL
if not errorlevel 1 goto :ntsuccess2
if     errorlevel 1 goto :nttryip

:nttryip
echo Faliure on 2nd test!
echo Checking DNS...
echo Let's try Google via IP
ping -n 1 216.239.37.99|find "Reply from " >NUL
if not errorlevel 1 goto :ntsuccessdns
if     errorlevel 1 goto :nttryrouter

:nttryrouter
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "Default"') do set ntdg=%%b
echo Checking Router
ping -n 2 %ntdg%|find "Reply from " >NUL
if not errorlevel 1 goto :ntroutersuccess
if     errorlevel 1 goto :ntnetdown

:ntroutersuccess
echo It seems you can reach your router, but cannot reach the internet
goto :ntfaliure

:ntnetdown
echo Faliure!
echo It seems you are having network issues and cannot reach your router
echo Check that your networking cable is plugged in
goto :ntfaliure

:ntsuccessdns
echo It appears you are having DNS issyes
goto :ntfaliure

:ntsuccess
echo You have an active Internet/Network connection
pause
goto nt


:ntsuccess2
echo You have an active Internet/Network connection
pause
goto nt

:ntfaliure
echo You do not have an active Internet/Network connection
pause
goto nt

rem =========================================


:cnf
for /f "skip=1 delims=" %%A in ('wmic computersystem get name') do for /f "delims=" %%B in ("%%A") do set "cnfcompname=%%A"
echo Your Computer Name is %cnfcompname%
pause
goto netbegin


