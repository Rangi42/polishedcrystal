GetPlayerIcon:
; Get the player icon corresponding to gender
	push hl
	call _GetPlayerIcon
	call FarDecompressWRA6InB
	pop hl
	ld de, wDecompressScratch
	ret

_GetPlayerIcon:
	ld a, [wPlayerGender]
	ld b, a
	add a ; * 2
	add b ; * 3
	add LOW(PlayerSpritePointers)
	ld l, a
	adc HIGH(PlayerSpritePointers)
	sub l
	ld h, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

GetCardPic:
	ld a, [wPlayerGender]
	add a
	add LOW(PlayerCardPicPointers)
	ld l, a
	adc HIGH(PlayerCardPicPointers)
	sub l
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, vTiles2 tile $00
	lb bc, BANK("Trainer Card Pics"), 5 * 7
	jmp DecompressRequest2bpp

GetPlayerBackpic:
	ld a, [wPlayerGender]
	add a
	add LOW(PlayerBackpicPointers)
	ld l, a
	adc HIGH(PlayerBackpicPointers)
	sub l
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, vTiles2 tile $31
	lb bc, BANK("Trainer Backpics"), 6 * 6
	jmp DecompressRequest2bpp

HOF_LoadTrainerFrontpic:
	call ApplyTilemapInVBlank
	xor a
	ldh [hBGMapMode], a
	ld a, [wPlayerGender]
	assert PLAYER_MALE + 1 == CHRIS
	assert PLAYER_FEMALE + 1 == KRIS
	assert PLAYER_ENBY + 1 == CRYS
	assert PLAYER_BETA + 1 == BETA
	inc a
	ld [wTrainerClass], a
	call GetCardPic
	call ApplyTilemapInVBlank
	ld a, $1
	ldh [hBGMapMode], a
	ret

INCLUDE "data/player/graphics.asm"
