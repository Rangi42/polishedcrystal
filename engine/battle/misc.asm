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
	ld a, h
	assert HIGH(STRUGGLE) == 0
	and a
	jr nz, .cphl_struggle_misc
	ld a, l
	assert LOW(STRUGGLE) != 0
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


CheckAirborneAfterMoldBreaker:
	push de
	call SwitchTurn
	call GetOpponentAbilityAfterMoldBreaker
	ld b, a
	call SwitchTurn
	jr CheckAirborne_GotAbility

CheckAirborne:
	push de
	call GetTrueUserAbility
	ld b, a
CheckAirborne_GotAbility:
; d=1: Skip type checks (used for Inverse Battle Ground->Flying matchup)
; Returns a=0 and z if grounded. Returns nz if not.
; a contains ATKFAIL_MISSED for air balloon, ATKFAIL_IMMUNE for flying type,
; ATKFAIL_ABILITY for Levitate.

	; Check Gravity
	ld a, [wFieldEffects]
	and FIELD_GRAVITY
	jr z, .no_gravity
	; All pokemon are grounded during Gravity
	pop de
	xor a
	ret
.no_gravity
	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVar
	bit SUBSTATUS_INGRAIN, a
	jr z, .no_ingrain
	xor a
	ret
.no_ingrain

	; Check Iron Ball
	push bc
	predef GetUserItemAfterUnnerve
	ld a, b
	pop bc
	pop de
	ld c, a
	sub HELD_IRON_BALL
	ret z

	; Check Magnet Rise
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerYawnMagnetRiseCount
	jr z, .got_magnet_rise
	ld hl, wEnemyYawnMagnetRiseCount
.got_magnet_rise
	ld a, [hl]
	and $0F
	jr nz, .airborne

	; d=1 (inverse matchup checks/ring target) skips hardcoded immunity check
	ld a, d
	and a
	jr nz, .typecheck_done
	push bc
	call CheckIfUserIsFlyingType
	pop bc
	ld a, ATKFAIL_IMMUNE
	jr z, .airborne
.typecheck_done
	ld a, c
	cp HELD_AIR_BALLOON
	ld a, ATKFAIL_MISSED
	jr z, .airborne
	ld a, b
	cp LEVITATE
	ld a, ATKFAIL_ABILITY
	jr z, .airborne
	xor a
.airborne
	and a
	ret


BattleCheckTypeMatchup:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonType1
	jr z, CheckTypeMatchup
	ld hl, wBattleMonType1
	; fallthrough
CheckTypeMatchup:
; Wrapper that handles ability immunities, because type matchups take predecence,
; this matters for Ground pokémon with Lightning Rod (and Trace edge-cases).
; Yes, Lightning Rod is useless on ground types since GSC has no doubles.
	push hl
	push de
	push bc
	call _CheckTypeMatchup
	; if the attack is ineffective, bypass ability checks
	ld a, [wTypeMatchup]
	and a
	jr z, .end

	; check Ground-type attacks
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp GROUND
	jr nz, .done_ground_type

	call SwitchTurn

	; Ring Target or Inverse battles bypass the type matchup check.
	push bc
	predef GetUserItemAfterUnnerve
	ld a, b
	pop bc
	cp HELD_RING_TARGET
	ld d, 1
	jr z, .check_airborne
	ld a, [wBattleType]
	cp BATTLETYPE_INVERSE
	jr z, .check_airborne
	dec d
.check_airborne
	call CheckAirborneAfterMoldBreaker
	push af
	call SwitchTurn
	pop af
	jr z, .done_ground_type
	cp ATKFAIL_ABILITY
	jr nz, .no_levitate
	ld [wAttackMissed], a

.no_levitate
	xor a
	ld [wTypeMatchup], a

.done_ground_type
	farcall CheckNullificationAbilities
.end
	jmp PopBCDEHL

_CheckTypeMatchup:
	push hl
; Handle powder moves
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	call GetMoveIndexFromID
	ld b, h
	ld c, l
	ld hl, PowderMoves
	ld de, 2
	call IsInWordArray
	jr nc, .skip_powder
	farcall GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_SAFETY_GOGGLES
	jmp z, .Immune
	pop hl
	push hl
	ld a, [hli]
	cp GRASS
	jmp z, .Immune
	ld a, [hl]
	cp GRASS
	jmp z, .Immune
	call GetOpponentAbilityAfterMoldBreaker
	cp OVERCOAT
	jr nz, .skip_powder
	ld a, ATKFAIL_ABILITY
	ld [wAttackMissed], a
	jr .Immune

