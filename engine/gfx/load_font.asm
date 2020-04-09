INCLUDE "gfx/font.asm"

_LoadStandardOpaqueFont::
	ld a, TRUE
	call _LoadStandardMaybeOpaqueFont
	ld hl, vTiles2 tile " "
	ld de, TextBoxSpaceGFX
	jp GetOpaque1bppFontTile

_LoadStandardFont::
	xor a
_LoadStandardMaybeOpaqueFont:
	push af
	call LoadStandardFontPointer
	ld d, h
	ld e, l
	ld hl, vTiles0 tile "A"
	lb bc, BANK(FontNormal), 111
	pop af
	ldh [hRequestOpaque1bpp], a
	push af
	call GetMaybeOpaque1bpp
	ld de, FontCommon
	ld hl, vTiles0 tile "▷"
	lb bc, BANK(FontCommon), 11
	pop af
	ldh [hRequestOpaque1bpp], a
	jp GetMaybeOpaque1bpp

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
	dw FontBraille
	dw FontUnown
	dw FontNormal

_LoadFontsBattleExtra::
	ld de, BattleExtrasGFX
	ld hl, vTiles2 tile BATTLEEXTRA_GFX_START
	lb bc, BANK(BattleExtrasGFX), 32
	call Get2bpp

LoadFrame::
	ld a, [wTextboxFrame]
	ld bc, TILES_PER_FRAME * LEN_1BPP_TILE
	ld hl, Frames
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles0 tile "┌"
	lb bc, BANK(Frames), TILES_PER_FRAME
	call Get1bpp
	ld hl, vTiles2 tile " "
	ld de, TextBoxSpaceGFX
	lb bc, BANK(TextBoxSpaceGFX), 1
	jp Get1bpp

LoadBattleFontsHPBar:
	call _LoadFontsBattleExtra

LoadStatusIcons:
	call LoadPlayerStatusIcon
	jp LoadEnemyStatusIcon

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

LoadStatsScreenGFX:
	call _LoadFontsBattleExtra

LoadStatsGFX:
	ld hl, GFX_Stats
	ld de, vTiles2 tile $31
	lb bc, BANK(GFX_Stats), 15
	jp DecompressRequest2bpp
