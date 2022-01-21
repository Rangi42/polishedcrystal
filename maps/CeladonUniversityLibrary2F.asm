CeladonUniversityLibrary2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  0, CELADON_UNIVERSITY_LIBRARY_1F, 3

	def_coord_events

	def_bg_events
	bg_event  4,  0, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FSignpost1Text
	bg_event 10,  0, BGEVENT_JUMPTEXT, CeladonUniversityLibrary1FSignpost2Text
	bg_event  0,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf1Text
	bg_event  1,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf2Text
	bg_event  2,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf3Text
	bg_event  3,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf4Text
	bg_event  4,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf5Text
	bg_event  5,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf6Text
	bg_event  8,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf7Text
	bg_event  9,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf8Text
	bg_event 10,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf9Text
	bg_event 11,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf10Text
	bg_event 12,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf11Text
	bg_event 13,  3, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf12Text
	bg_event  6,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf13Text
	bg_event  7,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf14Text
	bg_event  8,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf15Text
	bg_event  9,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf16Text
	bg_event 10,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf17Text
	bg_event 11,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf18Text
	bg_event 12,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf19Text
	bg_event 13,  7, BGEVENT_JUMPTEXT, CeladonUniversityLibrary2FBookshelf20Text
	bg_event  1,  6, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer1
	bg_event  3,  6, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer2
	bg_event  1,  8, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer3
	bg_event  3,  8, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer1
	bg_event  1, 10, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer1
	bg_event  3, 10, BGEVENT_RIGHT, CeladonUniversityLibrary2FComputer4

	def_object_events
	object_event  3,  4, SPRITE_COSPLAYER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FCosplayerText, -1
	object_event 11,  5, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FLassText, -1
	object_event  0,  9, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityLibrary2FArtistScript, -1
	object_event  2, 11, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FSuper_nerdText, -1
	object_event  8, 11, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FCooltrainerfText, -1
	object_event 11, 10, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FYoungsterText, -1
	itemball_event  0,  1, TIMER_BALL, 1, EVENT_CELADON_UNIVERSITY_LIBRARY_2F_TIMER_BALL

CeladonUniversityLibrary2FCosplayerText:
	text "It's great being"
	line "in the city!"

	para "I can wear my cos-"
	line "tume in public and"

	para "people don't bat"
	line "an eye!"
	done

CeladonUniversityLibrary2FLassText:
	text "Never judge a book"
	line "by its cover."

	para "Sometimes even the"
	line "dullest exterior"

	para "can hide the best"
	line "stories."
	done

CeladonUniversityLibrary2FArtistScript:
	showtext .Text1
	showtextfaceplayer .Text2
	turnobject LAST_TALKED, RIGHT
	end

.Text1:
	text "“Jasmine gazed"
	line "into Erika's deep"
	cont "brown eyes…”"
	done

.Text2:
	text "Huh? Go away!"

	para "It's rude to read"
	line "over someone's"
	cont "shoulder!"
	done

CeladonUniversityLibrary2FSuper_nerdText:
	text "The “net send”"
	line "command will show"

	para "a message on"
	line "everyone else's"
	cont "computer screen!"

	para "Hmm, what to send…"

	para "“Free pizza in"
	line "Prof.Westwood's"
	cont "office!”"

	para "Hehehe."
	done

CeladonUniversityLibrary2FCooltrainerfText:
	text "This is my book."
	line "And I'm going to"
	cont "READ IT!"
	done

CeladonUniversityLibrary2FYoungsterText:
	text "I'm reading about a"
	line "legendary #mon"

	para "with the power to"
	line "distort space."

	para "It's pretty scary…"
	done

CeladonUniversityLibrary2FBookshelf1Text:
	text "It's a book con-"
	line "taining #mon"

	para "of an ancient"
	line "alphabet."

	para "With one of each"
	line "kind, they can"
	cont "grant wishes."
	done

CeladonUniversityLibrary2FBookshelf2Text:
	text "This book is"
	line "falling apart."

	para "The title is no"
	line "longer readable,"

	para "but there's a pic-"
	line "ture of a #mon"

	para "wearing heavy"
	line "armor."
	done

CeladonUniversityLibrary2FBookshelf3Text:
	text "It's a book with a"
	line "giant padlock on"
	cont "the cover."

	para "Better leave it"
	line "alone."
	done

