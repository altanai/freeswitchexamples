# Freeswitch Dialplan actions 

These snippets and descriptions are learned from https://freeswitch.org/confluence/display/FREESWITCH/mod_dptools.
Below is my grouping of the dialplan actions and snippets based on usage and common cases.

## Call Management 

- pickup - Pickup a call.
- hangup - Hang up the current channel.
- hold - Send a hold message.
- park - Park a call.
- park_state - Park State.
- deflect - Send a call deflect/refer.
- early_hangup - Enable early hangup on a channel.
- pre_answer - Answer a channel in early media mode.
- redirect - Send a redirect message to a session.
- respond - Send a respond message to a session.
- transfer - Immediately transfer the calling channel to a new extension.
- unhold - Send a un-hold message.

### Answer 
Answer the call for a channel.
<extension name="play tone">
    <condition field="destination_number" expression="^tone1$">
        <action application="log" data="INFO *****Playing tone1***** "/>
        <action application="answer"/>
        <action application="sleep" data="1000"/>
        <action application="playback" data="tone_stream://v=-6;%(10000,100,1004);loops=1"/>
        <action application="hangup"/>
    </condition>
</extension>

## att_xfer  Attended Transfer.

- bgsystem — Execute an operating system command in the background.

- bind_digit_action - Bind a key sequence or regex to an action.


## Break 

Cancel an application currently running on the channel.
Dialplan execution proceeds to the next application. Optionally clears all unprocessed events (queued applications) on the channel.
but can't break an endless_playback
```xml
<action application="break" data="${bridge_to}">
```

check_acl - Check originating address against an Access Control List
clear_digit_action - Clear all digit bindings
clear_speech_cache - Clear speech handle cache.
digit_action_set_realm - Change binding realm.
displace_session - Displace audio on a channel.


## DTMF 

- send_dtmf - Send inband DTMF, 2833, or SIP Info digits from a session.
- start_dtmf - Start inband DTMF detection.
- stop_dtmf - Stop inband DTMF detection.
- start_dtmf_generate - Start inband DTMF generation.
- stop_dtmf_generate - Stop inband DTMF generation.
- bind_meta_app - Respond to certain DTMF sequences on specified call leg(s) during a bridge and execute another dialplan application.
- block_dtmf - Block DTMFs from being sent or received on the channel.
- flush_dtmf - Flush any queued DTMF.
- queue_dtmf - Send DTMF digits after a successful bridge.

## Echo 
Echo audio and video back to the originator, including voice, DTMF, etc.
Places the calling channel in loopback mode.
Mostly used to test delay in path
```xml
    <extension name="universalinboundcalls">
        <condition field="destination_number" expression="^123$">
            <action application="log" data="INFO ***** Echo tone ***** "/>
            <action application="sleep" data="5000"/>
            <action application="answer"/>
            <action application="echo" data=""/>
       </condition>
    </extension>
```

Example to eavesdrop on extension 1001 , dial 881001
```xml
<extension name="global" continue="true">
  <condition>
    <action application="info"/>
    <action application="db" data="insert/spymap/${caller_id_number}/${uuid}"/>
    <action application="db" data="insert/last_dial/${caller_id_number}/${destination_number}"/>
    <action application="db" data="insert/last_dial/global/${uuid}"/>
  </condition>
</extension>
<extension name="eavesdrop">
  <condition field="destination_number" expression="^88(.*)$|^\*0(.*)$">
    <action application="answer"/>
    <action application="eavesdrop" data="${db(select/spymap/$1$2)}"/>
  </condition>
</extension>
```

- delay_echo - Echo audio at a specified delay.

# API
- httapi - Send call control to a Web server with the HTTAPI infrastructure

# Playback 

- endless_playback - Continuously play file to caller.[old wiki]
- page - Play an audio file as a page.
- loop_playback - Playback a file to the channel looply for limted times
- play_and_detect_speech - Play while doing speech recognition.
- play_and_get_digits - Play and get Digits.
- play_fsv - Play an FSV file. FSV - (FS Video File Format) additional description needed
- playback - Play a sound file to the originator.
- speak - Speaks a string or file of text to the channel using the defined TTS engine.

