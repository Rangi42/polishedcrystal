CeladonDeptStoreElevator_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 3, 1, -1, CELADON_DEPT_STORE_1F
	warp_def 3, 2, -1, CELADON_DEPT_STORE_1F

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 0, 3, SIGNPOST_READ, CeladonDeptStoreElevatorButton

	db 0 ; person events

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
