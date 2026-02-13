FarDeinitBattleAnimation:
	farjp DeinitBattleAnimation

FarReinitBattleAnimFrameset:
	farjp ReinitBattleAnimFrameset

DoBattleAnimFrame:
	ld hl, BATTLEANIMSTRUCT_FUNCTION
	add hl, bc
	ld a, [hl]
	call StackJumpTable

.Jumptable:
; entries correspond to BATTLEANIMFUNC_* constants
	table_width 2
	dw BattleAnimFunction_Null
	dw BattleAnimFunction_MoveFromUserToTarget
	dw BattleAnimFunction_MoveFromUserToTargetAndDisappear
	dw BattleAnimFunction_MoveInCircle
	dw BattleAnimFunction_MoveWaveToTarget
	dw BattleAnimFunction_ThrowFromPlayerToEnemy
	dw BattleAnimFunction_ThrowFromPlayerToEnemyAndDisappear
	dw BattleAnimFunction_Drop
	dw BattleAnimFunction_MoveFromUserToTargetSpinAround
	dw BattleAnimFunction_Shake
	dw BattleAnimFunction_FireBlast
	dw BattleAnimFunction_RazorLeaf
	dw BattleAnimFunction_Bubble
	dw BattleAnimFunction_Surf
	dw BattleAnimFunction_Sing
	dw BattleAnimFunction_WaterGun
	dw BattleAnimFunction_Ember
	dw BattleAnimFunction_Powder
	dw BattleAnimFunction_PokeBall
	dw BattleAnimFunction_PokeBallBlocked
	dw BattleAnimFunction_Recover
	dw BattleAnimFunction_ThunderWave
	dw BattleAnimFunction_Clamp_Encore
	dw BattleAnimFunction_Bite
	dw BattleAnimFunction_SolarBeam
	dw BattleAnimFunction_Gust
	dw BattleAnimFunction_RazorWind
	dw BattleAnimFunction_Kick
	dw BattleAnimFunction_Absorb
	dw BattleAnimFunction_Egg
	dw BattleAnimFunction_MoveUp
	dw BattleAnimFunction_Wrap
	dw BattleAnimFunction_LeechSeed
	dw BattleAnimFunction_Sound
	dw BattleAnimFunction_ConfuseRay
	dw BattleAnimFunction_Dizzy
	dw BattleAnimFunction_Amnesia
	dw BattleAnimFunction_FloatUp
	dw BattleAnimFunction_Dig
	dw BattleAnimFunction_String
	dw BattleAnimFunction_Paralyzed
	dw BattleAnimFunction_SpiralDescent
	dw BattleAnimFunction_PoisonGas
	dw BattleAnimFunction_Horn
	dw BattleAnimFunction_Needle
	dw BattleAnimFunction_PetalDance
	dw BattleAnimFunction_ThiefPayday
	dw BattleAnimFunction_AbsorbCircle
	dw BattleAnimFunction_Bonemerang
	dw BattleAnimFunction_Shiny
	dw BattleAnimFunction_SkyAttack
	dw BattleAnimFunction_GrowthSwordsDance
	dw BattleAnimFunction_SmokeFlameWheel
	dw BattleAnimFunction_PresentSmokescreen
	dw BattleAnimFunction_StrengthSeismicToss
	dw BattleAnimFunction_SpeedLine
	dw BattleAnimFunction_Sludge
	dw BattleAnimFunction_MetronomeHand
	dw BattleAnimFunction_MetronomeSparkleSketch
	dw BattleAnimFunction_Agility
	dw BattleAnimFunction_SacredFire
	dw BattleAnimFunction_SafeguardProtect
	dw BattleAnimFunction_LockOnMindReader
	dw BattleAnimFunction_Spikes
	dw BattleAnimFunction_HealBellNotes
	dw BattleAnimFunction_BatonPass
	dw BattleAnimFunction_Conversion
	dw BattleAnimFunction_EncoreBellyDrum
	dw BattleAnimFunction_SwaggerMorningSun
	dw BattleAnimFunction_HiddenPower
	dw BattleAnimFunction_HiddenPower_Fast
	dw BattleAnimFunction_Curse
	dw BattleAnimFunction_PerishSong
	dw BattleAnimFunction_RapidSpin
	dw BattleAnimFunction_BetaPursuit
	dw BattleAnimFunction_RainSandstorm
	dw BattleAnimFunction_AnimObjB0
	dw BattleAnimFunction_PsychUp
	dw BattleAnimFunction_AncientPower
	dw BattleAnimFunction_RockSmash
	dw BattleAnimFunction_Cotton
	dw BattleAnimFunction_PauseThenRush
	dw BattleAnimFunction_RockTomb
	dw BattleAnimFunction_PowerGem
	dw BattleAnimFunction_BubbleSplash
	dw BattleAnimFunction_Moon
	dw BattleAnimFunction_PokeBall_BG
	dw BattleAnimFunction_AirCutter
	dw BattleAnimFunction_RadialMoveOut
	dw BattleAnimFunction_RadialMoveOut_Slow
	dw BattleAnimFunction_RadialMoveOut_VerySlow
	dw BattleAnimFunction_RadialMoveOut_Fast
	dw BattleAnimFunction_RadialMoveOut_Spore
	dw BattleAnimFunction_RadialMoveOut_Stats
	dw BattleAnimFunction_PowerUp
	dw BattleAnimFunction_Roost
	dw BattleAnimFunction_LastResort
	dw BattleAnimFunction_DarkPulse
	dw BattleAnimFunction_SpiralDescent_Fast
	dw BattleAnimFunction_RadialMoveIn
	dw BattleAnimFunction_NightSlash
	assert_table_length NUM_BATTLEANIMFUNCS

