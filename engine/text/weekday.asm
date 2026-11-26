_PrintDayOfWeek::
	push hl
	push bc
	ld c, a
	ld b, 0
	ld hl, .Days
	add hl, bc
	ld c, [hl]
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	rst PlaceString
	ld h, b
	ld l, c
	ld de, .Day
	rst PlaceString
	pop hl
	ret

.Days:
	dr .Sun
	dr .Mon
	dr .Tues
	dr .Wednes
	dr .Thurs
	dr .Fri
	dr .Satur

.Sun:    db "Sun@"
.Mon:    db "Mon@"
.Tues:   db "Tues@"
.Wednes: db "Wednes@"
.Thurs:  db "Thurs@"
.Fri:    db "Fri@"
.Satur:  db "Satur@"
.Day:    db "day@"
