BattleCommand_spikes:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyHazards
	jr z, .got_hazards
	ld hl, wPlayerHazards
.got_hazards
	ld a, [hl]
	or ~HAZARDS_SPIKES
	inc a
	jr z, FailSpikes
	ld a, HAZARDS_SPIKES / 3
	add [hl]
	ld [hl], a

	farcall AnimateCurrentMove

	ld hl, SpikesText
	jmp StdBattleTextbox

BattleCommand_toxicspikes:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyHazards
	jr z, .got_screens
	ld hl, wPlayerHazards
.got_screens
	ld a, [hl]
	and HAZARDS_TOXIC_SPIKES
	cp (HAZARDS_TOXIC_SPIKES / 3) * 2
	jr z, FailSpikes
	ld a, HAZARDS_TOXIC_SPIKES / 3
	add [hl]
	ld [hl], a

	farcall AnimateCurrentMove

	ld hl, ToxicSpikesText
	jmp StdBattleTextbox

BattleCommand_stickyweb:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyHazards
	jr z, .got_screens
	ld hl, wPlayerHazards
.got_screens
	ld a, [hl]
	and HAZARDS_STICKY_WEB
	jr nz, FailSpikes
	ld a, HAZARDS_STICKY_WEB
	or [hl]
	ld [hl], a

	farcall AnimateCurrentMove

	ld hl, StickyWebText
	jmp StdBattleTextbox

FailSpikes:
	farjp PrintDidntAffect2
