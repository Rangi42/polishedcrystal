BlackthornGym2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_CMDQUEUE, BlackthornGym2FBoulders

BlackthornGym2F_MapEventHeader:

.Warps: db 5
	warp_def 7, 1, 3, BLACKTHORN_GYM_1F
	warp_def 9, 7, 4, BLACKTHORN_GYM_1F
	warp_def 5, 2, 5, BLACKTHORN_GYM_1F ; hole
	warp_def 7, 8, 6, BLACKTHORN_GYM_1F ; hole
	warp_def 3, 8, 7, BLACKTHORN_GYM_1F ; hole

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 8
	strengthboulder_event 2, 8, EVENT_BOULDER_IN_BLACKTHORN_GYM_1
	strengthboulder_event 3, 2, EVENT_BOULDER_IN_BLACKTHORN_GYM_2
	strengthboulder_event 16, 6, EVENT_BOULDER_IN_BLACKTHORN_GYM_3
	strengthboulder_event 3, 3
	strengthboulder_event 1, 6
	strengthboulder_event 14, 8
	person_event SPRITE_COOLTRAINER_M, 1, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainermCody, -1
	person_event SPRITE_COOLTRAINER_F, 11, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainerfFran, -1

const_value set 1
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
	generictrainer EVENT_BEAT_COOLTRAINERM_CODY, COOLTRAINERM, CODY, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_COOLTRAINERF_FRAN, COOLTRAINERF, FRAN, .SeenText, .BeatenText

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
