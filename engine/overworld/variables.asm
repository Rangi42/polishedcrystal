VarActionTable:
; $00: copy [de] to wStringBuffer2
; $40: return address in de
; $80: call function
	table_width 3, VarActionTable
	dwb wStringBuffer2,                 RETVAR_STRBUF2
	dwb wPartyCount,                    RETVAR_STRBUF2
	dwb Var_BattleResult,               RETVAR_EXECUTE
	dwb wBattleType,                    RETVAR_ADDR_DE
	dwb wTimeOfDay,                     RETVAR_STRBUF2
	dwb Var_CountBadges,                RETVAR_EXECUTE
	dwb wPlayerState,                   RETVAR_ADDR_DE
	dwb Var_PlayerFacing,               RETVAR_EXECUTE
	dwb hHours,                         RETVAR_STRBUF2
	dwb Var_DayOfWeek,                  RETVAR_EXECUTE
	dwb wMapGroup,                      RETVAR_STRBUF2
	dwb wMapNumber,                     RETVAR_STRBUF2
	dwb Var_UnownCaught,                RETVAR_EXECUTE
	dwb wEnvironment,                   RETVAR_STRBUF2
	dwb Var_BoxFreeSpace,               RETVAR_EXECUTE
	dwb wBugContestMinsRemaining,       RETVAR_STRBUF2
	dwb wXCoord,                        RETVAR_STRBUF2
	dwb wYCoord,                        RETVAR_STRBUF2
	dwb wSpecialPhoneCallID,            RETVAR_STRBUF2
	dwb wKurtApricornQuantity,          RETVAR_STRBUF2
	dwb wCurCaller,                     RETVAR_ADDR_DE
	dwb wBlueCardBalance,               RETVAR_ADDR_DE
	dwb wBuenasPassword,                RETVAR_ADDR_DE
	dwb wKenjiBreakTimer,               RETVAR_STRBUF2
	dwb Var_CountPokemonJournals,       RETVAR_EXECUTE
	dwb Var_CountTrainerStars,          RETVAR_EXECUTE
	dwb Var_Landmark,                   RETVAR_EXECUTE
	dwb wPlayerGender,                  RETVAR_ADDR_DE
	assert_table_length NUM_VARS

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
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld b, a
	and RETVAR_EXECUTE
	jmp nz, _de_
	ld a, b
	and RETVAR_ADDR_DE
	ret nz
	ld a, [de]
_Var_loadstringbuffer2:
	ld de, wStringBuffer2
	ld [de], a
	ret

Var_CountBadges:
	ld hl, wBadges
	ld b, wBadgesEnd - wBadges
	call CountSetBits
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
