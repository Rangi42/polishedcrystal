VarActionTable:
; $00: copy [de] to wStringBuffer2
; $40: return address in de
; $80: call function
	dwb wStringBuffer2,                 RETVAR_STRBUF2
	dwb wPartyCount,                    RETVAR_STRBUF2
	dwb Var_BattleResult,               RETVAR_EXECUTE
	dwb wBattleType,                    RETVAR_ADDR_DE
	dwb wTimeOfDay,                     RETVAR_STRBUF2
	dwb Var_CountCaughtMons,            RETVAR_EXECUTE
	dwb Var_CountSeenMons,              RETVAR_EXECUTE
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
	dwb NULL,                           RETVAR_STRBUF2

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
	jmp nz, _de_
	ld a, b
	and RETVAR_ADDR_DE
	ret nz
	ld a, [de]
_Var_loadstringbuffer2:
	ld de, wStringBuffer2
	ld [de], a
	ret

Var_CountCaughtMons:
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld a, [wNumSetBits]
	jr _Var_loadstringbuffer2

Var_CountSeenMons:
	ld hl, wPokedexSeen
	ld b, wEndPokedexSeen - wPokedexSeen
	call CountSetBits
	ld a, [wNumSetBits]
	jr _Var_loadstringbuffer2

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
	call .count
	ld a, b
	jr _Var_loadstringbuffer2

.count
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
; Remaining database entries
	farcall CheckFreeDatabaseEntries
	jr _Var_loadstringbuffer2

Var_BattleResult:
	ld a, [wBattleResult]
	and $3f
	jr _Var_loadstringbuffer2

Var_CountPokemonJournals:
	ld hl, wPokemonJournals
	ld b, wPokemonJournalsEnd - wPokemonJournals
	call CountSetBits
	ld a, [wNumSetBits]
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
	jmp _Var_loadstringbuffer2
