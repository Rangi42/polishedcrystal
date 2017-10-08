DiglettsCave_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

DiglettsCave_MapEventHeader:

.Warps: db 6
	warp_def 15, 37, 10, VERMILION_CITY
	warp_def 13, 39, 5, DIGLETTS_CAVE
	warp_def 5, 37, 4, ROUTE_2_NORTH
	warp_def 3, 39, 6, DIGLETTS_CAVE
	warp_def 31, 37, 2, DIGLETTS_CAVE
	warp_def 5, 5, 4, DIGLETTS_CAVE

.XYTriggers: db 0

.Signposts: db 2
	signpost 15, 8, SIGNPOST_ITEM + MAX_REVIVE, EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REVIVE
	signpost 33, 34, SIGNPOST_ITEM + MAX_REPEL, EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REPEL

.PersonEvents: db 9
	person_event SPRITE_BALL_CUT_FRUIT, 8, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, DiglettsCaveDiglettDoll, EVENT_DECO_DIGLETT_DOLL
	person_event SPRITE_SUPER_NERD, 15, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, DiglettsCaveFossilManiacScript, -1
	person_event SPRITE_POKEFAN_M, 13, 5, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerHikerGerard, -1
	person_event SPRITE_POKEFAN_M, 31, 25, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerHikerDent, -1
	person_event SPRITE_BLACK_BELT, 21, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerBlackbeltInigo, -1
	person_event SPRITE_ENGINEER, 20, 9, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerEngineerSmith, -1
	person_event SPRITE_POKEFAN_M, 13, 37, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, PokefanMScript_0x74002Text, -1
	person_event SPRITE_COOLTRAINER_F, 27, 20, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, DiglettsCaveCooltrainerfText, -1
	itemball_event 28, 13, RARE_BONE, 1, EVENT_DIGLETTS_CAVE_RARE_BONE

const_value set 1
	const DIGLETTSCAVE_POKE_BALL2

DiglettsCaveFossilManiacScript:
	faceplayer
	opentext
	writetext .GreetingText
	buttonsound
	special Special_ChooseItem
	iffalse .NoItem
	special GetFossilManiacPrice
	iffalse .WrongItem
	writetext .OfferText
	special PlaceMoneyTopRight
	yesorno
	iffalse .NoItem
	copybytetovar CurItem
	takeitem ITEM_FROM_MEM
	waitsfx
	playsound SFX_TRANSACTION
	special Give_hMoneyTemp
	special PlaceMoneyTopRight
	jumpopenedtext .ThankYouText

.NoItem:
	jumpopenedtext .NoItemText

.WrongItem:
	jumpopenedtext .WrongItemText

.GreetingText:
	text "Hey, check it out."
	line "I've got a sweet"
	cont "deal for ya!"

	para "You know how #-"
	line "mon fossils turn"
	cont "up in rocks?"

	para "If you find one,"
	line "bring it to me."

	para "I'll make it worth"
	line "your while."
	done

.OfferText:
	text "Hey, nice! Let me"
	line "check that out."

	para "I'll give you"
	line "¥@"
	deciram hMoneyTemp, 3, 7
	text " for it."
	cont "Whaddaya say?"
	done

.ThankYouText:
	text "Hey, thanks!"

	para "I bet I can sell"
	line "this for way more"
	cont "than I just gave"
	cont "you. Ha!"

	para "That's business"
	line "for ya!"
	done

.WrongItemText:
	text "Nope, this is no"
	line "good. Not worth"
	cont "my while."
	done

.NoItemText:
	text "…Nope, nothing"
	line "cool in your Bag."

	para "Oh well. Maybe"
	line "next time!"
	done

TrainerHikerGerard:
	trainer EVENT_BEAT_HIKER_GERARD, HIKER, GERARD, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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
	jumptextfaceplayer .AfterText

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
	jumptextfaceplayer .AfterText

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
	jumptextfaceplayer .AfterText

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

DiglettsCaveCooltrainerfText:
	text "Look at all these"
	line "cute Diglett!"

	para "I swear I saw one"
	line "with a blue nose!"
	done

PokefanMScript_0x74002Text:
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

DiglettsCaveDiglettDoll:
	disappear DIGLETTSCAVE_POKE_BALL2
	setevent EVENT_DECO_DIGLETT_DOLL
	opentext
	writetext .FoundText
	playsound SFX_ITEM
	pause 60
	waitbutton
	jumpopenedtext .SentText

.FoundText:
	text "<PLAYER> found"
	line "Diglett Doll."
	done

.SentText:
	text "Diglett Doll"
	line "was sent home."
	done
