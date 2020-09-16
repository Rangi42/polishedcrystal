CheckTrainerBattle::
	ldh a, [hROMBank]
	push af

	call SwitchToMapScriptsBank
	call _CheckTrainerBattle

	pop bc
	ld a, b
	rst Bankswitch
	ret

_CheckTrainerBattle::
; Check if any trainer on the map sees the player and wants to battle.

; Skip the player object.
	ld a, 1
	ld de, wMapObjects + MAPOBJECT_LENGTH

.loop

; Start a battle if the object:

	push af
	push de

; Has a sprite
	ld hl, MAPOBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next

; Is a trainer
	ld hl, MAPOBJECT_COLOR
	add hl, de
	ld a, [hl]
	and $f
	cp OBJECTTYPE_TRAINER
	jr z, .is_trainer
	cp OBJECTTYPE_GENERICTRAINER
	jr nz, .next
.is_trainer

; Is visible on the map
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .next

; Is facing the player...
	call GetObjectStruct
	call FacingPlayerDistance_bc
	jr nc, .next

; ...within their sight range
	ld hl, MAPOBJECT_RANGE
	add hl, de
	ld a, [hl]
	cp b
	jr c, .next

; And hasn't already been beaten
	push bc
	push de
	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	pop de
	pop bc
	and a
	jr z, .startbattle

.next
	pop de
	ld hl, MAPOBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	xor a
	ret

.startbattle
	pop de
	pop af
	ldh [hLastTalked], a
	ld a, b
	ld [wSeenTrainerDistance], a
	ld a, c
	ld [wSeenTrainerDirection], a
	jr LoadTrainer_continue

TalkToTrainer::
	ld a, 1
	ld [wSeenTrainerDistance], a
	ld a, -1
	ld [wSeenTrainerDirection], a

LoadTrainer_continue::
	ld a, [wMapScriptsBank]
	ld [wSeenTrainerBank], a

	ldh a, [hLastTalked]
	call GetMapObject

	ld hl, MAPOBJECT_COLOR
	add hl, bc
	ld a, [hl]
	and $f
	cp OBJECTTYPE_GENERICTRAINER
	push af
	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, bc
	ld a, [wSeenTrainerBank]
	call GetFarHalfword
	ld de, wTempTrainer
	pop af
	push af
	ld bc, wGenericTempTrainerHeaderEnd - wTempTrainer
	jr z, .skipCopyingLossPtrAndScriptPtr
	ld bc, wTempTrainerEnd - wTempTrainer
.skipCopyingLossPtrAndScriptPtr
	ld a, [wSeenTrainerBank]
	call FarCopyBytes
	pop af
	jr nz, .notGenericTrainer
	call SwapHLDE
	; store 0 loss pointer
	xor a
	ld [hli], a
	ld [hli], a
	; store generic trainer script in script pointer
	ld a, LOW(.generic_trainer_script)
	ld [hli], a
	ld [hl], HIGH(.generic_trainer_script)
	; store after-battle text in wStashedTextPointer
	ld hl, wStashedTextPointer
	ld a, e
	ld [hli], a
	ld a, d
	ld [hl], a
.notGenericTrainer
	xor a
	ld [wRunningTrainerBattleScript], a
	scf
	ret

.generic_trainer_script
	end_if_just_battled
	jumpstashedtext

FacingPlayerDistance_bc::
	push de
	call FacingPlayerDistance
	ld b, d
	ld c, e
	pop de
	ret

FacingPlayerDistance::
; Return carry if the sprite at bc is facing the player,
; and its distance in d.

	ld hl, OBJECT_NEXT_MAP_X ; x
	add hl, bc
	ld d, [hl]

	ld hl, OBJECT_NEXT_MAP_Y ; y
	add hl, bc
	ld e, [hl]

	ld a, [wPlayerStandingMapX]
	cp d
	jr z, .CheckY

	ld a, [wPlayerStandingMapY]
	cp e
	jr z, .CheckX

	and a
	ret

.CheckY:
	ld a, [wPlayerStandingMapY]
	sub e
	jr z, .NotFacing
	jr nc, .Above

; Below
	cpl
	inc a
	ld d, a
	ld e, OW_UP
	jr .CheckFacing

.Above:
	ld d, a
	ld e, OW_DOWN
	jr .CheckFacing

.CheckX:
	ld a, [wPlayerStandingMapX]
	sub d
	jr z, .NotFacing
	jr nc, .Left

; Right
	cpl
	inc a
	ld d, a
	ld e, OW_LEFT
	jr .CheckFacing

.Left:
	ld d, a
	ld e, OW_RIGHT

.CheckFacing:
	call GetSpriteDirection
	cp e
	jr nz, .NotFacing
	scf
	ret

.NotFacing:
	and a
	ret

PrintWinLossText::
	ld a, [wBattleResult]
	ld hl, wWinTextPointer
	and $f
	jr z, .ok
	ld hl, wLossTextPointer

.ok
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapScriptsBank]
	call FarPrintText
	call ApplyTilemapInVBlank
	jp WaitPressAorB_BlinkCursor
