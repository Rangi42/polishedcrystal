CeladonUniversityLibrary1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversityLibrary1F_MapEventHeader:

.Warps: db 3
	warp_def $b, $6, 4, CELADON_UNIVERSITY_1F
	warp_def $b, $7, 4, CELADON_UNIVERSITY_1F
	warp_def $0, $7, 1, CELADON_UNIVERSITY_LIBRARY_2F

.XYTriggers: db 0

.Signposts: db 14
	signpost 0, 4, SIGNPOST_READ, CeladonUniversityLibrary1FSignpost1
	signpost 0, 10, SIGNPOST_READ, CeladonUniversityLibrary1FSignpost2
	signpost 3, 0, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf1
	signpost 3, 1, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf2
	signpost 3, 2, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf3
	signpost 3, 3, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf4
	signpost 3, 4, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf5
	signpost 3, 5, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf6
	signpost 7, 0, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf7
	signpost 7, 1, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf8
	signpost 7, 2, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf9
	signpost 7, 3, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf10
	signpost 7, 4, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf11
	signpost 7, 5, SIGNPOST_READ, CeladonUniversityLibrary1FBookshelf12

.PersonEvents: db 8
	person_event SPRITE_GAMEBOY_KID, 5, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary1FGameboyKidScript, -1
	person_event SPRITE_LADY, 3, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary1FLadyScript, -1
	person_event SPRITE_GENTLEMAN, 3, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary1FGentlemanScript, -1
	person_event SPRITE_COOLTRAINER_F, 5, 0, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary1FCooltrainerfScript, -1
	person_event SPRITE_POKEFAN_F, 8, 3, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary1FPokefan_fScript, -1
	person_event SPRITE_COOLTRAINER_M, 8, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary1FCooltrainermScript, -1
	person_event SPRITE_TEACHER, 11, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary1FTeacherScript, -1
	person_event SPRITE_BOOK_UNOWN_R, 3, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CeladonUniversityLibrary1FBookScript, -1

const_value set 2
	const CELADONUNIVERSITYLIBRARY1F_GAMEBOY_KID

CeladonUniversityLibrary1FLadyScript:
	jumptextfaceplayer .Text

.Text:
	text "This library is on"
	line "university"
	cont "grounds, but it's"

	para "open for anyone"
	line "to use."

	para "Isn't that great?"
	done

CeladonUniversityLibrary1FGentlemanScript:
	jumptextfaceplayer .Text

.Text:
	text "Shh! Can't you see"
	line "I'm reading here?"
	done

CeladonUniversityLibrary1FCooltrainerfScript:
	jumptextfaceplayer .Text

.Text:
	text "Prof.Oak used to"
	line "teach here, so the"

	para "library has copies"
	line "of all his journal"
	cont "articles."

	para "I've read each one"
	line "cover to cover!"
	done

CeladonUniversityLibrary1FGameboyKidScript:
	showtextfaceplayer .Text
	spriteface CELADONUNIVERSITYLIBRARY1F_GAMEBOY_KID, DOWN
	end

.Text:
	text "My #dex has a"
	line "game upgrade."

	para "I'm playing Tetris!"
	done

CeladonUniversityLibrary1FPokefan_fScript:
	jumptextfaceplayer .Text

.Text:
	text "We have a mutual"
	line "lending agreement"

	para "with Canalave"
	line "Library in Sinnoh."
	done

CeladonUniversityLibrary1FCooltrainermScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_FOCUS_BAND_IN_UNIVERSITY
	iftrue .GotItem
	writetext .Text1
	buttonsound
	verbosegiveitem FOCUS_BAND
	iffalse .Done
	setevent EVENT_GOT_FOCUS_BAND_IN_UNIVERSITY
.GotItem:
	writetext .Text2
	waitbutton
.Done:
	closetext
	end

.Text1:
	text "I have a big test"
	line "coming up, so I'm"

	para "planning to be"
	line "here a while."

	para "I just need to"
	line "hang in there."

	para "This is what helps"
	line "me out."
	done

.Text2:
	text "If you want your"
	line "#mon to hang in"
	cont "there, give them"
	cont "that Focus Band."
	done

