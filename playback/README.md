# Plyback/ Annoucemnt with pre-stored audio files on incoming call 

## debugging help

**Issue 1** :  Sampling rate related issue such as 
[NOTICE] mod_dptools.c:1357 Channel [sofia/external/3333333333@x.x.x.x:5080] has been answered
[DEBUG] switch_channel.c:3781 (sofia/external/3333333333@x.x.x.x:5080) Callstate Change EARLY -> ACTIVE
EXECUTE sofia/external/3333333333@x.x.x.x:5080 playback(/home/ubuntu/PinkPanther30.wav)
2019-07-31 07:16:59.361747 [DEBUG] switch_core_file.c:358 File /home/ubuntu/PinkPanther30.wav sample rate 22050 doesn't match requested rate 16000
2019-07-31 07:16:59.361747 [DEBUG] switch_ivr_play_say.c:1498 Codec Activated L16@16000hz 1 channels 20ms 

**Solution** : find the sampling rate of the file u have 
file 
```
file /home/ubuntu/PinkPanther30.wav 
/home/ubuntu/PinkPanther30.wav: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, mono 22050 Hz
```
or soxi 
```
>soxi /home/ubuntu/PinkPanther30.wav 

Input File     : '/home/ubuntu/PinkPanther30.wav'
Channels       : 1
Sample Rate    : 22050
Precision      : 16-bit
Duration       : 00:00:30.00 = 661500 samples ~ 2250 CDDA sectors
File Size      : 1.32M
Bit Rate       : 353k
Sample Encoding: 16-bit Signed Integer PCM
```

Convert that to other sapling rates and store as same filename under same location , server will auto pick the one which meets the requirnments 

Sox
```
>sox -S /home/ubuntu/PinkPanther30.wav /home/ubuntu/PinkPanther30.wav rate -L -s 16000
Input File     : '/home/ubuntu/PinkPanther30.wav'
Channels       : 1
Sample Rate    : 22050
Precision      : 16-bit
Duration       : 00:00:30.00 = 661500 samples ~ 2250 CDDA sectors
File Size      : 0
Bit Rate       : 0
Sample Encoding: 16-bit Signed Integer PCM

In:0.00% 00:00:00.00 [00:00:30.00] Out:0     [      |      ]        Clip:0    sox WARN wav: Premature EOF on .wav input file
In:0.00% 00:00:00.00 [00:00:30.00] Out:0     [      |      ]        Clip:0    
Done.

```