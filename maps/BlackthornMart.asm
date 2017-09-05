BlackthornMart_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

BlackthornMart_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 4, BLACKTHORN_CITY
	warp_def 7, 3, 4, BLACKTHORN_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 4
	mart_clerk_event 3, 1, MARTTYPE_STANDARD, MART_BLACKTHORN
	person_event SPRITE_COOLTRAINER_M, 6, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornMartCooltrainermText, -1
	person_event SPRITE_BLACK_BELT, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornMartBlackbeltText, -1
	person_event SPRITE_SUPER_NERD, 3, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornMartSuperNerdText, -1

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
