CeladonChiefHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CELADON_CITY, 10
	warp_event  3,  7, CELADON_CITY, 10

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_ITEM + DUBIOUS_DISC, EVENT_CELADON_CHIEF_HOUSE_HIDDEN_DUBIOUS_DISC

	def_object_events
	object_event  1,  3, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonChiefHouseCooltrainerMText, -1

CeladonChiefHouseCooltrainerMText:
	text "The Game Corner is"
	line "making us a lot"
	cont "of money!"

	para "It's all legal,"
	line "too. Honestly!"
	done
