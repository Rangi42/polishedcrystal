KrissNeighborsHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

KrissNeighborsHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 3, NEW_BARK_TOWN
	warp_def 7, 3, 3, NEW_BARK_TOWN

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 5, SIGNPOST_READ, KrissNeighborsHouseRadio

.PersonEvents: db 3
	person_event SPRITE_POKEFAN_F, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, KrissNeighborText, EVENT_KRISS_NEIGHBORS_HOUSE_NEIGHBOR
	person_event SPRITE_COOLTRAINER_F, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, KrissNeighborsDaughterText, -1
	person_event SPRITE_YOUNGSTER, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << NITE), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, KrissNeighborsHusbandText, -1

KrissNeighborsHouseRadio:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .NormalRadio
	checkevent EVENT_LISTENED_TO_INITIAL_RADIO
	iftrue .AbbreviatedRadio
	playmusic MUSIC_POKEMON_TALK
	opentext
	writetext KrisNeighborRadioText1
	pause 45
	writetext KrisNeighborRadioText2
	pause 45
	writetext KrisNeighborRadioText3
	pause 45
	musicfadeout MUSIC_NEW_BARK_TOWN, $10
	writetext KrisNeighborRadioText4
	pause 45
	closetext
	setevent EVENT_LISTENED_TO_INITIAL_RADIO
	end
.NormalRadio:
	jumpstd radio1
.AbbreviatedRadio:
	opentext
	writetext KrisNeighborRadioText4
	pause 45
	endtext

KrissNeighborsDaughterText:
	text "Pikachu is an"
	line "evolved #mon."

	para "I was amazed by"
	line "Prof.Elm's find-"
	cont "ings."

	para "He's so famous for"
	line "his research on"
	cont "#mon evolution."

	para "…sigh…"

	para "I wish I could be"
	line "a researcher like"
	cont "him…"
	done

KrissNeighborsHusbandText:
	text "This town is the"
	line "farthest south-"

	para "east one in all"
	line "of Johto."
	done

KrissNeighborText:
	text "My daughter is"
	line "adamant about"

	para "becoming Prof."
	line "Elm's assistant."

	para "She really loves"
	line "#mon!"

	para "But then, so do I!"
	done

KrisNeighborRadioText1:
	text "Prof.Oak's #mon"
	line "Talk! Please tune"
	cont "in next time!"
	done

KrisNeighborRadioText2:
	text "#mon Channel!"
	done

KrisNeighborRadioText3:
	text "This is DJ Mary,"
	line "your co-host!"
	done

KrisNeighborRadioText4:
	text "#mon!"
	line "#mon Channel…"
	done
