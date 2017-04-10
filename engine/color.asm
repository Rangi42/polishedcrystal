INCLUDE "engine/cgb.asm"

CheckShininess:
; Check if a mon is shiny by personality at bc.
; Return carry if shiny.

	ld a, [bc]
	and SHINY_MASK
	jr z, .NotShiny

	scf
	ret

.NotShiny:
	and a
	ret

InitPokegearPalettes:
; This is needed because the regular palette is dark at night.
	call InitPartyMenuOBPals
	ret

InitPartyMenuPalettes:
	ld hl, PalPacket_9c56 + 1
	call CopyFourPalettes
	call InitPartyMenuOBPals
	call WipeAttrMap
	ret

ApplyHPBarPals:
	ld a, [wWhichHPBar]
	and a
	jr z, .Enemy
	cp $1
	jr z, .Player
	cp $2
	jr z, .PartyMenu
	ret

.Enemy:
	ld de, BGPals + 2 palettes + 2
	jr .okay

.Player:
	ld de, BGPals + 3 palettes + 2

.okay
	ld l, c
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, Palettes_a8be
	add hl, bc
	ld bc, 4
	ld a, $5
	call FarCopyWRAM
	ld a, $1
	ld [hCGBPalUpdate], a
	ret

.PartyMenu:
	ld e, c
	inc e
	hlcoord 11, 1, AttrMap
	ld bc, 2 * SCREEN_WIDTH
	ld a, [CurPartyMon]
.loop
	and a
	jr z, .done
	add hl, bc
	dec a
	jr .loop

.done
	lb bc, 2, 8
	ld a, e
	call FillBoxCGB
	ret

LoadStatsScreenPals:
	ld hl, StatsScreenPals
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld a, [hli]
	ld [UnknBGPals], a
	ld [UnknBGPals + 2 palettes], a
	ld a, [hl]
	ld [UnknBGPals + 1], a
	ld [UnknBGPals + 2 palettes + 1], a
	pop af
	ld [rSVBK], a
	call ApplyPals
	ld a, $1
	ret

LoadMailPalettes:
	ld l, e
	ld h, 0
rept 3
	add hl, hl
endr
	ld de, .MailPals
	add hl, de
	ld de, UnknBGPals
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	call ApplyPals
	call WipeAttrMap
	call ApplyAttrMap
	ret

.MailPals:
	RGB 20, 31, 11
	RGB 31, 19, 00
	RGB 31, 10, 09
	RGB 00, 00, 00

	RGB 15, 20, 31
	RGB 30, 26, 00
	RGB 31, 12, 00
	RGB 00, 00, 00

	RGB 24, 17, 31
	RGB 30, 26, 00
	RGB 08, 11, 31
	RGB 00, 00, 00

	RGB 31, 25, 17
	RGB 31, 18, 04
	RGB 28, 12, 05
	RGB 00, 00, 00

	RGB 19, 26, 31
	RGB 31, 05, 08
	RGB 31, 09, 31
	RGB 00, 00, 00

	RGB 31, 19, 28
	RGB 31, 21, 00
	RGB 12, 22, 00
	RGB 00, 00, 00

	RGB 19, 17, 23
	RGB 30, 26, 00
	RGB 31, 12, 00
	RGB 00, 00, 00

	RGB 07, 26, 31
	RGB 26, 26, 27
	RGB 31, 11, 11
	RGB 00, 00, 00

	RGB 21, 31, 21
	RGB 30, 26, 00
	RGB 31, 12, 00
	RGB 00, 00, 00

	RGB 07, 26, 31
	RGB 31, 31, 00
	RGB 00, 21, 00
	RGB 00, 00, 00

CopyFourPalettes:
	ld de, UnknBGPals
	ld c, $4

CopyPalettes:
.loop
	push bc
	ld a, [hli]
	push hl
	call GetPredefPal
	call LoadHLPaletteIntoDE
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
	ret

GetPredefPal:
	ld l, a
	ld h, $0
