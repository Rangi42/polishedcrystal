CheckFaint:
	farjp ResolveFaints

HandleBetweenTurnEffects:
; Things handled at endturn. Things commented out are currently not in Polished.
	call CheckFaint
	ret c
	call HandleWeather
	call CheckFaint
	ret c
	; Self-curing status from high Affection
	call HandleFutureSight
	call CheckFaint
	ret c
	; Wish
	call HandleEndturnBlockA
	call CheckFaint
	ret c
	; aqua ring
	; ingrain
	call HandleLeechSeed
	call CheckFaint
	ret c
	call HandlePoison
	call CheckFaint
	ret c
	call HandleBurn
	call CheckFaint
	ret c
	; nightmare
	call HandleCurse
	call CheckFaint
	ret c
	call HandleWrap
	call CheckFaint
	ret c
	; taunt
	call HandleEncore
	call HandleDisable
	; magnet rise
	; telekinesis
	; heal block
	; embargo
	; yawn
	call HandlePerishSong
	call CheckFaint
	ret c
	; Things below are yet to be updated to be handled in correct order
	call HandleTrickRoom
	call HandleLeppaBerry
	call HandleScreens
	call HandleSafeguard
	call HandleHealingItems
	farcall HandleAbilities

	; these run even if the user switched at endturn
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_FLINCHED, [hl]
	ld hl, wEnemySubStatus3
	res SUBSTATUS_FLINCHED, [hl]

	call HandleStatusOrbs
	call HandleRoost
	call UpdateBattleMonInParty
	call UpdateEnemyMonInParty

.endturn_loop
	; Resolve faints, just in case
	call CheckFaint
	ret c
	call LoadTileMapToTempTileMap

	; If player is fainted in wild battle, maybe try flee
	call HasPlayerFainted
	jr nz, .player_not_fleeing

	farcall AskUseNextPokemon
	jr nc, .player_not_fleeing
	ld a, 1
	ld [wBattleEnded], a
	ret

.player_not_fleeing
	; figure out which Pokémon fainted
	ld e, 0
	call HasPlayerFainted
	jr nz, .player_not_fainted
	set 0, e
.player_not_fainted
	call HasEnemyFainted
	jr nz, .enemy_not_fainted
	set 1, e
.enemy_not_fainted
	ld a, e
	and a
	ret z
	push de
	cp 3
	jr nz, .not_both
	farcall GetBothSwitchTarget
	jr .got_target
.not_both
	call SetPlayerTurn
	bit 1, e
	call nz, SetEnemyTurn
	farcall GetUserSwitchTarget

.got_target
	; If enemy has fainted, display enemy trainer mons left (pokéballs)
	call HasEnemyFainted
	jr nz, .skip_trainerhud
	farcall EnemySwitch_TrainerHud
.skip_trainerhud
	; If player has a switch target, continue as if we're in "Set" mode
	ld a, [wPlayerSwitchTarget]
	and a
	jr nz, .player_set_mode

	; Enemy, but not player, has chosen a switch-in. Maybe prompt a switch
	farcall CheckAnyOtherAlivePartyMons
	jr z, .player_set_mode

	; In Battle Tower or Link mode, always use "Set" mode.
	ld a, [wLinkMode]
	and a
	jr nz, .player_set_mode
	ld a, [wInBattleTowerBattle]
	bit 0, a
	jr nz, .player_set_mode

	; Obviously, if we're playing in Set mode, assume Set mode...
	ld a, [wOptions2]
	and 1 << BATTLE_SWITCH | 1 << BATTLE_PREDICT
	jr z, .player_set_mode
	farcall OfferSwitch

.player_set_mode
	ld a, [wPlayerSwitchTarget]
	and a
	jr z, .enemy_only

	; Mark the need to run Spikes+Abilities for players using Switch/Predict
	pop de
	set 0, e
	push de

	ld a, [wEnemySwitchTarget]
	and a
	jr z, .player_only

	call SetPlayerTurn
	ld a, [wLinkMode]
	and a
	jr z, .got_first_switchin
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	call z, SetEnemyTurn
.got_first_switchin
	farcall SendInUserPkmn
	call SwitchTurn
	farcall SendInUserPkmn
	jr .finish_sendin
