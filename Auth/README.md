# Auth capabilities in Freeswitch 

Auth is identifying SIP endpoints to FreeSWITCH.

FreeSWICH will default to $${local_ip_v4} unless changed.  Changing this setting does affect the sip authentication.
review conf/directory/default.xml for more

<X-PRE-PROCESS cmd="set" data="domain=$${local_ip_v4}"/>
<X-PRE-PROCESS cmd="set" data="domain_name=$${domain}"/>
<X-PRE-PROCESS cmd="set" data="use_profile=external"/>

challenge-realm - realm challenge key. Default is auto_to if not set.
auto_from - uses the from field as the value for the SIP realm. auto_to - uses the to field as the value for the SIP realm. <anyvalue> - you can input any value to use for the SIP realm.
If you want URL dialing to work you'll want to set this to auto_from.
If you use any other value besides auto_to or auto_from you'll loose the ability to do multiple domains.
<param name="challenge-realm" value="auto_from"/>

accept-blind-auth - accept any authentication without actually checking
<param name="accept-blind-auth" value="true"/>
   
auth-calls - Users in the directory can have "auth-acl" parameters applied to them so as to restrict users access to a predefined ACL or a CIDR.
<param name="auth-calls" value="$${internal_auth_calls}"/>
Value can be "false" to disable authentication on this profile, meaning that when calls come in the profile will *not* send an auth challenge to the caller.

log-auth-failures - log entries ( Warning ) on authentication failures ( Registration & Invite ).
<param name="log-auth-failures" value="true"/>

auth-all-packets - On authed calls, authenticate *all* the packets instead of only INVITE and REGISTER ( Note: OPTIONS, SUBSCRIBE, INFO and MESSAGE are not authenticated even with this option set to true, see http://jira.freeswitch.org/browse/FS-2871)
<param name="auth-all-packets" value="false"/>

## answer auth challenges without defining a full gateway.

originate {sip_auth_username=1111111111,sip_auth_password=123456}sofia/internal/2222222222@3.222.205.112 &echo

## output 407 Proxy Authentication Required

Auth seetings will ensure that a proxy auth challenge like below is send back for every incoming sip request 
```
SIP/2.0 407 Proxy Authentication Required
Via: SIP/2.0/UDP x.x.x.x:5060;branch=z9hG4bK4d5f.11c7cfacce4d26c8fd1b01339c08b1dc.0
From: "1001"<sip:100@x.x.x.x;transport=TCP>;tag=18aa565e
To: <sip:200@y.y.y.y:5080;pstn_inbound=;ignore_userinfo=>;tag=eX6m9Ktp48aaF
Call-ID: ZwRgsMB3luEHyKaM2vL9eQ..
CSeq: 1 INVITE
User-Agent: FreeSWITCH-mod_sofia/1.9.0-742-8f1b7e0~64bit
Accept: application/sdp
Allow: INVITE, ACK, BYE, CANCEL, OPTIONS, MESSAGE, INFO, UPDATE, REGISTER, REFER, NOTIFY
Supported: timer, path, replaces
Allow-Events: talk, hold, conference, refer
Proxy-Authenticate: Digest realm="x.x.x.x", nonce="e797bde2-c7b5-47a7-ae95-931af57c9774", algorithm=MD5, qop="auth"
Content-Length: 0
```

It is not upto the UA to, reconstruct another INVITE ( with CSeq-2) with proxy Authoroxation header containing digest , username , realm, nonce  etc to resent to freeswitch server to autheticate and proceed with call
```
Proxy-Authorization: Digest username="aaa", realm="x.x.x.x", nonce="e797bde2-c7b5-47a7-ae95-931af57c9774", uri="sip:200@x.x.x.x5:5080;pstn_inbound=;ignore_userinfo=", qop=auth, nc=00000001, cnonce="4060286812", response="cae451f24bbbcefeb7d01c13b070026a", algorithm=MD5
```