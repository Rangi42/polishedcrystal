const_value set 2
	const GIOVANNISCAVE_CELEBI
	const GIOVANNISCAVE_LYRA
	const GIOVANNISCAVE_GIOVANNI
	const GIOVANNISCAVE_ROCK1
	const GIOVANNISCAVE_ROCK2

GiovannisCave_MapScriptHeader:
.MapTriggers:
	db 1

	; triggers
	maptrigger .Trigger0

.MapCallbacks:
	db 0

.Trigger0:
	priorityjump GiovannisCaveCelebiEventScript
	end

GiovannisCaveCelebiEventScript:
	pause 30
	spriteface PLAYER, UP
	spriteface GIOVANNISCAVE_LYRA, UP
	showemote EMOTE_SHOCK, GIOVANNISCAVE_GIOVANNI, 15
	spriteface GIOVANNISCAVE_GIOVANNI, DOWN
	opentext
	writetext GiovannisCaveGiovanniIntroText
	waitbutton
	closetext
	applymovement GIOVANNISCAVE_GIOVANNI, GiovannisCave_GiovanniStepsDownMovementData
	opentext
	writetext GiovannisCaveGiovanniMemoriesText
	waitbutton
	closetext
	spriteface GIOVANNISCAVE_LYRA, RIGHT
	opentext
	writetext GiovannisCaveLyraQuestionsText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, GIOVANNISCAVE_LYRA, 15
	opentext
	writetext GiovannisCaveLyraRecognizesGiovanniText
	waitbutton
	closetext
	spriteface GIOVANNISCAVE_LYRA, UP
	spriteface GIOVANNISCAVE_GIOVANNI, UP
	opentext
	writetext GiovannisCaveRadioText
	waitbutton
	closetext
	spriteface GIOVANNISCAVE_GIOVANNI, DOWN
	opentext
	writetext GiovannisCaveGiovanniIMustGoText
	waitbutton
	closetext
	winlosstext GiovannisCaveGiovanniBeatenText, 0
	setlasttalked GIOVANNISCAVE_GIOVANNI
	loadtrainer GIOVANNI, 1
	startbattle
;	dontrestartmapmusic
	reloadmapafterbattle
	end

GiovannisCave_GiovanniStepsDownMovementData:
	slow_step_down
	step_end

GiovannisCaveGiovanniIntroText:
	text "…"

	para "I don't know why"
	line "you came here,"

	para "but I have to warn"
	line "you that this is"
	cont "no place for kids"
	cont "like you."

	para "Lyra: Huh? That's"
	line "the guy we just"

	para "saw arguing with"
	line "that boy!"
	done

GiovannisCaveGiovanniMemoriesText:
	text "You have a certain"
	line "look…"

	para "I remember you!"

	para "That kid three"
	line "years ago kept"
	cont "ruining our plans,"

	para "but you caused all"
	line "our problems in"
	cont "the first place!"

	para "…"

	para "I'm on my way to"
	line "Goldenrod City to"

	para "answer the call"
	line "and join my team."

	para "Are you going to"
	line "get in my way"
	cont "again?"
	done

GiovannisCaveLyraQuestionsText:
	text "Lyra: Three years"
	line "ago…? Goldenrod"
	cont "City…?"
	done

GiovannisCaveLyraRecognizesGiovanniText:
	text "This is who Team"
	line "Rocket was trying"
	cont "to reach!"

	para "Their boss,"
	line "Giovanni!"

	para "<PLAYER>, when did"
	line "you meet Giovanni"
	cont "before…?"
	done

GiovannisCaveRadioText:
	text "<``>… …Ahem, we are"
	line "Team Rocket!"
	cont "After three years"
	cont "of preparation, we"
	cont "have risen again"
	cont "from the ashes!"
	cont "Giovanni! Can you"
	cont "hear? We did it!"
	cont "Where is our boss?"
	cont "Is he listening?<''>"

	para "Lyra: Team Rocket"
	line "has occupied the"

	para "Radio Tower right"
	line "now…"

	para "You're there, and"
	line "you're also here…"
	done

GiovannisCaveGiovanniIMustGoText:
	text "Giovanni: My old"
	line "associates need"
	cont "me…"

	para "We will not repeat"
	line "the failure of"
	cont "three years ago!"

	para "Team Rocket will"
	line "be born again!"

	para "Lyra: Hah!"
	line "<PLAYER> already"
	cont "stopped you!"
	cont "…Will stop you."

	para "Will have stopped"
	line "you…?"

	para "…Traveling through"
	line "time is confusing!"

	para "Giovanni: Enough"
	line "chatter! Get out"
	cont "of my way!"
	done

GiovannisCaveGiovanniBeatenText:
	text "Giovanni: How is"
	line "this possible…?"

	para "The past three"
	line "years have been"
	cont "a waste…?"

	para "How can a kid like"
	line "you manage to"

	para "destroy my dream"
	line "once again?"
	done

GiovannisCave_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_CELEBI, 6, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_LYRA, 5, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_GIOVANNI, 3, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_ROCK, 6, 3, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_ROCK, 2, 6, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
