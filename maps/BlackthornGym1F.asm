const_value set 2
	const BLACKTHORNGYM1F_CLAIR
	const BLACKTHORNGYM1F_COOLTRAINER_M
	const BLACKTHORNGYM1F_DRAGON_TAMER
	const BLACKTHORNGYM1F_COOLTRAINER_F
	const BLACKTHORNGYM1F_GYM_GUY

BlackthornGym1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_TILES, .Boulders

.Boulders:
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_1
	iffalse .skip1
	changeblock $8, $2, $3b
.skip1
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_2
	iffalse .skip2
	changeblock $2, $4, $3a
.skip2
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_3
	iffalse .skip3
	changeblock $8, $6, $3b
.skip3
	return

BlackthornGymClairScript:
	faceplayer
	opentext
	checkflag ENGINE_RISINGBADGE
	iftrue .AlreadyGotBadge
	checkevent EVENT_BEAT_CLAIR
	iftrue .FightDone
	writetext ClairIntroText
	waitbutton
	closetext
	winlosstext ClairWinText, 0
	loadtrainer CLAIR, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CLAIR
	opentext
	writetext ClairText_GoToDragonsDen
	waitbutton
	closetext
	setevent EVENT_BEAT_DRAGON_TAMER_PAUL
	setevent EVENT_BEAT_COOLTRAINERM_CODY
	setevent EVENT_BEAT_COOLTRAINERM_MIKE
	setevent EVENT_BEAT_COOLTRAINERF_FRAN
	setevent EVENT_BEAT_COOLTRAINERF_LOLA
	clearevent EVENT_MAHOGANY_MART_OWNERS
	setevent EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	clearevent EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	end

.FightDone:
	writetext ClairText_TooMuchToExpect
	waitbutton
	closetext
	end

.AlreadyGotBadge:
	checkevent EVENT_GOT_TM21_DRAGONBREATH
	iftrue .GotTM21
	writetext BlackthornGymClairText_YouKeptMeWaiting
	buttonsound
	verbosegivetmhm TM_DRAGONBREATH
	setevent EVENT_GOT_TM21_DRAGONBREATH
	writetext BlackthornGymClairText_DescribeTM21
	buttonsound
.GotTM21:
	writetext BlackthornGymClairText_League
	waitbutton
	closetext
	end

TrainerDragonTamerPaul:
	trainer EVENT_BEAT_DRAGON_TAMER_PAUL, DRAGON_TAMER, PAUL, DragonTamerPaulSeenText, DragonTamerPaulBeatenText, 0, DragonTamerPaulScript

DragonTamerPaulScript:
	end_if_just_battled
	opentext
	writetext DragonTamerPaulAfterText
	waitbutton
	closetext
	end

TrainerCooltrainermMike:
	trainer EVENT_BEAT_COOLTRAINERM_MIKE, COOLTRAINERM, MIKE, CooltrainermMikeSeenText, CooltrainermMikeBeatenText, 0, CooltrainermMikeScript

CooltrainermMikeScript:
	end_if_just_battled
	opentext
	writetext CooltrainermMikeAfterText
	waitbutton
	closetext
	end

TrainerCooltrainerfLola:
	trainer EVENT_BEAT_COOLTRAINERF_LOLA, COOLTRAINERF, LOLA, CooltrainerfLolaSeenText, CooltrainerfLolaBeatenText, 0, CooltrainerfLolaScript

CooltrainerfLolaScript:
	end_if_just_battled
	opentext
	writetext CooltrainerfLolaAfterText
	waitbutton
	closetext
	end

BlackthornGymGuyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CLAIR
	iftrue .BlackthornGymGuyWinScript
	writetext BlackthornGymGuyText
	waitbutton
	closetext
	end

.BlackthornGymGuyWinScript:
	writetext BlackthornGymGuyWinText
	waitbutton
	closetext
	end

BlackthornGymStatue:
	checkflag ENGINE_RISINGBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	trainertotext CLAIR, 1, $1
	checkcode VAR_BADGES
	if_greater_than 15, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

ClairIntroText:
	text "I am Clair."

	para "The world's best"
	line "dragon master."

	para "I can hold my own"
	line "against even the"

	para "#mon League's"
	line "Elite Four."

	para "Do you still want"
	line "to take me on?"

	para "…Fine."
	line "Let's do it!"

	para "As a Gym Leader,"
	line "I will use my full"

	para "power against any"
	line "opponent!"
	done

ClairWinText:
	text "I lost?"

	para "I don't believe"
	line "it. There must be"
	cont "some mistake…"
	done