rept 3 ; multiply by 8
	add hl, hl
endr
	ld bc, Palettes_9df6
	add hl, bc
	ret

LoadHLPaletteIntoDE:
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld c, $8
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	pop af
	ld [rSVBK], a
	ret

LoadPalette_White_Col1_Col2_Black:
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a

	ld a, $7fff % $100 ; (RGB 31, 31, 31) % $100
	ld [de], a
	inc de
	ld a, $7fff / $100 ; (RGB 31, 31, 31) / $100
	ld [de], a
	inc de

	ld c, 2 * 2
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop

	xor a ; RGB 00, 00, 00
rept 2
	ld [de], a
	inc de
endr

	pop af
	ld [rSVBK], a
	ret

FillBoxCGB:
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

ResetBGPals:
	push af
	push bc
	push de
	push hl

	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a

	ld hl, UnknBGPals
	ld c, 8
.loop
	ld a, $ff
rept 4
	ld [hli], a
endr
	xor a
rept 4
	ld [hli], a
endr
	dec c
	jr nz, .loop

	pop af
	ld [rSVBK], a

	pop hl
	pop de
	pop bc
	pop af
	ret

WipeAttrMap:
	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	ret

ApplyPals:
	ld hl, UnknBGPals
	ld de, BGPals
	ld bc, 16 palettes
	ld a, $5
	call FarCopyWRAM
	ret

ApplyAttrMap:
	ld a, [rLCDC]
	bit 7, a
	jr z, .UpdateVBank1
	ld a, [hBGMapMode]
	push af
	ld a, $2
	ld [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	call DelayFrame
	pop af
	ld [hBGMapMode], a
	ret

.UpdateVBank1:
	hlcoord 0, 0, AttrMap
	debgcoord 0, 0
	ld b, SCREEN_HEIGHT
	ld a, $1
	ld [rVBK], a
.row
	ld c, SCREEN_WIDTH
.col
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .col
	ld a, BG_MAP_WIDTH - SCREEN_WIDTH
	add e
	jr nc, .okay
	inc d
.okay
	ld e, a
	dec b
	jr nz, .row
	xor a
	ld [rVBK], a
	ret

ApplyPartyMenuHPPals: ; 96f3
	ld hl, wHPPals
	ld a, [wSGBPals]
	ld e, a
	ld d, $0
	add hl, de
	ld e, l
	ld d, h
	ld a, [de]
	inc a
	ld e, a
	hlcoord 11, 2, AttrMap
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wSGBPals]
.loop
	and a
	jr z, .done
	add hl, bc
	dec a
	jr .loop
.done
	lb bc, 2, 8
	ld a, e
	call FillBoxCGB
	ret

InitPartyMenuOBPals:
	ld hl, Palettes_b681
	ld de, UnknOBPals
	ld bc, 2 palettes
	ld a, $5
	call FarCopyWRAM
	ret

GetBattlemonBackpicPalettePointer:
	push de
	farcall GetPartyMonPersonality
	ld c, l
	ld b, h
	ld a, [TempBattleMonSpecies]
	call GetPlayerOrMonPalettePointer
	pop de
	ret

GetEnemyFrontpicPalettePointer:
	ld a, [TempEnemyMonSpecies]
	cp MEWTWO
	jr nz, .not_armored_mewtwo
	ld a, [wBattleMode]
	cp 2
	jr nz, .not_armored_mewtwo
	ld a, [OtherTrainerClass]
	cp GIOVANNI
	jr nz, .not_armored_mewtwo
	ld hl, MewtwoArmoredPalette
	ret
.not_armored_mewtwo
	push de
	farcall GetEnemyMonPersonality
	ld c, l
	ld b, h
	ld a, [TempEnemyMonSpecies]
	call GetFrontpicPalettePointer
	pop de
	ret

