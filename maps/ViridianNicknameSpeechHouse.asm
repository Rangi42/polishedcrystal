ViridianNicknameSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, VIRIDIAN_CITY, 2
	warp_event  3,  7, VIRIDIAN_CITY, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ViridianNicknameSpeechHousePokefanMText, -1
	object_event  5,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ViridianNicknameSpeechHouseLassText, -1
	pokemon_event  5,  2, HOOTHOOT, -1, -1, PAL_NPC_BROWN, HootyText, -1
	pokemon_event  6,  3, RATTATA, -1, -1, PAL_NPC_PURPLE, RatteyText, -1

ViridianNicknameSpeechHousePokefanMText:
	text "Do you put a lot"
	line "of thought into"

	para "naming your"
	line "#mon?"

	para "Giving them good"
	line "nicknames adds to"

	para "the fun of trading"
	line "with others."
	done

ViridianNicknameSpeechHouseLassText:
	text "They're Hooty--"
	line "a Hoothoot--and"
	cont "Rattey--a Rattata."
	done

HootyText:
	text "Hooty: Hoot!"
	done

RatteyText:
	text "Rattey: Kikiii!"
	done
