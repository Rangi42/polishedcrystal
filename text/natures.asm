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


PrintNatureIndicators:
; Print indicators for nature b at hl.

	ld a, b

	push hl
	add a
	ld hl, NatureIndicators
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl

	jp PlaceString


NatureIndicators:
	dw HardyInd, LonelyInd, BraveInd, AdamantInd, NaughtyInd
	dw BoldInd, DocileInd, RelaxedInd, ImpishInd, LaxInd
	dw TimidInd, HastyInd, SeriousInd, JollyInd, NaiveInd
	dw ModestInd, MildInd, QuietInd, BashfulInd, RashInd
	dw CalmInd, GentleInd, SassyInd, CarefulInd, QuirkyInd

SassyInd:   db $4e ; fallthrough
RashInd:    db $4e ; fallthrough
ImpishInd:  db $4e ; fallthrough
LonelyInd:  db "↑", $4e, "↓@"
NaiveInd:   db $4e ; fallthrough
CarefulInd: db $4e ; fallthrough
MildInd:    db $4e ; fallthrough
BoldInd:    db "↓", $4e, "↑@"
QuietInd:   db $4e ; fallthrough
LaxInd:     db $4e ; fallthrough
AdamantInd: db "↑", $4e, $4e, "↓@"
JollyInd:   db $4e ; fallthrough
GentleInd:  db $4e ; fallthrough
ModestInd:  db "↓", $4e, $4e, "↑@"
RelaxedInd: db $4e ; fallthrough
NaughtyInd: db "↑", $4e, $4e, $4e, "↓@"
HastyInd:   db $4e ; fallthrough
CalmInd:    db "↓", $4e, $4e, $4e, "↑@"
BraveInd:   db "↑", $4e, $4e, $4e, $4e, "↓@"
TimidInd:   db "↓", $4e, $4e, $4e, $4e, "↑" ; fallthrough
HardyInd:
DocileInd:
SeriousInd:
BashfulInd:
QuirkyInd:  db "@"
