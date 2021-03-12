CeladonUniversityLounge_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 11, CELADON_UNIVERSITY_1F, 10
	warp_event  5, 11, CELADON_UNIVERSITY_1F, 10

	def_coord_events

	def_bg_events
	bg_event  7,  5, BGEVENT_JUMPTEXT, CeladonUniversityLoungeBookshelf1Text
	bg_event  7,  8, BGEVENT_READ, CeladonUniversityLoungeBookshelf2
	bg_event  0,  7, BGEVENT_RIGHT, CeladonUniversityLoungeComputer

	def_object_events
	object_event  5,  8, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityLoungeNeeshaScript, -1
	object_event  3,  1, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLoungeLassText, -1
	object_event  5,  3, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLoungeRichBoyText, -1
	object_event  5,  4, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLoungeCooltrainerfText, -1
	object_event  2,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLoungeSuper_nerd1Text, -1
	object_event  1,  8, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLoungeSuper_nerd2Text, -1

	object_const_def
	const CELADONUNIVERSITYLOUNGE_NEESHA

CeladonUniversityLoungeNeeshaScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_COOLTRAINERF_NEESHA
	iftrue .Beaten
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
	setlasttalked CELADONUNIVERSITYLOUNGE_NEESHA
	loadtrainer COOLTRAINERF, NEESHA
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERF_NEESHA
	opentext
.Beaten
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
	text "Hi! I'm Neesha!"
	line "I'm one of top four"

	para "trainers in Cela-"
	line "don University."

	para "We're known as the"
	line "Celadon Four!"

	para "Want me to show"
	line "you why we're so"
	cont "famous?"

	para "Then let's battle!"
	done

.IntroText2:
	text "Hi! I'm Neesha!"
	line "I'm one of the"
	cont "Celadon Four!"

	para "It looks like"
	line "you've heard of us."

	para "Then let's battle!"
	done

.NoBattleText:
	text "Not interested in"
	line "a challenge?"
	done

.SeenText:
	text "We'll blow you"
	line "away!"
	done

.BeatenText:
	text "A painful loss…"
	done

.AfterText1:
	text "You're a worthy"
	line "opponent!"

	para "But you haven't"
	line "seen everything"

	para "the Celadon Four"
	line "can do."

	para "Why don't you find"
	line "the rest of us and"
	cont "challenge them?"
	done

.AfterText2:
	text "So you beat all of"
	line "the Celadon Four…"

	para "That's so cool!"

	para "Take this as a"
	line "prize!"
	done

.FinalText:
	text "It's not often that"
	line "someone gives us"

	para "Celadon Four a"
	line "real challenge."

	para "I won't forget"
	line "you, trainer!"
	done

CeladonUniversityLoungeLassText:
	text "Next month we're"
	line "going on a trip"
	cont "to Mt.Moon."

	para "Maybe I'll see a"
	line "Clefairy!"
	done

CeladonUniversityLoungeRichBoyText:
	text "Have you ever"
	line "wondered why"

	para "Ultra Balls have"
	line "a yellow letter"
	cont "H on the top?"

	para "It's because they"
	line "were first called"
	cont "Hyper Balls!"
	done

CeladonUniversityLoungeCooltrainerfText:
	text "#mon with"
	line "reduced physical"

	para "strength instinct-"
	line "ively attempt to"
	cont "enter a # Ball."
	done

CeladonUniversityLoungeSuper_nerd1Text:
	text "What do you get if"
	line "you cross a joke"

	para "with a rhetorical"
	line "question?"

	para "………………………………"
	done

CeladonUniversityLoungeSuper_nerd2Text:
	text "I'm writing scripts"
	line "for a game."

	para "Do not said use"
	line "asm!"
	done

CeladonUniversityLoungeBookshelf1Text:
	text "It's stuffed full"
	line "of copies of"
	cont "#mon manga!"
	done

CeladonUniversityLoungeBookshelf2:
	opentext
	writetext .Text1
	waitbutton
	checkevent EVENT_GOT_PP_MAX_IN_UNIVERSITY
	iftrue .GotItem
	verbosegiveitem PP_MAX
	iffalse .Done
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

CeladonUniversityLoungeComputer:
	jumpthistext

	text "There's a player"
	line "character running"

	para "around a 2D"
	line "Celadon City."
	done