.player_only
	call SetPlayerTurn
	farcall SendInUserPkmn
	jr .finish_sendin
.enemy_only
	call SetEnemyTurn
	farcall SendInUserPkmn

.finish_sendin
	pop de

	; Run Spikes and entry abilities depending on which mons are alive
	ld a, e
	cp 3
	jr nz, .not_both2

	farcall HandleFirstAirBalloon
	farcall RunBothActivationAbilities
	jp .endturn_loop
.not_both2
	call SetEnemyTurn
	dec e
	call z, SetPlayerTurn
	farcall SpikesDamage
	farcall RunActivationAbilities
	jp .endturn_loop

HandleEndturnBlockA:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	; sea of fire
	; Grassy Terrain recovery
	call HasUserFainted
	ret z
	farcall EndturnAbilitiesA
	jp HandleLeftovers
	; healer

HandleWeather:
	ld a, [wWeather]
	and a ; cp WEATHER_NONE
	ret z

	ld hl, wWeatherCount
	dec [hl]
	jr nz, .ongoing

	ld hl, .WeatherEndedMessages
	ld a, [wWeather]
	dec a
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call StdBattleTextBox
	xor a
	ld [wWeather], a
	ret

.WeatherEndedMessages:
	dw BattleText_TheRainStopped
	dw BattleText_TheSunlightFaded
	dw BattleText_TheSandstormSubsided
	dw BattleText_TheHailStopped

.ongoing
	; the above needs actual [wWeather] to be
	; able to time it out, but otherwise check
	; Cloud Nine
	call GetWeatherAfterCloudNine
	and a ; cp WEATHER_NONE
	ret z

; sandstorm/hail damage, abilities like rain dish, etc.
	xor a
	ld [wAlreadySawWeather], a
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call HasUserFainted
	ret z
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_SAFETY_GOGGLES
	jr z, .run_weather_abilities
	call GetWeatherAfterUserUmbrella
	cp WEATHER_HAIL
	call z, .HandleHail
	call GetWeatherAfterUserUmbrella
	cp WEATHER_SANDSTORM
	call z, .HandleSandstorm
.run_weather_abilities
	farjp RunWeatherAbilities

.HandleSandstorm
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_UNDERGROUND, a
	ret nz
	call GetTrueUserAbility
	cp MAGIC_GUARD
	ret z
	cp OVERCOAT
	ret z
	cp SAND_FORCE
	ret z
	cp SAND_RUSH
	ret z
	cp SAND_VEIL
	ret z

	call CheckIfUserIsGroundType
	ret z
	call CheckIfUserIsRockType
	ret z
	call CheckIfUserIsSteelType
	ret z

	ld a, [wAlreadySawWeather]
	and a
	jr nz, .saw_sandstorm
	ld de, ANIM_IN_SANDSTORM
	xor a
	ld [wNumHits], a
	inc a
	ld [wKickCounter], a
	ld [wAlreadySawWeather], a
	farcall Call_PlayBattleAnim
.saw_sandstorm

	ld hl, SandstormHitsText
	call StdBattleTextBox
	call GetSixteenthMaxHP
	predef_jump SubtractHPFromUser

.HandleHail
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_UNDERGROUND, a
	ret nz
	call GetTrueUserAbility
	cp MAGIC_GUARD
	ret z
	cp OVERCOAT
	ret z
	cp SNOW_CLOAK
	ret z
	cp ICE_BODY
	ret z

	call CheckIfUserIsIceType
	ret z

	ld a, [wAlreadySawWeather]
	and a
	jr nz, .saw_hail
	ld de, ANIM_IN_HAIL
	xor a
	ld [wNumHits], a
	inc a
	ld [wKickCounter], a
	ld [wAlreadySawWeather], a
	farcall Call_PlayBattleAnim
.saw_hail

	ld hl, HailHitsText
	call StdBattleTextBox
	call GetSixteenthMaxHP
	predef_jump SubtractHPFromUser

HandleFutureSight:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerFutureSightCount
	jr z, .got_future
	ld hl, wEnemyFutureSightCount
