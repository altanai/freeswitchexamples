# secure RTP / SRTP on TLS with Auth challenge 


## Dialplan 

```xml
<?xml version="1.0" encoding="utf-8"?>
<include>
    <context name="public">
        <extension name="dialplansecure">
            <condition field="destination_number" expression="^(\d+)$">
                <action application="set" data="proxy_media=false"/>
                <action application="set" data="bypass_media=false"/>
                <action application="export" data="nolocal:rtp_secure_media=true:AES_CM_128_HMAC_SHA1_80"/>
                <action application="set" data="dialed_number=$1"/>
                <action application="log" data="INFO Processing for Secure destination ${dialed_number}"/>
                <action application="bridge" data="sofia/gateway/securecalls/$1"/>
            </condition>
        </extension>
    </context>
</include>
```
##  Generate SSL Certificate

To use TLS/SSL we need a root (CA) certificate and a certificate for every server. 

1. Generate the CA (Root) Certificate

Use script gentls_cert ( /usr/bin/gentls_cert  part of source tarball )
assuming that the DNS name of our FreeSWITCH PBX is pbx.securecompany.com (we can use ip too, just ensure -cn and -alt is same)
```sh 
$gentls_cert setup -cn pbx.securecompany.com -alt DNS:pbx.securecompany.com -org securecompany.com

Creating new CA...
Generating a 2048 bit RSA private key
.......................+++
......................+++
writing new private key to '/etc/freeswitch/tls/CA/cakey.pem'
-----
DONE
```

2. Generate the Server Certificate

```sh
$gentls_cert create_server -cn pbx.securecompany.com -alt DNS:pbx.securecompany.com -org securecompany.com

Generating new certificate...
--------------------------------------------------------
CN: "pbx.securecompany.com"
ORG_NAME: "securecompany.com"
ALT_NAME: "DNS:pbx.securecompany.com"

Certificate filename "agent.pem"

[Is this OK? (y/N)]
y
Generating a 2048 bit RSA private key
....................................................................+++
........+++
writing new private key to '/tmp/fs-ca-2753-20190924065450.key'
-----
Signature ok
subject=/CN=pbx.securecompany.com/O=securecompany.com
Getting CA Private Key
DONE
```
This server certificate at /etc/freeswitch/tls/agent.pem, contains both the certificate and the private key. 

3. Verifying cerrtificate 
```sh
openssl x509 -noout -inform pem -text -in /etc/freeswitch/tls/agent.pem
```

4. File permission 
```sh
cd /etc/freeswitch/tls
chmod 640 agent.pem cafile.pem
```
-rw-r----- 1 root root 3091 Jan 24 06:55 agent.pem
drwxr-x--- 2 root root 4096 Jan 24 06:54 CA
-rw-r----- 1 root root 1172 Jan 24 06:52 cafile.pem


## Enable TLS

In /etc/freeswitch/vars.xml :
```xml
<X-PRE-PROCESS cmd="set" data="external_ssl_enable=true"/>
```
In /etc/freeswitch/sip_profiles/external.xml :
```xml
<param name="tls-cert-dir" value="/etc/freeswitch/tls/"/>
```

## SRTP Crypto suites 

When using SRTP it's critical that you do not offer or accept variable bit rate codecs, doing so would leak information and possibly
compromise your SRTP stream. (FS-6404)

Supported SRTP Crypto Suites:

AEAD_AES_256_GCM_8
____________________________________________________________________________
This algorithm is identical to AEAD_AES_256_GCM (see Section 5.2 of
[RFC5116]), except that the tag length, t, is 8, and an
authentication tag with a length of 8 octets (64 bits) is used.
An AEAD_AES_256_GCM_8 ciphertext is exactly 8 octets longer than its
corresponding plaintext.


AEAD_AES_128_GCM_8
____________________________________________________________________________
This algorithm is identical to AEAD_AES_128_GCM (see Section 5.1 of
[RFC5116]), except that the tag length, t, is 8, and an
authentication tag with a length of 8 octets (64 bits) is used.
An AEAD_AES_128_GCM_8 ciphertext is exactly 8 octets longer than its
corresponding plaintext.


