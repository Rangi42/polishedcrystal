LavenderNameRater_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

LavenderNameRater_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 4, LAVENDER_TOWN
	warp_def 7, 3, 4, LAVENDER_TOWN

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_GENTLEMAN, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LavenderNameRater, -1

LavenderNameRater:
	faceplayer
	opentext
	special SpecialNameRater
	waitendtext
