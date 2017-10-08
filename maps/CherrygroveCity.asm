CherrygroveCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 2
	dbw MAPCALLBACK_NEWMAP, CherrygroveCityFlyPoint
	dbw MAPCALLBACK_SPRITES, CherrygroveCitySwimmerGuySprite

CherrygroveCity_MapEventHeader:

.Warps: db 5
	warp_def 3, 23, 2, CHERRYGROVE_MART
	warp_def 3, 29, 1, CHERRYGROVE_POKECENTER_1F
	warp_def 7, 17, 1, CHERRYGROVE_GYM_SPEECH_HOUSE
	warp_def 9, 25, 1, GUIDE_GENTS_HOUSE
	warp_def 11, 31, 1, CHERRYGROVE_EVOLUTION_SPEECH_HOUSE

.XYTriggers: db 3
	xy_trigger 0, 7, 33, CherrygroveGuideGentTrigger
	xy_trigger 1, 6, 33, CherrygroveSilverTriggerNorth
	xy_trigger 1, 7, 33, CherrygroveSilverTriggerSouth

.Signposts: db 2
	signpost 8, 30, SIGNPOST_JUMPTEXT, CherrygroveCitySignText
	signpost 9, 23, SIGNPOST_JUMPTEXT, GuideGentsHouseSignText

.PersonEvents: db 5
	person_event SPRITE_GUIDE_GENT, 6, 32, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CherrygroveCityGuideGent, EVENT_GUIDE_GENT_IN_HIS_HOUSE
	person_event SPRITE_CHERRYGROVE_RIVAL, 6, 39, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_CHERRYGROVE_CITY
	person_event SPRITE_TEACHER, 12, 27, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CherrygroveTeacherScript, -1
	person_event SPRITE_YOUNGSTER, 7, 23, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CherrygroveYoungsterScript, -1
	person_event SPRITE_FISHER, 12, 7, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, MysticWaterGuy, -1

const_value set 1
	const CHERRYGROVECITY_GRAMPS
	const CHERRYGROVECITY_SILVER

CherrygroveCityFlyPoint:
	setflag ENGINE_FLYPOINT_CHERRYGROVE
	return

CherrygroveCitySwimmerGuySprite:
	checkevent EVENT_GUIDE_GENT_VISIBLE_IN_CHERRYGROVE
	iftrue .done
	variablesprite SPRITE_GUIDE_GENT, SPRITE_SWIMMER_GUY
.done
	return

CherrygroveGuideGentTrigger:
	applymovement PLAYER, GuideGentPlayerMovement
	setlasttalked CHERRYGROVECITY_GRAMPS
CherrygroveCityGuideGent:
	showtextfaceplayer GuideGentIntroText
	playmusic MUSIC_SHOW_ME_AROUND
	follow CHERRYGROVECITY_GRAMPS, PLAYER
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement1
	showtext GuideGentPokeCenterText
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement2
	spriteface PLAYER, UP
	showtext GuideGentMartText
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement3
	spriteface PLAYER, UP
	showtext GuideGentRoute30Text
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement4
	spriteface PLAYER, LEFT
	showtext GuideGentSeaText
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement5
	spriteface PLAYER, UP
	pause 60
	spriteface CHERRYGROVECITY_GRAMPS, LEFT
	spriteface PLAYER, RIGHT
	opentext
	writetext GuideGentGiftText
	buttonsound
	stringtotext .mapcardname, $1
	scall .JumpstdReceiveItem
	setflag ENGINE_MAP_CARD
	writetext GotMapCardText
	buttonsound
	writetext GuideGentPokegearText
	waitbutton
	closetext
	stopfollow
	special RestartMapMusic
	spriteface PLAYER, UP
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement6
	playsound SFX_ENTER_DOOR
	disappear CHERRYGROVECITY_GRAMPS
	clearevent EVENT_GUIDE_GENT_VISIBLE_IN_CHERRYGROVE
	variablesprite SPRITE_GUIDE_GENT, SPRITE_SWIMMER_GUY
	dotrigger $2
	waitsfx
	end

.JumpstdReceiveItem:
	jumpstd receiveitem
	end

