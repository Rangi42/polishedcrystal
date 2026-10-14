; DexNav: search the current area for a chosen wild species.
; Behavior is modeled on CFRU's src/dexnav.c. See PC-DexNav-Decisions.md.

DexNav_ChooseWildEncounter:
; Set up a wild battle against [wDexNavTargetSpecies]/[wDexNavTargetForm]
; using this area's land or water table for the current time of day.
; Returns z and sets wTempWildMonSpecies, wWildMonForm, wCurPartyLevel
; and wBattleType on success; nz if the target isn't found here.
	farcall SetBadgeBaseLevel
	ld a, [wTimeOfDay]
	cp EVE
	jr nz, .try
	; Evening normally uses day or night encounters at random,
	; so a target from either table can be found.
	ld a, DAY
	call .try
	ret z
	ld a, NITE
.try
	call DexNav_GetSlotTable
	jr nc, .fail

	; Make sure the target is in this table, or the roll below never ends.
	push hl
.find_loop
	call DexNav_CheckSlotIsTarget
	jr z, .found
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .find_loop
	pop hl
.fail
	or 1
	ret

.found
	pop hl
.roll
	; Roll slots with the normal encounter odds until one is the target,
	; so the level comes from the same distribution as a normal encounter.
	push hl
	push de
	ld a, 100
	call RandomRange
	inc a
	ld c, a
	ld b, -1
	ld h, d
	ld l, e
.prob_bracket_loop
	inc b
	ld a, BANK(GrassMonProbTable)
	call GetFarByte
	inc hl
	cp c
	jr c, .prob_bracket_loop
	pop de
	pop hl
	push hl
	ld a, b
	add b
	add b
	ld c, a
	ld b, 0
	add hl, bc
	call DexNav_CheckSlotIsTarget
	jr z, .got_slot
	pop hl
	jr .roll

.got_slot
	pop bc ; discard table pointer

	; Same Unown check as _ChooseWildEncounter
	ld a, [wDexNavTargetSpecies]
	cp UNOWN
	jr nz, .unown_check_done
	ld a, [wDexNavTargetForm]
	bit MON_EXTSPECIES_F, a
	jr nz, .unown_check_done
	ld a, [wUnlockedUnowns]
	and a
	jr z, .fail
.unown_check_done

	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld b, a

	; Same surfing level boost as _ChooseWildEncounter
	push bc
	farcall CheckOnWater
	pop bc
	jr nz, .level_ok
	call Random
	cp 35 percent
	jr c, .level_ok
	inc b
	cp 65 percent
	jr c, .level_ok
	inc b
	cp 85 percent
	jr c, .level_ok
	inc b
	cp 95 percent
	jr c, .level_ok
	inc b
.level_ok
	ld a, b
	farcall AdjustLevelForBadges
	ld [wCurPartyLevel], a

	ld a, [wDexNavTargetSpecies]
	ld [wTempWildMonSpecies], a
	ld a, [wDexNavTargetForm]
	ld [wWildMonForm], a
	ld a, BATTLETYPE_DEXNAV
	ld [wBattleType], a
	xor a
	ret

DexNav_GetSlotTable:
; Find this area's wild slots for time of day a (ignored on water).
; Returns carry and hl = first slot (in BANK(JohtoGrassWildMons)),
; de = cumulative odds (in BANK(GrassMonProbTable)), b = slot count.
; Returns nc if this area has no wild data.
	push af
	farcall LoadWildMonDataPointer
	jr nc, .none
	inc hl ; skip map group
	inc hl ; skip map number
	inc hl ; skip encounter chance
	farcall CheckOnWater
	jr nz, .grass
	pop af
	ld de, WaterMonProbTable
	ld b, NUM_WATERMON
	scf
	ret

.grass
	pop af
	ld bc, NUM_GRASSMON * 3
	rst AddNTimes
	ld de, GrassMonProbTable
	ld b, NUM_GRASSMON
	scf
	ret

.none
	pop af
	and a
	ret

DexNav_CheckSlotIsTarget:
; Returns z if the wild slot at hl is the DexNav target. Clobbers a and c.
	push hl
	inc hl ; skip level
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld c, a
	ld a, [wDexNavTargetSpecies]
	cp c
	jr nz, .done
	inc hl
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld c, a
	ld a, [wDexNavTargetForm]
	cp c
.done
	pop hl
	ret

DexNav_UseItem:
; Key item effect (Bag or Select). The Bag closes first, then this script runs.
	ld a, BANK(DexNavUseScript)
	ld hl, DexNavUseScript
	call FarQueueScript
	ld a, TRUE
	ld [wItemEffectSucceeded], a
	ret

DexNavUseScript:
	special UpdateTimePals
	callasm DexNav_ChooseTarget
	iffalsefwd .done
	randomwildmon
	startbattle
	reloadmapafterbattle
.done
	end

DexNav_ChooseTarget:
; Temporary target picker until the species list menu (Phase 2.2).
; Yes = search for the target, No = show the next wild slot as the target.
; Sets [hScriptVar] to TRUE if a DexNav battle is ready to start.
	xor a ; FALSE
	ldh [hScriptVar], a
	call OpenText
	ld a, [wDexNavTargetSpecies]
	and a
	jr nz, .prompt
	xor a
	ld [wDexNavListCursor], a
	call .SetTargetFromSlot
	jr nc, .no_wild_data

.prompt
	ld a, [wDexNavTargetSpecies]
	ld [wNamedObjectIndex], a
	ld a, [wDexNavTargetForm]
	ld [wNamedObjectIndex + 1], a
	call GetPokemonName
	ld hl, .TargetText
	call PrintText
	call YesNoBox
	jr c, .next_slot

	call DexNav_ChooseWildEncounter
	jr nz, .not_here
	ld a, TRUE
	ldh [hScriptVar], a
	jmp CloseText

.next_slot
	ld hl, wDexNavListCursor
	inc [hl]
	call .SetTargetFromSlot
	jr c, .prompt
.no_wild_data
	ld hl, .NoWildDataText
	jr .print_and_close

.not_here
	ld hl, .NotHereText
.print_and_close
	call PrintText
	call WaitButton
	jmp CloseText

.SetTargetFromSlot:
; Target the species in slot [wDexNavListCursor] (wrapping around).
; Returns nc if this area has no wild data.
	ld a, [wTimeOfDay]
	cp EVE
	jr nz, .got_time
	ld a, DAY
.got_time
	call DexNav_GetSlotTable
	ret nc
	ld a, [wDexNavListCursor]
	cp b
	jr c, .slot_ok
	xor a
	ld [wDexNavListCursor], a
.slot_ok
	ld bc, 3
	rst AddNTimes
	inc hl ; skip level
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld [wDexNavTargetSpecies], a
	inc hl
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld [wDexNavTargetForm], a
	scf
	ret

.TargetText:
	text "DexNav target:"
	line "@"
	text_ram wStringBuffer1
	text "! Search?"
	done

.NotHereText:
	text_ram wStringBuffer1
	text " isn't"
	line "around here."
	prompt

.NoWildDataText:
	text "No wild #mon"
	line "live here."
	prompt
