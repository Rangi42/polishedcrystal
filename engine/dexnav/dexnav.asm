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
	opentext
	callasm DexNav_ChooseTarget
	iffalsefwd .done
	closetext
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

.done
	endtext

DexNav_ChooseTarget:
; Let the player pick a species from this area's list, then set up the battle.
; Sets [hScriptVar] to TRUE if a DexNav battle is ready to start.
	xor a ; FALSE
	ldh [hScriptVar], a
	call DexNav_BuildList
	ld hl, .NoWildDataText
	jmp nc, .print

	; Start the cursor on the last target if it's in the list.
	ld hl, wDexNavList
	ld a, [hli]
	ld c, a
	ld b, 1
.find_target_loop
	ld a, [wDexNavTargetSpecies]
	cp [hl]
	inc hl
	ld a, [wDexNavTargetForm]
	jr nz, .next_target
	cp [hl]
	jr z, .got_cursor
.next_target
	inc hl
	inc b
	dec c
	jr nz, .find_target_loop
	ld b, 1
.got_cursor
	ld a, b
	cp DEXNAV_MENU_ROWS + 1
	jr c, .cursor_ok
	ld a, 1
.cursor_ok
	ld [wDexNavListCursor], a

	ldh a, [hBGMapMode]
	push af
	ld a, [wMenuScrollPosition]
	push af
	call LoadStandardMenuHeader
	ld hl, .WhichMonText
	call PrintText
.menu_loop
	ld hl, .MenuHeader
	call CopyMenuHeader
	ld a, [wDexNavListCursor]
	ld [wMenuCursorBuffer], a
	xor a
	ld [wMenuScrollPosition], a
	call InitScrollingMenu
	call DexNav_HideSpritesUnderMenu
	call ScrollingMenu
	ld a, [wMenuCursorY]
	ld [wDexNavListCursor], a
	ld a, [wMenuJoypad]
	cp PAD_B
	jr z, .cancel
	ld a, [wMenuSelection]
	cp CANCEL
	jr z, .cancel

	; Only seen species can be searched for (D14).
	ld c, a
	ld a, [wMenuSelectionQuantity]
	ld b, a
	push bc
	call CheckSeenMon
	pop bc
	jr nz, .seen
	ld de, SFX_WRONG
	call PlaySFX
	call WaitSFX
	jr .menu_loop

.seen
	ld a, c
	ld [wDexNavTargetSpecies], a
	ld a, b
	ld [wDexNavTargetForm], a
	call ExitMenu
	pop af
	ld [wMenuScrollPosition], a
	pop af
	ldh [hBGMapMode], a

	call DexNav_ChooseWildEncounter
	ld a, TRUE
	jr z, .done
	ld a, [wDexNavTargetSpecies]
	ld [wNamedObjectIndex], a
	ld a, [wDexNavTargetForm]
	ld [wNamedObjectIndex + 1], a
	call GetPokemonName
	ld hl, .NotHereText
.print
	call PrintText
	xor a ; FALSE
.done
	ldh [hScriptVar], a
	ret

.cancel
	call ExitMenu
	pop af
	ld [wMenuScrollPosition], a
	pop af
	ldh [hBGMapMode], a
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	; The border is drawn one tile outside these coords (see InitScrollingMenu).
	menu_coords DEXNAV_MENU_LEFT, 1, SCREEN_WIDTH - 2, 1 + DEXNAV_MENU_ROWS * 2
	dw .MenuData
	db 1 ; default option

.MenuData:
	db SCROLLINGMENU_DISPLAY_ARROWS ; flags
	db DEXNAV_MENU_ROWS, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; species + form
	dba wDexNavList
	dba .PlaceSpeciesName
	dba DoNothing
	dba DoNothing

.PlaceSpeciesName:
; Unseen species show as "?????".
	push de
	ld a, [wMenuSelection]
	ld c, a
	ld a, [wMenuSelectionQuantity]
	ld b, a
	push bc
	call CheckSeenMon
	pop bc
	ld de, .UnseenString
	jr z, .got_name
	ld a, c
	ld [wNamedObjectIndex], a
	ld a, b
	ld [wNamedObjectIndex + 1], a
	call GetPokemonName
.got_name
	pop hl
	rst PlaceString
	ret

.UnseenString:
	db "?????@"

.WhichMonText:
	text "Search for which"
	line "#mon?"
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

DexNav_HideSpritesUnderMenu:
; Hide sprites (including the player) that would draw over the list,
; like ClearSpritesUnderStartMenu.
	ld hl, wShadowOAMSprite00XCoord
	ld de, OBJ_SIZE
	ld c, OAM_COUNT
.loop
	ld a, [hl]
	cp (DEXNAV_MENU_LEFT - 1) * TILE_WIDTH ; left border
	jr c, .next
	dec l
	ld [hl], OAM_YCOORD_HIDDEN
	inc l
.next
	add hl, de
	dec c
	jr nz, .loop
	ldh a, [hOAMUpdate]
	push af
	ld a, TRUE
	ldh [hOAMUpdate], a
	call DelayFrame
	pop af
	ldh [hOAMUpdate], a
	ret

DexNav_BuildList:
; Fill wDexNavList with each distinct species/form in this area's table for
; the current time of day (both day and night in the evening).
; Format: count, (species, form) * count, -1. Returns nc if no wild data.
	xor a
	ld [wDexNavList], a
	ld a, [wTimeOfDay]
	cp EVE
	jr nz, .add_table
	ld a, DAY
	call .add_table
	ret nc
	ld a, NITE
.add_table
	call DexNav_GetSlotTable
	ret nc
.slot_loop
	push hl
	inc hl ; skip level
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld e, a
	inc hl
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld d, a
	push bc
	call .AddToList
	pop bc
	pop hl
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .slot_loop
	scf
	ret

.AddToList:
; Append species e / form d unless it's already listed.
	ld hl, wDexNavList
	ld a, [hli]
	and a
	jr z, .append
	ld c, a
.dupe_loop
	ld a, [hli]
	cp e
	ld a, [hli]
	jr nz, .next
	cp d
	ret z
.next
	dec c
	jr nz, .dupe_loop
.append
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld [hl], CANCEL
	ld hl, wDexNavList
	inc [hl]
	ret
