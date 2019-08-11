# secure RTP / SRTP on TLS with Auth challenge 

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
sofia profile internal restart rescan
Reload XML [Success]
restarting: internal
 mod_enum.c:879 ENUM Reloaded
 switch_time.c:1423 Timezone reloaded 1750 definitions
 sofia.c:3424 Waiting for worker thread
 switch_core_sqldb.c:1720 sofia:internal Destroying SQL queue.
 switch_core_sqldb.c:1678 sofia:internal Stopping SQL thread.
 sofia.c:3479 Write lock internal
 sofia.c:3492 Write unlock internal
 sofia.c:4637 debug [0]
 sofia.c:4637 sip-trace [yes]
 sofia.c:4637 sip-capture [yes]
 sofia.c:4637 watchdog-enabled [no]
 sofia.c:4637 watchdog-step-timeout [30000]
 sofia.c:4637 watchdog-event-timeout [30000]
 sofia.c:4637 log-auth-failures [false]
 sofia.c:4637 forward-unsolicited-mwi-notify [false]
 sofia.c:4637 context [public]
 sofia.c:4637 rfc2833-pt [101]
 sofia.c:4637 sip-port [5060]
 sofia.c:4637 dialplan [XML]
 sofia.c:4637 dtmf-duration [2000]
 sofia.c:4637 inbound-codec-prefs [PCMU,PCMA]
 sofia.c:4637 outbound-codec-prefs [PCMU,PCMA]
 sofia.c:4637 rtp-timer-name [soft]
 sofia.c:4637 rtp-ip [10.130.74.15]
 sofia.c:4637 sip-ip [10.130.74.15]
 sofia.c:4637 hold-music [local_stream://moh]
 sofia.c:4637 apply-nat-acl [nat.auto]
 sofia.c:4637 apply-inbound-acl [test2]
 sofia.c:4637 local-network-acl [localnet.auto]
 sofia.c:4637 record-path [/var/lib/freeswitch/recordings]
 sofia.c:4637 record-template [${caller_id_number}.${target_domain}.${strftime(%Y-%m-%d-%H-%M-%S)}.wav]
 sofia.c:4637 manage-presence [true]
 sofia.c:4637 presence-hosts [10.130.74.15,10.130.74.15]
 sofia.c:4637 presence-privacy [false]
 sofia.c:4637 inbound-codec-negotiation [generous]
 sofia.c:4637 tls [false]
 sofia.c:4637 tls-only [false]
 sofia.c:4637 tls-bind-params [transport=tls]
 sofia.c:4637 tls-sip-port [5061]
 sofia.c:4637 tls-passphrase []
 sofia.c:4637 tls-verify-date [true]
 sofia.c:4637 tls-verify-policy [none]
 sofia.c:4637 tls-verify-depth [2]
 sofia.c:4637 tls-verify-in-subjects []
 sofia.c:4637 tls-version [tlsv1,tlsv1.1,tlsv1.2]
 sofia.c:4637 tls-ciphers [ALL:!ADH:!LOW:!EXP:!MD5:@STRENGTH]
 sofia.c:4637 inbound-late-negotiation [true]
 sofia.c:4637 inbound-zrtp-passthru [true]
 sofia.c:4637 nonce-ttl [60]
 sofia.c:4637 auth-calls [true]
 sofia.c:4637 inbound-reg-force-matching-username [true]
 sofia.c:4637 auth-all-packets [false]
 sofia.c:4637 ext-rtp-ip [34.237.223.219]
 sofia.c:4637 ext-sip-ip [34.237.223.219]
 sofia.c:4637 rtp-timeout-sec [300]
 sofia.c:4637 rtp-hold-timeout-sec [1800]
 sofia.c:4637 force-register-domain [10.130.74.15]
 sofia.c:4637 force-subscription-domain [10.130.74.15]
 sofia.c:4637 force-register-db-domain [10.130.74.15]
 sofia.c:4637 ws-binding [:5066]
 sofia.c:4637 wss-binding [:7443]
 sofia.c:4637 challenge-realm [auto_from]
 sofia.c:5987 Setting MAX Auth Validity to 0 Attempts
 sofia.c:6154 Started Profile internal [sofia_reg_internal]
 sofia.c:3127 Creating agent for internal
 sofia.c:3246 Created agent for internal
 sofia.c:3295 Set params for internal
 sofia.c:3342 Activated db for internal
 switch_core_sqldb.c:1693 sofia:internal Starting SQL thread.
 sofia.c:3380 Starting thread for internal
 sofia.c:3027 Launching worker thread for internal
 sofia.c:4172 Adding Alias [34.237.223.219] for profile [internal]
```
Reloading gateways 
```
>sofia profile external rescan reloadxml
Reload XML [Success]
+OK scan complete

2019-07-16 11:59:42.566749 [INFO] mod_enum.c:879 ENUM Reloaded
2019-07-16 11:59:42.566749 [INFO] switch_time.c:1423 Timezone reloaded 1750 definitions
 sofia.c:4637 debug [1]
 sofia.c:4637 sip-trace [yes]
 sofia.c:4637 sip-capture [yes]
 sofia.c:4637 rfc2833-pt [101]
 sofia.c:4637 sip-port [5080]
 sofia.c:4637 dialplan [XML]
 sofia.c:4637 context [public]
 sofia.c:4637 dtmf-duration [2000]
 sofia.c:4637 inbound-codec-prefs [PCMU,PCMA]
 sofia.c:4637 outbound-codec-prefs [PCMU,PCMA]
 sofia.c:4637 hold-music [local_stream://moh]
 sofia.c:4637 rtp-timer-name [soft]
 sofia.c:4637 local-network-acl [localnet.auto]
 sofia.c:4637 manage-presence [false]
 sofia.c:4637 inbound-codec-negotiation [generous]
 sofia.c:4637 nonce-ttl [60]
 sofia.c:4637 auth-calls [true]
 sofia.c:4637 inbound-late-negotiation [true]
 sofia.c:4637 inbound-zrtp-passthru [true]
 sofia.c:4637 rtp-ip [10.130.74.15]
 sofia.c:4637 sip-ip [10.130.74.15]
 sofia.c:4637 ext-rtp-ip [34.237.223.219]
 sofia.c:4637 ext-sip-ip [34.237.223.219]
 sofia.c:4637 rtp-timeout-sec [5000]
 sofia.c:4637 rtp-hold-timeout-sec [1800]
 sofia.c:4637 tls [true]
 sofia.c:4637 tls-only [false]
 sofia.c:4637 tls-bind-params [transport=tls]
 sofia.c:4637 tls-sip-port [5081]
 sofia.c:4637 tls-passphrase []
 sofia.c:4637 tls-verify-date [true]
 sofia.c:4637 tls-verify-policy [none]
 sofia.c:4637 tls-verify-depth [2]
 sofia.c:4637 tls-verify-in-subjects []
 sofia.c:4637 tls-version [tlsv1,tlsv1.1,tlsv1.2]
 sofia.c:5987 Setting MAX Auth Validity to 0 Attempts
[WARNING] sofia.c:3744 Ignoring duplicate gateway '3.214.144.105'
[WARNING] sofia.c:3744 Ignoring duplicate gateway 'altanai.com'
```