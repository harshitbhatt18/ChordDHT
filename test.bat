@echo off
echo Chord Protocol DHT Test Script for Windows
echo ==========================================

set port1=9000
set port2=9200
set port3=9300

echo.
echo Starting node on port: %port1%
start /b python Node_DHT.py %port1%
timeout /t 2 /nobreak >nul

echo.
echo Starting node on port: %port2%
start /b python Node_DHT.py %port2% %port1%
timeout /t 4 /nobreak >nul

echo.
echo Starting node on port: %port3%
start /b python Node_DHT.py %port3% %port1%
timeout /t 8 /nobreak >nul

set key1=good
set val1=world
set key2=corona
set val2=virus

echo.
echo Testing DHT operations...
echo.
echo Inserting %key1%:%val1% on port %port2%
echo insert^|%key1%:%val1% | nc localhost %port2%
echo.

echo Searching for key=%key1% on port %port3%
echo search^|%key1% | nc localhost %port3%
echo.

echo Inserting %key2%:%val2% on port %port3%
echo insert^|%key2%:%val2% | nc localhost %port3%
echo.

echo Searching for key=%key2% on port %port1%
echo search^|%key2% | nc localhost %port1%
echo.

echo Test completed. Press any key to stop all nodes...
pause >nul

echo Stopping all nodes...
taskkill /f /im python.exe >nul 2>&1
echo All nodes stopped. 