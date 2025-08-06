HollowportRival2F_MapScriptHeader:

	def_scene_scripts
;	scene_script script, SCENE_MAPNAME_SCENE_NAME

	def_callbacks
;	callback type, script

	def_warp_events
	warp_event  1,  0, HOLLOWPORT_RIVAL_1F, 3

	def_coord_events
;	coord_event x, y, scene_id, script

	def_bg_events
	bg_event  4,  1, BGEVENT_JUMPTEXT, RivalHousePCText
	bg_event  5,  1, BGEVENT_JUMPTEXT, RivalRadioText

	def_object_events
	pokemon_event  6,  4, PIDGEY, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BROWN, RivalHousePidgeyText, -1
	object_event  3,  2, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, PAL_NPC_N64, OBJECTTYPE_COMMAND, jumptext, RivalHouseN64Text, -1


RivalHousePidgeyText:
	text "Pidgey: Pijiii!"
	done
RivalRadioText:
	text "The radio is"
	line "turned off."
	done

RivalHousePCText:
	text "You shouldn't mess"
	line "with someone"
	cont "else's PC!"
	done

RivalHouseN64Text:
	text "It's a limited-"
	line "edition Pikachu"
	cont "N64!"
	done
