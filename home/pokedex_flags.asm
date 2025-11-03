CountSetBits::
; Count the number of set bits in b bytes starting from hl.
; Return in a, c and [wNumSetBits].

	ld c, 0
.outer_loop
	ld a, [hli]
.zerocheck
	and a
	jr nz, .inner_loop
	dec b
	jr nz, .outer_loop
	ld a, c
	ld [wNumSetBits], a
	ret
.inner_loop
	add a
	jr nc, .inner_loop
	inc c
	jr .zerocheck

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
	ld b, a
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
	ret ; should return z if no variants have been caught

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