ClairText_GoToDragonsDen:
	text "I won't admit"
	line "this."

	para "I may have lost,"
	line "but you're still"

	para "not ready for the"
	line "#mon League."

	para "I know. You should"
	line "take the Dragon-"
	cont "master challenge."

	para "Behind this Gym is"
	line "a place called"
	cont "Dragon's Den."

	para "There is a small"
	line "shrine at its"

	para "center."
	line "Go there."

	para "If you can prove"
	line "that you've lost"

	para "your lazy ideals,"
	line "I will recognize"

	para "you as a trainer"
	line "worthy of a Gym"
	cont "Badge!"
	done

ClairText_TooMuchToExpect:
	text "What's the matter?"

	para "Is it too much to"
	line "expect of you?"
	done

BlackthornGymClairText_YouKeptMeWaiting:
	text "You've kept me"
	line "waiting!"

	para "Here! Take this!"
	done

BlackthornGymClairText_DescribeTM21:
	text "That contains"
	line "DragonBreath."

	para "No, it doesn't"
	line "have anything to"
	cont "do with my breath."

	para "If you don't want"
	line "it, you don't have"
	cont "to take it."
	done

BlackthornGymClairText_League:
	text "What's the matter?"

	para "Aren't you headed"
	line "to the #mon"
	cont "League?"

	para "Don't you know"
	line "where it is?"

	para "From here, go to"
	line "New Bark Town."

	para "Then Surf east."
	line "The route there is"
	cont "very tough."

	para "Don't you dare"
	line "lose at the #-"
	cont "mon League!"

	para "If you do, I'll"
	line "feel even worse"

	para "about having lost"
	line "to you!"

	para "Give it every-"
	line "thing you've got."
	done

DragonTamerPaulSeenText:
	text "Your first battle"
	line "against dragons?"

	para "I'll show you how"
	line "tough they are!"
	done

DragonTamerPaulBeatenText:
	text "My dragon #mon"
	line "lost?"
	done

DragonTamerPaulAfterText:
	text "Lance told you"
	line "that he'd like to"

	para "see you again?"
	line "Not a chance!"
	done

CooltrainermMikeSeenText:
	text "My chance of"
	line "losing? Not even"
	cont "one percent!"
	done

CooltrainermMikeBeatenText:
	text "That's odd."
	done

CooltrainermMikeAfterText:
	text "I know my short-"
	line "comings now."

	para "Thanks for showing"
	line "me!"
	done

CooltrainerfLolaSeenText:
	text "Dragons are sacred"
	line "#mon."

	para "They are full of"
	line "life energy."

	para "If you're not"
	line "serious, you won't"

	para "be able to beat"
	line "them."
	done

CooltrainerfLolaBeatenText:
	text "Way to go!"
	done

CooltrainerfLolaAfterText:
	text "Dragons are weak"
	line "against Dragon-"
	cont "type moves."
	done

BlackthornGymGuyText:
	text "Yo! Champ in"
	line "making!"

	para "It's been a long"
	line "journey, but we"

	para "are almost done!"
	line "Count on me!"

	para "Clair uses the"
	line "mythical and sac-"
	cont "red Dragon-type"
	cont "#mon."

	para "You can't damage"
	line "them very easily."

	para "But you know,"
	line "they're supposed"

	para "to be weak against"
	line "Ice-type moves."
	done

BlackthornGymGuyWinText:
	text "You were great to"
	line "beat Clair!"

	para "All that's left is"
	line "the #mon League"
	cont "challenge."

	para "You're on the way"
	line "to becoming the"
	cont "#mon Champion!"
	done

BlackthornGym1F_MapEventHeader:
.Warps:
	db 7
	warp_def $11, $4, 1, BLACKTHORN_CITY
	warp_def $11, $5, 1, BLACKTHORN_CITY
	warp_def $7, $1, 1, BLACKTHORN_GYM_2F
	warp_def $9, $7, 2, BLACKTHORN_GYM_2F
	warp_def $6, $2, 3, BLACKTHORN_GYM_2F
	warp_def $7, $7, 4, BLACKTHORN_GYM_2F
	warp_def $6, $7, 5, BLACKTHORN_GYM_2F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 15, 3, SIGNPOST_READ, BlackthornGymStatue
	signpost 15, 6, SIGNPOST_READ, BlackthornGymStatue

.PersonEvents:
	db 5
	person_event SPRITE_CLAIR, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BlackthornGymClairScript, -1
	person_event SPRITE_COOLTRAINER_M, 6, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCooltrainermMike, -1
	person_event SPRITE_DRAGON_TAMER, 14, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerDragonTamerPaul, -1
	person_event SPRITE_COOLTRAINER_F, 2, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainerfLola, -1
	person_event SPRITE_GYM_GUY, 15, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BlackthornGymGuyScript, -1
