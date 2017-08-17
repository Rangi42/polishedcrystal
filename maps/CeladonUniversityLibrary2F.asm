CeladonUniversityLibrary2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversityLibrary2F_MapEventHeader:

.Warps: db 1
	warp_def 0, 7, 3, CELADON_UNIVERSITY_LIBRARY_1F

.XYTriggers: db 0

.Signposts: db 28
	signpost 0, 4, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary1FSignpost1Text
	signpost 0, 10, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary1FSignpost2Text
	signpost 3, 0, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf1Text
	signpost 3, 1, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf2Text
	signpost 3, 2, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf3Text
	signpost 3, 3, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf4Text
	signpost 3, 4, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf5Text
	signpost 3, 5, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf6Text
	signpost 3, 8, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf7Text
	signpost 3, 9, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf8Text
	signpost 3, 10, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf9Text
	signpost 3, 11, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf10Text
	signpost 3, 12, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf11Text
	signpost 3, 13, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf12Text
	signpost 7, 6, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf13Text
	signpost 7, 7, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf14Text
	signpost 7, 8, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf15Text
	signpost 7, 9, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf16Text
	signpost 7, 10, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf17Text
	signpost 7, 11, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf18Text
	signpost 7, 12, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf19Text
	signpost 7, 13, SIGNPOST_JUMPTEXT, CeladonUniversityLibrary2FBookshelf20Text
	signpost 6, 1, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer1
	signpost 6, 3, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer2
	signpost 8, 1, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer3
	signpost 8, 3, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer1
	signpost 10, 1, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer1
	signpost 10, 3, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer4

.PersonEvents: db 7
	person_event SPRITE_COSPLAYER, 4, 3, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FCosplayerText, -1
	person_event SPRITE_LASS, 5, 11, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FLassText, -1
	person_event SPRITE_ARTIST, 9, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary2FArtistScript, -1
	person_event SPRITE_SUPER_NERD, 11, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FSuper_nerdText, -1
	person_event SPRITE_COOLTRAINER_F, 11, 8, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FCooltrainerfText, -1
	person_event SPRITE_YOUNGSTER, 10, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityLibrary2FYoungsterText, -1
	itemball_event 1, 0, TIMER_BALL, 1, EVENT_CELADON_UNIVERSITY_LIBRARY_2F_TIMER_BALL

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
	spriteface LAST_TALKED, RIGHT
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
	thistext

	text "There's a login"
	line "screen with a"

	para "background image"
	line "of a Magikarp."
	done

CeladonUniversityLibrary2FComputer2:
	thistext

	text "Someone forgot to"
	line "log out!"
	done

CeladonUniversityLibrary2FComputer3:
	thistext

	text "There's a story"
	line "full of grammar"
	cont "and spelling"
	cont "errors."
	done

CeladonUniversityLibrary2FComputer4:
	thistext

	text "There's a web page"
	line "about how to be a"
	cont "“l33t h4x0r”."
	done
