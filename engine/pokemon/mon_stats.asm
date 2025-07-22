DrawPlayerHP:
	ld a, $1
	ld [wWhichHPBar], a
	push hl
	push bc
	ld a, [wMonType]
	cp BOXMON
	jr z, .at_least_1_hp

	ld a, [wTempMonHP]
	ld b, a
	ld a, [wTempMonHP + 1]
	ld c, a

; Any HP?
	or b
	jr nz, .at_least_1_hp

	xor a
	ld c, a
	ld e, a
	ld a, 6
	ld d, a
	jr .fainted

.at_least_1_hp
	ld a, [wTempMonMaxHP]
	ld d, a
	ld a, [wTempMonMaxHP + 1]
	ld e, a
	ld a, [wMonType]
	cp BOXMON
	jr nz, .not_boxmon

	ld b, d
	ld c, e

.not_boxmon
	predef ComputeHPBarPixels
	ld a, 6
	ld d, a
	ld c, a

.fainted
	ld a, c
	pop bc
	ld c, a
	pop hl
	push de
	push hl
	push hl
	call DrawBattleHPBar
	pop hl

; Print HP
	bccoord 1, 1, 0
	add hl, bc
	ld de, wTempMonHP
	ld a, [wMonType]
	cp BOXMON
	jr nz, .not_boxmon_2
	ld de, wTempMonMaxHP
.not_boxmon_2
	lb bc, 2, 3
	call PrintNum

	ld a, "/"
	ld [hli], a

; Print max HP
	ld de, wTempMonMaxHP
	lb bc, 2, 3
	call PrintNum
	pop hl
	pop de
	ret

PrintTempMonStats:
; Print wTempMon's stats at hl, with spacing bc.
	push bc
	push hl
	ld de, MostStatNames
	rst PlaceString
	pop hl
	pop bc

	push bc
	push hl
	push hl
	ld a, [wTempMonNature]
	ld b, a
	call GetNature
	pop hl
rept 8
	inc hl
endr
	call PrintNatureIndicators
	pop hl
	pop bc

	add hl, bc
	ld de, wTempMonAttack
	lb bc, 2, 3
	call .PrintStat
	ld de, wTempMonDefense
	call .PrintStat
	ld de, wTempMonSpAtk
	call .PrintStat
	ld de, wTempMonSpDef
	call .PrintStat
	ld de, wTempMonSpeed
	jmp PrintNum

.PrintStat:
	push hl
	call PrintNum
	pop hl
	ld de, TILEMAP_WIDTH
	add hl, de
	ret

AllStatNames:
	db   "Health<NEXT>"
MostStatNames:
	db   "Attack"
	next "Defense"
	next "Sp.Atk"
	next "Sp.Def"
	next "Speed"
	next "@"

PrintStatDifferences:
	ld a, [wTextboxFlags]
	push af
	set NO_LINE_SPACING_F, a
	ld [wTextboxFlags], a

	; Figure out length of largest modifier (+x, +xx or +xxx)
	ld hl, wStringBuffer3
	lb bc, 1, 6
.loop
	call .ComputeStatDifference
	inc hl
	inc hl
	ld a, [wStringBuffer3 + 12]
	and a
	ld a, [wStringBuffer3 + 13]
	ld d, 4
	jr nz, .got_digit_length
	cp 100
	jr nc, .got_digit_length
	dec d
	cp 10
	jr nc, .got_digit_length
	dec d
.got_digit_length
	ld a, b
	cp d
	jr nc, .digit_length_not_larger
	ld b, d
.digit_length_not_larger
	dec c
	jr nz, .loop

	ld a, b
	ld [wStringBuffer3 + 14], a
	ld de, wStringBuffer3
	ld b, 1 ; show stat+difference
	call .PrintStatDisplay
	ld de, wTempMonMaxHP
	ld b, 0 ; just show stat
	call .PrintStatDisplay
	pop af
	ld [wTextboxFlags], a
	ret

