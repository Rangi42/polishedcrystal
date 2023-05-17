MACRO battleanimgfx
	db \1 ; # tiles
	if _NARG == 2
		fardw \2 ; label
	else
		dw NULL
	endc
ENDM

AnimObjGFX:
; entries correspond to ANIM_GFX_* constants
	table_width 3, AnimObjGFX
	farbank "Battle Anim Graphics"
	battleanimgfx  0, AnimObj00GFX
	battleanimgfx 35, AnimObjHitGFX
	battleanimgfx  6, AnimObjCutGFX
	battleanimgfx  6, AnimObjFireGFX
	battleanimgfx 20, AnimObjWaterGFX
	battleanimgfx 26, AnimObjLightningGFX
	battleanimgfx 18, AnimObjPlantGFX
	battleanimgfx 12, AnimObjSmokeGFX
	battleanimgfx  9, AnimObjExplosionGFX
	battleanimgfx 19, AnimObjRocksGFX
	battleanimgfx  6, AnimObjIceGFX
	battleanimgfx 10 ; use AnimBallObjGFX
	battleanimgfx  9, AnimObjPoisonGFX
	battleanimgfx 13, AnimObjBubbleGFX
	battleanimgfx 16, AnimObjNoiseGFX
	battleanimgfx  2, AnimObjPowderGFX
	battleanimgfx 11, AnimObjBeamGFX
	battleanimgfx  9, AnimObjSpeedGFX
	battleanimgfx  9, AnimObjChargeGFX
	battleanimgfx 19, AnimObjWindGFX
	battleanimgfx 10, AnimObjWhipGFX
	battleanimgfx 12, AnimObjEggGFX
	battleanimgfx 18, AnimObjRopeGFX
	battleanimgfx 13, AnimObjPsychicGFX
	battleanimgfx 10, AnimObjReflectGFX
	battleanimgfx 27, AnimObjStatusGFX
	battleanimgfx 12, AnimObjSandGFX
	battleanimgfx 14, AnimObjWebGFX
	battleanimgfx 16, AnimObjHazeGFX
	battleanimgfx  7, AnimObjHornGFX
	battleanimgfx  8, AnimObjFlowerGFX
	battleanimgfx 40, AnimObjMiscGFX
	battleanimgfx 36, AnimObjSkyAttackGFX
	battleanimgfx 16, AnimObjGlobeGFX
	battleanimgfx 48, AnimObjShapesGFX
	battleanimgfx 18, AnimObjObjectsGFX
	battleanimgfx 38, AnimObjShineGFX
	battleanimgfx 35, AnimObjAngelsGFX
	battleanimgfx 18, AnimObjWaveGFX
	battleanimgfx 24, AnimObjAeroblastGFX
	battleanimgfx 16, AnimObjMoonGFX
	battleanimgfx  9, AnimObjBugBuzzGFX
	battleanimgfx 56, AnimObjLeafStormGFX
	battleanimgfx  5, AnimObjHeartsGFX
	battleanimgfx  5, AnimObjStarsGFX
	battleanimgfx  8, AnimObjMiniGFX
	battleanimgfx 48, AnimObjUTurnGFX
	battleanimgfx 12, AnimObjBerryGFX
	battleanimgfx  1 ; ANIM_GFX_PLAYERHEAD
	battleanimgfx  1 ; ANIM_GFX_ENEMYFEET
	battleanimgfx 10, AnimObjPokeBallBGGFX
	assert_table_length NUM_ANIM_GFX + 1

AnimBallObjGFX:
; entries correspond to poke ball item constants
	table_width 2, AnimBallObjGFX
	farbank "Battle Ball Icons"
	fardw AnimObjParkBallGFX
	fardw AnimObjPokeBallGFX
	fardw AnimObjGreatBallGFX
	fardw AnimObjUltraBallGFX
	fardw AnimObjMasterBallGFX
	fardw AnimObjSafariBallGFX
	fardw AnimObjLevelBallGFX
	fardw AnimObjLureBallGFX
	fardw AnimObjMoonBallGFX
	fardw AnimObjFriendBallGFX
	fardw AnimObjFastBallGFX
	fardw AnimObjHeavyBallGFX
	fardw AnimObjLoveBallGFX
	fardw AnimObjRepeatBallGFX
	fardw AnimObjTimerBallGFX
	fardw AnimObjNestBallGFX
	fardw AnimObjNetBallGFX
	fardw AnimObjDiveBallGFX
	fardw AnimObjLuxuryBallGFX
	fardw AnimObjHealBallGFX
	fardw AnimObjQuickBallGFX
	fardw AnimObjDuskBallGFX
	fardw AnimObjDreamBallGFX
	fardw AnimObjPremierBallGFX
	fardw AnimObjCherishBallGFX
	assert_table_length NUM_POKE_BALLS
