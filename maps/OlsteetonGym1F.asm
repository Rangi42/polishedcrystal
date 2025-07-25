OlsteetonGym1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8, 11, OLSTEETON, 5
	warp_event  9, 11, OLSTEETON, 5
	warp_event  0,  2, OLSTEETON_GYM_2F, 1

	def_coord_events

	def_bg_events
	bg_event 11, 11, BGEVENT_READ, OlsteetonGymStatue
	bg_event  6, 11, BGEVENT_READ, OlsteetonGymStatue

	def_object_events
	object_event  7, 10, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 1, OlsteetonGymGuyScript, -1

OlsteetonGymGuyScript:
	jumptextfaceplayer OlsteetonGymGuyText

OlsteetonGymStatue:
    text "UNDER CONSTRUCTION"
    line "COME BACK LATER"
	done
OlsteetonGymGuyText:
	text "Yo! Champ in"
	line "making! You've"

	para "got a steely"
	line "demeanor, but the"

	para "Gym isn't open"
	line "just yet."

	para "Rusty and his crew"
	line "are nearly"
    cont "finished!"
	done

