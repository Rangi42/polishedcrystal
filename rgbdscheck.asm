if !DEF(__RGBDS_MAJOR__) || !DEF(__RGBDS_MINOR__) || !DEF(__RGBDS_PATCH__)
	fail "polishedcrystal requires rgbds v0.6.0 or newer."
endc

if (__RGBDS_MAJOR__ == 0 && __RGBDS_MINOR__ <  6) || \
   (__RGBDS_MAJOR__ == 0 && __RGBDS_MINOR__ == 6 && __RGBDS_PATCH__ <  0)
   (__RGBDS_MAJOR__ == 0 && __RGBDS_MINOR__ == 6 && __RGBDS_PATCH__ == 0 && DEF(__RGBDS_RC__))
	fail "polishedcrystal requires rgbds v0.6.0 or newer."
endc