.ComputeStatDifference:
	push de
	push bc
	ld a, [hli]
	cpl
	ld d, a
	ld a, [hld]
	cpl
	inc a
	jr nz, .dont_inc_d
	inc d
.dont_inc_d
	ld e, a
	ld bc, wTempMonMaxHP - wStringBuffer3
	add hl, bc
	ld a, [hli]
	ld b, a
	ld a, [hld]
	ld c, a
	push bc
	ld bc, wStringBuffer3 - wTempMonMaxHP
	add hl, bc
	pop bc
	push hl
	ld h, b
	ld l, c
	add hl, de
	ld a, h
	ld [wStringBuffer3 + 12], a
	ld a, l
	ld [wStringBuffer3 + 13], a
	pop hl
	pop bc
	pop de
	ret

.PrintStatDisplay:
	push de
	push bc
	call .PrintStatNames
	ld bc, 9
	add hl, bc
	pop bc
	pop de
	call .PrintStats
	jmp WaitPressAorB_BlinkCursor

.PrintStatNames:
	ld a, [wStringBuffer3 + 14]
	push af
	hlcoord 6, 4
.coord_loop
	dec hl
	dec a
	jr nz, .coord_loop
	pop af
	push af
	lb bc, 6, 12
	add c
	ld c, a
	call Textbox
	pop af
	push af
	hlcoord 7, 5
.coord_loop2
	dec hl
	dec a
	jr nz, .coord_loop2
	pop af
	push hl
	ld de, AllStatNames
	rst PlaceString
	pop hl
	ret

.PrintStats:
	; Some screen movement is done because internal stat order is different
	; from the order we want to display.
	; Printing: HP, Atk, Def, SAtk, SDef, Speed
	; Internal: HP, Atk, Def, Speed, SAtk, SDef
	call .PrintStat ; HP
	call .PrintStat ; Attack
	call .PrintStat ; Defense

	push bc
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	call .PrintStat ; Speed

	push bc
	ld bc, -SCREEN_WIDTH * 3
	add hl, bc
	pop bc
	call .PrintStat
.PrintStat:
	push bc
	push hl
	push de
	ld a, b
	lb bc, 2, 3
	push af
	call PrintNum
	pop af
	and a
	jr z, .mod_done
	pop hl
	call .ComputeStatDifference
	ld d, h
	ld e, l
	pop hl
	push hl
	inc hl
	inc hl
	inc hl
	ld a, "+"
	ld [hli], a

	ld b, 2
	ld a, [wStringBuffer3 + 14]
	ld c, a
	dec c
	push de
	ld de, wStringBuffer3 + 12
	call PrintNum
.mod_done
	pop de
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc de
	inc de
	pop bc
	ret

GetShininess:
; Return the shininess of a given monster (wCurPartyMon/wCurOTMon/CurWildMon)
; based on wMonType.

; Figure out what type of monster struct we're looking at.

; 0: PartyMon
	ld hl, wPartyMon1Shiny
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wMonType]
	and a
	jr z, .PartyMon

; 1: OTPartyMon
	ld hl, wOTPartyMon1Shiny
	dec a
	jr z, .PartyMon

; 2: encountered oldbox code
	dec a
	jr nz, .other
	ld a, ERR_OLDBOX
	jmp Crash

.other
; 3: Other
	ld hl, wTempMonShiny
	dec a
	jr z, .Shininess

; else: WildMon
	ld hl, wEnemyMonShiny
	jr .Shininess

; Get our place in the party/box.

.PartyMon:
	ld a, [wCurPartyMon]
	rst AddNTimes

.Shininess:

; Check the shininess value
	ld a, [hl]
	and SHINY_MASK
	ret

GetGender:
; Return the gender of a given monster (wCurPartyMon/wCurOTMon/CurWildMon)
; based on wMonType.

; return values:
; a = 1: f = nc|nz; male
; a = 0: f = nc|z;  female
;        f = c:  genderless

