BlackthornMart_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, BLACKTHORN_CITY, 4
	warp_event  3,  7, BLACKTHORN_CITY, 4

	db 0 ; coord events

	db 0 ; bg events

	db 4 ; object events
	mart_clerk_event  1,  3, MARTTYPE_STANDARD, MART_BLACKTHORN
	object_event  7,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornMartCooltrainermText, -1
	object_event  5,  2, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornMartBlackbeltText, -1
	object_event 11,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornMartSuperNerdText, -1

BlackthornMartCooltrainermText:
	text "You can't buy Max"
	line "Revive, but it"

	para "fully restores a"
	line "fainted #mon."

	para "Beware--it won't"
	line "restore PP, the"

	para "Power Points"
	line "needed for moves."
	done

BlackthornMartBlackbeltText:
	text "Max Repel keeps"
	line "weak #mon away"
	cont "from you."

	para "It's the longest"
	line "lasting of the"
	cont "Repel sprays."
	done

BlackthornMartSuperNerdText:
	text "The towns in Johto"
	line "are all named"
	cont "after plants."

	para "Did you ever"
	line "notice?"
	done
