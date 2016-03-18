@echo off    
for /F "eol=c tokens=1" %%i in (%1) do "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" %%i