.skip_powder
	pop hl
	push hl
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	ld d, a
	ld a, [hli]
	ld c, [hl]
	ld b, a
	ld a, $10 ; 1.0
	ld [wTypeMatchup], a
	ld hl, InverseTypeMatchups
	ld a, [wBattleType]
	cp BATTLETYPE_INVERSE
	jr z, .TypesLoop
	ld hl, TypeMatchups
.TypesLoop:
	ld a, [hli]
	; terminator
	cp $ff
	jr z, .end
	cp $fe
	jr nz, .Next
	; stuff beyond this point is ignored if the foe is identified or we have Scrappy
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_IDENTIFIED, a
	jr nz, .end
	call GetTrueUserAbility
	cp SCRAPPY
	jr z, .end
	cp MINDS_EYE
	jr nz, .TypesLoop
.end
	pop hl
	ret

.Next:
	; attacking type
	cp d
	jr nz, .Nope
	ld a, [hli]
	; defending types
	cp b
	jr z, .Yup
	cp c
	jr z, .Yup
	jr .Nope2

.Nope:
	inc hl
.Nope2:
	inc hl
	jr .TypesLoop

.Yup:
	; no need to continue if we encountered a 0x matchup
	ld a, [hli]
	and a
	jr z, .RingTarget
	cp SUPER_EFFECTIVE
	jr z, .se
	cp NOT_VERY_EFFECTIVE
	jr z, .nve
	jr .TypesLoop
.se
	ld a, [wTypeMatchup]
	add a
	ld [wTypeMatchup], a
	jr .TypesLoop
.nve
	ld a, [wTypeMatchup]
	srl a
	ld [wTypeMatchup], a
	jr .TypesLoop

.RingTarget:
	; if opponent is holding Ring Target, ignore type-based immunity
	push hl
	farcall GetOpponentItemAfterUnnerve
	pop hl
	ld a, b
	cp HELD_RING_TARGET
	jr z, .TypesLoop
.Immune:
	xor a
	ld [wTypeMatchup], a
	pop hl
	ret

INCLUDE "data/types/inverse_type_matchups.asm"
INCLUDE "data/types/type_matchups.asm"


TrueUserValidBattleItem:
; Items (and Abilities) never apply to external Future Sight users.
	farcall GetFutureSightUser
	ret nz
	; fallthrough
UserValidBattleItem:
; Checks if the user's held item applies to the species+form.
; Used for items like Leek, Lucky Punch, Thick Club, etc.
; Returns z if the item is valid.
	push hl
	push de
	push bc

	; Get item, species and form data.
	ld hl, wBattleMonItem
	call GetUserMonAttr
	ld a, [hl]
	ld de, wBattleMonSpecies - wBattleMonItem
	add hl, de
	ld c, [hl]
	ld de, wBattleMonForm - wBattleMonSpecies
	add hl, de
	ld b, [hl]
	ld d, a
	ld hl, .ValidBattleItemTable

.loop
	; Check if we reached the end of the table.
	ld a, [hli]
	inc a
	jr z, .failed

	; Does the item match the held one?
	dec a
	cp d
	ld a, [hli]
	jr nz, .next

	; Does the item apply to the species?
	cp c
	jr nz, .next

	; Check exact species+form.
	ld a, [hl]
	call CompareSpeciesForm
	jr z, .matched
.next
	inc hl
	jr .loop
.matched
	xor a
	jr .done
.failed
	or 1
.done
	jmp PopBCDEHL

MACRO species_battle_item
	db \1
	shift
	dp \#
ENDM

.ValidBattleItemTable:
	species_battle_item LIGHT_BALL, PIKACHU
	species_battle_item LEEK, FARFETCH_D
	species_battle_item LEEK, SIRFETCH_D
	species_battle_item LUCKY_PUNCH, CHANSEY
	species_battle_item QUICK_POWDER, DITTO
	species_battle_item THICK_CLUB, CUBONE
	species_battle_item THICK_CLUB, MAROWAK
	db -1


CheckSheerForceNegation:
; Check if a secondary effect was suppressed due to Sheer Force.
; Most likely a bug introduced in Gen V, it is an established
; mechanic at this point (VII) that if Sheer Force negates the
; secondary effect of a move, various side effects don't trigger.
; Returns z if an effect is negated.
	call GetTrueUserAbility
	cp SHEER_FORCE
	ret nz
	ld a, [wEffectFailed]
	and a
	jr z, .ret_nz
	xor a
	ret
.ret_nz
	or 1
	ret
