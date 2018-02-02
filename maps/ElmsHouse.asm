ElmsHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  7,  4, NEW_BARK_TOWN, 5
	warp_event  7,  5, NEW_BARK_TOWN, 5

	db 0 ; coord events

	db 3 ; bg events
	bg_event  0,  1, SIGNPOST_JUMPTEXT, ElmsHouseFridgeText
	bg_event  6,  1, SIGNPOST_JUMPTEXT, ElmsHousePCText
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 2 ; object events
	object_event  1,  5, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, ElmsWifeText, -1
	object_event  4,  5, SPRITE_CHILD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, ElmsSonText, -1

ElmsWifeText:
	text "Hi, <PLAYER>! My"
	line "husband's always"

	para "so busy--I hope"
	line "he's OK."

	para "When he's caught"
	line "up in his #mon"

	para "research, he even"
	line "forgets to eat."
	done

ElmsSonText:
	text "When I grow up,"
	line "I'm going to help"
	cont "my dad!"

	para "I'm going to be a"
	line "great #mon"
	cont "professor!"
	done

ElmsHouseFridgeText:
	text "There's some food"
	line "here. This must be"
	cont "for #mon."
	done

ElmsHousePCText:
	text "#mon. Where do"
	line "they come from?"

	para "Where are they"
	line "going?"

	para "Why has no one"
	line "ever witnessed a"
	cont "#mon's birth?"

	para "I want to know! I"
	line "will dedicate my"

	para "life to the study"
	line "of #mon!"

	para "…"

	para "It's a part of"
	line "Prof.Elm's re-"
	cont "search papers."
	done
