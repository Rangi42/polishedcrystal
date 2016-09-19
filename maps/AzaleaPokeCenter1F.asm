const_value set 2
	const AZALEAPOKECENTER1F_NURSE
	const AZALEAPOKECENTER1F_GENTLEMAN
	const AZALEAPOKECENTER1F_FISHING_GURU
	const AZALEAPOKECENTER1F_POKEFAN_F

AzaleaPokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 1

	; triggers
	dw UnknownScript_0x18db27, 0

.MapCallbacks:
	db 0

UnknownScript_0x18db27:
	end

NurseScript_0x18db28:
	jumpstd pokecenternurse

GentlemanScript_0x18db2b:
	jumptextfaceplayer UnknownText_0x18db34

FishingGuruScript_0x18db2e:
	jumptextfaceplayer UnknownText_0x18db88

PokefanFScript_0x18db31:
	jumptextfaceplayer UnknownText_0x18dc19

UnknownText_0x18db34:
	text "Do your #mon"
	line "know HM moves?"

	para "Those moves can"
	line "be used even if"

	para "your #mon has"
	line "fainted."
	done

UnknownText_0x18db88:
	text "This Bill guy"
	line "created the system"

	para "for storing"
	line "#mon in a PC."

	para "Bill's PC can"
	line "store up to 20"
	cont "#mon per Box."
	done

UnknownText_0x18dc19:
	text "Do you know about"
	line "Apricorns?"

	para "Crack one open,"
	line "hollow it out and"

	para "fit it with a"
	line "special device."

	para "Then you can catch"
	line "#mon with it."

	para "Before # Balls"
	line "were invented,"

	para "everyone used"
	line "Apricorns."
	done

AzaleaPokeCenter1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $5, 1, AZALEA_TOWN
	warp_def $7, $6, 1, AZALEA_TOWN
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 4
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x18db28, -1
	person_event SPRITE_GENTLEMAN, 6, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GentlemanScript_0x18db2b, -1
	person_event SPRITE_FISHING_GURU, 1, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x18db2e, -1
	person_event SPRITE_POKEFAN_F, 5, 2, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, PokefanFScript_0x18db31, -1
