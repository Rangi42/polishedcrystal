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

	ld hl, ChrisSpriteGFX
	ld b, BANK(ChrisSpriteGFX)
	and a ; PLAYER_MALE
	ret z

	ld hl, KrisSpriteGFX
	ld b, BANK(KrisSpriteGFX)
	dec a ; PLAYER_FEMALE
	ret z

	; PLAYER_ENBY
	ld hl, CrysSpriteGFX
	ld b, BANK(CrysSpriteGFX)
	ret

GetCardPic:
	ld a, [wPlayerGender]
	ld hl, ChrisCardPic
	and a ; PLAYER_MALE
	jr z, .ok
	ld hl, KrisCardPic
	dec a ; PLAYER_FEMALE
	jr z, .ok
	; PLAYER_ENBY
	ld hl, CrysCardPic
.ok
	ld de, vTiles2 tile $00
	lb bc, BANK("Trainer Card Pics"), 5 * 7
	jmp DecompressRequest2bpp

GetPlayerBackpic:
	ld a, [wPlayerGender]
	ld hl, ChrisBackpic
	and a ; PLAYER_MALE
	jr z, .ok
	ld hl, KrisBackpic
	dec a ; PLAYER_FEMALE
	jr z, .ok
	; PLAYER_ENBY
	ld hl, CrysBackpic
.ok
	ld de, vTiles2 tile $31
	lb bc, BANK("Trainer Backpics"), 6 * 6
	jmp DecompressRequest2bpp

HOF_LoadTrainerFrontpic:
	call ApplyTilemapInVBlank
	xor a
	ldh [hBGMapMode], a
	ld a, [wPlayerGender]
	ld e, CHRIS
	and a ; PLAYER_MALE
	jr z, .ok
	assert CHRIS - 1 == KRIS
	dec e
	dec a ; PLAYER_FEMALE
	jr z, .ok
	; PLAYER_ENBY
	ld e, CRYS
.ok
	ld a, e
	ld [wTrainerClass], a
	call GetCardPic
	call ApplyTilemapInVBlank
	ld a, $1
	ldh [hBGMapMode], a
	ret
