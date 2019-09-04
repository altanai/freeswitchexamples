# Freeswitch SIP profiles 

 sofia profile internal 

[            register]	[          unregister]	[            register]	[          unregister]	
[              killgw]	[             startgw]	[            siptrace]	[             capture]	
[            watchdog]	[               start]	[              rescan]	[             restart]	
[          check_sync]	[   flush_inbound_reg]	[              gwlist]	[              killgw]	
[             startgw]	[                stop]	

After making any change in sofia profile 
```
fs_cli> sofia profile external restart
```

