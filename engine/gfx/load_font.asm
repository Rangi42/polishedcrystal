INCLUDE "gfx/font.asm"

_LoadStandardOpaqueFont::
	ld a, TRUE
	call _LoadStandardMaybeOpaqueFont
	ld hl, vTiles2 tile ' '
	ld de, TextboxSpaceGFX
	jmp GetOpaque1bppFontTile

_LoadStandardFont::
	xor a
_LoadStandardMaybeOpaqueFont:
	push af
	call LoadStandardFontPointer
	ld d, h
	ld e, l
	ld hl, vTiles0 tile 'A'
	lb bc, BANK(FontTiles), 114
	pop af
	ldh [hRequestOpaque1bpp], a
	push af
	call GetMaybeOpaque1bpp
	ld de, FontCommon
	ld hl, vTiles0 tile '↑'
	lb bc, BANK(FontCommon), 6
	pop af
	ldh [hRequestOpaque1bpp], a
	jmp GetMaybeOpaque1bpp

LoadStandardFontPointer::
	ld hl, .FontPointers
	ld a, [wOptions2]
	and FONT_MASK
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.FontPointers:
	table_width 2
	dw FontNormal
	dw FontNarrow
	dw FontBold
	dw FontItalic
	dw FontSerif
	dw FontChicago
	dw FontMICR
	dw FontUnown
	assert_table_length NUM_FONTS

_LoadFontsBattleExtra::
	ld hl, BattleExtrasGFX
	ld de, vTiles2 tile BATTLEEXTRA_GFX_START
	lb bc, BANK(BattleExtrasGFX), 32
	call DecompressRequest2bpp

_LoadFrame::
	ld a, [wTextboxFrame]
	ld bc, TEXTBOX_FRAME_TILES * TILE_1BPP_SIZE
	ld hl, Frames
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles0 tile '┌'
	lb bc, BANK(Frames), TEXTBOX_FRAME_TILES
	call Get1bpp
	ld hl, vTiles2 tile ' '
	ld de, TextboxSpaceGFX
	lb bc, BANK(TextboxSpaceGFX), 1
	jmp Get1bpp

LoadBattleFontsHPBar:
	call _LoadFontsBattleExtra

LoadSummaryStatusIcon:
	push de
	xor a
	ld de, wTempMonStatus
	farcall GetStatusConditionIndex
	ld hl, SummaryStatusIconGFX
	ld bc, 2 tiles
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles0 tile SUMMARY_TILE_OAM_STATUS
	lb bc, BANK(SummaryStatusIconGFX), 2
	call Request2bpp
	farcall LoadSummaryStatusIconPalette
	farcall ApplyOBPals
	pop de
	ret

LoadPlayerStatusIcon:
	push de
	ld a, [wPlayerSubStatus2]
	ld de, wBattleMonStatus
	farcall GetStatusConditionIndex
	ld hl, StatusIconGFX
	ld bc, 2 tiles
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles2 tile $55
	lb bc, BANK(StatusIconGFX), 2
	call Request2bpp
	farcall LoadPlayerStatusIconPalette
	pop de
	ret

LoadStatusIcons:
	call LoadPlayerStatusIcon
	; fallthrough

LoadEnemyStatusIcon:
	push de
	ld a, [wEnemySubStatus2]
	ld de, wEnemyMonStatus
	farcall GetStatusConditionIndex
	ld hl, EnemyStatusIconGFX
	ld bc, 2 tiles
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles2 tile $57
	lb bc, BANK(EnemyStatusIconGFX), 2
	call Request2bpp
	farcall LoadEnemyStatusIconPalette
	pop de
	ret

LoadBoldPDoubled:
	; point hl to the '<BOLDP>' 1bpp tile in ROM
	call LoadStandardFontPointer
	ld de, ('<BOLDP>' - $80) * TILE_1BPP_SIZE
	add hl, de
	; copy the bold P, with halves swapped, to the middle char of wSummaryScreenPPTileBuffer
	ld de, wSummaryScreenPPTileBuffer + TILE_1BPP_SIZE
	push de
	ld c, TILE_1BPP_SIZE
.loop
	ld a, [hli]
	swap a
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	pop hl
	; copy the left and right halves to the two other chars of wSummaryScreenPPTileBuffer
	ld c, TILE_1BPP_SIZE
.loop2
	push hl
	ld a, [hl]
	and $0f
	ld de, -TILE_1BPP_SIZE
	add hl, de
	ld [hl], a
	ld de, TILE_1BPP_SIZE
	add hl, de
	ld a, [hl]
	and $f0
	add hl, de
	ld [hl], a
	pop hl
	inc hl
	dec c
	jr nz, .loop2
	; copy the three tiles from wSummaryScreenPPTileBuffer to VRAM
	ld hl, vTiles2 tile SUMMARY_TILE_PP_START
	ld de, wSummaryScreenPPTileBuffer
	lb bc, BANK(@), 3
	jmp Get1bpp