BattleAnim_AnonJumptable:
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	jmp OffsetStackJumpTable

BattleAnim_IncAnonJumptableIndex:
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_Null:
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothing
	dw FarDeinitBattleAnimation

BattleAnimFunction_ThrowFromPlayerToEnemyAndDisappear:
	call BattleAnimFunction_ThrowFromPlayerToEnemy
	ret c
	jmp FarDeinitBattleAnimation

BattleAnimFunction_ThrowFromPlayerToEnemy:
	; If x coord at $88 or beyond, abort.
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	ret nc
	; Move right 2 pixels
	add $2
	ld [hl], a
	; Move down 1 pixel
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	; Decrease ??? and hold onto its previous value (argument of the sine function)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	; Get ???, which is the amplitude of the sine function
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	farcall Sine
	; Store the result in the Y offset
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	; Carry flag denotes success
	scf
	ret

BattleAnimFunction_MoveWaveToTarget:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jmp nc, FarDeinitBattleAnimation

	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
rept 4
	inc [hl]
endr
	ld d, $10
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	sra a
	sra a
	sra a
	sra a
	ld [hl], a
	ret

BattleAnimFunction_MoveInCircle:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	xor a
	bit 7, [hl]
	jr z, .got_starting_position
	ld a, $20
.got_starting_position
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_MoveFromUserToTarget:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw FarDeinitBattleAnimation

.zero
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	ret nc
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jmp BattleAnim_StepToTarget

BattleAnimFunction_MoveFromUserToTargetAndDisappear:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jr nc, .done
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jmp BattleAnim_StepToTarget

.done
	jmp FarDeinitBattleAnimation

BattleAnimFunction_PokeBall_BG:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .load_ball_palette
	dw BattleAnimFunction_PokeBall.throw_ball
	dw DoNothing
	dw BattleAnimFunction_PokeBall.prepare_bounce
	dw BattleAnimFunction_PokeBall.bounce
	dw DoNothing
	dw BattleAnimFunction_PokeBall.shake
	dw BattleAnimFunction_PokeBall.seven
	dw BattleAnimFunction_PokeBall.eight_or_ten
	dw DoNothing
	dw BattleAnimFunction_PokeBall.eight_or_ten
	dw FarDeinitBattleAnimation
	dw BattleAnimFunction_PokeBall.twelve
	dw DoNothing
	dw BattleAnimFunction_PokeBall.fourteen
	dw DoNothing

.load_ball_palette
	call GetBallAnimBGPal
	jmp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_PokeBall:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .load_ball_palette
	dw .throw_ball
	dw DoNothing
	dw .prepare_bounce
	dw .bounce
	dw DoNothing
	dw .shake
	dw .seven
	dw .eight_or_ten
	dw DoNothing
	dw .eight_or_ten
	dw FarDeinitBattleAnimation
	dw .twelve
	dw DoNothing
	dw .fourteen
	dw DoNothing

.load_ball_palette
	call GetBallAnimPal
	jmp BattleAnim_IncAnonJumptableIndex

.throw_ball
	; throw the ball; if the ball hasn't reached the enemy yet, we're done
	call BattleAnimFunction_ThrowFromPlayerToEnemy
	ret c
	; absorb the Y offset into the coordinate...
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	; ...select a new frameset, and move onto the next part of the animation
	ld a, BATTLEANIMFRAMESET_0B
	call FarReinitBattleAnimFrameset
	jmp BattleAnim_IncAnonJumptableIndex

.prepare_bounce
	; initialize the parameters for the bounce; make sure this is only done once
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_09
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	; initial height 16, angle 0
	xor a
	ld [hli], a
	ld [hl], 16
.bounce
	; bounce up based on a sine wave with the current parameters (the angle is
	; always negative, creating a negative Y offset)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	dec [hl]
	ld a, [hl]
	; if we didn't reach -180°, do nothing
	and $1f
	ret nz
	ld [hl], a
	; otherwise, reset the angle and reduce the bounce height by 4
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	sub 4
	ld [hl], a
	ret nz
	; if the bounce height became 0, load a new frameset and go to the next part of the animation
	ld a, BATTLEANIMFRAMESET_0C
	call FarReinitBattleAnimFrameset
	jmp BattleAnim_IncAnonJumptableIndex

.shake
	ld a, BATTLEANIMFRAMESET_0D
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	dec [hl]
	ret

; Bottom of the PokeBall
.seven ; open
	call GetBallAnimPal
	ld a, BATTLEANIMFRAMESET_0A
	call FarReinitBattleAnimFrameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $20
.eight_or_ten ; close
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	dec [hl]
	ld a, [hl]
	and $1f
	jmp z, FarDeinitBattleAnimation
	and $f
	ret nz
	jmp BattleAnim_IncAnonJumptableIndex

.twelve
; critical shake
	ld a, BATTLEANIMFRAMESET_0C
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_VAR3
	add hl, bc
	ld [hl], $10
	jmp BattleAnim_IncAnonJumptableIndex

