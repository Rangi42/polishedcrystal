const_value set 3
	const LYRASHOUSE2F_LYRA
	const LYRASHOUSE2F_AMPHAROS
	const LYRASHOUSE2F_N64

LyrasHouse2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

LyrasHouse2F_MapEventHeader:

.Warps: db 1
	warp_def 0, 0, 3, LYRAS_HOUSE_1F

.XYTriggers: db 0

.Signposts: db 3
	signpost 1, 4, SIGNPOST_JUMPTEXT, LyrasHousePCText
	signpost 1, 5, SIGNPOST_READ, LyrasHouseRadio
	signpost 1, 7, SIGNPOST_READ, PokemonJournalProfElmScript

.PersonEvents: db 3
	person_event SPRITE_LYRA, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, LyrasHouseLyraText, EVENT_LYRA_IN_HER_ROOM
	person_event SPRITE_AMPHAROS, 3, 3, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEMON, AMPHAROS, LyrasHouseAmpharosText, EVENT_LYRA_IN_HER_ROOM
	person_event SPRITE_N64, 2, 6, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_ROCK, PERSONTYPE_COMMAND, jumptext, LyrasHouseN64Text, -1

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