; This is determined by checking the Personality gender value,
; which was already determined by the species' gender ratio.

; Figure out what type of monster struct we're looking at.

; 0: PartyMon
	ld hl, wPartyMon1Gender
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wMonType]
	and a
	jr z, .PartyMon

; 1: OTPartyMon
	ld hl, wOTPartyMon1Gender
	dec a
	jr z, .PartyMon

; 2: encountered oldbox code
	dec a
	jr nz, .other
	ld a, ERR_OLDBOX
	jmp Crash

.other
; 3: Other (used for breeding, possibly elsewhere)
	ld hl, wTempMonGender
	dec a
	jr z, .Gender

; else: WildMon
	ld hl, wEnemyMonGender
	jr .Gender

; Get our place in the party/box.

.PartyMon:
	ld a, [wCurPartyMon]
	rst AddNTimes

.Gender:

; Gender and form are stored in the same byte
	ld a, [hl]
	ld b, a

; We need the gender ratio to do anything with this.
	ld a, [wCurPartySpecies]
	ld c, a
	push bc ; b == gender|form
	ld a, b
	and SPECIESFORM_MASK
	ld b, a
	call GetGenderRatio ; c = gender ratio
	pop af ; a = gender|form
	and GENDER_MASK
	ld b, a

; Fixed values ignore the Personality gender value.
	ld a, c
	cp GENDER_UNKNOWN
	jr z, .Genderless
	and a ; cp GENDER_F0
	jr z, .Male
	cp GENDER_F100
	jr z, .Female

; Otherwise, use the Personality gender value directly.
	ld a, b
	and a ; cp MALE
	jr z, .Male

.Female:
	xor a
	ret

.Male:
	ld a, 1
	and a
	ret

.Genderless:
	scf
	ret

ListMovePP:
	ld a, [wNumMoves]
	inc a
	ld c, a ; no-optimize a = N - a (c gets used in .load_loop)
	ld a, NUM_MOVES
	sub c
	ld b, a
	push hl
	ld a, [wBuffer1]
	ld e, a
	ld d, $0
	ld a, "<BOLDP>"
	call .load_loop
	ld a, b
	and a
	jr z, .skip
	ld c, a
	ld a, "-"
	call .load_loop

.skip
	pop hl
	inc hl
	inc hl
	inc hl
	ld d, h
	ld e, l
	ld hl, wTempMonMoves
	ld b, 0
.loop
	ld a, [hli]
	and a
	ret z
	push bc
	push hl
	push de
	ld hl, wMenuCursorY
	ld a, [hl]
	push af
	ld [hl], b
	push hl
	ld a, [wMonType]
	push af
	ld a, BOXMON
	ld [wMonType], a
	farcall GetMaxPPOfMove
	pop af
	ld [wMonType], a
	pop hl
	pop af
	ld [hl], a
	pop de
	pop hl
	push hl
	ld bc, wTempMonPP - (wTempMonMoves + 1)
	add hl, bc
	ld a, [hl]
	and $3f
	ld [wStringBuffer1 + 4], a
	ld h, d
	ld l, e
	push hl
	ld de, wStringBuffer1 + 4
	lb bc, 1, 2
	call PrintNum
	ld a, "/"
	ld [hli], a
	ld de, wTextDecimalByte
	lb bc, 1, 2
	call PrintNum
	pop hl
	ld a, [wBuffer1]
	ld e, a
	ld d, 0
	add hl, de
	ld d, h
	ld e, l
	pop hl
	pop bc
	inc b
	ld a, b
	cp NUM_MOVES
	jr nz, .loop
	ret

.load_loop
	ld [hli], a
	ld [hld], a
	add hl, de
	dec c
	jr nz, .load_loop
	ret

