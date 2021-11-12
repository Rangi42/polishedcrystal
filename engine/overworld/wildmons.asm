LoadWildMonData:
	call _GrassWildmonLookup
	jr c, .copy
	ld hl, wMornEncounterRate
	xor a
	ld [hli], a ; morn rate
	ld [hli], a ; day rate
	ld [hli], a ; nite rate
	ld [hl], a  ; eve rate
	jr .done_copy

.copy
	inc hl
	inc hl
	ld de, wMornEncounterRate
	ld bc, 3
	rst CopyBytes
	ld [de], a ; eve rate = nite rate
.done_copy
	call _WaterWildmonLookup
	ld a, 0
	jr nc, .no_copy
	inc hl
	inc hl
	ld a, [hl]
.no_copy
	ld [wWaterEncounterRate], a
	ret

FindNest:
; Parameters:
; e: 0 = Johto, 1 = Kanto, 2 = Orange
; wNamedObjectIndex: species
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	rst ByteFill
	ld a, e
	cp KANTO_REGION
	jr z, .kanto
	cp ORANGE_REGION
	jr z, .orange
	decoord 0, 0
	ld hl, JohtoGrassWildMons
	call .FindGrass
	ld hl, JohtoWaterWildMons
	call .FindWater
	ld hl, wRoamMon1Species
	call .RoamMon
	ld hl, wRoamMon2Species
	call .RoamMon
	ld hl, wRoamMon3Species
	jmp .RoamMon

.kanto
	decoord 0, 0
	ld hl, KantoGrassWildMons
	call .FindGrass
	ld hl, KantoWaterWildMons
	jr .FindWater

.orange
	decoord 0, 0
	ld hl, OrangeGrassWildMons
	call .FindGrass
	ld hl, OrangeWaterWildMons
	jr .FindWater

.FindGrass:
	ld a, [hl]
	cp -1
	ret z
	push hl

	; assume that navel rock is the first off-screen map, and end the search early
	ld a, [hli]
	cp GROUP_NAVEL_ROCK_INSIDE
	jr nz, .not_navel_rock_group
	ld b, a
	ld a, [hli]
	cp MAP_NAVEL_ROCK_INSIDE
	jr nz, .not_navel_rock_map
	pop hl
	ret

	ld a, [hli]
.not_navel_rock_group
	ld b, a
	ld a, [hli]
.not_navel_rock_map
	ld c, a
	inc hl
	inc hl
	inc hl
	ld a, NUM_GRASSMON * 3
	call .SearchMapForMon
	jr nc, .next_grass
	ld [de], a
	inc de

.next_grass
	pop hl
	ld bc, GRASS_WILDDATA_LENGTH
	add hl, bc
	jr .FindGrass

.FindWater:
	ld a, [hl]
	cp -1
	ret z
	push hl
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	inc hl
	ld a, 3
	call .SearchMapForMon
	jr nc, .next_water
	ld [de], a
	inc de

.next_water
	pop hl
	ld bc, WATER_WILDDATA_LENGTH
	add hl, bc
	jr .FindWater

.SearchMapForMon:
	inc hl
.ScanMapLoop:
	push af
	ld a, [wNamedObjectIndex]
	cp [hl]
	inc hl
	jr nz, .not_found

	; We want to check if the extspecies bit matches between hl and form
	ld a, [wCurForm]
	xor [hl]
	and EXTSPECIES_MASK
	jr z, .found

.not_found
	inc hl
	inc hl
	pop af
	dec a
	jr nz, .ScanMapLoop
	and a
	ret

.found
	pop af
	; fallthrough

.AppendNest:
	push de
	call GetWorldMapLocation
	ld c, a
	hlcoord 0, 0
	ld de, SCREEN_WIDTH * SCREEN_HEIGHT
.AppendNestLoop:
	ld a, [hli]
	cp c
	jr z, .found_nest
	dec de
	ld a, e
	or d
	jr nz, .AppendNestLoop
	ld a, c
	pop de
	scf
	ret

.found_nest
	pop de
	and a
	ret

.RoamMon:
	ld a, [hli]
	inc hl ; skip wRoamMon#Level
	ld b, a
	ld a, [wNamedObjectIndex]
	cp b
	ret nz
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	call .AppendNest
	ret nc
	ld [de], a
	inc de
	ret