.got_future
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld a, [hl]
	and $f
	ret nz

	push hl
	call HasOpponentFainted
	pop hl
	jr nz, .do_future_sight

	; Future Sight misses automatically
	xor a
	ld [hl], a
	ld hl, BattleText_UsersFutureSightMissed
	jp StdBattleTextBox

.do_future_sight
	push hl
	ld hl, BattleText_TargetWasHitByFutureSight
	call StdBattleTextBox

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	push af
	ld [hl], FUTURE_SIGHT
	farcall UpdateMoveData

	xor a
	ld [wAttackMissed], a
	ld [wAlreadyDisobeyed], a
	ld a, $10
	ld [wTypeModifier], a
	farcall DoMove
	xor a
	ld [wCurDamage], a
	ld [wCurDamage + 1], a

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	pop af
	ld [hl], a
	farcall UpdateMoveData
	pop hl
	ld [hl], 0
	call UpdateBattleMonInParty
	jp UpdateEnemyMonInParty

HandleLeftovers:
	call HasUserFainted
	ret z
	farcall GetUserItem
	call GetCurItemName
	ld a, b
	cp HELD_LEFTOVERS
	jr z, .leftovers
	cp HELD_BLACK_SLUDGE
	ret nz
	call CheckIfUserIsPoisonType
	jr z, .leftovers

	; damage instead
	call GetEighthMaxHP
	predef SubtractHPFromUser
	ld hl, BattleText_UserHurtByItem
	jr .print
.leftovers
	farcall CheckFullHP
	ret z
	call GetSixteenthMaxHP
	farcall RestoreHP
	ld hl, BattleText_UserRecoveredWithItem
.print
	jp StdBattleTextBox

PreventEndturnDamage:
; returns z if residual damage at endturn is prevented
	call GetTrueUserAbility
	cp MAGIC_GUARD
	call nz, HasUserFainted
	ret

HandleLeechSeed:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_LEECH_SEED, [hl]
	call nz, PreventEndturnDamage
	call nz, HasOpponentFainted
	ret z

	call SwitchTurn
	xor a
	ld [wNumHits], a
	ld de, ANIM_SAP
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jr nz, .no_anim
	farcall Call_PlayBattleAnim_OnlyIfVisible
.no_anim
	call SwitchTurn

	call GetEighthMaxHP
	push bc
	predef SubtractHPFromUser
	pop bc
	call SwitchTurn
	farcall GetHPAbsorption
	ld a, $1
	ldh [hBGMapMode], a
	call GetOpponentAbility
	cp LIQUID_OOZE
	jr z, .hurt
	farcall RestoreHP
	jr .sap_text
.hurt
	farcall ShowEnemyAbilityActivation
	predef SubtractHPFromUser
.sap_text
	call SwitchTurn
	ld hl, LeechSeedSapsText
	jp StdBattleTextBox

HandlePoison:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and 1 << PSN
	ld hl, HurtByPoisonText
	ld de, ANIM_PSN
	ret z
	jr DoPoisonBurnDamage

HandleBurn:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and 1 << BRN
	ld hl, HurtByBurnText
	ld de, ANIM_BRN
	ret z
DoPoisonBurnDamage:
	push hl
	push de
	call PreventEndturnDamage
	pop de
	pop hl
	ret z

	call GetTrueUserAbility
	cp POISON_HEAL
	jr nz, .got_anim
	; check if we are at full HP
	farcall CheckFullHP
	ret z
	ld hl, PoisonHealText
	call .do_anim
	farjp RestoreHP

.do_anim
	push de
	call StdBattleTextBox
	pop de
	xor a
	ld [wNumHits], a
	farcall Call_PlayBattleAnim_OnlyIfVisible
	jp GetEighthMaxHP

.got_anim
	call .do_anim

	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and 1 << BRN | 1 << TOX
	jr z, .got_damage_amount
	; Burn and Toxic does (or starts at) 1/16 damage as of Gen VII
	call GetSixteenthMaxHP

.got_damage_amount
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerToxicCount
	jr z, .got_toxic_count
	ld hl, wEnemyToxicCount
.got_toxic_count
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	bit TOX, a
	jr z, .did_toxic
	inc [hl]
	ld a, [hl]
	ld hl, 0
.add
	add hl, bc
	dec a
	jr nz, .add
	ld b, h
	ld c, l
