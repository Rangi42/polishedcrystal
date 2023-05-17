rsreset
DEF GROTTODATA_WARP        rb
DEF GROTTODATA_ITEM        rb
DEF GROTTODATA_MONLEVEL    rb
DEF GROTTODATA_MON1SPECIES rb
DEF GROTTODATA_MON1FORM    rb
DEF GROTTODATA_MON2SPECIES rb
DEF GROTTODATA_MON2FORM    rb
DEF GROTTODATA_MON3SPECIES rb
DEF GROTTODATA_MON3FORM    rb
DEF GROTTODATA_MON4SPECIES rb
DEF GROTTODATA_MON4FORM    rb
DEF GROTTODATA_LENGTH EQU _RS

InitializeHiddenGrotto::
; store backup warp number
	ld hl, HiddenGrottoData + GROTTODATA_WARP
	call GetHiddenGrottoDataMember
	ld a, [hl]
	ld [wBackupWarpNumber], a

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
	ld c, a
	jr .StoreContent

.RandomPokemon:
	eventflagset EVENT_SAW_FIRST_HIDDEN_GROTTO
	ld hl, HiddenGrottoPokemonIndexes
	call GetHiddenGrottoTableEntry
	ld hl, HiddenGrottoData + GROTTODATA_MON1SPECIES
.mon_loop
	and a
	jr z, .got_mon
	inc hl
	inc hl
	dec a
	jr .mon_loop
.got_mon
	call GetHiddenGrottoDataMember
	ld a, [hli]
	ld d, GROTTO_POKEMON
	ld c, a
	ld b, [hl]
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
	ld c, a
.StoreContent:
	push bc
	call GetHiddenGrottoContentPointer
	pop bc
	ld a, d ; content type
	ld [hli], a
	ld a, c ; content id
	ld [hli], a
	ld [hl], b ; content id + 1
	ld a, d
.Done:
; return content type
	ldh [hScriptVar], a
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
	inc a
	ret z
	ld a, [hl]
	ret

TryResetHiddenGrottoes:
	ld hl, wDailyFlags4
	bit 5, [hl] ; ENGINE_ALL_HIDDEN_GROTTOES
	ret nz
	xor a
	ld hl, wHiddenGrottoContents
	ld bc, NUM_HIDDEN_GROTTOES * 3
	rst ByteFill
	ld hl, wDailyFlags4
	set 5, [hl] ; ENGINE_ALL_HIDDEN_GROTTOES
	ret

EmptiedHiddenGrotto:
	call GetHiddenGrottoContentPointer
	ld [hl], GROTTO_EMPTY
	ret

GetHiddenGrottoDataMember:
	ld bc, GROTTODATA_LENGTH
	jr AddCurHiddenGrottoTimes

GetHiddenGrottoContentPointer:
	ld hl, wHiddenGrottoContents
	ld bc, 3
AddCurHiddenGrottoTimes:
	ld a, [wCurHiddenGrotto]
	dec a ; since hidden grotto IDs start at 1
	rst AddNTimes
	ret

GetHiddenGrottoContents::
	call GetHiddenGrottoContentPointer
	inc hl
	ld a, [hli]
	ld c, a
	ldh [hScriptVar], a
	ld b, [hl]
	ret

GetCurHiddenGrottoLevel::
	ld hl, HiddenGrottoData + GROTTODATA_MONLEVEL
	call GetHiddenGrottoDataMember
	ld a, [hl]
	ret

INCLUDE "data/events/hidden_grottoes/grottoes.asm"
