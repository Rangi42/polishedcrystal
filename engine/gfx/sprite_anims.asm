DoAnimFrame:
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld a, [hl]
	call StackJumpTable

.Jumptable:
	dw DoNothing           ; SPRITE_ANIM_SEQ_NULL
	dw .PartyMon           ; SPRITE_ANIM_SEQ_PARTY_MON
	dw .PartyMonSwitch     ; SPRITE_ANIM_SEQ_PARTY_MON_SWITCH
	dw .PartyMonSelected   ; SPRITE_ANIM_SEQ_PARTY_MON_SELECTED
	dw .NamingScreenCursor ; SPRITE_ANIM_SEQ_NAMING_SCREEN_CURSOR
	dw .ComposeMailCursor  ; SPRITE_ANIM_SEQ_COMPOSE_MAIL_CURSOR
	dw .GameFreakLogo      ; SPRITE_ANIM_SEQ_GAMEFREAK_LOGO
	dw .SlotsGolem         ; SPRITE_ANIM_SEQ_SLOTS_GOLEM
	dw .SlotsChansey       ; SPRITE_ANIM_SEQ_SLOTS_CHANSEY
	dw .SlotsChanseyEgg    ; SPRITE_ANIM_SEQ_SLOTS_EGG
;	dw .DummyGameCursor    ; SPRITE_ANIM_SEQ_DUMMY_GAME_CURSOR
	dw .PokegearModeArrow  ; SPRITE_ANIM_SEQ_POKEGEAR_MODE_ARROW
	dw .TradePokeBall      ; SPRITE_ANIM_SEQ_TRADE_POKE_BALL
	dw .TradeTubeBulge     ; SPRITE_ANIM_SEQ_TRADE_TUBE_BULGE
	dw .TradeMonBubble     ; SPRITE_ANIM_SEQ_TRADEMON_IN_TUBE
	dw .RevealNewMon       ; SPRITE_ANIM_SEQ_REVEAL_NEW_MON
	dw .RadioTuningKnob    ; SPRITE_ANIM_SEQ_RADIO_TUNING_KNOB
	dw .CutGrassLeaves     ; SPRITE_ANIM_SEQ_CUT_GRASS_LEAVES
	dw .FlyFrom            ; SPRITE_ANIM_SEQ_FLY_FROM
	dw .FlyLeaf            ; SPRITE_ANIM_SEQ_FLY_LEAF
	dw .FlyTo              ; SPRITE_ANIM_SEQ_FLY_TO
	dw .IntroSuicune       ; SPRITE_ANIM_SEQ_INTRO_SUICUNE
	dw .IntroPichuWooper   ; SPRITE_ANIM_SEQ_PICHU_WOOPER
	dw .IntroUnown         ; SPRITE_ANIM_SEQ_UNOWN
	dw .IntroUnownF        ; SPRITE_ANIM_SEQ_UNOWN_F
	dw .IntroSuicuneAway   ; SPRITE_ANIM_SEQ_SUICUNE_AWAY
	dw .Celebi             ; SPRITE_ANIM_SEQ_CELEBI
	dw .MaxStatSparkle     ; SPRITE_ANIM_SEQ_MAX_STAT_SPARKLE

.PartyMon
	ld a, [wMenuCursorY]

	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	cp [hl]
	jr z, .PartyMonSwitch

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 8 * 2

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $0
	ret

.PartyMonSwitch
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 8 * 3

	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	ld d, a
	inc [hl]
	and $f
	ret nz

	ld hl, SPRITEANIMSTRUCT_0D
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
	cp $1
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

.PartyMonSelected
	ld a, [wMenuCursorY]

	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	cp [hl]
	jr z, .PartyMonSelected_offset_right

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 8 * 2
	ret

.PartyMonSelected_offset_right
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 8 * 3
	ret

.NamingScreenCursor
	farjp NamingScreen_AnimateCursor

.ComposeMailCursor
	farjp ComposeMail_AnimateCursor

.GameFreakLogo:
	farjp GameFreakLogoJumper

.SlotsGolem:
	farjp SlotMachine_AnimateGolem

.SlotsChansey:
	farcall Slots_AnimateChansey
	ld hl, wcf64
	ld a, [hl]
	cp $2
	ret nz
	ld [hl], $3
	ld a, SPRITE_ANIM_FRAMESET_SLOTS_CHANSEY_2
	jp _ReinitSpriteAnimFrame

