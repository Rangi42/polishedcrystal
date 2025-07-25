OlsteetonNameRater_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, OLSTEETON, 18
	warp_event  3,  7, OLSTEETON, 18

	def_coord_events

	def_bg_events
	bg_event  5,  1, BGEVENT_JUMPSTD, radio2
	bg_event  7,  1, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  2,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonNameRater, -1

OlsteetonNameRater:
	faceplayer
	opentext
	special SpecialNameRater
	waitendtext
