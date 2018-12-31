CheckFacingTileForStd:: ; 1365b
; Checks to see if the tile you're facing has a std script associated with it.  If so, executes the script and returns carry.
	ld a, c
	ld de, 3
	ld hl, .table1
	call IsInArray
	jr nc, .notintable

	ld a, jumpstd_command
	ld [wJumpStdScriptBuffer], a
	inc hl
	ld a, [hli]
	ld [wJumpStdScriptBuffer + 1], a
	ld a, [hli]
	ld [wJumpStdScriptBuffer + 2], a
	ld a, BANK(.JumpStdFromRAMScript)
	ld hl, .JumpStdFromRAMScript
	call CallScript
	scf
	ret

.notintable
	xor a
	ret

.table1
	dbw COLL_BOOKSHELF,       magazinebookshelf
	dbw COLL_TRASH_CAN,       trashcan
	dbw COLL_PC,              pcscript
	dbw COLL_RADIO,           radio1
	dbw COLL_TOWN_MAP,        townmap
	dbw COLL_MART_SHELF,      merchandiseshelf
	dbw COLL_TV,              tv
	dbw COLL_POKECENTER_SIGN, pokecentersign
	dbw COLL_MART_SIGN,       martsign
	dbw COLL_VENDING_MACHINE, vendingmachine
	dbw COLL_FRIDGE,          refrigerator
	dbw COLL_SINK,            sink
	dbw COLL_WINDOW,          window
	dbw COLL_STOVE,           stove
	dbw COLL_INCENSE,         incenseburner
	dbw COLL_ELEVATOR_BUTTON, elevatorbutton
	db -1 ; end

.JumpStdFromRAMScript: ; 0x1369a
	jump wJumpStdScriptBuffer
