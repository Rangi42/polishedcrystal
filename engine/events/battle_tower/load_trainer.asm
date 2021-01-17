Function_LoadOpponentTrainer:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBT_OTTrainer)
	ldh [rSVBK], a

	; Fill BT_OTTrainer with zeros
	xor a
	ld hl, wBT_OTTrainer
	ld bc, wBT_OTTrainerEnd - wBT_OTTrainer
	rst ByteFill

	ld a, BANK(sBTTrainers)
	call GetSRAMBank
	ld a, [sNrOfBeatenBattleTowerTrainers]
	call CloseSRAM

	; Every 3rd complete battle tower session, meet the tycoon
.tycoon_loop
	sub BATTLETOWER_NROFTRAINERS * 3
	jr nc, .tycoon_loop
	inc a
	jr z, .load_tycoon

	ldh a, [hRandomAdd]
	ld b, a
.resample ; loop to find a random trainer
	call Random
	ldh a, [hRandomAdd]
	add b
	ld b, a ; b contains the nr of the trainer
	and %01111111
if BATTLETOWER_NUM_TRAINERS != 128
	cp BATTLETOWER_NUM_TRAINERS
	jr nc, .resample
endc
	ld b, a

	ld a, BANK(sBTTrainers)
	call GetSRAMBank

	ld c, BATTLETOWER_NROFTRAINERS
	ld hl, sBTTrainers
.next_trainer
	ld a, [hli]
	cp b
	jr z, .resample
	dec c
	jr nz, .next_trainer ; c <= 7  initialise all 7 trainers?
	jp .found_trainer

.load_tycoon:
	ld a, BATTLETOWER_NUM_TRAINERS
	ld b, a

.found_trainer:
	ld hl, sBTTrainers
	ld a, [sNrOfBeatenBattleTowerTrainers]
	ld c, a
	ld a, b
	ld b, 0
	add hl, bc
	ld [hl], a

	call CloseSRAM

; Copy name (10 bytes) and class (1 byte) of trainer
	ld hl, BattleTowerTrainers
	ld de, wBT_OTName
	ld bc, NAME_LENGTH
	rst AddNTimes
	ld bc, NAME_LENGTH
	rst CopyBytes

	call CloseSRAM

	pop af
	ldh [rSVBK], a
	ret

INCLUDE "data/battle_tower/classes.asm"

PopulateBattleTowerTeam:
; Loads 3 pokémon from a set and places it in OTPartyMon
	; Zerofill the OTPartyMon struct
	xor a
	ld hl, wOTPartyMons
	ld bc, wOTPartyMonsEnd - wOTPartyMons
	rst ByteFill

	; Set party size
	ld a, BATTLETOWER_NROFPKMNS
	ld [wOTPartyCount], a

	; Get the set and size
	ld a, [wNrOfBeatenBattleTowerTrainers]
	call BT_GetTargetSet
	call BT_GetSetSize
	ld d, a

	; Pick randomly among the set but never duplicate species.
	ld e, 0
	push hl
	push de
.loop
	pop de
	pop hl
	ld a, e
	cp BATTLETOWER_NROFPKMNS
	jp z, .set_level
	push hl
	push de
	ld a, d
	call RandomRange
	ld bc, BattleTowerPokemon2 - BattleTowerPokemon1
	rst AddNTimes

	; Verify that the species hasn't been chosen already
	ld a, [hl]
	ld d, a
	inc e
.species_loop
	dec e
	jr z, .species_ok
	push hl
	ld hl, wOTPartyMon1Species
	ld a, e
	dec a
	call GetPartyLocation
	ld a, [hl]
	pop hl
	cp d
	jr z, .loop ; Duplicate species -- re-roll
	jr .species_loop
.species_ok
	; Species is OK. Store species data in wOTPartyMon and wOTPartySpecies
	pop de
	push de
	push hl
	ld a, e
	ld hl, wOTPartySpecies
	ld c, a
	ld b, 0
	add hl, bc
	ld b, h
	ld c, l
	ld hl, wOTPartyMon1Species
	call GetPartyLocation
	pop de

	; wOTPartyMon in hl, target battle tower data in de
	; Species
	ld a, [de]
	ld [hl], a
	ld [bc], a
	inc de

	ld bc, wOTPartyMon1Item - wOTPartyMon1Species
	add hl, bc
	ld a, [de]
	ld [hl], a
	inc de

	ld bc, wOTPartyMon1Moves - wOTPartyMon1Item
	add hl, bc
	ld b, NUM_MOVES
	call .Copy

	push hl
	push de
	push hl
	ld bc, wOTPartyMon1PP - wOTPartyMon1Moves
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	predef FillPP
	pop de
	pop hl

	ld bc, wOTPartyMon1DVs - wOTPartyMon1Moves
	add hl, bc
	ld b, 3
	call .Copy

	ld bc, wOTPartyMon1Personality - wOTPartyMon1DVs
	add hl, bc
	ld b, 2
	call .Copy

	; We're done copying the struct. Now generate the rest.
	; Happiness is always 255
	ld bc, wOTPartyMon1Happiness - wOTPartyMon1Personality
	add hl, bc
	ld [hl], 255

	; Set EVs to 252
	ld bc, wOTPartyMon1EVs - wOTPartyMon1Happiness
	add hl, bc
	push hl
	ld bc, 6
	ld a, 252
	rst ByteFill
	pop hl

	pop de
	inc e
	push de
	jp .loop

.set_level
	ld a, 50
	call BT_SetLevel

	; Initialize trainer nicknames
	ld a, [wOTPartyCount]
	ld d, a
.nick_loop
	dec d
	push de
	ld a, d
	ld hl, wOTPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, wOTPartyMonNicknames
	pop de
	push de
	ld a, d
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	pop de
	ld a, d
	and a
	jr nz, .nick_loop
	ret

.Copy:
	push hl
.copy_loop
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, .copy_loop
	pop hl
	ret

BT_GetTargetSet:
; Set hl to target set a. If a is higher than the amount of sets, gives the last set.
	cp BATTLETOWER_NUM_SETS
	jr c, .ok
	ld a, BATTLETOWER_NUM_SETS - 1
.ok
	inc a
	ld hl, BattleTowerMons
	ld bc, BattleTowerPokemon2 - BattleTowerPokemon1
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
	ld bc, BattleTowerPokemon2 - BattleTowerPokemon1
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
