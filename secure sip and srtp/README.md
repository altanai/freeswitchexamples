When using SRTP it's critical that you do not offer or accept variable bit rate codecs, doing so would leak information and possibly
compromise your SRTP stream. (FS-6404)

Supported SRTP Crypto Suites:

AEAD_AES_256_GCM_8
____________________________________________________________________________
This algorithm is identical to AEAD_AES_256_GCM (see Section 5.2 of
[RFC5116]), except that the tag length, t, is 8, and an
authentication tag with a length of 8 octets (64 bits) is used.
An AEAD_AES_256_GCM_8 ciphertext is exactly 8 octets longer than its
corresponding plaintext.


AEAD_AES_128_GCM_8
____________________________________________________________________________
This algorithm is identical to AEAD_AES_128_GCM (see Section 5.1 of
[RFC5116]), except that the tag length, t, is 8, and an
authentication tag with a length of 8 octets (64 bits) is used.
An AEAD_AES_128_GCM_8 ciphertext is exactly 8 octets longer than its
corresponding plaintext.


AES_CM_256_HMAC_SHA1_80 | AES_CM_192_HMAC_SHA1_80 | AES_CM_128_HMAC_SHA1_80
____________________________________________________________________________
AES_CM_128_HMAC_SHA1_80 is the SRTP default AES Counter Mode cipher
and HMAC-SHA1 message authentication with an 80-bit authentication
tag. The master-key length is 128 bits and has a default lifetime of
a maximum of 2^48 SRTP packets or 2^31 SRTCP packets, whichever comes
first.


AES_CM_256_HMAC_SHA1_32 | AES_CM_192_HMAC_SHA1_32 | AES_CM_128_HMAC_SHA1_32
____________________________________________________________________________
This crypto-suite is identical to AES_CM_128_HMAC_SHA1_80 except that
the authentication tag is 32 bits. The length of the base64-decoded key and
salt value for this crypto-suite MUST be 30 octets i.e., 240 bits; otherwise,
the crypto attribute is considered invalid.


AES_CM_128_NULL_AUTH
____________________________________________________________________________
The SRTP default cipher (AES-128 Counter Mode), but to use no authentication
method.  This policy is NOT RECOMMENDED unless it is unavoidable; see
Section 7.5 of [RFC3711].


SRTP variables that modify behaviors based on direction/leg:

rtp_secure_media
____________________________________________________________________________
possible values:
    mandatory - Accept/Offer SAVP negotiation ONLY
    optional  - Accept/Offer SAVP/AVP with SAVP preferred
    forbidden - More useful for inbound to deny SAVP negotiation
    false     - implies forbidden
    true      - implies mandatory

default if not set is accept SAVP inbound if offered.


rtp_secure_media_inbound | rtp_secure_media_outbound
____________________________________________________________________________
This is the same as rtp_secure_media, but would apply to either inbound
or outbound offers specifically.

How to specify crypto suites:
____________________________________________________________________________
By default without specifying any crypto suites FreeSWITCH will offer
crypto suites from strongest to weakest accepting the strongest each
endpoint has in common.  If you wish to force specific crypto suites you
can do so by appending the suites in a comma separated list in the order
that you wish to offer them in.

Examples:

    rtp_secure_media=mandatory:AES_CM_256_HMAC_SHA1_80,AES_CM_256_HMAC_SHA1_32
    rtp_secure_media=true:AES_CM_256_HMAC_SHA1_80,AES_CM_256_HMAC_SHA1_32
    rtp_secure_media=optional:AES_CM_256_HMAC_SHA1_80
    rtp_secure_media=true:AES_CM_256_HMAC_SHA1_80

Additionally you can narrow this down on either inbound or outbound by
specifying as so:

    rtp_secure_media_inbound=true:AEAD_AES_256_GCM_8
    rtp_secure_media_inbound=mandatory:AEAD_AES_256_GCM_8
    rtp_secure_media_outbound=true:AEAD_AES_128_GCM_8
    rtp_secure_media_outbound=optional:AEAD_AES_128_GCM_8


rtp_secure_media_suites
____________________________________________________________________________
Optionaly you can use rtp_secure_media_suites to dictate the suite list
and only use rtp_secure_media=[optional|mandatory|false|true] without having
to dictate the suite list with the rtp_secure_media* variables.

