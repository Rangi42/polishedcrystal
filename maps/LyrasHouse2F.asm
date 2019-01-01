LyrasHouse2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  0,  0, LYRAS_HOUSE_1F, 3

	db 0 ; coord events

	db 3 ; bg events
	bg_event  4,  1, SIGNPOST_JUMPTEXT, LyrasHousePCText
	bg_event  5,  1, SIGNPOST_READ, LyrasHouseRadio
	bg_event  7,  1, SIGNPOST_READ, PokemonJournalProfElmScript

	db 3 ; object events
	object_event  2,  3, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, LyrasHouseLyraText, EVENT_LYRA_IN_HER_ROOM
	object_event  3,  3, SPRITE_AMPHAROS, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_POKEMON, AMPHAROS, LyrasHouseAmpharosText, EVENT_LYRA_IN_HER_ROOM
	object_event  6,  2, SPRITE_N64, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, PAL_NPC_ROCK, PERSONTYPE_COMMAND, jumptext, LyrasHouseN64Text, -1

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
	text "Lyra: Hi, <PLAYER>!"

	para "Hmm… My #mon"
	line "may be putting"

	para "on some weight"
	line "lately…"
	done

LyrasHouseAmpharosText:
	text "Ampharos: Palu!"
	line "Palulu!"
	done

LyrasRadioText1:
	text "Prof.Oak's #mon"
	line "Talk! Please tune"
	cont "in next time!"
	done

LyrasRadioText2:
	text "#mon Channel!"
	done

LyrasRadioText3:
	text "This is DJ Mary,"
	line "your co-host!"
	done

LyrasRadioText4:
	text "#mon!"
	line "#mon Channel…"
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
