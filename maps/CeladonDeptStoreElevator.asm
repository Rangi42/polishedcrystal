CeladonDeptStoreElevator_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  1,  3, CELADON_DEPT_STORE_1F, -1
	warp_event  2,  3, CELADON_DEPT_STORE_1F, -1

	db 0 ; coord events

	db 1 ; bg events
	bg_event  3,  0, SIGNPOST_READ, CeladonDeptStoreElevatorButton

	db 0 ; object events

CeladonDeptStoreElevatorButton:
	opentext
	elevator .Floors
	closetext
	iffalse .Done
	pause 5
	playsound SFX_ELEVATOR
	earthquake 60
	waitsfx
.Done:
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
