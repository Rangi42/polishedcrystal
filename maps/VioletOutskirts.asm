VioletOutskirts_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, VioletOutskirtsAvalanche

	db 0 ; warp events

	db 0 ; coord events

	db 0 ; bg events

	db 4 ; object events
	object_event 16, -2, SPRITE_SUICUNE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_42
	fruittree_event 17, -2, FRUITTREE_ROUTE_42_1, PNK_APRICORN
	fruittree_event 18, -2, FRUITTREE_ROUTE_42_2, GRN_APRICORN
	fruittree_event 19, -2, FRUITTREE_ROUTE_42_3, YLW_APRICORN

VioletOutskirtsAvalanche:
	checkevent EVENT_BEAT_JASMINE
	iftrue .end
	changeblock 4, -2, $0a
	changeblock 6, -2, $0a
.end
	return
