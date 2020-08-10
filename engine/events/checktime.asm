CheckTime::
	ld a, [wTimeOfDay]
	ld hl, .TimeOfDayTable
	ld de, 2
	call IsInArray
	inc hl
	ld c, [hl]
	ret c

	xor a
	ld c, a
	ret

.TimeOfDayTable:
	db MORN, 1 << MORN
	db DAY,  1 << DAY
	db EVE,  1 << EVE
	db NITE, 1 << NITE
	db -1
