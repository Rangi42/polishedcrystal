GetPlayerIcon:
; Get the player icon corresponding to gender
	push hl
	call _GetPlayerIcon
	call FarDecompressWRA6InB
	pop hl
	ld de, wDecompressScratch
	ret

_GetPlayerIcon:
; Male
	ld hl, ChrisSpriteGFX
	ld b, BANK(ChrisSpriteGFX)

	ld a, [wPlayerGender]
	bit 0, a
	ret z

; Female
	ld hl, KrisSpriteGFX
	ld b, BANK(KrisSpriteGFX)
	ret

GetCardPic:
	ld hl, ChrisCardPic
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .ok
	ld hl, KrisCardPic
.ok
	ld de, vTiles2 tile $00
	lb bc, BANK("Trainer Card Pics"), 5 * 7
	jmp DecompressRequest2bpp

GetPlayerBackpic:
	ld hl, ChrisBackpic
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .ok
	ld hl, KrisBackpic
.ok
	ld de, vTiles2 tile $31
	lb bc, BANK("Trainer Backpics"), 6 * 6
	jmp DecompressRequest2bpp

HOF_LoadTrainerFrontpic:
	call ApplyTilemapInVBlank
	xor a
	ldh [hBGMapMode], a
	ld e, CHRIS
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .ok
	ld e, KRIS
.ok
	ld a, e
	ld [wTrainerClass], a
	call GetCardPic
	call ApplyTilemapInVBlank
	ld a, $1
	ldh [hBGMapMode], a
	ret
