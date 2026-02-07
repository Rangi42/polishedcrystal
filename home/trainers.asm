CheckTrainerBattle::
; Check if any trainer on the map sees the player and wants to battle.
	ldh a, [hROMBank]
	push af

	call SwitchToMapScriptsBank

; Skip the player object.
	ld a, 1
	ld de, wMapObjects + MAPOBJECT_LENGTH

.loop
; Start a battle if the object:
	push af
	push de

; Has a sprite
	assert MAPOBJECT_SPRITE == 1
	; hl = MAPOBJECT_SPRITE + de
	ld h, d
	ld l, e
	inc hl
	ld a, [hl]
	and a
	jr z, .next

; Is a trainer
	ld hl, MAPOBJECT_TYPE
	add hl, de
	ld a, [hl]
	sub OBJECTTYPE_TRAINER
	jr z, .is_trainer
	assert OBJECTTYPE_TRAINER + 1 == OBJECTTYPE_GENERICTRAINER
	dec a ; cp OBJECTTYPE_GENERICTRAINER
	jr nz, .next

.is_trainer
; Is visible on the map
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	assert UNASSOCIATED_MAPOBJECT == -1
	inc a ; cp UNASSOCIATED_MAPOBJECT
	jr z, .next
	dec a

; Is facing the player...
	call GetObjectStruct
	push de
	call FacingPlayerDistance
	pop de
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

	xor a ; clear carry (no trainer battle)

.done
	pop bc
	ld a, b
	rst Bankswitch
	ret

.startbattle
	pop de
	pop af
	ldh [hLastTalked], a
	call TalkToTrainerAtBC
	scf ; set carry (start trainer battle)
	jr .done

TalkToTrainer::
	lb bc, 1, -1
TalkToTrainerAtBC::
	ld a, b
	ld [wSeenTrainerDistance], a
	ld a, c
	ld [wSeenTrainerDirection], a

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
	ld a, LOW(.GenericTrainerScript)
	ld [hli], a
	ld [hl], HIGH(.GenericTrainerScript)

	; store after-battle text in wStashedTextPointer
	ld hl, wStashedTextPointer
	ld a, e
	ld [hli], a
	ld a, d
	ld [hl], a

.notGenericTrainer
	xor a
	ld [wRunningTrainerBattleScript], a
	ret

.GenericTrainerScript:
	endifjustbattled
	jumpstashedtext

FacingPlayerDistance::
; Return carry if the sprite at bc is facing the player,
; and its distance in b and direction in c.

	ld hl, OBJECT_MAP_X
	assert OBJECT_MAP_X + 1 == OBJECT_MAP_Y
	add hl, bc
	ld a, [hli]
	ld d, a    ; x
	ld e, [hl] ; y

	ld a, [wPlayerMapX]
	cp d
	jr z, .CheckY

	ld a, [wPlayerMapY]
	cp e
	jr z, .CheckX

.NotFacing:
	and a ; clear carry
	ret

.CheckY:
	ld a, [wPlayerMapY]
	sub e
	jr z, .NotFacing
	jr nc, .Above

; Below
	cpl
	inc a
	ld e, OW_UP
	jr .CheckFacing

.Above:
	ld e, OW_DOWN
	jr .CheckFacing

.CheckX:
	ld a, [wPlayerMapX]
	sub d
	jr z, .NotFacing
	jr nc, .Left

; Right
	cpl
	inc a
	ld e, OW_LEFT
	jr .CheckFacing

.Left:
	ld e, OW_RIGHT

.CheckFacing:
	ld d, a

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
	ldh [hLineOfSightXLo], a
	ld a, d
	ldh [hLineOfSightXHi], a

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
	ldh [hLineOfSightYLo], a
	ld a, e
	ldh [hLineOfSightYHi], a

	; Save trainer struct low byte to skip self in the loop
	ld a, c
	ldh [hTrainerSeeing], a

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
	ldh a, [hTrainerSeeing]
	cp c
	jr z, .next_obj

	; Get object map position
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hli]
	ld e, [hl] ; e = objY
	ld h, a    ; h = objX

	; Check if object is within the bounding box of the line of sight.
	; On the shared axis, x_lo == x_hi (or y_lo == y_hi), so the
	; inclusive range check acts as an equality check.

	; Check objX >= x_lo  (using precomputed x_lo - 1)
	ldh a, [hLineOfSightXLo] ; a = x_lo - 1
	cp h                     ; (x_lo - 1) - objX
	jr nc, .next_obj         ; objX < x_lo → skip

	; Check objX <= x_hi
	ldh a, [hLineOfSightXHi] ; a = x_hi
	cp h                     ; x_hi - objX
	jr c, .next_obj          ; objX > x_hi → skip

	; Check objY >= y_lo  (using precomputed y_lo - 1)
	ldh a, [hLineOfSightYLo] ; a = y_lo - 1
	cp e                     ; (y_lo - 1) - objY
	jr nc, .next_obj         ; objY < y_lo → skip

	; Check objY <= y_hi
	ldh a, [hLineOfSightYHi] ; a = y_hi
	cp e                     ; y_hi - objY
	jr c, .next_obj          ; objY > y_hi → skip

	; Found an object blocking the line of sight!
	pop bc
	pop bc
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
	pop bc ; b = distance, c = direction
	scf
	ret

PrintWinLossText::
	ld a, [wBattleResult]
	and $f
	ld hl, wWinTextPointer
	jr z, .got_pointer
	assert wWinTextPointer + 2 == wLossTextPointer
	inc hl
	inc hl
.got_pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapScriptsBank]
	call FarPrintText
	call ApplyTilemapInVBlank
	jmp WaitPressAorB_BlinkCursor
