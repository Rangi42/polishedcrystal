_CheckContactMove::
; Check if user's move made contact. Returns nc if it is
	farcall GetUserItemAfterUnnerve
	ld a, b
	cp HELD_PROTECTIVE_PADS
	jr z, .protective_pads
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp STRUGGLE
	ret z
	ld hl, .ContactMoves
	ld de, 1
	call IsInArray
.protective_pads
	ccf
	ret
.ContactMoves::
	db AERIAL_ACE
	db AQUA_TAIL
	db ASTONISH
	db BITE
	db BODY_SLAM
	db BUG_BITE
	db BULLET_PUNCH
	db CLOSE_COMBAT
	db COUNTER
	db CRABHAMMER
	db CROSS_CHOP
	db CRUNCH
	db CUT
	db DIG
	db DIZZY_PUNCH
	db DOUBLE_KICK
	db DOUBLE_EDGE
	db DRAGON_CLAW
	db DRAIN_KISS
	db DRAIN_PUNCH
	db DRILL_PECK
	db DYNAMICPUNCH
	db EXTREMESPEED
	db FALSE_SWIPE
	db FEINT_ATTACK
	db FIRE_PUNCH
	db FLAME_WHEEL
	db FLARE_BLITZ
	db FLY
	db FURY_STRIKES
	db GYRO_BALL
	db GIGA_IMPACT
	db HEADBUTT
	db HI_JUMP_KICK
	db HORN_ATTACK
	db HYPER_FANG
	db ICE_PUNCH
	db IRON_HEAD
	db IRON_TAIL
	db KARATE_CHOP
	db KNOCK_OFF
	db LEECH_LIFE
	db LICK
	db LOW_KICK
	db MACH_PUNCH
	db MEGAHORN
	db METAL_CLAW
	db NIGHT_SLASH
	db OUTRAGE
	db PECK
	db PETAL_DANCE
	db PLAY_ROUGH
	db POISON_JAB
	db POWER_WHIP
	db PURSUIT
	db QUICK_ATTACK
	db RAGE
	db RAPID_SPIN
	db RETURN
	db REVERSAL
	db ROCK_SMASH
	db ROLLOUT
	db SCRATCH
	db SEISMIC_TOSS
	db SHADOW_CLAW
	db SLASH
	db SPARK
	db STEEL_WING
	db STOMP
	db STRENGTH
	db SUPER_FANG
	db TACKLE
	db TAKE_DOWN
	db THIEF
	db THRASH
	db THUNDERPUNCH
	db U_TURN
	db VINE_WHIP
	db WATERFALL
	db WILD_CHARGE
	db WING_ATTACK
	db WRAP
	db X_SCISSOR
	db ZEN_HEADBUTT
	db -1

_DisappearUser::
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

_AppearUserRaiseSub:
	farcall BattleCommand_raisesubnoanim
	jr AppearUser

_AppearUserLowerSub:
	farcall BattleCommand_lowersubnoanim

AppearUser:
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
FinishAppearDisappearUser:
	ld a, $1
	ld [hBGMapMode], a
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
