DEF in_stringbuffer2 EQUS "- $4000"

VarActionTable:
; words 0000-7fff (ROM labels) are executed as code
; words c000-ffff (WRAM/HRAM labels) are returned directly
; words 8000-bfff (shifted RAM labels) are shifted to c000-ffff and read into wStringBuffer2
; this means that vars cannot execute RAM code, nor return pointers to or values from ROM or VRAM/SRAM
	table_width 2
	dw wStringBuffer2 in_stringbuffer2
	dw wPartyCount in_stringbuffer2
	dw Var_BattleResult ; execute
	dw wBattleType ; in de
	dw wTimeOfDay in_stringbuffer2
	dw Var_CountBadges ; execute
	dw wPlayerState ; in de
	dw Var_PlayerFacing ; execute
	dw hHours in_stringbuffer2
	dw Var_DayOfWeek ; execute
	dw wMapGroup in_stringbuffer2
	dw wMapNumber in_stringbuffer2
	dw Var_UnownCaught ; execute
	dw wEnvironment in_stringbuffer2
	dw Var_BoxFreeSpace ; execute
	dw wBugContestMinsRemaining in_stringbuffer2
	dw wXCoord in_stringbuffer2
	dw wYCoord in_stringbuffer2
	dw wSpecialPhoneCallID in_stringbuffer2
	dw wKurtApricornQuantity in_stringbuffer2
	dw wCurCaller ; in de
	dw wBlueCardBalance ; in de
	dw wBuenasPassword ; in de
	dw wKenjiBreakTimer in_stringbuffer2
	dw Var_CountPokemonJournals ; execute
	dw Var_CountTrainerStars ; execute
	dw Var_Landmark ; execute
	dw wPlayerGender ; in de
	assert_table_length NUM_VARS

_GetVarAction::
	ld b, 0
	ld hl, VarActionTable
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, [hl]
	bit 7, d
	jmp z, _de_
	bit 6, d
	ret nz
	ld hl, $4000
	add hl, de
	ld a, [hl]
_Var_loadstringbuffer2:
	ld de, wStringBuffer2
	ld [de], a
	ret

Var_CountBadges:
	ld hl, wBadges
	ld b, wBadgesEnd - wBadges
	call CountSetBits
	ld a, [wNumSetBits]
	jr _Var_loadstringbuffer2

Var_PlayerFacing:
	ld a, [wPlayerDirection]
	and $c
	rrca
	rrca
	jr _Var_loadstringbuffer2

Var_DayOfWeek:
	call GetWeekday
	jr _Var_loadstringbuffer2

Var_UnownCaught:
	push hl
	push de
	push bc

	assert !HIGH(UNOWN)
	lb bc, NUM_UNOWN, UNOWN
	ld d, 0
.loop
	push de
	push bc
	call CheckCaughtMon
	pop bc
	pop de
	jr z, .not_captured
	inc d
.not_captured
	dec b
	jr nz, .loop
	ld a, d
	pop bc
	pop de
	pop hl
	jr _Var_loadstringbuffer2

Var_BoxFreeSpace:
; Remaining database entries
	farcall CheckFreeDatabaseEntries
	jr _Var_loadstringbuffer2

Var_BattleResult:
	ld a, [wBattleResult]
	and ~BATTLERESULT_BITMASK
	jr _Var_loadstringbuffer2

Var_CountPokemonJournals:
	ld hl, wPokemonJournals
	ld b, wPokemonJournalsEnd - wPokemonJournals
	call CountSetBits
	ld a, [wNumSetBits]
	jr _Var_loadstringbuffer2

Var_Landmark:
	call GetCurrentLandmark
	jr _Var_loadstringbuffer2

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
	farcall Pokedex_CountSeenOwn
	ld hl, wTempDexOwn
	ld a, [hli]
	cp HIGH(NUM_POKEMON)
	jr c, .nostar3
	ld a, [hl]
	cp LOW(NUM_POKEMON)
	jr c, .nostar3
	inc b
.nostar3
	pop bc
	; star for beating Tower Tycoon Palmer or Factory Head Thorton
	eventflagcheck EVENT_BEAT_PALMER
	jr nz, .star4
	eventflagcheck EVENT_BEAT_THORTON
	jr z, .nostar4
.star4
	inc b
.nostar4
	ld a, b
	jmp _Var_loadstringbuffer2
