BTMON_SIZE EQU 9 ; species + personality extspecies/gender/form + item + 4 moves + DV index + personality ability/nature

INCLUDE "data/battle_tower/classes.asm"
INCLUDE "data/battle_tower/tiers.asm"

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

NewRentalTeam:
; Gives the player 6 rental Pokémon to choose from. The first 3
; are guranteed to be legal together (the first 6 run into problems with
; Item Clause).
	; First, figure out tier selection.
	ld a, [wBattleFactorySwapCount]
	ld c, 6
	call SimpleDivide
	ld b, a

	ld a, 5 ; same as for trainer 6 (0-indexed).
	push bc
	call BT_GetPointsForTrainer
	pop bc
	add b
	cp 9
	jr c, .got_tier_table
	ld a, 8
.got_tier_table
	dec a
	add a
	ld hl, BattleTowerTierTable
	ld b, 0
	ld c, a
	add hl, bc

	; Add both tables to populate a team of 6.
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ld c, 2
	ld hl, wBT_MonParty
	push hl
.outer_add_loop
	ld b, BATTLETOWER_PARTY_LENGTH
.add_loop
	ld a, d
	and %11
	ld [hli], a
	ld a, -1 ; pick a random number within a tier group
	ld [hli], a
	srl d
	srl d
	dec b
	jr nz, .add_loop
	dec c
	ld d, e
	jr nz, .outer_add_loop

	; Now, shuffle the tier composition as to not reveal what tiers each mon is.
	ld c, PARTY_LENGTH
	pop hl
	call ShuffleTierSelections

	; Group composition complete. Now generate the actual sets.
.generate_team
	xor a
	ld [wOTPartyCount], a

	ld hl, wBT_MonParty
	ld b, BATTLETOWER_PARTY_LENGTH

.generate_loop
	push bc
	ld a, [hli]
	ld b, a

	; Ignore set index, we want to pick a random mon.
	ld c, -1
	call BT_AppendOTMon

	ld a, c
	ld [hli], a
	pop bc
	dec b
	jr nz, .generate_loop

	; Check if the team is legal. Otherwise, generate a new team.
	farcall BT_LegalityCheck
	jr nz, .generate_team

.generate_filler
	; The picks are legal. Now, generate filler to fill up the rest
	; of the party without checking for legality. We do, however, still
	; want them to be distinct sets, checked later.
	ld a, BATTLETOWER_PARTY_LENGTH
	ld [wOTPartyCount], a

	ld hl, wBT_MonParty + BATTLETOWER_PARTYDATA_SIZE
	ld b, PARTY_LENGTH - BATTLETOWER_PARTY_LENGTH

.filler_loop
	push bc
	ld a, [hli]
	ld b, a

	; Ignore set index, we want to pick a random mon.
	ld c, -1
	call BT_AppendOTMon

	ld a, c
	ld [hli], a
	pop bc
	dec b
	jr nz, .filler_loop

	; Now, verify that all sets are distinct. This does check both
	; group + index, even if group is currently redundant. This is
	; in case we generate mons from different groups in the future.
	ld de, wBT_MonParty
	ld a, [wOTPartyCount]
	dec a
	ld c, a
.outer_loop
	ld h, d
	ld l, e
	inc hl
	inc hl
	ld b, c
.inner_loop
	; Is group identical?
	ld a, [de]
	cp [hl]
	inc de
	inc hl
	jr nz, .next

	; Is set identical?
	ld a, [de]
	cp [hl]
	jr z, .generate_filler

.next
	dec de
	inc hl
	dec b
	jr nz, .inner_loop
	inc de
	inc de
	dec c
	jr nz, .outer_loop
	ret

LoadRentalParty:
; Loads the 6 player rental Pokémon in wBT_MonParty for party lineup.
	ld hl, wBT_MonParty
	ld b, PARTY_LENGTH
	call LoadAnyParty

	; Copy it to the player party.
	ld hl, wOTPartyCount
	ld de, wPartyCount
	ld bc, wPartyMonNicknamesEnd - wPartyCount
	rst CopyBytes
	ret