FixPlayerEVs:
; This will adjust player EVs in case the player is using the 510 EV limit mode.
; An EV total at or below 510 will be untouched. Otherwise, the following will
; be done until the EV total is 510 or less:
; 1. Lower all EVs to a multiple of 4
; 2. Reduce HP EVs by 4 if above 0.
; 3. Reduce Attack EVs by 4 if above 0.
; 4. Reduce Defense EVs by 4 if above 0.
; 5. Reduce Speed EVs by 4 if above 0.
; 6. Reduce Sp.Atk EVs by 4 if above 0.
; 7. Reduce Sp.Def EVs by 4 if above 0.
; 8. Go to step 2.
	; First, check if the player is using modern EVs.
	ld a, [wInitialOptions2]
	and EV_OPTMASK
	cp EVS_OPT_MODERN
	ret nz

	ld a, [wPartyCount]
	ld [wCurPartyMon], a
	jr .loop

.pop_bchl_loop
	pop bc
	pop hl
.loop
	ld a, [wCurPartyMon]
	and a
	ret z
	dec a
	ld [wCurPartyMon], a

	; Does the mon have more than 510 EVs?
	call .CompareEVTotal
	jr nc, .loop

	; Set EVs to a multiple of 4.
	ld a, MON_EVS
	call GetPartyParamLocationAndValue
	lb bc, 6, 4 ; c is used later for decrementing.
	push hl
	push bc
.remove_ev_remainder
	ld a, [hl]
	and ~%11
	ld [hli], a
	dec b
	jr nz, .remove_ev_remainder

	call .CompareEVTotal
	jr nc, .pop_bchl_loop

.outer_ev_reduction_loop
	; Reduce EVs for each stat by 4 sequentially.
	pop bc
	pop hl
	push hl
	push bc
.ev_reduction_loop
	ld a, [hl]
	and a
	jr z, .reduction_done
	sub c
.reduction_done
	ld [hli], a
	call .CompareEVTotal
	jr nc, .pop_bchl_loop
	dec b
	jr nz, .ev_reduction_loop
	jr .outer_ev_reduction_loop

.CompareEVTotal:
	push hl
	push bc
	call GetEVTotal
	pop bc
	pop hl
	ret

GetEVTotal:
; Returns total EVs for wCurPartyMon in bc. Returns carry if it exceeds the
; modern EV limit.
	ld a, MON_EVS
	call GetPartyParamLocationAndValue
_GetEVTotal:
	ld a, 6
	ld bc, 0
.loop
	push af
	ld a, [hli]
	add c
	ld c, a
	adc b
	sub c
	ld b, a
	pop af
	dec a
	jr nz, .loop

	; Compare with the modern EV limit.
	ld hl, -(MODERN_EV_LIMIT + 1)
	add hl, bc
	ret

CalcPkmnStats:
; Calculates all 6 Stats of a Pkmn
; b: Hyper Training (bit 7-2), apply EVs (bit 0)
; 'c' counts from 1-6 and points with 'wBaseStats' to the base value
; hl is the path to the EVs - 1
; de is a pointer where the 6 stats are placed

	ld c, 0
.loop
	inc c
	call CalcPkmnStatC
	ldh a, [hMultiplicand + 1]
	ld [de], a
	inc de
	ldh a, [hMultiplicand + 2]
	ld [de], a
	inc de
	ld a, c
	cp STAT_SDEF
	jr nz, .loop
	ret

CalcPkmnStatC:
; 'c' is 1-6 and points to the BaseStat
; 1: HP
; 2: Attack
; 3: Defense
; 4: Speed
; 5: SpAtk
; 6: SpDef
	push hl
	push de
	push bc
	ld d, b
	push hl
	ld hl, wBaseStats - 1 ; has to be decreased, because 'c' begins with 1
	ld b, 0
	add hl, bc
	ld e, [hl]
	pop hl
	push hl
	ld a, d
	and TRUE
	jr z, .no_evs
	ld a, [wInitialOptions2]
	and EV_OPTMASK
	jr z, .no_evs
	add hl, bc
	ld b, [hl]
