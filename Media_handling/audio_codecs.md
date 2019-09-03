## Audio Codecs 

Transcodable Audio Codecs
The following codecs can be used when setting codec_string and absolute_codec_string.

OPUS 
opus@48000h@10i - Opus 48khz using 10 ms ptime (mono and stereo)
opus@48000h@20i - Opus 48khz using 20 ms ptime (mono and stereo)
opus@48000h@40i - Opus 48khz using 40 ms ptime
opus@16000h@10i - Opus 16khz using 10 ms ptime (mono and stereo)
opus@16000h@20i - Opus 16khz using 20 ms ptime (mono and stereo)
opus@16000h@40i - Opus 16khz using 40 ms ptime
opus@8000h@10i - Opus 8khz using 10 ms ptime (mono and stereo)
opus@8000h@20i - Opus 8khz using 20 ms ptime (mono and stereo)
opus@8000h@40i - Opus 8khz using 40 ms ptime 
opus@8000h@60i - Opus 8khz using 60 ms ptime 
opus@8000h@80i - Opus 8khz using 80 ms ptime 
opus@8000h@100i - Opus 8khz using 100 ms ptime 
opus@8000h@120i - Opus 8khz using 120 ms ptime 
provided by mod_opus

iSAC (mod_isac)

CODEC2 2550bps) 8000hz 20ms (mod_codec2)

SILK Skype Audio codec (mod_silk)

iLBC@30i - iLBC using mode=30 which will win in all cases (mod_ilbc)

Speex (mod_speex)
speex@8000h@20i - Speex 8kHz using 20ms ptime.
speex@16000h@20i - Speex 16kHz using 20ms ptime.
speex@32000h@20i - Speex 32kHz using 20ms ptime.


BroadVoice (mod_bv)
BV32 - BroadVoice 16kHz, 32kb/s wideband
BV16 - BroadVoice 8kHz, 16kb/s narrowband

Siren
G7221@16000h - G722.1 16kHz (aka Siren 7)
G7221@32000h - G722.1C 32kHz (aka Siren 14)
Provided by mod_siren

CELT wideband.
CELT@32000h - CELT 32kHz, only 10ms supported
CELT@48000h - CELT 48kHz, only 10ms supported
Provided by mod_celt

DVI
DVI4@8000h@20i - IMA ADPCM 8kHz using 20ms ptime. (multiples of 10)
DVI4@16000h@40i - IMA ADPCM 16kHz using 40ms ptime. (multiples of 10)

GSM@40i - GSM 8kHz using 40ms ptime. (GSM is done in multiples of 20, Default is 20ms)

G722 - G722 16kHz using default 20ms ptime. (multiples of 10)

G.726
G726-16 - G726 16kbit adpcm using default 20ms ptime. (multiples of 10)
G726-24 - G726 24kbit adpcm using default 20ms ptime. (multiples of 10)
G726-32 - G726 32kbit adpcm using default 20ms ptime. (multiples of 10)
G726-40 - G726 40kbit adpcm using default 20ms ptime. (multiples of 10)
AAL2-G726-16 - Same as G726-16 but using AAL2 packing. (multiples of 10)
AAL2-G726-24 - Same as G726-24 but using AAL2 packing. (multiples of 10)
AAL2-G726-32 - Same as G726-32 but using AAL2 packing. (multiples of 10)
AAL2-G726-40 - Same as G726-40 but using AAL2 packing. (multiples of 10)

LPC - LPC10 using 90ms ptime (only supports 90ms at this time in FreeSWITCH)
Provided by mod_spandsp.

G729 - G729 in transcoding mode
provided by: mod_com_g729

PCMU - G711 8kHz ulaw using default 20ms ptime. (multiples of 10)

PCMA - G711 8kHz alaw using default 20ms ptime. (multiples of 10)

L16 - L16 isn't recommended for VoIP but you can do it. L16 can exceed the MTU Rather quickly.
Provided in core PCM module.

Pass-through Audio Codecs

G729 - G729 in passthru mode. (mod_g729 / mod_com_g729)
Provided by mod_g729 for passthru mode and mod_com_g729 for commercial license (10USD per channel)

G723 - G723.1 in passthru mode. (mod_g723_1)
Provided in mod_g723.1.

AMR - AMR in passthru mode. (mod_amr)

AMR-WB (G.722.2) - AMR-WB in passthru mode. (mod_amr_wb)