.did_toxic
	predef_jump SubtractHPFromUser

HandleCurse:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	bit SUBSTATUS_CURSE, [hl]
	call nz, PreventEndturnDamage
	ret z

	xor a
	ld [wNumHits], a
	ld de, ANIM_UNDER_CURSE
	farcall Call_PlayBattleAnim_OnlyIfVisible
	call GetQuarterMaxHP
	predef SubtractHPFromUser
	ld hl, HurtByCurseText
	jp StdBattleTextBox

HandleWrap:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call PreventEndturnDamage
	ret z

	ld hl, wPlayerWrapCount
	ld de, wPlayerTrappingMove
	ldh a, [hBattleTurn]
	and a
	jr z, .got_addrs
	ld hl, wEnemyWrapCount
	ld de, wEnemyTrappingMove

.got_addrs
	ld a, [hl]
	and a
	ret z

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret nz

	push de
	ld a, [de]
	ld [wFXAnimIDLo], a
	dec [hl]
	ld hl, BattleText_UserWasReleasedFromStringBuffer1
	jr z, .print_text

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jr nz, .skip_anim
	call SwitchTurn
	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	predef PlayBattleAnim
	call SwitchTurn

.skip_anim
	farcall GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_BINDING_BAND
	jr nz, .no_binding_band
	call GetSixthMaxHP
	jr .subtract_hp
.no_binding_band
	call GetEighthMaxHP
.subtract_hp
	predef SubtractHPFromUser
	ld hl, BattleText_UsersHurtByStringBuffer1

.print_text
	pop de
	ld a, [de]
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	jp StdBattleTextBox

HandleEncore:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call HasUserFainted
	ret z

	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerEncoreCount
	jr z, .got_encore_count
	ld hl, wEnemyEncoreCount
.got_encore_count
	; We don't want to delete the move index, which is used for Choice-locking
	ld a, [hl]
	and a
	ret z ; no move used yet, and no encore
	ld b, a

	push bc
	push hl
	call .do_encore
	pop hl
	pop bc
	ld a, [hl]
	and a
	ret nz ; encore not yet finished
	ld a, b
	and $f0
	ld [hl], a
	ret

.do_encore
	ld a, [hl]
	and $f
	ret z
	push hl
	ld a, [hl]
	swap a
	and $f
	dec a
	ld c, a
	ld b, 0
	ld hl, wBattleMonPP
	call GetUserMonAttr
	add hl, bc
	ld a, [hl]
	and $3f
	pop hl
	ld de, BattleText_UserEncoreEnded
	jr z, EndturnEncoreDisable_End
EndturnEncoreDisable:
	ld a, [hl]
	and $f
	ret z
	dec [hl]
	ld a, [hl]
	and $f
	ret nz
EndturnEncoreDisable_End:
	ld [hl], 0
	ld h, d
	ld l, e
	jp StdBattleTextBox

HandleDisable:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call HasUserFainted
	ret z
	ld de, DisabledNoMoreText

	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerDisableCount
	jr z, EndturnEncoreDisable
	ld hl, wEnemyDisableCount
	jr EndturnEncoreDisable

HandlePerishSong:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call HasUserFainted
	ret z

	ld hl, wPlayerPerishCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_count
	ld hl, wEnemyPerishCount

.got_count
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	bit SUBSTATUS_PERISH, a
	ret z
	dec [hl]
	ld a, [hl]
	ld [wd265], a
	push af
	ld hl, PerishCountText
	call StdBattleTextBox
	pop af
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	res SUBSTATUS_PERISH, [hl]

	call GetMaxHP
	predef_jump SubtractHPFromUser

HandleTrickRoom:
	ld hl, wTrickRoom
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret nz
	ld hl, TrickRoomEndedText
	jp StdBattleTextBox

HandleLeppaBerry:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call HasUserFainted
	ret z
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_RESTORE_PP
	ret nz
	farcall PreparePPRestore
	farcall GetZeroPPMove
	ret z
	push bc
	farcall ConsumeUserItem
	pop bc
	farjp LeppaRestorePP

HandleScreens:
	call CheckSpeed
	jr nz, .enemy_first

	call .CheckPlayer
	jr .CheckEnemy

