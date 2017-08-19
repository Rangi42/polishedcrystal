PewterGym_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

PewterGym_MapEventHeader:

.Warps: db 2
	warp_def 13, 4, 2, PEWTER_CITY
	warp_def 13, 5, 2, PEWTER_CITY

.XYTriggers: db 0

.Signposts: db 2
	signpost 11, 2, SIGNPOST_READ, PewterGymStatue
	signpost 11, 7, SIGNPOST_READ, PewterGymStatue

.PersonEvents: db 4
	person_event SPRITE_BROCK, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BrockScript_0x1a2864, -1
	person_event SPRITE_YOUNGSTER, 7, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerCamperJerry, -1
	person_event SPRITE_POKEFAN_M, 5, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerEdwin, -1
	person_event SPRITE_GYM_GUY, 11, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 1, PewterGymGuyScript, -1

BrockScript_0x1a2864:
	faceplayer
	opentext
	checkflag ENGINE_BOULDERBADGE
	iftrue .FightDone
	writetext UnknownText_0x1a28d0
	waitbutton
	closetext
	winlosstext UnknownText_0x1a29bb, 0
	loadtrainer BROCK, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BROCK
	setevent EVENT_BEAT_CAMPER_JERRY
	setevent EVENT_BEAT_HIKER_EDWIN
	opentext
	writetext UnknownText_0x1a2a3d
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_BOULDERBADGE
	checkcode VAR_BADGES
	if_equal 9, .FirstBadge
	if_equal 10, .SecondBadge
	if_equal 12, .LyrasEgg
	jump .FightDone
.FirstBadge:
	specialphonecall SPECIALCALL_FIRSTBADGE
	jump .FightDone
.SecondBadge:
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	iftrue .FightDone
	specialphonecall SPECIALCALL_SECONDBADGE
	jump .FightDone
.LyrasEgg:
	specialphonecall SPECIALCALL_LYRASEGG
.FightDone:
	checkevent EVENT_GOT_TM48_ROCK_SLIDE
	iftrue BrockAfterTMScript
	writetext UnknownText_0x1a2a57
	buttonsound
	verbosegivetmhm TM_ROCK_SLIDE
	setevent EVENT_GOT_TM48_ROCK_SLIDE
	jumpopenedtext BrockOutroText

BrockAfterTMScript:
	jumpopenedtext UnknownText_0x1a2ada

TrainerCamperJerry:
	trainer EVENT_BEAT_CAMPER_JERRY, CAMPER, JERRY, CamperJerrySeenText, CamperJerryBeatenText, 0, CamperJerryScript

CamperJerryScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a2c0f

TrainerHikerEdwin:
	trainer EVENT_BEAT_HIKER_EDWIN, HIKER, EDWIN, HikerEdwinSeenText, HikerEdwinBeatenText, 0, HikerEdwinScript

HikerEdwinScript:
	end_if_just_battled
	jumptextfaceplayer HikerEdwinAfterText

PewterGymGuyScript:
	checkevent EVENT_BEAT_BROCK
	iftrue_jumptextfaceplayer PewterGymGuyWinText
	jumptextfaceplayer PewterGymGuyText

PewterGymStatue:
	trainertotext BROCK, 1, $1
	checkflag ENGINE_BOULDERBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

UnknownText_0x1a28d0:
	text "Brock: Wow, it's"
	line "not often that we"

	para "get a challenger"
	line "from Johto."

	para "I'm Brock, the"
	line "Pewter Gym Leader."

	para "I'm an expert on"
	line "Rock-type #mon."

	para "My #mon are im-"
	line "pervious to most"

	para "physical attacks."
	line "You'll have a hard"

	para "time inflicting"
	line "any damage."

	para "Come on!"
	done

UnknownText_0x1a29bb:
	text "Brock: Your #-"
	line "mon's powerful at-"
	cont "tacks overcame my"
	cont "rock-hard defense…"

	para "You're stronger"
	line "than I expected…"

	para "Go ahead--take"
	line "this Badge."
	done

UnknownText_0x1a2a3d:
	text "<PLAYER> received"
	line "the Boulder Badge."
	done

UnknownText_0x1a2a57:
	text "Brock: <PLAYER>,"
	line "thanks. I enjoyed"

	para "battling you, even"
	line "though I am a bit"
	cont "upset."

	para "I'll give you the"
	line "TM for Rock Slide,"
	cont "too."
	done

BrockOutroText:
	text "It can sometimes"
	line "cause your foe to"
	cont "flinch."
	done

UnknownText_0x1a2ada:
	text "Brock: The world"
	line "is huge. There are"

	para "still many strong"
	line "trainers like you."

	para "Just wait and see."
	line "I'm going to be-"
	cont "come a lot strong-"
	cont "er too."
	done

CamperJerrySeenText:
	text "The trainers of"
	line "this Gym use Rock-"
	cont "type #mon."

	para "The Rock-type has"
	line "high Defense."

	para "Battles could end"
	line "up going a long"

	para "time. Are you"
	line "ready for this?"
	done

CamperJerryBeatenText:
	text "I have to win"
	line "these battles…"
	done

UnknownText_0x1a2c0f:
	text "Hey, you! Trainer"
	line "from Johto! Brock"

	para "is tough. He'll"
	line "punish you if you"

	para "don't take him"
	line "seriously."
	done

HikerEdwinSeenText:
	text "R-r-r-R-R--CRASH!"
	done

HikerEdwinBeatenText:
	text "BOOM!"
	done

HikerEdwinAfterText:
	text "Phew… Broken"
	line "in pieces."
	done

PewterGymGuyText:
	text "Yo! Champ in"
	line "making! You're"

	para "really rocking."
	line "Are you battling"

	para "the Gym Leaders of"
	line "Kanto?"

	para "They're strong and"
	line "dedicated people,"

	para "just like Johto's"
	line "Gym Leaders."
	done

PewterGymGuyWinText:
	text "Yo! Champ in"
	line "making! That Gym"

	para "didn't give you"
	line "much trouble."

	para "The way you took"
	line "charge was really"

	para "inspiring. I mean"
	line "that seriously."
	done
