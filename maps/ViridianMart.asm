ViridianMart_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ViridianMart_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 4, VIRIDIAN_CITY
	warp_def 7, 3, 4, VIRIDIAN_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	mart_clerk_event 3, 1, MARTTYPE_STANDARD, MART_VIRIDIAN
	person_event SPRITE_LASS, 2, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b5f4, -1
	person_event SPRITE_COOLTRAINER_M, 6, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b61a, -1

UnknownText_0x9b5f4:
	text "The Gym Leader"
	line "here is totally"
	cont "cool."

	para "He's the only one"
	line "without a type"
	cont "specialty."

	para "He likes to keep"
	line "people guessing."
	done

UnknownText_0x9b61a:
	text "Have you been to"
	line "Cinnabar?"

	para "It's an island way"
	line "south of here."
	done
