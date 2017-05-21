@echo off

set EXEC="C:\Program Files\ImageMagick-6.8.9-Q16\convert.exe"
set OUTPUT_FILE_PREFIX=KRSLaunch
set ORIGINAL_FILE_x1=moconavi_logo_hafe.png
set ORIGINAL_FILE_x2=moconavi_logo_x2.png
set ORIGINAL_FILE568=moconavi_logo_568.png
set ORIGINAL_FILE_IPAD_x1=moconavi_logo_pad.png
set ORIGINAL_FILE_ORG=moconavi_logo_new.png

echo %ORIGINAL_FILE_ORG% to %ORIGINAL_FILE_x1%
%EXEC% -resize 30%% %ORIGINAL_FILE_ORG% %ORIGINAL_FILE_x1%
echo %ORIGINAL_FILE_ORG% to %ORIGINAL_FILE_x2%
%EXEC% -resize 60%% %ORIGINAL_FILE_ORG% %ORIGINAL_FILE_x2%
echo %ORIGINAL_FILE_ORG% to %ORIGINAL_FILE568%
%EXEC% -resize 71%% %ORIGINAL_FILE_ORG% %ORIGINAL_FILE568%
echo %ORIGINAL_FILE_ORG% to %ORIGINAL_FILE_IPAD_x1%
%EXEC% -resize 50%% %ORIGINAL_FILE_ORG% %ORIGINAL_FILE_IPAD_x1%

echo output %OUTPUT_FILE_PREFIX% file

%EXEC% -gravity center -background white -extent 320x480  %ORIGINAL_FILE_x1% %OUTPUT_FILE_PREFIX%.png
%EXEC% -gravity center -background white -extent 640x960  %ORIGINAL_FILE_x2% %OUTPUT_FILE_PREFIX%@2x.png
%EXEC% -gravity center -background white -extent 640x1136 %ORIGINAL_FILE568% %OUTPUT_FILE_PREFIX%-568h@2x.png

%EXEC% -gravity center -background white -extent 768x1024  %ORIGINAL_FILE_IPAD_x1%  %OUTPUT_FILE_PREFIX%~ipad-Portrait70.png
%EXEC% -gravity center -background white -extent 1536x2048 %ORIGINAL_FILE_ORG%  %OUTPUT_FILE_PREFIX%~ipad-Portrait@2x70.png

%EXEC% -gravity center -background white -extent 768x1004  %ORIGINAL_FILE_IPAD_x1%  %OUTPUT_FILE_PREFIX%~ipad.png
%EXEC% -gravity center -background white -extent 1536x2008 %ORIGINAL_FILE_ORG%  %OUTPUT_FILE_PREFIX%-Portrait@2x~ipad.png

%EXEC% -gravity center -background white -extent 1024x768  %ORIGINAL_FILE_IPAD_x1%  %OUTPUT_FILE_PREFIX%~ipad-Landscape70.png
%EXEC% -gravity center -background white -extent 2048x1536 %ORIGINAL_FILE_ORG%  %OUTPUT_FILE_PREFIX%~ipad-Landscape@2x70.png

%EXEC% -gravity center -background white -extent 1024x748  %ORIGINAL_FILE_IPAD_x1%  %OUTPUT_FILE_PREFIX%-Landscape~ipad.png
%EXEC% -gravity center -background white -extent 2048x1496 %ORIGINAL_FILE_ORG%  %OUTPUT_FILE_PREFIX%-Landscape@2x~ipad.png

del %ORIGINAL_FILE_x1%
del %ORIGINAL_FILE_x2%
del %ORIGINAL_FILE568%
del %ORIGINAL_FILE_IPAD_x1%

pause

