OlsteetonUniGymDept_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6, 13, OLSTEETON_UNI, 16
	warp_event  7, 13, OLSTEETON_UNI, 16

	def_coord_events

	def_bg_events
	bg_event  9, 13, BGEVENT_READ, OlsteetonGymDeptStatue
	bg_event  4, 13, BGEVENT_READ, OlsteetonGymDeptStatue

	def_object_events
	; object_event  0,  3, SPRITE_WILL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonGymDeptBrockScript, -1
	; object_event  2,  7, SPRITE_WHITNEY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCamperJerry, -1
	; object_event  7,  7, SPRITE_FLANNERY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHikerEdwin, -1
	; object_event 15,  7, SPRITE_ANABEL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTowerOutsideAnabelScript, -1
	object_event  5, 12, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 1, OlsteetonGymDeptGuyScript, -1

; OlsteetonGymDeptBrockScript:
; 	faceplayer
; 	opentext
; 	; checkflag ENGINE_BOULDERBADGE
; 	; iftruefwd .FightDone
; 	writetext BrockIntroText
; 	waitbutton
; 	closetext
; ; 	winlosstext BrockWinLossText, 0
; ; 	loadtrainer BROCK, 1
; ; 	startbattle
; ; 	reloadmapafterbattle
; ; 	setevent EVENT_BEAT_BROCK
; ; 	setevent EVENT_BEAT_CAMPER_JERRY
; ; 	setevent EVENT_BEAT_HIKER_EDWIN
; ; 	opentext
; ; 	givebadge BOULDERBADGE, KANTO_REGION
; ; 	callstd kantopostgymevents
; ; .FightDone:
; ; 	checkevent EVENT_GOT_TM48_ROCK_SLIDE
; ; 	iftrue_jumpopenedtext BrockFightDoneText
; ; 	writetext BrockBoulderBadgeText
; ; 	promptbutton
; ; 	verbosegivetmhm TM_ROCK_SLIDE
; ; 	setevent EVENT_GOT_TM48_ROCK_SLIDE
; ; 	jumpthisopenedtext

; ; 	text "It can sometimes"
; ; 	line "cause your foe to"
; ; 	cont "flinch."
; 	done

; GenericTrainerCamperJerry:
; 	generictrainer CAMPER, JERRY, EVENT_BEAT_CAMPER_JERRY, CamperJerrySeenText, CamperJerryBeatenText

; 	text "Hey, you! Trainer"
; 	line "from Johto! Brock"

; 	para "is tough. He'll"
; 	line "punish you if you"

; 	para "don't take him"
; 	line "seriously."
; 	done

; GenericTrainerHikerEdwin:
; 	generictrainer HIKER, EDWIN, EVENT_BEAT_HIKER_EDWIN, HikerEdwinSeenText, HikerEdwinBeatenText

; 	text "Phew… Broken"
; 	line "in pieces."
; 	done

OlsteetonGymDeptGuyScript:
	; checkevent EVENT_BEAT_BROCK
	; iftrue_jumptextfaceplayer OlsteetonGymDeptGuyWinText
	jumptextfaceplayer OlsteetonGymDeptGuyText

OlsteetonGymDeptStatue:
	gettrainername BROCK, 1, STRING_BUFFER_4
	checkflag ENGINE_BOULDERBADGE
	iftruefwd .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

; BrockIntroText:
; 	text "Brock: Wow, it's"
; 	line "not often that we"

; 	para "get a challenger"
; 	line "from Johto."

; 	para "I'm Brock, the"
; 	line "Pewter Gym Leader."

; 	para "I'm an expert on"
; 	line "Rock-type #mon."

; 	para "My #mon are im-"
; 	line "pervious to most"

; 	para "physical attacks."
; 	line "You'll have a hard"

; 	para "time inflicting"
; 	line "any damage."

; 	para "Come on!"
; 	done

; BrockWinLossText:
; 	text "Brock: Your #-"
; 	line "mon's powerful at-"
; 	cont "tacks overcame my"
; 	cont "rock-hard defense…"

; 	para "You're stronger"
; 	line "than I expected…"

; 	para "Go ahead--take"
; 	line "this Badge."
; 	done

; BrockBoulderBadgeText:
; 	text "Brock: <PLAYER>,"
; 	line "thanks. I enjoyed"

; 	para "battling you, even"
; 	line "though I am a bit"
; 	cont "upset."

; 	para "I'll give you the"
; 	line "TM for Rock Slide,"
; 	cont "too."
; 	done

; BrockFightDoneText:
; 	text "Brock: The world"
; 	line "is huge. There are"

; 	para "still many strong"
; 	line "trainers like you."

; 	para "Just wait and see."
; 	line "I'm going to be-"
; 	cont "come a lot strong-"
; 	cont "er too."
; 	done

; CamperJerrySeenText:
; 	text "The trainers of"
; 	line "this Gym use Rock-"
; 	cont "type #mon."

; 	para "The Rock-type has"
; 	line "high Defense."

; 	para "Battles could end"
; 	line "up going a long"

; 	para "time. Are you"
; 	line "ready for this?"
; 	done

; CamperJerryBeatenText:
; 	text "I have to win"
; 	line "these battles…"
; 	done

; HikerEdwinSeenText: ; text > text
; 	text "R-r-r-R-R--CRASH!"
; 	done

; HikerEdwinBeatenText: ; text > text
; 	text "BOOM!"
; 	done

OlsteetonGymDeptGuyText:
	text "Yo! Champ in"
	line "making! You're"

	para "interested in."
	line "enrolling in"

	para "the Gym Leader"
	line "Training Program?"
	done

OlsteetonGymDeptGuyWinText:
	text "Yo! Champ in"
	line "making! That Gym"

	para "didn't give you"
	line "much trouble."

	para "The way you took"
	line "charge was really"

	para "inspiring. I mean"
	line "that seriously."
	done