CeladonUniversityLibrary2FBookshelf4Text:
	text "This book's written"
	line "in a foreign"
	cont "language!"

	para "Better put it"
	line "back…"
	done

CeladonUniversityLibrary2FBookshelf5Text:
	text "Behind these"
	line "books…"

	para "Nope. There's"
	line "nothing here."
	done

CeladonUniversityLibrary2FBookshelf6Text:
	text "It's a book about"
	line "#mon that have"

	para "regional diff-"
	line "erences."

	para "There's a picture"
	line "of a Raichu that"
	cont "looks a little"
	cont "strange…"
	done

CeladonUniversityLibrary2FBookshelf7Text:
	text "It's a book about"
	line "#mon Contests."

	para "An impressive-"
	line "looking building"

	para "is pictured on"
	line "the cover."
	done

CeladonUniversityLibrary2FBookshelf8Text:
	text "A boy is shown"
	line "riding a #mon"

	para "on the cover"
	line "of this book."

	para "“How to Train Your"
	line "Dragonite” is"
	cont "written in bold."
	done

CeladonUniversityLibrary2FBookshelf9Text:
	text "It's a book de-"
	line "picting a world"

	para "inhabited entirely"
	line "by #mon!"

	para "“Pikachu's Adven-"
	line "tures in #Park”"

	para "is written on the"
	line "cover."
	done

CeladonUniversityLibrary2FBookshelf10Text:
	text "It's a book about"
	line "an island of giant"
	cont "#mon robots."

	para "“#mon Robotics”"
	line "by Anne Droid…"
	done

CeladonUniversityLibrary2FBookshelf11Text:
	text "“Forgive and"
	line "Forget” by Saul"
	cont "Goode."

	para "There's a picture"
	line "of a man with a"
	cont "big grin."
	done

CeladonUniversityLibrary2FBookshelf12Text:
	text "“Weightlessness”"
	line "by Andy Gravity."
	cont "Sounds flighty!"
	done

CeladonUniversityLibrary2FBookshelf13Text:
	text "It's a book"
	line "explaining the"

	para "biology of"
	line "#mon."

	para "It's enormous!"
	done

CeladonUniversityLibrary2FBookshelf14Text:
	text "This book is"
	line "covered in"
	cont "cobwebs."

	para "Guess it hasn't"
	line "been read in a"
	cont "while."
	done

CeladonUniversityLibrary2FBookshelf15Text:
	text "It's a book de-"
	line "picting a fearsome"
	cont "#mon."

	para "“Absofusion and"
	line "the Tao Trio” is"

	para "written in big"
	line "letters."
	done

CeladonUniversityLibrary2FBookshelf16Text:
	text "“Ancient #-"
	line "mopolis: A History"

	para "of Extinct"
	line "#mon”"

	para "Sounds"
	line "interesting!"
	done

CeladonUniversityLibrary2FBookshelf17Text:
	text "It's a book titled"
	line "“Typecasting: The"

	para "Mystery of"
	line "Sudowoodo”."
	done

CeladonUniversityLibrary2FBookshelf18Text:
	text "It's a book about"
	line "an ancient tree"

	para "guarded by three"
	line "titans."

	para "It looks almost"
	line "magical."
	done

CeladonUniversityLibrary2FBookshelf19Text:
	text "It's a copy of the"
	line "original route for"
	cont "the Magnet Train!"

	para "It shows a planned"
	line "stop-off station"
	cont "in Ecruteak City."
	done

CeladonUniversityLibrary2FBookshelf20Text:
	text "Red books,"
	line "blue books,"
	cont "yellow books,"
	cont "green books…"

	para "Books of every"
	line "color!"
	done

CeladonUniversityLibrary2FComputer1:
	jumpthistext

	text "There's a login"
	line "screen with a"

	para "background image"
	line "of a Magikarp."
	done

CeladonUniversityLibrary2FComputer2:
	jumpthistext

	text "Someone forgot to"
	line "log out!"
	done

CeladonUniversityLibrary2FComputer3:
	jumpthistext

	text "There's a story"
	line "full of grammar"
	cont "and spelling"
	cont "errors."
	done

CeladonUniversityLibrary2FComputer4:
	jumpthistext

	text "There's a web page"
	line "about how to be a"
	cont "“l33t h4x0r”."
	done
