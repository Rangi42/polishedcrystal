OlsteetonUniLibrary1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7, 11, OLSTEETON_UNI, 3
	warp_event  8, 11, OLSTEETON_UNI, 3
	warp_event  9,  0, OLSTEETON_UNI_LIBRARY_2F, 1

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FSignpost1Text
	bg_event 10,  1, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FSignpost2Text
	bg_event  0,  9, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf1Text
	bg_event  1,  9, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf2Text
	bg_event  7,  1, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf3Text
	bg_event  6,  1, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf4Text
	bg_event  4,  1, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf5Text
	bg_event  5,  1, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf6Text
	bg_event  6,  5, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf7Text
	bg_event  7,  5, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf8Text
	bg_event  0,  5, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf9Text
	bg_event  1,  5, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf10Text
	bg_event  4,  9, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf11Text
	bg_event  5,  9, BGEVENT_JUMPTEXT, OlsteetonUniLibrary1FBookshelf12Text

	def_object_events
	object_event  4,  5, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniLibrary1FLadyText, -1
	object_event 13,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniLibrary1FGentlemanText, -1
	object_event  0,  6, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniLibrary1FCooltrainerfText, -1
	object_event 12,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OlsteetonUniLibrary1FGameboyKidScript, -1
	object_event  5,  2, SPRITE_MATRON, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniLibrary1FPokefan_fText, -1
	object_event 10,  4, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, OlsteetonUniLibrary1FCooltrainermScript, -1
	object_event 12, 10, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniLibrary1FTeacherText, -1
	object_event 12,  5, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptext, OlsteetonUniLibrary1FBookText, -1

OlsteetonUniLibrary1FLadyText:
	para "This library is on"
	line "university"
	cont "grounds, but it's"

	para "open for anyone"
	line "to use."

	para "Isn't that great?"
	done

OlsteetonUniLibrary1FGentlemanText:
	text "Shh! Can't you see"
	line "I'm reading here?"
	done

OlsteetonUniLibrary1FCooltrainerfText:
	text "Prof.Oak used to"
	line "teach here, so the"

	para "library has copies"
	line "of all his journal"
	cont "articles."

	para "I've read each one"
	line "cover to cover!"
	done

OlsteetonUniLibrary1FGameboyKidScript:
	showtextfaceplayer .Text
	turnobject LAST_TALKED, DOWN
	end

.Text:
	text "My #dex has a"
	line "game upgrade."

	para "I'm playing Tetris!"
	done

OlsteetonUniLibrary1FPokefan_fText:
	text "We have a mutual"
	line "lending agreement"

	para "with Canalave"
	line "Library in Sinnoh."
	done

OlsteetonUniLibrary1FCooltrainermScript:
	checkevent EVENT_GOT_FOCUS_BAND_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem FOCUS_BAND
	iffalse_endtext
	setevent EVENT_GOT_FOCUS_BAND_IN_UNIVERSITY
	jumpopenedtext .Text2

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

OlsteetonUniLibrary1FTeacherText:
	text "I'm the head"
	line "librarian."

	para "If you need any-"
	line "thing, just shout."

	para "Quietly, though."
	line "This IS a library."
	done

OlsteetonUniLibrary1FBookText:
	text "It's a book about"
	line "flower arranging."

	para "A Sunflora is on"
	line "the cover."
	done

OlsteetonUniLibrary1FSignpost1Text:
	text "Please do not"
	line "disturb students"

	para "reading in the"
	line "library."
	done

OlsteetonUniLibrary1FSignpost2Text:
	text "Please do not"
	line "bring food or"

	para "beverages into"
	line "the library."
	done

OlsteetonUniLibrary1FBookshelf1Text:
	text "Huh? Someone left"
	line "an old photograph"
	cont "in this book."

	para "Erika and a man"
	line "with a gentle"

	para "smile are posing"
	line "happily alongside"
	cont "an Oddish."
	done

OlsteetonUniLibrary1FBookshelf2Text:
	text "It's a photo album"
	line "containing many"

	para "pictures of"
	line "#mon."

	para "“Todd Snap's Scrap-"
	line "folio” is written"
	cont "on the cover."
	done

OlsteetonUniLibrary1FBookshelf3Text:
	text "It's a book about"
	line "a man who taught"

	para "his #mon to"
	line "play a musical"
	cont "instrument."

	para "They seem the best"
	line "of friends."
	done

OlsteetonUniLibrary1FBookshelf4Text:
	text "It's a book about"
	line "#mon palin-"
	cont "dromes."

	para "There's an Eevee"
	line "and a Girafarig"
	cont "on the cover."
	done

OlsteetonUniLibrary1FBookshelf5Text:
	text "This book is about"
	line "Toy #mon that"

	para "come to life after"
	line "being wound up by"
	cont "a Wonder Key."

	para "They look kinda"
	line "cute."
	done

OlsteetonUniLibrary1FBookshelf6Text:
	text "It's a book about"
	line "a #mon puppet"
	cont "that can't tell"
	cont "lies."

	para "“Pinpokéo” is"
	line "written on the"
	cont "cover."
	done

OlsteetonUniLibrary1FBookshelf7Text:
	text "It's a bo…"
	line "wait…"

	para "This is a video"
	line "game!"

	para "A #mon pinball"
	line "machine is shown"

	para "proudly on the"
	line "box art."
	done

OlsteetonUniLibrary1FBookshelf8Text:
	text "It's a book writ-"
	line "ten by a fishing"
	cont "guru providing"

	para "advice to new"
	line "anglers."

	para "“Odds and Rods” is"
	line "written on the"
	cont "cover."
	done

OlsteetonUniLibrary1FBookshelf9Text:
	text "It's a manual"
	line "explaining the"

	para "#mon Trading"
	line "Card game."
	done

OlsteetonUniLibrary1FBookshelf10Text:
	text "It's a cookbook"
	line "full of #mon-"
	cont "themed recipes!"

	para "Jigglypuff Jello,"
	line "Charmander Chut-"
	cont "ney, Munchlax"
	cont "Snacks…"
	done

OlsteetonUniLibrary1FBookshelf11Text:
	text "It's a guide to"
	line "Poffin blending."

	para "A famous #mon"
	line "breeder is on the"
	cont "cover."
	done

OlsteetonUniLibrary1FBookshelf12Text:
	text "“The Secret Life"
	line "of Laughter” by"
	cont "Joe King."
	cont "Puntastic!"
	done
