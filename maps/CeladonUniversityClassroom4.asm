CeladonUniversityClassroom4_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 11, CELADON_UNIVERSITY_1F, 9
	warp_event  3, 11, CELADON_UNIVERSITY_1F, 9

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom4BlackboardText
	bg_event  3,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom4BlackboardText
	bg_event  4,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom4BlackboardText
	bg_event  6,  1, BGEVENT_READ, CeladonUniversityClassroom4Bookshelf1
	bg_event  7,  1, BGEVENT_JUMPTEXT, CeladonUniversityClassroom4Bookshelf2Text

	def_object_events
	object_event  5,  2, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityClassroom4RaymondScript, -1
	object_event  2,  1, SPRITE_CANDELA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom4CandelaText, EVENT_CELADON_UNIVERSITY_CANDELA
	object_event  2,  1, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom4TeacherText, EVENT_SHAMOUTI_COAST_CANDELA
	object_event  2,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom4Bug_catcherText, -1
	object_event  3,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom4FisherText, -1
	object_event  5,  7, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom4LadyText, -1
	object_event  4,  9, SPRITE_RICH_BOY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonUniversityClassroom4Rich_boyScript, -1

	object_const_def
	const CELADONUNIVERSITYCLASSROOM4_RAYMOND

CeladonUniversityClassroom4RaymondScript:
	faceplayer
	checkevent EVENT_BEAT_COOLTRAINERM_RAYMOND
	iftrue .Beaten
	opentext
	checkevent EVENT_INTRODUCED_CELADON_FOUR
	iftrue .IntroducedCeladonFour1
	writetext .IntroText1
	sjump .AfterIntro
.IntroducedCeladonFour1
	writetext .IntroText2
.AfterIntro
	yesorno
	iffalse_jumpopenedtext .NoBattleText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked CELADONUNIVERSITYCLASSROOM4_RAYMOND
	loadtrainer COOLTRAINERM, COOLTRAINERM_RAYMOND
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_RAYMOND
.Beaten
	opentext
	setevent EVENT_INTRODUCED_CELADON_FOUR
	checkevent EVENT_BEAT_COOLTRAINERM_COREY
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_BEAT_COOLTRAINERM_RAYMOND
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_BEAT_COOLTRAINERM_FERGUS
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_GOT_CHOICE_BAND_FROM_CELADON_FOUR
	iftrue_jumpopenedtext .FinalText
	writetext .AfterText2
	promptbutton
	verbosegiveitem CHOICE_BAND
	iffalse_endtext
	setevent EVENT_GOT_CHOICE_BAND_FROM_CELADON_FOUR
	jumpopenedtext .FinalText

.IntroText1:
	text "Hey! I'm Raymond!"
	line "Just call me Ray."

	para "I'm one of top four"
	line "trainers at Cela-"
	cont "don University."

	para "We're known as the"
	line "Celadon Four!"

	para "Want to see our"
	line "skill yourself?"

	para "Let's have a match!"
	line "Unless you're"
	cont "afraid to lose."
	done

.IntroText2:
	text "Hey! I'm Raymond!"
	line "Just call me Ray."

	para "I'm one of the"
	line "Celadon Four!"

	para "You're looking to"
	line "fight us all?"

	para "Let's have a match!"
	line "Unless you're"
	cont "afraid to lose."
	done

.NoBattleText:
	text "I knew you were"
	line "scared."
	done

.SeenText:
	text "Let's do this!"
	done

.BeatenText:
	text "Ohhhh nooooo!"
	done

.AfterText1:
	text "How could this be?"
	line "I'm one of the"
	cont "Celadon Four!"

	para "I may have lost,"
	line "but my three pals"
	cont "will avenge me."

	para "Go find them"
	line "yourself!"
	done

.AfterText2:
	text "You've beaten all"
	line "of the Celadon"
	cont "Four?"

	para "No way!"

	para "…Fine. I guess"
	line "you've earned this."
	done

.FinalText:
	text "If you've conquered"
	line "the Celadon Four,"

	para "you can bear any"
	line "burden."
	done

CeladonUniversityClassroom4CandelaText:
	text "Hi! I'm Candela."
	line "I teach #mon"
	cont "Battling!"

	para "I'm researching"
	line "ways to enhance"

	para "#mon's natural"
	line "power in the pur-"
	cont "suit of strength."
	done

CeladonUniversityClassroom4TeacherText:
	text "I'm just a sub-"
	line "stitute."

	para "The usual instruc-"
	line "tor, Candela, went"

	para "off to Shamouti"
	line "Island for some"
	cont "reason."
	done

CeladonUniversityClassroom4Bug_catcherText:
	text "My lecturer said"
	line "my #mon could"

	para "really battle with"
	line "the best of them."

	para "Its potential was"
	line "the best she'd"
	cont "ever seen!"
	done

CeladonUniversityClassroom4FisherText:
	text "The prof said my"
	line "#mon was a"
	cont "wonder!"

	para "It's a breath-"
	line "taking #mon."
	done

CeladonUniversityClassroom4LadyText:
	text "The professor said"
	line "my #mon simply"
	cont "amazed her."

	para "I guess it really"
	line "can accomplish"
	cont "anything!"
	done

CeladonUniversityClassroom4Rich_boyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_ABILITY_CAP_IN_UNIVERSITY
	iftrue .GotItem
	writetext .Text1
	promptbutton
	verbosegiveitem ABILITY_CAP
	iffalse_endtext
	setevent EVENT_GOT_ABILITY_CAP_IN_UNIVERSITY
.GotItem:
	writetext .Text2
	waitendtext

.Text1:
	text "We're learning"
	line "about #mon"
	cont "abilities."

	para "Some species can"
	line "have more than one"
	cont "ability."

	para "Use this to switch"
	line "between them!"
	done

.Text2:
	text "There are some"
	line "rare “hidden"
	cont "abilities” that"

	para "an Ability Cap"
	line "can't change."

	para "But! If a #-"
	line "mon holding an"

	para "Ability Cap has"
	line "an Egg, its baby"

	para "might have a"
	line "hidden ability!"
	done

CeladonUniversityClassroom4BlackboardText:
	text "Be aware of these"
	line "factors in battle:"
	cont "- Type chart"
	cont "- Move effects"
	cont "- Move categories"
	cont "- Conditions"
	cont "- Held items"
	cont "- Base stats"
	cont "- Effort values"
	cont "- Natures"
	cont "- Abilities"
	cont "- Weather"
	cont "- Others?"
	done

CeladonUniversityClassroom4Bookshelf1:
	checkevent EVENT_GOT_X_SPCL_ATK_IN_UNIVERSITY
	iftrue_jumptext .Text2
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem X_SPCL_ATK
	iffalse_endtext
	setevent EVENT_GOT_X_SPCL_ATK_IN_UNIVERSITY
	endtext

.Text1:
	text "This bookcase is"
	line "a mess!"

	para "<PLAYER> straight-"
	line "ened up the books."

	para "…Oh?"
	done

.Text2:
	text "This bookcase is"
	line "all neat and tidy."
	done

CeladonUniversityClassroom4Bookshelf2Text:
	text "It's a #mon"
	line "coloring book."

	para "What's this doing"
	line "here?"
	done
