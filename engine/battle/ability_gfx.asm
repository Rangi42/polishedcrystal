SLIDEOUT_WIDTH EQU 11 ; tiles
SLIDEOUT_TEXT_WIDTH EQU (SLIDEOUT_WIDTH - 1) * TILE_WIDTH
SLIDEOUT_OVERLAP EQU 10 ; pixels
SLIDEOUT_START_TILE EQU $d4

PerformAbilityGFX:
	call RunFunctionInWRA6
.Function:
	; Get ability name
	ld de, wAbilityName
	farcall _BufferAbility

	; Blank existing nickname
	ld hl, wAbilityPkmn
	ld bc, MON_NAME_LENGTH
	ld a, "@"
	rst ByteFill

	; Get user nickname (post-processed with n-grams)
	ldh a, [hBattleTurn]
	and a
	ld de, wBattleMonNickname
	jr z, .got_pkmn_name
	ld de, wEnemyMonNickname
.got_pkmn_name
	ld hl, wAbilityPkmn
	rst PlaceString

	; Append 's
	ld hl, wAbilityPkmn
.name_loop
	ld a, [hli]
	cp "@"
	jr nz, .name_loop
	ld [hld], a
	ld [hl], "'s"

	; Copy tile data to temporary WRAM
	call .CopyTilesToWRAM

	call ApplyAbilityTiles

	; Change tilemap references
	call .WriteTilemap
	ld b, 2
	call SafeCopyTilemapAtOnce

	ld de, SFX_ABILITYSLIDEOUT
	call WaitPlaySFX

	call .OverlaySlideout

	ld b, PAL_BATTLE_BG_TEXT
	call SetUserAbilityOverlayAttributes

	ld b, 2
	call SafeCopyTilemapAtOnce

	call AbilityVWF
	jmp ApplyAbilityTiles

.Fill2Tiles:
; Fills 2 tiles at hl, which points to the last row of the bottom tile + 1
	dec hl
	call .do_fill_loop
	ld bc, -(SLIDEOUT_WIDTH - 1) tiles
	add hl, bc
.do_fill_loop
	ld c, 1 tiles
	ld a, -1
.fill_loop
	ld [hld], a
	dec c
	jr nz, .fill_loop
	ret

.OverlaySlideout:
	ldh a, [hBattleTurn]
	and a
	; start at the bottom row of the upper (leftmost) tile
	ld hl, wAbilityTiles + 7 * 2 + 1
	ld bc, 2 tiles
	jr z, .got_start
	; start at the bottom row of the upper rightmost tile
	ld hl, wAbilityTiles + 7 * 2 + 1 + (SLIDEOUT_WIDTH - 1) tiles
	ld bc, 0 tiles
.got_start
	ld d, SLIDEOUT_WIDTH
	push bc
	jr .handle_slide_loop
.slide_loop
	call .Fill2Tiles
	pop bc
	add hl, bc
	push bc
.handle_slide_loop
	push bc
	push de
	call .do_slide
	pop de
	pop bc
	call DelayFrame
	dec d
	jr nz, .slide_loop
	pop bc
	ret

.do_slide
	lb bc, -1, 8
	push bc
.slide_loop1
	ld a, [hl]
	or b
	ld [hld], a
	ld a, [hl]
	or b
	ld [hld], a
	call .ShiftB
	dec c
	jr nz, .slide_loop1
	ld bc, SLIDEOUT_WIDTH tiles + 1
	add hl, bc
	pop bc
.slide_loop2
	ld a, [hl]
	or b
	ld [hli], a
	ld a, [hl]
	or b
	ld [hli], a
	call .ShiftB
	dec c
	jr nz, .slide_loop2
	push hl
	call ApplyAbilityTiles
	pop hl
	ret

.ShiftB:
	ldh a, [hBattleTurn]
	and a
	jr nz, .ShiftEnemyB
	sla b
	ret
.ShiftEnemyB
	srl b
	ret

