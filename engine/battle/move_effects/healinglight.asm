BattleCommand_healweather:
	farcall CheckFullHP
	jr z, .full

	ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonType1]
	ld b, a
	ld a, [wBattleMonType2]
	ld c, a
	jr z, .got_types
	ld a, [wEnemyMonType1]
	ld b, a
	ld a, [wEnemyMonType2]
	ld c, a
.got_types
	ld a, b
	cp GRASS
	jr z, .synthesis_anim
	ld a, c
	cp GRASS
	jr z, .synthesis_anim
	ld a, [wTimeOfDay]
	cp NITE
	jr nc, .moonlight_anim
	xor a ; Morning Sun anim
	jr .got_anim
.moonlight_anim
	ld a, $1
	jr .got_anim
.synthesis_anim
	ld a, $2
.got_anim
	ld [wKickCounter], a
	call AnimateCurrentMove

	call GetWeatherAfterUserUmbrella
	cp WEATHER_SUN
	jr z, .goodheal
	and a
	jr nz, .badheal
	call GetHalfMaxHP
	jr .amount_ok
.badheal
	call GetQuarterMaxHP
	jr .amount_ok
.goodheal
	call GetThirdMaxHP
	sla c
	rl b
.amount_ok
	farcall RestoreHP
	call UpdateUserInParty

; 'regained health!'
	ld hl, RegainedHealthText
	jp StdBattleTextbox

.full
	call AnimateFailedMove
	ld hl, HPIsFullText
	jp StdBattleTextbox