.fourteen
	ld hl, BATTLEANIMSTRUCT_VAR3
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	; a = ($10 - a) * 4
	cpl
	add $10 + 1
	add a
	add a
	ld d, 2
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.done
	ld a, BATTLEANIMFRAMESET_09
	call FarReinitBattleAnimFrameset
	jmp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_PokeBallBlocked:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero
	call GetBallAnimPal
	jmp BattleAnim_IncAnonJumptableIndex

.one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $70
	jmp c, BattleAnimFunction_ThrowFromPlayerToEnemy

	call BattleAnim_IncAnonJumptableIndex
.two
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .done
	add $4
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
	dec [hl]
	ret

.done
	jmp FarDeinitBattleAnimation

; When throwing a ball, the ANIM_GFX_SMOKE uses GRAY, ANIM_GFX_SPEED for Master Ball uses YELLOW,
; and weather icons may use YELLOW/BLUE/BROWN/GRAY.
; RED is free for the ball and GREEN for the white background.

GetBallAnimPal:
	ld hl, BATTLEANIMSTRUCT_PALETTE
	add hl, bc
	ld [hl], PAL_BATTLE_OB_RED
	ret

GetBallAnimBGPal:
	ld hl, BATTLEANIMSTRUCT_PALETTE
	add hl, bc
	ld [hl], PAL_BATTLE_OB_GREEN
	ret

BattleAnimFunction_Ember:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw FarDeinitBattleAnimation
	dw .three
	dw DoNothing

.zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	swap a
	and $f
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

.one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	ret nc
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jmp BattleAnim_StepToTarget

.three
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_0F
	jmp FarReinitBattleAnimFrameset

BattleAnimFunction_Drop:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, $30
	ld [hli], a
	ld [hl], $48
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $20
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	sub [hl]
	jr z, .done
	jr c, .done
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ret

.done
	jmp FarDeinitBattleAnimation

BattleAnimFunction_MoveFromUserToTargetSpinAround:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three

.zero
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	jr c, .SetCoords
	call BattleAnim_IncAnonJumptableIndex
.one
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $0
.two
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $40
	jr nc, .loop_back
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $18
	farcall Cosine
	sub $18
	sra a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $18
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	add [hl]
	ld [hl], a
	ret

.loop_back
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	jr z, .finish
	sub $10
	ld d, a
	ld a, [hl]
	and $f
	or d
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	dec [hl]
	ret

.finish
	call BattleAnim_IncAnonJumptableIndex
.three
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $b0
	jmp nc, FarDeinitBattleAnimation

.SetCoords:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld e, a
	srl e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
.loop
	dec [hl]
	dec e
	jr nz, .loop
	ret

BattleAnimFunction_Shake:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw FarDeinitBattleAnimation

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done_one
	dec [hl]
	ret

.done_one
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	swap a
	and $f
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ret

BattleAnimFunction_FireBlast:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .five
	dw DoNothing
	dw .seven
	dw .eight
	dw FarDeinitBattleAnimation

.zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	cp $7
	jr z, .seven
	ld a, BATTLEANIMFRAMESET_BURNED
	jmp FarReinitBattleAnimFrameset

.seven
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jr nc, .set_up_eight
	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

.set_up_eight
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_10
	call FarReinitBattleAnimFrameset
.eight
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ret

.one
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	dec [hl]
	ret

.four
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	inc [hl]
.two
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	dec [hl]
	ret

.five
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	inc [hl]
.three
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_RazorLeaf:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw BattleAnim_IncAnonJumptableIndex
	dw BattleAnim_IncAnonJumptableIndex
	dw BattleAnim_IncAnonJumptableIndex
	dw BattleAnim_IncAnonJumptableIndex
	dw .eight

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $40
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $30
	jr nc, .sine_cosine
	call BattleAnim_IncAnonJumptableIndex
	xor a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hli], a
	ld [hl], a
	ld a, BATTLEANIMFRAMESET_17
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 6, [hl]
	ret z
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], $5
	ret

.sine_cosine
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $3f
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	call BattleAnim_ScatterHorizontal
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ret

.two
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $20
	jmp z, FarDeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 6, [hl]
	jr nz, .decrease
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	jr .finish

.decrease
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	dec [hl]
.finish
	ld de, $80
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ret

.three
	ld a, BATTLEANIMFRAMESET_RAZOR_LEAF_1
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_OAMFLAGS
	add hl, bc
	res 5, [hl]
	jmp BattleAnim_IncAnonJumptableIndex

.eight
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $c0
	ret nc
	ld a, $8
	jmp BattleAnim_StepToTarget

BattleAnim_ScatterHorizontal:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	bit 7, a
	jr nz, .negative
	cp $20
	jr nc, .plus_256
	cp $18
	jr nc, .plus_384
	ld de, $200
	ret

.plus_384
	ld de, $180
	ret

.plus_256
	ld de, $100
	ret

.negative
	and $3f
	cp $20
	jr nc, .minus_256
	cp $18
	jr nc, .minus_384
	ld de, -$200
	ret

.minus_384
	ld de, -$180
	ret

.minus_256
	ld de, -$100
	ret

BattleAnimFunction_BubbleSplash:
	call BattleAnim_AnonJumptable
.anon_dw
	dw BattleAnimFunction_RockSmash.after_frameset
	dw BattleAnimFunction_RockSmash.one

BattleAnimFunction_RockSmash:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $40
	rlca
	rlca
	add $19
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
.after_frameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $40
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $30
	jmp c, FarDeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $3f
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	call BattleAnim_ScatterHorizontal
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ret

BattleAnimFunction_Bubble:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $c
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jmp BattleAnim_StepToTarget