## Call Queue 
fifo - Send caller to a FIFO queue.
fifo_track_call - Count a call as a FIFO call in the manual_calls queue.


# Group

group - Insert or delete members in a group.

### info 
Display Call Info.


    EXECUTE sofia/external/6666666666@6.6.6.6 info()
    2019-09-05 10:26:54.718507 [INFO] mod_dptools.c:1806 CHANNEL_DATA:
    Channel-State: [CS_EXECUTE]
    Channel-Call-State: [RINGING]
    Channel-State-Number: [4]
    Channel-Name: [sofia/external/6666666666@6.6.6.6]
    Unique-ID: [4061d7a4-2a61-4ab2-a998-13d9425fe3c2]
    Call-Direction: [inbound]
    Presence-Call-Direction: [inbound]
    Channel-HIT-Dialplan: [true]
    Channel-Call-UUID: [4061d7a4-2a61-4ab2-a998-13d9425fe3c2]
    Answer-State: [ringing]
    Caller-Direction: [inbound]
    Caller-Logical-Direction: [inbound]
    Caller-Username: [6666666666]
    Caller-Dialplan: [XML]
    Caller-Caller-ID-Name: [6666666666]
    Caller-Caller-ID-Number: [6666666666]
    Caller-Orig-Caller-ID-Name: [6666666666]
    Caller-Orig-Caller-ID-Number: [6666666666]
    Caller-Network-Addr: [5.5.5.5]
    Caller-ANI: [6666666666]
    Caller-Destination-Number: [18552702852]
    Caller-Unique-ID: [4061d7a4-2a61-4ab2-a998-13d9425fe3c2]
    Caller-Source: [mod_sofia]
    Caller-Context: [public]
    Caller-Channel-Name: [sofia/external/6666666666@6.6.6.6]
    Caller-Profile-Index: [1]
    Caller-Profile-Created-Time: [1567679214718507]
    Caller-Channel-Created-Time: [1567679214718507]
    Caller-Channel-Answered-Time: [0]
    Caller-Channel-Progress-Time: [0]
    Caller-Channel-Progress-Media-Time: [0]
    Caller-Channel-Hangup-Time: [0]
    Caller-Channel-Transfer-Time: [0]
    Caller-Channel-Resurrect-Time: [0]
    Caller-Channel-Bridged-Time: [0]
    Caller-Channel-Last-Hold: [0]
    Caller-Channel-Hold-Accum: [0]
    Caller-Screen-Bit: [true]
    Caller-Privacy-Hide-Name: [false]
    Caller-Privacy-Hide-Number: [false]
    variable_direction: [inbound]
    variable_uuid: [4061d7a4-2a61-4ab2-a998-13d9425fe3c2]
    variable_session_id: [143]
    variable_sip_from_user: [6666666666]
    variable_sip_from_uri: [6666666666@6.6.6.6]
    variable_sip_from_host: [6.6.6.6]
    variable_video_media_flow: [disabled]
    variable_audio_media_flow: [disabled]
    variable_text_media_flow: [disabled]
    variable_channel_name: [sofia/external/6666666666@6.6.6.6]
    variable_sip_call_id: [99140NTQ4OWE1MGVlZjk0ZWU4YzI5NDAyMmIxYjdmNjdlOWQ]
    variable_sip_local_network_addr: [7.7.7.7]
    variable_sip_network_ip: [5.5.5.5]
    variable_sip_network_port: [5060]
    variable_sip_invite_stamp: [1567679214718507]
    variable_sip_received_ip: [5.5.5.5]
    variable_sip_received_port: [5060]
    variable_sip_via_protocol: [udp]
    variable_sip_authorized: [true]
    variable_Event-Name: [REQUEST_PARAMS]
    variable_Core-UUID: [11422524-b611-4ece-8042-c5716846e852]
    variable_FreeSWITCH-Hostname: [ip-10-130-74-15]
    variable_FreeSWITCH-Switchname: [ip-10-130-74-15]
    variable_FreeSWITCH-IPv4: [8.8.8.8]
    variable_FreeSWITCH-IPv6: [fe80::a9:33ff:feb3:2da0]
    variable_Event-Date-Local: [2019-09-05 10:26:54]
    variable_Event-Date-GMT: [Thu, 05 Sep 2019 10:26:54 GMT]
    variable_Event-Date-Timestamp: [1567679214718507]
    variable_Event-Calling-File: [sofia.c]
    variable_Event-Calling-Function: [sofia_handle_sip_i_invite]
    variable_Event-Calling-Line-Number: [10302]
    variable_Event-Sequence: [3174]
    variable_sip_number_alias: [2222222222]
    variable_sip_auth_username: [2222222222]
    variable_sip_auth_realm: [8.8.8.8]
    variable_number_alias: [2222222222]
    variable_requested_user_name: [2222222222]
    variable_requested_domain_name: [8.8.8.8]
    variable_user_name: [2222222222]
    variable_domain_name: [8.8.8.8]
    variable_sip_from_user_stripped: [6666666666]
    variable_sip_from_tag: [253cab72]
    variable_sofia_profile_name: [external]
    variable_sofia_profile_url: [sip:mod_sofia@7.7.7.7:5080]
    variable_recovery_profile_name: [external]
    variable_sip_full_via: [SIP/2.0/UDP 5.5.5.5:5060;branch=z9hG4bK6312.8f93f8fc5e3fcdcb1f3f52e73313710b.1.cs1]
    variable_sip_full_from: [<sip:6666666666@6.6.6.6>;tag=253cab72]
    variable_sip_full_to: [<sip:18552702852@8.8.8.8:5080>]
    variable_sip_allow: [INVITE, ACK, CANCEL, BYE, UPDATE]
    variable_sip_req_user: [18552702852]
    variable_sip_req_port: [5080]
    variable_sip_req_uri: [18552702852@8.8.8.8:5080]
    variable_sip_req_host: [8.8.8.8]
    variable_sip_to_user: [18552702852]
    variable_sip_to_port: [5080]
    variable_sip_to_uri: [18552702852@8.8.8.8:5080]
    variable_sip_to_host: [8.8.8.8]
    variable_sip_contact_user: [abc]
    variable_sip_contact_uri: [abc@5.5.5.5]
    variable_sip_contact_host: [5.5.5.5]
    variable_rtp_use_codec_string: [PCMU,PCMA]
    variable_sip_user_agent: [trunk_privider1]
    variable_sip_via_host: [5.5.5.5]
    variable_sip_via_port: [5060]
    variable_max_forwards: [66]
    variable_switch_r_sdp: [v=0
    o=- 1567679214883751 1 IN IP4 3.92.94.37
    s=X-Lite release 5.6.1 stamp 99140
    c=IN IP4 3.92.94.37
    t=0 0
    m=audio 10026 RTP/AVP 0
    a=rtpmap:0 PCMU/8000
    ]
    variable_ep_codec_string: [CORE_PCM_MODULE.PCMU@8000h@20i@64000b]
    variable_endpoint_disposition: [DELAYED NEGOTIATION]
    variable_call_uuid: [4061d7a4-2a61-4ab2-a998-13d9425fe3c2]
    variable_current_application: [info]


