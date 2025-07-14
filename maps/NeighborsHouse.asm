NeighborsHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, HOLLOWPORT, 2
	warp_event  3,  7, HOLLOWPORT, 2

	def_coord_events

	def_bg_events
	bg_event  5,  1, BGEVENT_READ,  NeighborsHouseRadio

	def_object_events
	object_event  5,  3, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, NeighborText, -1
	object_event  2,  3, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, NeighborsDaughterText, -1
	object_event  5,  4, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, 0, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, NeighborsHusbandText, -1

NeighborsHouseRadio:
	; checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	; iftruefwd .NormalRadio
	; checkevent EVENT_LISTENED_TO_INITIAL_RADIO
	; iftruefwd .AbbreviatedRadio
	; playmusic MUSIC_POKEMON_TALK
	; opentext
	; writetext NeighborRadioText1
	; pause 45
	; writetext NeighborRadioText2
	; pause 45
	; writetext NeighborRadioText3
	; pause 45
	; musicfadeout MUSIC_NEW_BARK_TOWN, $10
	; writetext NeighborRadioText4
	; pause 45
	; closetext
	; setevent EVENT_LISTENED_TO_INITIAL_RADIO
	; end
.NormalRadio:
	jumpstd radio1
.AbbreviatedRadio:
	opentext
	writetext NeighborRadioText4
	pause 45
	endtext

NeighborsDaughterText:
	text "Glutglub only"
	line "likes clean water"

	para "I was amazed by"
	line "Prof. Pawpaw's"
	cont "findings!"

	para "He's so famous for"
	line "his research on"
	cont "#mon biomes."

	para "…sigh…"

	para "I wish I could be"
	line "a researcher like"
	cont "him…"
	done

NeighborsHusbandText:
	text "My wife and I"
	line "have lived here"

	para "since we finished"
	line "the academy!"
	cont "It's lovely here."
	done

NeighborText:
	text "My daughter is"
	line "adamant about"

	para "becoming just"
	line "like Prof. Paw-"
	cont "paw one day."

	para "She really loves"
	line "#mon!"

	para "But then, so do I!"
	done

NeighborRadioText1:
	text "Prof.Poplar's"
	line "#mon Talk! Tune"
	cont "in next time!"
	done

NeighborRadioText2:
	text "#mon Channel!"
	done

NeighborRadioText3:
	text "The new gym is"
	line "set to open soon!"
	
	para "This has been"
	line "Jazzy Jake report-"
	cont "ing!"
	done

NeighborRadioText4:
	text "#mon!"
	line "#mon Channel…"
	done
