MAJOR EQU 0
MINOR EQU 5
PATCH EQU 2
RC    EQU 0

wrong_rgbds: MACRO
	fail "polishedcrystal requires rgbds v0.5.2 or newer."
ENDM

if !DEF(__RGBDS_MAJOR__) || !DEF(__RGBDS_MINOR__) || !DEF(__RGBDS_PATCH__)
	wrong_rgbds
else
	if (__RGBDS_MAJOR__ < MAJOR) || \
		(__RGBDS_MAJOR__ == MAJOR && __RGBDS_MINOR__ < MINOR) || \
		(__RGBDS_MAJOR__ == MAJOR && __RGBDS_MINOR__ == MINOR && __RGBDS_PATCH__ < PATCH)
		wrong_rgbds
	else
		if DEF(__RGBDS_RC__)
			wrong_rgbds
		endc
	endc
endc