AES_CM_256_HMAC_SHA1_80 | AES_CM_192_HMAC_SHA1_80 | AES_CM_128_HMAC_SHA1_80
____________________________________________________________________________
AES_CM_128_HMAC_SHA1_80 is the SRTP default AES Counter Mode cipher
and HMAC-SHA1 message authentication with an 80-bit authentication
tag. The master-key length is 128 bits and has a default lifetime of
a maximum of 2^48 SRTP packets or 2^31 SRTCP packets, whichever comes
first.


AES_CM_256_HMAC_SHA1_32 | AES_CM_192_HMAC_SHA1_32 | AES_CM_128_HMAC_SHA1_32
____________________________________________________________________________
This crypto-suite is identical to AES_CM_128_HMAC_SHA1_80 except that
the authentication tag is 32 bits. The length of the base64-decoded key and
salt value for this crypto-suite MUST be 30 octets i.e., 240 bits; otherwise,
the crypto attribute is considered invalid.


AES_CM_128_NULL_AUTH
____________________________________________________________________________
The SRTP default cipher (AES-128 Counter Mode), but to use no authentication
method.  This policy is NOT RECOMMENDED unless it is unavoidable; see
Section 7.5 of [RFC3711].


SRTP variables that modify behaviors based on direction/leg:

rtp_secure_media
____________________________________________________________________________
possible values:
    mandatory - Accept/Offer SAVP negotiation ONLY
    optional  - Accept/Offer SAVP/AVP with SAVP preferred
    forbidden - More useful for inbound to deny SAVP negotiation
    false     - implies forbidden
    true      - implies mandatory

default if not set is accept SAVP inbound if offered.


rtp_secure_media_inbound | rtp_secure_media_outbound
____________________________________________________________________________
This is the same as rtp_secure_media, but would apply to either inbound
or outbound offers specifically.

How to specify crypto suites:
____________________________________________________________________________
By default without specifying any crypto suites FreeSWITCH will offer
crypto suites from strongest to weakest accepting the strongest each
endpoint has in common.  If you wish to force specific crypto suites you
can do so by appending the suites in a comma separated list in the order
that you wish to offer them in.

Examples:

    rtp_secure_media=mandatory:AES_CM_256_HMAC_SHA1_80,AES_CM_256_HMAC_SHA1_32
    rtp_secure_media=true:AES_CM_256_HMAC_SHA1_80,AES_CM_256_HMAC_SHA1_32
    rtp_secure_media=optional:AES_CM_256_HMAC_SHA1_80
    rtp_secure_media=true:AES_CM_256_HMAC_SHA1_80

Additionally you can narrow this down on either inbound or outbound by
specifying as so:

    rtp_secure_media_inbound=true:AEAD_AES_256_GCM_8
    rtp_secure_media_inbound=mandatory:AEAD_AES_256_GCM_8
    rtp_secure_media_outbound=true:AEAD_AES_128_GCM_8
    rtp_secure_media_outbound=optional:AEAD_AES_128_GCM_8


rtp_secure_media_suites
____________________________________________________________________________
Optionaly you can use rtp_secure_media_suites to dictate the suite list
and only use rtp_secure_media=[optional|mandatory|false|true] without having
to dictate the suite list with the rtp_secure_media* variables.

