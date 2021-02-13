BTMON_SIZE EQU 11 ; species + item + 4 moves + 3 DVs + 2 personality

INCLUDE "data/battle_tower/classes.asm"
INCLUDE "data/battle_tower/sets.asm"

WriteBattleTowerTrainerName:
; Returns trainer class in a
	ld hl, BattleTowerTrainers
	ld a, NAME_LENGTH
	rst AddNTimes
	ld de, wOTPlayerName
	ld bc, NAME_LENGTH - 1
	rst CopyBytes

	; Add terminator
	ld a, "@"
	ld [de], a

	; The 11th byte is actually trainer class, not a terminator.
	ld a, [hl]
	ld [wOtherTrainerClass], a
	ret

PopulateBattleTowerTeam:
; Prepares your and the opponent's parties for battle tower battle
	; Populate wOTPartyMons with your selections. Used for legality
	; checking, but works just as well here as a straightforward way
	; to get the party in the correct order. Yes, we need to do this,
	; we can't abuse the fact that the legality checker already did
	; this, or we run into trouble after the first battle.
	farcall BT_LoadPartySelections
	farcall BT_SetPlayerOT

	; Now copy the OT data to the player party struct
	ld hl, wOTPartyCount
	ld de, wPartyCount
	ld bc, wPartyMonNicknamesEnd - wPartyCount
	rst CopyBytes

	; Generate opponent set usage
	call BT_GetSetTable

.generate_team
	; Now add the enemy trainer data
	; Mark the OT struct as not having any mons
	xor a
	ld [wOTPartyCount], a

	; Now append the list of mons according to chosen sets
	ld hl, wBT_OTMonParty
	ld b, BATTLETOWER_NROFPKMNS
.generate_loop
	push bc
	ld a, [hli]
	ld b, a

	; Ignore set index, we want to pick a random mon.
	ld c, -1
	call BT_AppendOTMon

	; Store actual index generated.
	ld a, c
	ld [hli], a
	pop bc
	dec b
	jr nz, .generate_loop

	; Check if the team is legal. Otherwise, generate a new team.
	farcall BT_LegalityCheck
	jr nz, .generate_team

	; Don't reuse recently seen mons.
	ld a, BANK(sBT_OTMonParties)
	call GetSRAMBank
	ld de, wBT_OTMonParty
	ld b, BATTLETOWER_NROFPKMNS
.repeat_outer_loop
	ld c, BATTLETOWER_NROFPKMNS * BATTLETOWER_SAVEDPARTIES
	ld hl, sBT_OTMonParties
.repeat_loop
	; Check if set is identical
	ld a, [de]
	cp [hl]
	inc de
	inc hl
	jr nz, .next_repeat

	; Set is identical. Check mon number.
	ld a, [de]
	cp [hl]

	; If number is also identical, re-roll.
	jr z, .generate_team
.next_repeat
	dec de
	inc hl
	dec c
	jr nz, .repeat_loop

	; Check next party slot
	inc de
	inc de
	dec b
	jr nz, .repeat_outer_loop

	; Done with checks. Shift SRAM parties and store current party.
	ld hl, sBT_OTMonParties + BATTLETOWER_PARTYDATA_SIZE
	ld de, sBT_OTMonParties
	ld bc, BATTLETOWER_PARTYDATA_SIZE * (BATTLETOWER_SAVEDPARTIES - 1)
	rst CopyBytes

	; And insert the current party in the last slot
	ld hl, wBT_OTMonParty
	ld bc, BATTLETOWER_PARTYDATA_SIZE
	rst CopyBytes

	call CloseSRAM

	; Set everything to level 50, then we're done.
	ld a, 50
	jp BT_SetLevel

BT_AppendOTMon:
; Appends mon c from set b to OT party. If c is -1, appends a random set b mon.
; Preserves de, hl, b. If c is -1, it is set to the actual resulting index.
	push hl
	push de
	push bc
	ld hl, BattleTowerMons
	ld a, b
	push bc
	call BT_GetTargetSet
	pop bc
	ld a, c
	inc a
	jr nz, .got_mon_index
	call BT_GetSetSize
	call RandomRange
	ld c, a