TryWildEncounter::
; Try to trigger a wild encounter.
	; Do this first, because this affects some abilities messing with encounter rate
	call ChooseWildEncounter
	jr nz, .no_battle
	call .EncounterRate
	jr nc, .no_battle
	call CheckRepelEffect
	jr nc, .no_battle
	xor a
	ret

.no_battle
	xor a ; BATTLETYPE_NORMAL
	ld [wTempWildMonSpecies], a
	ld [wBattleType], a
	ld a, 1
	and a
	ret

.EncounterRate:
	call GetMapEncounterRate
	call ApplyMusicEffectOnEncounterRate
	call ApplyCleanseTagEffectOnEncounterRate
	call SetBattlerLevel
	call ApplyAbilityEffectsOnEncounterMon
	call Random
	cp b
	ret

GetMapEncounterRate:
	ld hl, wMornEncounterRate
	call CheckOnWater
	ld a, wWaterEncounterRate - wMornEncounterRate
	jr z, .ok
	ld a, [wTimeOfDay]
.ok
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	ret

ApplyMusicEffectOnEncounterRate::
; Pokemon March and Ruins of Alph signal double encounter rate.
; Pokemon Lullaby halves encounter rate.
	ld a, [wMapMusic]
	cp MUSIC_POKEMON_MARCH
	jr z, .double
	cp MUSIC_RUINS_OF_ALPH_RADIO
	jr z, .double
	cp MUSIC_POKEMON_LULLABY
	ret nz
	srl b
	ret

.double
	sla b
	ret

ApplyCleanseTagEffectOnEncounterRate::
; Cleanse Tag halves encounter rate.
	ld a, [wPartyCount]
	and a
	ret z
	ld hl, wPartyMon1Item
	ld de, PARTYMON_STRUCT_LENGTH
	ld c, a
.loop
	ld a, [hl]
	cp CLEANSE_TAG
	jr z, .cleansetag
	add hl, de
	dec c
	jr nz, .loop
	ret

.cleansetag
	srl b
	ret

SetBattlerLevel:
; Sets c to the level of the first nonfainted mon (to be sent first into wild fights)
	push bc
	ld hl, wPartyMon1HP
	ld bc, PARTYMON_STRUCT_LENGTH - 1
.loop
	ld a, [hli]
	or [hl]
	jr nz, .ok
	add hl, bc
	jr .loop

.ok
	pop bc
	; Set hl to level of said mon
rept 4
	dec hl
endr
	ld c, [hl]
	ret

ChooseWildEncounter:
	ld c, $ff
_ChooseWildEncounter:
	push bc
	call LoadWildMonDataPointer
	pop bc
	jmp nc, .nowildbattle
	push bc
	call CheckEncounterRoamMon
	pop bc
	jmp c, .startwildbattle
	xor a ; BATTLETYPE_NORMAL
	ld [wBattleType], a

	inc hl
	inc hl
	inc hl
	push bc
	call CheckOnWater
	pop bc
	ld de, WaterMonProbTable
	ld b, NUM_WATERMON
	jr z, .got_table
	inc hl
	inc hl
	call GetTimeOfDayNotEve
	push bc
	ld bc, NUM_GRASSMON * 3
	rst AddNTimes
	pop bc
	ld de, GrassMonProbTable
	ld b, NUM_GRASSMON

.got_table
	; Check if we want to force a type
	inc c
	jr z, .get_random_mon
	dec c

	; Check if we can actually encounter a valid species of the given type
	push de
	push hl
.force_loop
	inc hl ; We don't care about level
	ld a, [hli]
	ld [wCurSpecies], a
	ld a, [hli]
	ld [wCurForm], a
	push bc
	push hl
	call GetBaseData
	pop hl
	pop bc
	ld a, [wBaseType1]
	cp c
	jr z, .can_force_type
	ld a, [wBaseType2]
	cp c
	jr z, .can_force_type
	dec b
	jr nz, .force_loop
	ld c, $ff
.can_force_type
	inc c
	pop hl
	pop de
.get_random_mon
	dec c
	push hl ; wild mon data pointer
	ld a, 100
	call RandomRange
	ld b, -1
	ld h, d
	ld l, e
