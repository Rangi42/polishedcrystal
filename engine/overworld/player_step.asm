_HandlePlayerStep::
	ld a, [wPlayerStepFlags]
	add a
	jr c, .updateOverworldMap ; starting step
	add a
	jr c, .updatePlayerCoords ; finishing step
	add a
	jr c, .finish ; ongoing step
	ret

.updateOverworldMap
	ld a, 4
	ld [wHandlePlayerStep], a
	call UpdateOverworldMap
	jr .finish

.updatePlayerCoords
	call UpdatePlayerCoords
	; fallthrough

.finish
	call HandlePlayerStep
	ld a, [wPlayerStepVectorX]
	ld d, a
	ld a, [wPlayerStepVectorY]
	ld e, a
	ld a, [wPlayerBGMapOffsetX]
	sub d
	ld [wPlayerBGMapOffsetX], a
	ld a, [wPlayerBGMapOffsetY]
	sub e
	ld [wPlayerBGMapOffsetY], a
	ret

ScrollScreen::
	ld a, [wPlayerStepVectorX]
	ld d, a
	ld a, [wPlayerStepVectorY]
	ld e, a
	ldh a, [hSCX]
	add d
	ldh [hSCX], a
	ldh a, [hSCY]
	add e
	ldh [hSCY], a
	ret

HandlePlayerStep:
	ld hl, wHandlePlayerStep
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld a, [hl]
	call StackJumpTable

.Jumptable:
	dw GetMovementPermissions
	dw BufferScreen
	dw DoNothing
	dw DoNothing

UpdatePlayerCoords:
	ld hl, wYCoord
	ld a, [wPlayerStepDirection]
	and a
	jr z, .incrementCoord
	dec a
	jr z, .decrementCoord
	inc hl
	dec a
	jr z, .decrementCoord
	dec a
	ret nz
.incrementCoord
	inc [hl]
	ret
.decrementCoord
	dec [hl]
	ret

UpdateOverworldMap:
	ld a, [wPlayerStepDirection]
	and a
	jr z, .stepDown
	dec a
	jr z, .stepUp
	dec a
	jr z, .stepLeft
	dec a
	ret nz
; step right
	call .ScrollOverworldMapRight
	call _LoadMapPart
	jmp ScrollMapLeft
.stepDown
	call .ScrollOverworldMapDown
	call _LoadMapPart
	jmp ScrollMapUp
.stepUp
	call .ScrollOverworldMapUp
	call _LoadMapPart
	jmp ScrollMapDown
.stepLeft
	call .ScrollOverworldMapLeft
	call _LoadMapPart
	jmp ScrollMapRight

.ScrollOverworldMapDown:
	ld a, [wBGMapAnchor]
	add 2 * BG_MAP_WIDTH
	ld [wBGMapAnchor], a
	jr nc, .not_overflowed
	ld a, [wBGMapAnchor + 1]
	inc a
	and $3
	or HIGH(vBGMap0)
	ld [wBGMapAnchor + 1], a
.not_overflowed
	ld hl, wMetatileStandingY
	inc [hl]
	ld a, [hl]
	cp 2 ; was 1
	ret nz
	ld [hl], 0
	ld hl, wOverworldMapAnchor
	ld a, [wMapWidth]
	add 6
	add [hl]
	ld [hli], a
	ret nc
	inc [hl]
	ret

.ScrollOverworldMapUp:
	ld a, [wBGMapAnchor]
	sub 2 * BG_MAP_WIDTH
	ld [wBGMapAnchor], a
	jr nc, .not_underflowed
	ld a, [wBGMapAnchor + 1]
	dec a
	and $3
	or HIGH(vBGMap0)
	ld [wBGMapAnchor + 1], a
.not_underflowed
	ld hl, wMetatileStandingY
	dec [hl]
	ld a, [hl]
	inc a
	ret nz
	ld [hl], $1
	ld hl, wOverworldMapAnchor
	ld a, [wMapWidth]
	add 6
	ld b, a
	ld a, [hl]
	sub b
	ld [hli], a
	ret nc
	dec [hl]
	ret