# IVR
- ivr - Run an IVR menu.
- phrase - Say a Phrase.

# Rate Limiter and  Thread management 
- mutex - Block on a call flow, allowing only one at a time
- sleep - Pause a channel.
- system - Execute an operating system command.
- limit - Set a limit on number of calls to/from a resource
- limit_execute - Set the limit on a specific application
- limit_hash - Set a limit on number of calls to/from a resource
- limit_hash_execute - Set the limit on a specific application

# Programming suport 
- lua - Run a Lua script from the dialplan [API link]
- javascript - Run a JavaScript script from the dialplan
- erlang - Handle a call using Erlang.

# Read 
Read Digits.
  > read <min> <max> <sound file> <variable name> <timeout> <terminators>

min = Minimum number of digits to fetch.
max = Maximum number of digits to fetch.
sound file = Sound file to play before digits are fetched.
variable name = Channel variable that digits should be placed in.
timeout = Number of milliseconds to wait on each digit
terminators = Digits used to end input if less than <min> digits have been pressed. (Typically '#')
```xml
<extension name="Read Example">
  <condition field="destination_number" expression="^400$">
    <action application="answer"/>
    <action application="sleep" data="1"/>
    <action application="read" data="0 10 $${base_dir}/sounds/en/us/callie/conference/8000/conf-pin.wav res 10000 #"/>
    <action application="phrase" data="spell,${res}"/>
    <action application="hangup"/>
  </condition>
</extension>
```


