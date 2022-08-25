AnimObjGFX:
; entries correspond to ANIM_GFX_* constants
	table_width 3, AnimObjGFX
	; # tiles, label
	dbw  0, AnimObj00GFX
	dbw 35, AnimObjHitGFX
	dbw  6, AnimObjCutGFX
	dbw  6, AnimObjFireGFX
	dbw 20, AnimObjWaterGFX
	dbw 26, AnimObjLightningGFX
	dbw 18, AnimObjPlantGFX
	dbw 12, AnimObjSmokeGFX
	dbw  9, AnimObjExplosionGFX
	dbw 19, AnimObjRocksGFX
	dbw  6, AnimObjIceGFX
	dbw 10, NULL ; use AnimBallObjGFX
	dbw  9, AnimObjPoisonGFX
	dbw 13, AnimObjBubbleGFX
	dbw 16, AnimObjNoiseGFX
	dbw  2, AnimObjPowderGFX
	dbw 11, AnimObjBeamGFX
	dbw  9, AnimObjSpeedGFX
	dbw  9, AnimObjChargeGFX
	dbw 19, AnimObjWindGFX
	dbw 10, AnimObjWhipGFX
	dbw 12, AnimObjEggGFX
	dbw 18, AnimObjRopeGFX
	dbw 13, AnimObjPsychicGFX
	dbw 10, AnimObjReflectGFX
	dbw 27, AnimObjStatusGFX
	dbw 12, AnimObjSandGFX
	dbw 14, AnimObjWebGFX
	dbw 16, AnimObjHazeGFX
	dbw  7, AnimObjHornGFX
	dbw  8, AnimObjFlowerGFX
	dbw 40, AnimObjMiscGFX
	dbw 36, AnimObjSkyAttackGFX
	dbw 16, AnimObjGlobeGFX
	dbw 48, AnimObjShapesGFX
	dbw 18, AnimObjObjectsGFX
	dbw 38, AnimObjShineGFX
	dbw 35, AnimObjAngelsGFX
	dbw 18, AnimObjWaveGFX
	dbw 24, AnimObjAeroblastGFX
	dbw 16, AnimObjMoonGFX
	dbw  9, AnimObjBugBuzzGFX
	dbw 56, AnimObjLeafStormGFX
	dbw  5, AnimObjHeartsGFX
	dbw  5, AnimObjStarsGFX
	dbw  8, AnimObjMiniGFX
	dbw 48, AnimObjUTurnGFX
	dbw  1, NULL ; ANIM_GFX_PLAYERHEAD
	dbw  1, NULL ; ANIM_GFX_ENEMYFEET
	dbw 10, AnimObjPokeBallBGGFX
	assert_table_length NUM_ANIM_GFX + 1

AnimBallObjGFX:
; entries correspond to poke ball item constants
	table_width 2, AnimBallObjGFX
	dw AnimObjParkBallGFX ; far-ok
	dw AnimObjPokeBallGFX ; far-ok
	dw AnimObjGreatBallGFX ; far-ok
	dw AnimObjUltraBallGFX ; far-ok
	dw AnimObjMasterBallGFX ; far-ok
	dw AnimObjSafariBallGFX ; far-ok
	dw AnimObjLevelBallGFX ; far-ok
	dw AnimObjLureBallGFX ; far-ok
	dw AnimObjMoonBallGFX ; far-ok
	dw AnimObjFriendBallGFX ; far-ok
	dw AnimObjFastBallGFX ; far-ok
	dw AnimObjHeavyBallGFX ; far-ok
	dw AnimObjLoveBallGFX ; far-ok
	dw AnimObjRepeatBallGFX ; far-ok
	dw AnimObjTimerBallGFX ; far-ok
	dw AnimObjNestBallGFX ; far-ok
	dw AnimObjNetBallGFX ; far-ok
	dw AnimObjDiveBallGFX ; far-ok
	dw AnimObjLuxuryBallGFX ; far-ok
	dw AnimObjHealBallGFX ; far-ok
	dw AnimObjQuickBallGFX ; far-ok
	dw AnimObjDuskBallGFX ; far-ok
	dw AnimObjDreamBallGFX ; far-ok
	dw AnimObjPremierBallGFX ; far-ok
	dw AnimObjCherishBallGFX ; far-ok
	assert_table_length NUM_POKE_BALLS
