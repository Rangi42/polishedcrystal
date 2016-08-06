const_value set 2

LyrasHouse2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

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
	closetext
	end

LyrasHouseBookshelf:
	jumpstd picturebookshelf

LyrasHousePC:
	jumptext LyrasHousePCText

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
	text "TODO"
	done

LyrasHouse2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $0, $7, 3, LYRAS_HOUSE_1F

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 1, 2, SIGNPOST_UP, LyrasHousePC
	signpost 1, 3, SIGNPOST_READ, LyrasHouseRadio
	signpost 1, 5, SIGNPOST_READ, LyrasHouseBookshelf

.PersonEvents:
	db 0
