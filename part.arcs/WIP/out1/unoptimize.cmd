@echo off
gifsicle.exe --colors 256 %1 -o %~n1_1.gif
gifsicle.exe --unoptimize %~n1_1.gif -o %~n1_2.gif
gifsicle.exe --colors 2 %~n1_2.gif -o %1
del %~n1_1.gif
del %~n1_2.gif