; This next loop chooses which mon to load up.
.prob_bracket_loop
	inc b
	cp [hl]
	inc hl
	jr nc, .prob_bracket_loop

	; At this point, b contains wildmon index to encounter.
	; Since each entry is 3 bytes, add b*3 to hl.
	ld a, b
	add b
	add b
	pop hl
	push hl
	add l
	ld l, a
	adc h
	sub l
	ld h, a

	; Get level
	ld a, [hli]
	ld b, a

	; Mons encountered while surfing sometimes get a minor level boost.
	push bc
	call CheckOnWater
	pop bc
	jr nz, .ok
	call Random
	cp 35 percent
	jr c, .ok
	inc b
	cp 65 percent
	jr c, .ok
	inc b
	cp 85 percent
	jr c, .ok
	inc b
	cp 95 percent
	jr c, .ok
	inc b
; Store the level
.ok
	ld a, b
	ld [wCurPartyLevel], a
	ld a, [hli]
	ld b, [hl]
	pop hl

	push af
	cp UNOWN
	jr nz, .unown_check_done

	; verify that it is actually unown
	bit MON_EXTSPECIES_F, b
	jr nz, .unown_check_done

	ld a, [wUnlockedUnowns]
	and a
	jr nz, .unown_check_done
	pop af
	jr .nowildbattle

.unown_check_done
	pop af

	; Check if we're forcing type
	ld [wCurSpecies], a
	ld a, b
	ld [wCurForm], a
	ld a, [wCurSpecies]
	ld b, a

	push bc
	push hl
	call GetBaseData
	pop hl
	pop bc
	ld a, [wBaseType1]
	cp c
	jr z, .loadwildmon
	ld a, [wBaseType2]
	cp c
	jr z, .loadwildmon
	inc c
	jr nz, .get_random_mon

.loadwildmon
	ld a, [wCurForm]
	ld [wWildMonForm], a
	ld a, b
	ld [wTempWildMonSpecies], a
	call IsAPokemon
	jr c, .nowildbattle

	ld a, [wMapGroup]
	cp GROUP_SOUL_HOUSE_B1F ; Soul House or Lavender Radio Tower
	jr nz, .not_ghost
	ld a, [wMapNumber]
	cp MAP_SOUL_HOUSE_B1F ; first Ghost map in its group
	jr c, .not_ghost
	ld a, SILPHSCOPE2
	ld [wCurKeyItem], a
	call CheckKeyItem
	jr c, .not_ghost
	ld a, BATTLETYPE_GHOST
	ld [wBattleType], a
.not_ghost

.startwildbattle
	xor a
	ret

.nowildbattle
	ld a, 1
	and a
	ret

INCLUDE "data/wild/probabilities.asm"

CheckRepelEffect::
; If there is no active Repel, there's no need to be here.
	ld a, [wRepelEffect]
	and a
	jr z, .encounter
	call SetBattlerLevel

	ld a, [wCurPartyLevel]
	cp c
.encounter
	ccf
	ret

ApplyAbilityEffectsOnEncounterMon:
; Consider making the abilities more useful in non-faithful
	call GetLeadAbility
	ret z
	ld hl, .AbilityEffects
	jmp BattleJumptable

.AbilityEffects:
	dbw ARENA_TRAP,    .ArenaTrap
	dbw FLASH_FIRE,    .FlashFire
	dbw HARVEST,       .Harvest
	dbw HUSTLE,        .Hustle
	dbw ILLUMINATE,    .Illuminate
	dbw INFILTRATOR,   .Infiltrator
	dbw INTIMIDATE,    .Intimidate
	dbw KEEN_EYE,      .KeenEye
	dbw LIGHTNING_ROD, .LightningRod
	dbw MAGNET_PULL,   .MagnetPull
	dbw NO_GUARD,      .NoGuard
	dbw PRESSURE,      .Pressure
	dbw QUICK_FEET,    .QuickFeet
	dbw STATIC,        .Static
	dbw STENCH,        .Stench
	dbw VITAL_SPIRIT,  .VitalSpirit
	dbw WHITE_SMOKE,   .WhiteSmoke
	dbw -1, -1

.ArenaTrap:
.Illuminate:
.NoGuard:
.double_encounter_rate
	sla b
	ret nc
	ld b, $ff
	ret

.Infiltrator:
.QuickFeet:
.Stench:
.WhiteSmoke:
.halve_encounter_rate
	srl b
.avoid_rate_underflow
	ld a, b
	and a
	ret nz
	ld b, 1
	ret

