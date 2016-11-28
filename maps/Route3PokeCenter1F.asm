const_value set 2
	const ROUTE3POKECENTER1F_NURSE
	const PEWTERPOKECENTER1F_POKEFAN_M

Route3PokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route3PokeCenter1FNurseScript:
	jumpstd pokecenternurse

Route3PokeCenter1FPokefanMScript:
	jumptextfaceplayer Route3PokeCenter1FPokefanMText

Route3PokeCenter1FPokefanMText:
	text "A few years ago"
	line "I sold a weird-"

	para "colored Magikarp"
	line "to this boy…"

	para "I thought there"
	line "was something"
	cont "wrong with it."
	
	para "Turns out it was"
	line "a rare shiny"
	cont "#mon!"

	para "I could have made"
	line "a lot more money!"
	done

Route3PokeCenter1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $5, 2, ROUTE_3
	warp_def $7, $6, 2, ROUTE_3
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route3PokeCenter1FNurseScript, -1
	person_event SPRITE_POKEFAN_M, 4, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route3PokeCenter1FPokefanMScript, -1
