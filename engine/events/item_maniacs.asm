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
	ld [ScriptVar], a
	ld a, [CurItem]
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
	ld [hMoneyTemp + 2], a
	ld a, [hl]
	ld [hMoneyTemp + 1], a
	xor a
	ld [hMoneyTemp], a
	inc a ; ld a, TRUE
	ld [ScriptVar], a
	ret

INCLUDE "data/items/item_maniacs.asm"

Give_hMoneyTemp:
	ld de, Money
	ld bc, hMoneyTemp
	farjp GiveMoney