.Hustle:
.Pressure:
.VitalSpirit:
; Vanilla 3gen+: 50% to force upper bound in a level range
; Since we don't have level ranges, 50% to increase level by 1/8 (min 1)
	call Random
	rrca
	ret c
	ld a, c
	cp 100
	ret nc
	inc c
	ret

.Intimidate:
.KeenEye:
; Halve encounter rate if enemy is 5+ levels below leading nonfainted mon
	ld a, [wCurPartyLevel]
	add 5
	cp c
	ret nc
	jr .halve_encounter_rate

.FlashFire:
	push bc
	ld c, FIRE
	jr .force_wildtype
.Harvest:
	push bc
	ld c, GRASS
	jr .force_wildtype
.MagnetPull:
	push bc
	ld c, STEEL
	jr .force_wildtype
.LightningRod:
.Static:
	push bc
	ld c, ELECTRIC
.force_wildtype
	; Force type (if we can) 50% of the time
	call Random
	and 1
	call z, _ChooseWildEncounter
	pop bc
	ret

LoadWildMonDataPointer:
	call CheckOnWater
	jr z, _WaterWildmonLookup

_GrassWildmonLookup:
	ld hl, SwarmGrassWildMons
	ld bc, GRASS_WILDDATA_LENGTH
	call _SwarmWildmonCheck
	ret c
	call _GetGrassWildmonPointer
	ld bc, GRASS_WILDDATA_LENGTH
	jr _NormalWildmonOK

_WaterWildmonLookup:
	ld hl, SwarmWaterWildMons
	ld bc, WATER_WILDDATA_LENGTH
	call _SwarmWildmonCheck
	ret c
	call _GetWaterWildmonPointer
	ld bc, WATER_WILDDATA_LENGTH
	jr _NormalWildmonOK

_GetGrassWildmonPointer:
	call RegionCheck
	ld a, e
	ld hl, JohtoGrassWildMons
	and a ; cp JOHTO_REGION
	ret z
	ld hl, KantoGrassWildMons
	dec a ; cp KANTO_REGION
	ret z
	ld hl, OrangeGrassWildMons
	ret

_GetWaterWildmonPointer:
	call RegionCheck
	ld a, e
	ld hl, JohtoWaterWildMons
	and a ; cp JOHTO_REGION
	ret z
	ld hl, KantoWaterWildMons
	dec a ; cp KANTO_REGION
	ret z
	ld hl, OrangeWaterWildMons
	ret

_SwarmWildmonCheck:
	call CopyCurrMapDE
	push hl
	ld hl, wSwarmFlags
	bit 2, [hl]
	pop hl
	jr z, .CheckYanma
	ld a, [wDunsparceMapGroup]
	cp d
	jr nz, .CheckYanma
	ld a, [wDunsparceMapNumber]
	cp e
	jr nz, .CheckYanma
	call LookUpWildmonsForMapDE
	jr nc, _NoSwarmWildmon
	scf
	ret

.CheckYanma:
	push hl
	ld hl, wSwarmFlags
	bit 3, [hl]
	pop hl
	jr z, _NoSwarmWildmon
	ld a, [wYanmaMapGroup]
	cp d
	jr nz, _NoSwarmWildmon
	ld a, [wYanmaMapNumber]
	cp e
	jr nz, _NoSwarmWildmon
	call LookUpWildmonsForMapDE
	jr nc, _NoSwarmWildmon
	scf
	ret

_NoSwarmWildmon:
	and a
	ret

_NormalWildmonOK:
	call CopyCurrMapDE
	jr LookUpWildmonsForMapDE

CopyCurrMapDE:
	ld a, [wMapGroup]
	ld d, a
	ld a, [wMapNumber]
	ld e, a
	ret

LookUpWildmonsForMapDE:
.loop
	push hl
	ld a, [hl]
	inc a
	jr z, .nope
	ld a, d
	cp [hl]
	jr nz, .next
	inc hl
	ld a, e
	cp [hl]
	jr z, .yup

.next
	pop hl
	add hl, bc
	jr .loop

.nope
	pop hl
	and a
	ret

.yup
	pop hl
	scf
	ret

InitRoamMons:
; initialize wRoamMon structs

; species
	ld a, RAIKOU
	ld [wRoamMon1Species], a
	assert RAIKOU + 1 == ENTEI
	inc a
	ld [wRoamMon2Species], a

; level
	ld a, 40
	ld [wRoamMon1Level], a
	ld [wRoamMon2Level], a

