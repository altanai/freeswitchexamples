

freeswitch.consoleLog("WARNING","Before first call")
first_session = freeswitch.Session("user/1011")
if (first_session:ready()) then  
freeswitch.consoleLog("WARNING","first leg answeredn")
second_session = freeswitch.Session("user/1010")  
if (second_session:ready()) then
freeswitch.consoleLog("WARNING","second leg answeredn")  
freeswitch.bridge(first_session, second_session)
freeswitch.consoleLog("WARNING","After bridgen")  
else
freeswitch.consoleLog("WARNING","second leg failedn")  
end
else  
freeswitch.consoleLog("WARNING","first leg failedn")
end





--[[
Output

2019-09-25 07:44:33.503863 [NOTICE] switch_channel.c:1104 New Channel sofia/internal/altanai@106.51.78.22:50037 [310277e3-4e42-41d0-8906-dba93e35c5d6]


   INVITE sip:altanai@106.51.78.22:50037;rinstance=c14e4a9ba6020f9b SIP/2.0
   Via: SIP/2.0/UDP 10.130.74.15;rport;branch=z9hG4bK31Z086ce8UtXK
   Max-Forwards: 70
   From: "" <sip:0000000000@10.130.74.15>;tag=3SvHQr98DK0vN
   To: <sip:altanai@106.51.78.22:50037;rinstance=c14e4a9ba6020f9b>
   Call-ID: 281334aa-5a0b-1238-d29d-02a933b32da0
   CSeq: 10144944 INVITE
   Contact: <sip:mod_sofia@10.130.74.15:5060>
   User-Agent: FreeSWITCH-mod_sofia/1.9.0-742-8f1b7e0~64bit
   Allow: INVITE, ACK, BYE, CANCEL, OPTIONS, MESSAGE, INFO, UPDATE, REGISTER, REFER, NOTIFY, PUBLISH, SUBSCRIBE
   Supported: timer, path, replaces
   Allow-Events: talk, hold, conference, presence, as-feature-event, dialog, line-seize, call-info, sla, include-session-description, presence.winfo, message-summary, refer
   Content-Type: application/sdp
   Content-Disposition: session
   Content-Length: 1210
   X-FS-Support: update_display,send_info
   Remote-Party-ID: <sip:0000000000@10.130.74.15>;party=calling;screen=yes;privacy=off


   ]]