.ScrollOverworldMapLeft:
	ld a, [wBGMapAnchor]
	ld e, a
	and $e0
	ld d, a
	ld a, e
	sub $2
	and $1f
	or d
	ld [wBGMapAnchor], a
	ld hl, wMetatileStandingX
	dec [hl]
	ld a, [hl]
	inc a
	ret nz
	ld [hl], 1
	ld hl, wOverworldMapAnchor
	ld a, [hl]
	sub 1 ; no-optimize a++|a-- (dec a can't set carry)
	ld [hli], a
	ret nc
	dec [hl]
	ret

.ScrollOverworldMapRight:
	ld a, [wBGMapAnchor]
	ld e, a
	and $e0
	ld d, a
	ld a, e
	add $2
	and $1f
	or d
	ld [wBGMapAnchor], a
	ld hl, wMetatileStandingX
	inc [hl]
	ld a, [hl]
	cp 2
	ret nz
	ld [hl], 0
	ld hl, wOverworldMapAnchor
	inc [hl]
	ret nz
	inc hl
	inc [hl]
	ret

CheckPlayerCoastSandColl:
	ld a, [wPlayerTileCollision]
	cp COLL_COAST_SAND
	ret z
	ld a, [wPlayerLastTile]
	cp COLL_COAST_SAND
	ret

ScrollMapDown::
	call CheckPlayerCoastSandColl
	jr nz, .reload_walked_tiles
	hlcoord 0, 0
	ld de, wBGMapBuffer
	call BackupBGMapRow
	hlcoord 0, 0, wAttrmap
	ld de, wBGMapPalBuffer
	jr .done
.reload_walked_tiles
	call ReloadWalkedTile
	hlcoord 0, 0
	ld de, wBGMapBuffer + 8
	call BackupBGMapRow
	hlcoord 0, 0, wAttrmap
	ld de, wBGMapPalBuffer + 8
.done
	call BackupBGMapRow
	ld hl, wBGMapAnchor
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call CheckPlayerCoastSandColl
	ld a, SCREEN_WIDTH + 4
	ld hl, wBGMapBufferPtrs + 8
	jr nz, .got_arguments
	ld a, SCREEN_WIDTH
	ld hl, wBGMapBufferPtrs
.got_arguments
	call UpdateBGMapRow
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

ScrollMapUp::
	call CheckPlayerCoastSandColl
	jr nz, .reload_walked_tiles
	hlcoord 0, SCREEN_HEIGHT - 2
	ld de, wBGMapBuffer
	call BackupBGMapRow
	hlcoord 0, SCREEN_HEIGHT - 2, wAttrmap
	ld de, wBGMapPalBuffer
	jr .done
.reload_walked_tiles
	call ReloadWalkedTile
	hlcoord 0, SCREEN_HEIGHT - 2
	ld de, wBGMapBuffer + 8
	call BackupBGMapRow
	hlcoord 0, SCREEN_HEIGHT - 2, wAttrmap
	ld de, wBGMapPalBuffer + 8
.done
	call BackupBGMapRow
	ld hl, wBGMapAnchor
	ld a, [hli]
	ld e, a
	ld a, [hl]
	; add $0200, but cap at HIGH(vBGMap1)
	inc a
	inc a
	and %00000011
	or HIGH(vBGMap0)
	ld d, a
	call CheckPlayerCoastSandColl
	ld a, SCREEN_WIDTH + 4
	ld hl, wBGMapBufferPtrs + 8
	jr nz, .got_arguments
	ld a, SCREEN_WIDTH
	ld hl, wBGMapBufferPtrs
.got_arguments
	call UpdateBGMapRow
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

ScrollMapRight::
	call CheckPlayerCoastSandColl
	jr nz, .reload_walked_tiles
	hlcoord 0, 0
	ld de, wBGMapBuffer
	call BackupBGMapColumn
	hlcoord 0, 0, wAttrmap
	ld de, wBGMapPalBuffer
	jr .done
.reload_walked_tiles
	call ReloadWalkedTile
	hlcoord 0, 0
	ld de, wBGMapBuffer + 8
	call BackupBGMapColumn
	hlcoord 0, 0, wAttrmap
	ld de, wBGMapPalBuffer + 8
.done
	call BackupBGMapColumn
	ld hl, wBGMapAnchor
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call CheckPlayerCoastSandColl
	ld a, SCREEN_HEIGHT + 4
	ld hl, wBGMapBufferPtrs + 8
	jr nz, .got_arguments
	ld a, SCREEN_HEIGHT
	ld hl, wBGMapBufferPtrs
.got_arguments
	call UpdateBGMapColumn
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

ScrollMapLeft::
	call CheckPlayerCoastSandColl
	jr nz, .reload_walked_tiles
	hlcoord SCREEN_WIDTH - 2, 0
	ld de, wBGMapBuffer
	call BackupBGMapColumn
	hlcoord SCREEN_WIDTH - 2, 0, wAttrmap
	ld de, wBGMapPalBuffer
	jr .done
.reload_walked_tiles
	call ReloadWalkedTile
	hlcoord SCREEN_WIDTH - 2, 0
	ld de, wBGMapBuffer + 8
	call BackupBGMapColumn
	hlcoord SCREEN_WIDTH - 2, 0, wAttrmap
	ld de, wBGMapPalBuffer + 8
.done
	call BackupBGMapColumn
	ld hl, wBGMapAnchor
	ld a, [hli]
	; add SCREEN_HEIGHT, but wrap-around the last 5 bits
	swap a
	rrca
	add SCREEN_HEIGHT << 3
	rlca
	swap a
	ld d, [hl]
	ld e, a
	call CheckPlayerCoastSandColl
	ld a, SCREEN_HEIGHT + 4
	ld hl, wBGMapBufferPtrs + 8
	jr nz, .got_arguments
	ld a, SCREEN_HEIGHT
	ld hl, wBGMapBufferPtrs
.got_arguments
	call UpdateBGMapColumn
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

BackupBGMapRow::
	ld c, 2 * SCREEN_WIDTH
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

BackupBGMapColumn::
	ld c, SCREEN_HEIGHT
.loop
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld a, SCREEN_WIDTH - 1
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec c
	jr nz, .loop
	ret

UpdateBGMapRow::
; input a = tile count
; hl = wBGMapBufferPtrs
	push af
	push de
	call .iteration
	pop de
	ld a, BG_MAP_WIDTH
	add e
	ld e, a
	call .iteration
	pop af
	ldh [hBGMapTileCount], a
	ret

.iteration
	ld c, 10
.loop
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, e
	inc a
	inc a
	xor e
	and $1f
	xor e
	ld e, a
	dec c
	jr nz, .loop
	ret

UpdateBGMapColumn::
; input a = tile count
; hl = wBGMapBufferPtrs
	push af
	ld c, SCREEN_HEIGHT
.loop
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, BG_MAP_HEIGHT
	add e
	ld e, a
	jr nc, .skip
	inc d
; cap d at HIGH(vBGMap1)
	ld a, d
	and %11
	or HIGH(vBGMap0)
	ld d, a

.skip
	dec c
	jr nz, .loop
	pop af
	ldh [hBGMapTileCount], a
	ret

ReloadWalkedTile:
; Update tile player is to walk on
	hlcoord 8, 6
	ld de, wBGMapBuffer
	call .CommitTiles
	hlcoord 8, 6, wAttrmap
	ld de, wBGMapPalBuffer
	call .CommitTiles
	ld a, [wBGMapAnchor]
	swap a
	rrca
	add 8 << 3
	rlca
	swap a
	add $c0
	ld l, a
	ld a, [wBGMapAnchor + 1]
	adc 0
	ld h, a
	ld c, 4
	ld de, wBGMapBufferPtrs
.ptr_loop
	ld a, h
	and HIGH($9800 | $9900 | $9a00 | $9b00) ; clamp within VRAM addresses
	ld h, a
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de

	ld a, BG_MAP_WIDTH
	call .AddHLDecC
	jr nz, .ptr_loop
	ret

.CommitTiles:
	ld c, 4
.tile_loop
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld a, SCREEN_WIDTH - 1
	call .AddHLDecC
	jr nz, .tile_loop
	ret

.AddHLDecC:
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec c
	ret
