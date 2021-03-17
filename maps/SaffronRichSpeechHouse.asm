SaffronRichSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 20
	warp_event  3,  7, SAFFRON_CITY, 20

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronRichSpeechHouseRichBoyText, -1

SaffronRichSpeechHouseRichBoyText:
	text "Houses are expen-"
	line "sive in Saffron."

	para "If you want to"
	line "live here, you've"

	para "got to have a lot"
	line "of money, or find"
	cont "a roommate."
	done
