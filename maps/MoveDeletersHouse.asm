MoveDeletersHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, BLACKTHORN_CITY, 6
	warp_event  3,  7, BLACKTHORN_CITY, 6

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 2 ; object events
	object_event  2,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MoveDeleterScript, -1
	object_event  5,  3, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MoveReminderScript, -1

MoveDeleterScript:
	faceplayer
	opentext
	special MoveDeletion
	waitendtext

MoveReminderScript:
	faceplayer
	opentext
	writetext MoveReminderIntroText
	waitbutton
	checkitem GOLD_LEAF
	iffalse .no_gold_leaf
	writetext MoveReminderPromptText
	yesorno
	iffalse .refused
	writebyte NO_MOVE ; to toggle move relearner
	writetext MoveReminderWhichMonText
	waitbutton
	special Special_MoveTutor
	ifequal $0, .teach_move
.refused
	jumpopenedtext MoveReminderCancelText

.no_gold_leaf
	jumpopenedtext MoveReminderNoGoldLeafText

.teach_move
	takeitem GOLD_LEAF
	jumpopenedtext MoveReminderCancelText

MoveReminderIntroText::
	text "Me? I'm the"
	line "Move Maniac."

	para "I'll make your"
	line "#mon remember"

	para "a move if you'll"
	line "trade me a"
	cont "Gold Leaf."
	done

MoveReminderPromptText::
	text "Do you want me to"
	line "teach one of your"
	cont "#mon a move?"
	done

MoveReminderWhichMonText::
	text "Which #mon"
	line "needs tutoring?"
	done

MoveReminderNoGoldLeafText::
	text "Huh? You don't"
	line "have any Gold"
	cont "Leaves."

	para "Sometimes you can"
	line "find them on wild"
	cont "Bellsprout."
	done

MoveReminderNoMovesText::
	text "Sorry… There isn't"
	line "any move I can"

	para "make that #mon"
	line "remember."
	done

MoveReminderCancelText::
	text "If your #mon"
	line "needs to learn a"

	para "move, come back"
	line "with a Gold Leaf."
	done