LoadOpponentParty:
; Loads opponent party in wBT_OTMonParty to the OT party.
	ld hl, wBT_OTMonParty
	ld b, BATTLETOWER_PARTY_LENGTH
	; fallthrough
LoadAnyParty:
	xor a
	ld [wOTPartyCount], a
.loop
	push bc
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	call BT_AppendOTMon
	pop bc
	dec b
	jr nz, .loop
	ret

PopulateBattleTowerTeam:
; Prepares your and the opponent's parties for battle tower battle.
	; Populate wOTPartyMons with your selections. Used for legality
	; checking, but works just as well here as a straightforward way
	; to get the party in the correct order. Yes, we need to do this,
	; we can't abuse the fact that the legality checker already did
	; this, or we run into trouble after the first battle.
	farcall BT_InRentalMode
	jr z, .rental

	farcall BT_LoadPartySelections
	farcall BT_SetPlayerOT

	; Now copy the OT data to the player party struct
	ld hl, wOTPartyCount
	ld de, wPartyCount
	ld bc, wPartyMonNicknamesEnd - wPartyCount
	rst CopyBytes

	; Generate opponent trainer sets.
	call GenerateOpponentTrainer
	jr .copy_player_data

.rental
	; First, copy rental data from SRAM
	ld a, BANK(sBT_MonParty)
	call GetSRAMBank
	ld hl, sBT_MonParty
	ld de, wBT_MonParty
	ld bc, BATTLETOWER_PARTYDATA_SIZE
	rst CopyBytes
	call CloseSRAM

	; Now, add rental choices to OT party
	xor a
	ld [wOTPartyCount], a
	ld hl, wBT_MonParty

	ld b, BATTLETOWER_PARTY_LENGTH
.rental_loop
	push bc
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	call BT_AppendOTMon
	pop bc
	dec b
	jr nz, .rental_loop

	; Now copy the OT data to the player party struct
	ld hl, wOTPartyCount
	ld de, wPartyCount
	ld bc, wPartyMonNicknamesEnd - wPartyCount
	rst CopyBytes
	; fallthrough
.copy_player_data
	; Now load opponent party data into OT.
	call LoadOpponentParty

	; Set everything to level BATTLETOWER_FORCED_LEVEL, then we're done.
	ld a, BATTLETOWER_FORCED_LEVEL
	jmp BT_SetLevel

GenerateOpponentTrainer:
	call BT_GetTierTable

.generate_team
	; Now add the enemy trainer data
	; Mark the OT struct as not having any mons
	xor a
	ld [wOTPartyCount], a

	; Now append the list of mons according to chosen sets
	ld hl, wBT_OTMonParty
	ld b, BATTLETOWER_PARTY_LENGTH
.generate_loop
	; Might have been opened if we ran into a failure condition.
	call CloseSRAM
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

	; Don't reuse recently seen mons, or anything in the player rental team.
	farcall BT_InRentalMode
	ld b, BATTLETOWER_PARTY_LENGTH
	ld de, wBT_OTMonParty
	jr nz, .not_rental

	; Check rental lineup.
	push de
	push bc
	ld c, PARTY_LENGTH
	ld hl, wBT_MonParty
	call CheckSetRepeats
	pop bc
	pop de
	jr c, .generate_team

.not_rental
	; Check previous trainers.
	ld a, BANK(sBT_OTMonParties)
	call GetSRAMBank
	ld c, BATTLETOWER_PARTY_LENGTH * BATTLETOWER_SAVEDPARTIES
	ld hl, sBT_OTMonParties
	call CheckSetRepeats
	jr c, .generate_team

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

	; Set everything to level BATTLETOWER_FORCED_LEVEL, then we're done.
	ld a, BATTLETOWER_FORCED_LEVEL
	jmp BT_SetLevel

CheckSetRepeats:
; Checks set repeats between de array length b and hl array length c.
; Returns c if there was a repeat.
	push hl
	push bc
