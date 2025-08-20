OlsteetonUniDormEastElevator_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  1,  3, OLSTEETON_UNI_DORM_EAST_1F, -1
	warp_event  2,  3, OLSTEETON_UNI_DORM_EAST_1F, -1

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, OlsteetonUniDormEastElevatorButton

	def_object_events

OlsteetonUniDormEastElevatorButton:
	opentext
	elevator .Floors
	closetext
	iffalse DoNothingScript
	pause 5
	playsound SFX_ELEVATOR
	earthquake 60
	waitsfx
	end


.Floors:
	db 3 ; floorsvf
	elevfloor FLOOR_1F,  6, OLSTEETON_UNI_DORM_EAST_1F
	elevfloor FLOOR_2F,  5, OLSTEETON_UNI_DORM_EAST_2F
	elevfloor FLOOR_3F,  4, OLSTEETON_UNI_DORM_EAST_3F
	; elevfloor FLOOR_4F,  2, OLSTEETON_UNI_DORM_EAST_ROOF
	db -1 ; end
