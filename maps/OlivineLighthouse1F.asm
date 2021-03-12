OlivineLighthouse1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 10, 17, OLIVINE_CITY, 8
	warp_event 11, 17, OLIVINE_CITY, 8
	warp_event  3, 11, OLIVINE_LIGHTHOUSE_2F, 1
	warp_event 16, 13, OLIVINE_LIGHTHOUSE_2F, 3
	warp_event 17, 13, OLIVINE_LIGHTHOUSE_2F, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineLighthouse1FSailorScript, -1
	object_event 16,  9, SPRITE_MATRON, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineLighthouse1FPokefanFText, -1

OlivineLighthouse1FSailorScript:
	checkevent EVENT_GOT_FULL_RESTORE_FROM_LIGHTHOUSE
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem FULL_RESTORE
	iffalse_endtext
	setevent EVENT_GOT_FULL_RESTORE_FROM_LIGHTHOUSE
	jumpthisopenedtext

.Text2:
	text "The trainers here"
	line "are all keen to"
	cont "battle."

	para "Be prepared!"
	done

.Text1:
	text "People are train-"
	line "ing hard at this"
	cont "Lighthouse."

	para "You should take"
	line "this."
	done

OlivineLighthouse1FPokefanFText:
	text "In the past, #-"
	line "mon used to light"

	para "the sea around"
	line "Olivine at night."

	para "The Lighthouse was"
	line "made in honor of"
	cont "those #mon."
	done