.next
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $0
	ld a, BATTLEANIMFRAMESET_22
	call FarReinitBattleAnimFrameset
.two
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $98
	jr nc, .okay
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	ld de, $60
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
.okay
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $20
	ret c
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	ld e, a
	ld d, $ff
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

BattleAnimFunction_Surf:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw DoNothing
	dw .three
	dw FarDeinitBattleAnimation

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, rIE
	set B_IE_STAT, [hl]
	ld a, LOW(rSCY)
	ldh [hLCDCPointer], a
	ld a, $58
	ldh [hLYOverrideStart], a
	ld a, $5e
	ldh [hLYOverrideEnd], a
	ret

.one
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp e
	jr nc, .move
	call BattleAnim_IncAnonJumptableIndex
	xor a
	ldh [hLYOverrideStart], a
	ret

.move
	dec a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	sub $10
	ret c
	ldh [hLYOverrideStart], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	inc a
	and $7
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	inc [hl]
	ret

.three
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $70
	jr c, .move_down
	ld hl, rIE
	res B_IE_STAT, [hl]
	xor a
	ldh [hLCDCPointer], a
	ldh [hLYOverrideStart], a
	ldh [hLYOverrideEnd], a
	jmp FarDeinitBattleAnimation

.move_down:
	inc a
	inc a
	ld [hl], a
	sub $10
	ret c
	ldh [hLYOverrideStart], a
	ret

BattleAnimFunction_Sing:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, BATTLEANIMFRAMESET_24
	add [hl] ; offset
	call FarReinitBattleAnimFrameset
.one:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $b8
	jmp nc, FarDeinitBattleAnimation

	ld a, $2
	call BattleAnim_StepToTarget
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	ld d, $8
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_WaterGun:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw DoNothing

.zero:
	call BattleAnim_IncAnonJumptableIndex
.one:
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $2c
	jr c, .run_down
	ld a, $2
	call BattleAnim_StepToTarget
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	ld d, $8
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.run_down
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_28
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], $2c
	ld hl, BATTLEANIMSTRUCT_OAMFLAGS
	add hl, bc
	ld a, [hl]
	and $1
	ld [hl], a
.two:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $18
	jr nc, .splash
	inc [hl]
	ret

.splash
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_29
	jmp FarReinitBattleAnimFrameset

BattleAnimFunction_Powder:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $38
	jmp nc, FarDeinitBattleAnimation

	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld l, [hl]
	ld h, a
	ld de, $80
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	xor $10
	ld [hl], a
	ret

BattleAnimFunction_Recover:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	add a
	add a
	add a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld [hl], $1
.one:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jmp z, FarDeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld d, [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	xor $1
	ld [hl], a
	ret z
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_ThunderWave:
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothing
	dw .one
	dw DoNothing
	dw FarDeinitBattleAnimation

.one:
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_35
	jmp FarReinitBattleAnimFrameset

BattleAnimFunction_Clamp_Encore:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .two
	dw .two
	dw .two
	dw .six

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 7, [hl]
	jr nz, .flipped
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $10
	jr .got_sine_start

.flipped
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30
.got_sine_start
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
.one:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	bit 7, a
	jr nz, .load_no_inc
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc a
	jr .reinit

.load_no_inc
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
.reinit
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $1f
	ret nz
.two:
	jmp BattleAnim_IncAnonJumptableIndex

.six:
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $1
	ret

BattleAnimFunction_Bite:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .two
	dw .two
	dw .two
	dw .six

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 7, [hl]
	jr nz, .flipped
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $10
	jr .got_sine_start

.flipped
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30
.got_sine_start
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
.one:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	bit 7, a
	ld a, BATTLEANIMFRAMESET_3D
	jr z, .got_frameset
	dec a ; BATTLEANIMFRAMESET_3C
.got_frameset
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $1f
	ret nz
.two:
	jmp BattleAnim_IncAnonJumptableIndex

.six:
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $1
	ret

BattleAnimFunction_SolarBeam:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, $28
	ld [hli], a
	ld [hl], $0
.one:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .zero_radius
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], d
	ret

.zero_radius
	jmp FarDeinitBattleAnimation

BattleAnimFunction_Gust:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one_three
	dw .two
	dw .one_three
	dw .four

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld [hl], $0
	jr .one_three

.two:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jr c, .move
	jmp BattleAnim_IncAnonJumptableIndex

.four:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $b8
	jmp nc, FarDeinitBattleAnimation

.move:
	call .one_three
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

.one_three:
	call .GetGustRadius
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	push af
	push de
	farcall Sine
	sra a
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	sub $8
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and a
	jr z, .start_wobble
	cp $c2
	jr c, .finish_wobble
.start_wobble
	dec a
	ld [hl], a
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	inc [hl]
	ret

.finish_wobble
	xor a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hli], a
	ld [hl], a
	ret

.GetGustRadius:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .GustOffsets
	add hl, de
	ld d, [hl]
	ret

.GustOffsets:
	db 8, 6, 5, 4, 5, 6, 8, 12, 16

BattleAnimFunction_Absorb:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jmp c, FarDeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld e, a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	sub e
	ld [hl], a
	srl e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
.loop
	inc [hl]
	dec e
	jr nz, .loop
	ret

BattleAnimFunction_Wrap:
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothing
	dw .one
	dw DoNothing

.one:
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	inc a
	call FarReinitBattleAnimFrameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $8
	ret

BattleAnimFunction_LeechSeed:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw DoNothing

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $40
	ret