.no_evs
	pop hl
	push bc
	ld bc, MON_DVS - (MON_EVS - 1)
	add hl, bc ; hl points to DVs
	pop bc
	ld a, [wInitialOptions]
	bit PERFECT_IVS_OPT, a
	ld a, $f
	jr nz, .GotDV
	ld a, d
	push bc
.hyper_training_loop
	rlca
	dec c
	jr nz, .hyper_training_loop
	pop bc
	ld a, $f
	jr c, .GotDV

.not_hyper_trained
	ld a, c
	dec a ; STAT_HP?
	jr z, .HP
	dec a ; STAT_ATK?
	jr z, .Attack
	dec a ; STAT_DEF?
	jr z, .Defense
	dec a ; STAT_SDF?
	jr z, .Speed
	dec a ; STAT_SAT?
	jr z, .SpAtk
	; STAT_SDEF
	inc hl
	inc hl
	ld a, [hld]
	dec hl
	jr .GotDV

.HP:
	ld a, [hl]
	jr .GotHighDV

.Attack:
	ld a, [hl]
	jr .GotDV

.Defense:
	inc hl
	ld a, [hld]
	jr .GotHighDV

.Speed:
	inc hl
	ld a, [hld]
	jr .GotDV

.SpAtk:
	inc hl
	inc hl
	ld a, [hld]
	dec hl
.GotHighDV:
	swap a
.GotDV:
	; de = e + a
	and $f
	add e
	ld e, a
	adc 0
	sub e
	ld d, a
	; de = (de * 2) + 1
	sla e
	inc e
	rl d
	srl b
	srl b
	ld a, b
	add e
	jr nc, .no_overflow_1
	inc d

.no_overflow_1
	ldh [hMultiplicand + 2], a
	ld a, d
	ldh [hMultiplicand + 1], a
	xor a
	ldh [hMultiplicand + 0], a
	ld a, [wCurPartyLevel]
	ldh [hMultiplier], a
	farcall Multiply
	ldh a, [hProduct + 1]
	ldh [hDividend + 0], a
	ldh a, [hProduct + 2]
	ldh [hDividend + 1], a
	ldh a, [hProduct + 3]
	ldh [hDividend + 2], a
	ld a, 100
	ldh [hDivisor], a
	ld a, 3
	ld b, a
	farcall Divide
	ld a, c
	cp STAT_HP
	ld a, STAT_MIN_NORMAL
	jr nz, .not_hp
	ld a, [wCurPartyLevel]
	ld b, a
	ldh a, [hQuotient + 2]
	add b
	ldh [hMultiplicand + 2], a
	jr nc, .no_overflow_2
	ldh a, [hQuotient + 1]
	inc a
	ldh [hMultiplicand + 1], a

.no_overflow_2
	ld a, STAT_MIN_HP

.not_hp
	ld b, a
	ldh a, [hQuotient + 2]
	add b
	ldh [hMultiplicand + 2], a
	jr nc, .no_overflow_3
	ldh a, [hQuotient + 1]
	inc a
	ldh [hMultiplicand + 1], a

.no_overflow_3
	ldh a, [hQuotient + 1]
	cp HIGH(1000) + 1
	jr nc, .max_stat
	cp HIGH(1000)
	jr c, .stat_value_okay
	ldh a, [hQuotient + 2]
	cp LOW(1000)
	jr c, .stat_value_okay

.max_stat
	ld a, HIGH(999)
	ldh [hMultiplicand + 1], a
	ld a, LOW(999)
	ldh [hMultiplicand + 2], a

.stat_value_okay
	; do natures here
	xor a
	ldh [hMultiplicand + 0], a
	push hl
	push bc
	ld bc, MON_NATURE - MON_DVS
	add hl, bc ; hl points to Nature
	ld a, [hl]
	and NATURE_MASK
	pop bc
	push bc
	call GetNatureStatMultiplier
	pop bc
	pop hl
	ldh [hMultiplier], a
	farcall Multiply
	ldh a, [hProduct + 1]
	ldh [hDividend + 0], a
	ldh a, [hProduct + 2]
	ldh [hDividend + 1], a
	ldh a, [hProduct + 3]
	ldh [hDividend + 2], a
	ld a, 10
	ldh [hDivisor], a
	ld a, 3
	ld b, a
	farcall Divide
	ldh a, [hQuotient + 1]
	ldh [hMultiplicand + 1], a
	ldh a, [hQuotient + 2]
	ldh [hMultiplicand + 2], a
	jmp PopBCDEHL

