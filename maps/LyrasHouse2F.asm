LyrasHouse2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  0, LYRAS_HOUSE_1F, 3

	def_coord_events

	def_bg_events
	bg_event  4,  1, BGEVENT_JUMPTEXT, LyrasHousePCText
	bg_event  5,  1, BGEVENT_READ, LyrasHouseRadio
	bg_event  7,  1, BGEVENT_READ, PokemonJournalProfElmScript

	def_object_events
	object_event  2,  3, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, LyrasHouseLyraText, EVENT_LYRA_IN_HER_ROOM
	pokemon_event  3,  3, PIDGEOT, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_BROWN, LyrasHousePidgeotText, EVENT_LYRA_IN_HER_ROOM
	object_event  6,  2, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_COMMAND, jumptext, LyrasHouseN64Text, -1

LyrasHouseRadio:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .NormalRadio
	checkevent EVENT_LISTENED_TO_INITIAL_RADIO
	iftrue .AbbreviatedRadio
	playmusic MUSIC_POKEMON_TALK
	opentext
	writetext LyrasRadioText1
	pause 45
	writetext LyrasRadioText2
	pause 45
	writetext LyrasRadioText3
	pause 45
	musicfadeout MUSIC_NEW_BARK_TOWN, 16
	writetext LyrasRadioText4
	pause 45
	closetext
	setevent EVENT_LISTENED_TO_INITIAL_RADIO
	end

.NormalRadio:
	jumpstd radio1

.AbbreviatedRadio:
	opentext
	writetext LyrasRadioText4
	pause 45
	endtext

LyrasHouseLyraText:
	ctxt "Lyra: Hi, <PLAYER>!"

	para "Hmm… My #mon"
	line "may be putting"

	para "on some weight"
	line "lately…"
	done

LyrasHousePidgeotText:
	ctxt "Pidgeot: Pijiii!"
	done

LyrasRadioText1:
	ctxt "Prof.Oak's #mon"
	line "Talk! Please tune"
	cont "in next time!"
	done

LyrasRadioText2:
	ctxt "#mon Channel!"
	done

LyrasRadioText3:
	ctxt "This is DJ Mary,"
	line "your co-host!"
	done

LyrasRadioText4:
	ctxt "#mon!"
	line "#mon Channel…"
	done

LyrasHousePCText:
	ctxt "You shouldn't mess"
	line "with someone"
	cont "else's PC!"
	done

LyrasHouseN64Text:
	ctxt "It's a limited-"
	line "edition Pikachu"
	cont "N64!"
	done
