@echo off
setlocal enabledelayedexpansion

:: 1. ตั้งชื่อโฟลเดอร์สำหรับเก็บไฟล์ (จะสร้างไว้ที่เดียวกับไฟล์ .bat นี้)
set "outDir=%~dp0Converted_VTT"

:: 2. สร้างโฟลเดอร์ถ้ายังไม่มี
if not exist "%outDir%" (
    mkdir "%outDir%"
)

echo --------------------------------------------------
echo  Subtitle Converter (SRT to VTT) - Drag ^& Drop
echo --------------------------------------------------

:: 3. วนลูปประมวลผลไฟล์ทุกไฟล์ที่ถูกลากมาวาง
for %%i in (%*) do (
    :: ตรวจสอบว่าเป็นไฟล์ .srt หรือไม่ (ไม่สนตัวพิมพ์เล็ก-ใหญ่)
    if /i "%%~xi"==".srt" (
        echo Converting: "%%~nxi"
        ffmpeg -i "%%~i" "%outDir%\%%~ni.vtt" -loglevel error -y
    ) else (
        echo [Skip] "%%~nxi" is not an SRT file.
    )
)

echo --------------------------------------------------
echo Done! All files are saved in: 
echo "%outDir%"
echo --------------------------------------------------
:: เช็กว่าถ้าไม่มี Error ให้ปิดจอ ถ้ามี Error ให้ค้างไว้
if %errorlevel% equ 0 (exit) else (pause)