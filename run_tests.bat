@echo off

SET rep=500
SET output=-o junit

echo --------------------------------------------------------------------------------
echo --                             Testing on Lua 5.1                             --
lua run_tests.lua -s -r %rep% %output% -n lava51
echo --------------------------------------------------------------------------------
echo.
echo.

echo --------------------------------------------------------------------------------
echo --                              Testing on LuaJIT                             --
luajit run_tests.lua -s -r %rep% %output% -n lavajit
echo --------------------------------------------------------------------------------
echo.
echo.

echo --------------------------------------------------------------------------------
echo --                             Testing on Lua 5.2                             --
lua52 run_tests.lua -s -r %rep% %output% -n lava52
echo --------------------------------------------------------------------------------
echo.
echo.

echo --------------------------------------------------------------------------------
echo --                             Testing on Lua 5.3                             --
lua53 run_tests.lua -s -r %rep% %output% -n lava53
echo --------------------------------------------------------------------------------