.got_mon_index
	; hl now points to the correct set. Make it point to the correct index.
	push bc
	ld b, 0
	ld a, BTMON_SIZE
	rst AddNTimes

	; Now we can actually start adding data.
	ld b, [hl]
	ld a, b
	ld [wNamedObjectIndexBuffer], a ; for later nickname setup
	push hl

	; Add first species byte.
	ld hl, wOTPartySpecies
	ld a, [wOTPartyCount]
	push af
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld [hl], b
	pop af

	; Also append terminator
	inc hl
	ld [hl], -1

	; Set de to the relevant partymon struct.
	ld hl, wOTPartyMon1
	call GetPartyLocation
	ld d, h
	ld e, l
	pop hl

	; Add second species byte
	ld bc, 1
	ld a, MON_SPECIES
	call .Copy

	; Add form byte
	ld bc, 1
	ld a, MON_FORM
	call .Copy

	; Add item
	ld bc, 1
	ld a, MON_ITEM
	call .Copy

	; Add moves
	ld bc, NUM_MOVES
	ld a, MON_MOVES
	call .Copy

	push hl
	ld hl, MON_MOVES
	add hl, de
	push de
	push hl
	ld hl, MON_PP
	add hl, de
	ld d, h
	ld e, l
	pop hl
	predef FillPP
	pop de
	pop hl

	ld bc, 3
	ld a, MON_DVS
	call .Copy

	; The 2nd personality byte is specified as part of extspecies
	ld bc, 1
	ld a, MON_PERSONALITY
	call .Copy

	; We're done copying the struct. Now generate the rest.
	; Happiness is always 255
	ld hl, MON_HAPPINESS
	add hl, de
	ld [hl], 255

	; Set EVs
	farcall BT_GetCurTrainer
	call BT_GetEVsForTrainer
	ld hl, MON_EVS
	add hl, de
	ld bc, 6
	rst ByteFill

	; If Speed DV is zero, also set Speed EV to zero
	ld hl, wPartyMon1DefSpdDV - wPartyMon1
	add hl, de
	ld a, [hl]
	and $f
	jr nz, .speed_dv_ok
	ld hl, MON_SPD_EV
	add hl, de
	ld [hl], a

.speed_dv_ok
	; Set up nickname. Species is already in named object index buffer.
	call GetPokemonName
	ld hl, wOTPartyMonNicknames
	ld a, [wOTPartyCount]
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	; All done, now we just have to increment the party counter
	ld a, [wOTPartyCount]
	inc a
	ld [wOTPartyCount], a
	pop bc

	; Overwrite c with actual set index, assuming it was -1 previously.
	ld a, c
	pop bc
	ld c, a
	pop de
	pop hl
	ret

.Copy:
; Copies bc bytes from hl to de+a. Preserves de but (deliberately) not hl.
	push de
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	rst CopyBytes
	pop de
	ret

BT_GetSetTable:
; Generates the appropriate set table given our current winstreak.
; Our current winstreak gives a certain amount of BP, but also serves
; to determine what sets the opponent Trainer gets his/her Pokémon from.
; This is read from BattleTowerSetTable.
	farcall BT_GetCurTrainer
	call BT_GetPointsForTrainer

	; There's no set table beyond 8, so don't try to check beyond that.
	cp 9
	jr c, .got_bp_amount
	ld a, 8
.got_bp_amount
	dec a ; we want 0-7, not 1-8
	add a
	ld c, a

	; Select one of 2 set tables at random
	ld hl, BattleTowerSetTable
	call Random
	and 1

	; Get the set
	add c
	add l
	ld l, a
	adc h
	sub l
	ld h, a

	; Store which sets to use.
	ld c, [hl]
	ld b, BATTLETOWER_NROFPKMNS
	ld hl, wBT_OTMonParty
.add_loop
	ld a, c
	and %11
	ld [hli], a
	ld [hl], -1 ; pick a random number within a set
	inc hl
	srl c
	srl c
	dec b
	jr nz, .add_loop

	; Now shuffle the team. The - 1 is intentional, we iterate one less.
	ld c, BATTLETOWER_NROFPKMNS

.shuffle_loop
	; This is intentional. We iterate one less than the amount of mons.
	dec c
	ret z
	ld b, 0
	ld hl, wBT_OTMonParty
	ld a, c
	inc a
	call RandomRange
	push bc
	add a ; each index is 2 bytes
	ld c, a
	push hl
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	add hl, bc
	add hl, bc
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	dec c
	jr nz, .shuffle_loop

