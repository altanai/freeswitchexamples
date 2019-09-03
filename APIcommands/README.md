# API commands 

orignate a call syntax  : *originate ALEG BLEG*


## Orignate a call via dialplan

originate {origination_caller_id_number=9999999999}sofia/default/2222222222@10.20.30.40 9999999999 XML default CALLER_ID_NAME CALLER_ID_NUMBER

make a call out to sip:2222222222@10.20.30.40
Caller ID number set to 9999999999.
send call to XML dialplan using context=default with the destination number of 19005551212 


## bypasses the dialplan and just sends the connected A-leg directly to the bridge app for B-leg.

originate {origination_caller_id_number=9999999999}sofia/default/2222222222@10.20.30.40 &bridge({origination_caller_id_number=8001234567}sofia/profile/someother@destination.com)



originate {origination_caller_id_number=9999999999}sofia/default/2222222222@3.222.205.112 9999999999 XML default CALLER_ID_NAME CALLER_ID_NUMBER


originate {origination_caller_id_number=9999999999}sofia/default/2222222222@3.222.205.112 9999999999 XML public

