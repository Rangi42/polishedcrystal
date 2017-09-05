CopycatsHouse1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CopycatsHouse1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 2, 8, SAFFRON_CITY
	warp_def 7, 3, 8, SAFFRON_CITY
	warp_def 0, 3, 1, COPYCATS_HOUSE_2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_POKEFAN_M, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CopycatsHouse1FPokefanMText, -1
	person_event SPRITE_POKEFAN_F, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CopycatsHouse1FPokefanFScript, -1
	person_event SPRITE_BLISSEY, 5, 4, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_POKEMON, BLISSEY, CopycatsHouse1FBlisseyText, -1

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
