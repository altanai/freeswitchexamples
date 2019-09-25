-- Answer call, play a prompt, hang up
-- Set the path separator
pathsep = '/'
-- Windows users do this instead:
-- pathsep = ''
-- Answer the call
freeswitch.consoleLog("WARNING","Not yet answered")
session:answer()
freeswitch.consoleLog("WARNING","Already answered")
-- Create a string with path and filename of a sound file
prompt ="ivr" ..pathsep .."ivr-welcome_to_freeswitch.wav"
-- Play the prompt
freeswitch.consoleLog("WARNING","About to play '" .. prompt .."'n")
session:streamFile(prompt)
freeswitch.consoleLog("WARNING","After playing '" .. prompt .."'n")
-- Hangup
session:hangup()
freeswitch.consoleLog("WARNING","Afterhangupn")

--[[
output :
[INFO] mod_dialplan_xml.c:637 Processing altanai <altanai>->5000 in context public
EXECUTE sofia/internal/altanai@x.x.x.x lua(/etc/freeswitch/dialplan/lua_session_answer_prompt_hangup.lua)
[WARNING] switch_cpp.cpp:1376 Not yet answered
...
[DEBUG] switch_channel.c:3781 (sofia/internal/altanai@x.x.x.x) Callstate Change EARLY -> ACTIVE
[WARNING] switch_cpp.cpp:1376 Already answered
[WARNING] switch_cpp.cpp:1376 About to play 'ivr/ivr-welcome_to_freeswitch.wav
...
[DEBUG] switch_ivr_play_say.c:1942 done playing file /usr/share/freeswitch/sounds/en/us/callie/ivr/ivr-welcome_to_freeswitch.wav
[WARNING] switch_cpp.cpp:1376 After playing 'ivr/ivr-welcome_to_freeswitch.wav'n [DEBUG] switch_cpp.cpp:731 CoreSession::hangup
[NOTICE] switch_cpp.cpp:733 Hangup sofia/internal/altanai@x.x.x.x [CS_EXECUTE] [NORMAL_CLEARING]
[WARNING] switch_cpp.cpp:1376 Afterhangup
]]                                             