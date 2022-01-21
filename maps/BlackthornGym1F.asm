BlackthornGym1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, BlackthornGym1FBoulderCallback

	def_warp_events
	warp_event  4, 17, BLACKTHORN_CITY, 1
	warp_event  5, 17, BLACKTHORN_CITY, 1
	warp_event  1,  7, BLACKTHORN_GYM_2F, 1
	warp_event  7,  9, BLACKTHORN_GYM_2F, 2
	warp_event  2,  6, BLACKTHORN_GYM_2F, 3
	warp_event  7,  7, BLACKTHORN_GYM_2F, 4
	warp_event  7,  6, BLACKTHORN_GYM_2F, 5

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, BlackthornGymStatue
	bg_event  6, 15, BGEVENT_READ, BlackthornGymStatue

	def_object_events
	object_event  5,  3, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGymClairScript, -1
	object_event  7, 15, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BlackthornGymGuyScript, -1
	object_event  1, 14, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerDragonTamerPaul, -1
	object_event  6,  6, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCooltrainermMike, -1
	object_event  9,  2, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainerfLola, -1

BlackthornGym1FBoulderCallback:
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_1
	iffalse .skip1
	changeblock 8, 2, $3b
.skip1
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_2
	iffalse .skip2
	changeblock 2, 4, $3a
.skip2
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_3
	iffalse .skip3
	changeblock 8, 6, $3b
.skip3
	endcallback

BlackthornGymStatue:
	gettrainername CLAIR, 1, $1
	checkflag ENGINE_RISINGBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	readvar VAR_BADGES
	ifgreater 15, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

BlackthornGymClairScript:
	checkflag ENGINE_RISINGBADGE
	iftrue_jumptextfaceplayer ClairPokemonLeagueDirectionsText
	checkevent EVENT_BEAT_CLAIR
	iftrue_jumptextfaceplayer .TooMuchToExpectText
	showtextfaceplayer .IntroText
	winlosstext .WinText, 0
	loadtrainer CLAIR, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CLAIR
	showtext .GoToDragonsDenText
	setevent EVENT_BEAT_DRAGON_TAMER_PAUL
	setevent EVENT_BEAT_COOLTRAINERM_CODY
	setevent EVENT_BEAT_COOLTRAINERM_MIKE
	setevent EVENT_BEAT_COOLTRAINERF_FRAN
	setevent EVENT_BEAT_COOLTRAINERF_LOLA
	clearevent EVENT_MAHOGANY_MART_OWNERS
	setevent EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	clearevent EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	end

.IntroText:
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

.WinText:
	text "I lost?"

	para "I don't believe"
	line "it. There must be"
	cont "some mistake…"
	done

.GoToDragonsDenText:
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
	cont "center."
	cont "Go there."

	para "If you can prove"
	line "that you've lost"

	para "your lazy ideals,"
	line "I will recognize"

	para "you as a trainer"
	line "worthy of a Gym"
	cont "Badge!"
	done

.TooMuchToExpectText:
	text "What's the matter?"

	para "Is it too much to"
	line "expect of you?"
	done

ClairPokemonLeagueDirectionsText:
	text "What's the matter?"

	para "Aren't you headed"
	line "to the #mon"
	cont "League?"

	para "Do you know how to"
	line "get there?"

	para "From here, go to"
	line "New Bark Town."
	cont "Then Surf east."

	para "The route there is"
	line "very tough."

	para "Don't you dare"
	line "lose at the #-"
	cont "mon League!"

	para "If you do, I'll"
	line "feel even worse"

	para "about having lost"
	line "to you!"

	para "Give it everything"
	line "you've got."
	done

BlackthornGymGuyScript:
	checkevent EVENT_BEAT_CLAIR
	iftrue_jumptextfaceplayer .WinText
	jumpthistextfaceplayer

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

.WinText:
	text "You were great to"
	line "beat Clair!"

	para "All that's left is"
	line "the #mon League"
	cont "challenge."

	para "You're on the way"
	line "to becoming the"
	cont "#mon Champion!"
	done

GenericTrainerDragonTamerPaul:
	generictrainer DRAGON_TAMER, PAUL, EVENT_BEAT_DRAGON_TAMER_PAUL, .SeenText, .BeatenText

	text "Lance told you"
	line "that he'd like to"

	para "see you again?"
	line "Not a chance!"
	done

.SeenText:
	text "Your first battle"
	line "against dragons?"

	para "I'll show you how"
	line "tough they are!"
	done

.BeatenText:
	text "My dragon #mon"
	line "lost?"
	done

GenericTrainerCooltrainermMike:
	generictrainer COOLTRAINERM, MIKE, EVENT_BEAT_COOLTRAINERM_MIKE, .SeenText, .BeatenText

	text "I know my short-"
	line "comings now."

	para "Thanks for showing"
	line "me!"
	done

.SeenText:
	text "My chance of"
	line "losing? Not even"
	cont "one percent!"
	done

.BeatenText:
	text "That's odd."
	done

GenericTrainerCooltrainerfLola:
	generictrainer COOLTRAINERF, LOLA, EVENT_BEAT_COOLTRAINERF_LOLA, .SeenText, .BeatenText

	text "Dragons are weak"
	line "against Dragon-"
	cont "type moves."
	done

.SeenText:
	text "Dragons are sacred"
	line "#mon."

	para "They are full of"
	line "life energy."

	para "If you're not"
	line "serious, you won't"

	para "be able to beat"
	line "them."
	done

.BeatenText:
	text "Way to go!"
	done
