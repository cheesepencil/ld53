pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
#include collisions.lua
#include constants.lua
#include splash.lua
#include gators.lua
#include camera.lua
#include world.lua
#include bird.lua
#include baby.lua
#include main.lua
__gfx__
00000000000000000000000000000000000700000000000000000000000000000000000055555000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000700000000000000000000000000330000000005550000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000700000000000000000000000003370009999995559000000000000000000000000000000000000000000000000000
06666006600000000000000000000000000700000000000003000000003337000099999999999900000000000000000000000000000000000000000000000000
067777076001600000000000000160000ee7efe00000000030003330034300000999999999999990000000000000000000000000000000000000000000000000
000677607601110000000000000111000077eee00000000030333333333370779999999999999999000000000000000000000000000000000000000000000000
000067707607700000000000000770000ee7e0000b00000033333333333333330044444444444400000000000000000000000000000000000000000000000000
00000676667799990000000000779999000000000b0b000000030300030300000044444444444400000000000000000000000000000000000000000000000000
00000677777000000000000777700000000000000000000000000000000000000049999444999400000000000000000000000000000000000000000000000000
00000777770000000000077777000000000000000000000000000000000000000049559444999400000000000000000000000000000000000000000000000000
77777777700000007777777776000000000000000000000000000000000000000049559444999400000000000000000000000000000000000000000000000000
77709009000000007770777966000000000000000000000003000000003300000049559444999400000000000000000000000000000000000000000000000000
00009009000000000000776960000000000000000000000030003330034300300049999444599400000000000000000000000000000000000000000000000000
0009009000000000000776900000000000000000000bb00030333333333333330044444444599400000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000b0000bbbb0033333333333333330044444444999400000000000000000000000000000000000000000000000000
000000000000000000000000000000000b00bb00000bb00000030300030300000044444444999400000000000000000000000000000000000000000000000000
