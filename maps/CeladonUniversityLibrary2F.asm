CeladonUniversityLibrary2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversityLibrary2F_MapEventHeader:

.Warps: db 1
	warp_def $0, $7, 3, CELADON_UNIVERSITY_LIBRARY_1F

.XYTriggers: db 0

.Signposts: db 28
	signpost 0, 4, SIGNPOST_READ, CeladonUniversityLibrary1FSignpost1
	signpost 0, 10, SIGNPOST_READ, CeladonUniversityLibrary1FSignpost2
	signpost 3, 0, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf1
	signpost 3, 1, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf2
	signpost 3, 2, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf3
	signpost 3, 3, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf4
	signpost 3, 4, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf5
	signpost 3, 5, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf6
	signpost 3, 8, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf7
	signpost 3, 9, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf8
	signpost 3, 10, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf9
	signpost 3, 11, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf10
	signpost 3, 12, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf11
	signpost 3, 13, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf12
	signpost 7, 6, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf13
	signpost 7, 7, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf14
	signpost 7, 8, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf15
	signpost 7, 9, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf16
	signpost 7, 10, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf17
	signpost 7, 11, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf18
	signpost 7, 12, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf19
	signpost 7, 13, SIGNPOST_READ, CeladonUniversityLibrary2FBookshelf20
	signpost 6, 1, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer1
	signpost 6, 3, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer2
	signpost 8, 1, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer3
	signpost 8, 3, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer1
	signpost 10, 1, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer1
	signpost 10, 3, SIGNPOST_RIGHT, CeladonUniversityLibrary2FComputer4

.PersonEvents: db 7
	person_event SPRITE_ARTIST, 9, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary2FArtistScript, -1
	person_event SPRITE_COSPLAYER, 4, 3, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary2FCosplayerScript, -1
	person_event SPRITE_LASS, 5, 11, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary2FLassScript, -1
	person_event SPRITE_SUPER_NERD, 11, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary2FSuper_nerdScript, -1
	person_event SPRITE_COOLTRAINER_F, 11, 8, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary2FCooltrainerfScript, -1
	person_event SPRITE_YOUNGSTER, 10, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary2FYoungsterScript, -1
	person_event SPRITE_BALL_CUT_FRUIT, 1, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, CeladonUniversityLibrary2FTimerBall, EVENT_CELADON_UNIVERSITY_LIBRARY_2F_TIMER_BALL

const_value set 2
	const CELADONUNIVERSITYLIBRARY2F_ARTIST

CeladonUniversityLibrary2FCosplayerScript:
	jumptextfaceplayer .Text

.Text:
	text "It's great being"
	line "in the city!"

	para "I can wear my cos-"
	line "tume in public and"

	para "people don't bat"
	line "an eye!"
	done

CeladonUniversityLibrary2FLassScript:
	jumptextfaceplayer .Text

.Text:
	text "Never judge a book"
	line "by its cover."

	para "Sometimes even the"
	line "dullest exterior"

	para "can hide the best"
	line "stories."
	done

CeladonUniversityLibrary2FArtistScript:
	opentext
	writetext .Text1
	waitbutton
	closetext
	faceplayer
	opentext
	writetext .Text2
	waitbutton
	closetext
	spriteface CELADONUNIVERSITYLIBRARY2F_ARTIST, RIGHT
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

CeladonUniversityLibrary2FSuper_nerdScript:
	jumptextfaceplayer .Text

.Text:
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

CeladonUniversityLibrary2FCooltrainerfScript:
	jumptextfaceplayer .Text

.Text:
	text "This is my book."
	line "And I'm going to"
	cont "READ IT!"
	done

CeladonUniversityLibrary2FYoungsterScript:
	jumptextfaceplayer .Text

.Text:
	text "I'm reading about a"
	line "legendary #mon"

	para "with the power to"
	line "distort space."

	para "It's pretty scary…"
	done

CeladonUniversityLibrary2FTimerBall:
	itemball TIMER_BALL

CeladonUniversityLibrary2FBookshelf1:
	jumptext .Text

.Text:
	text "It's a book con-"
	line "taining #mon"

	para "of an ancient"
	line "alphabet."

	para "With one of each"
	line "kind, they can"
	cont "grant wishes."
	done

CeladonUniversityLibrary2FBookshelf2:
	jumptext .Text

.Text:
	text "This book is"
	line "falling apart."

	para "The title is no"
	line "longer readable,"

	para "but there's a pic-"
	line "ture of a #mon"

	para "wearing heavy"
	line "armor."
	done

CeladonUniversityLibrary2FBookshelf3:
	jumptext .Text

.Text:
	text "It's a book with a"
	line "giant padlock on"
	cont "the cover."

	para "Better leave it"
	line "alone."
	done

CeladonUniversityLibrary2FBookshelf4:
	jumptext .Text