BT_GetPointsForTrainer:
; Returns BP reward that the given trainer in a gives from the table below.
; Challenge run 1: 1, 2, 2, 3, 3, 4, 5, 20 total
; Challenge run 2: 2, 3, 3, 4, 4, 5, 6, 27 total
; Challenge run 3: 3, 4, 4, 5, 5, 6, 7, 34 total (Tycoon run)
; Challenge run 4: 4, 5, 5, 6, 6, 7, 8, 41 total
; Challenge run 5: 5, 6, 6, 7, 7, 8, 8, 47 total
; Challenge run 6: 6, 7, 7, 8, 8, 8, 8, 52 total (Tycoon run)
; Challenge run 7: 7, 8, 8, 8, 8, 8, 8, 55 total
; Challenge run 8: 8, 8, 8, 8, 8, 8, 8, 56 total
; Challenge runs after 8 award the same as run 8.
	; a is dealt with later
	ld b, a

	; If our current streak exceeds 255, just return 8.
	ld a, [wBattleTowerCurStreak]
	and a
	jr nz, .overflow

	; Calculate (current challenge trainer + current streak) / 7.
	; This effectively gives us challenge run in b and current trainer in a.
	ld a, [wBattleTowerCurStreak + 1]
	add b
	jr c, .overflow
	ld c, 7
	call SimpleDivide

	inc a ; Current trainer (1-7)
	inc b ; Current challenge run (1-36, 37+ means 255+ wins, handled above)

	; +1 for trainer 2-3, +2 for 4-5, +3 for 6, +4 for 7.
	cp 7
	jr nz, .no_extra
	inc a
.no_extra
	srl a ; can't use rra since carry state is unknown
	add b

	; Cap at 8
	cp 9
	ret c
.overflow
	ld a, 8
	ret

BT_GetEVsForTrainer:
; Return EVs for given trainer in a. Value is (CurStreak + CurTrainer) * 16,
; capped at 252.
	ld b, a

	; If our current streak exceeds 255, just return 252.
	ld a, [wBattleTowerCurStreak]
	and a
	jr nz, .overflow

	ld a, [wBattleTowerCurStreak + 1]
	add b
	jr c, .overflow
	cp 16
	jr nc, .overflow

	; EVs = (current streak + current trainer) * 16
	swap a
	ret

.overflow
	ld a, 252
	ret

BT_GetTargetSet:
; Set hl to target set a. If higher than the amount of sets, gives the last set.
	cp BATTLETOWER_NUM_SETS
	jr c, .ok
	ld a, BATTLETOWER_NUM_SETS - 1
.ok
	inc a
	ld hl, BattleTowerMons
	ld bc, BTMON_SIZE
	ld d, a
.loop
	dec d
	ret z
.loop_inner
	ld a, [hl]
	inc a
	jr z, .next
	add hl, bc
	jr .loop_inner
.next
	inc hl
	jr .loop

BT_GetSetSize:
; Return size of battle tower set in hl
	ld bc, BTMON_SIZE
	push hl
	ld d, 0
.loop
	ld a, [hl]
	inc a
	jr z, .done
	add hl, bc
	inc d
	jr .loop
.done
	pop hl
	ld a, d
	ret

BT_SetLevel:
; Set level of all pokémon in your and opponent's party to a and set HP to max HP
	ld d, a
	ld a, [wPartyCount]
	ld hl, wPartyMon1
	call .set_level
	set 7, d ; flag that we're dealing with opponent
	ld a, [wOTPartyCount]
	ld hl, wOTPartyMon1
.set_level
	dec a
	ld e, a
.loop
	push hl
	ld a, e
	push de
	call GetPartyLocation

	; Get base stats and experience group
	ld bc, wPartyMon1Species - wPartyMon1
	add hl, bc
	ld a, [hl]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	ld bc, wPartyMon1Form - wPartyMon1Species
	add hl, bc
	ld a, [hl]
	ld [wCurForm], a
	call GetBaseData

	ld bc, wPartyMon1Level - wPartyMon1Form
	add hl, bc
	pop de
	push de
	ld a, d
	and $7f
	ld [hl], a
	ld [wCurPartyLevel], a ; for stat calculation

	; Set up Exp properly
	ld bc, wPartyMon1Exp - wPartyMon1Level
	add hl, bc
	push hl
	farcall CalcExpAtLevel
	pop hl
	push hl
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop hl
	pop de
	push de
	bit 7, d
	ld a, 0
	jr nz, .hyper_training_done
	push hl
	ld a, e
	ld [wCurPartyMon], a
	farcall GetHyperTraining
	pop hl

.hyper_training_done
	; Calculate stats
	push af
	ld bc, wPartyMon1MaxHP - wPartyMon1Exp
	add hl, bc
	push hl
	ld bc, wPartyMon1EVs - wPartyMon1MaxHP - 1
	add hl, bc ; 'hl' now points to EVs - 1, needed by CalcPkmnStats
	pop de
	pop af

	inc a
	ld b, a
	push de
	predef CalcPkmnStats
	pop hl
	push hl
	ld bc, wOTPartyMon1HP - wOTPartyMon1MaxHP
	add hl, bc
	pop de
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	pop de
	pop hl
	ld a, e
	and a
	ret z
	dec e
	jr .loop

INCLUDE "data/battle_tower/parties.asm"
