const_value set 2
	const SHAMOUTIPOKECENTER1F_NURSE

ShamoutiPokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiPokeCenter1FNurseScript:
	jumpstd pokecenternurse

PokemonJournalLoreleiScript:
	setflag ENGINE_READ_LORELEI_JOURNAL
	jumptext PokemonJournalLoreleiText

PokemonJournalLoreleiText:
	text "#mon Journal"

	para "Special Feature:"
	line "Ex-Elite Lorelei!"

	para "Lorelei is said to"
	line "have a complete"

	para "collection of"
	line "#mon dolls."
	done

ShamoutiPokeCenter1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $5, 1, SHAMOUTI_ISLAND
	warp_def $7, $6, 1, SHAMOUTI_ISLAND
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalLoreleiScript

.PersonEvents:
	db 1
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ShamoutiPokeCenter1FNurseScript, -1