GetNatureStatMultiplier::
; a points to Nature
; c is 1-6 according to the stat (STAT_HP to STAT_SDEF)
; returns (sets a to) 9 if c is lowered, 11 if raised, 10 if neutral
; (to be used in calculations in CalcPkmnStatC)
	push de
	ld d, a
	ld a, c
	cp STAT_HP
	jr z, .neutral
	ld a, d
	ld b, a
	call GetNature
	ld a, b
	cp NO_NATURE
	jr z, .neutral
	ld d, STAT_HP
.loop
	inc d
	sub 5
	jr nc, .loop
	add 7 ; Atk-SDf is 2-6, not 0-4
	cp c
	jr z, .penalty
	ld a, d
	cp c
	jr z, .bonus
.neutral
	ld a, 10
	pop de
	ret
.bonus
	ld a, 11
	pop de
	ret
.penalty
	; Neutral natures (divisible by 6) raise and lower the same stat,
	; but +10% -10% isn't neutral (the result is 99%), so we need to
	; avoid messing with it altogether.
	cp d
	jr z, .neutral
	ld a, 9
	pop de
	ret

GetStatusConditionIndex:
; de points to status, e.g. from a party_struct or battle_struct
; return the status condition index in a
	ld a, [de]
	ld b, a
	and SLP_MASK
	ld a, 0 ; no-optimize a = 0
	jr nz, .slp
	bit TOX, b
	jr nz, .tox
	bit PSN, b
	jr nz, .psn
	bit PAR, b
	jr nz, .par
	bit BRN, b
	jr nz, .brn
	bit FRZ, b
	jr nz, .frz
	ret

.tox
	inc a ; 7
.fnt
	inc a ; 6
.frz
	inc a ; 5
.brn
	inc a ; 4
.slp
	inc a ; 3
.par
	inc a ; 2
.psn
	inc a ; 1
	ret

PlaceStatusString:
	xor a
	call GetStatusConditionIndex
	and a
	ret z
	push de

	ld d, 0
	ld e, a
	push hl
	ld hl, StatusStringPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	pop hl

	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a

	pop de
	ld a, $1
	and a
	ret

StatusStringPointers:
	dw OKString
	dw PsnString
	dw ParString
	dw SlpString
	dw BrnString
	dw FrzString
	dw FntString
	dw ToxString

OKString:  rawchar "OK @"
PsnString: rawchar "Psn@"
ParString: rawchar "Par@"
SlpString: rawchar "Slp@"
BrnString: rawchar "Brn@"
FrzString: rawchar "Frz@"
FntString: rawchar "Fnt@"
ToxString: rawchar "Tox@"

ListMoves:
; List moves at hl, spaced every [wBuffer1] tiles.
	ld de, wListMoves_MoveIndicesBuffer
	ld b, $0
.moves_loop
	ld a, [de]
	inc de
	and a
	jr z, .no_more_moves
	push de
	push hl
	push bc
	ld [wNamedObjectIndex], a
	call GetMoveName
	rst PlaceString
	pop bc
	ld a, b
	ld [wNumMoves], a
	inc b
	pop hl
	push bc
	ld a, [wBuffer1]
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	pop de
	ld a, b
	cp NUM_MOVES
	ret z
	jr .moves_loop

.no_more_moves
	ld a, b
.nonmove_loop
	push af
	ld [hl], "-"
	ld a, [wBuffer1]
	ld c, a
	ld b, 0
	add hl, bc
	pop af
	inc a
	cp NUM_MOVES
	jr nz, .nonmove_loop
	ret