.one:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $20
	jr nc, BattleAnim_StepThrownToTarget

	ld [hl], $40
	ld a, BATTLEANIMFRAMESET_57
	call FarReinitBattleAnimFrameset
	jmp BattleAnim_IncAnonJumptableIndex

.two:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .flutter
	dec [hl]
	ret

.flutter
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_58
	jmp FarReinitBattleAnimFrameset

BattleAnimFunction_Spikes_one:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $20
	jmp c, BattleAnim_IncAnonJumptableIndex
	; fallthrough

BattleAnim_StepThrownToTarget:
	dec [hl]
	ld d, $20
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_FIX_Y
	add hl, bc
	ld a, [hl]
	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld h, [hl]
	ld a, h
	and $f
	swap a
	ld l, a
	ld a, h
	and $f0
	swap a
	ld h, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_Spikes:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw BattleAnimFunction_Spikes_one
	dw DoNothing

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $40
	ret

BattleAnimFunction_RazorWind:
	call BattleAnimFunction_MoveInCircle
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	add $f
	ld [hl], a
	ret

BattleAnimFunction_Kick:
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothing
	dw .one
	dw .two
	dw .three
	dw .four

.one:
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jr c, .move_down
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $0
	ret

.move_down
	add $4
	ld [hl], a
	ret

.two:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $98
	ret nc
	inc [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_OAMFLAGS
	add hl, bc
	set 0, [hl]
	ld hl, BATTLEANIMSTRUCT_FIX_Y
	add hl, bc
	ld [hl], $90
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], $2
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

.three:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $2c
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], $80
.four:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $98
	ret nc
	inc [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $8
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_RockTomb:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw DoNothing

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, $30
	ld [hli], a
	ld [hl], $48
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	jmp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_PowerUp:
; "Absorbing power"-like animation (pulls particles towards user)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, 40
	ld [hli], a
	ld [hl], 0
.one
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld hl, -4.5
	add hl, de
	jmp nc, FarDeinitBattleAnimation
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, e
	ld [hld], a
	ld [hl], d
	ret

BattleAnimFunction_Egg:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one ; Egg Bomb start
	dw .two
	dw .three
	dw DoNothing
	dw FarDeinitBattleAnimation
	dw .six ; Softboiled obj 1 start
	dw .seven
	dw .eight
	dw .nine
	dw DoNothing
	dw .eleven ; Softboiled obj 2 start
	dw .twelve
	dw DoNothing

.zero:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, $28
	ld [hli], a
	ld [hl], $10
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

.one:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $40
	jr nc, .egg_bomb_vertical_wave
	inc [hl]
.egg_bomb_vertical_wave
	jmp .EggVerticalWaveMotion

.six:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $4b
	jr nc, .softboiled_vertical_wave
	inc [hl]
.softboiled_vertical_wave
	jmp .EggVerticalWaveMotion

.two:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jr nc, .egg_bomb_done
	and $f
	jr nz, .egg_bomb_step
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $10
	jmp BattleAnim_IncAnonJumptableIndex

.egg_bomb_done
	call BattleAnim_IncAnonJumptableIndex
	inc [hl]
	ret

.three:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done_waiting
	dec [hl]
	ret

.done_waiting
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	dec [hl]
.egg_bomb_step:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ret

.seven:
	ld a, BATTLEANIMFRAMESET_4E
	call FarReinitBattleAnimFrameset
	jmp BattleAnim_IncAnonJumptableIndex

.eight:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	ld d, $2
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.nine:
	ld a, BATTLEANIMFRAMESET_50
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $4
	jmp BattleAnim_IncAnonJumptableIndex

.eleven:
	ld a, BATTLEANIMFRAMESET_4F
	call FarReinitBattleAnimFrameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $40
	ret

.twelve:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $20
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $30
	jmp c, BattleAnim_IncAnonJumptableIndex
	dec [hl]
	ret

.EggVerticalWaveMotion:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $20
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	sub $8
	ld [hl], a
	ret nz
	xor a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hli], a
	ld [hl], a
	jmp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_MoveUp:
; Moves object up for 41 frames
; Obj Param: Movement speed
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	and a
	jr z, .move
	cp $d8
	jmp c, FarDeinitBattleAnimation

.move
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	sub d
	ld [hl], a
	ret

BattleAnimFunction_PowerGem:
	call BattleAnim_AnonJumptable
.anon_dw
	dw PowerGemFunction1
	dw PowerGemFunction2
	dw PowerGemFunction3

PowerGemFunction1:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $ff
	jr nz, .move_up
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $2
	ret

.move_up
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ret

PowerGemFunction2:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .switch_position
	dec [hl]
	ret

.switch_position
	ld [hl], $4
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	add [hl]
	ld [hl], a
	ret

PowerGemFunction3:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $c0
	ret nc
	ld a, $8
	jmp BattleAnim_StepToTarget

BattleAnimFunction_Sound:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	cpl
	add $3
	ld [hl], a
.got_turn
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $8
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, BATTLEANIMFRAMESET_59
	add [hl]
	jmp FarReinitBattleAnimFrameset

.one:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jmp z, FarDeinitBattleAnimation
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	ld d, $10
	farcall Sine
	ld d, a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and a
	jr z, .negative
	dec a
	ret z
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ret

.negative
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, d
	cpl
	inc a
	ld [hl], a
	ret

