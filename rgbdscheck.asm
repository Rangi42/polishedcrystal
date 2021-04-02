FAIL_MESSAGE EQUS "fail \"polishedcrystal requires rgbds 0.5.0-rc2 or newer.\""

MAJOR EQU 0
MINOR EQU 5
PATCH EQU 0
RC    EQU 2

if !DEF(__RGBDS_MAJOR__) || !DEF(__RGBDS_MINOR__) || !DEF(__RGBDS_PATCH__)
	FAIL_MESSAGE
else
if (__RGBDS_MAJOR__ < MAJOR) || \
	(__RGBDS_MAJOR__ == MAJOR && __RGBDS_MINOR__ < MINOR) || \
	(__RGBDS_MAJOR__ == MAJOR && __RGBDS_MINOR__ == MINOR && __RGBDS_PATCH__ < PATCH)
	FAIL_MESSAGE
else
if DEF(__RGBDS_RC__)
if __RGBDS_RC__ > 0 && __RGBDS_RC__ < RC
	FAIL_MESSAGE
endc
endc
endc
endc
