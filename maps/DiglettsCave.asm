const_value set 2
	const DIGLETTSCAVE_POKEFAN_M1
	const DIGLETTSCAVE_POKEFAN_M2
	const DIGLETTSCAVE_POKEFAN_M3
	const DIGLETTSCAVE_ENGINEER
	const DIGLETTSCAVE_POKEFAN_M4
	const DIGLETTSCAVE_COOLTRAINER_F
	const DIGLETTSCAVE_POKE_BALL1
	const DIGLETTSCAVE_POKE_BALL2

DiglettsCave_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerHikerGerard:
	trainer EVENT_BEAT_HIKER_GERARD, HIKER, GERARD, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Aah! I think that"
	line "rock just moved!"
	done

.BeatenText:
	text "Must have been"
	line "my imagination."
	done

.AfterText:
	text "This place makes"
	line "me so nervous."

	para "What if a Diglett"
	line "attacks me out of"
	cont "nowhere?"
	done

TrainerHikerDent:
	trainer EVENT_BEAT_HIKER_DENT, HIKER, DENT, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "I'm headed to"
	line "Pewter."

	para "Its Rock-type Gym"
	line "is perfect for a"
	cont "buff guy like me!"
	done

.BeatenText:
	text "Hohoh!"
	line "Someone more buff"
	cont "than me!"
	done

.AfterText:
	text "I'll fit right in"
	line "with Pewter Gym's"
	cont "buff crew. Hohoh!"
	done

TrainerBlackbeltInigo:
	trainer EVENT_BEAT_BLACKBELT_INIGO, BLACKBELT_T, INIGO, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Prepare for"
	line "battle!"
	cont "HOO-HAH!"
	done

.BeatenText:
	text "HIIYAAAH!"
	done

.AfterText:
	text "Making noises won't"
	line "make you a better"
	cont "fighter, but it"

	para "can intimidate"
	line "your foes."
	done

TrainerEngineerSmith:
	trainer EVENT_BEAT_ENGINEER_SMITH, ENGINEER, SMITH, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "How did Diglett"
	line "create such a long"
	cont "tunnel?"
	done

.BeatenText:
	text "Amazing!"
	done

.AfterText:
	text "Those Diglett are"
	line "just natural"
	cont "engineers."
	done

DiglettsCaveCooltrainerfScript:
	jumptextfaceplayer .Text

.Text:
	text "Look at all these"
	line "cute Diglett!"

	para "I swear I saw one"
	line "with a blue nose!"
	done

PokefanMScript_0x74002:
	jumptextfaceplayer .Text

.Text:
if DEF(FAITHFUL)
	text "A bunch of Diglett"
	line "popped out of the"

	para "ground! That was"
	line "shocking."
else
	text "When the volcano"
	line "on Cinnabar Island"
	cont "erupted, it radic-"

	para "ally affected some"
	line "#mon species."

	para "Diglett and Dug-"
	line "trio burrowing"
	cont "underground got"

	para "covered in strands"
	line "of cooled lava,"

	para "blown here all the"
	line "way from Cinnabar."

	para "It's made them even"
	line "tougher. Good luck"
	cont "in the caves!"
endc
	done

DiglettsCaveRareBone:
	itemball RARE_BONE

DiglettsCaveDiglettDoll:
	disappear DIGLETTSCAVE_POKE_BALL2
	setevent EVENT_DECO_DIGLETT_DOLL
	opentext
	writetext .FoundText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext .SentText
	waitbutton
	closetext
	end

.FoundText:
	text "<PLAYER> found"
	line "Diglett Doll."
	done

.SentText:
	text "Diglett Doll"
	line "was sent home."
	done

DiglettsCaveHiddenMaxRevive:
	dwb EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REVIVE, MAX_REVIVE

DiglettsCaveHiddenMaxRepel:
	dwb EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REPEL, MAX_REPEL

DiglettsCave_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $f, $25, 10, VERMILION_CITY
	warp_def $d, $27, 5, DIGLETTS_CAVE
	warp_def $5, $25, 4, ROUTE_2_NORTH
	warp_def $3, $27, 6, DIGLETTS_CAVE
	warp_def $1f, $25, 2, DIGLETTS_CAVE
	warp_def $5, $5, 4, DIGLETTS_CAVE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 15, 8, SIGNPOST_ITEM, DiglettsCaveHiddenMaxRevive
	signpost 8, 7, SIGNPOST_ITEM, DiglettsCaveHiddenMaxRepel

.PersonEvents:
	db 8
	person_event SPRITE_POKEFAN_M, 13, 5, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerHikerGerard, -1
	person_event SPRITE_POKEFAN_M, 31, 25, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerHikerDent, -1
	person_event SPRITE_BLACK_BELT, 21, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerBlackbeltInigo, -1
	person_event SPRITE_ENGINEER, 20, 9, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerEngineerSmith, -1
	person_event SPRITE_POKEFAN_M, 13, 37, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x74002, -1
	person_event SPRITE_COOLTRAINER_F, 27, 20, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, DiglettsCaveCooltrainerfScript, -1
	person_event SPRITE_BALL_CUT_FRUIT, 28, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, DiglettsCaveRareBone, EVENT_DIGLETTS_CAVE_RARE_BONE
	person_event SPRITE_BALL_CUT_FRUIT, 8, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, DiglettsCaveDiglettDoll, EVENT_DECO_DIGLETT_DOLL
