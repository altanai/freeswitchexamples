## Freeswitch sample configuration for various usecases

freeswitch internal archietture  ![freeswitch_internal_archietture](https://altanaitelecom.files.wordpress.com/2012/05/freeswitch.png?w=500)

Opensource SIP 

Mozilla Public License (MPL)

### Sofia commands
```sh
sofia profile external rescan reloadxml
```

### fs_cli
Viewing preset freeswitch variables by fs_cli eval $${variable}.  Can view value of 
      hostname
      local_ip_v4
      local_mask_v4
      local_ip_v6
      switch_serial
      base_dir
      recordings_dir
      sound_prefix
      sounds_dir
      conf_dir
      log_dir
      run_dir
      db_dir
      mod_dir
      htdocs_dir
      script_dir
      temp_dir
      grammar_dir
      certs_dir
      storage_dir
      cache_dir
      core_uuid
      zrtp_enabled
      nat_public_addr
      nat_private_addr
      nat_type

## sofis status
```
sofia status profile internal
=================================================================================================
Name              internal
Domain Name       N/A
Auto-NAT          false
DBName            sofia_reg_internal
Pres Hosts        x.x.x.x,x.x.x.x
Dialplan          XML
Context           public
Challenge Realm   auto_from
RTP-IP            x.x.x.x
Ext-RTP-IP        y.y.y.y
SIP-IP            x.x.x.x
Ext-SIP-IP        y.y.y.y
URL               sip:mod_sofia@y.y.y.y:5060
BIND-URL          sip:mod_sofia@y.y.y.y:5060;maddr=x.x.x.x;transport=udp,tcp
WS-BIND-URL       sip:mod_sofia@x.x.x.x:5066;transport=ws
WSS-BIND-URL      sips:mod_sofia@x.x.x.x:7443;transport=wss
HOLD-MUSIC        local_stream://moh
OUTBOUND-PROXY    N/A
CODECS IN         PCMU,PCMA
CODECS OUT        PCMU,PCMA
TEL-EVENT         101
DTMF-MODE         rfc2833
CNG               13
SESSION-TO        0
MAX-DIALOG        0
NOMEDIA           false
LATE-NEG          true
PROXY-MEDIA       false
ZRTP-PASSTHRU     true
AGGRESSIVENAT     false
CALLS-IN          0
FAILED-CALLS-IN   0
CALLS-OUT         0
FAILED-CALLS-OUT  0
REGISTRATIONS     0
```

## debuging in dev mode 

Turn sip trace on on selected profile or global
```
>sofia profile internal siptrace on
Enabled sip debugging on internal
```

