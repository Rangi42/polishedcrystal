const_value set 2
	const RUINSOFALPHAERODACTYLITEMROOM_POKE_BALL1
	const RUINSOFALPHAERODACTYLITEMROOM_POKE_BALL2
	const RUINSOFALPHAERODACTYLITEMROOM_POKE_BALL3
	const RUINSOFALPHAERODACTYLITEMROOM_POKE_BALL4

RuinsofAlphAerodactylItemRoom_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

RuinsofAlphAerodactylItemRoomRareBone:
	itemball RARE_BONE

RuinsofAlphAerodactylItemRoomEnergyRoot:
	itemball ENERGY_ROOT

RuinsofAlphAerodactylItemRoomRevivalHerb:
	itemball REVIVAL_HERB

RuinsofAlphAerodactylItemRoomShellBell:
	itemball SHELL_BELL

MapRuinsofAlphAerodactylItemRoomSignpost1Script:
	jumptext UnknownText_0x59ac1

UnknownText_0x59ac1:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done

RuinsofAlphAerodactylItemRoom_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $9, $3, 5, RUINS_OF_ALPH_AERODACTYL_CHAMBER
	warp_def $9, $4, 5, RUINS_OF_ALPH_AERODACTYL_CHAMBER
	warp_def $1, $3, 1, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM
	warp_def $1, $4, 2, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 1, 2, SIGNPOST_READ, MapRuinsofAlphAerodactylItemRoomSignpost1Script
	signpost 1, 5, SIGNPOST_READ, MapRuinsofAlphAerodactylItemRoomSignpost1Script

.PersonEvents:
	db 4
	person_event SPRITE_BALL_CUT_FRUIT, 6, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RuinsofAlphAerodactylItemRoomRareBone, EVENT_PICKED_UP_RARE_BONE_FROM_AERODACTYL_ITEM_ROOM
	person_event SPRITE_BALL_CUT_FRUIT, 6, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RuinsofAlphAerodactylItemRoomEnergyRoot, EVENT_PICKED_UP_ENERGY_ROOT_FROM_AERODACTYL_ITEM_ROOM
	person_event SPRITE_BALL_CUT_FRUIT, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RuinsofAlphAerodactylItemRoomRevivalHerb, EVENT_PICKED_UP_REVIVAL_HERB_FROM_AERODACTYL_ITEM_ROOM
	person_event SPRITE_BALL_CUT_FRUIT, 4, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RuinsofAlphAerodactylItemRoomShellBell, EVENT_PICKED_UP_SHELL_BELL_FROM_AERODACTYL_ITEM_ROOM
