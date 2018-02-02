CeladonMansion1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event  6,  9, CELADON_CITY, 2
	warp_event  7,  9, CELADON_CITY, 2
	warp_event  3,  0, CELADON_CITY, 3
	warp_event  0,  0, CELADON_MANSION_2F, 1
	warp_event  7,  0, CELADON_MANSION_2F, 4

	db 0 ; coord events

	db 3 ; bg events
	bg_event  5,  8, SIGNPOST_UP, CeladonMansionManagersSuiteSign
	bg_event  0,  3, SIGNPOST_JUMPSTD, picturebookshelf
	bg_event  2,  3, SIGNPOST_JUMPSTD, picturebookshelf

	db 4 ; object events
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonMansionManagerText, -1
	object_event  2,  6, SPRITE_MEOWTH, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_POKEMON, MEOWTH, CeladonMansion1FMeowthText, -1
	object_event  3,  4, SPRITE_CLEFAIRY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, PERSONTYPE_POKEMON, CLEFAIRY, CeladonMansion1FClefairyText, -1
	object_event  4,  4, SPRITE_NIDORAN_F, SPRITEMOVEDATA_POKEMON, 0, 2, -1, -1, PAL_NPC_BLUE, PERSONTYPE_POKEMON, NIDORAN_F, CeladonMansion1FNidoranFText, -1

CeladonMansionManagersSuiteSign:
	thistext

	text "Celadon Mansion"
	line "Manager's Suite"
	done

CeladonMansionManagerText:
	text "My dear #mon"
	line "keep me company,"

	para "so I don't ever"
	line "feel lonely."

	para "Meowth even brings"
	line "money home."
	done

CeladonMansion1FMeowthText:
	text "Meowth: Meow!"
	done

CeladonMansion1FClefairyText:
	text "Clefairy: Clef"
	line "cleff!"
	done

CeladonMansion1FNidoranFText:
	text "Nidoran: Kya"
	line "kyaoo!"
	done
