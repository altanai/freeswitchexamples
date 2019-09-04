# Gateways in freeswitch 

Define a gateway

<gateway name="sipcall_41449999990">
    <param name="username" value="41449999990"/>
    <param name="proxy" value="business1.voipgateway.org"/>
    <param name="password" value="xxxxxxxxxx"/>
    <param name="expire-seconds" value="600"/>
    <param name="register" value="true"/>
    <param name="register-transport" value="udp"/>
    <param name="retry-seconds" value="30"/>
    <param name="caller-id-in-from" value="true"/>
    <param name="ping" value="36"/>
    <variables>
        <variable name="domain" value="int.example.net" direction="inbound"/>
        <variable name="target_context" value="int.example.net" direction="inbound"/>
    </variables>
</gateway>
         

## gateway status 

sofia profile external gwlist up
```sh
sipcall_41449999990
```
sofia profile external gwlist down
```sh
x.x.x.x voxbeam_outbound
```
## debugging 

**Isuee1** freeswitch hanging up, cause: INCOMPATIBLE_DESTINATION
**Solution** most often the fault lies in codec list , check for matching codecs 