## Rescan and restart profile if changes are made to config xmls without restarting server 
```
>sofia profile internal restart rescan
Reload XML [Success]
restarting: internal
 mod_enum.c:879 ENUM Reloaded
 switch_time.c:1423 Timezone reloaded 1750 definitions
 sofia.c:3424 Waiting for worker thread
 switch_core_sqldb.c:1720 sofia:internal Destroying SQL queue.
 switch_core_sqldb.c:1678 sofia:internal Stopping SQL thread.
 sofia.c:3479 Write lock internal
 sofia.c:3492 Write unlock internal
debug [0]
sip-trace [yes]
sip-capture [yes]
watchdog-enabled [no]
watchdog-step-timeout [30000]
watchdog-event-timeout [30000]
log-auth-failures [false]
forward-unsolicited-mwi-notify [false]
context [public]
rfc2833-pt [101]
sip-port [5060]
dialplan [XML]
dtmf-duration [2000]
inbound-codec-prefs [PCMU,PCMA]
outbound-codec-prefs [PCMU,PCMA]
rtp-timer-name [soft]
rtp-ip [x.x.x.x]
sip-ip [x.x.x.x]
hold-music [local_stream://moh]
apply-nat-acl [nat.auto]
apply-inbound-acl [test2]
local-network-acl [localnet.auto]
record-path [/var/lib/freeswitch/recordings]
record-template [${caller_id_number}.${target_domain}.${strftime(%Y-%m-%d-%H-%M-%S)}.wav]
manage-presence [true]
presence-hosts [x.x.x.x,x.x.x.x]
presence-privacy [false]
inbound-codec-negotiation [generous]
tls [false]
tls-only [false]
tls-bind-params [transport=tls]
tls-sip-port [5061]
tls-passphrase []
tls-verify-date [true]
tls-verify-policy [none]
tls-verify-depth [2]
tls-verify-in-subjects []
tls-version [tlsv1,tlsv1.1,tlsv1.2]
tls-ciphers [ALL:!ADH:!LOW:!EXP:!MD5:@STRENGTH]
inbound-late-negotiation [true]
inbound-zrtp-passthru [true]
nonce-ttl [60]
auth-calls [true]
inbound-reg-force-matching-username [true]
auth-all-packets [false]
ext-rtp-ip [x.x.x.x]
ext-sip-ip [x.x.x.x]
rtp-timeout-sec [300]
rtp-hold-timeout-sec [1800]
force-register-domain [x.x.x.x]
force-subscription-domain [x.x.x.x]
force-register-db-domain [x.x.x.x]
ws-binding [:5066]
wss-binding [:7443]
challenge-realm [auto_from]
 sofia.c:5987 Setting MAX Auth Validity to 0 Attempts
 sofia.c:6154 Started Profile internal [sofia_reg_internal]
 sofia.c:3127 Creating agent for internal
 sofia.c:3246 Created agent for internal
 sofia.c:3295 Set params for internal
 sofia.c:3342 Activated db for internal
 switch_core_sqldb.c:1693 sofia:internal Starting SQL thread.
 sofia.c:3380 Starting thread for internal
 sofia.c:3027 Launching worker thread for internal
 sofia.c:4172 Adding Alias [x.x.x.x] for profile [internal]
```
Reloading gateways 
```
>sofia profile external rescan reloadxml
Reload XML [Success]
+OK scan complete

[INFO] mod_enum.c:879 ENUM Reloaded
[INFO] switch_time.c:1423 Timezone reloaded 1750 definitions
debug [1]
sip-trace [yes]
sip-capture [yes]
rfc2833-pt [101]
sip-port [5080]
dialplan [XML]
context [public]
dtmf-duration [2000]
inbound-codec-prefs [PCMU,PCMA]
outbound-codec-prefs [PCMU,PCMA]
hold-music [local_stream://moh]
rtp-timer-name [soft]
local-network-acl [localnet.auto]
manage-presence [false]
inbound-codec-negotiation [generous]
nonce-ttl [60]
auth-calls [true]
inbound-late-negotiation [true]
inbound-zrtp-passthru [true]
rtp-ip [x.x.x.x]
sip-ip [x.x.x.x]
ext-rtp-ip [x.x.x.x]
ext-sip-ip [x.x.x.x]
rtp-timeout-sec [5000]
rtp-hold-timeout-sec [1800]
tls [true]
tls-only [false]
tls-bind-params [transport=tls]
tls-sip-port [5081]
tls-passphrase []
tls-verify-date [true]
tls-verify-policy [none]
tls-verify-depth [2]
tls-verify-in-subjects []
tls-version [tlsv1,tlsv1.1,tlsv1.2]
Setting MAX Auth Validity to 0 Attempts
```

## Ref :
Freeswitch SIP TLS https://freeswitch.org/confluence/display/FREESWITCH/SIP+TLS