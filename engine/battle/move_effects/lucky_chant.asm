BattleCommand_luckychant:
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerTeamEffects
	jr z, .ok
	ld hl, wEnemyTeamEffects
.ok
	ld a, [hl]
	and TEAM_LUCKY_CHANT
	jr nz, .failed
	ld a, [hl]
	and ~(TEAM_LUCKY_CHANT)
	or 5
	ld [hl], a
	farcall AnimateCurrentMove
	ld hl, LuckyChantUsedText
	jmp StdBattleTextbox

.failed
	farcall AnimateFailedMove
	farjp PrintButItFailed