; raikou starting map
	ld a, GROUP_ROUTE_42
	ld [wRoamMon1MapGroup], a
	ld a, MAP_ROUTE_42
	ld [wRoamMon1MapNumber], a

; entei starting map
	ld a, GROUP_ROUTE_37
	ld [wRoamMon2MapGroup], a
	ld a, MAP_ROUTE_37
	ld [wRoamMon2MapNumber], a

; hp
	xor a ; generate new stats
	ld [wRoamMon1HP], a
	ld [wRoamMon2HP], a

	ret

CheckEncounterRoamMon:
	push hl
; Don't trigger an encounter if we're on water.
	call CheckOnWater
	jr z, .DontEncounterRoamMon
; Load the current map group and number to de
	call CopyCurrMapDE
; Randomly select a beast.
	call Random
	cp 100 ; 25/64 chance
	jr nc, .DontEncounterRoamMon
	and %00000011 ; Of that, a 3/4 chance.  Running total: 75/256, or around 29.3%.
	jr z, .DontEncounterRoamMon
	dec a ; 1/3 chance that it's Entei, 1/3 chance that it's Raikou
; Compare its current location with yours
	ld hl, wRoamMon1MapGroup
	ld c, a
	ld b, 0
	ld a, wRoamMon1End - wRoamMon1 ; length of the RoamMon struct
	rst AddNTimes
	ld a, d
	cp [hl]
	jr nz, .DontEncounterRoamMon
	inc hl
	ld a, e
	cp [hl]
	jr nz, .DontEncounterRoamMon
; We've decided to take on a beast, so stage its information for battle.
	dec hl
	dec hl
	dec hl
	ld a, [hli]
	ld [wTempWildMonSpecies], a
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, BATTLETYPE_ROAMING
	ld [wBattleType], a

	pop hl
	scf
	ret

.DontEncounterRoamMon:
	pop hl
	and a
	ret

UpdateRoamMons:
	ld a, [wRoamMon1MapGroup]
	cp GROUP_N_A
	jr z, .SkipRaikou
	ld b, a
	ld a, [wRoamMon1MapNumber]
	ld c, a
	call .Update
	ld a, b
	ld [wRoamMon1MapGroup], a
	ld a, c
	ld [wRoamMon1MapNumber], a

.SkipRaikou:
	ld a, [wRoamMon2MapGroup]
	cp GROUP_N_A
	jr z, .SkipEntei
	ld b, a
	ld a, [wRoamMon2MapNumber]
	ld c, a
	call .Update
	ld a, b
	ld [wRoamMon2MapGroup], a
	ld a, c
	ld [wRoamMon2MapNumber], a

.SkipEntei:
	ld a, [wRoamMon3MapGroup]
	cp GROUP_N_A
	jr z, .SkipSuicune
	ld b, a
	ld a, [wRoamMon3MapNumber]
	ld c, a
	call .Update
	ld a, b
	ld [wRoamMon3MapGroup], a
	ld a, c
	ld [wRoamMon3MapNumber], a

.SkipSuicune: ; no-optimize stub jump
	jr _BackUpMapIndices

.Update:
	ld hl, RoamMaps
.loop
; Are we at the end of the table?
	ld a, [hl]
	cp -1
	ret z
; Is this the correct entry?
	ld a, b
	cp [hl]
	jr nz, .next
	inc hl
	ld a, c
	cp [hl]
	jr z, .yes
; We don't have the correct entry yet, so let's continue.  A 0 terminates each entry.
.next
	ld a, [hli]
	and a
	jr nz, .next
	jr .loop

; We have the correct entry now, so let's choose a random map from it.
.yes
	inc hl
	ld d, h
	ld e, l
.update_loop
	ld h, d
	ld l, e
; Choose which map to warp to.
	call Random
	and $1f ; 1/8n chance it moves to a completely random map, where n is the number of roaming connections from the current map.
	jr z, JumpRoamMon
	and 3
	cp [hl]
	jr nc, .update_loop ; invalid index, try again
	inc hl
	ld c, a
	ld b, $0
	add hl, bc
	add hl, bc
	ld a, [wRoamMons_LastMapGroup]
	cp [hl]
	jr nz, .done
	inc hl
	ld a, [wRoamMons_LastMapNumber]
	cp [hl]
	jr z, .update_loop
	dec hl

.done
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ret

