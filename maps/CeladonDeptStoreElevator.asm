CeladonDeptStoreElevator_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  1,  3, CELADON_DEPT_STORE_1F, -1
	warp_event  2,  3, CELADON_DEPT_STORE_1F, -1

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, CeladonDeptStoreElevatorButton

	def_object_events

CeladonDeptStoreElevatorButton:
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
	elevfloor _1F, 4, CELADON_DEPT_STORE_1F
	elevfloor _2F, 3, CELADON_DEPT_STORE_2F
	elevfloor _3F, 3, CELADON_DEPT_STORE_3F
	elevfloor _4F, 3, CELADON_DEPT_STORE_4F
	elevfloor _5F, 3, CELADON_DEPT_STORE_5F
	elevfloor _6F, 2, CELADON_DEPT_STORE_6F
	db -1 ; end
