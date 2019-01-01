_DisappearUser:: ; fbd54
	xor a
	ld [hBGMapMode], a
	ld a, [hBattleTurn]
	and a
	jr z, .player
	call GetEnemyFrontpicCoords
	jr .okay
.player
	call GetPlayerBackpicCoords
.okay
	call ClearBox
	jr FinishAppearDisappearUser

_AppearUserRaiseSub: ; fbd69 (3e:7d69)
	farcall BattleCommand_RaiseSubNoAnim
	jr AppearUser

_AppearUserLowerSub: ; fbd71 (3e:7d71)
	farcall BattleCommand_LowerSubNoAnim

AppearUser: ; fbd77 (3e:7d77)
	xor a
	ld [hBGMapMode], a
	ld a, [hBattleTurn]
	and a
	jr z, .player
	call GetEnemyFrontpicCoords
	xor a
	jr .okay
.player
	call GetPlayerBackpicCoords
	ld a, $31
.okay
	ld [hGraphicStartTile], a
	predef PlaceGraphic
FinishAppearDisappearUser: ; fbd91 (3e:7d91)
	ld a, $1
	ld [hBGMapMode], a
	ret

GetEnemyFrontpicCoords: ; fbd96 (3e:7d96)
	hlcoord 12, 0
	lb bc, 7, 7
	ret

GetPlayerBackpicCoords: ; fbd9d (3e:7d9d)
	hlcoord 2, 6
	lb bc, 6, 6
	ret


DoWeatherModifiers: ; fbda4
; checks attacking move type in b with current weather for a x1.5 boost or x0.5 penalty to
; apply for wTypeMatchup for later damage calc adjustment (alongside STAB and type matchup)
	call GetWeatherAfterCloudNine
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
