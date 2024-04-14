gifsicle.exe --colors 256 %1 -o _1.gif
gifsicle.exe --unoptimize _1.gif -o _2.gif
gifsicle.exe --colors 2 _2.gif -o _3.gif

rem inverse colors
gifsicle.exe --change-color #ffffff #000000 --change-color #000000 #ffffff _3.gif -o _4.gif

del _1.gif
del _2.gif
del _3.gif
del %~n1-unoptimized.gif

rename _4.gif %~n1-unoptimized.gif