# Record 
Record a file from the channel's input.

- record,Record File,<path> [<time_limit_secs>] [<silence_thresh>] [<silence_hits>]
time_limit_secs - (optional) is the maximum duration of the recording in seconds.

```xml
<action application="playback" data="/var/sounds/beep.gsm"/>
<action application="set" data="playback_terminators=#"/> 
<action application="record" data="/tmp/data.wav 20 200"/>
```

- record_fsv - Record a FSV file. FSV - (FS Video File Format) additional description needed
- record_session - Record Session.
- stop_record_session - Stop Record Session.


# ring_ready
Indicate Ring_Ready on a channel by senidng an 180 Ringing to be sent to the originator.

### say 
Say time/date/ip_address/digits/etc. With pre-recorded prompts.
can also spell out alpha-numeric text, including punctuation marks.
- say <module_name>[:<lang>] <say_type> <say_method> [gender] <text>

Say type is one of the following
	NUMBER
	ITEMS
	PERSONS
	MESSAGES
	CURRENCY
	TIME_MEASUREMENT
	CURRENT_DATE
	CURRENT_TIME
	CURRENT_DATE_TIME
	TELEPHONE_NUMBER
	TELEPHONE_EXTENSION
	URL
	IP_ADDRESS
	EMAIL_ADDRESS
	POSTAL_ADDRESS
	ACCOUNT_NUMBER
	NAME_SPELLED
	NAME_PHONETIC
	SHORT_DATE_TIME
