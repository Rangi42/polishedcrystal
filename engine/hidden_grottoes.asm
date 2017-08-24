; BUG: first time you enter any grotto it appears empty.

InitializeHiddenGrotto::
; return 0 for nothing, 1 for pokemon, 2 for item, 3 for hidden item, 4 for empty

; store backup warp number
	ld hl, HiddenGrottoData
	call GetHiddenGrottoDataMember
	ld a, [hl]
	ld [BackupWarpNumber], a

; reset all hidden grottoes daily
	call TryResetHiddenGrottoes

; check if grotto is already populated or already empty
	call GetHiddenGrottoContentPointer
	ld a, [hl]
	and a
	jr nz, .Done

; choose random grotto contents
	call Random
	cp 56
	jr c, .RandomPokemon
	sub 56
	cp 100
	jr c, .RandomItem
	sub 100
.RandomHiddenItem:
; a is in [0, 100)
	ld hl, .HiddenItems
	call GetHiddenGrottoTableEntry
	ld d, GROTTO_HIDDEN_ITEM
	ld e, a
	jr .StoreContent

.RandomPokemon:
; a is in [0, 56)
	ld hl, .PokemonIndexes
	call GetHiddenGrottoTableEntry
	ld hl, HiddenGrottoData + 2 ; mon of pokemon list
.mon_loop
	and a
	jr z, .got_mon
	inc hl
	dec a
	jr .mon_loop
.got_mon
	call GetHiddenGrottoDataMember
	ld a, [hl]
	ld d, GROTTO_POKEMON
	ld e, a
	jr .StoreContent

.RandomItem:
; a is in [0, 100)
	ld hl, .Items
	call GetHiddenGrottoTableEntry
	cp ITEM_FROM_MEM
	jr nz, .got_item
	ld hl, HiddenGrottoData + 1 ; rare item
	call GetHiddenGrottoDataMember
	ld a, [hl]
.got_item
	ld d, GROTTO_ITEM
	ld e, a
.StoreContent:
	call GetHiddenGrottoContentPointer
	ld a, d ; content type
	ld [hli], a
	ld a, e ; content id
	ld [hl], a
	ld a, d
.Done:
	ld [ScriptVar], a
	ret

.PokemonIndexes:
; probabilities sum to 56
	db 42, $0
	db 11, $1
	db 3, $2
	db -1

.Items:
; probabilities sum to 100
	db 31, POKE_BALL
	db 12, GREAT_BALL
	db 5, ULTRA_BALL
	db 16, POTION
	db 6, SUPER_POTION
	db 3, HYPER_POTION
	db 16, REPEL
	db 6, SUPER_REPEL
	db 3, MAX_REPEL
	db 2, ITEM_FROM_MEM
	db -1

.HiddenItems:
; probabilities sum to 100
	db 60, MULCH
	db 20, TINYMUSHROOM
	db 6, BIG_MUSHROOM
	db 5, SILVER_LEAF
	db 5, GOLD_LEAF
	db 1, RARE_CANDY
	db 2, PP_UP
	db 1, PP_MAX
	db -1

GetHiddenGrottoTableEntry:
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	jr .loop
.ok
	ld a, [hli]
	cp -1
	ld a, $0 ; not xor a; preserve carry flag
	ret z
	ld a, [hl]
	ret

TryResetHiddenGrottoes:
	ld hl, DailyFlags4
	bit 5, [hl] ; ENGINE_ALL_HIDDEN_GROTTOES
	ret nz
	xor a
	ld hl, HiddenGrottoContents
	ld bc, NUM_HIDDEN_GROTTOES * 2
	call ByteFill
	ld hl, DailyFlags4
	set 5, [hl] ; ENGINE_ALL_HIDDEN_GROTTOES
	ret

EmptiedHiddenGrotto:
	call GetHiddenGrottoContentPointer
	ld [hl], GROTTO_EMPTY
	ret

GetHiddenGrottoDataMember:
	ld bc, HiddenGrotto2 - HiddenGrotto1
	jr AddCurHiddenGrottoTimes

GetHiddenGrottoContentPointer:
	ld hl, HiddenGrottoContents
	ld bc, 2
AddCurHiddenGrottoTimes:
	ld a, [CurHiddenGrotto]
	dec a ; since hidden grotto IDs start at 1
	jp AddNTimes

GetHiddenGrottoContents::
	call GetHiddenGrottoContentPointer
	inc hl
	ld a, [hl]
	ld [ScriptVar], a
	ret

GetCurHiddenGrottoLevel::
	ld hl, HiddenGrottoData + 5 ; level
	call GetHiddenGrottoDataMember
	ld a, [hl]
	ret

HiddenGrottoData:
	; warp number, rare item, common mon, uncommon mon, rare mon, level
HiddenGrotto1:
	db 4, SUN_STONE, SNUBBULL, YANMA, YANMA, 15 ; HIDDENGROTTO_ROUTE_35
HiddenGrotto2:
	db 2, WATER_STONE, FLAAFFY, GIRAFARIG, FARFETCH_D, 25 ; HIDDENGROTTO_LAKE_OF_RAGE_SOUTH
