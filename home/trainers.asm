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
	ld hl, MAPOBJECT_TYPE
	add hl, de
	ld a, [hl]
	cp OBJECTTYPE_TRAINER
	jr z, .is_trainer
	cp OBJECTTYPE_GENERICTRAINER
	jr nz, .next
.is_trainer

; Is visible on the map
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	cp UNASSOCIATED_MAPOBJECT
	jr z, .next

; Is facing the player...
	call GetObjectStruct
	call FacingPlayerDistance_bc
	jr nc, .next

; ...within their sight range
	ld hl, MAPOBJECT_SIGHT_RANGE
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
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld b, CHECK_FLAG
	call EventFlagAction
	pop de
	pop bc
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

	xor a
	ld [wTrainerPal], a

	ldh a, [hLastTalked]
	call GetMapObject

	ld hl, MAPOBJECT_TYPE
	add hl, bc
	ld a, [hl]
	cp OBJECTTYPE_GENERICTRAINER
	push af
	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, bc
	ld a, [wSeenTrainerBank]
	call GetFarWord
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
	endifjustbattled
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

	ld hl, OBJECT_MAP_X ; x
	add hl, bc
	ld d, [hl]

	ld hl, OBJECT_MAP_Y ; y
	add hl, bc
	ld e, [hl]

	ld a, [wPlayerMapX]
	cp d
	jr z, .CheckY

	ld a, [wPlayerMapY]
	cp e
	jr z, .CheckX

	and a
	ret

.CheckY:
	ld a, [wPlayerMapY]
	sub e
	jmp z, .NotFacing
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
	ld a, [wPlayerMapX]
	sub d
	jmp z, .NotFacing
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

	; Trainer at bc is facing the player.
	; d = distance, e = direction.
	; Check if any visible object blocks the line of sight.

	push de ; save distance/direction
	push bc ; save trainer struct pointer

	; Get trainer position
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hli]
	ld e, [hl] ; e = trainerY
	ld d, a    ; d = trainerX


	; Compute bounding box: [x_lo, x_hi] x [y_lo, y_hi]
	; Since the line of sight is axis-aligned, one range is a point
	; (min == max) and the other spans the gap between trainer and player.
	; An object on the line of sight will be within this bounding box.

	ld a, [wPlayerMapX]
	cp d
	jr c, .x_sorted
	jr z, .x_sorted
	ld b, d
	ld d, a
	ld a, b
.x_sorted:
	; a = x_lo, d = x_hi
	dec a ; precompute x_lo - 1 for fast >= check
	ldh [hMathBuffer], a
	ld a, d
	ldh [hMathBuffer + 1], a

	ld a, [wPlayerMapY]
	cp e
	jr c, .y_sorted
	jr z, .y_sorted
	ld b, e
	ld e, a
	ld a, b
.y_sorted:
	; a = y_lo, e = y_hi
	dec a ; precompute y_lo - 1
	ldh [hMathBuffer + 2], a
	ld a, e
	ldh [hMathBuffer + 3], a

	; Save trainer struct low byte to skip self in the loop
	ld a, c
	ldh [hMathBuffer + 4], a

	; Iterate through all non-player object structs
	ld bc, wObject1Struct
	ld d, NUM_OBJECT_STRUCTS - 1

.obj_loop:
	; Skip inactive objects (no sprite)
	ld a, [bc] ; OBJECT_SPRITE at offset 0
	and a
	jr z, .next_obj

	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	jr nz, .next_obj

	; Skip the trainer's own object struct
	ldh a, [hMathBuffer + 4]
	cp c
	jr z, .next_obj

	; Get object map position
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hli] ; a = objX
	ld e, [hl]  ; e = objY

	; Check if object is within the bounding box of the line of sight.
	; On the shared axis, x_lo == x_hi (or y_lo == y_hi), so the
	; inclusive range check acts as an equality check.

	; Check objX >= x_lo  (using precomputed x_lo - 1)
	ld h, a              ; h = objX
	ldh a, [hMathBuffer] ; a = x_lo - 1
	cp h                 ; (x_lo - 1) - objX
	jr nc, .next_obj     ; objX < x_lo → skip

	; Check objX <= x_hi
	ldh a, [hMathBuffer + 1] ; a = x_hi
	cp h                     ; x_hi - objX
	jr c, .next_obj          ; objX > x_hi → skip

	; Check objY >= y_lo  (using precomputed y_lo - 1)
	ldh a, [hMathBuffer + 2] ; a = y_lo - 1
	cp e                     ; (y_lo - 1) - objY
	jr nc, .next_obj         ; objY < y_lo → skip

	; Check objY <= y_hi
	ldh a, [hMathBuffer + 3] ; a = y_hi
	cp e                     ; y_hi - objY
	jr c, .next_obj          ; objY > y_hi → skip

	; Found an object blocking the line of sight!
	pop bc
	pop de
	and a ; clear carry
	ret

.next_obj:
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	dec d
	jr nz, .obj_loop

	; No blocking object found
	pop bc
	pop de ; d = distance, e = direction
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
	jmp WaitPressAorB_BlinkCursor
