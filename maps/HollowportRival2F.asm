HollowportRival2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  0, HOLLOWPORT_RIVAL_1F, 3

	def_bg_events
	bg_event  4,  1, BGEVENT_JUMPTEXT, RivalsHousePCText
	bg_event  5,  1, BGEVENT_READ, RivalsHouseRadio
	bg_event  7,  1, BGEVENT_READ, PokemonJournalProfElmScript

	def_object_events
	; object_event  6,  4, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RivalsHouseLyraText, EVENT_LYRA_IN_HER_ROOM
	pokemon_event  3,  5, PIDGEY, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BROWN, RivalsHousePidgeotText, -1
	object_event  3,  2, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, PAL_NPC_N64, OBJECTTYPE_COMMAND, jumptext, RivalsHouseN64Text, -1

RivalsHouseRadio:
opentext
writetext RivalsRadioText1
endtext
; 	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
; 	iftruefwd .NormalRadio
; 	checkevent EVENT_LISTENED_TO_INITIAL_RADIO
; 	iftruefwd .AbbreviatedRadio
; 	playmusic MUSIC_POKEMON_TALK
; 	opentext
; 	writetext RivalsRadioText1
; 	pause 45
; 	writetext RivalsRadioText2
; 	pause 45
; 	writetext RivalsRadioText3
; 	pause 45
; 	musicfadeout MUSIC_NEW_BARK_TOWN, 16
; 	writetext RivalsRadioText4
; 	pause 45
; 	closetext
; 	setevent EVENT_LISTENED_TO_INITIAL_RADIO
; 	end

; .NormalRadio:
; 	jumpstd radio1

; .AbbreviatedRadio:
; 	opentext
; 	writetext RivalsRadioText4
; 	pause 45
; 	endtext

; RivalsHouseLyraText:
; 	text "Lyra: Hi, <PLAYER>!"

; 	para "Hmm… My #mon"
; 	line "may be putting"

; 	para "on some weight"
; 	line "lately…"
; 	done

RivalsHousePidgeotText:
	text "Pidgey: Pijiii!"
	done

RivalsRadioText1:
	text "The radio is"
	line "turned off."
	done

; RivalsRadioText2:
; 	text "#mon Channel!"
; 	done

; RivalsRadioText3:
; 	text "This is DJ Mary,"
; 	line "your co-host!"
; 	done

; RivalsRadioText4:
; 	text "#mon!"
; 	line "#mon Channel…"
; 	done

RivalsHousePCText:
	text "You shouldn't mess"
	line "with someone"
	cont "else's PC!"
	done

RivalsHouseN64Text:
	text "It's a limited-"
	line "edition Pikachu"
	cont "N64!"
	done

; only changed Lyras>Rivals. All text needs rewritten