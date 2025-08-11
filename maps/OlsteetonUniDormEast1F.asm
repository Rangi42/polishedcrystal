OlsteetonUniDormEast1F_MapScriptHeader:

	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7, 11, OLSTEETON_UNI, 15
	warp_event  8, 11, OLSTEETON_UNI, 15
	warp_event  0,  8, OLSTEETON_UNI_DINING_HALL, 4
	warp_event  0,  9, OLSTEETON_UNI_DINING_HALL, 5
; 	warp_event 11,  3, OLSTEETON_UNI_DORM_EAST_2F, 10



	def_coord_events

	def_bg_events
	bg_event 11,  6, BGEVENT_RIGHT, OlsteetonUniDormEast1FComputer
	bg_event  2,  0, BGEVENT_JUMPTEXT, OlsteetonUniDormEast1FSignText
	bg_event 11,  8, BGEVENT_RIGHT, OlsteetonUniDormEast1FComputer

	def_object_events
; 	object_event 10,  6, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonUniDormEast1FNeeshaScript, -1
; 	object_event  5,  1, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDormEast1FLassText, -1
; 	object_event  4,  1, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDormEast1FRichBoyText, -1
; 	object_event  1,  4, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDormEast1FCooltrainerfText, -1
; 	object_event  2,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDormEast1FSuper_nerd1Text, -1
; 	object_event  5,  7, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDormEast1FSuper_nerd2Text, -1

	object_const_def
; 	const OlsteetonUniDormEast1F_NEESHA

; OlsteetonUniDormEast1FNeeshaScript:
; 	faceplayer
; 	opentext
; 	checkevent EVENT_BEAT_COOLTRAINERF_NEESHA
; 	iftruefwd .Beaten
; 	checkevent EVENT_INTRODUCED_CELADON_FOUR
; 	iftruefwd .IntroducedCeladonFour1
; 	writetext .IntroText1
; 	sjumpfwd .AfterIntro
; .IntroducedCeladonFour1
; 	writetext .IntroText2
; .AfterIntro
; 	yesorno
; 	iffalse_jumpopenedtext .NoBattleText
; 	writetext .SeenText
; 	waitbutton
; 	closetext
; 	winlosstext .BeatenText, 0
; 	setlasttalked OlsteetonUniDormEast1F_NEESHA
; 	loadtrainer COOLTRAINERF, NEESHA
; 	startbattle
; 	reloadmapafterbattle
; 	setevent EVENT_BEAT_COOLTRAINERF_NEESHA
; 	opentext
; .Beaten
; 	setevent EVENT_INTRODUCED_CELADON_FOUR
; 	checkevent EVENT_BEAT_COOLTRAINERM_COREY
; 	iffalse_jumpopenedtext .AfterText1
; 	checkevent EVENT_BEAT_COOLTRAINERM_RAYMOND
; 	iffalse_jumpopenedtext .AfterText1
; 	checkevent EVENT_BEAT_COOLTRAINERM_FERGUS
; 	iffalse_jumpopenedtext .AfterText1
; 	checkevent EVENT_GOT_CHOICE_BAND_FROM_CELADON_FOUR
; 	iftrue_jumpopenedtext .FinalText
; 	writetext .AfterText2
; 	promptbutton
; 	verbosegiveitem CHOICE_BAND
; 	iffalse_endtext
; 	setevent EVENT_GOT_CHOICE_BAND_FROM_CELADON_FOUR
; 	jumpopenedtext .FinalText

; .IntroText1:
; 	text "Hi! I'm Neesha!"
; 	line "I'm one of top four"

; 	para "trainers in Cela-"
; 	line "don University."

; 	para "We're known as the"
; 	line "Celadon Four!"

; 	para "Want me to show"
; 	line "you why we're so"
; 	cont "famous?"

; 	para "Then let's battle!"
; 	done

; .IntroText2:
; 	text "Hi! I'm Neesha!"
; 	line "I'm one of the"
; 	cont "Celadon Four!"

; 	para "It looks like"
; 	line "you've heard of us."

; 	para "Then let's battle!"
; 	done

; .NoBattleText:
; 	text "Not interested in"
; 	line "a challenge?"
; 	done

; .SeenText:
; 	text "We'll blow you"
; 	line "away!"
; 	done

; .BeatenText:
; 	text "A painful loss…"
; 	done

; .AfterText1:
; 	text "You're a worthy"
; 	line "opponent!"

; 	para "But you haven't"
; 	line "seen everything"

; 	para "the Celadon Four"
; 	line "can do."

; 	para "Why don't you find"
; 	line "the rest of us and"
; 	cont "challenge them?"
; 	done

; .AfterText2:
; 	text "So you beat all of"
; 	line "the Celadon Four…"

; 	para "That's so cool!"

; 	para "Take this as a"
; 	line "prize!"
; 	done

; .FinalText:
; 	text "It's not often that"
; 	line "someone gives us"

; 	para "Celadon Four a"
; 	line "real challenge."

; 	para "I won't forget"
; 	line "you, trainer!"
; 	done

; OlsteetonUniDormEast1FLassText:
; 	text "Next month we're"
; 	line "going on a trip"
; 	cont "to Mt.Moon."

; 	para "Maybe I'll see a"
; 	line "Clefairy!"
; 	done

; OlsteetonUniDormEast1FSuper_nerd1Text:
; 	text "What do you get if"
; 	line "you cross a joke"

; 	para "with a rhetorical"
; 	line "question?"

; 	para "………………………………"
; 	done

; OlsteetonUniDormEast1FSuper_nerd2Text:
; 	text "I'm writing scripts"
; 	line "for a game."

; 	para "Do not said use"
; 	line "asm!"
; 	done

OlsteetonUniDormEast1FSignText:
	text "Beware:"
	line "Students may"
	cont "challenge you"
	done

OlsteetonUniDormEast1FBookshelf2:
	opentext
	writetext .Text1
	waitbutton
	checkevent EVENT_GOT_PP_MAX_IN_UNIVERSITY
	iftruefwd .GotItem
	verbosegiveitem PP_MAX
	iffalsefwd .Done
	setevent EVENT_GOT_PP_MAX_IN_UNIVERSITY
.Done
	endtext

.GotItem
	jumpopenedtext .Text2

.Text1:
	text "This book has a"
	line "secret compartment"

	para "where the pages"
	line "should be!"
	done

.Text2:
	text "Too bad--it's"
	line "empty."
	done

OlsteetonUniDormEast1FComputer:
	jumpthistext

	text "There's a player"
	line "character running"

	para "around a 2D"
	line "Celadon City."
	done
