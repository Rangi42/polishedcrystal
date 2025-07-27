; Determines the current battle environment at the start of a battle
; clobbers everything
InitBattleEnvironment:
	ld a, [wBattleType]
	cp a, BATTLETYPE_FISH
	jr nz, .not_fishing
	ld a, ENVIRONMENT_WATER
	jr .got_environment
.not_fishing
	call GetCurrentLandmark
	ld hl, PriorityLandmarkEnvironments
	ld de, 2
	call IsInArray
	jr nc, .no_override_environment
	inc hl
	ld a, [hl]
	jr .got_environment

.no_override_environment
	ld a, [wPlayerTileCollision]
	ld hl, TileEnvironments
	ld de, 2
	call IsInArray
	jr nc, .no_tile_environment
	inc hl
	ld a, [hl]
	jr .got_environment

.no_tile_environment
	call GetCurrentLandmark
	ld hl, LandmarkEnvironments
	ld de, 2
	call IsInArray
	jr nc, .no_landmark_environment
	inc hl
	ld a, [hl]
	jr .got_environment

.no_landmark_environment
	ldh a, [rSVBK]
	push af
	ld a, BANK(wEnvironment)
	ldh [rSVBK], a
	ld a, [wEnvironment]
	dec a
	ld b, 0
	ld c, a
	pop af
	ldh a, [rSVBK]
	ld hl, MapTypeEnvironments
	add hl, bc
	ld a, [hl]
	; fallthrough
.got_environment
	ld [wBattleEnvironment], a
	ret

; hl -> environment pointer
; clobbers a, hl
GetEnvironmentPointer:
	ld a, [wBattleEnvironment]
	push bc
	ld b, 0
	ld c, a
	ld hl, EnvironmentData
	add hl, bc
	add hl, bc
	add hl, bc
	pop bc
	ret

; a -> camouflage type
; clobbers a, hl
GetEnvironmentCamouflage:
	call GetEnvironmentPointer
	ld a, [hl]
	ret

; hl -> move index
; clobbers a, hl
GetEnvironmentNaturePower:
	call GetEnvironmentPointer
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

INCLUDE "data/battle/environments.asm"