.SlotsChanseyEgg:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	dec [hl]
	ld e, a
	and $1
	jr z, .move_vertical

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp 15 * 8
	jr c, .move_right
	call DeinitializeSprite
	ld a, $4
	ld [wcf64], a
	ld de, SFX_PLACE_PUZZLE_PIECE_DOWN
	jp PlaySFX

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

;.DummyGameCursor
;	farcall DummyGame_InterpretJoypad_AnimateCursor
;	ret

.PokegearModeArrow
	farjp AnimatePokegearModeIndicatorArrow

.TradePokeBall
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	call StackJumpTable

.TradePokeBall_Jumptable
	dw .sixteen_zero
	dw .sixteen_one
	dw .sixteen_two
	dw .sixteen_three
	dw .sixteen_four
	dw .sixteen_five

.sixteen_zero
	ld a, SPRITE_ANIM_FRAMESET_TRADE_POKE_BALL_0
	call _ReinitSpriteAnimFrame

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $2

	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $20
	ret

.sixteen_two
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_8d4af
	dec [hl]
	ret

.asm_8d4af
	call .IncrementSpriteAnimStruct0B

	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $40

.sixteen_three
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	cp $30
	jr c, .asm_8d4cd
	dec [hl]
	ld d, $28
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.asm_8d4cd
	ld de, SFX_GOT_SAFARI_BALLS
	call PlaySFX
	jr .sixteen_five

.sixteen_one
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $4

	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $30

	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld [hl], $24
	ret

.sixteen_four
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_8d51c
	ld d, a

	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz

	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $20

	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	sub $c
	ld [hl], a
	ld de, SFX_SWITCH_POKEMON
	jp PlaySFX

.asm_8d51c
	xor a

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	jp .IncrementSpriteAnimStruct0B

.sixteen_five
	jp DeinitializeSprite

.TradeTubeBulge
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	cp $b0
	jr nc, .delete
	and $3
	ret nz
	ld de, SFX_POKEBALLS_PLACED_ON_TABLE
	jp PlaySFX

.delete
	jp DeinitializeSprite

.TradeMonBubble
	farjp TradeAnim_AnimateTrademonInTube

.RevealNewMon:
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .finish_RevealNewMon
	ld d, a
	add $8
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

.finish_RevealNewMon
	jp DeinitializeSprite

.RadioTuningKnob:
	farjp AnimateTuningKnob

.CutGrassLeaves
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $80
	add hl, de
	ld e, l
	ld d, h

	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d

	ld hl, SPRITEANIMSTRUCT_0C
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

.FlyFrom:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	and a
	ret z

	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	inc [hl]
	cp $40
	ret c

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	dec [hl]

	ld hl, SPRITEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, a
	cp $40
	jr nc, .skip
	add $8
	ld [hl], a
.skip
	ld hl, SPRITEANIMSTRUCT_0E
	add hl, bc
	ld a, [hl]
	inc [hl]
	call Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.FlyLeaf:
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
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	inc [hl]
	call Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.delete_leaf
	jp DeinitializeSprite

.FlyTo:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp 10 * 8 + 4
	ret z

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
	inc [hl]

	ld hl, SPRITEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, a
	and a
	jr z, .asm_8d621
	sub $2
	ld [hl], a
.asm_8d621
	ld hl, SPRITEANIMSTRUCT_0E
	add hl, bc
	ld a, [hl]
	inc [hl]
	call Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.IntroSuicune
	ld a, [wcf65]
	and a
	ret z
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $0

	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	add $2
	ld [hl], a
	cpl
	inc a
	ld d, $20
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld a, SPRITE_ANIM_FRAMESET_INTRO_SUICUNE_2
	jp _ReinitSpriteAnimFrame

.IntroPichuWooper
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	cp $14
	ret nc
	add $2
	ld [hl], a
	cpl
	inc a
	ld d, $20
	call Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.IntroUnown
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld d, [hl]
	inc [hl]
	inc [hl]
	inc [hl]

	ld hl, SPRITEANIMSTRUCT_0C
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

.IntroUnownF
	ld a, [wcf64]
	cp $40
	ret nz
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_F_2
	jp _ReinitSpriteAnimFrame

.IntroSuicuneAway
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	add $10
	ld [hl], a
	ret

.Celebi
	farjp UpdateCelebiPosition

.MaxStatSparkle
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

.IncrementSpriteAnimStruct0B:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret
