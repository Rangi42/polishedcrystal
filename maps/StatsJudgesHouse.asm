StatsJudgesHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 7, CIANWOOD_CITY
	warp_def 7, 3, 7, CIANWOOD_CITY

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf

	db 1 ; person events
	person_event SPRITE_COOLTRAINER_M, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, StatsJudgeScript, -1

StatsJudgeScript:
	faceplayer
	opentext
	special SpecialStatsJudge
	waitendtext
