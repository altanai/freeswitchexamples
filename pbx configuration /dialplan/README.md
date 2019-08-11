## deafult dialplan 

This context is usually accessed via authenticated callers on the sip profile on port 5060
    or transfered callers from the public context which arrived via the sip profile on port 5080.

    Authenticated users will use the user_context variable on the user to determine what context
    they can access.  You can also add a user in the directory with the cidr= attribute acl.conf.xml
    will build the domains ACL using this value.
