RiverfrontAptElevator_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  1,  3, RIVERFRONT_APT_1F, -1
	warp_event  2,  3, RIVERFRONT_APT_1F, -1

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, RiverfrontAptElevatorButton

	def_object_events

RiverfrontAptElevatorButton:
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
	elevfloor FLOOR_1F,  6, RIVERFRONT_APT_1F
	elevfloor FLOOR_2F,  3, RIVERFRONT_APT_2F
	elevfloor FLOOR_3F,  3, RIVERFRONT_APT_3F
	elevfloor FLOOR_4F,  3, RIVERFRONT_APT_4F
	elevfloor FLOOR_5F,  3, RIVERFRONT_APT_5F
	elevfloor FLOOR_6F,  2, RIVERFRONT_APT_ROOF
	db -1 ; end
