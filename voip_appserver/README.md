# Freeswitch as Main App Server in a aVOIP platform 

## Debugging help 

**Issue 1**   [WARNING] mod_sofia.c:4859 Cannot locate registered user 2222222222@
**Solution** Add correct user in dialplan and also register the user in a sip phone 
<include>
  <context name="public">
    <extension name="universalinboundcalls">
      <condition field="destination_number" expression="^.*$">
        <action application="log" data="INFO ***** Forwarding Call to 2222222222 ***** "/>
        <action application="sleep" data="5000"/>
        <action application="bridge" data="sofia/internal/2222222222%${sip_profile}"/>-->
       </condition>
    </extension>
</context>
</include>
