PrintNature:
	ld bc, Natures
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push de
.loop
	ld a, [hli]
	cp "@"
	jr z, .done
	ld [de], a
	inc de
	jr .loop
.done
	pop de
	ret

Natures:
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
