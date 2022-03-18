# PResenev handling on Freeswitch 

-- tbd 

## sip_profiles/external.xml 

as this is outbound registrations to providers

share presence info across sofia profiles
         manage-presence needs to be set to passive on this profile
         if you want it to behave as if it were the internal profile
         for presence.

             <!-- Name of the db to use for this profile -->
    <!--<param name="dbname" value="share_presence"/>-->
    <!--<param name="presence-hosts" value="$${domain}"/>-->
    <!--<param name="force-register-domain" value="$${domain}"/>-->
    <!--all inbound reg will stored in the db using this domain -->
    <!--<param name="force-register-db-domain" value="$${domain}"/>-->