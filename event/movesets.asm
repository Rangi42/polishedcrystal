TeachDratiniExtremeSpeed: ; 0x8b170
	call GetLastPartyMonMoveset
	ld hl, .Moveset
	call GiveSpecialMoveset
	ret

.Moveset:
	db EXTREMESPEED
	db THUNDER_WAVE
	db TWISTER
	db DRAGON_RAGE
	db 0

TeachMagikarpDragonRage:
	call GetLastPartyMonMoveset
	ld hl, .Moveset
	call GiveSpecialMoveset
	ret

.Moveset:
	db SPLASH
	db DRAGON_RAGE
	db 0

GetLastPartyMonMoveset: ; 0x8b1ce
	ld bc, PartyCount
	ld a, [bc]
	ld hl, MON_SPECIES

	ld de, PartyMon1
	add hl, de
	and a
	jr z, .EmptyParty
	dec a
	ret z
	ld de, PARTYMON_STRUCT_LENGTH
.loop
	add hl, de
	dec a
	jr nz, .loop

	ld a, [bc]
	ld c, a
	ld de, PARTYMON_STRUCT_LENGTH

	; get address of mon's first move
	push hl
	pop de
rept 2
	inc de
endr
	ret

.EmptyParty:
	scf
	ret
; 8b1e1

GiveSpecialMoveset:
.GiveMoves:
	ld a, [hl]
	and a ; is the move 00?
	ret z ; if so, we're done here

	push hl
	push de
	ld [de], a ; give the Pokémon the new move

	; get the PP of the new move
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte

	; get the address of the move's PP and update the PP
	ld hl, MON_PP - MON_MOVES
	add hl, de
	ld [hl], a

	pop de
	pop hl
	inc de
	inc hl
	jr .GiveMoves
