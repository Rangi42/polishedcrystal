EarlsPokemonAcademy_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3, 15, VIOLET_CITY, 3
	warp_event  4, 15, VIOLET_CITY, 3

	db 0 ; coord events

	db 4 ; bg events
	bg_event  0,  1, SIGNPOST_READ, PokemonJournalWillScript
	bg_event  1,  1, SIGNPOST_READ, PokemonJournalWillScript
	bg_event  3,  0, SIGNPOST_READ, AcademyBlackboard
	bg_event  4,  0, SIGNPOST_READ, AcademyBlackboard

	db 6 ; object events
	object_event  4,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, AcademyEarl, EVENT_EARLS_ACADEMY_EARL
	object_event  2,  4, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AcademyNotebook, -1
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x68d80, -1
	object_event  4,  7, SPRITE_CHILD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x68e39, -1
	object_event  3, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x68a86, -1
	object_event  4, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x68a91, -1

	const_def 1 ; object constants
	const EARLSPOKEMONACADEMY_EARL

AcademyEarl:
	applymovement EARLSPOKEMONACADEMY_EARL, MovementData_0x68b2d
	faceplayer
	opentext
	writetext UnknownText_0x68b3b
	yesorno
	iffalse .Part1
	writetext UnknownText_0x68bbd
	yesorno
	iffalse_jumpopenedtext UnknownText_0x68d31
.Part1:
	writetext UnknownText_0x68c51
	yesorno
	iffalse_jumpopenedtext UnknownText_0x68d31
	jumpopenedtext UnknownText_0x68c7b

GameboyKidScript_0x68a86:
	showtextfaceplayer UnknownText_0x68dda
	turnobject LAST_TALKED, DOWN
	end

GameboyKidScript_0x68a91:
	showtextfaceplayer UnknownText_0x68e07
	turnobject LAST_TALKED, DOWN
	end

AcademyBlackboard:
	opentext
	writetext AcademyBlackboardText
.Loop:
	loadmenu .MenuHeader
	_2dmenu
	closewindow
	ifequal $1, .Poison
	ifequal $2, .Paralysis
	ifequal $3, .Sleep
	ifequal $4, .Burn
	ifequal $5, .Freeze
	endtext

.Poison:
	writetext AcademyPoisonText
	waitbutton
	jump .Loop

.Paralysis:
	writetext AcademyParalysisText
	waitbutton
	jump .Loop

.Sleep:
	writetext AcademySleepText
	waitbutton
	jump .Loop

.Burn:
	writetext AcademyBurnText
	waitbutton
	jump .Loop

.Freeze:
	writetext AcademyFreezeText
	waitbutton
	jump .Loop

.MenuHeader:
	db $40 ; flags
	db 00, 00 ; start coords
	db 08, 11 ; end coords
	dw .Data
	db 1 ; default option

.Data:
	db $80 ; flags
	dn 3, 2 ; rows, columns
	db 5 ; spacing
	dba .Text
	dbw BANK(AcademyBlackboard), 0

.Text:
	db "Psn@"
	db "Par@"
	db "Slp@"
	db "Brn@"
	db "Frz@"
	db "Quit@"

AcademyNotebook:
	opentext
	writetext AcademyNotebookText
	yesorno
	iffalse .Done
	writetext AcademyNotebookText1
	yesorno
	iffalse .Done
	writetext AcademyNotebookText2
	yesorno
	iffalse .Done
	writetext AcademyNotebookText3
	waitbutton
.Done:
	endtext

PokemonJournalWillScript:
	setflag ENGINE_READ_WILL_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Elite Four Will!"

	para "Will does not talk"
	line "about his past"

	para "before joining the"
	line "Elite Four."

	para "Some say he worked"
	line "for Team Rocket."

	para "#mon Journal"
	line "refuses to specu-"
	cont "late."
	done

MovementData_0x68b2d:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	step_end

UnknownText_0x68b3b:
	text "Earl, I am!"

	para "Wonderful are"
	line "#mon, yes!"

	para "Teach you I will"
	line "to be a better"
	cont "trainer!"

	para "What you want to"
	line "know? Want to be"
	cont "a winner is you?"
	done

