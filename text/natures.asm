PrintNature:
; Print nature b at hl.

	ld a, b

	push hl
	add a
	ld hl, NatureNames
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl

	jp PlaceString


NatureNames:
	dw Hardy, Lonely, Brave, Adamant, Naughty
	dw Bold, Docile, Relaxed, Impish, Lax
	dw Timid, Hasty, Serious, Jolly, Naive
	dw Modest, Mild, Quiet, Bashful, Rash
	dw Calm, Gentle, Sassy, Careful, Quirky

Hardy:   db "Hardy@"
Lonely:  db "Lonely@"
Brave:   db "Brave@"
Adamant: db "Adamant@"
Naughty: db "Naughty@"
Bold:    db "Bold@"
Docile:  db "Docile@"
Relaxed: db "Relaxed@"
Impish:  db "Impish@"
Lax:     db "Lax@"
Timid:   db "Timid@"
Hasty:   db "Hasty@"
Serious: db "Serious@"
Jolly:   db "Jolly@"
Naive:   db "Naive@"
Modest:  db "Modest@"
Mild:    db "Mild@"
Quiet:   db "Quiet@"
Bashful: db "Bashful@"
Rash:    db "Rash@"
Calm:    db "Calm@"
Gentle:  db "Gentle@"
Sassy:   db "Sassy@"
Careful: db "Careful@"
Quirky:  db "Quirky@"
