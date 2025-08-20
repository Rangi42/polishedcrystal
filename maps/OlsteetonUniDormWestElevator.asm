OlsteetonUniDormWestElevator_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  1,  3, OLSTEETON_UNI_DORM_WEST_1F, -1
	warp_event  2,  3, OLSTEETON_UNI_DORM_WEST_1F, -1

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, OlsteetonUniDormWestElevatorButton

	def_object_events

OlsteetonUniDormWestElevatorButton:
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
	db 6 ; floors
	elevfloor FLOOR_1F,  6, OLSTEETON_UNI_DORM_WEST_1F
	elevfloor FLOOR_2F,  5, OLSTEETON_UNI_DORM_WEST_2F
	elevfloor FLOOR_3F,  4, OLSTEETON_UNI_DORM_WEST_3F
	; elevfloor FLOOR_6F,  2, OLSTEETON_UNI_DORM_WEST_ROOF
	db -1 ; end
