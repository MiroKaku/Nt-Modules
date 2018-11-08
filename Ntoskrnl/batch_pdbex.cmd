@ECHO OFF

SETlOCAL enabledelayedexpansion

::指定起始文件夹
SET DIR="%cd%"
ECHO DIR=%DIR%

SET TOOL_FILE=pdbex.exe

:: 参数 /R 表示需要遍历子文件夹,去掉表示不遍历子文件夹
:: %%f 是一个变量,类似于迭代器,但是这个变量只能由一个字母组成,前面带上%%
:: 括号中是通配符,可以指定后缀名,*.*表示所有文件

FOR /R %DIR% %%f IN (*.exe) DO ( 
    SET TARGET_FILE=%%f
    SET FILE_DIR=%%~dpf
    SET FILE_NAME_NOT_PATH=%%~nxf
    SET FULL_PATH_NOT_EXT=%%~dpnf

    IF NOT !FILE_NAME_NOT_PATH!==%TOOL_FILE% (

        ECHO 生成代码: !FULL_PATH_NOT_EXT!

        CALL %TOOL_FILE% %%%% !TARGET_FILE! -o !FULL_PATH_NOT_EXT! -c -p- -j- -x- -z-
        
        rem GOTO :EOF
    )

)
pause
