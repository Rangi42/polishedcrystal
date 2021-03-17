VioletOutskirts_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, VioletOutskirtsAvalanche

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event 16, -2, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SUICUNE, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_42
	fruittree_event 17, -2, FRUITTREE_ROUTE_42_1, PNK_APRICORN, PAL_NPC_RED
	fruittree_event 18, -2, FRUITTREE_ROUTE_42_2, GRN_APRICORN, PAL_NPC_GREEN
	fruittree_event 19, -2, FRUITTREE_ROUTE_42_3, YLW_APRICORN, PAL_NPC_BROWN

VioletOutskirtsAvalanche:
	checkevent EVENT_BEAT_JASMINE
	iftrue .end
	changeblock 4, -2, $0a
	changeblock 6, -2, $0a
.end
	endcallback
