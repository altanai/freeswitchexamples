# IVR - Interactive Voice Response 

FreeSWITCH IVRs can be written in any language that FreeSWITCH supports including JavaScript, Python, Perl, Lua and an XML macro format.
IVR is more than an automatic attendant as it not only performs rudimentary call routing but also interacts with callers, gathers information and makes decision.

include action plan 
```
<action application="ivr" data="demo_ivr"/>
```

Freeswitch includes many dialplans that we dont need for IVR, we can remove those before making new dial plan 
```
$ rm -rf  /etc/freeswitch/dialplan/default/
$ rm -rf /etc/freeswitch/dialplan/skinny-patterns*
$ rm /etc/freeswitch/dialplan/features.xml
```

Logs Output
```
EXECUTE sofia/internal/2222222222@x.x.x.x ivr(demo_ivr)
switch_ivr_menu.c:743 switch_ivr_menu_stack_xml_add binding 'menu-exit'
switch_ivr_menu.c:743 switch_ivr_menu_stack_xml_add binding 'menu-sub'
switch_ivr_menu.c:743 switch_ivr_menu_stack_xml_add binding 'menu-exec-app'
switch_ivr_menu.c:743 switch_ivr_menu_stack_xml_add binding 'menu-play-sound'
switch_ivr_menu.c:743 switch_ivr_menu_stack_xml_add binding 'menu-back'
switch_ivr_menu.c:743 switch_ivr_menu_stack_xml_add binding 'menu-top'
switch_ivr_menu.c:880 building menu 'demo_ivr'
switch_ivr_menu.c:964 binding menu action 'menu-exec-app' to '1'
switch_ivr_menu.c:964 binding menu action 'menu-exec-app' to '2'
switch_ivr_menu.c:964 binding menu action 'menu-exec-app' to '3'
switch_ivr_menu.c:964 binding menu action 'menu-exec-app' to '4'
switch_ivr_menu.c:964 binding menu action 'menu-exec-app' to '5'
switch_ivr_menu.c:880 building menu 'demo_ivr_submenu'
switch_ivr_menu.c:964 binding menu action 'menu-top' to '*'
switch_ivr_menu.c:964 binding menu action 'menu-sub' to '6'
switch_ivr_menu.c:964 binding menu action 'menu-exec-app' to '/^(10[01][0-9])$/'
switch_ivr_menu.c:964 binding menu action 'menu-top' to '9'
switch_ivr_menu.c:483 Executing IVR menu demo_ivr
switch_ivr_play_say.c:70 No language specified - Using [en]
switch_ivr_play_say.c:250 Handle play-file:[ivr/ivr-welcome_to_freeswitch.wav] (en:en)
switch_ivr_play_say.c:1498 Codec Activated L16@8000hz 1 channels 20ms
```