.enemy_first
	call .CheckEnemy
.CheckPlayer:
	call SetPlayerTurn
	ld de, .Your
	call .Copy
	ld hl, wPlayerScreens
	ld de, wPlayerLightScreenCount
	jr .TickScreens

.CheckEnemy:
	call SetEnemyTurn
	ld de, .Enemy
	call .Copy
	ld hl, wEnemyScreens
	ld de, wEnemyLightScreenCount

.TickScreens:
	bit SCREENS_LIGHT_SCREEN, [hl]
	call nz, .LightScreenTick
	bit SCREENS_REFLECT, [hl]
	call nz, .ReflectTick
	ret

.Copy:
	ld hl, wStringBuffer1
	jp CopyName2

.Your:
	db "Your@"
.Enemy:
	db "Foe@"

.LightScreenTick:
	ld a, [de]
	dec a
	ld [de], a
	ret nz
	res SCREENS_LIGHT_SCREEN, [hl]
	push hl
	push de
	ld hl, BattleText_PkmnLightScreenFell
	call StdBattleTextBox
	pop de
	pop hl
	ret

.ReflectTick:
	inc de
	ld a, [de]
	dec a
	ld [de], a
	ret nz
	res SCREENS_REFLECT, [hl]
	ld hl, BattleText_PkmnReflectFaded
	jp StdBattleTextBox

HandleSafeguard:
	call CheckSpeed
	jr z, .player_first

	call .CheckEnemy
.CheckPlayer:
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	ret z
	ld hl, wPlayerSafeguardCount
	dec [hl]
	ret nz
	res SCREENS_SAFEGUARD, a
	ld [wPlayerScreens], a
	xor a
	jr .print

.player_first
	call .CheckPlayer
.CheckEnemy:
	ld a, [wEnemyScreens]
	bit SCREENS_SAFEGUARD, a
	ret z
	ld hl, wEnemySafeguardCount
	dec [hl]
	ret nz
	res SCREENS_SAFEGUARD, a
	ld [wEnemyScreens], a
	ld a, $1

.print
	ldh [hBattleTurn], a
	ld hl, BattleText_SafeguardFaded
	jp StdBattleTextBox

HandleHealingItems:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call HasUserFainted
	ret z
	farcall HandleHPHealingItem
	farcall UseHeldStatusHealingItem
	farcall HandleStatBoostBerry
	farjp UseConfusionHealingItem

HandleStatusOrbs:
	call SetFastestTurn
	; Done for target to simplify checks so invert
	; turn
	call SwitchTurn
	call .do_it
	call SwitchTurn

.do_it
	call HasOpponentFainted
	ret z

	; bypass ineffectiveness checks to avoid residual results from last attack
	ld a, $10
	ld [wTypeModifier], a

	farcall GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_SELF_BRN
	ld b, 1 << BRN
	jr z, .burn
	cp HELD_SELF_PSN
	ld b, 1 << PSN | 1 << TOX
	jr z, .poison
	ret
.poison
	push bc
	ld b, 0
	farcall CanPoisonTarget
	pop bc
	ret nz
	ld de, ANIM_PSN
	ld hl, BadlyPoisonedText
	jr .do_status
.burn
	push bc
	ld b, 0
	farcall CanBurnTarget
	pop bc
	ret nz
	ld de, ANIM_BRN
	ld hl, WasBurnedText
	; fallthrough
.do_status
	push hl
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	ld [hl], b
	xor a
	ld [wNumHits], a
	farcall PlayOpponentBattleAnim
	call RefreshBattleHuds
	pop hl
	jp StdBattleTextBox

HandleRoost:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call HasUserFainted
	ret z

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_ROOST, [hl]
	res SUBSTATUS_ROOST, [hl]
	ret z

	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonType1
	jr z, .got_types
	ld hl, wEnemyMonType1
.got_types
	; Check which type is ???
	ld a, [hl]
	cp UNKNOWN_T
	jr z, .got_target
	inc hl
	ld a, [hl]
	cp UNKNOWN_T
	jr nz, .aerilate
.got_target
	ld [hl], FLYING
	ret
.aerilate
	; Set Flying types on both
	ld a, FLYING
	ld [hld], a
	ld [hl], a
	ret