.WriteTilemap:
	ldh a, [hBattleTurn]
	and a
	hlcoord 0, 8
	ld b, SLIDEOUT_START_TILE + SLIDEOUT_WIDTH * 2
	jr z, .got_tilemap_data
	hlcoord 9, 3
	ld b, SLIDEOUT_START_TILE
.got_tilemap_data
	call SetAbilityTilemap
	ld bc, wAttrMap - wTileMap - SLIDEOUT_WIDTH - SCREEN_WIDTH
	add hl, bc
	ld b, -1 ; keep current palette
	jr SetAbilityOverlayAttributes

.CopyTilesToWRAM:
	ldh a, [hBattleTurn]
	and a
	decoord 0, 8
	jr z, .got_start_tile
	decoord 9, 3
.got_start_tile
	ld hl, wAbilityTiles
	ld b, 2
.outer_loop
	ld c, SLIDEOUT_WIDTH
.inner_loop
	push bc
	ld a, [de]
	xor $80
	inc de
	push de
	push hl
	; hl = vTiles1 tile a
	swap a
	ld h, a
	and $f0
	ld l, a
	xor h
	ld h, a
	ld bc, vTiles1
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	push hl
	ld c, 1
	call Get2bpp
	pop hl
	ld bc, 1 tiles
	add hl, bc
	pop de
	pop bc
	dec c
	jr nz, .inner_loop
	push hl
	ld hl, SCREEN_WIDTH - SLIDEOUT_WIDTH
	add hl, de
	ld d, h
	ld e, l
	pop hl
	dec b
	jr nz, .outer_loop
	ret

ResetAbilityTilemap:
; Sets tilemap data depending on which overlays are active.
	hlcoord 0, 8, wAttrMap
	ld b, SLIDEOUT_START_TILE + SLIDEOUT_WIDTH * 2
	bit OAM_TILE_BANK, [hl]
	call nz, .SetTilemap
	hlcoord 9, 3, wAttrMap
	ld b, SLIDEOUT_START_TILE
	bit OAM_TILE_BANK, [hl]
	ret z
.SetTilemap
	push bc
	ld bc, wTileMap - wAttrMap
	add hl, bc
	pop bc
	; fallthrough
SetAbilityTilemap:
	call .do_tilemap_loop
	push bc
	ld bc, SCREEN_WIDTH - SLIDEOUT_WIDTH
	add hl, bc
	pop bc

.do_tilemap_loop
	ld c, SLIDEOUT_WIDTH
.tilemap_loop
	ld [hl], b
	inc hl
	inc b
	dec c
	jr nz, .tilemap_loop
	ret

SetUserAbilityOverlayAttributes:
	ldh a, [hBattleTurn]
	and a
	hlcoord 0, 8, wAttrMap
	jr z, SetAbilityOverlayAttributes
	hlcoord 9, 3, wAttrMap
	; fallthrough

SetAbilityOverlayAttributes:
; sets attributes for hl pointing to overlay area to use vbk1
; b: palette to use, or -1 to keep the current palette
	call .do_attrmap_loop
	push bc
	ld bc, SCREEN_WIDTH - SLIDEOUT_WIDTH
	add hl, bc
	pop bc
.do_attrmap_loop
	ld c, SLIDEOUT_WIDTH
.attrmap_loop
	push af
	ld a, b
	inc a
	jr z, .no_pal_change
	ld a, [hl]
	and ~PALETTE_MASK
	or b
	ld [hl], b
.no_pal_change
	pop af
	set OAM_TILE_BANK, [hl]
	set OAM_PRIORITY, [hl]
	inc hl
	dec c
	jr nz, .attrmap_loop
	ret

ApplyAbilityTiles:
	ldh a, [hBattleTurn]
	and a
	jr nz, .ApplyEnemyTiles
.ApplyPlayerTiles:
	ld hl, vTiles3 tile (SLIDEOUT_START_TILE + SLIDEOUT_WIDTH * 2)
	jr .DoApplyTiles
