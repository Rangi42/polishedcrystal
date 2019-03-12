emote: MACRO
; graphics pointer, length, starting tile
	dw \1
	db \2 tiles, BANK(\1)
	dw VTiles0 tile \3
ENDM

EmotesPointers:
	emote ShockEmote,      4, $78 ; EMOTE_SHOCK
	emote QuestionEmote,   4, $78 ; EMOTE_QUESTION
	emote HappyEmote,      4, $78 ; EMOTE_HAPPY
	emote SadEmote,        4, $78 ; EMOTE_SAD
	emote HeartEmote,      4, $78 ; EMOTE_HEART
	emote BoltEmote,       4, $78 ; EMOTE_HEART
	emote SleepEmote,      4, $78 ; EMOTE_SLEEP
	emote FishEmote,       4, $78 ; EMOTE_FISH
	emote JumpShadowGFX,   1, $7c ; EMOTE_SHADOW
	emote FishingRodGFX,   2, $7c ; EMOTE_ROD
	emote BoulderDustGFX,  2, $7e ; EMOTE_BOULDER_DUST
	emote ShakingGrassGFX, 1, $7e ; EMOTE_SHAKING_GRASS
	emote PuddleSplashGFX, 1, $7f ; EMOTE_PUDDLE_SPLASH
