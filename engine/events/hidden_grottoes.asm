	const_def
	const GROTTODATA_WARP
	const GROTTODATA_ITEM
	const GROTTODATA_MON1
	const GROTTODATA_MON2
	const GROTTODATA_MON3
	const GROTTODATA_MON4
	const GROTTODATA_MONLEVEL

InitializeHiddenGrotto::
; store backup warp number
	ld hl, HiddenGrottoData + GROTTODATA_WARP
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

; first grotto always has a Pokémon
	eventflagcheck EVENT_SAW_FIRST_HIDDEN_GROTTO
	jr z, .RandomPokemon

; choose random grotto contents
; 20% Pokémon, 40% item, 40% hidden item
	ld a, 5
	call RandomRange
	and a
	jr z, .RandomPokemon
	srl a
	jr c, .RandomItem
.RandomHiddenItem:
	ld hl, HiddenGrottoHiddenItems
	call GetHiddenGrottoTableEntry
	ld d, GROTTO_HIDDEN_ITEM
	ld e, a
	jr .StoreContent

.RandomPokemon:
	eventflagset EVENT_SAW_FIRST_HIDDEN_GROTTO
	ld hl, HiddenGrottoPokemonIndexes
	call GetHiddenGrottoTableEntry
	ld hl, HiddenGrottoData + GROTTODATA_MON1
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
	ld hl, HiddenGrottoItems
	call GetHiddenGrottoTableEntry
	cp ITEM_FROM_MEM
	jr nz, .got_item
	ld hl, HiddenGrottoData + GROTTODATA_ITEM
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
; return content type
	ld [ScriptVar], a
	ret

INCLUDE "data/events/hidden_grottoes/probabilities.asm"

GetHiddenGrottoTableEntry:
	ld a, [hli]
	call RandomRange
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
	ld hl, HiddenGrottoData + GROTTODATA_MONLEVEL
	call GetHiddenGrottoDataMember
	ld a, [hl]
	ret

INCLUDE "data/events/hidden_grottoes/grottoes.asm"
