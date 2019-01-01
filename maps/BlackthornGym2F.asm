BlackthornGym2F_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_CMDQUEUE, BlackthornGym2FBoulders

	db 5 ; warp events
	warp_event  1,  7, BLACKTHORN_GYM_1F, 3
	warp_event  7,  9, BLACKTHORN_GYM_1F, 4
	warp_event  2,  5, BLACKTHORN_GYM_1F, 5 ; hole
	warp_event  8,  7, BLACKTHORN_GYM_1F, 6 ; hole
	warp_event  8,  3, BLACKTHORN_GYM_1F, 7 ; hole

	db 0 ; coord events

	db 0 ; bg events

	db 8 ; object events
	strengthboulder_event  8,  2, EVENT_BOULDER_IN_BLACKTHORN_GYM_1
	strengthboulder_event  2,  3, EVENT_BOULDER_IN_BLACKTHORN_GYM_2
	strengthboulder_event  6, 16, EVENT_BOULDER_IN_BLACKTHORN_GYM_3
	strengthboulder_event  3, 3
	strengthboulder_event  6, 1
	strengthboulder_event  8, 14
	object_event  4,  1, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainermCody, -1
	object_event  4, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainerfFran, -1

	const_def 1 ; object constants
	const BLACKTHORNGYM2F_BOULDER1
	const BLACKTHORNGYM2F_BOULDER2
	const BLACKTHORNGYM2F_BOULDER3

BlackthornGym2FBoulders:
	writecmdqueue .BoulderCmdQueue
	return

.BoulderCmdQueue:
	dbw CMDQUEUE_STONETABLE, .BoulderTable ; check if any stones are sitting on a warp
	dw 0 ; filler

.BoulderTable:
	stonetable 5, BLACKTHORNGYM2F_BOULDER1, .Disappear4
	stonetable 3, BLACKTHORNGYM2F_BOULDER2, .Disappear5
	stonetable 4, BLACKTHORNGYM2F_BOULDER3, .Disappear6
	db -1 ; end

.Disappear4:
	disappear BLACKTHORNGYM2F_BOULDER1
	jump .Fall

.Disappear5:
	disappear BLACKTHORNGYM2F_BOULDER2
	jump .Fall

.Disappear6:
	disappear BLACKTHORNGYM2F_BOULDER3
.Fall:
	pause 30
	playsound SFX_STRENGTH
	earthquake 80
	thistext

	text "The boulder fell"
	line "through!"
	done

GenericTrainerCooltrainermCody:
	generictrainer COOLTRAINERM, CODY, EVENT_BEAT_COOLTRAINERM_CODY, .SeenText, .BeatenText

	text "Members of our"
	line "dragon-user clan"

	para "can use dragon"
	line "#mon only after"

	para "our Master allows"
	line "it."
	done

.SeenText:
	text "It's not as if we"
	line "all use Dragon-"
	cont "type #mon."
	done

.BeatenText:
	text "Rats! If only I"
	line "had a dragon!"
	done

GenericTrainerCooltrainerfFran:
	generictrainer COOLTRAINERF, FRAN, EVENT_BEAT_COOLTRAINERF_FRAN, .SeenText, .BeatenText

	text "Uh-oh… Clair is"
	line "going to be mad…"
	done

.SeenText:
	text "I can't allow a"
	line "nameless trainer"
	cont "past me!"

	para "Clair would be"
	line "livid if I did!"
	done

.BeatenText:
	text "Awww… I lost…"
	done