Say method is one of the following (
	pronounced 
	iterated
	counted
Say gender
	FEMININE
	MASCULINE
	NEUTER
Examples:
```xml
<action application="say" data="en name_spelled iterated ${destination_number}"/>
 
<action application="say" data="en number pronounced 12345"/>

<action application="say" data="en ip_address pronounced 12.34.56.78"/>

<action application="say" data="en CURRENCY PRONOUNCED -1.96"/>

<action application="say" data="en short_date_time pronounced [timestamp]"/>
```

A transcript of the pre-recorded files - https://freeswitch.org/stash/projects/FS/repos/freeswitch/browse/docs/phrase/phrase_en.xml

send_display - Sends an info packet with a sipfrag.

send_info - Send info to the endpoint.

# Channel Variables 
- set - Set a channel variable for the channel calling the application.
- capture - Capture data into a channel variable.
- multiset - Set multiple channel variables with a single action.
- unset - Unset a variable.

set_audio_level - Adjust the read or write audio levels for a channel.
set_global - Set a global variable.
set_name - Name the channel.
set_profile_var - Set a caller profile variable.
set_user - Set a user.
set_zombie_exec - Sets the zombie execution flag on the current channel.

socket - Establish an outbound socket connection.

stop_displace_session - Stop displacement audio on a channel.


three_way - Three way call with a UUID.

translate - Number translation.

unbind_meta_app - Unbind a key from an application.


## Bridge call 
Used for MCU ( mixer) in media plane

- bridge - Bridge a new channel to the existing one.
- bridge_export - Export a channel variable across any bridge.
- export - Export a channel variable across a bridge <varname>=<value>
- soft_hold - Put a bridged channel on hold.
- conference - Establish an inbound or outbound conference call

## Schedule Events 

sched_broadcast - Enable Scheduled Broadcast.
sched_cancel - Cancel a scheduled future broadcast/transfer.
sched_hangup - Enable Scheduled Hangup.
sched_heartbeat - Enable Scheduled Heartbeat. Additional information needed
sched_transfer - Enable Scheduled Transfer.

## Lawful Interception/ Call barge

- intercept - Lets you pickup a call and take it over if you know the uuid.
- privacy - Set caller privacy on calls.
- userspy - Provides persistent eavesdrop on all channels bridged to a certain user using eavesdrop.

### eavesdrop 
Spy on a channel / barge
```xml
<action application="set" data="eavesdrop_require_group=<groupID>"/>
<action application="set" data="eavesdrop_indicate_failed=/sounds/failed.wav"/>         
<action application="set" data="eavesdrop_indicate_new=/sounds/new_chan_announce.wav"/> 
<action application="set" data="eavesdrop_indicate_idle=/sounds/idle.wav"/>
<action application="set" data="eavesdrop_enable_dtmf=true"/> <!-- false means no commands during eavesdrop -->
<action application="set" data="eavesdrop_bridge_aleg=true"/> <!-- enables listen to aleg -->
<action application="set" data="eavesdrop_bridge_bleg=true"/> <!-- enables listen to bleg -->
<action application="set" data="eavesdrop_whisper_aleg=true"/> <!-- enables whisper mode in aleg -->
<action application="set" data="eavesdrop_whisper_bleg=true"/> <!-- enables whisper mode in bleg -->
```

## Logs and Verbose Events 
- verbose_events - Make ALL Events verbose (Make all variables appear in every single event for this channel).
- log - Logs a channel variable for the channel calling the application
- session_loglevel - Override the system's loglevel for this channel.

## Error Resilience and Anlytics

- cng_plc - Packet Loss Concealment on lost packets + comfort noise generation
- sound_test - Analyze Audio.
- jitterbuffer - Send a jitter buffer message to a session

## Wait 

- wait_for_silence - Pause processing while waiting for silence on the channel.


    wait_for_silence <silence_thresh> <silence_hits> <listen_hits> <timeout_ms> [<file>]

- wait_for_answer - Pause processing while waiting for the call to be answered.

## Tone Detect and Silence Detect 

- tone_detect - Detect the presence of a tone and execute a command if found.
- detect_speech - Implements speech recognition.
- stop_tone_detect - Stop detecting tones.
- gentones - Generate TGML tones.
- silence_thresh - (optional) is the energy level below which is considered silence.
- silence_hits - (optional) is how many seconds of audio below silence_thresh will be tolerated before the recording stops. default is 3 seconds.

## Chat and Presence
- chat - Send a text message to a IM client.
- presence - Send Presence.

## Time 
- strftime - Returns formatted date and time.
- strepoch - Returns the date/time as a UNIX epoch (seconds elapsed since midnight UTC, January 1, 1970).
- strftime - Returns formatted date and time.
- strftime_tz - Returns formatted date and time in the timezone specified.

# Media management 
- media_reset - Reset all bypass/proxy media flags.
- remove_bugs - Remove media bugs.
- enable_heartbeat - Enable Media Heartbeat.

Others 
- rxfax - Receive a fax as a tif file.
- fax_detect - Detect FAX CNG - may be deprecated.
- db - insert information into the database.
- recovery_refresh - Send a recovery refresh. addition information needed
- regex - Perform a regex.
- rename - Rename file.
- mkdir - Create a directory.
- preprocess - description needed
- eval - Evaluates a string.
- event - Fire an event.
- execute_extension - Execute an extension from within another extension and return.
- enum - Perform E.164 lookup.
- hash - Add a hash to the db.

## Debugging 

**Issue1** 404 not found on destination 
Dialplan: sofia/internal/2222222222@x.x.x.x parsing [public->universalinboundcalls] continue=false
Dialplan: sofia/internal/2222222222@x.x.x.x Regex (FAIL) [universalinboundcalls] destination_number(987654321) =~ /^8888888888$/ break=on-false
[INFO] switch_core_state_machine.c:311 No Route, Aborting
[NOTICE] switch_core_state_machine.c:312 Hangup sofia/internal/2222222222@x.x.x.x [CS_ROUTING] [NO_ROUTE_DESTINATION]

**Solution** Add visible on sample snippet the deatination is unmatched to any condition ind dialplan. To fix this wither add a wildcard or add a matching extension for same detsination number such as 

```xml
<include>
  	<context name="public">
    	<extension name="universalinboundcalls">
        	<condition field="destination_number" expression="^987654321$">
        		...
        	</condition>
    	</extension>
	</context>
</include>
```