const_value set 2
	const VIRIDIANGYM_BLUE
	const VIRIDIANGYM_GYM_GUY

ViridianGym_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

BlueScript_0x9aa26:
	faceplayer
	opentext
	checkflag ENGINE_EARTHBADGE
	iftrue .FightDone
	writetext LeaderBlueBeforeText
	waitbutton
	closetext
	winlosstext LeaderBlueWinText, 0
	loadtrainer BLUE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BLUE
	opentext
	writetext Text_ReceivedEarthBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_EARTHBADGE
.FightDone:
	checkevent EVENT_GOT_TM41_STONE_EDGE
	iftrue BlueEpilogueScript
	writetext LeaderBlueAfterText
	buttonsound
	verbosegiveitem TM_STONE_EDGE
	iffalse BlueCannotGiveTMScript
	setevent EVENT_GOT_TM41_STONE_EDGE
	writetext BlueOutroText
	waitbutton
	closetext
	end

BlueEpilogueScript:
	writetext LeaderBlueEpilogueText
	waitbutton
BlueCannotGiveTMScript:
	closetext
	end

ViridianGymGuyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BLUE
	iftrue .ViridianGymGuyWinScript
	writetext ViridianGymGuyText
	waitbutton
	closetext
	end

.ViridianGymGuyWinScript:
	writetext ViridianGymGuyWinText
	waitbutton
	closetext
	end

ViridianGymStatue:
	checkflag ENGINE_EARTHBADGE
	iftrue .Beaten
	jumpstd gymstatue1

.Beaten:
	trainertotext BLUE, 1, $1
	jumpstd gymstatue2

LeaderBlueBeforeText:
	text "Blue: Yo! Finally"
	line "got here, huh?"

	para "I wasn't in the"
	line "mood at Cinnabar,"

	para "but now I'm ready"
	line "to battle you."

	para "…"

	para "You're telling me"
	line "you conquered all"
	cont "the Gyms in Johto?"

	para "Heh! Johto's Gyms"
	line "must be pretty"
	cont "pathetic then."

	para "Hey, don't worry"
	line "about it."

	para "I'll know if you"
	line "are good or not by"

	para "battling you right"
	line "now."

	para "Ready, Johto"
	line "Champ?"
	done

LeaderBlueWinText:
	text "Blue: What?"

	para "How the heck did I"
	line "lose to you?"

	para "…"

	para "Tch, all right…"
	line "Here, take this--"

	para "it's the Earth"
	line "Badge."
	done

Text_ReceivedEarthBadge:
	text "<PLAYER> received"
	line "the Earth Badge."
	done

LeaderBlueAfterText:
	text "Blue: Here! Take"
	line "this as well!"
	done

BlueOutroText:
	text "It contains Stone"
	line "Edge. It's not only"

	para "for Rock-type"
	line "#mon, got it?"

	para "…"

	para "All right, I was"
	line "wrong. You're the"

	para "real deal. You are"
	line "a good trainer."

	para "But I'm going to"
	line "beat you someday."

	para "Don't you forget"
	line "it!"

	para "I train at the"
	line "Fighting Dojo in"

	para "Saffron City on"
	line "Mondays."

	para "All of the Gym"
	line "Leaders show up"
	cont "there sometimes."

	para "Meet me there and"
	line "I'll show you my"
	cont "real power!"

	para "Or you can always"
	line "rematch the Elite"
	cont "Four."

	para "With badges from"
	line "two regions,"

	para "they'll show you"
	line "no mercy."
	done

LeaderBlueEpilogueText:
	text "Blue: Listen, you."

	para "You'd better not"
	line "lose until I beat"
	cont "you. Got it?"
	done

ViridianGymGuyText:
	text "Yo, Champ in"
	line "making!"

	para "How's it going?"
	line "Looks like you're"
	cont "on a roll."

	para "The Gym Leader is"
	line "a guy who battled"

	para "the Champion three"
	line "years ago."

	para "He's no pushover."

	para "Give it everything"
	line "you've got!"
	done

ViridianGymGuyWinText:
	text "Man, you are truly"
	line "tough…"

	para "That was a heck of"
	line "an inspirational"

	para "battle. It brought"
	line "tears to my eyes."
	done

ViridianGym_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $2d, $6, 1, VIRIDIAN_CITY
	warp_def $2d, $7, 1, VIRIDIAN_CITY

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 43, 4, SIGNPOST_READ, ViridianGymStatue
	signpost 43, 9, SIGNPOST_READ, ViridianGymStatue

.PersonEvents:
	db 2
	person_event SPRITE_BLUE, 2, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BlueScript_0x9aa26, EVENT_VIRIDIAN_GYM_BLUE
	person_event SPRITE_GYM_GUY, 43, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ViridianGymGuyScript, EVENT_VIRIDIAN_GYM_BLUE
