TeachDratiniExtremeSpeed:
	call GetLastPartyMonMoveset
	ld hl, .Moveset
	jp GiveSpecialMoveset

.Moveset:
	db EXTREMESPEED
	db THUNDER_WAVE
	db AQUA_JET
	db DRAGON_RAGE
	db 0

TeachShuckiePoisonJab:
	call GetLastPartyMonMoveset
	ld hl, .Moveset
	jp GiveSpecialMoveset

.Moveset:
	db POISON_JAB
	db SAFEGUARD
	db REST
	db ROCK_THROW
	db 0

TeachMagikarpDragonRage:
	call GetLastPartyMonMoveset
	ld hl, .Moveset
	jp GiveSpecialMoveset

.Moveset:
	db SPLASH
	db DRAGON_RAGE
	db 0

GetLastPartyMonStruct:
	ld bc, wPartyCount
	ld a, [bc]
	ld hl, MON_SPECIES

	ld de, wPartyMon1
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
	ret

.EmptyParty:
	scf
	ret

GetLastPartyMonMoveset:
	call GetLastPartyMonStruct
	ld de, MON_MOVES
	add hl, de
	push hl
	pop de
	ret

GiveSpecialMoveset:
.GiveMoves:
	ld a, [hl]
	and a ; is the move 00?
	ret z ; if so, we're done here

	push hl
	push de
	ld [de], a ; give the Pokémon the new move

	; get the PP of the new move
	ld hl, Moves + MOVE_PP
	call GetMoveProperty

	; get the address of the move's PP and update the PP
	ld hl, MON_PP - MON_MOVES
	add hl, de
	ld [hl], a

	pop de
	pop hl
	inc de
	inc hl
	jr .GiveMoves

SetLastPartyMonBall:
	call GetLastPartyMonStruct
	ld de, MON_CAUGHTBALL
	add hl, de
	ldh a, [hScriptVar]
	ld c, a
	ld a, [hl]
	and $ff - CAUGHTBALL_MASK
	or c
	ld [hl], a
	ret
