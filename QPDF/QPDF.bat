chcp 65001 >nul
@echo off&setlocal enabledelayedexpansion

set PDFPath=%~1

set QPDFPath=%~dp0QPDF-MSVC32\bin
set QPDF=%QPDFPath%\qpdf.exe
set QPDFSourcePath=%~dp0000Source
set QPDFTargetPath=%~dp0000Target

echo QPDF List
echo.
echo 1. PDF 截取 (对文件，结果与源文件同路径)
echo 2. PDF 分拆 (对文件，结果在 000Target)
echo 3. PDF 合并 (对文件，结果在 000Target)
echo 4. PDF 压缩 (对文件，结果与源文件同路径)
echo 5. PDF 旋转 (对文件，结果与源文件同路径)
echo 6. PDF 水印 (批量，结果在 000Target)
echo 7. PDF 加密 (批量，结果在 000Target)
echo 8. PDF 偶数页化 (批量，奇数页 PDF 最后增加空白页，结果在 000Target)
echo.
set /p choose=请选择处理方式：
if "%choose%"=="1" Goto QPDFPagesA
if "%choose%"=="2" Goto QPDFPagesB
if "%choose%"=="3" Goto QPDFPagesC
if "%choose%"=="4" Goto QPDFCompress
if "%choose%"=="5" Goto QPDFRotate
if "%choose%"=="6" Goto QPDFOverlay
if "%choose%"=="7" Goto QPDFEncrypt
if "%choose%"=="8" Goto QPDFAddBlank
exit

:QPDFPagesA
if defined PDFPath ( echo 脚本启动时已带入路径： %1) else set /p PDFPath=请输入需要处理的 PDF 文件路径并回车:
set /p QPDFOPT=请输入需要截取的页数（支持 1,2 或 1-3 或 2-z）：
cd %QPDFTargetPath%
echo 正在处理 %PDFPath%
%QPDF% --empty --pages "%PDFPath%" "%QPDFOPT%" -- "%PDFPath%-A.pdf"
exit

:QPDFPagesB
if defined PDFPath ( echo 脚本启动时已带入路径： %1) else set /p PDFPath=请输入需要处理的 PDF 文件路径并回车:
echo 正在处理 %PDFPath%
%QPDF% --split-pages=1 "%PDFPath%" %QPDFTargetPath%\outfile.pdf
pause
exit

:QPDFPagesC
echo 请确认所有需要合并的文件已按顺序命名并放入 %QPDFSourcePath% 内。
pause.
cd %QPDFTargetPath%
%QPDF% --empty --pages %QPDFSourcePath%\*.pdf -- COMBINED.pdf
echo 正在处理 %PDFPath%
pause
exit

:QPDFCompress
if defined PDFPath ( echo 脚本启动时已带入路径： %1) else set /p PDFPath=请输入需要处理的 PDF 文件路径并回车:
echo 正在处理 %PDFPath%
%QPDF% "%PDFPath%" --stream-data=compress -- "%PDFPath%-Compress.pdf"
pause
exit

:QPDFRotate
echo 实例：
echo +90:1 ：第一页顺时针旋转 90 度。
echo -90:1,2 ：第二页顺时针旋转 90 度。
if defined PDFPath ( echo 脚本启动时已带入路径： %1) else set /p PDFPath=请输入需要处理的 PDF 文件路径并回车:
set /p QPDFOPT=请输入旋转参数:
echo 正在处理 %PDFPath%
%QPDF% "%PDFPath%" "%PDFPath%-Rotate.pdf" --rotate=%QPDFOPT%
pause
exit

:QPDFOverlay
echo.
echo 水印 PDF 文件（watermark.pdf）请放在 QPDF.exe 的同一目录
echo.
pause
for /r %QPDFSourcePath% %%a in (*.pdf) do (
    echo 正在给 %%~na 加水印
	%QPDF% "%%a" --overlay watermark.pdf -- %QPDFTargetPath%\%%~na-WM.pdf
	echo.
    )
exit

:QPDFEncrypt
echo.
echo 默认设置用户密码，且允许复制内容，如需变更限制，请自行参考帮助文件修改。
echo.
set /p user_pw=请输入加密密码（留空默认123456）：

if "%user_pw%"=="" set user_pw=123456

for /r %QPDFSourcePath% %%a in (*.pdf) do (
    echo 正在给 %%~na 加密
	%QPDF% --encrypt %user_pw% %user_pw% 256 -- "%%a" %QPDFTargetPath%\%%~na-PW.pdf
	echo.
    )
    pause
exit

:QPDFAddBlank
for /r %QPDFSourcePath% %%a in (*.pdf) do (
    for /f "delims=*" %%i in ('%QPDF% %%a --show-npages') do (
        set Number=%%i%
        set /a Remainder=!Number!%%2
        if !Remainder! equ 0 (
            echo 双页文件，无需处理
            copy /y %%a %QPDFTargetPath%\%%~na-NB.pdf
        ) else (
            echo 单页文件，添加空白页
            %QPDF% blank.pdf --pages %%a . -- %QPDFTargetPath%\%%~na-AB.pdf
        )
    )
)
pause
exit

:: vim: set expandtab foldmethod=marker softtabstop=4 shiftwidth=4:
