DoAnimFrame:
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld a, [hl]
	call StackJumpTable

.Jumptable:
; entries correspond to SPRITE_ANIM_SEQ_* constants (see constants/sprite_anim_constants.asm)
	table_width 2, DoAnimFrame.Jumptable
	dw DoNothing                  ; SPRITE_ANIM_SEQ_NULL
	dw AnimSeq_PartyMon           ; SPRITE_ANIM_SEQ_PARTY_MON
	dw AnimSeq_PartyMonSwitch     ; SPRITE_ANIM_SEQ_PARTY_MON_SWITCH
	dw AnimSeq_PartyMonSelected   ; SPRITE_ANIM_SEQ_PARTY_MON_SELECTED
	dw AnimSeq_NamingScreenCursor ; SPRITE_ANIM_SEQ_NAMING_SCREEN_CURSOR
	dw AnimSeq_MailCursor         ; SPRITE_ANIM_SEQ_COMPOSE_MAIL_CURSOR
	dw AnimSeq_GameFreakLogo      ; SPRITE_ANIM_SEQ_GAMEFREAK_LOGO
	dw AnimSeq_SlotsGolem         ; SPRITE_ANIM_SEQ_SLOTS_GOLEM
	dw AnimSeq_SlotsChansey       ; SPRITE_ANIM_SEQ_SLOTS_CHANSEY
	dw AnimSeq_SlotsChanseyEgg    ; SPRITE_ANIM_SEQ_SLOTS_EGG
	;dw AnimSeq_MemoryGameCursor   ; SPRITE_ANIM_SEQ_MEMORY_GAME_CURSOR
	dw AnimSeq_PokegearArrow      ; SPRITE_ANIM_SEQ_POKEGEAR_MODE_ARROW
	dw AnimSeq_TradePokeBall      ; SPRITE_ANIM_SEQ_TRADE_POKE_BALL
	dw AnimSeq_TradeTubeBulge     ; SPRITE_ANIM_SEQ_TRADE_TUBE_BULGE
	dw AnimSeq_TrademonInTube     ; SPRITE_ANIM_SEQ_TRADEMON_IN_TUBE
	dw AnimSeq_RevealNewMon       ; SPRITE_ANIM_SEQ_REVEAL_NEW_MON
	dw AnimSeq_RadioTuningKnob    ; SPRITE_ANIM_SEQ_RADIO_TUNING_KNOB
	dw AnimSeq_CutLeaves          ; SPRITE_ANIM_SEQ_CUT_GRASS_LEAVES
	dw AnimSeq_FlyFrom            ; SPRITE_ANIM_SEQ_FLY_FROM
	dw AnimSeq_FlyLeaf            ; SPRITE_ANIM_SEQ_FLY_LEAF
	dw AnimSeq_FlyTo              ; SPRITE_ANIM_SEQ_FLY_TO
	dw AnimSeq_IntroSuicune       ; SPRITE_ANIM_SEQ_INTRO_SUICUNE
	dw AnimSeq_IntroPichuWooper   ; SPRITE_ANIM_SEQ_PICHU_WOOPER
	dw AnimSeq_IntroUnown         ; SPRITE_ANIM_SEQ_UNOWN
	dw AnimSeq_IntroUnownF        ; SPRITE_ANIM_SEQ_UNOWN_F
	dw AnimSeq_IntroSuicuneAway   ; SPRITE_ANIM_SEQ_SUICUNE_AWAY
	dw AnimSeq_Celebi             ; SPRITE_ANIM_SEQ_CELEBI
	dw AnimSeq_MaxStatSparkle     ; SPRITE_ANIM_SEQ_MAX_STAT_SPARKLE
	dw AnimSeq_PcCursor           ; SPRITE_ANIM_SEQ_PC_CURSOR
	dw AnimSeq_PcQuick            ; SPRITE_ANIM_SEQ_PC_QUICK
	dw AnimSeq_PcMode             ; SPRITE_ANIM_SEQ_PC_MODE
	dw AnimSeq_PcPack             ; SPRITE_ANIM_SEQ_PC_PACK
	assert_table_length NUM_SPRITE_ANIM_SEQS

AnimSeq_PartyMon:
	ld a, [wMenuCursorY]

	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	cp [hl]
	jr z, AnimSeq_PartyMonSwitch

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 8 * 2

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $0
	ret

AnimSeq_PartyMonSwitch:
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 8 * 3

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, a
	inc [hl]
	and $f
	ret nz

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld e, [hl]

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, d
	and $10 ; bit 4
	jr z, .load_zero
	ld a, e
	and a
	jr z, .load_minus_two
	cp 1
	jr z, .load_minus_one
.load_zero
	xor a
	ld [hl], a
	ret

.load_minus_one
	ld [hl], -1
	ret

.load_minus_two
	ld [hl], -2
	ret

AnimSeq_PartyMonSelected:
	ld a, [wMenuCursorY]

	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	cp [hl]
	jr z, .three_offset_right

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 8 * 2
	ret

.three_offset_right
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 8 * 3
	ret

AnimSeq_NamingScreenCursor:
	farjp NamingScreen_AnimateCursor

AnimSeq_MailCursor:
	farjp ComposeMail_AnimateCursor

AnimSeq_GameFreakLogo:
	farjp GameFreakLogoJumper

AnimSeq_SlotsGolem:
	farjp SlotMachine_AnimateGolem

AnimSeq_SlotsChansey:
	farcall Slots_AnimateChansey
	ld hl, wSlotsDelay
	ld a, [hl]
	cp 2
	ret nz
	ld [hl], 3
	ld a, SPRITE_ANIM_FRAMESET_SLOTS_CHANSEY_2
	jmp _ReinitSpriteAnimFrame

AnimSeq_SlotsChanseyEgg:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	dec [hl]
	ld e, a
	and 1
	jr z, .move_vertical

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp 15 * 8
	jr c, .move_right
	call DeinitializeSprite
	ld a, 4
	ld [wSlotsDelay], a
	ld de, SFX_PLACE_PUZZLE_PIECE_DOWN
	jmp PlaySFX

.move_right
	inc [hl]
.move_vertical
	ld a, e
	ld d, $20
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

;AnimSeq_MemoryGameCursor:
	;farjp MemoryGame_InterpretJoypad_AnimateCursor

AnimSeq_PokegearArrow:
	farjp AnimatePokegearModeIndicatorArrow

AnimSeq_TradePokeBall:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	call StackJumpTable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .delete

.zero
	ld a, SPRITE_ANIM_FRAMESET_TRADE_POKE_BALL_0
	call _ReinitSpriteAnimFrame

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], 2

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $20
	ret

.two
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	dec [hl]
	ret

.next
	call AnimSeqs_IncAnonJumptableIndex

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $40

.three
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp 48
	jr c, .done
	dec [hl]
	ld d, 40
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.done
	ld de, SFX_GOT_SAFARI_BALLS
	call PlaySFX
	jr .delete

.one
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $4

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $24
	ret

.four
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done2
	ld d, a

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $20

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	sub $c
	ld [hl], a
	ld de, SFX_SWITCH_POKEMON
	jmp PlaySFX

.done2
	xor a

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	jmp AnimSeqs_IncAnonJumptableIndex

.delete
	jmp DeinitializeSprite

AnimSeq_TradeTubeBulge:
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	cp $b0
	jr nc, .delete
	and 3
	ret nz
	ld de, SFX_POKEBALLS_PLACED_ON_TABLE
	jmp PlaySFX

.delete
	jmp DeinitializeSprite

AnimSeq_TrademonInTube:
	farjp TradeAnim_AnimateTrademonInTube

AnimSeq_RevealNewMon:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .finish_EggShell
	ld d, a
	add 8
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	xor $20
	ld [hl], a

	push af
	push de
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a

	pop de
	pop af
	call Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.finish_EggShell
	jmp DeinitializeSprite

AnimSeq_RadioTuningKnob:
	farjp AnimateTuningKnob

AnimSeq_CutLeaves:
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $80
	add hl, de
	ld e, l
	ld d, h

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	push af
	push de
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_FlyFrom:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	and a
	ret z

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	cp $40
	ret c

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	dec [hl]

	ld hl, SPRITEANIMSTRUCT_VAR4
	add hl, bc
	ld a, [hl]
	ld d, a
	cp $40
	jr nc, .skip
	add 8
	ld [hl], a
.skip
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	ld a, [hl]
	inc [hl]
	call Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_FlyLeaf:
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp -9 * 8
	jr nc, .delete_leaf
	inc [hl]
	inc [hl]

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]

	ld d, $40
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	call Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.delete_leaf
	jmp DeinitializeSprite

