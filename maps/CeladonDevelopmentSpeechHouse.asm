CeladonDevelopmentSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CELADON_CITY, 16
	warp_event  3,  7, CELADON_CITY, 16

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDevelopmentSpeechHouseCooltrainermText, -1
	object_event  5,  3, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDevelopmentSpeechHouseBeautyText, -1

CeladonDevelopmentSpeechHouseCooltrainermText:
	text "Celadon has become"
	line "quite the tourist"
	cont "spot."

	para "The hotel's always"
	line "fully booked!"
	done

CeladonDevelopmentSpeechHouseBeautyText:
	text "This city used to"
	line "be a haven for"
	cont "Team Rocket."

	para "I was scared to"
	line "leave the house"
	cont "while they were"
	cont "lurking about!"
	done
