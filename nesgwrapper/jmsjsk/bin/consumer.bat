@echo off
rem #******************************************************************************
rem # Copyright (c) 2021 L3Harris Technologies
rem #
rem #
rem # Permission is hereby granted, free of charge, to any person obtaining a copy
rem # of this software and associated documentation files (the "Software"), to deal
rem # in the Software without restriction, including without limitation the rights
rem # to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
rem # copies of the Software, and to permit persons to whom the Software is
rem # furnished to do so, subject to the following conditions:
rem #
rem # The above copyright notice and this permission notice shall be included in all
rem # copies or substantial portions of the Software.
rem #
rem # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
rem # IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
rem # FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
rem # AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
rem # LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
rem # OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
rem # SOFTWARE.
rem #******************************************************************************

setLocal EnableDelayedExpansion

set CLASSPATH=..\conf

for /f %%f in ('dir ..\lib\ /b') do (
   set CLASSPATH=!CLASSPATH!;..\lib\%%f
)

for /f %%f in ('dir ..\lib\solace /b') do (
   set CLASSPATH=!CLASSPATH!;..\lib\solace\%%f
)

for /f %%f in ('dir ..\lib\activemq /b') do (
   set CLASSPATH=!CLASSPATH!;..\lib\activemq\%%f
)

for /f %%f in ('dir ..\lib\weblogic /b') do (
   set CLASSPATH=!CLASSPATH!;..\lib\weblogic\%%f
)


if not "%JAVA_HOME%" == "" (
   set "JAVA=%JAVA_HOME%\bin\java.exe"
) else (
   set "JAVA=java"
)

%JAVA% -cp %CLASSPATH% com.harris.gcsd.dex.jumpstart.Consumer %*

endLocal

