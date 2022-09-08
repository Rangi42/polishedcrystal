MAJOR EQU 0
MINOR EQU 6
PATCH EQU 0
RC    EQU 2

WRONG_RGBDS EQUS "fail \"polishedcrystal requires rgbds v0.6.0-rc2 or newer.\""

if !DEF(__RGBDS_MAJOR__) || !DEF(__RGBDS_MINOR__) || !DEF(__RGBDS_PATCH__)
	WRONG_RGBDS
else
	if (__RGBDS_MAJOR__ < MAJOR) || \
		(__RGBDS_MAJOR__ == MAJOR && __RGBDS_MINOR__ < MINOR) || \
		(__RGBDS_MAJOR__ == MAJOR && __RGBDS_MINOR__ == MINOR && __RGBDS_PATCH__ < PATCH)
		WRONG_RGBDS
	else
		if DEF(__RGBDS_RC__)
			if __RGBDS_RC__ < RC
				WRONG_RGBDS
			endc
		endc
	endc
endc