CeladonUniversityLibrary1FTeacherScript:
	jumptextfaceplayer .Text

.Text:
	text "I'm the head"
	line "librarian."

	para "If you need any-"
	line "thing, just shout."

	para "Quietly, though."
	line "This IS a library."
	done

CeladonUniversityLibrary1FBookScript:
	jumptext .Text

.Text:
	text "It's a book about"
	line "flower arranging."

	para "A Sunflora is on"
	line "the cover."
	done

CeladonUniversityLibrary1FSignpost1:
	jumptext .Text

.Text:
	text "Please do not"
	line "disturb students"

	para "reading in the"
	line "library."
	done

CeladonUniversityLibrary1FSignpost2:
	jumptext .Text

.Text:
	text "Please do not"
	line "bring food or"

	para "beverages into"
	line "the library."
	done

CeladonUniversityLibrary1FBookshelf1:
	jumptext .Text

.Text:
	text "Huh? Someone left"
	line "an old photograph"
	cont "in this book."

	para "Erika and a man"
	line "with a gentle"

	para "smile are posing"
	line "happily alongside"
	cont "an Oddish."
	done

CeladonUniversityLibrary1FBookshelf2:
	jumptext .Text

.Text:
	text "It's a photo album"
	line "containing many"

	para "pictures of"
	line "#mon."

	para "“Todd Snap's Scrap-"
	line "folio” is written"
	cont "on the cover."
	done

CeladonUniversityLibrary1FBookshelf3:
	jumptext .Text

.Text:
	text "It's a book about"
	line "a man who taught"

	para "his #mon to"
	line "play a musical"
	cont "instrument."

	para "They seem the best"
	line "of friends."
	done

CeladonUniversityLibrary1FBookshelf4:
	jumptext .Text

.Text:
	text "It's a book about"
	line "#mon palin-"
	cont "dromes."

	para "There's an Eevee"
	line "and a Girafarig"
	cont "on the cover."
	done

CeladonUniversityLibrary1FBookshelf5:
	jumptext .Text

.Text:
	text "This book is about"
	line "Toy #mon that"

	para "come to life after"
	line "being wound up by"
	cont "a Wonder Key."

	para "They look kinda"
	line "cute."
	done

CeladonUniversityLibrary1FBookshelf6:
	jumptext .Text

.Text:
	text "It's a book about"
	line "a #mon puppet"
	cont "that can't tell"
	cont "lies."

	para "“Pinpokéo” is"
	line "written on the"
	cont "cover."
	done

CeladonUniversityLibrary1FBookshelf7:
	jumptext .Text

.Text:
	text "It's a bo…"
	line "wait…"

	para "This is a video"
	line "game!"

	para "A #mon pinball"
	line "machine is shown"

	para "proudly on the"
	line "box art."
	done

CeladonUniversityLibrary1FBookshelf8:
	jumptext .Text

.Text:
	text "It's a book writ-"
	line "ten by a fishing"
	cont "guru providing"

	para "advice to new"
	line "anglers."

	para "“Odds and Rods” is"
	line "written on the"
	cont "cover."
	done

CeladonUniversityLibrary1FBookshelf9:
	jumptext .Text

.Text:
	text "It's a manual"
	line "explaining the"

	para "#mon Trading"
	line "Card game."
	done

CeladonUniversityLibrary1FBookshelf10:
	jumptext .Text

.Text:
	text "It's a cookbook"
	line "full of #mon-"
	cont "themed recipes!"

	para "Jigglypuff Jello,"
	line "Charmander Chut-"
	cont "ney, Munchlax"
	cont "Snacks…"
	done

CeladonUniversityLibrary1FBookshelf11:
	jumptext .Text

.Text:
	text "It's a guide to"
	line "Poffin blending."

	para "A famous #mon"
	line "breeder is on the"
	cont "cover."
	done

CeladonUniversityLibrary1FBookshelf12:
	jumptext .Text

.Text:
	text "“The Secret Life"
	line "of Laughter” by"
	cont "Joe King."
	cont "Puntastic!"
	done
