# Dialplans 

When a call arrives at the FreeSWITCH™ PBX, Sofia is the first responder. She gathers information about the call, and decides which dialplan to invoke.

Sofia passes information about the call to your dialplan inside "channel variables" ( like destination_number , caller-ID , source IP address etc)  which dialplan accesses to make decisions about what to do with the call. 

The XML dialplan is organized as a series of extension definitions. FS passes each one looking for a mtaching one for a call using condition.

When condition(s) for an extension are met, the extension's action definitions (called "actions") are executed. 
If the conditions for your extension are not met, there are optional action definitions (called "anti-actions") that can be executed.

## deafult dialplan 

This context is usually accessed via authenticated callers on the sip profile on port 5060 or transfered callers from the public context which arrived via the sip profile on port 5080.

Authenticated users will use the user_context variable on the user to determine what context they can access.  
Add a user in the directory with the cidr= attribute acl.conf.xml will build the domains ACL using this value.

