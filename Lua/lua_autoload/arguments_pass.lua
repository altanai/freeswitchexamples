#!/usr/bin/lua
freeswitch.consoleLog("info","------------------------------------------- arguments_pass sample -------------------------------")
var1 = argv[1]      -- First argument
var2 = argv[2]      -- Second argumenti
freeswitch.consoleLog("info", tostring(var1) .. "\n")
freeswitch.consoleLog("info", tostring(var2) .. "\n")

--[[
output
switch_cpp.cpp:1376 ------------------------------------------- arguments_pass sample -------------------------------
[INFO] switch_cpp.cpp:1376 altanai
[INFO] switch_cpp.cpp:1376 bisht
]]