.repeat_outer_loop
	pop bc
	pop hl
	dec b
	push hl
	push bc
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

	; If number is also identical, we reached an identical set.
	scf
	jr z, .done

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
	and a
.done
	pop bc
	pop hl
	ret

BT_AppendOTMon:
; Appends mon c from set b to OT party. If c is -1, appends a random set b mon.
; Preserves de, hl, b. If c is -1, it is set to the actual resulting index.
	push hl
	push de
	push bc
	ld hl, BattleTowerMons
	ld a, b
	push bc
	call BT_GetTargetTier
	pop bc
	ld a, c
	inc a
	jr nz, .got_mon_index
	call BT_GetTierSize
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
	ld [wNamedObjectIndex], a ; for later nickname setup
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

	; Look up 3 actual DV bytes from a 1-byte ID
	ld a, [hli]
	ld b, a
	add a
	add b
	push hl
	add LOW(BattleTower_DVSpreads)
	ld l, a
	adc HIGH(BattleTower_DVSpreads)
	sub l
	ld h, a
	ld bc, 3
	ld a, MON_DVS
	call .Copy
	pop hl

	; The 2nd personality byte is specified as part of extspecies
	ld bc, 1
	ld a, MON_PERSONALITY
	call .Copy

	; We're done copying the struct. Now generate the rest.
	; Some of this might seem unnecessary, but is required to
	; make the stats screen look good for rental mons.
	; Happiness is always 255
	ld hl, MON_HAPPINESS
	add hl, de
	ld [hl], 255

	; Clear status conditions
	ld hl, MON_STATUS
	add hl, de
	xor a
	ld [hl], a

	; Set capture data
	ld hl, MON_CAUGHTDATA
	add hl, de
	ld a, [wTimeOfDay]
	inc a
	rrca
	rrca
	rrca
	and CAUGHT_TIME_MASK
	or POKE_BALL
	ld [hli], a
	ld a, BATTLETOWER_FORCED_LEVEL
	ld [hli], a
	ld a, BATTLE_TOWER
	ld [hli], a

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

BT_GetTierTable:
; Generates the appropriate tier table given our current winstreak.
; Our current winstreak gives a certain amount of BP, but also serves
; to determine what tiers the opponent Trainer gets his/her Pokémon from.
; This is read from BattleTowerTierTable.
	farcall BT_GetCurTrainer
	call BT_GetPointsForTrainer

	; There's no tier table beyond 8, so don't try to check beyond that.
	cp 9
	jr c, .got_bp_amount
	ld a, 8
.got_bp_amount
	dec a ; we want 0-7, not 1-8
	add a
	ld c, a

	; Select one of 2 tier tables at random
	ld hl, BattleTowerTierTable
	call Random
	and 1

	; Get the tier group
	add c
	add l
	ld l, a
	adc h
	sub l
	ld h, a

	; Store which tiers to use.
	ld c, [hl]
	ld b, BATTLETOWER_PARTY_LENGTH
	ld hl, wBT_OTMonParty
.add_loop
	ld a, c
	and %11
	ld [hli], a
	ld a, -1 ; pick a random number within a tier group
	ld [hli], a
	srl c
	srl c
	dec b
	jr nz, .add_loop

	; Now shuffle the team.
	ld c, BATTLETOWER_PARTY_LENGTH
	ld hl, wBT_OTMonParty
	; fallthrough
ShuffleTierSelections:
; Shuffles 16bit array in hl of length c.
.shuffle_loop
	; This is intentional. We iterate one less than the amount of mons.
	dec c
	ret z
	ld b, 0
	ld a, c
	inc a
	call RandomRange
	push hl
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
	call .SwapByte
	inc de
	inc hl
	call .SwapByte
	pop hl
	jr .shuffle_loop

.SwapByte:
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	ret