.Text:
	text "This book's written"
	line "in a foreign"
	cont "language!"

	para "Better put it"
	line "back…"
	done

CeladonUniversityLibrary2FBookshelf5:
	jumptext .Text

.Text:
	text "Behind these"
	line "books…"

	para "Nope. There's"
	line "nothing here."
	done

CeladonUniversityLibrary2FBookshelf6:
	jumptext .Text

.Text:
	text "It's a book about"
	line "#mon that have"

	para "regional diff-"
	line "erences."

	para "There's a picture"
	line "of a Raichu that"
	cont "looks a little"
	cont "strange…"
	done

CeladonUniversityLibrary2FBookshelf7:
	jumptext .Text

.Text:
	text "It's a book about"
	line "#mon Contests."

	para "An impressive-"
	line "looking building"

	para "is pictured on"
	line "the cover."
	done

CeladonUniversityLibrary2FBookshelf8:
	jumptext .Text

.Text:
	text "A boy is shown"
	line "riding a #mon"

	para "on the cover"
	line "of this book."

	para "“How to Train Your"
	line "Dragonite” is"
	cont "written in bold."
	done

CeladonUniversityLibrary2FBookshelf9:
	jumptext .Text

.Text:
	text "It's a book de-"
	line "picting a world"

	para "inhabited entirely"
	line "by #mon!"

	para "“Pikachu's Adven-"
	line "tures in #Park”"

	para "is written on the"
	line "cover."
	done

CeladonUniversityLibrary2FBookshelf10:
	jumptext .Text

.Text:
	text "It's a book about"
	line "an island of giant"
	cont "#mon robots."

	para "“#mon Robotics”"
	line "by Anne Droid…"
	done

CeladonUniversityLibrary2FBookshelf11:
	jumptext .Text

.Text:
	text "“Forgive and"
	line "Forget” by Saul"
	cont "Goode."

	para "There's a picture"
	line "of a man with a"
	cont "big grin."
	done

CeladonUniversityLibrary2FBookshelf12:
	jumptext .Text

.Text:
	text "“Weightlessness”"
	line "by Andy Gravity."
	cont "Sounds flighty!"
	done

CeladonUniversityLibrary2FBookshelf13:
	jumptext .Text

.Text:
	text "It's a book"
	line "explaining the"

	para "biology of"
	line "#mon."

	para "It's enormous!"
	done

CeladonUniversityLibrary2FBookshelf14:
	jumptext .Text

.Text:
	text "This book is"
	line "covered in"
	cont "cobwebs."

	para "Guess it hasn't"
	line "been read in a"
	cont "while."
	done

CeladonUniversityLibrary2FBookshelf15:
	jumptext .Text

.Text:
	text "It's a book de-"
	line "picting a fearsome"
	cont "#mon."

	para "“Absofusion and"
	line "the Tao Trio” is"

	para "written in big"
	line "letters."
	done

CeladonUniversityLibrary2FBookshelf16:
	jumptext .Text

.Text:
	text "“Ancient #-"
	line "mopolis: A History"

	para "of Extinct"
	line "#mon”"

	para "Sounds"
	line "interesting!"
	done

CeladonUniversityLibrary2FBookshelf17:
	jumptext .Text

.Text:
	text "It's a book titled"
	line "“Typecasting: The"

	para "Mystery of"
	line "Sudowoodo”."
	done

CeladonUniversityLibrary2FBookshelf18:
	jumptext .Text

.Text:
	text "It's a book about"
	line "an ancient tree"

	para "guarded by three"
	line "titans."

	para "It looks almost"
	line "magical."
	done

CeladonUniversityLibrary2FBookshelf19:
	jumptext .Text

.Text:
	text "It's a copy of the"
	line "original route for"
	cont "the Magnet Train!"

	para "It shows a planned"
	line "stop-off station"
	cont "in Ecruteak City."
	done

CeladonUniversityLibrary2FBookshelf20:
	jumptext .Text

.Text:
	text "Red books,"
	line "blue books,"
	cont "yellow books,"
	cont "green books…"

	para "Books of every"
	line "color!"
	done

CeladonUniversityLibrary2FComputer1:
	jumptext .Text

.Text:
	text "There's a login"
	line "screen with a"

	para "background image"
	line "of a Magikarp."
	done

CeladonUniversityLibrary2FComputer2:
	jumptext .Text

.Text:
	text "Someone forgot to"
	line "log out!"
	done

CeladonUniversityLibrary2FComputer3:
	jumptext .Text

.Text:
	text "There's a story"
	line "full of grammar"
	cont "and spelling"
	cont "errors."
	done

CeladonUniversityLibrary2FComputer4:
	jumptext .Text

.Text:
	text "There's a web page"
	line "about how to be a"
	cont "“l33t h4x0r”."
	done
