SaffronOrreSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 17
	warp_event  3,  7, SAFFRON_CITY, 17

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronOrreSpeechHouseSilphEmployeeText, -1
	object_event  5,  4, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SaffronOrreSpeechHouseCooltrainerMText, -1

SaffronOrreSpeechHouseSilphEmployeeText:
	text "I heard about a"
	line "method to seal off"
	cont "a #mon's heart"

	para "and force them to"
	line "attack people."

	para "How could anyone"
	line "do such a horrible"
	cont "thing to #mon?!"
	done

SaffronOrreSpeechHouseCooltrainerMText:
	text "We just got back"
	line "from seeing a"

	para "friend in another"
	line "region."

	para "They had a lot of"
	line "trouble from two"
	cont "criminal gangs,"

	para "but a talented"
	line "trainer stepped up"
	cont "to save them."
	done