.ApplyEnemyTiles:
	ld hl, vTiles3 tile SLIDEOUT_START_TILE
	; fallthrough
.DoApplyTiles:
	ld a, 1
	ldh [rVBK], a
	ld c, SLIDEOUT_WIDTH * 2
	ld de, wAbilityTiles
	call Get2bpp
	xor a
	ldh [rVBK], a
	ret

DismissAbilityOverlays:
; Dismisses ability overlay for both sides.
	push hl
	push de
	push bc

	; Revert tilemap and attributes
	ldh a, [rSVBK]
	push af
	ld a, BANK(wTempTileMap)
	ldh [rSVBK], a
	ld b, PAL_BATTLE_BG_PLAYER
	hlcoord 0, 8
	call .reset_tilemap
	ld b, PAL_BATTLE_BG_PLAYER
	hlcoord 0, 9
	call .reset_tilemap
	ld b, PAL_BATTLE_BG_ENEMY
	hlcoord 9, 3
	call .reset_tilemap
	ld b, PAL_BATTLE_BG_ENEMY
	hlcoord 9, 4
	call .reset_tilemap
	pop af
	ldh [rSVBK], a

	; Reload the graphics
	ld b, 2
	call SafeCopyTilemapAtOnce

	pop bc
	pop de
	pop hl
	ret

.reset_tilemap
	; revert tilemap
	ld d, h
	ld e, l
	push bc
	ld bc, wTempTileMap - wTileMap
	add hl, bc
	ld bc, SLIDEOUT_WIDTH
	push hl
	rst CopyBytes
	pop hl
	ld bc, wAttrMap - wTempTileMap
	add hl, bc
	pop bc
	ld c, SLIDEOUT_WIDTH
.attr_loop
	ld a, [hl]
	and ~(PALETTE_MASK | VRAM_BANK_1 | PRIORITY)
	or b
	ld [hli], a
	dec c
	jr nz, .attr_loop
	ret

AbilityVWF:
; Write variable-width names into ability graphics
	; First, try to center the combined string with some overlap.
	ld de, wAbilityPkmn
	call GetVWFLength
	ld b, a
	ld de, wAbilityName
	call GetVWFLength
	ld c, a
	add b
	sub SLIDEOUT_OVERLAP
	cp SLIDEOUT_TEXT_WIDTH
	jr c, .center_text

	; Regular length calculation
	lb bc, 0, SLIDEOUT_TEXT_WIDTH ; left+right edges, for pokémon name + ability
	jr .got_offsets

.center_text
	ld c, a
	srl c
	ld a, SLIDEOUT_TEXT_WIDTH / 2
	add c
	ld c, a ; no-optimize a = N - a
	ld a, SLIDEOUT_TEXT_WIDTH
	sub c
	ld b, a

.got_offsets
	; Offsets are in bc, add additional offsets to account for edges
	ldh a, [hBattleTurn]
	and a
	ld a, 1
	jr z, .got_extra_offset
	ld a, TILE_WIDTH
.got_extra_offset
	push af
	add b
	ld b, a
	pop af
	add c
	ld c, a

	; Now we have true offsets in bc for use.
	ld de, wAbilityPkmn
	ld hl, wAbilityTiles
	push bc
	ld c, b
	ld b, VWF_SINGLE | VWF_INVERT | VWF_OPAQUE
	call PlaceAbilityVWFString
	ld de, wAbilityName
	call GetVWFLength
	pop bc
	; Right-align enemy text
	ld h, a
	ld a, c
	sub h
	ld c, a
	ld b, VWF_SINGLE | VWF_INVERT | VWF_OPAQUE
	ld hl, wAbilityTiles + SLIDEOUT_WIDTH tiles
	; fallthrough

PlaceAbilityVWFString:
; Wrapper around PlaceVWFString so we can scroll the ability text
	call PlaceVWFString
	ret z

	push hl
	push de
	push bc
	call ApplyAbilityTiles
	call DelayFrame
	pop bc
	pop de
	pop hl
	jr PlaceAbilityVWFString
