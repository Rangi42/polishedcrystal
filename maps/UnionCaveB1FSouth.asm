const_value set 2
	const UNIONCAVEB1F_SUPER_NERD1
	const UNIONCAVEB1F_SUPER_NERD2
	const UNIONCAVEB1F_BOULDER

UnionCaveB1FSouth_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerPokemaniacAndrew:
	trainer EVENT_BEAT_POKEMANIAC_ANDREW, POKEMANIAC, ANDREW, PokemaniacAndrewSeenText, PokemaniacAndrewBeatenText, 0, PokemaniacAndrewScript

PokemaniacAndrewScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x5a181
	waitbutton
	closetext
	end

TrainerPokemaniacCalvin:
	trainer EVENT_BEAT_POKEMANIAC_CALVIN, POKEMANIAC, CALVIN, PokemaniacCalvinSeenText, PokemaniacCalvinBeatenText, 0, PokemaniacCalvinScript

PokemaniacCalvinScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x5a230
	waitbutton
	closetext
	end

UnionCaveB1FSouthBoulder:
	jumpstd strengthboulder

PokemaniacAndrewSeenText:
	text "Who's there?"

	para "Leave me and my"
	line "#mon alone!"
	done

PokemaniacAndrewBeatenText:
	text "Go…"
	line "Go away!"
	done

UnknownText_0x5a181:
	text "Just me and my"
	line "#mon. I'm de-"
	cont "lirious with joy."
	done

PokemaniacCalvinSeenText:
	text "I came all the way"
	line "here to conduct my"
	cont "#mon research."

	para "Let me demonstrate"
	line "my findings in a"
	cont "real battle!"
	done

PokemaniacCalvinBeatenText:
	text "You demonstrated"
	line "on me!"
	done

UnknownText_0x5a230:
	text "I should compile"
	line "and announce my"
	cont "study findings."

	para "I might even be-"
	line "come famous like"
	cont "Prof.Elm."
	done

UnionCaveB1FSouth_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $5, $3, 2, UNION_CAVE_1F
	warp_def $3, $11, 1, UNION_CAVE_B2F
	warp_def $21, $5, 3, MURKY_SWAMP

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_SUPER_NERD, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPokemaniacAndrew, -1
	person_event SPRITE_SUPER_NERD, 2, 17, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPokemaniacCalvin, -1
	person_event SPRITE_BOULDER, 4, 14, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, UnionCaveB1FSouthBoulder, -1
