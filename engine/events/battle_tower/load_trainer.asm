Function_LoadOpponentTrainer: ; 1f8000
	ld a, [rSVBK]
	push af
	ld a, BANK(BT_OTTrainer)
	ld [rSVBK], a

	; Fill BT_OTTrainer with zeros
	xor a
	ld hl, BT_OTTrainer
	ld bc, BT_OTTrainerEnd - BT_OTTrainer
	call ByteFill

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

	ld a, [hRandomAdd]
	ld b, a
.resample ; loop to find a random trainer
	call Random
	ld a, [hRandomAdd]
	add b
	ld b, a ; b contains the nr of the trainer
	and (1 << 7) - 1
	cp BATTLETOWER_NUM_TRAINERS
	jr nc, .resample
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
	ld de, BT_OTName
	ld bc, NAME_LENGTH
	call AddNTimes
	ld bc, NAME_LENGTH
	call CopyBytes

	call CloseSRAM

	pop af
	ld [rSVBK], a
	ret

INCLUDE "data/battle_tower/classes.asm"

PopulateBattleTowerTeam:
; Loads 3 pokémon from a set and places it in OTPartyMon
	; Zerofill the OTPartyMon struct
	xor a
	ld hl, OTPartyMons
	ld bc, OTPartyMonsEnd - OTPartyMons
	call ByteFill

	; Set party size
	ld a, BATTLETOWER_NROFPKMNS
	ld [OTPartyCount], a

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
	call AddNTimes

	; Verify that the species hasn't been chosen already
	ld a, [hl]
	ld d, a
	inc e
.species_loop
	dec e
	jr z, .species_ok
	push hl
	ld hl, OTPartyMon1Species
	ld a, e
	dec a
	call GetPartyLocation
	ld a, [hl]
	pop hl
	cp d
	jr z, .loop ; Duplicate species -- re-roll
	jr .species_loop
.species_ok
	; Species is OK. Store species data in OTPartyMon and OTPartySpecies
	pop de
	push de
	push hl
	ld a, e
	ld hl, OTPartySpecies
	ld c, a
	ld b, 0
	add hl, bc
	ld b, h
	ld c, l
	ld hl, OTPartyMon1Species
	call GetPartyLocation
	pop de

	; OTPartyMon in hl, target battle tower data in de
	; Species
	ld a, [de]
	ld [hl], a
	ld [bc], a
	inc de

	ld bc, OTPartyMon1Item - OTPartyMon1Species
	add hl, bc
	ld a, [de]
	ld [hl], a
	inc de

	ld bc, OTPartyMon1Moves - OTPartyMon1Item
	add hl, bc
	ld b, NUM_MOVES
	call .Copy

	push hl
	push de
	push hl
	ld bc, OTPartyMon1PP - OTPartyMon1Moves
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	predef FillPP
	pop de
	pop hl

	ld bc, OTPartyMon1DVs - OTPartyMon1Moves
	add hl, bc
	ld b, 3
	call .Copy

	ld bc, OTPartyMon1Personality - OTPartyMon1DVs
	add hl, bc
	ld b, 2
	call .Copy

	; We're done copying the struct. Now generate the rest.
	; Happiness is always 255
	ld bc, OTPartyMon1Happiness - OTPartyMon1Personality
	add hl, bc
	ld [hl], 255

	; Set EVs to 252
	ld bc, OTPartyMon1EVs - OTPartyMon1Happiness
	add hl, bc
	push hl
	ld bc, 6
	ld a, 252
	call ByteFill
	pop hl

	pop de
	inc e
	push de
	jp .loop

.set_level
	ld a, 50
	call BT_SetLevel

	; Initialize trainer nicknames
	ld a, [OTPartyCount]
	ld d, a
.nick_loop
	dec d
	push de
	ld a, d
	ld hl, OTPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, OTPartyMonNicknames
	pop de
	push de
	ld a, d
	call SkipNames
	ld d, h
	ld e, l
	ld hl, StringBuffer1
	ld bc, PKMN_NAME_LENGTH
	call CopyBytes
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
	ld a, [PartyCount]
	ld hl, PartyMon1
	call .set_level
	ld a, [OTPartyCount]
	ld hl, OTPartyMon1
.set_level
	dec a
	ld e, a
.loop
	push hl
	ld a, e
	push de
	call GetPartyLocation

	; Get base stats and experience group
	ld bc, PartyMon1Species - PartyMon1
	add hl, bc
	ld a, [hl]
	ld [CurSpecies], a
	ld [CurPartySpecies], a
	push hl
	call GetBaseData
	pop hl

	ld bc, PartyMon1Level - PartyMon1Species
	add hl, bc
	pop de
	push de
	ld a, d
	ld [hl], a
	ld [CurPartyLevel], a ; for stat calculation

	; Set up Exp properly
	ld bc, PartyMon1Exp - PartyMon1Level
	add hl, bc
	push hl
	farcall CalcExpAtLevel
	pop hl
	push hl
	ld a, [hProduct + 1]
	ld [hli], a
	ld a, [hProduct + 2]
	ld [hli], a
	ld a, [hProduct + 3]
	ld [hl], a
	pop hl

	; Calculate stats
	ld bc, PartyMon1MaxHP - PartyMon1Exp
	add hl, bc
	push hl
	ld bc, PartyMon1EVs - PartyMon1MaxHP
	add hl, bc
	pop de
	ld b, TRUE
	push de
	predef CalcPkmnStats
	pop hl
	push hl
	ld bc, OTPartyMon1HP - OTPartyMon1MaxHP
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
