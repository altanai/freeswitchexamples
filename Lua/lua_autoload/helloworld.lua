
--single line comment 
--[[ 
multi
line 
comment
]]
freeswitch.consoleLog("info","------------------------------------------- hello world -------------------------------")
freeswitch.consoleLog("notice", "SECTION " .. XML_REQUEST["section"] .. "\n")
freeswitch.consoleLog("info",params:serialize())

--[[ multi line comment 

output of above  : 

[INFO] switch_cpp.cpp:1376 ------------------------------------------- hello world -------------------------------2019-09-24 11:30:51.267996 [NOTICE] switch_cpp.cpp:1376 SECTION dialplan
[INFO] switch_cpp.cpp:1376 Event-Name: REQUEST_PARAMS
Core-UUID: 7f7bf79b-6f9b-40bb-865a-df0ec9a1637a
FreeSWITCH-Hostname: ip-x-x-x-x
FreeSWITCH-Switchname: ip-x-x-x-x
FreeSWITCH-IPv4: x.x.x.x
FreeSWITCH-IPv6: fe80%3A%3Aa9%3A33ff%3Afeb3%3A2da0
Event-Date-Local: 2019-09-24%2011%3A30%3A51
Event-Date-GMT: Tue,%2024%20Sep%202019%2011%3A30%3A51%20GMT
Event-Date-Timestamp: 1569324651267996
Event-Calling-File: mod_dialplan_xml.c
Event-Calling-Function: dialplan_xml_locate
Event-Calling-Line-Number: 608
Event-Sequence: 536
Channel-State: CS_ROUTING
Channel-Call-State: RINGING
Channel-State-Number: 2
Channel-Name: sofia/internal/2222222222%40x.x.x.x
Unique-ID: b3fe45ad-78ad-4d33-b70e-644e48969805
Call-Direction: inbound
Presence-Call-Direction: inbound
Channel-HIT-Dialplan: true
Channel-Presence-ID: 2222222222%40x.x.x.x
Channel-Call-UUID: b3fe45ad-78ad-4d33-b70e-644e48969805
Answer-State: ringing
Caller-Direction: inbound
Caller-Logical-Direction: inbound
Caller-Username: 2222222222
Caller-Dialplan: XML
Caller-Caller-ID-Name: 2222222222
Caller-Caller-ID-Number: 2222222222
Caller-Orig-Caller-ID-Name: 2222222222
Caller-Orig-Caller-ID-Number: 2222222222
Caller-Network-Addr: x.x.x.x
Caller-ANI: 2222222222
Caller-Destination-Number: 9999999999
Caller-Unique-ID: b3fe45ad-78ad-4d33-b70e-644e48969805
Caller-Source: mod_sofia
Caller-Context: public
Caller-Channel-Name: sofia/internal/2222222222%40x.x.x.x
Caller-Profile-Index: 1
Caller-Profile-Created-Time: 1569324651267996
Caller-Channel-Created-Time: 1569324651267996
Caller-Channel-Answered-Time: 0
Caller-Channel-Progress-Time: 0
Caller-Channel-Progress-Media-Time: 0
Caller-Channel-Hangup-Time: 0
Caller-Channel-Transfer-Time: 0
Caller-Channel-Resurrect-Time: 0
Caller-Channel-Bridged-Time: 0
Caller-Channel-Last-Hold: 0
Caller-Channel-Hold-Accum: 0
Caller-Screen-Bit: true
Caller-Privacy-Hide-Name: false
Caller-Privacy-Hide-Number: false
variable_direction: inbound
variable_uuid: b3fe45ad-78ad-4d33-b70e-644e48969805
variable_session_id: 1
variable_sip_from_user: 2222222222
variable_sip_from_uri: 2222222222%40x.x.x.x
variable_sip_from_host: x.x.x.x
variable_video_media_flow: disabled
variable_audio_media_flow: disabled
variable_text_media_flow: disabled
variable_channel_name: sofia/internal/2222222222%40x.x.x.x
variable_sip_call_id: 99140ZjE1YWVmZjQ3MWJhMGFlMGVjMDUwOTdmY2MzYzFiMTQ
variable_sip_local_network_addr: x.x.x.x
variable_sip_network_ip: x.x.x.x
variable_sip_network_port: 20729
variable_sip_invite_stamp: 1569324651267996
variable_sip_received_ip: x.x.x.x
variable_sip_received_port: 20729
variable_sip_via_protocol: udp
variable_sip_authorized: true
variable_sip_acl_authed_by: test2
variable_sip_from_user_stripped: 2222222222
variable_sip_from_tag: 4268b509
variable_sofia_profile_name: internal
variable_sofia_profile_url: sip%3Amod_sofia%40x.x.x.x%3A5060
variable_recovery_profile_name: internal
variable_sip_full_via: SIP/2.0/UDP%20x.x.x.x%3A5067%3Bbranch%3Dz9hG4bK-524287-1---3e4ff717c1d11449%3Brport%3D20729%3Breceived%3Dx.x.x.x
variable_sip_full_from: %3Csip%3A2222222222%40x.x.x.x%3E%3Btag%3D4268b509
variable_sip_full_to: %3Csip%3A9999999999%40x.x.x.x%3E
variable_sip_allow: OPTIONS,%20SUBSCRIBE,%20NOTIFY,%20INVITE,%20ACK,%20CANCEL,%20BYE,%20REFER,%20INFO
variable_sip_req_user: 9999999999
variable_sip_req_uri: 9999999999%40x.x.x.x
variable_sip_req_host: x.x.x.x
variable_sip_to_user: 9999999999
variable_sip_to_uri: 9999999999%40x.x.x.x
variable_sip_to_host: x.x.x.x
variable_sip_contact_user: 2222222222
variable_sip_contact_port: 5067
variable_sip_contact_uri: 2222222222%40x.x.x.x%3A5067
variable_sip_contact_host: x.x.x.x
variable_rtp_use_codec_string: PCMU,PCMA
variable_sip_user_agent: X-Lite%20release%205.6.1%20stamp%2099140
variable_sip_via_host: x.x.x.x
variable_sip_via_port: 5067
variable_sip_via_rport: 20729
variable_max_forwards: 70
variable_presence_id: 2222222222%40x.x.x.x
variable_sip_nat_detected: true
variable_switch_r_sdp: v%3D0%0D%0Ao%3D-%201569324651642456%201%20IN%20IP4%20x.x.x.x%0D%0As%3DX-Lite%20release%205.6.1%20stamp%2099140%0D%0Ac%3DIN%20IP4%20x.x.x.x%0D%0At%3D0%200%0D%0Am%3Daudio%2059190%20RTP/AVP%209%0D%0A
variable_endpoint_disposition: DELAYED%20NEGOTIATION
variable_call_uuid: b3fe45ad-78ad-4d33-b70e-644e48969805
Hunt-Direction: inbound
Hunt-Logical-Direction: inbound
Hunt-Username: 2222222222
Hunt-Dialplan: XML
Hunt-Caller-ID-Name: 2222222222
Hunt-Caller-ID-Number: 2222222222
Hunt-Orig-Caller-ID-Name: 2222222222
Hunt-Orig-Caller-ID-Number: 2222222222
Hunt-Network-Addr: x.x.x.x
Hunt-ANI: 2222222222
Hunt-Destination-Number: 9999999999
Hunt-Unique-ID: b3fe45ad-78ad-4d33-b70e-644e48969805
Hunt-Source: mod_sofia
Hunt-Context: public
Hunt-Channel-Name: sofia/internal/2222222222%40x.x.x.x
Hunt-Profile-Index: 1
Hunt-Profile-Created-Time: 1569324651267996
Hunt-Channel-Created-Time: 1569324651267996
Hunt-Channel-Answered-Time: 0
Hunt-Channel-Progress-Time: 0
Hunt-Channel-Progress-Media-Time: 0
Hunt-Channel-Hangup-Time: 0
Hunt-Channel-Transfer-Time: 0
Hunt-Channel-Resurrect-Time: 0
Hunt-Channel-Bridged-Time: 0
Hunt-Channel-Last-Hold: 0
Hunt-Channel-Hold-Accum: 0
Hunt-Screen-Bit: true
Hunt-Privacy-Hide-Name: false
Hunt-Privacy-Hide-Number: false
]]