GetPlayerOrMonPalettePointer:
	and a
	jp nz, GetMonNormalOrShinyPalettePointer
	ld a, [wPlayerSpriteSetupFlags]
	bit 2, a ; transformed to male
	jr nz, .male
	ld a, [PlayerGender]
	and a
	jr z, .male
	ld a, [BattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .lyra
	ld hl, KrisPalette
	ret

.male
	ld hl, PlayerPalette
	ret

.lyra
	ld hl, Lyra1Palette
	ret

GetFrontpicPalettePointer:
	and a
	jp nz, GetMonNormalOrShinyPalettePointer
	ld a, [TrainerClass]

GetTrainerPalettePointer:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld bc, TrainerPalettes
	add hl, bc
	ret

GetMonPalettePointer_:
	call GetMonPalettePointer
	ret

Palettes_979c:
	RGB 31, 31, 31
	RGB 25, 25, 25
	RGB 13, 13, 13
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 31, 07
	RGB 31, 16, 01
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 19, 24
	RGB 30, 10, 06
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 12, 25, 01
	RGB 05, 14, 00
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 08, 12, 31
	RGB 01, 04, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 24, 18, 07
	RGB 20, 15, 03
	RGB 00, 00, 00

GetMonPalettePointer:
	ld l, a
	ld h, $0
rept 3
	add hl, hl
endr
	ld bc, PokemonPalettes
	add hl, bc
	ret

GetMonNormalOrShinyPalettePointer:
	push bc
	call GetMonPalettePointer
	pop bc
	push hl
	call CheckShininess
	pop hl
	ret nc
rept 4
	inc hl
endr
	ret

LoadPokemonPalette:
	; a = species
	ld a, [CurPartySpecies]
	; hl = palette
	call GetMonPalettePointer
	; load palette in BG 7
	ld a, $5
	ld de, UnknBGPals + 7 palettes + 2
	ld bc, 4
	call FarCopyWRAM
	ret

LoadPartyMonPalette:
	; bc = personality
	ld hl, PartyMon1Personality
	ld a, [CurPartyMon]
	call GetPartyLocation
	ld c, l
	ld b, h
	; a = species
	ld a, [CurPartySpecies]
	; hl = palette
	call GetMonNormalOrShinyPalettePointer
	; load palette in BG 7
	ld a, $5
	ld de, UnknBGPals + 7 palettes + 2
	ld bc, 4
	call FarCopyWRAM
	ret

InitCGBPals::
	ld a, $1
	ld [rVBK], a
	ld hl, VTiles0
	ld bc, $200 tiles
	xor a
	call ByteFill
	xor a
	ld [rVBK], a
	ld a, $80
	ld [rBGPI], a
	ld c, 4 * 8
.bgpals_loop
	ld a, $7fff % $100
	ld [rBGPD], a
	ld a, $7fff / $100
	ld [rBGPD], a
	dec c
	jr nz, .bgpals_loop
	ld a, $80
	ld [rOBPI], a
	ld c, 4 * 8
.obpals_loop
	ld a, $7fff % $100
	ld [rOBPD], a
	ld a, $7fff / $100
	ld [rOBPD], a
	dec c
	jr nz, .obpals_loop
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld hl, UnknBGPals
	call .LoadWhitePals
	ld hl, BGPals
	call .LoadWhitePals
	pop af
	ld [rSVBK], a
	ret

.LoadWhitePals:
	ld c, 4 * 16
.loop
	ld a, $7fff % $100
	ld [hli], a
	ld a, $7fff / $100
	ld [hli], a
	dec c
	jr nz, .loop
	ret

CopyData: ; 0x9a52
; copy bc bytes of data from hl to de
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, CopyData
	ret
; 0x9a5b

ClearBytes: ; 0x9a5b
; clear bc bytes of data starting from de
	xor a
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, ClearBytes
	ret
; 0x9a64

DrawDefaultTiles: ; 0x9a64
; Draw 240 tiles (2/3 of the screen) from tiles in VRAM
	hlbgcoord 0, 0 ; BG Map 0
	ld de, BG_MAP_WIDTH - SCREEN_WIDTH
	ld a, $80 ; starting tile
	ld c, 12 + 1
.line
	ld b, 20
.tile
	ld [hli], a
	inc a
	dec b
	jr nz, .tile
; next line
	add hl, de
	dec c
	jr nz, .line
	ret
; 0x9a7a

BlkPacket_9a86:
	db $21, $01, $03, $00, $00, $00, $13, $11, $00, $00, $00, $00, $00, $00, $00, $00

BlkPacket_9a96:
	db $21, $01, $07, $05, $00, $0a, $13, $0d, $00, $00, $00, $00, $00, $00, $00, $00

BlkPacket_9aa6:
	db $22, $05, $07, $0a, $00, $0c, $13, $11, $03, $05, $01, $00, $0a, $03, $03, $00
	db $0a, $08, $13, $0a, $03, $0a, $00, $04, $08, $0b, $03, $0f, $0b, $00, $13, $07

BlkPacket_9ac6:
	db $21, $01, $07, $05, $00, $01, $07, $07, $00, $00, $00, $00, $00, $00, $00, $00

BlkPacket_9ad6:
	db $21, $01, $07, $05, $0b, $01, $13, $02, $00, $00, $00, $00, $00, $00, $00, $00

BlkPacket_9ae6:
	db $21, $01, $07, $05, $01, $01, $08, $08, $00, $00, $00, $00, $00, $00, $00, $00

BlkPacket_9af6:
	db $21, $01, $07, $05, $07, $05, $0d, $0b, $00, $00, $00, $00, $00, $00, $00, $00

BlkPacket_9b06:
	db $22, $05, $03, $05, $00, $00, $13, $0b, $03, $0a, $00, $04, $13, $09, $02, $0f
	db $00, $06, $13, $07, $03, $00, $04, $04, $0f, $09, $03, $00, $00, $0c, $13, $11

BlkPacket_9b26:
	db $23, $07, $07, $10, $00, $00, $02, $0c, $02, $00, $0c, $00, $12, $01, $02, $00
	db $0c, $02, $12, $03, $02, $00, $0c, $04, $12, $05, $02, $00, $0c, $06, $12, $07
	db $02, $00, $0c, $08, $12, $09, $02, $00, $0c, $0a, $12, $0b, $00, $00, $00, $00

BlkPacket_9b56:
	db $22, $03, $07, $20, $00, $00, $13, $04, $03, $0f, $00, $06, $13, $11, $03, $05
	db $0f, $01, $12, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

BlkPacket_9b76:
	db $21, $01, $07, $10, $00, $00, $13, $05, $00, $00, $00, $00, $00, $00, $00, $00

BlkPacket_9b86:
	db $21, $02, $07, $0a, $00, $04, $13, $0d, $03, $05, $00, $06, $13, $0b, $00, $00

PalPacket_9b96:	db $51, $48, $00, $49, $00, $4a, $00, $4b, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9ba6:	db $51, $2b, $00, $24, $00, $20, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9bb6:	db $51, $41, $00, $42, $00, $43, $00, $44, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9bc6:	db $51, $4c, $00, $4c, $00, $4c, $00, $4c, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9bd6:	db $51, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9be6:	db $51, $36, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9bf6:	db $51, $37, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9c06:	db $51, $38, $00, $39, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9c16:	db $51, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9c26:	db $51, $3b, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9c36:	db $51, $3c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9c46:	db $51, $39, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9c56:	db $51, $2e, $00, $2f, $00, $30, $00, $31, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9c66:	db $51, $1a, $00, $1a, $00, $1a, $00, $1a, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9c76:	db $51, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9c86:	db $51, $3c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9c96:	db $51, $3d, $00, $3e, $00, $3f, $00, $40, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9ca6:	db $51, $33, $00, $34, $00, $1b, $00, $1f, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9cb6:	db $51, $1b, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9cc6:	db $51, $1c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9cd6:	db $51, $35, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9ce6:	db $01, $ff, $7f, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9cf6:	db $09, $ff, $7f, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9d06:	db $59, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9d16:	db $89, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9d26:	db $89, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9d36:	db $99, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9d46:	db $a1, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9d56:	db $b9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9d66:	db $b9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PalPacket_9d76:	db $79, $5d, $08, $00, $0b, $8c, $d0, $f4, $60, $00, $00, $00, $00, $00, $00, $00
PalPacket_9d86:	db $79, $52, $08, $00, $0b, $a9, $e7, $9f, $01, $c0, $7e, $e8, $e8, $e8, $e8, $e0
PalPacket_9d96:	db $79, $47, $08, $00, $0b, $c4, $d0, $16, $a5, $cb, $c9, $05, $d0, $10, $a2, $28
PalPacket_9da6:	db $79, $3c, $08, $00, $0b, $f0, $12, $a5, $c9, $c9, $c8, $d0, $1c, $a5, $ca, $c9
PalPacket_9db6:	db $79, $31, $08, $00, $0b, $0c, $a5, $ca, $c9, $7e, $d0, $06, $a5, $cb, $c9, $7e
PalPacket_9dc6:	db $79, $26, $08, $00, $0b, $39, $cd, $48, $0c, $d0, $34, $a5, $c9, $c9, $80, $d0
PalPacket_9dd6:	db $79, $1b, $08, $00, $0b, $ea, $ea, $ea, $ea, $ea, $a9, $01, $cd, $4f, $0c, $d0
PalPacket_9de6:	db $79, $10, $08, $00, $0b, $4c, $20, $08, $ea, $ea, $ea, $ea, $ea, $60, $ea, $ea

Palettes_9df6:
	RGB 31, 31, 31
	RGB 22, 25, 19
	RGB 16, 21, 30
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 27, 28, 31
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 24, 28, 19
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 24, 24, 24
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 21, 23, 31
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 24, 21, 27
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 24, 16
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 25, 30, 26
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 25, 31
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 20, 19
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 26, 19
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 27, 28, 27
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 24, 30, 23
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 29, 24, 29
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 26, 23, 29
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 25, 23, 20
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 29, 26, 18
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 21, 18
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 26, 25, 31
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 22, 21, 31
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 22, 25, 21
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 21, 21, 22
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 20, 20
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 26, 26, 26
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 21, 14, 09
	RGB 15, 20, 20
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 12, 28, 22
	RGB 15, 20, 20
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 07, 07, 07
	RGB 02, 03, 03
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 30, 22, 17
	RGB 16, 14, 19
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 18, 20, 27
	RGB 11, 15, 23
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 20, 10
	RGB 26, 10, 06
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 21, 25, 29
	RGB 14, 19, 25
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 27, 22, 24
	RGB 21, 15, 23
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 28, 20, 15
	RGB 21, 14, 09
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 20, 26, 16
	RGB 09, 20, 11
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 30, 22, 24
	RGB 28, 15, 21
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 28, 14
	RGB 26, 20, 00
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 26, 21, 22
	RGB 15, 15, 18
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 23, 19, 13
	RGB 14, 12, 17
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 16, 18, 21
	RGB 10, 12, 18
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 22, 15, 16
	RGB 17, 02, 05
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 15, 20, 20
	RGB 05, 16, 16
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 23, 15, 19
	RGB 14, 04, 12
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 20, 17, 18
	RGB 18, 13, 11
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 23, 21, 16
	RGB 12, 12, 10
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 21, 25, 29
	RGB 30, 22, 24
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 26, 23, 16
	RGB 29, 14, 09
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 18, 18, 18
	RGB 10, 10, 10
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 25, 02
	RGB 00, 23, 00
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 25, 02
	RGB 31, 23, 00
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 25, 02
	RGB 31, 00, 00
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 29, 26, 19
	RGB 27, 20, 14
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 24, 20, 10
	RGB 21, 00, 04
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 20, 10
	RGB 21, 00, 04
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 30, 26, 16
	RGB 16, 12, 09
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 15, 28, 26
	RGB 12, 22, 26
	RGB 03, 16, 14

	RGB 31, 31, 31
	RGB 15, 28, 26
	RGB 23, 24, 24
	RGB 00, 00, 00

	RGB 31, 31, 24
	RGB 07, 27, 19
	RGB 26, 20, 10
	RGB 19, 12, 08

	RGB 31, 31, 31
	RGB 31, 28, 14
	RGB 31, 13, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 16, 18, 21
	RGB 10, 12, 18
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 23, 21, 16
	RGB 12, 12, 10
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 14, 00
	RGB 07, 11, 15
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 26, 21, 22
	RGB 26, 10, 06
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 30, 27, 04
	RGB 24, 20, 11
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 13, 25
	RGB 24, 20, 11
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 16, 19, 29
	RGB 24, 20, 11
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 30, 22, 24
	RGB 18, 18, 18
	RGB 16, 10, 07

	RGB 31, 31, 31
	RGB 21, 25, 29
	RGB 18, 18, 18
	RGB 16, 10, 07

	RGB 31, 31, 31
	RGB 20, 26, 16
	RGB 18, 18, 18
	RGB 16, 10, 07

	RGB 31, 31, 31
	RGB 31, 28, 14
	RGB 18, 18, 18
	RGB 16, 10, 07

	RGB 31, 31, 31
	RGB 18, 18, 18
	RGB 26, 10, 06
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 30, 22, 24
	RGB 28, 15, 21
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 26, 20, 00
	RGB 16, 19, 29
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 16, 02, 30
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 16, 13, 04
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 28, 04, 02
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 18, 23, 31
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 24, 20, 11
	RGB 18, 13, 11
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 25, 30, 00
	RGB 25, 30, 00

	RGB 00, 00, 00
	RGB 08, 11, 11
	RGB 21, 21, 21
	RGB 31, 31, 31

Palettes_a8be:
	RGB 31, 25, 02
	RGB 00, 23, 00

	RGB 31, 25, 02
	RGB 31, 21, 00

	RGB 31, 25, 02
	RGB 31, 00, 00

Palettes_a8ca:
	RGB 31, 25, 02
	RGB 04, 17, 31

GenderAndExpPalettes:
	RGB 31, 12, 06
	RGB 04, 17, 31

INCLUDE "gfx/pics/palette_pointers.asm"

INCLUDE "gfx/trainers/palette_pointers.asm"

LoadMapPals:
	farcall LoadSpecialMapPalette
	jr c, .got_pals

	; Which palette group is based on whether we're outside or inside
	ld a, [wPermission]
	and 7
	ld e, a
	ld d, 0
	ld hl, .TilesetColorsPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; Futher refine by time of day
	ld a, [TimeOfDayPal]
	and 3
	add a
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h
	; Switch to palettes WRAM bank
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld hl, UnknBGPals
	ld b, 8
.outer_loop
	ld a, [de] ; lookup index for TilesetBGPalette
	push de
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, TilesetBGPalette
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld c, 1 palettes
.inner_loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .inner_loop
	pop de
	inc de
	dec b
	jr nz, .outer_loop
	pop af
	ld [rSVBK], a

.got_pals
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	ld hl, MapObjectPals
	call AddNTimes
	ld de, UnknOBPals
	ld bc, 8 palettes
	ld a, $5 ; BANK(UnknOBPals)
	call FarCopyWRAM

	farcall LoadSpecialMapOBPalette

	ld a, [wPermission]
	cp TOWN
	jr z, .outside
	cp ROUTE
	jr z, .outside
	cp PERM_5
	ret nz
.outside
	ld a, [MapGroup]
	ld l, a
	ld h, 0
rept 3
	add hl,hl
endr
	ld de, RoofPals
	add hl, de
	ld a, [TimeOfDayPal]
	and 3
	cp NITE
	jr c, .morn_day
rept 4
	inc hl
endr
.morn_day
	ld de, UnknBGPals + 6 palettes + 2
	ld bc, 4
	ld a, $5
	call FarCopyWRAM

	ret

.TilesetColorsPointers:
	dw .OutdoorColors ; unused
	dw .OutdoorColors ; TOWN
	dw .OutdoorColors ; ROUTE
	dw .IndoorColors ; INDOOR
	dw .DungeonColors ; CAVE
	dw .Perm5Colors ; PERM_5
	dw .IndoorColors ; GATE
	dw .DungeonColors ; DUNGEON

; Valid indices: $00 - $29
.OutdoorColors:
.Perm5Colors:
	db $00, $01, $02, $28, $04, $05, $06, $07 ; morn
	db $08, $09, $0a, $29, $0c, $0d, $0e, $0f ; day
	db $10, $11, $12, $2a, $14, $15, $16, $17 ; nite
	db $18, $19, $1a, $1b, $1c, $1d, $1e, $1f ; dark

.IndoorColors:
	db $20, $21, $22, $23, $24, $25, $26, $07 ; morn
	db $20, $21, $22, $23, $24, $25, $26, $07 ; day
	db $10, $11, $12, $13, $14, $15, $16, $07 ; nite
	db $18, $19, $1a, $1b, $1c, $1d, $1e, $07 ; dark

.DungeonColors:
	db $00, $01, $02, $03, $04, $05, $06, $07 ; morn
	db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; day
	db $10, $11, $12, $13, $14, $15, $16, $17 ; nite
	db $18, $19, $1a, $1b, $1c, $1d, $1e, $1f ; dark

Palette_b311:
	RGB 31, 31, 31
	RGB 17, 19, 31
	RGB 14, 16, 31
	RGB 00, 00, 00

TilesetBGPalette:
INCLUDE "tilesets/bg.pal"

MapObjectPals::
INCLUDE "tilesets/ob.pal"

RoofPals:
INCLUDE "tilesets/roof.pal"

Palettes_b641:
	RGB 27, 31, 27
	RGB 21, 21, 21
	RGB 13, 13, 13
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 31, 07, 06
	RGB 20, 02, 03
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 10, 31, 09
	RGB 04, 14, 01
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 08, 12, 31
	RGB 01, 04, 31
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 31, 31, 07
	RGB 31, 16, 01
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 22, 16, 08
	RGB 13, 07, 01
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 15, 31, 31
	RGB 05, 17, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 11, 11, 19
	RGB 07, 07, 12
	RGB 00, 00, 00

Palettes_b681:
	RGB 27, 31, 27
	RGB 31, 19, 10
	RGB 31, 07, 04
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 31, 19, 10
	RGB 10, 14, 20
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 31, 19, 10
	RGB 31, 07, 04
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 31, 19, 10
	RGB 31, 07, 04
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 31, 19, 10
	RGB 31, 07, 04
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 31, 19, 10
	RGB 31, 07, 04
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 31, 19, 10
	RGB 31, 07, 04
	RGB 00, 00, 00

	RGB 27, 31, 27
	RGB 31, 19, 10
	RGB 31, 07, 04
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 21, 21, 21
	RGB 13, 13, 13
	RGB 07, 07, 07

	RGB 31, 31, 31
	RGB 31, 31, 07
	RGB 31, 16, 01
	RGB 07, 07, 07

	RGB 31, 31, 31
	RGB 31, 19, 24
	RGB 30, 10, 06
	RGB 07, 07, 07

	RGB 31, 31, 31
	RGB 12, 25, 01
	RGB 05, 14, 00
	RGB 07, 07, 07

	RGB 31, 31, 31
	RGB 08, 12, 31
	RGB 01, 04, 31
	RGB 07, 07, 07

	RGB 31, 31, 31
	RGB 24, 18, 07
	RGB 20, 15, 03
	RGB 07, 07, 07

Palettes_b6f1:
	RGB 31, 31, 31
	RGB 18, 23, 31
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 22, 00, 31
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 00, 00
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 25, 22, 00
	RGB 15, 20, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 23, 26, 31
	RGB 18, 23, 31
	RGB 00, 00, 00

Palettes_b719:
	RGB 31, 31, 31
	RGB 07, 06, 03
	RGB 07, 06, 03
	RGB 07, 06, 03

	RGB 31, 31, 31
	RGB 31, 31, 00
	RGB 26, 22, 00
	RGB 00, 00, 00

MalePokegearPals:
	RGB 31, 31, 31
	RGB 21, 21, 21
	RGB 13, 13, 13
	RGB 00, 00, 00

	RGB 20, 13, 08
	RGB 00, 24, 15
	RGB 00, 17, 19
	RGB 00, 20, 22

	RGB 00, 20, 12
	RGB 00, 24, 15
	RGB 29, 17, 10
	RGB 20, 13, 08

	RGB 31, 31, 31
	RGB 31, 15, 00
	RGB 15, 07, 00
	RGB 00, 00, 00

	RGB 17, 27, 30
	RGB 00, 11, 19
	RGB 00, 17, 19
	RGB 00, 20, 22

	RGB 31, 05, 09
	RGB 00, 24, 15
	RGB 24, 00, 04
	RGB 04, 04, 04

	RGB 31, 31, 31
	RGB 00, 24, 15
	RGB 00, 16, 10
	RGB 04, 04, 04

	RGB 31, 22, 05
	RGB 00, 24, 15
	RGB 29, 17, 10
	RGB 04, 04, 04

FemalePokegearPals:
	RGB 31, 31, 31
	RGB 21, 21, 21
	RGB 13, 13, 13
	RGB 00, 00, 00

	RGB 20, 13, 08
	RGB 00, 24, 15
	RGB 00, 17, 19
	RGB 00, 20, 22

	RGB 00, 20, 12
	RGB 00, 24, 15
	RGB 29, 17, 10
	RGB 20, 13, 08

	RGB 31, 31, 31
	RGB 10, 18, 31
	RGB 13, 06, 31
	RGB 00, 00, 00

	RGB 17, 27, 30
	RGB 00, 11, 19
	RGB 00, 17, 19
	RGB 00, 20, 22

	RGB 31, 05, 09
	RGB 00, 24, 15
	RGB 24, 00, 04
	RGB 04, 04, 04

	RGB 31, 31, 31
	RGB 00, 24, 15
	RGB 00, 16, 10
	RGB 04, 04, 04

	RGB 31, 22, 05
	RGB 00, 24, 15
	RGB 29, 17, 10
	RGB 04, 04, 04

Palettes_b789:
	RGB 31, 31, 31
	RGB 30, 22, 24
	RGB 18, 18, 18
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 10, 11, 31
	RGB 18, 18, 18
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 12, 31, 11
	RGB 18, 18, 18
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 29, 26, 05
	RGB 18, 18, 18
	RGB 00, 00, 00

Palettes_b7a9:
	RGB 31, 31, 31
	RGB 17, 09, 08
	RGB 31, 12, 09
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 24, 31, 06
	RGB 31, 12, 09
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 15, 31, 00
	RGB 31, 12, 09
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 15, 31
	RGB 31, 12, 09
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 15, 21, 31
	RGB 31, 12, 09
	RGB 00, 00, 00

	RGB 31, 31, 11
	RGB 31, 31, 06
	RGB 31, 12, 09
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 16, 19, 29
	RGB 25, 22, 00
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 21, 21, 21
	RGB 13, 13, 13
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 30, 10, 06
	RGB 31, 00, 00
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 12, 25, 01
	RGB 05, 14, 00
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 12, 25, 01
	RGB 30, 10, 06
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 31, 06
	RGB 20, 15, 03
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 31, 06
	RGB 15, 21, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 31, 06
	RGB 20, 15, 03
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 24, 21
	RGB 31, 13, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 00, 00, 00
	RGB 00, 00, 00

