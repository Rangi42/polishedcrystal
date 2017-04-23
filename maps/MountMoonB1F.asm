const_value set 2
	const MOUNTMOONB1F_POKEFAN_M

MountMoonB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

MountMoonB1FPokefanmScript:
	jumptextfaceplayer MountMoonB1FPokefanmText

MountMoonB1FHiddenStarPiece:
	dwb EVENT_MOUNT_MOON_B1F_HIDDEN_STAR_PIECE, STAR_PIECE

MountMoonB1FHiddenMoonStone:
	dwb EVENT_MOUNT_MOON_B1F_HIDDEN_MOON_STONE, MOON_STONE

MountMoonB1FPokefanmText:
	text "I'm excavating for"
	line "fossils here under"
	cont "Mt.Moon."

	para "Sometimes Brock of"
	line "Pewter Gym lends"
	cont "me a hand."
	done

MountMoonB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 10
	warp_def $14, $1a, 2, MOUNT_MOON_1F
	warp_def $3, $5, 3, MOUNT_MOON_1F
	warp_def $b, $3, 4, MOUNT_MOON_1F
	warp_def $1f, $f, 1, MOUNT_MOON_B2F
	warp_def $3, $d, 2, MOUNT_MOON_B2F
	warp_def $16, $10, 3, MOUNT_MOON_B2F
	warp_def $d, $f, 4, MOUNT_MOON_B2F
	warp_def $f, $f, 1, ROUTE_4
	warp_def $3, $17, 5, MOUNT_MOON_B2F
	warp_def $5, $17, 1, MOUNT_MOON_SQUARE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 18, 5, SIGNPOST_ITEM, MountMoonB1FHiddenStarPiece
	signpost 26, 24, SIGNPOST_ITEM, MountMoonB1FHiddenMoonStone

.PersonEvents:
	db 1
	person_event SPRITE_POKEFAN_M, 20, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, MountMoonB1FPokefanmScript, -1
