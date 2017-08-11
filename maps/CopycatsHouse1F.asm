CopycatsHouse1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CopycatsHouse1F_MapEventHeader:

.Warps: db 3
	warp_def $7, $2, 8, SAFFRON_CITY
	warp_def $7, $3, 8, SAFFRON_CITY
	warp_def $0, $3, 1, COPYCATS_HOUSE_2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_POKEFAN_M, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x18ad34, -1
	person_event SPRITE_POKEFAN_F, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, PokefanFScript_0x18ad16, -1
	person_event SPRITE_BLISSEY, 5, 4, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BlisseyScript_0x18ad2a, -1

PokefanFScript_0x18ad16:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue UnknownScript_0x18ad24
	jumpopenedtext UnknownText_0x18ad95

UnknownScript_0x18ad24:
	jumpopenedtext UnknownText_0x18add3

BlisseyScript_0x18ad2a:
	opentext
	writetext UnknownText_0x18ae4b
	cry BLISSEY
	waitbutton
	closetext
	end

UnknownText_0x18ad34:
	text "My daughter likes"
	line "to mimic people."

	para "Her mimicry has"
	line "earned her the"

	para "nickname Copycat"
	line "around here."
	done

UnknownText_0x18ad95:
	text "My daughter is so"
	line "self-centered…"

	para "She only has a few"
	line "friends."
	done

UnknownText_0x18add3:
	text "She recently lost"
	line "the # Doll that"

	para "a boy gave her"
	line "three years ago."

	para "Ever since then,"
	line "she's gotten even"
	cont "better at mimicry…"
	done

UnknownText_0x18ae4b:
	text "Blissey: Bliisii!"
	done
