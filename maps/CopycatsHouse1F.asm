CopycatsHouse1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  2,  7, SAFFRON_CITY, 8
	warp_event  3,  7, SAFFRON_CITY, 8
	warp_event  3,  0, COPYCATS_HOUSE_2F, 1

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CopycatsHouse1FPokefanMText, -1
	object_event  5,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, CopycatsHouse1FPokefanFScript, -1
	object_event  4,  5, SPRITE_BLISSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_POKEMON, BLISSEY, CopycatsHouse1FBlisseyText, -1

CopycatsHouse1FPokefanMText:
	text "My daughter likes"
	line "to mimic people."

	para "Her mimicry has"
	line "earned her the"

	para "nickname Copycat"
	line "around here."
	done

CopycatsHouse1FPokefanFScript:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer .Text2
	thistextfaceplayer

	text "My daughter is so"
	line "self-centered…"

	para "She only has a few"
	line "friends."
	done

.Text2:
	text "She recently lost"
	line "the # Doll that"

	para "a boy gave her"
	line "three years ago."

	para "Ever since then,"
	line "she's gotten even"
	cont "better at mimicry…"
	done

CopycatsHouse1FBlisseyText:
	text "Blissey: Bliisii!"
	done