UnknownText_0x68bbd:
	text "Good! Teach you,"
	line "I will!"

	para "In battle, #mon"
	line "top on list jump"
	cont "out first!"

	para "Change order in"
	line "list, make battle"
	cont "easy, maybe!"

	para "More from me you"
	line "want to hear?"
	done

UnknownText_0x68c51:
	text "So, want to know"
	line "how to raise"
	cont "#mon well?"
	done

UnknownText_0x68c7b:
	text "Fine! Teach you,"
	line "I will!"

	para "If #mon come"
	line "out in battle even"

	para "briefly, some Exp."
	line "Points it gets."

	para "At top of list put"
	line "weak #mon."

	para "Switch in battle"
	line "quick!"

	para "This way, weak"
	line "#mon strong"
	cont "become!"
	done

UnknownText_0x68d31:
	text "Oh! Smart student"
	line "you are! Nothing"
	cont "more do I teach!"

	para "Good to #mon"
	line "you must be!"
	done

UnknownText_0x68d80:
	text "I'm taking notes"
	line "of the teacher's"
	cont "lecture."

	para "I'd better copy"
	line "the stuff on the"
	cont "blackboard too."
	done

UnknownText_0x68dda:
	text "I traded my best"
	line "#mon to the"
	cont "guy beside me."
	done

UnknownText_0x68e07:
	text "Huh? The #mon I"
	line "just got is hold-"
	cont "ing something!"
	done

UnknownText_0x68e39:
	text "A #mon holding"
	line "a Berry will heal"
	cont "itself in battle."

	para "Many other items"
	line "can be held by"
	cont "#mon…"

	para "It sure is tough"
	line "taking notes…"
	done

AcademyBlackboardText:
	text "The blackboard"
	line "describes #mon"

	para "status changes in"
	line "battle."
	done

AcademyPoisonText:
	text "If poisoned, a"
	line "#mon steadily"
	cont "loses HP."

	para "Poison lingers"
	line "after the battle,"

	para "and HP is lost as"
	line "you walk."

	para "To cure it, use an"
	line "Antidote."
	done

AcademyParalysisText:
	text "Paralysis reduces"
	line "speed and may"
	cont "prevent movement."

	para "It remains after"
	line "battle, so use"
	cont "a ParalyzeHeal."
	done

AcademySleepText:
	text "If asleep, your"
	line "#mon can't make"
	cont "a move."

	para "A sleeping #mon"
	line "doesn't wake up"
	cont "after battle."

	para "Wake it up with"
	line "an Awakening."
	done

AcademyBurnText:
	text "A burn steadily"
	line "consumes HP."

	para "It also reduces"
	line "attack power."

	para "A burn lingers"
	line "after battle."

	para "Use a Burn Heal as"
	line "the cure."
	done

AcademyFreezeText:
	text "If your #mon is"
	line "frozen, it can't"
	cont "do a thing."

	para "It remains frozen"
	line "after battle."

	para "Thaw it out with"
	line "an Ice Heal."
	done

AcademyNotebookText:
	text "It's this kid's"
	line "notebook…"

	para "Catch #mon"
	line "using # Balls."

	para "Up to six can be"
	line "in your party."

	para "Keep reading?"
	done

AcademyNotebookText1:
	text "Before throwing a"
	line "# Ball, weaken"
	cont "the target first."

	para "A poisoned or"
	line "burned #mon is"
	cont "easier to catch."

	para "Keep reading?"
	done

AcademyNotebookText2:
	text "Some moves may"
	line "cause confusion."

	para "Confusion may make"
	line "a #mon attack"
	cont "itself."

	para "Leaving battle"
	line "clears up any"
	cont "confusion."

	para "Keep reading?"
	done

AcademyNotebookText3:
	text "People who catch"
	line "and use #mon"

	para "in battle are"
	line "#mon trainers."

	para "They are expected"
	line "to visit #mon"

	para "Gyms and defeat"
	line "other trainers."

	para "The next page"
	line "is… Blank!"

	para "Boy: E-he-he…"

	para "I haven't written"
	line "any more…"
	done
