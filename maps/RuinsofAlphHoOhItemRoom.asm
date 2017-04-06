const_value set 2
	const RUINSOFALPHHOOHITEMROOM_POKE_BALL1
	const RUINSOFALPHHOOHITEMROOM_POKE_BALL2
	const RUINSOFALPHHOOHITEMROOM_POKE_BALL3
	const RUINSOFALPHHOOHITEMROOM_POKE_BALL4

RuinsofAlphHoOhItemRoom_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

RuinsofAlphHoOhItemRoomSunStone:
	itemball SUN_STONE

RuinsofAlphHoOhItemRoomMoonStone:
	itemball MOON_STONE

RuinsofAlphHoOhItemRoomPearlString:
	itemball PEARL_STRING

RuinsofAlphHoOhItemRoomCharcoal:
	itemball CHARCOAL

MapRuinsofAlphHoOhItemRoomSignpost1Script:
	jumptext UnknownText_0x59923

UnknownText_0x59923:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done

RuinsofAlphHoOhItemRoom_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $9, $3, 5, RUINS_OF_ALPH_HO_OH_CHAMBER
	warp_def $9, $4, 5, RUINS_OF_ALPH_HO_OH_CHAMBER
	warp_def $1, $3, 1, RUINS_OF_ALPH_HO_OH_WORD_ROOM
	warp_def $1, $4, 2, RUINS_OF_ALPH_HO_OH_WORD_ROOM

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 1, 2, SIGNPOST_READ, MapRuinsofAlphHoOhItemRoomSignpost1Script
	signpost 1, 5, SIGNPOST_READ, MapRuinsofAlphHoOhItemRoomSignpost1Script

.PersonEvents:
	db 4
	person_event SPRITE_BALL_CUT_FRUIT, 6, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RuinsofAlphHoOhItemRoomSunStone, EVENT_PICKED_UP_SUN_STONE_FROM_HO_OH_ITEM_ROOM
	person_event SPRITE_BALL_CUT_FRUIT, 6, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RuinsofAlphHoOhItemRoomMoonStone, EVENT_PICKED_UP_MOON_STONE_FROM_HO_OH_ITEM_ROOM
	person_event SPRITE_BALL_CUT_FRUIT, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RuinsofAlphHoOhItemRoomPearlString, EVENT_PICKED_UP_PEARL_STRING_FROM_HO_OH_ITEM_ROOM
	person_event SPRITE_BALL_CUT_FRUIT, 4, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RuinsofAlphHoOhItemRoomCharcoal, EVENT_PICKED_UP_CHARCOAL_FROM_HO_OH_ITEM_ROOM