JumpRoamMons:
	ld a, [wRoamMon1MapGroup]
	cp GROUP_N_A
	jr z, .SkipRaikou
	call JumpRoamMon
	ld a, b
	ld [wRoamMon1MapGroup], a
	ld a, c
	ld [wRoamMon1MapNumber], a
.SkipRaikou:

	ld a, [wRoamMon2MapGroup]
	cp GROUP_N_A
	jr z, .SkipEntei
	call JumpRoamMon
	ld a, b
	ld [wRoamMon2MapGroup], a
	ld a, c
	ld [wRoamMon2MapNumber], a
.SkipEntei:

	ld a, [wRoamMon3MapGroup]
	cp GROUP_N_A
	jr z, .SkipSuicune
	call JumpRoamMon
	ld a, b
	ld [wRoamMon3MapGroup], a
	ld a, c
	ld [wRoamMon3MapNumber], a
.SkipSuicune:
	; fallthrough

_BackUpMapIndices:
	ld a, [wRoamMons_CurMapNumber]
	ld [wRoamMons_LastMapNumber], a
	ld a, [wRoamMons_CurMapGroup]
	ld [wRoamMons_LastMapGroup], a
	ld a, [wMapNumber]
	ld [wRoamMons_CurMapNumber], a
	ld a, [wMapGroup]
	ld [wRoamMons_CurMapGroup], a
	ret

JumpRoamMon:
.loop
	ld hl, RoamMaps
	call Random ; Choose a random number
	and $f ; Take the lower nybble only.  This gives a number between 0 and 15.
	inc a
	ld b, a
.innerloop ; Loop to get hl to the address of the chosen roam map.
	dec b
	jr z, .ok
.innerloop2 ; Loop to skip the current roam map, which is terminated by a 0.
	ld a, [hli]
	and a
	jr nz, .innerloop2
	jr .innerloop
; Check to see if the selected map is the one the player is currently in.  If so, try again.
.ok
	ld a, [wMapGroup]
	cp [hl]
	jr nz, .done
	inc hl
	ld a, [wMapNumber]
	cp [hl]
	jr z, .loop
	dec hl
; Return the map group and number in bc.
.done
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ret

INCLUDE "data/wild/roammon_maps.asm"

RandomPhoneRareWildMon:
; Related to the phone?
	farcall GetCallerLocation
	ld d, b
	ld e, c
	ld hl, JohtoGrassWildMons
	ld bc, GRASS_WILDDATA_LENGTH
	call LookUpWildmonsForMapDE
	jr c, .GetGrassmon
	ld hl, KantoGrassWildMons
	call LookUpWildmonsForMapDE
	jr nc, .done

.GetGrassmon:
	push hl
	ld bc, 5 + 4 * 3 ; Location of the level of the 5th wild Pokemon in that map
	add hl, bc
	call GetTimeOfDayNotEve
	ld bc, NUM_GRASSMON * 3
	rst AddNTimes
	ld a, 3
	call RandomRange
	ld c, a
	ld b, $0
	add hl, bc
	add hl, bc
	add hl, bc
; We now have the pointer to one of the last (rarest) three wild Pokemon found in that area.
	inc hl
	ld a, [hli] ; Contains the species index of this rare Pokemon
	ld c, a
	ld a, [hl] ; Contains the form (including extspecies)
	ld b, a
	ld [wCurForm], a
	pop hl
	ld de, 5 + 0 * 3
	add hl, de
	inc hl ; Species index of the most common Pokemon on that route
	ld d, 4
.loop2
	ld a, [hli]
	cp c ; Compare this Pokemon with the rare one stored in c.
	ld a, [hli]
	jr nz, .next
	xor b ; Compare extspecies bit
	and EXTSPECIES_MASK
	jr z, .done
.next
	inc hl
	dec d
	jr nz, .loop2
; This Pokemon truly is rare.
	push bc
	dec c
	ld a, c
	call CheckSeenMon
	pop bc
	jr nz, .done
; Since we haven't seen it, have the caller tell us about it.
	ld de, wStringBuffer1
	call CopyName1
	ld a, c
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, .SawRareMonText
	call PrintText
	xor a
	ldh [hScriptVar], a
	ret

.done
	ld a, $1
	ldh [hScriptVar], a
	ret

.SawRareMonText:
	; I just saw some rare @  in @ . I'll call you if I see another rare #MON, OK?
	text_far _JustSawSomeRareMonText
	text_end

