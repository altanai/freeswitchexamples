# Media Handling in Freeswitch sever 

FreeSWITCH can act as media Server or can completely bypassing the media altogether to save bandwidth and load on the server .
It can also proxy media in cases where a particular codec is not supported , only Natig si required or no processing on media stream is required such as transcoding.
Freeswitch can also make the media proxy via ana external media server

## RTP Related options in configuration file

auto-jitterbuffer-msec - size of the jitterbuffer on all calls coming through this profile.
<param name="auto-jitterbuffer-msec" value="120"/>

rtp-timer-name
<param name="rtp-timer-name" value="soft"/>

rtp-rewrite-timestamps - regenerate and rewrite the timestamps in all the RTP streams
<param name="rtp-rewrite-timestamps" value="true"/>

rtp-timeout-sec - seconds of RTP inactivity (media silence) before FreeSWITCH considers the call disconnected, and hangs up.
<param name="rtp-timeout-sec" value="300"/>

rtp-hold-timeout-sec - seconds of RTP inactivity (media silence) for a call placed on hold by an endpoint before FreeSWITCH considers the call disconnected, and hangs up. 
<param name="rtp-hold-timeout-sec" value="1800"/>

rtp-autoflush-during-bridge
Controls what happens if FreeSWITCH detects that it's not keeping up with the RTP media (audio) stream on a bridged call. (This situation can happen if the FreeSWITCH server has insufficient CPU time available.)

When set to "true" (the default), FreeSWITCH will notice when more than one RTP packet is waiting to be read in the incoming queue. If this condition persists for more than five seconds, RTP packets will be discarded to "catch up" with the audio stream. For example, if there are always five extra 20 ms packets in the queue, 100 ms of audio latency can be eliminated by discarding the packets. This will cause an audio glitch as some audio is discarded, but will improve the latency by 100 ms for the rest of the call.

If rtp-autoflush-during-bridge is set to false, FreeSWITCH will instead preserve all RTP packets on bridged calls, even if it increases the latency or "lag" that callers hear.

<param name="rtp-autoflush-during-bridge" value="true"/>
rtp-autoflush
Has the same effect as "rtp-autoflush-during-bridge", but affects NON-bridged calls (such as faxes, IVRs and the echo test).

Unlike "rtp-autoflush-during-bridge", the default is false, meaning that high-latency packets on non-bridged calls will not be discarded. This results in smoother audio at the possible expense of increasing audio latency (or "lag").

Setting "rtp-autoflush" to true will discard packets to minimize latency when possible. Doing so may cause errors in DTMF recognition, faxes, and other processes that rely on receiving all packets.

<param name="rtp-autoflush" value="true"/>


## Media related options


resume-media-on-hold - When calls are in no media this will bring them back to media when you press the hold button. To return the calls to bypass-media after the call is unheld, enable bypass-media-after-hold.
<param name="media-option" value="resume-media-on-hold"/>

bypass-media-after-att-xfer - allow a call after an attended transfer go back to bypass media after an attended transfer.
<param name="media-option" value="bypass-media-after-att-xfer"/>

bypass-media-after-hold - allow a call to go back to bypass media after a hold. This option can be enabled only if resume-media-on-hold is set. Available from git rev 8fa385b.
<param name="media-option" value="bypass-media-after-hold"/>

inbound-bypass-media - server only keeps the SIP messages state, but have the RTP steam go directly from end-point to end-point
<param name="inbound-bypass-media" value="true"/>

inbound-proxy-media - server keeps both the SIP and RTP traffic on the server but does not interact with the RTP stream.
<param name="inbound-proxy-media" value="true"/>

disable-rtp-auto-adjust
<param name="disable-rtp-auto-adjust" value="true"/>

ignore-183nosdp
<param name="ignore-183nosdp" value="true"/>

enable-soa
<param name="enable-soa" value="true"/>
Set the value to "false" to diable SIP SOA from sofia to tell sofia not to touch the exchange of SDP

t38-passthru
<param name="t38-passthru" value="true"/>
'true' enables t38 passthru
'false' disables t38 passthru
'once' enables t38 passthru, but sends t.38 re-invite only once (available since commit 08b25a8 from Nov. 9, 2011)


##Codecs related options

inbound-codec-prefs 
<param name="inbound-codec-prefs" value="$${global_codec_prefs}"/>

outbound-codec-prefs
<param name="outbound-codec-prefs" value="$${outbound_codec_prefs}"/>

codec-prefs - change both inbound-codec-prefs and outbound-codec-prefs at the same time.
<param name="codec-prefs" value="$${global_codec_prefs}"/>

inbound-codec-negotiation
 <param name="inbound-codec-negotiation" value="generous"/>
'generous' permits the remote codec list have precedence and 'win' the codec negotiation and selection process
'greedy' forces a win by the local FreeSWITCH preference list
'scrooge' wins even when the far side lies about capabilities during the negotiation process
sip_codec_negotiation is a channel variable version of this setting

inbound-late-negotiation - Uncomment to let calls hit the dialplan *before* you decide if the codec is OK.
<param name="inbound-late-negotiation" value="true"/>

bitpacking - AAL2 bitpacking on G.726.
<param name="bitpacking" value="aal2"/>

disable-transcoding - force the outbound leg of a bridge to only offer the codec that the originator is using
<param name="disable-transcoding" value="true"/>

renegotiate-codec-on-reinvite
<param name="renegotiate-codec-on-reinvite" value="true"/>


## Bypass media 
<action application="set" data="bypass_media=true"/>


## codecs 

Compression / decompression 
for the multimedia data streams to be useful in stored or transmitted form, they must be encapsulated together in a container format.

Lossy - eliminiates correspondingly larger data sets 
Lossless - preserves orignal quality of stream

default codecs in vars.xml
```
<X-PRE-PROCESS cmd="set" data="global_codec_prefs=G722,PCMA,PCMU,GSM"/>
<X-PRE-PROCESS cmd="set" data="outbound_codec_prefs=G722,PCMA,PCMU,GSM"/>
```

codec ettings in sofia.cofif.xml
```
<settings>
 <param name="inbound-codec-prefs" value="$${global_codec_prefs}"/>
 <param name="outbound-codec-prefs" value="$${global_codec_prefs}"/>
</settings>
```

Two principal techniques are used in codecs, pulse-code modulation and delta modulation. 

## Early Media 

Early media refers to media (e.g., audio and video) that is exchanged before a particular session is accepted by the called user. 
ie exchange of information before establishment of a connection

Triggering early media
On an inbound call you can execute pre_answer to trigger early media. After this you can do ringback, play a file or whatever.

**ignoring early media** on dialplan 
<action application="bridge" data="{ignore_early_media=true}sofia/internal/1001%${domain}"/>
