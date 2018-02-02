WarmBeachHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, WARM_BEACH, 3
	warp_event  3,  7, WARM_BEACH, 3

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, WarmBeachHouseGrampsText, -1
	object_event  5,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, WarmBeachHouseGrannyText, -1
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, WarmBeachHouseBookScript, -1

WarmBeachHouseGrampsText:
	text "TODO"
	done

WarmBeachHouseGrannyText:
	text "TODO"
	done

WarmBeachHouseBookScript:
	opentext
	writetext .Text0
	yesorno
	iffalse_endtext
	writetext .Text1
	yesorno
	iffalse_endtext
	writetext .Text2
	yesorno
	iffalse_endtext
	thisopenedtext

	text "From the trio of"
	line "islands, ancient"
	cont "spheres shall you"
	cont "take."

	para "For between life"
	line "and death, all the"
	cont "difference you'll"
	cont "make."

	para "Climb to the"
	line "shrine to right"
	cont "what is wrong,"

	para "and the world"
	line "shall be healed"
	cont "by the guardian's"
	cont "song…"
	done

.Text0:
	text "The Shamouti"
	line "Prophecy"

	para "Want to read it?"
	done

.Text1:
	text "Disturb not the"
	line "harmony of fire,"
	cont "ice, or lightning,"

	para "lest these titans"
	line "wreak destruction"
	cont "upon the world in"
	cont "which they clash."

	para "Though the water's"
	line "great guardian sh-"
	cont "all arise to quell"
	cont "the fighting,"

	para "alone its song"
	line "will fail, and"
	cont "thus the earth"
	cont "shall turn to ash."

	para "Keep reading?"
	done

.Text2:
	text "O Chosen One,"
	line "into thine hands"
	cont "bring together"
	cont "all three."

	para "Their treasures"
	line "combined tame the"
	cont "beast of the sea."

	para "Keep reading?"
	done
