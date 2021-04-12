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

ScrollMapDown::
	call ReloadWalkedTile
	hlcoord 0, 0
	ld de, wBGMapBuffer + 8
	call BackupBGMapRow
	hlcoord 0, 0, wAttrMap
	ld de, wBGMapPalBuffer + 8
	call BackupBGMapRow
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapRow
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

ScrollMapUp::
	call ReloadWalkedTile
	hlcoord 0, SCREEN_HEIGHT - 2
	ld de, wBGMapBuffer + 8
	call BackupBGMapRow
	hlcoord 0, SCREEN_HEIGHT - 2, wAttrMap
	ld de, wBGMapPalBuffer + 8
	call BackupBGMapRow
	ld hl, wBGMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, $0200
	add hl, bc
; cap d at HIGH(vBGMap1)
	ld a, h
	and %00000011
	or HIGH(vBGMap0)
	ld e, l
	ld d, a
	call UpdateBGMapRow
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

ScrollMapRight::
	call ReloadWalkedTile
	hlcoord 0, 0
	ld de, wBGMapBuffer + 8
	call BackupBGMapColumn
	hlcoord 0, 0, wAttrMap
	ld de, wBGMapPalBuffer + 8
	call BackupBGMapColumn
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapColumn
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

ScrollMapLeft::
	call ReloadWalkedTile
	hlcoord SCREEN_WIDTH - 2, 0
	ld de, wBGMapBuffer + 8
	call BackupBGMapColumn
	hlcoord SCREEN_WIDTH - 2, 0, wAttrMap
	ld de, wBGMapPalBuffer + 8
	call BackupBGMapColumn
	ld a, [wBGMapAnchor]

	; add SCREEN_HEIGHT, but wrap-around the last 5 bits
	swap a
	rrca
	add SCREEN_HEIGHT << 3
	rlca
	swap a
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
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
	ld hl, wBGMapBufferPtrs + 8
	push de
	call .iteration
	pop de
	ld a, BG_MAP_WIDTH
	add e
	ld e, a

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
	and $1f
	ld b, a
	ld a, e
	and $e0
	or b
	ld e, a
	dec c
	jr nz, .loop
	ld a, SCREEN_WIDTH + 4
	ldh [hBGMapTileCount], a
	ret

UpdateBGMapColumn::
	ld hl, wBGMapBufferPtrs + 8
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
	ld a, SCREEN_HEIGHT + 4
	ldh [hBGMapTileCount], a
	ret
