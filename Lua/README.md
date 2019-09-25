# Lua Scripts for Call routing in freeswitch 

Lua not only helps write modular call scripts but also is lightweight and embeddbale 
suited to make dialplans for complex applications as well as high-cps call dispatching
mod_lua lets us bind lua script to XML requests and serve your configuration. The Lua scrit returns the XML string.

default lua config
```xml
<configuration name="lua.conf" description="LUA Configuration">
  <settings>

    <!-- 
    Specify local directories that will be searched for LUA modules
    These entries will be pre-pended to the LUA_CPATH environment variable
    -->
    <!-- <param name="module-directory" value="/usr/lib/lua/5.1/?.so"/> -->
    <!-- <param name="module-directory" value="/usr/local/lib/lua/5.1/?.so"/> -->

    <!-- 
    Specify local directories that will be searched for LUA scripts
    These entries will be pre-pended to the LUA_PATH environment variable
    -->
    <!-- <param name="script-directory" value="/usr/local/lua/?.lua"/> -->
    <!-- <param name="script-directory" value="$${script_dir}/?.lua"/> -->

    <!--<param name="xml-handler-script" value="/dp.lua"/>-->
    <!--<param name="xml-handler-bindings" value="dialplan"/>-->

    <!--
        The following options identifies a lua script that is launched
        at startup and may live forever in the background.
        You can define multiple lines, one for each script you 
        need to run.
    -->
    <!--<param name="startup-script" value="startup_script_1.lua"/>-->
    <!--<param name="startup-script" value="startup_script_2.lua"/>-->

    <!--<hook event="CUSTOM" subclass="conference::maintenance" script="catch-event.lua"/>-->
  </settings>
</configuration>
```

fetching a Dialplan from Lua script.
```xml
<configuration name="lua.conf" description="LUA Configuration">
  <settings>
    <param name="xml-handler-script" value="dp.lua"/>
    <param name="xml-handler-bindings" value="dialplan"/>
  </settings>
</configuration>
```

## Installation on ubuntu 
Assuming freeswitch is already installed , install lus 
```
apt-get install lua5.2
```
version in used Lua 5.2.3  Copyright (C) 1994-2013 Lua.org, PUC-Rio

## Runing Lua 
usage: lua [options] [script [args]]
Available options are:
  -e stat  execute string 'stat'
  -i       enter interactive mode after executing 'script'
  -l name  require library 'name'
  -v       show version information
  -E       ignore environment variables
  --       stop handling options
  -        stop handling options and execute stdin

### Ruuning simple call program 

make a file called callscript.lua
```c
new_leg = freeswitch.Session("user/altanai")
```

Runing this with lua from fs_cli
```
fs_cli> lua callscript.lua
```
will output in a call from freeswitch to user altanai , like
```
Output

[NOTICE] switch_channel.c:1104 New Channel sofia/internal/altanai@x.x.x.x:50037 [310277e3-4e42-41d0-8906-dba93e35c5d6]
 INVITE sip:altanai@x.x.x.x:50037;rinstance=c14e4a9ba6020f9b SIP/2.0
 Via: SIP/2.0/UDP x.x.x.x;rport;branch=z9hG4bK31Z086ce8UtXK
 Max-Forwards: 70
 From: "" <sip:0000000000@x.x.x.x>;tag=3SvHQr98DK0vN
 To: <sip:altanai@x.x.x.x:50037;rinstance=c14e4a9ba6020f9b>
 Call-ID: 281334aa-5a0b-1238-d29d-02a933b32da0
 CSeq: 10144944 INVITE
 Contact: <sip:mod_sofia@x.x.x.x:5060>
 User-Agent: FreeSWITCH-mod_sofia/1.9.0-742-8f1b7e0~64bit
 Allow: INVITE, ACK, BYE, CANCEL, OPTIONS, MESSAGE, INFO, UPDATE, REGISTER, REFER, NOTIFY, PUBLISH, SUBSCRIBE
 Supported: timer, path, replaces
 Allow-Events: talk, hold, conference, presence, as-feature-event, dialog, line-seize, call-info, sla, include-session-description, presence.winfo, message-summary, refer
 Content-Type: application/sdp
 Content-Disposition: session
 Content-Length: 1210
 X-FS-Support: update_display,send_info
 Remote-Party-ID: <sip:0000000000@x.x.x.x>;party=calling;screen=yes;privacy=off
```
Before runing above script make sure to register an internal user altanai in directory with domain such as below
```
<include>
  <domain name ="x.x.x.x">
        <user id="altanai">
                <params>
                        <param name="password" value="123456"/>
                        <param name="dial-string" value="${sofia_contact(${dialed_user}@${dialed_domain})}"/>
                </params>
        </user>
  </domain>
</include>
```
PS : we can use luarun for non blocking operation 

When the Lua script is called from FreeSWITCH, we get the 'freeswitch' object which can be used to access session , logs , parms or do operatiosn like bridge , msleep etc
```c
freeswitch.consoleLog("INFO","This is a log linen")
freeswitch.bridge(session1, session2)
```
If script is executed from dialplan , then we get a 'session' object which represents the call leg and we can access answer, play media, get DTMFs, hangup, etc funcality
```c
session:answer()
session:hangup() 
```


### Other auto-load configs 

/etc/freeswitch/autoload_configs# ls
abstraction.conf.xml  
cdr_pg_csv.conf.xml          
distributor.conf.xml      
hiredis.conf.xml      
modules.conf.xml       
post_load_modules.conf.xml  
sofia.conf.xml            
voicemail.conf.xml
acl.conf.xml         
cdr_sqlite.conf.xml          
easyroute.conf.xml        
httapi.conf.xml        
mongo.conf.xml         
presence_map.conf.xml       
spandsp.conf.xml          
voicemail_ivr.conf.xml
alsa.conf.xml         
cepstral.conf.xml            
enum.conf.xml             
http_cache.conf.xml    
msrp.conf.xml          
python.conf.xml             
switch.conf.xml           
xml_cdr.conf.xml
amqp.conf.xml         
cidlookup.conf.xml           
erlang_event.conf.xml     
ivr.conf.xml           
nibblebill.conf.xml    
redis.conf.xml              
syslog.conf.xml           
xml_curl.conf.xml
amr.conf.xml          
conference.conf.xml          
event_multicast.conf.xml  
java.conf.xml          
opal.conf.xml          
rss.conf.xml                
timezones.conf.xml        
xml_rpc.conf.xml
amrwb.conf.xml        
conference_layouts.conf.xml  
event_socket.conf.xml     
kazoo.conf.xml         
opus.conf.xml          
rtmp.conf.xml               
translate.conf.xml        
xml_scgi.conf.xml
avmd.conf.xml         
console.conf.xml             
fax.conf.xml              
lcr.conf.xml           
oreka.conf.xml         
sangoma_codec.conf.xml      
tts_commandline.conf.xml  
zeroconf.conf.xml
blacklist.conf.xml    
db.conf.xml                  
fifo.conf.xml             
local_stream.conf.xml  osp.conf.xml           
shout.conf.xml              
unicall.conf.xml
callcenter.conf.xml   
dialplan_directory.conf.xml  
format_cdr.conf.xml       
logfile.conf.xml       
perl.conf.xml          
skinny.conf.xml             
unimrcp.conf.xml
cdr_csv.conf.xml      
dingaling.conf.xml           
graylog2.conf.xml         
lua.conf.xml           
pocketsphinx.conf.xml  
smpp.conf.xml               
v8.conf.xml
cdr_mongodb.conf.xml  
directory.conf.xml           
hash.conf.xml             
memcache.conf.xml      
portaudio.conf.xml     
sms_flowroute.conf.xml      
verto.conf.xml


## Debug 

**Issue1** 2019-09-23 12:13:19.026927 [ERR] mod_lua.cpp:203 cannot open /dp.lua: No such file or directory
2019-09-23 12:13:19.026927 [ERR] mod_lua.cpp:271 LUA script parse/execute error!
**Solution** add file with correct path 
```xml
<configuration name="lua.conf" description="LUA Configuration">
  <settings>
    <param name="xml-handler-script" value="/etc/freeswitch/helloworld.lua"/>
    <param name="xml-handler-bindings" value="dialplan"/>
  </settings>
</configuration>
```

**Issue2**[ERR] mod_dptools.c:4297 control the behavior of the call when a user is dialed. 
[NOTICE] switch_ivr_originate.c:2868 Cannot create outgoing channel of type [user] cause: [MANDATORY_IE_MISSING]
**solution** The dial-string parameter is used by the user/ endpoint. ample given for directory/default.xml
```xml
<param name="dial-string" value="${sofia_contact(${dialed_user}@${dialed_domain})}"/>
```