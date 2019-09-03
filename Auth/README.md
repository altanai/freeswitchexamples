# Auth capabilities in freeswitch 

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