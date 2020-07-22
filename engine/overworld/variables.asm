_GetVarAction::
	ld a, c
	cp NUM_VARS
	jr c, .valid
	xor a
.valid
	ld c, a
	ld b, 0
	ld hl, VarActionTable
	add hl, bc
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld b, [hl]
	ld a, b
	and RETVAR_EXECUTE
	jp nz, _de_
	ld a, b
	and RETVAR_ADDR_DE
	ret nz
	ld a, [de]
	; fallthrough
LoadStringBuffer2:
	ld de, wStringBuffer2
	ld [de], a
	ret

INCLUDE "data/overworld/variables.asm"

Var_CountCaughtMons:
; Caught mons.
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld a, [wd265]
	jp LoadStringBuffer2

Var_CountSeenMons:
; Seen mons.
	ld hl, wPokedexSeen
	ld b, wEndPokedexSeen - wPokedexSeen
	call CountSetBits
	ld a, [wd265]
	jp LoadStringBuffer2

Var_CountBadges:
; Number of owned badges.
	ld hl, wBadges
	ld b, wBadgesEnd - wBadges
	call CountSetBits
	ld a, [wd265]
	jp LoadStringBuffer2

Var_PlayerFacing:
; The direction the player is facing.
	ld a, [wPlayerDirection]
	and $c
	rrca
	rrca
	jp LoadStringBuffer2

Var_DayOfWeek:
; The day of the week.
	call GetWeekday
	jp LoadStringBuffer2

Var_UnownCaught:
; Number of unique Unown caught.
	call .count
	ld a, b
	jp LoadStringBuffer2

.count:
	ld hl, wUnownDex
	ld b, 0
.loop
	ld a, [hli]
	and a
	ret z
	inc b
	ld a, b
	cp NUM_UNOWN
	jr c, .loop
	ret

Var_BoxFreeSpace:
; Remaining slots in the current box.
	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld hl, sBoxCount
	ld a, MONS_PER_BOX
	sub [hl]
	ld b, a
	call CloseSRAM
	ld a, b
	jp LoadStringBuffer2

Var_BattleResult:
	ld a, [wBattleResult]
	and $3f
	jp LoadStringBuffer2

Var_CountPokemonJournals:
	ld hl, wPokemonJournals
	ld b, wPokemonJournalsEnd - wPokemonJournals
	call CountSetBits
	ld a, [wd265]
	jp LoadStringBuffer2

Var_CountTrainerStars:
	ld b, 0
	; star for beating the Elite Four
	eventflagcheck EVENT_BEAT_ELITE_FOUR
	jr z, .nostar1
	inc b
.nostar1
	; star for beating Leaf
	eventflagcheck EVENT_BEAT_LEAF
	jr z, .nostar2
	inc b
.nostar2
	; star for completing the Pokédex
	push bc
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	pop bc
	cp NUM_POKEMON
	jr c, .nostar3
	inc b
.nostar3
	; star for reading all Pokémon Journals
	push bc
	ld hl, wPokemonJournals
	ld b, wPokemonJournalsEnd - wPokemonJournals
	call CountSetBits
	pop bc
	cp NUM_POKEMON_JOURNALS
	jr c, .nostar4
	inc b
.nostar4
	ld a, b
	jp LoadStringBuffer2
