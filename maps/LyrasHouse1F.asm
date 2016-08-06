const_value set 2

LyrasHouse1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

LyrasTVScript:
	jumptext LyrasTVText

LyrasStoveScript:
	jumptext LyrasStoveText

LyrasSinkScript:
	jumptext LyrasSinkText

LyrasFridgeScript:
	jumptext LyrasFridgeText

LyrasStoveText:
	text "Mom's specialty!"

	para "Cinnabar Volcano"
	line "Burger!"
	done

LyrasSinkText:
	text "The sink is spot-"
	line "less. Mom likes it"
	cont "clean."
	done

LyrasFridgeText:
	text "Let's see what's"
	line "in the fridge…"

	para "Fresh Water and"
	line "tasty Lemonade!"
	done

LyrasTVText:
	text "There's a movie on"
	line "TV: Stars dot the"

	para "sky as two boys"
	line "ride on a train…"

	para "I'd better get"
	line "rolling too!"
	done

LyrasHouse1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $6, 4, NEW_BARK_TOWN
	warp_def $7, $7, 4, NEW_BARK_TOWN
	warp_def $0, $9, 1, LYRAS_HOUSE_2F

.XYTriggers:
	db 0

.Signposts:
	db 4
	signpost 1, 0, SIGNPOST_READ, LyrasStoveScript
	signpost 1, 1, SIGNPOST_READ, LyrasSinkScript
	signpost 1, 2, SIGNPOST_READ, LyrasFridgeScript
	signpost 1, 4, SIGNPOST_READ, LyrasTVScript

.PersonEvents:
	db 0
