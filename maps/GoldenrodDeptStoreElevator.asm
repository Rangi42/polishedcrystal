GoldenrodDeptStoreElevator_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  1,  3, GOLDENROD_DEPT_STORE_1F, -1
	warp_event  2,  3, GOLDENROD_DEPT_STORE_1F, -1

	db 0 ; coord events

	db 1 ; bg events
	bg_event  3,  0, SIGNPOST_READ, GoldenrodDeptStoreElevatorButton

	db 0 ; object events

GoldenrodDeptStoreElevatorButton:
	opentext
	elevator .Floors
	closetext
	iffalse .Done
	pause 5
	playsound SFX_ELEVATOR
	earthquake 60
	waitsfx
	checkevent EVENT_WAREHOUSE_BLOCKED_OFF
	iftrue .Done
	checkevent EVENT_WAREHOUSE_LAYOUT_1
	iftrue .BoxLayout1
	checkevent EVENT_WAREHOUSE_LAYOUT_2
	iftrue .BoxLayout2
	setevent EVENT_WAREHOUSE_LAYOUT_1
	clearevent EVENT_WAREHOUSE_LAYOUT_2
	clearevent EVENT_WAREHOUSE_LAYOUT_3
	end

.BoxLayout1:
	clearevent EVENT_WAREHOUSE_LAYOUT_1
	setevent EVENT_WAREHOUSE_LAYOUT_2
	clearevent EVENT_WAREHOUSE_LAYOUT_3
	end

.BoxLayout2:
	clearevent EVENT_WAREHOUSE_LAYOUT_1
	clearevent EVENT_WAREHOUSE_LAYOUT_2
	setevent EVENT_WAREHOUSE_LAYOUT_3
.Done:
	end

.Floors:
	db 7 ; floors
	elevfloor _B1F, 2, GOLDENROD_DEPT_STORE_B1F
	elevfloor _1F,  4, GOLDENROD_DEPT_STORE_1F
	elevfloor _2F,  3, GOLDENROD_DEPT_STORE_2F
	elevfloor _3F,  3, GOLDENROD_DEPT_STORE_3F
	elevfloor _4F,  3, GOLDENROD_DEPT_STORE_4F
	elevfloor _5F,  3, GOLDENROD_DEPT_STORE_5F
	elevfloor _6F,  2, GOLDENROD_DEPT_STORE_6F
	db -1 ; end