BT_GetPointsForTrainer:
; Returns BP reward that the given trainer in a gives from the table below.
; TOWER
; Challenge run 1: 1, 2, 2, 3, 3, 4, 5, 20 total
; Challenge run 2: 2, 3, 3, 4, 4, 5, 6, 27 total
; Challenge run 3: 3, 4, 4, 5, 5, 6, 7, 34 total (Tycoon run)
; Challenge run 4: 4, 5, 5, 6, 6, 7, 8, 41 total
; Challenge run 5: 5, 6, 6, 7, 7, 8, 8, 47 total
; Challenge run 6: 6, 7, 7, 8, 8, 8, 8, 52 total (Tycoon run)
; Challenge run 7: 7, 8, 8, 8, 8, 8, 8, 55 total
; Challenge run 8: 8, 8, 8, 8, 8, 8, 8, 56 total

; FACTORY
; Challenge run 1: 1, 1, 1, 2, 2, 2, 3, 12 total
; Challenge run 2: 2, 2, 2, 3, 3, 3, 4, 19 total
; Challenge run 3: 3, 3, 3, 4, 4, 4, 5, 26 total (Tycoon run)
; Challenge run 4: 4, 4, 4, 5, 5, 5, 6, 33 total
; Challenge run 5: 5, 5, 5, 6, 6, 6, 7, 40 total
; Challenge run 6: 6, 6, 6, 7, 7, 7, 8, 47 total (Tycoon run)
; Challenge run 7: 7, 7, 7, 8, 8, 8, 8, 53 total
; Challenge run 8: 8, 8, 8, 8, 8, 8, 8, 56 total
; Challenge runs after 8 award the same as run 8.
; Rental selection tier takes the one from trainer 6, and adds 1
; for every 6 swaps with previous trainer's mon.
	; a is dealt with later
	ld b, a
	push hl
	farcall BT_GetCurStreakAddr

	; If our current streak exceeds 255, just return 8.
	ld a, [hli]
	and a
	ld a, [hl]
	pop hl
	jr nz, .overflow

	; Calculate (current challenge trainer + current streak) / 7.
	; This effectively gives us challenge run in b and current trainer in a.
	add b
	jr c, .overflow
	ld c, 7
	call SimpleDivide
	ld c, a
	inc b ; Current challenge run (1-36, 37+ means 255+ wins, handled above)
	inc c ; Current trainer (1-7)

	farcall BT_InRentalMode
	ld a, c
	jr nz, .not_rental

	; In rental mode, every 3rd trainer increases the current tier.
	cp 4
	jr c, .got_rental_bp
	inc b
	cp 7
	jr c, .got_rental_bp
	inc b
.got_rental_bp
	ld a, b
	jr .got_bp

.not_rental
	; +1 for trainer 2-3, +2 for 4-5, +3 for 6, +4 for 7.
	cp 7
	jr nz, .no_extra
	inc a
.no_extra
	srl a ; can't use rra since carry state is unknown
	add b

.got_bp
	; Cap at 8
	cp 9
	ret c
.overflow
	ld a, 8
	ret

BT_GetEVsForTrainer:
; Return EVs for given trainer in a. Value is (CurStreak + CurTrainer) * 16,
; capped at 252 in Battle Tower, and always 252 in Battle Factory.
	ld b, a
	farcall BT_InRentalMode
	jr z, .max

	; If our current streak exceeds 255, just return 252.
	ld a, [wBattleTowerCurStreak]
	and a
	jr nz, .max

	ld a, [wBattleTowerCurStreak + 1]
	add b
	jr c, .max
	cp 16
	jr nc, .max

	; EVs = (current streak + current trainer) * 16
	swap a
	ret

.max
	ld a, 252
	ret

BT_GetTargetTier:
; Set hl to target tier a. If higher than the amount of tiers, gives the last tier.
	cp BATTLETOWER_NUM_TIERS
	jr c, .ok
	ld a, BATTLETOWER_NUM_TIERS - 1
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

BT_GetTierSize:
; Return size of battle tower tier in hl
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
	push de
	ld d, a ; needed for CalcExpAtLevel
	farcall CalcExpAtLevel
	pop de
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
INCLUDE "data/battle_tower/dvs.asm"
