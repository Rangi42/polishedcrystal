const_value set 2
	const CINNABARVOLCANO1F_SCIENTIST
	const CINNABARVOLCANO1F_SUPER_NERD
	const CINNABARVOLCANO1F_BOULDER1
	const CINNABARVOLCANO1F_BOULDER2
	const CINNABARVOLCANO1F_BOULDER3
	const CINNABARVOLCANO1F_BOULDER4
	const CINNABARVOLCANO1F_BOULDER5
	const CINNABARVOLCANO1F_ROCK1
	const CINNABARVOLCANO1F_ROCK2
	const CINNABARVOLCANO1F_ROCK3
	const CINNABARVOLCANO1F_ROCK4
	const CINNABARVOLCANO1F_ROCK5
	const CINNABARVOLCANO1F_ROCK6
	const CINNABARVOLCANO1F_ROCK7

CinnabarVolcano1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks
	dbw MAPCALLBACK_CMDQUEUE, .BouldersFall

.BouldersFall:
	writecmdqueue .BoulderCmdQueue
	return

.BoulderCmdQueue:
	dbw CMDQUEUE_STONETABLE, .BoulderTable ; check if any stones are sitting on a warp
	dw 0 ; filler

.BoulderTable:
	stonetable 6, CINNABARVOLCANO1F_BOULDER1, .Disappear1
	stonetable 7, CINNABARVOLCANO1F_BOULDER2, .Disappear2
	stonetable 8, CINNABARVOLCANO1F_BOULDER3, .Disappear3
	stonetable 9, CINNABARVOLCANO1F_BOULDER4, .Disappear4
	db -1 ; end

.Disappear1:
	disappear CINNABARVOLCANO1F_BOULDER1
	jump .Fall

.Disappear2:
	disappear CINNABARVOLCANO1F_BOULDER2
	jump .Fall

.Disappear3:
	disappear CINNABARVOLCANO1F_BOULDER3
	jump .Fall

.Disappear4:
	disappear CINNABARVOLCANO1F_BOULDER4
	jump .Fall

.Fall:
	pause 30
	scall .FX
	opentext
	writetext CinnabarVolcano1FBoulderFellText
	waitbutton
	closetext
	end

.FX:
	playsound SFX_STRENGTH
	earthquake 80
	end

TrainerScientistOskar:
	trainer EVENT_BEAT_SCIENTIST_OSKAR, SCIENTIST, OSKAR, ScientistOskarSeenText, ScientistOskarBeatenText, 0, ScientistOskarScript

ScientistOskarScript:
	end_if_just_battled
	opentext
	writetext ScientistOskarAfterText
	waitbutton
	closetext
	end

TrainerSuperNerdLuis:
	trainer EVENT_BEAT_SUPER_NERD_LUIS, SUPER_NERD, LUIS, SuperNerdLuisSeenText, SuperNerdLuisBeatenText, 0, SuperNerdLuisScript

SuperNerdLuisScript:
	end_if_just_battled
	opentext
	writetext SuperNerdLuisAfterText
	waitbutton
	closetext
	end

CinnabarVolcano1FBoulder:
	jumpstd strengthboulder

CinnabarVolcano1FRock:
	jumpstd smashrock

CinnabarVolcano1FHiddenFullRestore:
	dwb EVENT_CINNABAR_VOLCANO_1F_HIDDEN_FULL_RESTORE, FULL_RESTORE

ScientistOskarSeenText:
	text "I'm studying the"
	line "volcano to learn"
	cont "why it erupted."
	done

ScientistOskarBeatenText:
	text "Better luck next"
	line "time!"
	done

ScientistOskarAfterText:
	text "It's important to"
	line "study natural"
	cont "disasters so we"

	para "can prepare for"
	line "the next one."
	done

SuperNerdLuisSeenText:
	text "Did you know that"
	line "magma is only"

	para "called lava once"
	line "it reaches the"

	para "surface through"
	line "a volcano vent?"
	done

SuperNerdLuisBeatenText:
	text "You just taught"
	line "me…"
	done

SuperNerdLuisAfterText:
	text "It's so thrilling"
	line "to be inside a"
	cont "volcano!"

	para "But scary at the"
	line "same time."
	done

CinnabarVolcano1FBoulderFellText:
	text "The boulder fell"
	line "through!"
	done

CinnabarVolcano1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 9
	warp_def $19, $d, 2, CINNABAR_ISLAND
	warp_def $d, $5, 1, CINNABAR_VOLCANO_B1F
	warp_def $14, $e, 2, CINNABAR_VOLCANO_B1F
	warp_def $13, $19, 3, CINNABAR_VOLCANO_B1F
	warp_def $8, $16, 4, CINNABAR_VOLCANO_B1F
	warp_def $15, $8, 8, CINNABAR_VOLCANO_B1F
	warp_def $13, $14, 9, CINNABAR_VOLCANO_B1F
	warp_def $9, $12, 10, CINNABAR_VOLCANO_B1F
	warp_def $7, $a, 11, CINNABAR_VOLCANO_B1F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 15, SIGNPOST_ITEM, CinnabarVolcano1FHiddenFullRestore

.PersonEvents:
	db 14
	person_event SPRITE_SCIENTIST, 19, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerScientistOskar, -1
	person_event SPRITE_SUPER_NERD, 24, 17, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerSuperNerdLuis, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 16, 6, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FBoulder, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 22, 15, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FBoulder, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_2
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 4, 19, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FBoulder, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_3
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 4, 5, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FBoulder, EVENT_BOULDER_IN_CINNABAR_VOLCANO_1F_4
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 16, 23, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FBoulder, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 18, 5, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FRock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 21, 11, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FRock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 23, 35, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FRock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 11, 19, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FRock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 12, 25, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FRock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 2, 15, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FRock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 4, 8, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CinnabarVolcano1FRock, -1
