_HandlePlayerStep::
	ld a, [wPlayerStepFlags]
	add a, a
	jr c, .updateOverworldMap ; starting step
	add a, a
	jr c, .updatePlayerCoords ; finishing step
	add a, a
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
	ld a, [hSCX]
	add d
	ld [hSCX], a
	ld a, [hSCY]
	add e
	ld [hSCY], a
	ret

HandlePlayerStep:
	ld hl, wHandlePlayerStep
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld a, [hl]
	ld hl, .Jumptable
	rst JumpTable
.fail
	ret

.Jumptable:

	dw GetMovementPermissions
	dw BufferScreen
	dw .fail
	dw .fail

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
	jp ScrollMapLeft
.stepDown
	call .ScrollOverworldMapDown
	call _LoadMapPart
	jp ScrollMapUp
.stepUp
	call .ScrollOverworldMapUp
	call _LoadMapPart
	jp ScrollMapDown
.stepLeft
	call .ScrollOverworldMapLeft
	call _LoadMapPart
	jp ScrollMapRight

.ScrollOverworldMapDown:
	ld a, [wBGMapAnchor]
	add 2 * BG_MAP_WIDTH
	ld [wBGMapAnchor], a
	jr nc, .not_overflowed
	ld a, [wBGMapAnchor + 1]
	inc a
	and $3
	or vBGMap0 / $100
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
	or vBGMap0 / $100
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
	sub 1
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
