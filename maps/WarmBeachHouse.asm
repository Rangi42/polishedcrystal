WarmBeachHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

WarmBeachHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 3, WARM_BEACH
	warp_def 7, 3, 3, WARM_BEACH

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_GRAMPS, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, WarmBeachHouseGrampsText, -1
	person_event SPRITE_GRANNY, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, WarmBeachHouseGrannyText, -1
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, WarmBeachHouseBookScript, -1

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
