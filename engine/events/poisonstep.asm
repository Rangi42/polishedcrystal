DoPoisonStep::
	ld a, [wPartyCount]
	and a
	jr z, .no_recovery

	xor a
	ld c, wPoisonStepDataEnd - wPoisonStepData
	ld hl, wPoisonStepFlagSum
.loop_clearPoisonStepData
	ld [hli], a
	dec c
	jr nz, .loop_clearPoisonStepData

	xor a
	ld [wCurPartyMon], a
.loop_check_poison
	call .DamageMonIfPoisoned
	jr nc, .not_poisoned
; the output flag is stored in c, copy it to [wPoisonStepPartyFlags + [wCurPartyMon]]
; and set the corresponding flag in wPoisonStepFlagSum
	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPoisonStepPartyFlags
	add hl, de
	ld [hl], c
	ld a, [wPoisonStepFlagSum]
	or c
	ld [wPoisonStepFlagSum], a

.not_poisoned
	ld a, [wPartyCount]
	ld hl, wCurPartyMon
	inc [hl]
	cp [hl]
	jr nz, .loop_check_poison

	ld a, [wPoisonStepFlagSum]
	and %10
	jr nz, .someone_has_recovered
	ld a, [wPoisonStepFlagSum]
	and %01
	jr z, .no_recovery
	call .PlayPoisonSFX
	xor a
	ret

.someone_has_recovered
	ld a, BANK(.Script_MonRecoveredFromPoison)
	ld hl, .Script_MonRecoveredFromPoison
	call CallScript
	scf
	ret

.no_recovery
	xor a
	ret

.DamageMonIfPoisoned:
; check if mon is poisoned, return if not
	ld a, MON_STATUS
	call GetPartyParamLocationAndValue
	and 1 << PSN
	ret z

; check if mon is fainted, return if so
	ld a, MON_HP
	call GetPartyParamLocationAndValue
	inc hl
	ld b, a
	ld c, [hl]
	or c
	ret z

; check for immunity, pastel veil, or poison heal
	push hl
	push bc
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld c, a
	ld a, MON_ABILITY
	call GetPartyParamLocationAndValue
	call GetAbility
	ld a, b
	pop bc
	pop hl
	cp IMMUNITY
	jr z, .heal_poison
	cp PASTEL_VEIL
	jr z, .heal_poison
	cp POISON_HEAL
	ret z ; keep poison, but don't deal damage for it
	cp MAGIC_GUARD
	ret z

; check if 1 HP
	ld a, b
	or a
	jr nz, .DoPoisonDamage
	ld a, c
	dec a
	jr nz, .DoPoisonDamage

; if 1 HP, heal poison
.heal_poison
	ld a, MON_STATUS
	call GetPartyParamLocationAndValue
	ld [hl], 0
; set carry and return %10
	ld c, %10
	scf
	ret

.DoPoisonDamage
; do 1 HP damage
	dec bc
	ld a, c
	ld [hld], a
	ld [hl], b
; set carry and return %01
	ld c, %01
	scf
	ret

.PlayPoisonSFX:
	ld de, SFX_POISON
	call PlaySFX
	ld b, $2
	call LoadPoisonBGPals
	jmp DelayFrame

.Script_MonRecoveredFromPoison:
	callasm .PlayPoisonSFX
	opentext
	callasm .CheckWhitedOut
	iffalsefwd .whiteout
	closetext
	end

.whiteout
	farsjump Script_OverworldWhiteout

.CheckWhitedOut:
	xor a
	ld [wCurPartyMon], a
	ld de, wPoisonStepPartyFlags
.party_loop
	push de
	ld a, [de]
	and %10
	jr z, .mon_not_fainted
	ld c, HAPPINESS_POISONFAINT
	predef ChangeHappiness
	farcall GetPartyNickname
	ld hl, .PoisonRecoveryText
	call PrintText

.mon_not_fainted
	pop de
	inc de
	ld hl, wCurPartyMon
	inc [hl]
	ld a, [wPartyCount]
	cp [hl]
	jr nz, .party_loop
	farcall CheckPlayerPartyForFitPkmn
	ld a, d
	ldh [hScriptVar], a
	ret

.PoisonRecoveryText:
	text_far _PoisonFaintText
	text_end

LoadPoisonBGPals:
	ld c, 6
	farcall UpdatePalFromC
	ld c, 4
	call DelayFrames
	farjp _UpdateTimePals
