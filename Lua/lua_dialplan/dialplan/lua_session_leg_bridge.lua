freeswitch.consoleLog("WARNING","-------- Before first call")

first_session = freeswitch.Session("user/altanai")
if (first_session:ready()) then  
	freeswitch.consoleLog("WARNING","--------- first leg answered")

	second_session = freeswitch.Session("user/bob")  
	if (second_session:ready()) then
		freeswitch.consoleLog("WARNING","------- second leg answered")  

		freeswitch.bridge(first_session, second_session)
		freeswitch.consoleLog("WARNING","--------- After bridging")  
	else
		freeswitch.consoleLog("WARNING","second leg failed")  
	end
else  
	freeswitch.consoleLog("WARNING","first leg failed")
end

-- Script for sipp to start the first call to 5001 , after which FS dials out altanaia nd bob 
-- sipp -sn uac -s 5001 x.x.x.x:5060 -m 1 -d 20000 -mp 6001 -mi 127.0.0.1 

--[[
Output :
Dialplan: sofia/internal/bob@x.x.x.x Action lua(/etc/freeswitch/dialplan/lua_session_leg_bridge.lua) 
EXECUTE sofia/internal/bob@x.x.x.x lua(/etc/freeswitch/dialplan/lua_session_leg_bridge.lua)

...Incoming call
[NOTICE] switch_channel.c:1104 New Channel sofia/internal/altanai@x.x.x.x:7494 [a096c009-3045-4f03-a416-b652397a8b29]
EXECUTE sofia/internal/sipp@fx.x.x.x:5060 lua(/etc/freeswitch/dialplan/lua_session_leg_bridge.lua)

[WARNING] switch_cpp.cpp:1376 -------- Before first call
.. Leg 1 
[NOTICE] switch_channel.c:1104 New Channel sofia/internal/altanai@x.x.x.x:5284 [ed7a825a-3e08-4372-82ca-428b1778a409]
[NOTICE] sofia.c:8427 Channel [sofia/internal/altanai@x.x.x.x:5284] has been answered
[WARNING] switch_cpp.cpp:1376 --------- first leg answered
[DEBUG] switch_ivr_originate.c:2159 Parsing global variables
.. Leg 2 
[NOTICE] switch_channel.c:1104 New Channel sofia/internal/bob@x.x.x.x:35733 [6f40d42a-fbca-4af3-a772-36c344b7d75c]
[NOTICE] sofia.c:8427 Channel [sofia/internal/bob@x.x.x.x:35733] has been answered
[WARNING] switch_cpp.cpp:1376 ------- second leg answered

[DEBUG] switch_ivr_bridge.c:1639 (sofia/internal/bob@x.x.x.x:35733) State Change CS_SOFT_EXECUTE -> CS_CONSUME_MEDIA
 ]]