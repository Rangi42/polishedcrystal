CeladonDeptStoreElevator_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonDeptStoreElevator_MapEventHeader:

.Warps: db 2
	warp_def 3, 1, -1, CELADON_DEPT_STORE_1F
	warp_def 3, 2, -1, CELADON_DEPT_STORE_1F

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 3, SIGNPOST_READ, CeladonDeptStoreElevatorButton

.PersonEvents: db 0

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
