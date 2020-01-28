#PBX freeswitch Configuration 

## Preprocessor Variables in vars.xml


## sip profile 

Inject delay between dtmf digits on send to help some slow interpreters (also per channel with rtp_digit_delay var
```xml
 <param name="rtp-digit-delay" value="40"/>
```
When calls are in no media this will bring them back to media when you press the hold button.
```xml
<param name="media-option" value="resume-media-on-hold"/>
```

allow a call after an attended transfer go back to bypass media after an attended transfer.
<param name="media-option" value="bypass-media-after-att-xfer"/>

set to "_undef_" to remove the User-Agent header
<param name="user-agent-string" value="FreeSWITCH Rocks!"/>

### watchdogs 

enable and control a watchdog on the Sofia SIP stack so that if it stops responding for the specified number of milliseconds, it will cause FreeSWITCH to crash immediately. 
```xml
    <param name="watchdog-enabled" value="no"/>
    <param name="watchdog-step-timeout" value="30000"/>
    <param name="watchdog-event-timeout" value="30000"/>
```
### TLS

TLS: disabled by default, set to "true" to enable
    <param name="tls" value="$${internal_ssl_enable}"/>
    <!-- Set to true to not bind on the normal sip-port but only on the TLS port -->
    <param name="tls-only" value="false"/>
    <!-- additional bind parameters for TLS -->
    <param name="tls-bind-params" value="transport=tls"/>
    <!-- Port to listen on for TLS requests. (5061 will be used if unspecified) -->
    <param name="tls-sip-port" value="$${internal_tls_port}"/>

Location of the agent.pem and cafile.pem ssl certificates (needed for TLS server) -->
    <!--<param name="tls-cert-dir" value=""/>-->
    <!-- Optionally set the passphrase password used by openSSL to encrypt/decrypt TLS private key files -->
    <param name="tls-passphrase" value=""/>
    <!-- Verify the date on TLS certificates -->
    <param name="tls-verify-date" value="true"/>
TLS verify policy, when registering/inviting gateways with other servers (outbound) or handling inbound registration/invite requests how should we verify their certificate 
set to 'in' to only verify incoming connections, 'out' to only verify outgoing connections, 'all' to verify all connections, also 'subjects_in', 'subjects_out' and 'subjects_all' for subject validation. Multiple policies can be split with a '|' pipe
    <param name="tls-verify-policy" value="none"/>

Certificate max verify depth to use for validating peer TLS certificates when the verify policy is not none
    <param name="tls-verify-depth" value="2"/>

If the tls-verify-policy is set to subjects_all or subjects_in this sets which subjects are allowed, multiple subjects can be split with a pipe
    ```xml
    <param name="tls-verify-in-subjects" value=""/>
    ```
TLS version default: tlsv1,tlsv1.1,tlsv1.2
    <param name="tls-version" value="$${sip_tls_version}"/>

TLS ciphers default: ALL:!ADH:!LOW:!EXP:!MD5:@STRENGTH
    <param name="tls-ciphers" value="$${sip_tls_ciphers}"/>

## directory.xml

When freeswitch gets a register packet it looks for the user in the directory based on the from or to domain in the packet depending on how your sofia profile is configured.  

Out of the box the default domain will be the IP address of the machine running FreeSWITCH.  This IP can be found by typing "sofia status" at the CLI.  

to see existing domain varaible 
```sh
eval ${domain}
```

### create dommain name 
To register sip phones using the domain edit domain in vars.xml in the root conf.

For example to add domain telco1.com in vars.cml
```xml
  <X-PRE-PROCESS cmd="set" data="domain_name=$${}"/>
```

Check if domain exists via fs_cli
```sh
domain_exists telco1.com
```

### add users to new domain name 
To add users to newly created domain use the directory default.xml
For exmaple to add user alt to internal profile 
```xml
```

## debugging support 