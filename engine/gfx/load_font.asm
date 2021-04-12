INCLUDE "gfx/font.asm"

_LoadStandardOpaqueFont::
	ld a, TRUE
	call _LoadStandardMaybeOpaqueFont
	ld hl, vTiles2 tile " "
	ld de, TextboxSpaceGFX
	jmp GetOpaque1bppFontTile

_LoadStandardFont::
	xor a
_LoadStandardMaybeOpaqueFont:
	push af
	call LoadStandardFontPointer
	ld d, h
	ld e, l
	ld hl, vTiles0 tile "A"
	lb bc, BANK(FontTiles), 111
	pop af
	ldh [hRequestOpaque1bpp], a
	push af
	call GetMaybeOpaque1bpp
	ld de, FontCommon
	ld hl, vTiles0 tile "▷"
	lb bc, BANK(FontCommon), 11
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
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld h, d
	ld l, e
	ret

.FontPointers:
	dw FontNormal
	dw FontNarrow
	dw FontBold
	dw FontItalic
	dw FontSerif
	dw FontChicago
	dw FontMICR
	dw FontUnown

_LoadFontsBattleExtra::
	ld hl, BattleExtrasGFX
	ld de, vTiles2 tile BATTLEEXTRA_GFX_START
	lb bc, BANK(BattleExtrasGFX), 32
	call DecompressRequest2bpp

LoadFrame::
	ld a, [wTextboxFrame]
	ld bc, TEXTBOX_FRAME_TILES * LEN_1BPP_TILE
	ld hl, Frames
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles0 tile "┌"
	lb bc, BANK(Frames), TEXTBOX_FRAME_TILES
	call Get1bpp
	ld hl, vTiles2 tile " "
	ld de, TextboxSpaceGFX
	lb bc, BANK(TextboxSpaceGFX), 1
	jmp Get1bpp

LoadBattleFontsHPBar:
	call _LoadFontsBattleExtra

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
