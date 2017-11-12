MountMoonB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MountMoonB1F_MapEventHeader:

.Warps: db 8
	warp_def 4, 26, 2, MOUNT_MOON_1F
	warp_def 3, 5, 3, MOUNT_MOON_1F
	warp_def 11, 3, 4, MOUNT_MOON_1F
	warp_def 15, 15, 1, MOUNT_MOON_B2F
	warp_def 3, 13, 2, MOUNT_MOON_B2F
	warp_def 22, 16, 3, MOUNT_MOON_B2F
	warp_def 23, 27, 4, MOUNT_MOON_B2F
	warp_def 25, 27, 1, ROUTE_4

.XYTriggers: db 0

.Signposts: db 2
	signpost 18, 5, SIGNPOST_ITEM + STAR_PIECE, EVENT_MOUNT_MOON_B1F_HIDDEN_STAR_PIECE
	signpost 10, 24, SIGNPOST_ITEM + MOON_STONE, EVENT_MOUNT_MOON_B1F_HIDDEN_MOON_STONE

.PersonEvents: db 1
	person_event SPRITE_POKEFAN_M, 20, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, MountMoonB1FPokefanmText, -1

MountMoonB1FPokefanmText:
	text "I'm excavating for"
	line "fossils here under"
	cont "Mt.Moon."

	para "Sometimes Brock of"
	line "Pewter Gym lends"
	cont "me a hand."
	done
