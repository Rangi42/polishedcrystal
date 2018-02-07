GetPlayerIcon: ; 8832c
; Get the player icon corresponding to gender

; Male
	ld de, ChrisSpriteGFX
	ld b, BANK(ChrisSpriteGFX)

	ld a, [PlayerGender]
	bit 0, a
	ret z

; Female
	ld de, KrisSpriteGFX
	ld b, BANK(KrisSpriteGFX)
	ret


GetCardPic: ; 8833e
	ld hl, ChrisCardPic
	ld a, [PlayerGender]
	bit 0, a
	jr z, .GotClass
	ld hl, KrisCardPic
.GotClass:
	ld de, VTiles2 tile $00
	ld bc, $23 tiles
	ld a, BANK(ChrisCardPic) ; BANK(KrisCardPic)
	jp FarCopyBytes

ChrisCardPic: ; 88365
INCBIN "gfx/trainer_card/chris_card.5x7.2bpp"

KrisCardPic: ; 88595
INCBIN "gfx/trainer_card/kris_card.5x7.2bpp"


GetPlayerBackpic: ; 88825
	ld hl, ChrisBackpic
	ld a, [PlayerGender]
	bit 0, a
	jr z, .ok
	ld hl, KrisBackpic
.ok
	ld de, VTiles2 tile $31
	lb bc, BANK(ChrisBackpic), 6 * 6 ; dimensions
	predef DecompressPredef
	ret

ChrisBackpic: ; 2ba1a
INCBIN "gfx/player/chris_back.6x6.2bpp.lz"

KrisBackpic: ; 88ed6
INCBIN "gfx/player/kris_back.6x6.2bpp.lz"

LyraBackpic: ; 2bbaa
INCBIN "gfx/battle/lyra_back.6x6.2bpp.lz"


HOF_LoadTrainerFrontpic: ; 88840
	call WaitBGMap
	xor a
	ld [hBGMapMode], a
	ld e, 0
	ld a, [PlayerGender]
	bit 0, a
	jr z, .GotClass
	ld e, 1

.GotClass:
	ld a, e
	ld [TrainerClass], a
	ld de, ChrisCardPic
	ld a, [PlayerGender]
	bit 0, a
	jr z, .GotPic
	ld de, KrisCardPic

.GotPic:
	ld hl, VTiles2
	lb bc, BANK(ChrisCardPic), 5 * 7 ; BANK(KrisCardPic)
	call Get2bpp
	call WaitBGMap
	ld a, $1
	ld [hBGMapMode], a
	ret