.mapcardname
	db "Map Card@"

CherrygroveSilverTriggerSouth:
	moveperson CHERRYGROVECITY_SILVER, 39, 7
CherrygroveSilverTriggerNorth:
	spriteface PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	appear CHERRYGROVECITY_SILVER
	applymovement CHERRYGROVECITY_SILVER, CherrygroveCity_RivalWalksToYou
	spriteface PLAYER, RIGHT
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext UnknownText_0x19c4e2
	variablesprite SPRITE_CHERRYGROVE_RIVAL, SPRITE_BUG_CATCHER
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext SilverCherrygroveWinText, SilverCherrygroveLossText
	setlasttalked CHERRYGROVECITY_SILVER
	loadtrainer RIVAL0, 3
	writecode VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	variablesprite SPRITE_CHERRYGROVE_RIVAL, SPRITE_SILVER
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	reloadmap
	jump .FinishRival

.Totodile:
	winlosstext SilverCherrygroveWinText, SilverCherrygroveLossText
	setlasttalked CHERRYGROVECITY_SILVER
	loadtrainer RIVAL0, 1
	writecode VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	variablesprite SPRITE_CHERRYGROVE_RIVAL, SPRITE_SILVER
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	reloadmap
	jump .FinishRival

.Chikorita:
	winlosstext SilverCherrygroveWinText, SilverCherrygroveLossText
	setlasttalked CHERRYGROVECITY_SILVER
	loadtrainer RIVAL0, 2
	writecode VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	variablesprite SPRITE_CHERRYGROVE_RIVAL, SPRITE_SILVER
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	reloadmap
.FinishRival:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext CherrygroveRivalTextAfter1
	showemote EMOTE_SHOCK, CHERRYGROVECITY_SILVER, 15
	showtext CherrygroveRivalTextAfter2
	playsound SFX_TACKLE
	applymovement PLAYER, CherrygroveCity_RivalPushesYouOutOfTheWay
	spriteface PLAYER, LEFT
	applymovement CHERRYGROVECITY_SILVER, CherrygroveCity_RivalExitsStageLeft
	disappear CHERRYGROVECITY_SILVER
	variablesprite SPRITE_CHERRYGROVE_RIVAL, SPRITE_BUG_CATCHER
	special MapCallbackSprites_LoadUsedSpritesGFX
	special HealPartyEvenForNuzlocke
	dotrigger $2
	playmusic MUSIC_CHERRYGROVE_CITY
	end

CherrygroveTeacherScript:
	faceplayer
	opentext
	checkflag ENGINE_MAP_CARD
	iftrue .HaveMapCard
	jumpopenedtext CherrygroveTeacherText_NoMapCard

.HaveMapCard:
	jumpopenedtext CherrygroveTeacherText_HaveMapCard

CherrygroveYoungsterScript:
	faceplayer
	opentext
	checkflag ENGINE_POKEDEX
	iftrue .HavePokedex
	jumpopenedtext CherrygroveYoungsterText_NoPokedex

.HavePokedex:
	jumpopenedtext CherrygroveYoungsterText_HavePokedex

MysticWaterGuy:
	faceplayer
	opentext
	checkevent EVENT_GOT_MYSTIC_WATER_IN_CHERRYGROVE
	iftrue .After
	writetext MysticWaterGuyTextBefore
	buttonsound
	verbosegiveitem MYSTIC_WATER
	iffalse .Exit
	setevent EVENT_GOT_MYSTIC_WATER_IN_CHERRYGROVE
.After:
	writetext MysticWaterGuyTextAfter
	waitbutton
.Exit:
	endtext

GuideGentPlayerMovement:
	step_left
	turn_head_up
	step_end

GuideGentMovement1:
	step_left
	step_left
	step_up
	step_left
	turn_head_up
	step_end

GuideGentMovement2:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	turn_head_up
	step_end

GuideGentMovement3:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	turn_head_up
	step_end

GuideGentMovement4:
	step_left
	step_left
	step_left
	step_down
	step_left
	step_left
	step_left
	step_down
	turn_head_left
	step_end

