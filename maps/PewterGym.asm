PewterGym_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  4, 13, PEWTER_CITY, 2
	warp_event  5, 13, PEWTER_CITY, 2

	db 0 ; coord events

	db 2 ; bg events
	bg_event  2, 11, SIGNPOST_READ, PewterGymStatue
	bg_event  7, 11, SIGNPOST_READ, PewterGymStatue

	db 4 ; object events
	object_event  5,  1, SPRITE_BROCK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, BrockScript_0x1a2864, -1
	object_event  2,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerCamperJerry, -1
	object_event  7,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerHikerEdwin, -1
	object_event  6, 11, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 1, PewterGymGuyScript, -1

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
	ifequal 9, .FirstBadge
	ifequal 10, .SecondBadge
	ifequal 12, .LyrasEgg
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
	iftrue_jumpopenedtext UnknownText_0x1a2ada
	writetext UnknownText_0x1a2a57
	buttonsound
	verbosegivetmhm TM_ROCK_SLIDE
	setevent EVENT_GOT_TM48_ROCK_SLIDE
	thisopenedtext

	text "It can sometimes"
	line "cause your foe to"
	cont "flinch."
	done

GenericTrainerCamperJerry:
	generictrainer CAMPER, JERRY, EVENT_BEAT_CAMPER_JERRY, CamperJerrySeenText, CamperJerryBeatenText

	text "Hey, you! Trainer"
	line "from Johto! Brock"

	para "is tough. He'll"
	line "punish you if you"

	para "don't take him"
	line "seriously."
	done

GenericTrainerHikerEdwin:
	generictrainer HIKER, EDWIN, EVENT_BEAT_HIKER_EDWIN, HikerEdwinSeenText, HikerEdwinBeatenText

	text "Phew… Broken"
	line "in pieces."
	done

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

HikerEdwinSeenText:
	text "R-r-r-R-R--CRASH!"
	done

HikerEdwinBeatenText:
	text "BOOM!"
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
