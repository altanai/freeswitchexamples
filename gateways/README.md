# Gateways in freeswitch 


Gateways can be defined with inside profile or in directory 

Barebone outbound call gateway with no usrename / pasword 
```xml
<include>
   <gateway name="provider">
     <param name="proxy" value="10.10.10.10"/>
     <param name="register" value="false"/>
     <param name="caller-id-in-from" value="true"/> <!--Most gateways seem to want this-->
     <param name="username" value="not-used"/>
     <param name="password" value="not-used"/>
   </gateway>
</include>
```

Define a gateway
```xml
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
```         

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