GuideGentMovement5:
	step_down
	step_down
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_down
	step_down
	step_right
	step_right
	step_right
	step_right
	step_right
	turn_head_up
	step_end

GuideGentMovement6:
	step_up
	step_up
	step_end

CherrygroveCity_RivalWalksToYou:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

CherrygroveCity_RivalPushesYouOutOfTheWay:
	big_step_down
	turn_head_up
	step_end

CherrygroveCity_RivalExitsStageLeft:
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	big_step_left
	big_step_left
	step_end

GuideGentIntroText:
	text "You're a rookie"
	line "trainer, aren't"
	cont "you? I can tell!"

	para "That's OK! Every-"
	line "one is a rookie"
	cont "at some point!"

	para "I can teach you"
	line "a few things."
	cont "Follow me!"
	done

GuideGentPokeCenterText:
	text "This is a #mon"
	line "Center. They heal"

	para "your #mon in no"
	line "time at all."

	para "You'll be relying"
	line "on them a lot, so"

	para "you better learn"
	line "about them."
	done

GuideGentMartText:
	text "This is a #mon"
	line "Mart, or just"
	cont "# Mart."

	para "They sell Balls"
	line "for catching wild"

	para "#mon and other"
	line "useful items."
	done

GuideGentRoute30Text:
	text "Route 30 is out"
	line "this way."

	para "Trainers will be"
	line "battling their"

	para "prized #mon"
	line "there."
	done

GuideGentSeaText:
	text "This is the sea,"
	line "as you can see."

	para "Route 32 is just"
	line "across the bay."
	done

GuideGentGiftText:
	text "Here…"

	para "It's my house!"
	line "Thanks for your"
	cont "company."

	para "Let me give you a"
	line "small gift."
	done

GotMapCardText:
	text "<PLAYER>'s #gear"
	line "now has a Map!"
	done

GuideGentPokegearText:
	text "#gear becomes"
	line "more useful as you"
	cont "add Cards."

	para "I wish you luck on"
	line "your journey!"
	done

UnknownText_0x19c4e2:
	text "…… …… ……"

	para "You got a #mon"
	line "at the Lab."

	para "What a waste."
	line "A wimp like you."

	para "…… …… ……"

	para "Don't you get what"
	line "I'm saying?"

	para "Well, I too, have"
	line "a good #mon."

	para "I'll show you"
	line "what I mean!"
	done

SilverCherrygroveWinText:
	text "Humph. Are you"
	line "happy you won?"
	done

SilverCherrygroveLossText:
	text "Humph. That was a"
	line "waste of time."
	done

CherrygroveRivalTextAfter1:
	text "…… …… ……"

	para "You want to know"
	line "who I am?"

	para "I'm going to be"
	line "the world's great-"
	cont "est #mon"
	cont "trainer."
	done

CherrygroveRivalTextAfter2:
	text "Hey! Give back my"
	line "Trainer Card!"

	para "Oh no… You saw"
	line "my name…"
	done

CherrygroveTeacherText_NoMapCard:
	text "Did you talk to"
	line "the old man by the"
	cont "#mon Center?"

	para "He'll put a Map of"
	line "Johto on your"
	cont "#gear."
	done

CherrygroveTeacherText_HaveMapCard:
	text "When you're with"
	line "#mon, going"
	cont "anywhere is fun."
	done

CherrygroveYoungsterText_NoPokedex:
	text "Mr.#mon's house"
	line "is still farther"
	cont "up ahead."
	done

CherrygroveYoungsterText_HavePokedex:
	text "I battled the"
	line "trainers on the"
	cont "road."

	para "My #mon lost."
	line "They're a mess! I"

	para "must take them to"
	line "a #mon Center."
	done

MysticWaterGuyTextBefore:
	text "A #mon I caught"
	line "had an item."

	para "I think it's"
	line "Mystic Water."

	para "I don't need it,"
	line "so do you want it?"
	done

MysticWaterGuyTextAfter:
	text "Back to fishing"
	line "for me, then."
	done

CherrygroveCitySignText:
	text "Cherrygrove City"

	para "The City of Cute,"
	line "Fragrant Flowers"
	done

GuideGentsHouseSignText:
	text "Guide Gent's House"
	done