BattleAnimFunction_ConfuseRay:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $3f
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $80
	rlca
	ld [hl], a
	add BATTLEANIMFRAMESET_5D
	jmp FarReinitBattleAnimFrameset

.one:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	swap a
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	ret nc
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and $3
	jr nz, .skip_vertical_movement
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
.skip_vertical_movement
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_Dizzy:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $80
	rlca
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	add [hl]
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
.one:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $10
	push af
	push de
	farcall Sine
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	and $3f
	jr z, .not_flipped
	and $1f
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc a
	jr .got_frameset

.not_flipped
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
.got_frameset
	jmp FarReinitBattleAnimFrameset

BattleAnimFunction_Amnesia:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw DoNothing
	dw FarDeinitBattleAnimation

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	add BATTLEANIMFRAMESET_AMNESIA_1
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .AmnesiaOffsets
	add hl, de
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.AmnesiaOffsets:
	db $ec, $f8, $00

BattleAnimFunction_FloatUp:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	ld d, $4
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld e, [hl]
	ld hl, $ffa0
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ret

BattleAnimFunction_Dig:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	dec [hl]
	ld d, $10
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_String:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw DoNothing

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .not_param_zero
	ld hl, BATTLEANIMSTRUCT_OAMFLAGS
	add hl, bc
	set 6, [hl]
.not_param_zero
	add BATTLEANIMFRAMESET_6A
	jmp FarReinitBattleAnimFrameset

BattleAnimFunction_Paralyzed:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld e, [hl]
	ld a, e
	and $70
	swap a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, e
	and $80
	jr nz, .right
	ld a, e
	and $f
	ld [hl], a
	ret

.right
	ld a, e
	and $f
	cpl
	inc a
	ld [hl], a
	ld a, BATTLEANIMFRAMESET_6E
	jmp FarReinitBattleAnimFrameset

.one:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .var1_zero
	dec [hl]
	ret

.var1_zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ret

BattleAnimFunction_SpiralDescent:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	farcall Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $28
	jr nc, .delete
	inc [hl]
	ret

.delete
	jmp FarDeinitBattleAnimation

BattleAnimFunction_PetalDance:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	farcall Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $30
	jr nc, .end
	inc [hl]
	inc [hl]
	ret

.end
	jmp FarDeinitBattleAnimation

BattleAnimFunction_PoisonGas:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw BattleAnimFunction_SpiralDescent

.zero:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jr nc, .next
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

.next
	jmp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_SmokeFlameWheel:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	farcall Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $e8
	jr z, .done
	dec [hl]
	ret

.done
	jmp FarDeinitBattleAnimation

BattleAnimFunction_SacredFire:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	farcall Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $3
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $d0
	jr z, .done
	dec [hl]
	dec [hl]
	ret

.done
	jmp FarDeinitBattleAnimation

BattleAnimFunction_PresentSmokescreen:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw FarDeinitBattleAnimation

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $34
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $10
.one:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $6c
	ret nc
	ld a, $2
	call BattleAnim_StepToTarget
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld d, [hl]
	farcall Sine
	bit 7, a
	jr nz, .negative
	cpl
	inc a
.negative
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	sub $4
	ld [hl], a
	and $1f
	cp $20
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	srl [hl]
	ret

BattleAnimFunction_Horn:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three

.zero:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ret

.one:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $58
	ret nc
	ld a, $2
	jmp BattleAnim_StepToTarget

.two:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $20
	jmp nc, FarDeinitBattleAnimation

.three:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld d, $8
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	sra a
	cpl
	inc a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	add $8
	ld [hl], a
	ret

BattleAnimFunction_Needle:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	swap a
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

.two:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	bit 7, a
	jr z, .negative
	ld [hl], a
.negative
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	sub $4
	ld [hl], a
.one:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jmp nc, FarDeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jmp BattleAnim_StepToTarget

BattleAnimFunction_ThiefPayday:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $28
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	sub $28
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
.one:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	and [hl]
	jr nz, .var_doesnt_equal_param
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
.var_doesnt_equal_param
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, $20
	ld [hli], a
	srl [hl]
	ret

BattleAnimFunction_AbsorbCircle:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $1
	jr nz, .dont_move_x
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
.dont_move_x
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $3
	jr nz, .dont_move_y
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
.dont_move_y
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	cp $5a
	jr nc, .increase_radius
	ld a, [hl]
	and a
	jr z, .end
	dec [hl]
	ret

.increase_radius
	inc [hl]
	ret

.end
	jmp FarDeinitBattleAnimation

BattleAnimFunction_Conversion:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	cp $40
	jr nc, .shrink
	inc [hl]
	ret

.shrink
	ld a, [hl]
	dec [hl]
	and a
	ret nz
	jmp FarDeinitBattleAnimation

BattleAnimFunction_Bonemerang:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
.one:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $30
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	add $8
	ld d, $30
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_Shiny:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw DoNothing

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $10
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $10
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $f
	ret

BattleAnimFunction_SkyAttack:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ldh a, [hBattleTurn]
	and a
	ld a, $f0
	jr z, .got_var1
	ld a, $cc
.got_var1
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ret

.two:
	call .one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	ret nc
	ld a, $4
	jmp BattleAnim_StepToTarget

.three:
	call .one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $d0
	jr nc, .done
	ld a, $4
	jmp BattleAnim_StepToTarget

.done
	jmp FarDeinitBattleAnimation

.one:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and $7
	inc [hl]
	srl a
	ld e, a
	ld d, $0
	ld hl, .pals
	add hl, de
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	and [hl]
	ld [wOBP0], a
	ret

