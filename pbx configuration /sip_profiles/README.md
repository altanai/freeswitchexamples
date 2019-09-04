# Freeswitch SIP profiles 

Vanila ( default ) freeswitch cofiguration has 2 profile , internal for users connected via private ip and external for users connected via public ip network .

```sh
> sofia profile internal 

[            register]	[          unregister]	[            register]	[          unregister]	
[              killgw]	[             startgw]	[            siptrace]	[             capture]	
[            watchdog]	[               start]	[              rescan]	[             restart]	
[          check_sync]	[   flush_inbound_reg]	[              gwlist]	[              killgw]	
[             startgw]	[                stop]	
```
After making any change in sofia profile 
```sh
fs_cli> sofia profile external restart
```
## status commands 

```sh
sofia status
                     Name	   Type	                                      Data	State
=================================================================================================
             	 y.y.y.y	alias	                            internal	ALIASED
                 external	profile	          sip:mod_sofia@x.x.x.x:5080	RUNNING (0)
                 external	profile	          sip:mod_sofia@x.x.x.x:5081	RUNNING (0) (TLS)
    external::altanai.com	gateway	                sip:2222222222@altanai.com	NOREG
                 internal	profile	          sip:mod_sofia@x.x.x.x:5060	RUNNING (0)
=================================================================================================
2 profiles 1 alias
```

```sh
sofia status profile internal
=================================================================================================
Name             	internal
Domain Name      	N/A
Auto-NAT         	false
DBName           	sofia_reg_internal
Pres Hosts       	y.y.y.y,y.y.y.y
Dialplan         	XML
Context          	public
Challenge Realm  	auto_from
RTP-IP           	y.y.y.y
Ext-RTP-IP       	x.x.x.x
SIP-IP           	y.y.y.y
Ext-SIP-IP       	x.x.x.x
URL              	sip:mod_sofia@x.x.x.x:5060
BIND-URL         	sip:mod_sofia@x.x.x.x:5060;maddr=y.y.y.y;transport=udp,tcp
WS-BIND-URL     	sip:mod_sofia@y.y.y.y:5066;transport=ws
WSS-BIND-URL     	sips:mod_sofia@y.y.y.y:7443;transport=wss
HOLD-MUSIC       	local_stream://moh
OUTBOUND-PROXY   	N/A
CODECS IN        	PCMU,PCMA
CODECS OUT       	PCMU,PCMA
TEL-EVENT        	101
DTMF-MODE        	rfc2833
CNG              	13
SESSION-TO       	0
MAX-DIALOG       	0
NOMEDIA          	false
LATE-NEG         	true
PROXY-MEDIA      	false
ZRTP-PASSTHRU    	true
AGGRESSIVENAT    	false
CALLS-IN         	0
FAILED-CALLS-IN  	0
CALLS-OUT        	0
FAILED-CALLS-OUT 	0
REGISTRATIONS    	0
```

```sh
sofia status profile external
=================================================================================================
Name             	external
Domain Name      	N/A
Auto-NAT         	false
DBName           	sofia_reg_external
Pres Hosts       	
Dialplan         	XML
Context          	public
Challenge Realm  	auto_to
RTP-IP           	y.y.y.y
Ext-RTP-IP       	x.x.x.x
SIP-IP           	y.y.y.y
Ext-SIP-IP       	x.x.x.x
URL              	sip:mod_sofia@x.x.x.x:5080
BIND-URL         	sip:mod_sofia@x.x.x.x:5080;maddr=y.y.y.y;transport=udp,tcp
TLS-URL          	sip:mod_sofia@x.x.x.x:5081
TLS-BIND-URL     	sips:mod_sofia@x.x.x.x:5081;maddr=y.y.y.y;transport=tls
HOLD-MUSIC       	local_stream://moh
OUTBOUND-PROXY   	N/A
CODECS IN        	PCMU,PCMA
CODECS OUT       	PCMU,PCMA
TEL-EVENT        	101
DTMF-MODE        	rfc2833
CNG              	13
SESSION-TO       	0
MAX-DIALOG       	0
NOMEDIA          	false
LATE-NEG         	true
PROXY-MEDIA      	false
ZRTP-PASSTHRU    	true
AGGRESSIVENAT    	false
CALLS-IN         	8
FAILED-CALLS-IN  	0
CALLS-OUT        	0
FAILED-CALLS-OUT 	0
REGISTRATIONS    	0
```