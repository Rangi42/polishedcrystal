CheckFaint:
	farjp ResolveFaints

HandleBetweenTurnEffects:
; Things handled at endturn. Things commented out are currently not in Polished.
	ld hl, wTotalBattleTurns
	inc [hl]
	jr nz, .done_turn_increment
	dec [hl]

.done_turn_increment
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
	call HandleRoost
	call HandleReflect
	call HandleLightScreen
	call HandleSafeguard
	call HandleMist
	; tailwind
	; lucky chant
	; rainbow dissipating (water+fire pledge)
	; sea of fire dissipating (grass+fire pledge)
	; swamp dissipating (water+grass pledge)
	call HandleTrickRoom
	; water sport
	; mud sport
	; wonder room
	; magic room
	; gravity
	; terrain (dissipating, grass terrain recovery is elsewhere)
	call HandleEndturnBlockB
	; Things below do not exist in 7gen -- it's here to avoid some quirks
	call HandleLeppaBerry
	call HandleHealingItems

	; these run even if the user switched at endturn
	ld hl, wPlayerSubStatus4
	res SUBSTATUS_FLINCHED, [hl]
	ld hl, wEnemySubStatus4
	res SUBSTATUS_FLINCHED, [hl]

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
	and a
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

	call SetFastestTurn
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

	farcall SpikesDamageBoth
	farcall RunBothActivationAbilities
	jmp .endturn_loop
.not_both2
	call SetEnemyTurn
	dec e
	call z, SetPlayerTurn
	farcall SpikesDamage
	farcall RunActivationAbilities
	jmp .endturn_loop

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
	jmp HandleLeftovers
	; healer

HandleEndturnBlockB:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	; uproar
	farcall EndturnAbilitiesB ; and pickup/harvest (no need to move below orbs)
	call SwitchTurn
	call HandleStatusOrbs
	jmp SwitchTurn

HandleWeather:
	ld a, [wBattleWeather]
	and a ; cp WEATHER_NONE
	ret z

	; Freeze the timer at 255 for permaweather (overworld weather)
	ld hl, wWeatherCount
	inc [hl]
	jr z, .infinite_weather
	dec [hl]
.infinite_weather
	dec [hl]
	jr nz, .ongoing

	ld hl, .WeatherEndedMessages
	ld a, [wBattleWeather]
	dec a
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call StdBattleTextbox
	xor a
	ld [wBattleWeather], a
	ret

.WeatherEndedMessages: ; these are all used with StdBattleTextbox
	dw BattleText_TheRainStopped ; far-ok
	dw BattleText_TheSunlightFaded ; far-ok
	dw BattleText_TheSandstormSubsided ; far-ok
	dw BattleText_TheHailStopped ; far-ok

.ongoing
	; the above needs actual [wBattleWeather] to be
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
	call StdBattleTextbox
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
if !DEF(FAITHFUL) ; Slush Rush is an exception in vanilla for some reason
	cp SLUSH_RUSH
	ret z
endc

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
	call StdBattleTextbox
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
	jmp StdBattleTextbox

.do_future_sight
	push hl
	ld hl, BattleText_TargetWasHitByFutureSight
	call StdBattleTextbox

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
	jmp UpdateEnemyMonInParty

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
	jmp StdBattleTextbox

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
	ld hl, LeechSeedSapsText
	call StdBattleTextbox
	pop bc
	call SwitchTurn
	farcall GetHPAbsorption
	ld a, $1
	ldh [hBGMapMode], a
	call GetOpponentAbility
	cp LIQUID_OOZE
	jr z, .hurt
	farcall RestoreHP
	jr .done
.hurt
	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	predef SubtractHPFromUser
	ld hl, SuckedUpOozeText
	call StdBattleTextbox
	farcall EnableAnimations
.done
	jmp SwitchTurn

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
	call GetTrueUserAbility
	cp POISON_HEAL
	jr nz, DoPoisonBurnDamage
	; check if we are at full HP
	farcall CheckFullHP
	ret z
	farcall DisableAnimations
	farcall ShowAbilityActivation
	ld hl, RegainedHealthText
	call DoPoisonBurnDamageAnim
	farcall RestoreHP
	farjp EnableAnimations

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

	call DoPoisonBurnDamageAnim
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and 1 << BRN | 1 << TOX
	; Burn and Toxic does (or starts at) 1/16 damage as of Gen VII
	call nz, GetSixteenthMaxHP

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

DoPoisonBurnDamageAnim:
	push de
	call StdBattleTextbox
	pop de
	xor a
	ld [wNumHits], a
	farcall Call_PlayBattleAnim_OnlyIfVisible
	jmp GetEighthMaxHP

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
	jmp StdBattleTextbox

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
	ld [wNamedObjectIndex], a
	call GetMoveName
	jmp StdBattleTextbox

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
	jmp StdBattleTextbox

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

	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerPerishCount
	jr z, .got_count
	ld hl, wEnemyPerishCount

.got_count
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld a, [hl]
	ld [wTextDecimalByte], a
	push af
	ld hl, PerishCountText
	call StdBattleTextbox
	pop af
	ret nz

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
	jmp StdBattleTextbox

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

HandleReflect:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call GetTurnAndPlacePrefix
	ld hl, wPlayerScreens
	jr z, .got_screens
	ld hl, wEnemyScreens
.got_screens
	ld de, BattleText_ReflectFaded
	jr DecrementLowNibble

HandleSafeguard:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call GetTurnAndPlacePrefix
	ld hl, wPlayerGuards
	jr z, .got_guards
	ld hl, wEnemyGuards
.got_guards
	ld de, BattleText_SafeguardFaded

DecrementLowNibble:
; Decrements lower nibble in hl. If it reaches 0, print message in de.
	ld a, [hl]
	and $f
	ret z
	dec [hl]
	dec a
	ret nz
	jr PrintTextAfterNibbleTick

HandleLightScreen:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call GetTurnAndPlacePrefix
	ld hl, wPlayerScreens
	jr z, .got_screens
	ld hl, wEnemyScreens
.got_screens
	ld de, BattleText_LightScreenFell
	jr DecrementHighNibble

HandleMist:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	call GetTurnAndPlacePrefix
	ld hl, wPlayerGuards
	jr z, .got_guards
	ld hl, wEnemyGuards
.got_guards
	ld de, BattleText_MistFaded

DecrementHighNibble:
; Decrements higher nibble in hl. If it reaches 0, print message in de.
	ld a, [hl]
	sub $10
	ret c
	ld [hl], a
	sub $10
	ret nc
PrintTextAfterNibbleTick:
	ld h, d
	ld l, e
	jmp StdBattleTextbox

GetTurnAndPlacePrefix:
; Preserves a, returns zero flag for a
	ldh a, [hBattleTurn]
	and a
	push af
	ld de, .Your
	jr z, .got_prefix
	ld de, .Foe
.got_prefix
	ld hl, wStringBuffer1
	call CopyName2
	pop af
	ret
.Your:
	db "Your@"
.Foe:
	db "Foe@"

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
	; Done for target to simplify checks so invert
	; turn
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
	ret nz
	push bc
	ld b, 2
	farcall CanPoisonTarget
	pop bc
	ret nz
	ld de, ANIM_PSN
	ld hl, BadlyPoisonedText
	jr .do_status
.burn
	push bc
	ld b, 2
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
	jmp StdBattleTextbox

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
