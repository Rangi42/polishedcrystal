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
	table_width 3
	farbank "Battle Anim Graphics"
	battleanimgfx  0, AnimObj00GFX
	battleanimgfx 35, AnimObjHitGFX
	battleanimgfx  7, AnimObjCutGFX
	battleanimgfx  6, AnimObjFireGFX
	battleanimgfx 20, AnimObjWaterGFX
	battleanimgfx 26, AnimObjLightningGFX
	battleanimgfx 18, AnimObjPlantGFX
	battleanimgfx 12, AnimObjSmokeGFX
	battleanimgfx  9, AnimObjExplosionGFX
	battleanimgfx 19, AnimObjRocksGFX
	battleanimgfx  6, AnimObjIceGFX
	battleanimgfx 10 ; use AnimBallObjGFX
	battleanimgfx 19, AnimObjPoisonGFX
	battleanimgfx 14, AnimObjBubbleGFX
	battleanimgfx 16, AnimObjNoiseGFX
	battleanimgfx  2, AnimObjPowderGFX
	battleanimgfx 11, AnimObjBeamGFX
	battleanimgfx  9, AnimObjSpeedGFX
	battleanimgfx 10, AnimObjChargeGFX
	battleanimgfx 21, AnimObjWindGFX
	battleanimgfx  4, AnimObjWindBGGFX
	battleanimgfx 10, AnimObjWhipGFX
	battleanimgfx 12, AnimObjEggGFX
	battleanimgfx 18, AnimObjRopeGFX
	battleanimgfx 14, AnimObjPsychicGFX
	battleanimgfx 10, AnimObjReflectGFX
	battleanimgfx 27, AnimObjStatusGFX
	battleanimgfx 12, AnimObjSandGFX
	battleanimgfx 14, AnimObjWebGFX
	battleanimgfx 16, AnimObjHazeGFX
	battleanimgfx 11, AnimObjHornGFX
	battleanimgfx  8, AnimObjFlowerGFX
	battleanimgfx 40, AnimObjMiscGFX
	battleanimgfx 36, AnimObjSkyAttackGFX
	battleanimgfx 16, AnimObjGlobeGFX
	battleanimgfx 48, AnimObjShapesGFX
	battleanimgfx 21, AnimObjObjectsGFX
	battleanimgfx 38, AnimObjShineGFX
	battleanimgfx 35, AnimObjAngelsGFX
	battleanimgfx 18, AnimObjWaveGFX
	battleanimgfx 24, AnimObjAeroblastGFX
	battleanimgfx 16, AnimObjMoonGFX
	battleanimgfx 16, AnimObjAuraSphereGFX
	battleanimgfx  9, AnimObjBugBuzzGFX
	battleanimgfx  9, AnimObjMidGlowClearGFX
	battleanimgfx  9, AnimObjTearGFX
	battleanimgfx 32, AnimObjVortexGFX
	battleanimgfx 18, AnimObjBulkUpGFX
	battleanimgfx  6, AnimObjRingsGFX
	battleanimgfx 13, AnimObjBigRingsGFX
	battleanimgfx 55, AnimObjGyroBallGFX
	battleanimgfx  5, AnimObjHeartsGFX
	battleanimgfx  5, AnimObjStarsGFX
	battleanimgfx 48, AnimObjUTurnGFX
	battleanimgfx  5, AnimObjMisc2GFX
	battleanimgfx 10, AnimObjBeamAuroraGFX
	battleanimgfx  9, AnimObjSmokePuffGFX
	battleanimgfx 18, AnimObjFocusBlastGFX
	battleanimgfx 10, AnimObjEnergyBallGFX
	battleanimgfx 14, AnimObjTrickRoomGFX
	battleanimgfx 13, AnimObjBigGlowClearGFX
	battleanimgfx 22, AnimObjObjects2GFX
	battleanimgfx 18, AnimObjBigWhipGFX
	battleanimgfx 24, AnimObjSwirlGFX
	battleanimgfx 12, AnimObjTriangleGFX
	battleanimgfx 18, AnimObjMushroomGFX
	battleanimgfx 12, AnimObjBerryGFX
	battleanimgfx  2, AnimObjStatsGFX
	battleanimgfx 10, AnimObjGlowGFX
	battleanimgfx 28, AnimObjAquaJetGFX
	battleanimgfx  9, AnimObjHit2GFX
	battleanimgfx  6, AnimObjIcicleCrashGFX
	battleanimgfx 28, AnimObjVoltSwitchGFX
	battleanimgfx 16, AnimObjPsystrikeGFX
	battleanimgfx 18, AnimObjHurricaneGFX
	battleanimgfx 12, AnimObjWaterBallGFX
	battleanimgfx 10, AnimObjBeamSolarGFX
	battleanimgfx  4, AnimObjPetalsGFX
	battleanimgfx 10, AnimObjGlowShadowGFX
	battleanimgfx  1 ; ANIM_GFX_PLAYERHEAD
	battleanimgfx  1 ; ANIM_GFX_ENEMYFEET
	battleanimgfx 10, AnimObjPokeBallBGGFX
	assert_table_length NUM_ANIM_GFX + 1

AnimBallObjGFX:
; entries correspond to poke ball item constants
	table_width 2
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
