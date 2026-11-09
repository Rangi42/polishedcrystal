LyrasHouse2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  0, LYRAS_HOUSE_1F, 3

	def_coord_events

	def_bg_events
	bg_event  4,  1, BGEVENT_JUMPTEXT, LyrasHousePCText
	bg_event  5,  1, BGEVENT_READ, InitialRadio
	bg_event  7,  1, BGEVENT_READ, PokemonJournalProfElmScript

	def_object_events
	object_event  2,  3, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, LyrasHouseLyraText, EVENT_LYRA_IN_HER_ROOM
	pokemon_event  3,  3, PIDGEOT, SPRITEMOVEDATA_POKEMON, -1, PAL_MON_BROWN, LyrasHousePidgeotText, EVENT_LYRA_IN_HER_ROOM
	object_event  6,  2, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, PAL_NPC_N64, OBJECTTYPE_COMMAND, jumptext, LyrasHouseN64Text, -1

LyrasHouseLyraText:
	text "Lyra: Hi, <PLAYER>!"

	para "Hmm… My #mon"
	line "may be putting"

	para "on some weight"
	line "lately…"
	done

LyrasHousePidgeotText:
	text "Pidgeot: Pijiii!"
	done

LyrasHousePCText:
	text "You shouldn't mess"
	line "with someone"
	cont "else's PC!"
	done

LyrasHouseN64Text:
	text "It's a limited-"
	line "edition Pikachu"
	cont "N64!"
	done