.pals:
	db $ff, $aa, $55, $aa

BattleAnimFunction_GrowthSwordsDance:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $18
	farcall Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	dec [hl]
	dec [hl]
	ret

BattleAnimFunction_Moon:
BattleAnimFunction_StrengthSeismicToss:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $e0
	jr nz, .move_up
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $2
	ret

.move_up
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ret

.one:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .switch_position
	dec [hl]
	ret

.switch_position
	ld [hl], $4
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	add [hl]
	ld [hl], a
	ret

.two:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jr nc, .done
	ld a, $4
	jmp BattleAnim_StepToTarget

.done
	jmp FarDeinitBattleAnimation

BattleAnimFunction_SpeedLine:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $7f
	add BATTLEANIMFRAMESET_81
	call FarReinitBattleAnimFrameset
.one:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 7, [hl]
	jr nz, .inverted
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	inc [hl]
	ret

.inverted
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_Sludge:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $c
	ret

.one:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ret

.done
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_20
	call FarReinitBattleAnimFrameset
.two:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_MetronomeHand:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	push af
	ld d, $2
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop af
	ld d, $8
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_MetronomeSparkleSketch:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $20
	jmp nc, FarDeinitBattleAnimation

	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $8
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	add $2
	ld [hl], a
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_Agility:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw FarDeinitBattleAnimation

.zero:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	ret

BattleAnimFunction_SafeguardProtect:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	sra a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	ret

BattleAnimFunction_LockOnMindReader:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $28
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	add [hl]
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	or $8
	ld [hl], a
.one:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	add $8
	ld d, a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.done
	ld [hl], $10
	call BattleAnim_IncAnonJumptableIndex
.two:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	and a
	ret nz
	jmp FarDeinitBattleAnimation

BattleAnimFunction_HealBellNotes:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, BATTLEANIMFRAMESET_24
	add [hl]
	call FarReinitBattleAnimFrameset
.one:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $38
	jr nc, .done
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
	ret

.done
	jmp FarDeinitBattleAnimation

BattleAnimFunction_BatonPass:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and a
	ret z
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	farcall Sine
	bit 7, a
	jr nz, .negative
	cpl
	inc a
.negative
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and $1f
	ret nz
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	srl [hl]
	ret

BattleAnimFunction_EncoreBellyDrum:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $10
	jr nc, .done
	inc [hl]
	inc [hl]
	ld d, a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.done
	jmp FarDeinitBattleAnimation

BattleAnimFunction_SwaggerMorningSun:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	ld a, e
	and $c0
	rlca
	rlca
	add [hl]
	ld [hl], a
	ld a, e
	and $3f
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_HiddenPower:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero:
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	jr .step_circle

.one:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $18
.two:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .done
	ld d, a
	add $8
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jr .step_circle

.done
	jmp FarDeinitBattleAnimation

.step_circle:
	jmp BattleAnim_StepCircle

BattleAnimFunction_HiddenPower_Fast:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero:
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl] ; increased rotation speed
	inc [hl]
	jr .step_circle

.one:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $18
.two:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .done
	ld d, a
	add $8
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jr .step_circle

.done
	jmp FarDeinitBattleAnimation

.step_circle:
	jmp BattleAnim_StepCircle

BattleAnimFunction_Curse:
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothing
	dw .one

.one:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jmp c, FarDeinitBattleAnimation
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
	inc [hl]
	ret

BattleAnimFunction_PerishSong:
	ld d, $50
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	push af
	push de
	farcall Sine
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	add [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_RapidSpin:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $d0
	jr z, .disappear
rept 4
	dec [hl]
endr
	ret

.disappear
	jmp FarDeinitBattleAnimation

BattleAnimFunction_BetaPursuit:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw FarDeinitBattleAnimation

.zero:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .move_up
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $ec
.one:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $4
	jr z, .three
rept 4
	inc [hl]
endr
	ret

.three:
	jmp FarDeinitBattleAnimation

.move_up:
	call BattleAnim_IncAnonJumptableIndex
	call BattleAnim_IncAnonJumptableIndex
.two:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $d8
	ret z
rept 4
	dec [hl]
endr
	ret

BattleAnimFunction_RainSandstorm:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three

.zero:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	jmp BattleAnim_IncAnonJumptableIndex

.one:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	cp $70
	jr c, .dont_reset_y_offset_one
	xor a
.dont_reset_y_offset_one
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	inc [hl]
	inc [hl]
	ret

.two:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	cp $70
	jr c, .dont_reset_y_offset_two
	xor a
.dont_reset_y_offset_two
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	add $8
	ld [hl], a
	ret

.three:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	cp $70
	jr c, .dont_reset_y_offset_three
	xor a
.dont_reset_y_offset_three
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	ld [hl], a
	ret

BattleAnimFunction_AnimObjB0:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld l, a
	and $f0
	ld h, a
	swap a
	or h
	ld h, a
	ld a, l
	and $f
	swap a
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ret

BattleAnimFunction_PsychUp:
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	jr BattleAnim_StepCircle

BattleAnimFunction_Cotton:
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	srl a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	add [hl]
	; fallthrough

BattleAnim_StepCircle:
	push af
	push de
	farcall Sine
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_AncientPower:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $20
	jr nc, .done
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	farcall Sine
	cpl
	inc a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.done
	jmp FarDeinitBattleAnimation

BattleAnim_StepToTarget:
	and $f
	ld e, a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	srl e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
.loop
	dec [hl]
	dec e
	jr nz, .loop
	ret

BattleAnimFunction_PauseThenRush:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	swap a
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

.two
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	bit 7, a
	jr z, .skip
	ld [hl], a
.skip
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	sub 4
	ld [hl], a
.one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $e4
	jmp nc, FarDeinitBattleAnimation
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jr BattleAnim_StepToTarget

BattleAnimFunction_AirCutter:
	call BattleAnim_AnonJumptable

	dw .zero
	dw .one
	dw .two

.zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	swap a
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

.two
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	bit 7, a
	jr z, .skip
	ld [hl], a
.skip
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	sub 4
	ld [hl], a
.one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $e4
	jmp nc, FarDeinitBattleAnimation
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jmp BattleAnim_StepToTarget

BattleAnimFunction_RadialMoveOut:
	lb de, 12, 80
	jr BattleAnimFunc_DoRadialMoveOut

BattleAnimFunction_RadialMoveOut_Slow:
	lb de, 3, 80
	jr BattleAnimFunc_DoRadialMoveOut

BattleAnimFunction_RadialMoveOut_VerySlow:
	lb de, 1, 120
	jr BattleAnimFunc_DoRadialMoveOut

BattleAnimFunction_RadialMoveOut_Fast:
	lb de, 20, 160
	jr BattleAnimFunc_DoRadialMoveOut

BattleAnimFunction_RadialMoveOut_Spore:
	lb de, 3, 40
	jr BattleAnimFunc_DoRadialMoveOut

BattleAnimFunction_RadialMoveOut_Stats:
	lb de, 6, 80
	; fallthrough
BattleAnimFunc_DoRadialMoveOut:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .init
	dw .step

.init
	call BattleAnimFunc_RadialInit
.step
	; fallthrough
BattleAnimFunc_RadialStep:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	push bc
	push hl
	ld a, [hli]
	ld c, [hl]
	ld b, a
	ld h, d ; speed x 2
	ld l, 0
	srl h
	rr l
	add hl, bc
	ld a, h
	ld c, l
	pop hl
	ld [hli], a
	ld [hl], c
	ld d, b ; used for Sine/Cosine
	pop bc
	cp e ; final position
	jmp nc, FarDeinitBattleAnimation
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld e, [hl]
	push de
	ld a, e
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	ld a, e
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunc_RadialInit:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR3
	add hl, bc
	add a
	swap a
	ld [hld], a
	xor a
	ld [hld], a
	ld [hl], a ; initial position = 0
	jmp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_Roost:
; Moves object in a circle where the height is 1/8 the width, while also moving downward 1 pixel per frame
; Obj Param: Defines where the object starts in the circle
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $18
	farcall Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $1e
	jmp nc, FarDeinitBattleAnimation
	inc [hl]
	inc [hl]
	ret

BattleAnimFunction_LastResort:
; A rotating circle of objects centered at a position. It expands for $40 frames and then shrinks. Once radius reaches 0, the object disappears.
; Obj Param: Defines starting point in the circle
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl] ; These speed up spinning
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl] ; the rest of these control the in and out.
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	cp $40
	jr nc, .shrink
	inc [hl]
	inc [hl] ; in and out
	inc [hl]
	ret

.shrink
	ld a, [hl]
	dec [hl]
	dec [hl] ; in and out
	dec [hl]
	and a
	ret nz
	jmp FarDeinitBattleAnimation

BattleAnimFunction_DarkPulse:
; Expands object out in a ring around position at 1 pixel at a time for 13 frames and then disappears
; Obj Param: Defines starting position in circle, and sprite rotation
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $80
	jmp nc, FarDeinitBattleAnimation
	ld d, a
	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]

	; Dark Pulse W ends early.
	cp $20
	jr nz, .dark_pulse_w_done
	ld h, a
	add a
	cp d ; cp $40
	jmp z, FarDeinitBattleAnimation
	ld a, h

.dark_pulse_w_done
	; Set sprite rotation
	push af
	ld hl, BATTLEANIMSTRUCT_VAR3
	add hl, bc
	add a
	swap a
	xor 4
	ld [hl], a
	pop af

	; Dark Pulse NW-NE should appear behind the mon.
	cp $28
	jr c, .no_priority
	push af

	; For NE, disable priority once we've reached a certain point.
	cp $38
	jr nz, .cont
	ld a, d
	cp $40
	jr nc, .pop_af_no_priority

.cont
	set 3, [hl] ; Set priority

.pop_af_no_priority
	pop af
.no_priority
	jmp BattleAnim_StepCircle

BattleAnimFunction_SpiralDescent_Fast:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	farcall Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $18
	jmp nc, FarDeinitBattleAnimation
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

BattleAnimFunction_RadialMoveIn:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one

.zero:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]

	; Set x/y flip dynamically.
	ld hl, BATTLEANIMSTRUCT_VAR3
	add hl, bc
	add a
	swap a
	ld [hl], a

	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, 40
	ld [hli], a
	ld [hl], 0
	; fallthrough
.one:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	farcall Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	farcall Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld hl, -4.5
	add hl, de
	jmp nc, FarDeinitBattleAnimation
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, e
	ld [hld], a
	ld [hl], d
	ret

BattleAnimFunction_NightSlash:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]

	; Set x/y flip dynamically.
	ld hl, BATTLEANIMSTRUCT_VAR3
	add hl, bc
	add a
	swap a
	ld [hl], a
	ret
