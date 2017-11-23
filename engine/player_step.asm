_HandlePlayerStep:: ; d497 (3:5497)
	ld a, [wPlayerStepFlags]
	and a
	ret z
	bit 7, a ; starting step
	jr nz, .update_overworld_map
	bit 6, a ; finishing step
	jr nz, .update_player_coords
	bit 5, a ; ongoing step
	jr nz, .finish
	ret

.update_overworld_map
	ld a, 4
	ld [wHandlePlayerStep], a
	call UpdateOverworldMap
	jr .finish

.update_player_coords
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

ScrollScreen:: ; d4d2 (3:54d2)
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

HandlePlayerStep: ; d4e5 (3:54e5)
	ld hl, wHandlePlayerStep
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld a, [hl]
	ld hl, .Jumptable
	rst JumpTable
.fail ; d510 (3:5510)
	ret

.Jumptable: ; d4f2 (3:54f2)

	dw GetMovementPermissions
	dw BufferScreen
	dw .fail
	dw .fail

UpdatePlayerCoords: ; d511 (3:5511)
	ld a, [wPlayerStepDirection]
	and a
	jr nz, .check_step_down
	ld hl, YCoord
	inc [hl]
	ret

.check_step_down
	cp UP
	jr nz, .check_step_left
	ld hl, YCoord
	dec [hl]
	ret

.check_step_left
	cp LEFT
	jr nz, .check_step_right
	ld hl, XCoord
	dec [hl]
	ret

.check_step_right
	cp RIGHT
	ret nz
	ld hl, XCoord
	inc [hl]
	ret

UpdateOverworldMap: ; d536 (3:5536)
	ld a, [wPlayerStepDirection]
	and a
	jr z, .step_down
	cp UP
	jr z, .step_up
	cp LEFT
	jr z, .step_left
	cp RIGHT
	jr z, .step_right
	ret

.step_down
	call .ScrollOverworldMapDown
	call LoadMapPart
	jp ScrollMapUp

.step_up
	call .ScrollOverworldMapUp
	call LoadMapPart
	jp ScrollMapDown

.step_left
	call .ScrollOverworldMapLeft
	call LoadMapPart
	jp ScrollMapRight

.step_right
	call .ScrollOverworldMapRight
	call LoadMapPart
	jp ScrollMapLeft

.ScrollOverworldMapDown: ; d571 (3:5571)
	ld a, [wBGMapAnchor]
	add 2 * BG_MAP_WIDTH
	ld [wBGMapAnchor], a
	jr nc, .not_overflowed
	ld a, [wBGMapAnchor + 1]
	inc a
	and $3
	or VBGMap0 / $100
	ld [wBGMapAnchor + 1], a
.not_overflowed
	ld hl, wMetatileStandingY
	inc [hl]
	ld a, [hl]
	cp 2 ; was 1
	ret nz
	ld [hl], 0
	ld hl, wOverworldMapAnchor
	ld a, [MapWidth]
	add 6
	add [hl]
	ld [hli], a
	ret nc
	inc [hl]
	ret

.ScrollOverworldMapUp: ; d5a2 (3:55a2)
	ld a, [wBGMapAnchor]
	sub 2 * BG_MAP_WIDTH
	ld [wBGMapAnchor], a
	jr nc, .not_underflowed
	ld a, [wBGMapAnchor + 1]
	dec a
	and $3
	or VBGMap0 / $100
	ld [wBGMapAnchor + 1], a
.not_underflowed
	ld hl, wMetatileStandingY
	dec [hl]
	ld a, [hl]
	cp -1 ; was 0
	ret nz
	ld [hl], $1
	ld hl, wOverworldMapAnchor
	ld a, [MapWidth]
	add 6
	ld b, a
	ld a, [hl]
	sub b
	ld [hli], a
	ret nc
	dec [hl]
	ret

.ScrollOverworldMapLeft: ; d5d5 (3:55d5)
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
	cp -1
	ret nz
	ld [hl], 1
	ld hl, wOverworldMapAnchor
	ld a, [hl]
	sub 1
	ld [hli], a
	ret nc
	dec [hl]
	ret

.ScrollOverworldMapRight: ; d5fe (3:55fe)
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
	ld a, [hl]
	add 1
	ld [hli], a
	ret nc
	inc [hl]
	ret
