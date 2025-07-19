_CheckContactMove::
; Check if user's move made contact. Returns nc if it is
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_PROTECTIVE_PADS
	jr z, .protective_pads
	cp HELD_PUNCHING_GLOVE
	jr nz, .not_punching_glove
	farcall IsPunchingMove
	ret z

.not_punching_glove
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld b, a
	call GetMoveIndexFromID
	assert HIGH(STRUGGLE) == 0
	ld a, h
	and a
	jr nz, .cphl_struggle_misc
	ld a, l
	cp LOW(STRUGGLE)
.cphl_struggle_misc
	ret nc
	ld a, b
	push af
	ld b, h
	ld c, l
	ld hl, AbnormalContactMoves
	ld de, 2
	call IsInWordArray
	ld b, PHYSICAL
	jr nc, .not_abnormal
	assert PHYSICAL + 1 == SPECIAL
	inc b
.not_abnormal
	pop af
	ld l, a
	ld a, MOVE_CATEGORY
	call GetMoveAttribute ; checks category properly even if PSS is off
	cp b
	ret z
	and a
.protective_pads
	ccf
	ret

INCLUDE "data/moves/abnormal_contact_moves.asm"

DisappearUser::
	xor a
	ldh [hBGMapMode], a
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	call GetEnemyFrontpicCoords
	jr .okay
.player
	call GetPlayerBackpicCoords
.okay
	call ClearBox
	jr FinishAppearDisappearUser

_AppearUserRaiseSub:
	farcall BattleCommand_raisesubnoanim
	jr AppearUser

_AppearUserLowerSub:
	farcall BattleCommand_lowersubnoanim

AppearUser:
	xor a
	ldh [hBGMapMode], a
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	call GetEnemyFrontpicCoords
	xor a
	jr .okay
.player
	call GetPlayerBackpicCoords
	ld a, $31
.okay
	ldh [hGraphicStartTile], a
	predef PlaceGraphic
FinishAppearDisappearUser:
	ld a, $1
	ldh [hBGMapMode], a
	ret

GetEnemyFrontpicCoords:
	hlcoord 12, 0
	lb bc, 7, 7
	ret

GetPlayerBackpicCoords:
	hlcoord 2, 6
	lb bc, 6, 6
	ret

DoWeatherModifiers:
; checks attacking move type in b with current weather for a x1.5 boost or x0.5 penalty to
; apply for wTypeMatchup for later damage calc adjustment (alongside STAB and type matchup)
	call GetWeatherAfterOpponentUmbrella
	cp WEATHER_SUN
	jr z, .sun
	cp WEATHER_RAIN
	jr z, .rain
	ret
.sun
	lb de, FIRE, WATER
	jr .check_movetype
.rain
	lb de, WATER, FIRE
.check_movetype
	ld a, b ; move type
	cp e
	jr z, .reduce
	cp d
	ret nz
.boost
	ld a, [wTypeMatchup]
	ld b, a
	srl b
	add b
	ld [wTypeMatchup], a
	ret
.reduce
	ld a, [wTypeMatchup]
	srl a
	ld [wTypeMatchup], a
	ret

; TODO another routine exists in effect_commands.asm that does this, is this routine also necessary?
CheckUserMove:
; Return z if the user has move a.
	ld b, a
	ld de, wBattleMonMoves
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld de, wEnemyMonMoves
.ok

	ld c, NUM_MOVES
.loop
	ld a, [de]
	inc de
	cp b
	ret z

	dec c
	jr nz, .loop

	ld a, 1
	and a
	ret