AnimSeq_FlyTo:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp 10 * 8 + 4
	ret z

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
	inc [hl]

	ld hl, SPRITEANIMSTRUCT_VAR4
	add hl, bc
	ld a, [hl]
	ld d, a
	and a
	jr z, .stay
	sub 2
	ld [hl], a
.stay
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	ld a, [hl]
	inc [hl]
	call Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_IntroSuicune:
	ld a, [wIntroSceneTimer]
	and a
	ret z
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], 0

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	add 2
	ld [hl], a
	cpl
	inc a
	ld d, 32
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld a, SPRITE_ANIM_FRAMESET_INTRO_SUICUNE_2
	jmp _ReinitSpriteAnimFrame

AnimSeq_IntroPichuWooper:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp 20
	ret nc
	add 2
	ld [hl], a
	cpl
	inc a
	ld d, 32
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_IntroUnown:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld d, [hl]
	inc [hl]
	inc [hl]
	inc [hl]

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	push af
	push de
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_IntroUnownF:
	ld a, [wIntroSceneFrameCounter]
	cp $40
	ret nz
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_F_2
	jmp _ReinitSpriteAnimFrame

AnimSeq_IntroSuicuneAway:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	add 16
	ld [hl], a
	ret

AnimSeq_Celebi:
	farjp UpdateCelebiPosition

AnimSeq_MaxStatSparkle:
	ldh a, [hVBlankCounter]
	push af
	ld d, 4
	call Sine
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop af
	ld d, 16
	call Cosine
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_PcCursor:
	push de
	push bc
	farcall BillsPC_GetCursorSlot
	farcall BillsPC_GetXYFromStorageBox
	pop bc
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], d
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], e
	pop de

	; Check for static cursor
	ld a, [wBillsPC_CursorAnimFlag]
	and a
	ret z

	; If we're picking up, the PC UI handles this flag.
	cp PCANIM_PICKUP
	jr c, .not_picking
	sub PCANIM_PICKUP - 1
	add [hl]
	ld [hl], a
	ret
.not_picking
	cp PCANIM_ANIMATE / 2 + 1
	jr c, .dont_bop
	inc [hl]
	inc [hl]
.dont_bop
	dec a
	ld [wBillsPC_CursorAnimFlag], a
	ret nz
	ld a, PCANIM_ANIMATE
	ld [wBillsPC_CursorAnimFlag], a
	ret

AnimSeq_PcQuick:
	; Moves a storage system mini from one destination to another.
	push de

	; Check if the animation has concluded
	ld hl, wBillsPC_QuickFrames
	inc [hl]
	dec [hl]
	jr z, .finish_anim
	dec [hl]

	; Handle x movement.
	ld a, [wBillsPC_QuickFromX]
	ld d, a
	ld a, [wBillsPC_QuickToX]
	ld e, a
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	call .ShiftPos
	ld a, [wBillsPC_QuickFromY]
	ld d, a
	ld a, [wBillsPC_QuickToY]
	ld e, a
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	call .ShiftPos
	jr .done

.finish_anim
	farcall BillsPC_FinishQuickAnim
	; fallthrough
.done
	pop de
	ret

.ShiftPos:
	; Set sprite position depending on movement frame.
	push hl
	push bc

	; Compute the difference between the coordinates
	ld a, d
	sub e

	; Load the result into bc. This sets b to $ff if we got a negative result.
	ld c, a
	sbc a
	ld b, a

	; Multiply by the frame number.
	xor a
	ld h, a
	ld l, a
	ld a, [wBillsPC_QuickFrames]
	inc a
.loop
	dec a
	jr z, .got_multiplier
	add hl, bc
	jr .loop
.got_multiplier
	; Divide by 8 and put 8bit result in a.
	ld a, l
	sra h
	rra
	sra h
	rra
	sra h
	rra

	; Get resulting coordinate.
	add e

	; Write to sprite anim coord.
	pop bc
	pop hl
	add hl, bc
	ld [hl], a
	ret

AnimSeq_PcMode:
	ld a, [wBillsPC_CursorMode]
	ld h, a
	add h
	add h
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], a
	ret

AnimSeq_PcPack:
	; Display male or female pack
	ld a, [wPlayerGender]
	add a
	add a
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], a

	; Hide pack outside Item mode
	farcall BillsPC_CheckBagDisplay
	ld a, $80 ; move it out of view
	jr nz, .got_pack_y
	xor a
.got_pack_y
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeqs_IncAnonJumptableIndex:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret
