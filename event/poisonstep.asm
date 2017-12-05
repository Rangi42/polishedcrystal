DoPoisonStep:: ; 505da
	ld a, [PartyCount]
	and a
	jr z, .no_recovery

	xor a
	ld c, 7
	ld hl, EngineBuffer1
.loop_clearEngineBuffer1
	ld [hli], a
	dec c
	jr nz, .loop_clearEngineBuffer1

	xor a
	ld [CurPartyMon], a
.loop_check_poison
	call .DamageMonIfPoisoned
	jr nc, .not_poisoned
; the output flag is stored in c, copy it to the ([CurPartyMon] + 2)nd EngineBuffer
; and set the corresponding flag in EngineBuffer1
	ld a, [CurPartyMon]
	ld e, a
	ld d, 0
	ld hl, EngineBuffer2
	add hl, de
	ld [hl], c
	ld a, [EngineBuffer1]
	or c
	ld [EngineBuffer1], a

.not_poisoned
	ld a, [PartyCount]
	ld hl, CurPartyMon
	inc [hl]
	cp [hl]
	jr nz, .loop_check_poison

	ld a, [EngineBuffer1]
	and %10
	jr nz, .someone_has_recovered
	ld a, [EngineBuffer1]
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
; 5062e

.DamageMonIfPoisoned: ; 5062e
; check if mon is poisoned, return if not
	ld a, MON_STATUS
	call GetPartyParamLocation
	ld a, [hl]
	and 1 << PSN
	ret z

; check if mon is fainted, return if so
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld b, a
	ld c, [hl]
	or c
	ret z

; check for immunity or poison heal
	push hl
	push bc
	ld a, MON_ABILITY
	call GetPartyParamLocation
	ld b, [hl]
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld c, [hl]
	call GetAbility
	ld a, b
	pop bc
	pop hl
	cp IMMUNITY
	jr z, .heal_poison
	cp POISON_HEAL
	ret z ; keep poison, but don't deal damage for it

; check if 1 HP
	ld a, b
	or a
	jr nz, .DoPoisonDamage
	ld a, c
	cp 1
	jr nz, .DoPoisonDamage

; if 1 HP, heal poison
.heal_poison
	ld a, MON_STATUS
	call GetPartyParamLocation
	ld [hl], 0
; set carry and return %10
	ld c, %10
	scf
	ret

.DoPoisonDamage
; do 1 HP damage
	dec bc
	ld [hl], c
	dec hl
	ld [hl], b
; set carry and return %01
	ld c, %01
	scf
	ret
; 50658

.PlayPoisonSFX: ; 50658
	ld de, SFX_POISON
	call PlaySFX
	ld b, $2
	call LoadPoisonBGPals
	jp DelayFrame
; 50669

.Script_MonRecoveredFromPoison: ; 50669
	callasm .PlayPoisonSFX
	opentext
	callasm .CheckWhitedOut
	iffalse .whiteout
	closetext
	end
; 50677

.whiteout ; 50677
	farjump Script_OverworldWhiteout
; 5067b

.CheckWhitedOut: ; 5067b
	xor a
	ld [CurPartyMon], a
	ld de, EngineBuffer2
.party_loop
	push de
	ld a, [de]
	and %10
	jr z, .mon_not_fainted
	ld c, HAPPINESS_POISONFAINT
	farcall ChangeHappiness
	farcall GetPartyNick
	ld hl, .PoisonRecoveryText
	call PrintText

.mon_not_fainted
	pop de
	inc de
	ld hl, CurPartyMon
	inc [hl]
	ld a, [PartyCount]
	cp [hl]
	jr nz, .party_loop
	predef CheckPlayerPartyForFitPkmn
	ld a, d
	ld [ScriptVar], a
	ret
; 506b2

.PoisonRecoveryText: ; 506b2
	text_jump UnknownText_0x1c0acc
	db "@"
; 506b7

LoadPoisonBGPals: ; cbcdd
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld hl, BGPals
	ld c, 8 * 4
.loop
if !DEF(MONOCHROME)
; RGB 28, 21, 31
	ld a, (palred 28 + palgreen 21 + palblue 31) % $100
	ld [hli], a
	ld a, (palred 28 + palgreen 21 + palblue 31) / $100
	ld [hli], a
else
	ld a, PAL_MONOCHROME_WHITE % $100
	ld [hli], a
	ld a, PAL_MONOCHROME_WHITE / $100
	ld [hli], a
endc
	dec c
	jr nz, .loop
	pop af
	ld [rSVBK], a
	ld a, $1
	ld [hCGBPalUpdate], a
	ld c, 4
	call DelayFrames
	farjp _UpdateTimePals
