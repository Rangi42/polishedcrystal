GetGourmetManiacPrice:
	ld hl, GourmetManiacItemRewards
	jr GetItemManiacPrice

GetOreManiacPrice:
	ld hl, OreManiacItemRewards
	jr GetItemManiacPrice

GetFossilManiacPrice:
	ld hl, FossilManiacItemRewards
GetItemManiacPrice:
	xor a ; ld a, FALSE
	ldh [hScriptVar], a
	ld a, [wCurItem]
	ld b, a
.loop
	ld a, [hli]
	cp -1
	ret z
	cp b
	jr z, .found
	inc hl
	inc hl
	jr .loop
.found
	ld a, [hli]
	ldh [hMoneyTemp + 2], a
	ld a, [hl]
	ldh [hMoneyTemp + 1], a
	xor a
	ldh [hMoneyTemp], a
	inc a ; ld a, TRUE
	ldh [hScriptVar], a
	ret

INCLUDE "data/items/item_maniacs.asm"

Give_hMoneyTemp:
	ld de, wMoney
	ld bc, hMoneyTemp
	farjp GiveMoney
