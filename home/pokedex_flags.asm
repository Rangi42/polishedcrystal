CountSetBits::
; Count the number of set bits in b bytes starting from hl.
; Return in a, c and [wNumSetBits].

	push de
	ld c, 0
.loop
	ld a, [hli]
	and a
	call nz, PopCountA
	add c
	ld c, a
	dec b
	jr nz, .loop
	ld [wNumSetBits], a
	pop de
	ret

PopCountA::
; Returns number of bits set in a
; clobbers de
; https://wikiti.brandonw.net/index.php?title=Z80_Routines:Optimized:PopCountA
; adapted for the gameboy
	ld e, a
	and %10101010
	cpl
	rrca
	adc e
	ld d, a
	and %00110011
	ld e, a
	xor d
	rrca
	rrca
	add e
	ld e, a
	swap a
	add e
	and %00001111
	ret

Pokedex_SetWildLandmark_MaintainNoCarry:
; Calls SetWildLandmark. If carry is currently set, calls it directly.
; Otherwise, reset carry no matter what it returns for the carry flag.
	jr nc, .no_carry
	farjp Pokedex_SetWildLandmark
.no_carry
	push af
	farcall Pokedex_SetWildLandmark
	pop af
	ret

GetWeekday::
	ld a, [wCurDay]
.mod
	sub 7
	jr nc, .mod
	add 7
	ret

CheckCosmeticCaughtMon:
; Same as CheckCaughtMon (check if mon is caught) if mon isn't cosmetic.
; Counts species c form b as caught if the player has caught any other
; mon of the same species if the mon is cosmetic.
	push bc
	farcall _Pokedex_MonHasCosmeticForms
	pop bc
	jr c, CheckCaughtMon

	; Begin by checking the base form.
	ld a, b
	and EXTSPECIES_MASK
	inc a
	push bc
	call CheckCaughtMon
	pop bc
	ret nz

	; Now check all entries in the cosmetic table.
	ld hl, CosmeticSpeciesAndFormTable
.loop
	ld a, [hli]
	cp c
	ld a, [hl]
	jr nz, .next
	xor b
	and EXTSPECIES_MASK
	jr nz, .next
	ld b, [hl]
	push hl
	push bc
	call CheckCaughtMon
	pop bc
	pop hl
	ret nz
.next
	inc hl
	ld a, h
	cp HIGH(VariantSpeciesAndFormTable)
	jr nz, .loop
	ld a, l
	cp LOW(VariantSpeciesAndFormTable)
	jr nz, .loop
	ret

; Pokedex Flag Actions:
; Input: bc = form, species
SetSeenAndCaughtMon::
	push bc
	ld hl, wPokedexCaught
	call SetDexMon
	pop bc
	; fallthrough

SetSeenMon::
	ld hl, wPokedexSeen
SetDexMon::
	ld a, SET_FLAG
	jr PokedexFlagAction

CheckCaughtMon::
	ld hl, wPokedexCaught
	jr CheckDexMon

CheckSeenMon::
	ld hl, wPokedexSeen
CheckDexMon::
	ld a, CHECK_FLAG
	; fallthrough

PokedexFlagAction::
	; Unless we're just checking dex flags, invalidate the dex cache.
	cp CHECK_FLAG
	jr z, .cache_done

	push af
	xor a
	ld [wDexCacheValid], a
	pop af

.cache_done
	push af
	push hl
	call GetCosmeticSpeciesAndFormIndex
	ld d, b
	ld e, c
	pop hl
	pop af
	ld b, a
	call FlagAction
	ld a, c
	and a
	ret
