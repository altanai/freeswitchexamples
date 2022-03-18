# Video Conference 

Video MCU stereo
```bash
<param name="rate" value="48000"/>
<param name="channels" value="2"/>
<param name="interval" value="20"/>
<param name="energy-level" value="200"/>
...
<param name="video-auto-floor-msec" value="1000"/>
<param name="video-mode" value="mux"/>
<param name="video-layout-name" value="3x3"/>
<param name="video-layout-name" value="group:grid"/>
<param name="video-canvas-size" value="1920x1080"/>
<param name="video-canvas-bgcolor" value="#333333"/>
<param name="video-layout-bgcolor" value="#000000"/>
<param name="video-codec-bandwidth" value="3mb"/>
<param name="video-fps" value="30"/>
```

video-mcu-stereo-720
```bash
<param name="rate" value="48000"/>
<param name="channels" value="2"/>
<param name="interval" value="20"/>
<param name="energy-level" value="200"/>
...
<param name="video-auto-floor-msec" value="1000"/>
<param name="video-mode" value="mux"/>
<param name="video-layout-name" value="3x3"/>
<param name="video-layout-name" value="group:grid"/>
<param name="video-canvas-size" value="1280x720"/>
<param name="video-canvas-bgcolor" value="#333333"/>
<param name="video-layout-bgcolor" value="#000000"/>
<param name="video-codec-bandwidth" value="3mb"/>
<param name="video-fps" value="30"/>
```

video-mcu-stereo-480
```bash
<param name="rate" value="48000"/>
<param name="channels" value="2"/>
<param name="interval" value="20"/>
<param name="energy-level" value="200"/>
...
<param name="video-auto-floor-msec" value="1000"/>
<param name="video-mode" value="mux"/>
<param name="video-layout-name" value="3x3"/>
<param name="video-layout-name" value="group:grid"/>
<param name="video-canvas-size" value="640x480"/>
<param name="video-canvas-bgcolor" value="#333333"/>
<param name="video-layout-bgcolor" value="#000000"/>
<param name="video-codec-bandwidth" value="3mb"/>
<param name="video-fps" value="30"/>
```

video-mcu-stereo-320
```bash
<param name="rate" value="48000"/>
<param name="channels" value="2"/>
<param name="interval" value="20"/>
<param name="energy-level" value="200"/>
...
<param name="video-auto-floor-msec" value="1000"/>
<param name="video-mode" value="mux"/>
<param name="video-layout-name" value="3x3"/>
<param name="video-layout-name" value="group:grid"/>
<param name="video-canvas-size" value="480x320"/>
<param name="video-canvas-bgcolor" value="#333333"/>
<param name="video-layout-bgcolor" value="#000000"/>
<param name="video-codec-bandwidth" value="3mb"/>
<param name="video-fps" value="30"/>
```


## video-mcu-stereo mapped to Number 3500 

dialplan 
```xml
<extension name="cdquality_conferences">
    <condition field="destination_number" expression="^(35\d{2})$">
        <action application="answer"/>
        <action application="conference" data="$1@video-mcu-stereo"/>
    </condition>
</extension>
```
3 party conferencing on RTP/AVP

Match with available extensions 
 ```
Dialplan: sofia/internal/1000@192.168.1.109 Regex (PASS) [cdquality_conferences] destination_number(3500) =~ /^(35\d{2})$/ break=on-false
Dialplan: sofia/internal/1000@192.168.1.109 Action answer() 
Dialplan: sofia/internal/1000@192.168.1.109 Action conference(3500@video-mcu-stereo) 
```

## debugging help 

**Issue 1** receives "SIP/2.0 422 Session Interval Too Small"

**solution** increase the default session rxpires in jssip-3.0.1.3.js


      // SESSION_EXPIRES: 90,
      SESSION_EXPIRES: 3600,


**Issue 2** receives "Q.850;cause=88;text="INCOMPATIBLE_DESTINATION"

**oslution** An access control list (ACL) is a list of permissions (or rules) associated with an object where the list defines what network entities are allowed to access the object. ICE candidates for RTP transport are checked against this list. It defaults to wan.auto if unset, which excludes the LAN.

Add the mkissing acl in acl.conf.xml


    <list name="wan.auto" default="allow">
      <node type="allow" domain="$${domain}"/>
      <node type="allow" cidr="10.176.2.43/24"/>
    </list>