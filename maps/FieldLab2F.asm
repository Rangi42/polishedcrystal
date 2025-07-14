FieldLab2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  3, ECHOING_CAVE, 2
	warp_event  8,  7, FIELD_LAB, 2

	def_coord_events

	def_bg_events
	bg_event  7,  5, BGEVENT_ITEM + STAR_PIECE, EVENT_MOUNT_MOON_B1F_HIDDEN_STAR_PIECE
	bg_event  3,  4, BGEVENT_ITEM + MOON_STONE, EVENT_MOUNT_MOON_B1F_HIDDEN_MOON_STONE

	def_object_events
	; object_event  5,  7, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, OBJECTTYPE_COMMAND, jumptextfaceplayer, FieldLabAideText, -1

FieldLabAideText:
	text "I'm using LIDAR"
	line "to create a 3D"
	cont "model of this"

	para "cave system!"
	line "It will help to"

	para "expand our under-"
	line "standing of cave"
	cont "dwelling #mon."

	done