RandomPhoneWildMon:
	farcall GetCallerLocation
	ld d, b
	ld e, c
	ld hl, JohtoGrassWildMons
	ld bc, GRASS_WILDDATA_LENGTH
	call LookUpWildmonsForMapDE
	jr c, .ok
	ld hl, KantoGrassWildMons
	call LookUpWildmonsForMapDE

.ok
	ld bc, 5 + 0 * 3
	add hl, bc
	call GetTimeOfDayNotEve
	ld bc, NUM_GRASSMON * 3
	rst AddNTimes

	call Random
	and $3
	ld c, a
	add a
	add c
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	inc hl
	ld a, [hli]
	ld [wNamedObjectIndex], a
	ld a, [hl]
	ld [wCurForm], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wStringBuffer4
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ret

RandomPhoneMon:
; Get a random monster owned by the trainer who's calling.
	farcall GetCallerLocation
	ld hl, TrainerGroups
	ld a, d
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, BANK(TrainerGroups)
	call GetFarByte
	inc hl
	ld [wTrainerGroupBank], a
	ld a, BANK(TrainerGroups)
	call GetFarWord

.skip_trainer
	dec e
	jr z, .skipped
.skip
	ld a, [wTrainerGroupBank]
	call GetFarByte
	inc hl
	cp -1
	jr nz, .skip
	jr .skip_trainer
.skipped

.skip_name
	ld a, [wTrainerGroupBank]
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .skip_name

	ld a, [wTrainerGroupBank]
	call GetFarByte
	inc hl

	; get trainer type
	ld b, a
	; nicknames have uneven length, so always use the first mon
	bit TRNTYPE_NICKNAME, b
	jr nz, .got_mon
	; TRAINERTYPE_NORMAL uses 2 bytes per mon
	ld c, 2
	; TRAINERTYPE_ITEM uses 1 more byte
	bit TRNTYPE_ITEM, b
	jr z, .no_item
	inc c
.no_item
	; TRAINERTYPE_EVs uses 1 more byte
	bit TRNTYPE_EVS, b
	jr z, .no_evs
	inc c
.no_evs
	; TRAINERTYPE_DVS uses 3 more bytes
	bit TRNTYPE_DVS, b
	jr z, .no_dvs
	inc c
	inc c
	inc c
.no_dvs
	; TRAINERTYPE_PERSONALITY uses 2 more bytes
	bit TRNTYPE_PERSONALITY, b
	jr z, .no_personality
	inc c
	inc c
.no_personality
	; TRAINERTYPE_MOVES uses 4 more bytes
	bit TRNTYPE_MOVES, b
	jr z, .no_moves
	inc c
	inc c
	inc c
	inc c
.no_moves
	; bc == size of mon sub-struct
	xor a
	ld b, a

	ld e, 0
	push hl
.count_mon
	inc e
	add hl, bc
	ld a, [wTrainerGroupBank]
	call GetFarByte
	cp -1
	jr nz, .count_mon
	pop hl

.rand
	call Random
	and 7
	cp e
	jr nc, .rand

	inc a
.get_mon
	dec a
	jr z, .got_mon
	add hl, bc
	jr .get_mon
.got_mon

	inc hl ; species
	ld a, [wTrainerGroupBank]
	call GetFarByte
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wStringBuffer4
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ret

CheckOnWater:
	call GetPlayerStandingTile
	dec a ; cp WATER_TILE
	ret

GetTimeOfDayNotEve:
	ld a, [wTimeOfDay]
	cp EVE
	ret nz
	; Evening uses day encounters 60% of the time
	; and night encounters 40%.
	call Random
	cp 60 percent
	ld a, DAY
	ret c
	inc a ; NITE
	ret

JohtoGrassWildMons:
INCLUDE "data/wild/johto_grass.asm"

JohtoWaterWildMons:
INCLUDE "data/wild/johto_water.asm"

KantoGrassWildMons:
INCLUDE "data/wild/kanto_grass.asm"

KantoWaterWildMons:
INCLUDE "data/wild/kanto_water.asm"

OrangeGrassWildMons:
INCLUDE "data/wild/orange_grass.asm"

OrangeWaterWildMons:
INCLUDE "data/wild/orange_water.asm"

SwarmGrassWildMons:
INCLUDE "data/wild/swarm_grass.asm"

SwarmWaterWildMons:
INCLUDE "data/wild/swarm_water.asm"
