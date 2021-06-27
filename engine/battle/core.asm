; Core components of the battle engine.
BattleCore:
DoBattle:
	call BackupBattleItems
	call ResetParticipants
	xor a
	ld [wBattlePlayerAction], a
	ld [wBattleEnded], a
	ld [wInverseBattleScore], a
	ld [wDeferredSwitch], a
	ld [wPlayerSwitchTarget], a
	ld [wEnemySwitchTarget], a
	ld [wTotalBattleTurns], a
	ld hl, wOTPartyMon1HP
	ld bc, PARTYMON_STRUCT_LENGTH - 1
	ld d, BATTLEACTION_SWITCH1 - 1
.loop
	inc d
	ld a, [hli]
	or [hl]
	jr nz, .alive
	add hl, bc
	jr .loop

.alive
	ld a, d
	ld [wBattleAction], a
	ld a, [wLinkMode]
	and a
	jr z, .not_linked

	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player_2

.not_linked
	ld a, [wBattleMode]
	dec a
	jr z, .wild
	ld a, 1
	ld [wEnemySwitchTarget], a
	call SlideEnemyPicOut
	call SetEnemyTurn
	call SendInUserPkmn

.wild
	; Wild mons bypass NewEnemyMonStatus, so set
	; their ability here too.
	call ResetEnemyAbility
	ld c, 40
	call DelayFrames

.player_2
	call LoadTileMapToTempTileMap
	call CheckPlayerPartyForFitPkmn
	ld a, d
	and a
	jr nz, .found_mon
	ld a, 1
	ld [wBattleResult], a
	jmp LostBattle
.found_mon
	call Call_LoadTempTileMapToTileMap
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jmp z, BattleMenu ; No real turns in a tutorial
	cp BATTLETYPE_SAFARI
	jmp z, SafariBattleTurn ; do not send out a player mon in a Safari Battle
	xor a
	ld [wCurPartyMon], a
.loop2
	call CheckIfCurPartyMonIsFitToFight
	jr nz, .alive2
	ld hl, wCurPartyMon
	inc [hl]
	jr .loop2

.alive2
	ld a, [wCurPartyMon]
	inc a
	ld [wPlayerSwitchTarget], a
	call SlidePlayerPicOut
	call SetPlayerTurn
	call SendInUserPkmn
	ld a, [wLinkMode]
	and a
	jr z, .not_linked_2
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .not_linked_2
	ld a, 1
	ld [wEnemySwitchTarget], a
	call SlideEnemyPicOut
	call SetEnemyTurn
	call SendInUserPkmn
.not_linked_2
	call AutomaticRainWhenOvercast
	call SpikesDamageBoth ; for Air Balloon
	call BoostGiovannisArmoredMewtwo
	call RunBothActivationAbilities
	jr BattleTurn

WildFled_EnemyFled_LinkBattleCanceled:
	call Call_LoadTempTileMapToTileMap
	ld a, [wBattleResult]
	and $c0
	add $2
	ld [wBattleResult], a

	ld hl, BattleText_LegendaryFled
	ld a, [wBattleType]
	cp BATTLETYPE_ROAMING
	jr z, .print_text
	cp BATTLETYPE_RED_GYARADOS
	jr nc, .print_text ; also BATTLETYPE_LEGENDARY

	ld hl, BattleText_WildFled
	ld a, [wLinkMode]
	and a
	jr z, .print_text

	ld a, [wBattleResult]
	and $c0
	ld [wBattleResult], a
	ld hl, BattleText_EnemyFled

.print_text
	call StdBattleTextbox

.skip_text
	call StopDangerSound
	ld de, SFX_RUN
	call PlaySFX
	call SetPlayerTurn
	ld a, 1
	ld [wBattleEnded], a
	ret

BattleTurn:
.loop
	call CheckContestBattleOver
	ret c

	xor a
	ld [wBattlePlayerAction], a
	ld [wPlayerSwitchTarget], a
	ld [wEnemySwitchTarget], a
	ld [wEnemyUsingItem], a
	ld [wCurDamage], a
	ld [wCurDamage + 1], a

	call HandleBerserkGene
	call UpdateBattleMonInParty
	call SetEnemyTurn
	call CheckLockedIn
	jr nz, .skip_ai_move
	farcall AIChooseMove
	farcall AI_MaybeSwitch
	call TryEnemyFlee
.skip_ai_move
	call SetPlayerTurn
	call CheckLockedIn
	jr nz, .skip_iteration
.loop1
	call BattleMenu
	ret c
	ld a, [wBattleEnded]
	and a
	ret nz
.skip_iteration
	call SetPlayerTurn
	call ParsePlayerAction
	jr nz, .loop1

	call ClearSprites

	call CheckOpponentForfeit
	ret c

	call DetermineMoveOrder
	; a = carry ? 0 (player first) : 1 (enemy first)
	sbc a
	inc a
	ldh [hBattleTurn], a
	ld [wEnemyGoesFirst], a
	call .do_move
	ret nz
	ld a, [wEnemyGoesFirst]
	xor 1
	ldh [hBattleTurn], a
	call .do_move
	ret nz

	call ProcessEnemyFleeing
	ld a, [wBattleEnded]
	and a
	ret nz

	farcall HandleBetweenTurnEffects
	ld a, [wBattleEnded]
	and a
	ret nz
	jr .loop

.do_move
	call PerformMove
	ld a, [wBattleEnded]
	and a
	ret nz

	call DeferredSwitch
	ld a, [wBattleEnded]
	and a
	ret

SafariBattleTurn:
.loop
	call CheckSafariBattleOver
	ret c

	call BattleMenu
	ret c

	ld a, [wBattleEnded]
	and a
	ret nz

	call HandleSafariAngerEatingStatus

	call CheckSafariMonRan
	ret c

	ld a, [wBattleEnded]
	and a
	ret nz

	jr .loop

HandleBerserkGene:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_BERSERK_GENE
	ret nz
	call GetCurItemName
	ld a, STAT_SKIPTEXT | STAT_SILENT
	ld b, $10 | ATTACK
	farcall _ForceRaiseStat
	ld a, [wFailedMessage]
	and a
	ret nz
	farcall UseStatItemText
	farcall ConsumeUserItem

	; Own Tempo prevents confusion. Safeguard, however, doesn't.
	call GetTrueUserAbility
	cp OWN_TEMPO
	ret z

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_CONFUSED, [hl]
	ret nz
	set SUBSTATUS_CONFUSED, [hl]
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerConfuseCount
	jr z, .got_confuse_count
	ld hl, wEnemyConfuseCount
.got_confuse_count
	call BattleRandom
	and 1
	add 2
	ld [hl], a
	ld [wNumHits], a
	ld de, ANIM_CONFUSED
	call Call_PlayBattleAnim_OnlyIfVisible
	call SwitchTurn
	ld hl, BecameConfusedText
	call StdBattleTextbox
	jmp SwitchTurn

CheckOpponentForfeit:
	ld a, [wLinkMode]
	and a
	jr z, .not_linked
	ld a, [wBattleAction]
	cp BATTLEACTION_FORFEIT
	jr z, .forfeit

.not_linked
	and a
	ret

.forfeit
	call WildFled_EnemyFled_LinkBattleCanceled
	scf
	ret

DetermineMoveOrder:
	ld a, [wBattlePlayerAction]
	and a
	jr nz, .player_first

	call CompareMovePriority
	jr z, .equal_priority
	jr c, .player_first
.enemy_first
	and a
	ret

.equal_priority
	call CheckMoveSpeed
	jr nz, .enemy_first
.player_first
	scf
	ret

GetSpeed::
; Sets bc to speed after items and stat changes.
; Fainted mons use raw speed (Tailwind and Pledge swamp isn't implemented).
	push hl
	push de
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSpdLevel]
	ld hl, wBattleMonSpeed
	jr z, .got_speed
	ld a, [wEnemySpdLevel]
	ld hl, wEnemyMonSpeed
.got_speed
	ld b, a
	xor a
	ldh [hMultiplicand + 0], a
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a

	call HasUserFainted
	jr z, .done

	; Apply stat changes
	farcall FarDoStatChangeMod
	ld a, b
	call MultiplyAndDivide

	; Halve speed if paralyzed unless we have Quick Feet
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	bit PAR, a
	jr z, .paralyze_done
	call GetTrueUserAbility
	cp QUICK_FEET
	ln a, 1, 2 ; x0.5
	call nz, MultiplyAndDivide

.paralyze_done
	farcall ApplySpeedAbilities

	; Apply item effects
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_QUICK_POWDER
	jr z, .quick_powder
	cp HELD_IRON_BALL
	ln a, 1, 2 ; x0.5
	jr z, .apply_item_mod
	ld a, b
	cp HELD_CHOICE
	jr nz, .done
	ld a, c
	cp SPEED
	jr nz, .done
	ln a, 3, 2 ; x1.5
	jr .apply_item_mod
.quick_powder
	; Double speed, but only for Ditto
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonSpecies
	jr z, .got_species
	ld hl, wEnemyMonSpecies
.got_species
	cp DITTO
	jr nz, .done
	ln a, 2, 1 ; x2
.apply_item_mod
	call MultiplyAndDivide
.done
	ldh a, [hMultiplicand + 0]
	and a
	jr z, .not_capped
	lb bc, $ff, $ff
	jr .end
.not_capped
	ldh a, [hMultiplicand + 1]
	ld b, a
	ldh a, [hMultiplicand + 2]
	ld c, a
.end
	pop de
	pop hl
	ret

CheckContestBattleOver:
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jr nz, .contest_not_over
	ld a, [wParkBallsRemaining]
	and a
	jr nz, .contest_not_over
	ld a, [wBattleResult]
	and $c0
	add $2
	ld [wBattleResult], a
	scf
	ret

.contest_not_over
	and a
	ret

CheckSafariBattleOver:
	ld a, [wSafariBallsRemaining]
	and a
	ret nz
	ld a, [wBattleResult]
	and $c0
	add $2
	ld [wBattleResult], a
	scf
	ret

CheckLockedIn:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_RECHARGE | 1 << SUBSTATUS_CHARGED | 1 << SUBSTATUS_RAMPAGE | 1 << SUBSTATUS_ROLLOUT
	ret

ParsePlayerAction:
	ld a, [wBattlePlayerAction]
	and a
	jr z, .using_move

	call SetPlayerTurn
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	xor a
	ld [hl], a
	farcall UpdateMoveData
	jr .setmovedata

.using_move
	ld a, [wBattleType]
	cp BATTLETYPE_GHOST
	jr z, .lavender_ghost

	call SetPlayerTurn
	call CheckLockedIn
	jr nz, .locked_in
	ld a, [wBattlePlayerAction]
	cp $2
	jr z, .reset_rage
	and a
	jr nz, .reset_bide
	xor a
	ld [wMoveSelectionMenuType], a
	inc a ; ld a, ACROBATICS
	ld [wFXAnimIDLo], a
	call MoveSelectionScreen
	push af
	call Call_LoadTempTileMapToTileMap

	ld hl, wBGPals1 palette PAL_BATTLE_BG_PLAYER
	ld de, wBGPals1 palette PAL_BATTLE_BG_TYPE_CAT
	ld bc, 1 palettes
	call FarCopyColorWRAM
	call SetPalettes
	ld a, [wCurPlayerMove]
	inc a ; cp STRUGGLE
	call nz, PlayClickSFX
	ld a, $1
	ldh [hBGMapMode], a
	pop af
	ret nz

.setmovedata
	call SetPlayerTurn
	farcall UpdateMoveData
	xor a
	ld [wPlayerCharging], a

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_RAGE
	jr z, .continue_rage
	ld hl, wPlayerSubStatus4
	res SUBSTATUS_RAGE, [hl]

.continue_rage
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_PROTECT
	jr z, .continue_protect
	cp EFFECT_ENDURE
	jr z, .continue_protect
	xor a
	ld [wPlayerProtectCount], a
	jr .continue_protect

.reset_bide
	; unsure when this is called, but what this used to do was removed to free up
	; SUBSTATUS_BIDE (it fellthrough to locked_in afterwards)
.locked_in
	xor a
	ld [wPlayerProtectCount], a
	ld hl, wPlayerSubStatus4
	res SUBSTATUS_RAGE, [hl]

.continue_protect
	call ParseEnemyAction
	xor a
	ret

.reset_rage
	xor a
	ld [wPlayerProtectCount], a
	ld hl, wPlayerSubStatus4
	res SUBSTATUS_RAGE, [hl]
.lavender_ghost
	xor a
	ret

TryEnemyFlee:
	call EnemyCanFlee
	jr nz, .Stay

	ld a, [wBattleType]
	cp BATTLETYPE_ROAMING
	jr z, .Flee

.Stay:
	xor a
	ld [wEnemyFleeing], a
	ret

.Flee:
	ld a, 1
	ld [wEnemyFleeing], a
	ret

ProcessEnemyFleeing:
	ld a, [wEnemyFleeing]
	and a
	ret z

	call EnemyCanFlee
	jmp z, WildFled_EnemyFled_LinkBattleCanceled

	; enemy failed to flee
	call SetEnemyTurn
	ld hl, BattleText_EnemyCantEscape
	jmp StdBattleTextbox

EnemyCanFlee:
	ld a, [wBattleMode]
	dec a
	ret nz

	call CheckNeutralizingGas
	jr nz, .no_gas
	ld a, [wEnemyAbility]
	cp RUN_AWAY
	jr z, .skip_traps

.no_gas
	call SetEnemyTurn
	call CheckIfUserIsGhostType
	jr z, .skip_traps
	farcall CheckIfTrappedByAbility
	jr nz, .not_ability_trapped
	or 1
	ret

.not_ability_trapped
	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_CANT_RUN, a
	ret nz

	ld a, [wEnemyWrapCount]
	and a
	ret nz

.skip_traps
	ld a, [wEnemyMonStatus]
	and 1 << FRZ | SLP
	ret

CompareMovePriority:
; Compare the priority of the player and enemy's moves.
; Return carry if the player goes first, or z if they match.
	call SetPlayerTurn
	call GetMovePriority
	ld b, a
	call SetEnemyTurn
	call GetMovePriority
	cp b
	ret

GetMovePriority:
; Return the priority of move being used.
	push bc
	push de
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar

	ld hl, MovePriorities
	ld de, 2
	call IsInArray
	inc a
	jr z, .got_priority
	inc hl
	ld a, [hl]
.got_priority
	xor $80 ; treat it as a signed byte
	ld b, a
	call GetTrueUserAbility
	cp PRANKSTER
	jr nz, .no_priority
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp STATUS
	jr nz, .no_priority
	inc b
.no_priority
	ld a, b
	pop de
	pop bc
	ret

INCLUDE "data/moves/priorities.asm"

GetMoveEffect:
	ld a, b
	ld hl, Moves + MOVE_EFFECT
	call GetMoveProperty
	ld b, a
	ret

PerformMove:
	xor a
	ld [wDamageTaken], a
	ld [wDamageTaken + 1], a
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	res SUBSTATUS_IN_ABILITY, [hl]
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	res SUBSTATUS_IN_ABILITY, [hl]
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp DESTINY_BOND
	jr z, .skip_destinybond_reset
	res SUBSTATUS_DESTINY_BOND, [hl]
.skip_destinybond_reset
	call HasUserFainted
	jr z, .end_protect
	farcall DoTurn
.end_protect
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	res SUBSTATUS_IN_ABILITY, [hl]
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	res SUBSTATUS_IN_ABILITY, [hl]

	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVarAddr
	res SUBSTATUS_PROTECT, [hl]
	res SUBSTATUS_ENDURE, [hl]
	call LoadTileMapToTempTileMap
	; fallthrough

ResolveFaints:
; Deal with unresolved faint events, experience, battle loss check, etc.
; Returns carry if battle is over.
	ldh a, [hBattleTurn]
	push af

	; If faint animations hasn't run yet, do that, starting with first faint
	ld a, [wWhichMonFaintedFirst]
	and a
	jr z, .no_fainted_mons
	dec a
	ldh [hBattleTurn], a
	call FaintUserPokemon
	call SwitchTurn
	call FaintUserPokemon
	call SwitchTurn

.no_fainted_mons
	pop af
	ldh [hBattleTurn], a

	call UpdateBattleMonInParty
	call UpdateEnemyMonInParty

	; Play victory music if wildmon fainted and we still have alive mons
	ld a, [wBattleMode]
	dec a
	jr nz, .not_wild

	call HasEnemyFainted
	jr nz, .not_wild

	call CheckPlayerPartyForFitPkmn
	ld a, d
	and a
	call nz, PlayVictoryMusic

.not_wild
	; If enemy has fainted, maybe award experience
	call HasEnemyFainted
	call z, GiveExperience

	; Figure out if any side is out of Pokémon
	call .check_battle_over
	xor a
	ld [wWhichMonFaintedFirst], a
	ld a, [wBattleEnded]
	dec a
	sub 1 ; no-optimize a++|a-- (dec a can't set carry)
	ret

.check_battle_over
	call CheckPlayerPartyForFitPkmn
	ld a, d
	and a
	jr nz, .player_not_out
	call HasEnemyFainted
	jr nz, .lost

	ld a, [wBattleMode]
	dec a
	jr z, .draw
	call CheckEnemyTrainerDefeated
	jr z, .draw

.lost
	ld hl, wBattleResult
	ld a, [hl]
	and $f0
	inc a
	ld [hl], a
	call LostBattle
	scf
	ret

.player_not_out
	call HasEnemyFainted
	ret nz

	ld a, [wBattleMode]
	dec a
	jr z, .won
	call CheckEnemyTrainerDefeated
	jr z, .wontrainer
	xor a
	ret

.won
	ld a, 1
	ld [wBattleEnded], a
	ld a, [wBattleResult]
	and $f0
	ld [wBattleResult], a
	scf
	ret

.draw
	; In-game draws count as losses. Sorry.
	ld a, [wLinkMode]
	and a
	jr nz, .draw2

	ld a, [wInBattleTowerBattle]
	and a
	jr z, .lost

.draw2
	ld a, [wWhichMonFaintedFirst]
	dec a
	jr z, .lost
.wontrainer
	call WinTrainerBattle
	ld a, [wBattleResult]
	and $f0
	ld [wBattleResult], a
	scf
	ret

DeferredSwitch:
; user switches out
	ld hl, wDeferredSwitch
	bit SWITCH_DEFERRED, [hl]
	ret z

ForceDeferredSwitch:
; player switches out due to "switch mode"
	; Check if we can switch out. If we're fainted OR lack alternatives, abort.
	ld hl, wDeferredSwitch
	push hl
	bit SWITCH_TARGET, [hl]
	jr nz, .check_target_alive
	call HasUserFainted
	jr z, .alive_check_done
	farcall CheckAnyOtherAliveMons
	jr .alive_check_done
.check_target_alive
	call HasOpponentFainted
	jr z, .alive_check_done
	farcall CheckAnyOtherAliveOpponentMons
.alive_check_done
	pop hl
	jmp z, .all_done

	; Do item consumption
	bit SWITCH_ITEM, [hl]
	call nz, .consume_item
	bit SWITCH_OPPITEM, [hl]
	jr z, .items_done

	call SwitchTurn
	call .consume_item
	call SwitchTurn

.items_done
	; Figure out which side is switching
	bit SWITCH_TARGET, [hl]
	jr z, .do_switch

	call SwitchTurn
	call .do_switch
	jmp SwitchTurn

.do_switch
	; Clear used move
	push hl
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld [hl], 0
	pop hl

	; Message
	push hl
	bit SWITCH_EXPLICIT, [hl]
	jr z, .no_explicit_withdraw

	; Enemy always uses "Trainer withdrew Pokémon!" Player has several messages.
	ldh a, [hBattleTurn]
	and a
	ld hl, BattleText_EnemyWithdrew
	jr nz, .got_text

	call WithdrawPkmnText
	jr .msg_done

.no_explicit_withdraw
	; For forced switches, say nothing until post-switch
	bit SWITCH_FORCED, [hl]
	jr nz, .msg_done

	ldh a, [hBattleTurn]
	and a
	ld hl, BattleText_WentBackToPlayer
	jr z, .got_text
	ld hl, BattleText_WentBackToEnemy
.got_text
	call StdBattleTextbox

.msg_done
	pop hl

	; Handle Pursuit
	push hl
	bit SWITCH_PURSUIT, [hl]
	call nz, PursuitSwitch

	; If we ended up fainting, abort the switch
	call HasUserFainted
	pop hl
	jr z, .all_done

	; Regenerator, Natural Cure, suppress Neutralizing Gas
	push hl
	farcall RunSwitchAbilities
	call SuppressUserNeutralizingGas
	call UpdateUserInParty
	pop hl

	; Withdraw animation.
	bit SWITCH_BATON_PASS, [hl]
	jr nz, .anim_done

	; This is only set exactly by Teleport, which also lacks animation.
	ld a, [hl]
	cp 1 << SWITCH_DEFERRED
	jr z, .anim_done

	bit SWITCH_FORCED, [hl]
	jr nz, .forced_anim

	xor a
	ld [wNumHits], a
	ld de, ANIM_RETURN_MON
	call Call_PlayBattleAnim
	jr .anim_done

.forced_anim
	call SlideUserPicOut

.anim_done
	; Clear battle UI display
	call ClearSpeechBox

	ldh a, [hBattleTurn]
	and a
	jr nz, .clear_enemy_hud
	farcall ClearPlayerHUD
	jr .hp_clear_done
.clear_enemy_hud
	farcall ClearEnemyHUD
.hp_clear_done

	ld c, 20
	call DelayFrames

	; Endturn switches due to "switch mode" (as opposed to set) skips the rest
	ld a, [wDeferredSwitch]
	bit SWITCH_DEFERRED, a
	jr z, .all_done

	call GetUserSwitchTarget
	call SendInUserPkmn
	ld a, [wDeferredSwitch]
	cp 1 << SWITCH_DEFERRED | 1 << SWITCH_TARGET | 1 << SWITCH_FORCED
	jr nz, .regular_spikes
	call SpikesDamage_CheckMoldBreaker
	jr .done_spikes
.regular_spikes
	call SpikesDamage
.done_spikes
	call RunActivationAbilities

.all_done
	xor a
	ld [wDeferredSwitch], a
	ret

.consume_item
	push hl
	call ItemRecoveryAnim
	farcall GetUserItem
	call GetCurItemName
	ld hl, BattleText_UsersStringBuffer1Activated
	call StdBattleTextbox
	farcall ConsumeUserItem
	pop hl
	ret

GetBothSwitchTarget:
; Forces both user and target to choose who to switch into.
	; Check if both player and enemy already has a switch target.
	ld a, [wPlayerSwitchTarget]
	ld hl, wEnemySwitchTarget
	or [hl]
	jr z, .both_needs_switch

	; only one of these will actually do anything
	call GetUserSwitchTarget
	call SwitchTurn
	call GetUserSwitchTarget
	jmp SwitchTurn

.both_needs_switch
	call GetPlayerSwitchTarget
	jr GetEnemySwitchTarget

GetPlayerSwitchTarget:
; Returns switch target in a
	call LoadStandardMenuHeader
	call SetUpBattlePartyMenu_NoLoop
	call ForcePickSwitchMonInBattle

	call ClearPalettes
	call _LoadBattleFontsHPBar
	call CloseWindow
	call ClearSprites
	ld a, CGB_BATTLE_COLORS
	call GetCGBLayout
	call SetPalettes
	ld a, [wCurPartyMon]
	inc a
	ld [wPlayerSwitchTarget], a
	ld a, [wLinkMode]
	and a
	ld a, 1
	ld [wBattlePlayerAction], a
	call nz, LinkBattleSendReceiveAction
	xor a
	ld [wBattlePlayerAction], a
	ld a, [wPlayerSwitchTarget]
	ret

GetEnemySwitchTarget:
; Returns switch target in a
	ld a, [wLinkMode]
	and a
	jr z, .ai_switch
	; we've already performed LinkBattleSendReceiveAction
	ld a, [wBattleAction]
	sub BATTLEACTION_SWITCH1 - 1 ; -1 to get the switch offset
	jr .done
.ai_switch
	farcall GetSwitchScores
	ld a, [wEnemySwitchMonParam]
	inc a ; switchtarget is 1-indexed
.done
	ld [wEnemySwitchTarget], a
	ret

GetUserSwitchTarget:
; Sets target to switch into if not already set.
; Do not use this for endturn mutual faints, because
; this would allow a malicious client to switch based on
; the opponent's choice.
	ld hl, wDeferredSwitch
	bit SWITCH_FORCED, [hl]
	jr nz, .random_select

	; Check if we've already made a selection.
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerSwitchTarget
	jr z, .got_switch_target
	ld hl, wEnemySwitchTarget
.got_switch_target
	ld a, [hl]
	and a
	ret nz

	; Allow user selection of switch target
	ldh a, [hBattleTurn]
	and a
	jr z, GetPlayerSwitchTarget

.enemy_switch
	ld a, [wLinkMode]
	and a
	call nz, LinkBattleSendReceiveAction
	jr GetEnemySwitchTarget

.random_select
	ldh a, [hBattleTurn]
	and a
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurBattleMon]
	ld c, a
	ld hl, wPartyMon1HP
	jr z, .got_party_vars
	ld a, [wOTPartyCount]
	ld b, a
	ld a, [wCurOTMon]
	ld c, a
	ld hl, wOTPartyMon1HP
.got_party_vars
	call BattleRandom
	and $7
	cp b
	jr nc, .got_party_vars
	cp c
	jr z, .got_party_vars
	push hl
	push af
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	pop de
	pop hl
	jr z, .got_party_vars

	; Got an appropriate target. Select it.
	inc d
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerSwitchTarget
	jr z, .got_switch_target2
	ld hl, wEnemySwitchTarget
.got_switch_target2
	ld [hl], d
	ret

SendInUserPkmn:
; sends in the new pokémon
	; volatile statuses that baton pass doesn't preserve
	call BreakAttraction
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	res SUBSTATUS_ENDURE, [hl]
	res SUBSTATUS_PROTECT, [hl]
	inc hl
	; substatus2
	ld a, 1 << SUBSTATUS_LOCK_ON ; only flag here that should be preserved
	and [hl]
	ld [hli], a
	; substatus3
	ld a, 1 << SUBSTATUS_CONFUSED ; only flag here that should be preserved
	and [hl]
	ld [hli], a
	; substatus4
	ld a, ~(1 << SUBSTATUS_RAGE | 1 << SUBSTATUS_FLINCHED | 1 << SUBSTATUS_CURLED)
	and [hl]
	ld [hl], a

	; Reset Disable and Encore statuses
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerDisableCount
	ld de, wPlayerEncoreCount
	jr z, .got_encore_and_disable
	ld hl, wEnemyDisableCount
	ld de, wEnemyEncoreCount
.got_encore_and_disable
	xor a
	ld [hl], a
	ld [de], a

	ldh a, [hBattleTurn]
	and a
	jr nz, .reset_used_moves_done
	ld hl, wPlayerUsedMoves
rept NUM_MOVES - 1
	ld [hli], a
endr
	ld [hl], a

.reset_used_moves_done
	; for non-baton pass, just reset everything
	ld a, [wDeferredSwitch]
	bit SWITCH_BATON_PASS, a
	jr nz, .volatile_done
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld a, $10
	ld [wTypeModifier], a
	ld bc, NUM_LEVEL_STATS
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerStatLevels
	jr z, .got_stat_levels
	ld hl, wEnemyStatLevels
.got_stat_levels
	ld a, BASE_STAT_LEVEL
	rst ByteFill
	ldh a, [hBattleTurn]
	and a
	jr nz, .new_enemy_mon_status
	call NewBattleMonStatus
	jr .volatile_done
.new_enemy_mon_status
	call NewEnemyMonStatus

.volatile_done
	; Switch active mon
	ldh a, [hBattleTurn]
	and a
	ld de, wPlayerSwitchTarget
	ld hl, wCurBattleMon
	jr z, .got_cur_mon
	ld de, wEnemySwitchTarget
	ld hl, wCurOTMon
.got_cur_mon
	ld a, [de]
	dec a
	ld [hl], a
	ld [wCurPartyMon], a

	ldh a, [hBattleTurn]
	and a
	ld hl, wPartyMon1Species
	jr z, .got_partymon
	ld hl, wOTPartyMon1Species
.got_partymon
	ld a, [wCurPartyMon]
	call GetPartyLocation
	ld de, wBattleMonSpecies
	call GetUserMonAttr_de
	push de
	ld bc, MON_ID - MON_SPECIES
	rst CopyBytes ; copy Species, Item, Moves
	ld bc, MON_DVS - MON_ID
	add hl, bc ; skip ID, Exp, EVs
	ld de, wBattleMonDVs
	call GetUserMonAttr_de
	ld bc, MON_PKRUS - MON_DVS
	rst CopyBytes ; copy DVs, Personality, PP, Happiness
	ld bc, MON_LEVEL - MON_PKRUS
	add hl, bc ; skip PokerusStatus, CaughtData
	ld de, wBattleMonLevel
	call GetUserMonAttr_de
	ld bc, PARTYMON_STRUCT_LENGTH - MON_LEVEL
	rst CopyBytes ; copy Level, Status, Unused, HP, MaxHP, Stats
	pop de

	ldh a, [hBattleTurn]
	and a
	ld hl, wTempBattleMonSpecies
	ld bc, GetBattleMonVariant
	jr z, .got_species_and_form
	ld hl, wTempEnemyMonSpecies
	ld bc, GetEnemyMonVariant
.got_species_and_form
	ld a, [de]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	ld [hl], a
	ld h, b
	ld l, c
	call _hl_ ; sets [wCurForm]

	push de
	call GetBaseData
	ld de, wBattleMonType1
	call GetUserMonAttr_de
	ld hl, wBaseType1
	ld bc, 2
	rst CopyBytes
	pop de

	ldh a, [hBattleTurn]
	and a
	ld hl, wPartyMonNicknames
	jr z, .got_nicknames
	ld hl, wOTPartyMonNicknames
.got_nicknames
	ld a, [wCurPartyMon]
	call SkipNames
	ldh a, [hBattleTurn]
	and a
	ld de, wBattleMonNickname
	jr z, .got_battle_nick
	ld de, wEnemyMonNickname
.got_battle_nick
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_ability
	call ResetPlayerAbility
	jr .done_ability
.enemy_ability
	call ResetEnemyAbility
.done_ability
	; Wild Pokémon are already out
	ldh a, [hBattleTurn]
	and a
	jr z, .sendout_text
	ld a, [wBattleMode]
	dec a
	jr z, .wild

.sendout_text
	; print "Go! X/TRAINER sends out X!"
	ld a, [wDeferredSwitch]
	bit SWITCH_FORCED, a
	call z, UserSentOutText

	ld a, CGB_BATTLE_COLORS
	call GetCGBLayout
	call SetPalettes

.wild
	; For enemy, we need to mark as seen and set base exp unless link/BT
	ldh a, [hBattleTurn]
	and a
	jr z, .enemy_extras_done

	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wEnemyHPAtTimeOfPlayerSwitch], a
	ld a, [hl]
	ld [wEnemyHPAtTimeOfPlayerSwitch + 1], a

	ld a, [wLinkMode]
	and a
	jr nz, .enemy_extras_done
	ld a, [wInBattleTowerBattle]
	and a
	jr nz, .enemy_extras_done

	ld a, [wCurSpecies]
	dec a
	ld c, a
	ld b, SET_FLAG
	ld hl, wPokedexSeen
	predef FlagPredef

	ld a, [wBaseExp]
	ld [wEnemyMonBaseExp], a

	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .skip_unown
	ld a, [wFirstUnownSeen]
	and a
	jr nz, .skip_unown
	ld a, [wCurForm]
	ld [wFirstUnownSeen], a
.skip_unown

	ld a, [wCurPartySpecies]
	cp MAGIKARP
	jr nz, .enemy_extras_done
	ld a, [wFirstMagikarpSeen]
	and a
	jr nz, .enemy_extras_done
	call GetEnemyMonVariant
	ld a, [wCurForm]
	ld [wFirstMagikarpSeen], a

.enemy_extras_done
	; Send-out animation
	ldh a, [hBattleTurn]
	and a
	jr z, .player_sends_out

	; Get rid of pokéball icons for trainers in case it's present
	hlcoord 0, 0
	lb bc, 4, 12
	call ClearBox
	call ClearSprites

	ld a, [wBattleMode]
	dec a
	call nz, Function_SetEnemyPkmnAndSendOutAnimation
	jr .send_out_anim_done
.player_sends_out
	; Get rid of pokéball icons for trainers in case it's present
	call HasEnemyFainted
	jr nz, .send_out_player_mon
	hlcoord 0, 0
	lb bc, 4, 12
	call ClearBox
	call ClearSprites

.send_out_player_mon
	call SendOutPlayerMon
.send_out_anim_done
	; Give a "X was dragged out!" message if applicable
	ld hl, DraggedOutText
	ld a, [wDeferredSwitch]
	bit SWITCH_FORCED, a
	call nz, StdBattleTextbox
	call LoadTileMapToTempTileMap
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerSwitchTarget
	jr z, .got_switch_target

	ld a, [wBattleMode]
	dec a
	call nz, FinalPkmnMusicAndAnimation
	ld hl, wEnemySwitchTarget
.got_switch_target
	ld [hl], 0
	ret

SetParticipant::
; Sets current active mon as participant vs target mon. Preserves registers.
	push hl
	push bc
	push af
	call GetParticipantVar
	ld a, [wCurBattleMon]
	ld c, a

	ld a, 1
	inc c
	rrca
.loop
	rlca
	dec c
	jr nz, .loop

	or [hl]
	ld [hl], a
	pop af
	pop bc
	pop hl
	ret

ResetParticipants::
	push hl
	push bc
	push af
	xor a
	ld hl, wPartyParticipants
	ld bc, PARTY_LENGTH
	rst ByteFill
	pop af
	pop bc
	pop hl
	ret

GetParticipantsIncludingFainted::
; Returns participants, including fainted, vs target mon to a.
	push hl
	push bc
	call GetParticipantVar
	ld a, [hl]
	and $3f
	pop bc
	pop hl
	ret

GetParticipantsNotFainted::
; Returns non-fainted participants vs target mon to a.
	push hl
	push de
	push bc
	call GetParticipantVar
	ld a, [hl]
	and $3f
	ld e, a
	ld a, [wPartyCount]
	ld d, a
	ld a, %11111110
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2HP - (wPartyMon1HP + 1)
.loop
	push af
	ld a, [hli]
	or [hl]
	jr nz, .not_fainted
	pop af
	push af
	and e
	ld e, a
.not_fainted
	pop af
	rlca
	add hl, bc
	dec d
	jr nz, .loop
	ld a, e
	jmp PopBCDEHL

GetParticipantVar::
	ld a, [wCurOTMon]
	ld b, 0
	ld c, a
	ld hl, wPartyParticipants
	add hl, bc
	ret

GetEnemyMonVariant:
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Form
	call GetPartyLocation
	predef_jump GetVariant

GetCurPartyMonVariant:
	ld a, [wCurPartyMon]
	jr _GetPlayerMonVariant

GetBattleMonVariant:
	ld a, [wCurBattleMon]
_GetPlayerMonVariant:
	ld hl, wPartyMon1Form
	call GetPartyLocation
	predef_jump GetVariant

CheckOpponentFullHP:
	call CallOpponentTurn
CheckFullHP:
; check if the user has full HP
; z: yes, nz: no
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP
.got_hp
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	cp b
	ret nz
	ld a, [hl]
	cp c
	ret

StealLeppaBerry:
	farcall GetOpponentItem
	ld a, b
	cp HELD_RESTORE_PP
	ret nz
	call PreparePPRestore
	call GetNonfullPPMove
	ret z
	push bc
	farcall ConsumeOpponentItem
	pop bc
	jr LeppaRestorePP

PreparePPRestore:
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy
	ld hl, wBattleMonMoves
	push hl
	ld hl, wBattleMonPP
	jr .copy

.enemy
	ld hl, wEnemyMonMoves
	push hl
	ld hl, wEnemyMonPP
.copy
	ld de, wTempMonPP
	ld bc, NUM_MOVES
	rst CopyBytes
	pop hl
	ld de, wTempMonMoves
	ld bc, NUM_MOVES
	rst CopyBytes
	ret

GetZeroPPMove:
; Returns z if we didn't find a valid move
	ld bc, 0
	ld d, NUM_MOVES
	ld hl, wTempMonPP
.loop
	ld a, [hli]
	and $3f ; mask out PP ups
	jr z, .got_zero_pp
	inc bc
	dec d
	jr nz, .loop
	ret

.got_zero_pp
	; Did we simply run past our valid moves?
	ld hl, wTempMonMoves
	add hl, bc
	ld a, [hl]
	and a
	ret

GetNonfullPPMove:
; Returns z if we didn't find a move without full PP
	ld a, BOXMON
	ld [wMonType], a
	ld a, [wMenuCursorY]
	push af
	ld bc, 0
	ld d, NUM_MOVES
.loop
	ld hl, wTempMonMoves
	add hl, bc
	ld a, [hl]
	and a
	jr z, .all_moves_full
	ld hl, wTempMonPP
	add hl, bc
	ld e, [hl]
	push bc
	push de
	ld a, c
	inc a
	ld [wMenuCursorY], a
	farcall GetMaxPPOfMove
	pop de
	pop bc
	ld a, [wTempPP]
	cp e
	jr nz, .got_nonfull_pp
	inc bc
	dec d
	jr nz, .loop
.all_moves_full
	pop af
	ld [wMenuCursorY], a
	xor a
	ret

.got_nonfull_pp
	pop af
	ld [wMenuCursorY], a
	or 1
	ret

LeppaRestorePP:
	; Restore up to 10PP of move bc (0-3)
	ld hl, wTempMonPP
	add hl, bc
	ld a, [hl]
	add 10
	ld d, a
	ld a, BOXMON
	ld [wMonType], a
	ld a, [wMenuCursorY]
	push af
	ld a, c
	inc a
	ld [wMenuCursorY], a
	push bc
	push de
	farcall GetMaxPPOfMove
	pop de
	pop bc
	pop af
	ld [wMenuCursorY], a
	ld a, [wTempPP]
	and a
	ret z
	cp d
	jr nc, .got_pp_to_restore
	ld d, a

.got_pp_to_restore
	; d: PP to restore, bc: memory offset of move
	call ItemRecoveryAnim
	push bc
	push de
	ld hl, wTempMonMoves
	add hl, bc
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetMoveName
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	ld bc, MOVE_NAME_LENGTH
	rst CopyBytes
	call GetCurItemName
	ld hl, BattleText_UserRecoveredPPUsing
	call StdBattleTextbox
	pop de
	pop bc

	; restore PP of active battle struct
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonPP
	jr z, .got_battle_pp
	ld hl, wEnemyMonPP
.got_battle_pp
	add hl, bc
	ld [hl], d

	; restore PP of party struct unless transformed
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_TRANSFORMED, a
	ret nz

	ldh a, [hBattleTurn]
	and a
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1PP
	jr z, .set_party_pp
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1PP
.set_party_pp
	push bc
	push de
	call GetPartyLocation
	pop de
	pop bc
.pp_vars_ok
	add hl, bc
	ld [hl], d
	ret

DealDamageToOpponent:
; ONLY runs from attacking damage.
	; If user has more than 50%HP, set Berserk flag. Unset later if we still
	; have more than 50%HP.
	push bc
	call SwitchTurn
	call GetHalfMaxHP
	call CompareHP
	call SwitchTurn
	jr z, .not_over_half
	jr c, .not_over_half
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	set SUBSTATUS_IN_ABILITY, [hl]

.not_over_half
	pop bc
	push de
	ld de, _SubtractHP
	ldh a, [hBattleTurn]
	and a
	push af
	call z, _SubtractHPFromEnemy
	pop af
	call nz, _SubtractHPFromPlayer
	pop de

	; deal with Berserk
	push bc
	call SwitchTurn
	call GetHalfMaxHP
	call CompareHP
	call SwitchTurn
	jr c, .half_or_less
	jr z, .half_or_less

	; We still have more than 50%HP, so remove berserk flag
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	res SUBSTATUS_IN_ABILITY, [hl]
	; fallthrough
.half_or_less
	farcall ResolveOpponentBerserk_CheckMultihit
	call SwitchTurn
	call HandleUserHealingItems
	pop bc
	jmp SwitchTurn

SubtractHPFromOpponent:
	call CallOpponentTurn
SubtractHPFromUser:
	ldh a, [hBattleTurn]
	and a
	jr nz, SubtractHPFromEnemy
	; fallthrough
SubtractHPFromPlayer:
	push de
	ld de, SubtractHP
	call _SubtractHPFromPlayer
	pop de
	ret

_SubtractHPFromPlayer:
	ld hl, wBattleMonMaxHP
	ld a, [hli]
	ld [wBuffer2], a
	ld a, [hl]
	ld [wBuffer1], a
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	push af
	call SetPlayerTurn
	call _de_
	pop af
	ldh [hBattleTurn], a
	ret

SubtractHPFromEnemy:
	push de
	ld de, SubtractHP
	call _SubtractHPFromEnemy
	pop de
	ret

_SubtractHPFromEnemy:
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld [wBuffer2], a
	ld a, [hl]
	ld [wBuffer1], a
	ld hl, wEnemyMonHP
	ldh a, [hBattleTurn]
	push af
	call SetEnemyTurn
	call _de_
	pop af
	ldh [hBattleTurn], a
	ret

SubtractHP:
	call _SubtractHP
	; fallthrough
HandleUserHealingItems:
	call HasUserFainted
	ret z
	push bc
	call HandleHPHealingItem
	call UseHeldStatusHealingItem
	call HandleStatBoostBerry
	call UseConfusionHealingItem
	pop bc
	ret

_SubtractHP:
; Subtracts HP. If HP drops to zero, marks this Pokémon as first fainted mon.
	call .do_subtract
	ld a, [hli]
	or [hl]
	push af
	call UpdateHPBarBattleHuds
	pop af
	ret nz
	ld hl, wWhichMonFaintedFirst
	ld a, [hl]
	and a
	ret nz
	ldh a, [hBattleTurn]
	inc a
	ld [hl], a
	ret

.do_subtract
	inc hl
	ld a, [hl]
	ld [wBuffer3], a
	sub c
	ld [hld], a
	ld [wBuffer5], a
	ld a, [hl]
	ld [wBuffer4], a
	sbc b
	ld [hl], a
	ld [wBuffer6], a
	ret nc

	ld a, [wBuffer3]
	ld [wCurDamage+1], a
	ld c, a
	ld a, [wBuffer4]
	ld [wCurDamage], a
	ld b, a
	xor a
	ld [hli], a
	ld [hld], a
	ld [wBuffer5], a
	ld [wBuffer6], a
	ret

RestoreOpponentHP:
	call CallOpponentTurn
RestoreHP:
	ld hl, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyMonMaxHP
.ok
	ld a, [hli]
	ld [wBuffer2], a
	ld a, [hld]
	ld [wBuffer1], a
	dec hl
	ld a, [hl]
	ld [wBuffer3], a
	add c
	ld [hld], a
	ld [wBuffer5], a
	ld a, [hl]
	ld [wBuffer4], a
	adc b
	ld [hli], a
	ld [wBuffer6], a

	ld a, [wBuffer1]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [wBuffer2]
	ld b, a
	ld a, [hl]
	sbc b
	jr c, UpdateHPBarBattleHuds
	ld a, b
	ld [hli], a
	ld [wBuffer6], a
	ld a, c
	ld [hl], a
	ld [wBuffer5], a
	; fallthrough

UpdateHPBarBattleHuds:
	call UpdateHPBar
	jmp UpdateBattleHuds

UpdateHPBar:
	hlcoord 11, 9
	ldh a, [hBattleTurn]
	and a
	ld a, 1
	jr z, .ok
	hlcoord 1, 2
	xor a
.ok
	push bc
	ld [wWhichHPBar], a
	call BattleAnimateHPBar
	pop bc
	ret

GiveExperience:
	call GetParticipantVar
	bit 7, [hl]
	ret nz
	set 7, [hl]
	; fallthrough

GiveExperiencePointsAfterCatch:
	call GetExpShareParticipants
	ld a, d
	ld [wGivingExperienceToExpShareHolders], a
	call GiveExperiencePoints
	xor a
	ld [wGivingExperienceToExpShareHolders], a
	ret

GetExpShareParticipants:
	ld a, [wPartyCount]
	ld b, a
	ld hl, wPartyMon1
	ld c, 1
	ld d, 0
.loop
	push hl
	push bc
	ld bc, MON_HP
	add hl, bc
	ld a, [hli]
	or [hl]
	pop bc
	pop hl
	jr z, .next

	push hl
	push bc
	ld bc, MON_ITEM
	add hl, bc
	pop bc
	ld a, [hl]
	pop hl

	cp EXP_SHARE
	jr nz, .next
	ld a, d
	or c
	ld d, a

.next
	sla c
	push de
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	pop de
	dec b
	jr nz, .loop

	ld a, d
	ld e, 0
	ld b, PARTY_LENGTH
.loop2
	srl a
	jr nc, .okay
	inc e

.okay
	dec b
	jr nz, .loop2
	ld a, e
	and a
	ret

StopDangerSound:
	xor a
	ld [wLowHealthAlarm], a
	ret

FaintUserPokemon:
	call HasUserFainted
	ret nz

	call BreakAttraction

	xor a
	ld [wPlayerWrapCount], a
	ld [wEnemyWrapCount], a

	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	ld [hl], 0

	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	bit SUBSTATUS_FAINTED, [hl]
	ret nz
	set SUBSTATUS_FAINTED, [hl]

	ld hl, wWhichMonFaintedFirst
	ld a, [hl]
	and a
	ldh a, [hBattleTurn]
	jr nz, .faint_target_chosen
	ld [hl], a
	inc [hl]
.faint_target_chosen
	and a
	push af
	call z, StopDangerSound
	call WaitSFX
	pop af
	ld a, $f0
	jr z, .got_cry_tracks
	swap a
.got_cry_tracks
	ld [wCryTracks], a

	ld hl, wBattleMonSpecies
	call GetUserMonAttr
	ld a, [hl]
	farcall PlaySlowCryA
	ld de, SFX_KINESIS
	call PlaySFX

	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_faint
	call PlayerMonFaintedAnimation

	; unless enemy also fainted, reduce happiness
	call HasEnemyFainted
	call nz, PlayerMonFaintHappinessMod

	farcall ClearPlayerHUD
	jr .done
.enemy_faint
	call EnemyMonFaintedAnimation
	farcall ClearEnemyHUD
.done
	ld de, SFX_FAINT
	call PlaySFX
	call LoadTileMapToTempTileMap
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_IN_LOOP, [hl]

	ld hl, BattleText_PkmnFainted
	ldh a, [hBattleTurn]
	and a
	jr z, .text
	ld hl, BattleText_EnemyPkmnFainted
.text
	call StdBattleTextbox
	call LoadTileMapToTempTileMap

SuppressUserNeutralizingGas:
; Use -1 as sentinel, not 0. This is because Transform (via Imposter) should
; regain Neutralizing Gas in case it procs.
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVarAddr
	ld a, [hl]
	cp NEUTRALIZING_GAS
	ret nz
	ld [hl], -1

	; Unless opponent also has Neutralizing Gas or Unnerve, (re-)run its
	; activation abilities. Yes, this means that it might run more than once.
	call GetOpponentAbility
	cp NEUTRALIZING_GAS
	ret z
	cp UNNERVE
	ret z
	call SwitchTurn
	call RunActivationAbilities
	jmp SwitchTurn

CheckEnemyTrainerDefeated:
	ld a, [wOTPartyCount]
	ld b, a
	xor a
	ld hl, wOTPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH

.loop
	or [hl]
	inc hl
	or [hl]
	dec hl
	add hl, de
	dec b
	jr nz, .loop

	and a
	ret

WinTrainerBattle:
; Player won the battle
	call StopDangerSound
	ld a, $1
	ld [wBattleLowHealthAlarm], a
	ld [wBattleEnded], a
	ld a, [wLinkMode]
	and a
	ld a, b
	call z, PlayVictoryMusic
	farcall Battle_GetTrainerName

	ld hl, BattleText_EnemyWereDefeated
	call CheckPluralTrainer
	jr nz, .PlaceBattleEndText
	ld hl, BattleText_EnemyWasDefeated

.PlaceBattleEndText
	call StdBattleTextbox

	ld a, [wLinkMode]
	and a
	ret nz

	call BattleWinSlideInEnemyTrainerFrontpic
	ld c, 40
	call DelayFrames

	ld a, [wInBattleTowerBattle]
	and a
	jr z, .not_battle_tower

	call EmptyBattleTextbox
	ld c, $3
	farcall BattleTowerText
	call WaitPressAorB_BlinkCursor
	ld hl, wPayDayMoney
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	ret nz
	call ClearTileMap
	jmp ClearBGPalettes

.not_battle_tower
	ld a, [wBattleType]
	cp BATTLETYPE_CANLOSE
	jr nz, .skip_heal
	farcall HealParty
.skip_heal
	ld a, [wMonStatusFlags]
	bit 0, a
	call z, PrintWinLossText

	ld a, [wAmuletCoin]
	and a
	call nz, .DoubleReward
	call .CheckMaxedOutMomMoney
	push af
	ld a, 0
	jr nc, .okay
	ld a, [wMomSavingMoney]
	and $7
	cp $3
	jr nz, .okay
	inc a

.okay
	ld b, a
	ld c, $4
.loop
	ld a, b
	and a
	jr z, .loop2
	call .SendMoneyToMom
	dec c
	dec b
	jr .loop

.loop2
	ld a, c
	and a
	jr z, .done
	call .AddMoneyToWallet
	dec c
	jr .loop2

.done
	call .DoubleReward
	call .DoubleReward
	pop af
	jr nc, .KeepItAll
	ld a, [wMomSavingMoney]
	and $7
	jr z, .KeepItAll
	ld hl, .SentToMomTexts
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp StdBattleTextbox

.KeepItAll:
	ld hl, GotMoneyForWinningText
	jmp StdBattleTextbox

.SendMoneyToMom:
	push bc
	ld hl, wBattleReward + 2
	ld de, wMomsMoney + 2
	call AddBattleMoneyToAccount
	pop bc
	ret

.AddMoneyToWallet:
	push bc
	ld hl, wBattleReward + 2
	ld de, wMoney + 2
	call AddBattleMoneyToAccount
	pop bc
	ret

.DoubleReward:
	ld hl, wBattleReward + 2
	sla [hl]
	dec hl
	rl [hl]
	dec hl
	rl [hl]
	ret nc
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

.SentToMomTexts: ; these are all used with StdBattleTextbox
	dw SentSomeToMomText ; far-ok
	dw SentHalfToMomText ; far-ok
	dw SentAllToMomText ; far-ok

.CheckMaxedOutMomMoney:
	ld hl, wMomsMoney + 2
	ld a, [hld]
	cp LOW(9999999)
	ld a, [hld]
	sbc LOW(9999999 / $100)
	ld a, [hl]
	sbc LOW(9999999 / $10000)
	ret

AddBattleMoneyToAccount:
	ld c, $3
	and a
	push de
.loop
	ld a, [de]
	adc [hl]
	ld [de], a
	dec de
	dec hl
	dec c
	jr nz, .loop
	pop hl
	ld a, [hld]
	cp LOW(9999999)
	ld a, [hld]
	sbc LOW(9999999 / $100)
	ld a, [hl]
	sbc LOW(9999999 / $10000)
	ret c
	ld a, LOW(9999999 / $10000)
	ld [hli], a
	ld a, LOW(9999999 / $100)
	ld [hli], a
	ld [hl], LOW(9999999)
	ret

PlayVictoryMusic:
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_WILD_VICTORY
	ld a, [wBattleMode]
	dec a
	jr nz, .trainer_victory
	ld hl, wPayDayMoney
	ld a, [hli]
	or [hl]
	jr nz, .play_music
	push de
	push bc
	call CheckPlayerPartyForFitPkmn
	ld a, d
	and a
	pop bc
	pop de
	jr z, .lost
	jr .play_music

.trainer_victory
	ld de, MUSIC_GYM_VICTORY
	call IsBossTrainer
	jr c, .play_music
	ld de, MUSIC_TRAINER_VICTORY

.play_music
	call PlayMusic

.lost
	pop de
	ret

; These functions check if the current opponent is a gym leader or one of a
; few other special trainers.

; Note: KantoGymLeaders is a subset of JohtoGymLeaders. If you wish to
; differentiate between the two, call IsKantoGymLeader first.

IsKantoGymLeader:
	ld hl, KantoGymLeaders
	jr IsBossTrainerCommon

IsJohtoGymLeader:
	ld hl, JohtoGymLeaders
	jr IsBossTrainerCommon

IsBossTrainer:
	ld hl, BossTrainers
IsBossTrainerCommon:
	push de
	ld a, [wOtherTrainerClass]
	call IsInByteArray
	pop de
	ret

INCLUDE "data/trainers/leaders.asm"

PlayerMonFaintHappinessMod:
	ld hl, wEnemySubStatus3
	res SUBSTATUS_IN_LOOP, [hl]
	xor a
	ld [wLowHealthAlarm], a
	ld [wBattleMonStatus], a
	call UpdateBattleMonInParty
	ld c, HAPPINESS_FAINTED
	; If TheirLevel > (YourLevel + 30), use a different parameter
	ld a, [wBattleMonLevel]
	add 30
	ld b, a
	ld a, [wEnemyMonLevel]
	cp b
	jr c, .got_param
	ld c, HAPPINESS_BEATENBYSTRONGFOE

.got_param
	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	predef_jump ChangeHappiness

AskUseNextPokemon:
	call EmptyBattleTextbox
	call LoadTileMapToTempTileMap
; We don't need to be here if we're in a Trainer battle,
; as that decision is made for us.
	ld a, [wBattleMode]
	dec a
	ret nz

	ld hl, BattleText_UseNextMon
	call StdBattleTextbox
.loop
	call YesNoBox
	ld a, [wMenuCursorY]
	jr c, .pressed_b
	and a
	ret

.pressed_b
	ld a, [wMenuCursorY]
	cp $1 ; YES
	jr z, .loop
	jmp CheckRunSpeed

SetUpBattlePartyMenu_NoLoop:
	call ClearBGPalettes
SetUpBattlePartyMenu: ; switch to fullscreen menu?
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farjp InitPartyMenuGFX

JumpToPartyMenuAndPrintText:
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call ApplyTilemapInVBlank
	call SetPalettes
	jmp DelayFrame

SelectBattleMon:
	farjp PartyMenuSelect

PickPartyMonInBattle:
.loop
	ld a, $2 ; Which PKMN?
	ld [wPartyMenuActionText], a
	call JumpToPartyMenuAndPrintText
	call SelectBattleMon
	ret c
	call CheckIfCurPartyMonIsFitToFight
	jr z, .loop
	xor a
	ret

SwitchMonAlreadyOut:
	ld hl, wCurBattleMon
	ld a, [wCurPartyMon]
	cp [hl]
	jr nz, .notout

	ld hl, BattleText_PkmnIsAlreadyOut
	call StdBattleTextbox
	scf
	ret

.notout
	xor a
	ret

ForcePickPartyMonInBattle:
; Can't back out.
.pick
	call PickPartyMonInBattle
	ret nc

	ld de, SFX_WRONG
	call PlaySFX
	call WaitSFX
	jr .pick

PickSwitchMonInBattle:
.pick
	call PickPartyMonInBattle
	ret c
	call SwitchMonAlreadyOut
	jr c, .pick
	xor a
	ret

ForcePickSwitchMonInBattle:
; Can't back out.
.pick
	call ForcePickPartyMonInBattle
	call SwitchMonAlreadyOut
	jr c, .pick

	xor a
	ret

LostBattle:
	ld a, 1
	ld [wBattleEnded], a

	ld a, [wInBattleTowerBattle]
	and a
	jr nz, .battle_tower

	ld hl, wLossTextPointer
	ld a, [hli]
	ld h, [hl]
	and h
	jr z, .no_loss_text

	; wild battles have no loss text
	ld a, [wBattleMode]
	dec a
	jr z, .no_loss_text

; Remove the enemy from the screen.
	hlcoord 0, 0
	lb bc, 8, 21
	call ClearBox
	call BattleWinSlideInEnemyTrainerFrontpic

	ld c, 40
	call DelayFrames

	ld a, [wMonStatusFlags]
	bit 0, a
	call z, PrintWinLossText

	ld a, [wBattleType]
	cp BATTLETYPE_CANLOSE
	ret z
	jr .no_loss_text

.battle_tower
; Remove the enemy from the screen.
	hlcoord 0, 0
	lb bc, 8, 21
	call ClearBox
	call BattleWinSlideInEnemyTrainerFrontpic

	ld c, 40
	call DelayFrames

	call EmptyBattleTextbox
	ld c, 2
	farcall BattleTowerText
	call WaitPressAorB_BlinkCursor
	call ClearTileMap
	jmp ClearBGPalettes

.no_loss_text
	ld a, [wLinkMode]
	and a
	jr nz, .LostLinkBattle

; Greyscale
	ld a, CGB_BATTLE_GRAYSCALE
	call GetCGBLayout
	call SetPalettes
	jr .end

.LostLinkBattle:
	call UpdateEnemyMonInParty
	call CheckEnemyTrainerDefeated
	jr nz, .not_tied
	ld hl, TiedAgainstText
	ld a, [wBattleResult]
	and $c0
	add 2
	ld [wBattleResult], a
	jr .text

.not_tied
	ld hl, LostAgainstText

.text
	call StdBattleTextbox

.end
	scf
	ret

EnemyMonFaintedAnimation:
	hlcoord 12, 5
	decoord 12, 6
	jr MonFaintedAnimation

PlayerMonFaintedAnimation:
	hlcoord 1, 10
	decoord 1, 11
	; fallthrough

MonFaintedAnimation:
	ld a, [wInputFlags]
	push af
	set 6, a
	ld [wInputFlags], a
	ld b, 7

.OuterLoop:
	push bc
	push de
	push hl
	ld b, 6

.InnerLoop:
	push bc
	push hl
	push de
	ld bc, 7
	rst CopyBytes
	pop de
	pop hl
	ld bc, -SCREEN_WIDTH
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	dec b
	jr nz, .InnerLoop

	ld bc, 20
	add hl, bc
	ld de, .Spaces
	rst PlaceString
	call ApplyTilemapInVBlank
	pop hl
	pop de
	pop bc
	dec b
	jr nz, .OuterLoop

	pop af
	ld [wInputFlags], a
	ret

.Spaces:
	db "       @"

SlideUserPicOut:
	ldh a, [hBattleTurn]
	and a
	jr nz, SlideEnemyPicOut
	; fallthrough
SlidePlayerPicOut:
	hlcoord 1, 5
	ld a, 9
	jr SlideBattlePicOut
SlideEnemyPicOut:
	hlcoord 18, 0
	ld a, 8
	; fallthrough
SlideBattlePicOut:
	ldh [hMapObjectIndexBuffer], a
	ld c, a
.loop
	push bc
	push hl
	ld b, $7
.loop2
	push hl
	call .DoFrame
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .loop2
	ld c, 2
	call DelayFrames
	pop hl
	pop bc
	dec c
	jr nz, .loop
	ret

.DoFrame:
	ldh a, [hMapObjectIndexBuffer]
	ld c, a
	cp $8
	jr nz, .back
.forward
	ld a, [hli]
	ld [hld], a
	dec hl
	dec c
	jr nz, .forward
	ret

.back
	ld a, [hld]
	ld [hli], a
	inc hl
	dec c
	jr nz, .back
	ret

FinalPkmnMusicAndAnimation:
	; if this is not a link battle...
	ld a, [wLinkMode]
	and a
	ret nz
	; ...and this trainer has final text...
	farcall GetFinalPkmnTextPointer
	ret nc
	; ...and this is their last Pokémon...
	farcall CheckAnyOtherAliveEnemyMons
	ret nz
	; ...then hide the Pokémon...
	call EmptyBattleTextbox
	ld c, 20
	call DelayFrames
	call SlideEnemyPicOut
	; ...play the final Pokémon music...
	call IsJohtoGymLeader
	jr nc, .no_music
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_FINAL_POKEMON_BW
	call PlayMusic
	pop de
.no_music
	; ...show their sprite and final dialog...
	ld a, [wTempEnemyMonSpecies]
	push af
	call BattleWinSlideInEnemyTrainerFrontpic
	farcall GetFinalPkmnTextPointer
	call StdBattleTextbox
	pop af
	ld [wTempEnemyMonSpecies], a
	; ...and return the Pokémon
	call EmptyBattleTextbox
	call ApplyTilemapInVBlank
	call SlideEnemyPicOut
	ld c, 10
	call DelayFrames
	jmp FinalPkmnSlideInEnemyMonFrontpic

OfferSwitch:
	farcall EnemySwitch_TrainerHud

	; Copy target mon's nickname into active enemy mon nickname
	ld hl, wOTPartyMonNicknames
	ld a, [wEnemySwitchTarget]
	dec a
	call SkipNames
	ld de, wEnemyMonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	; Actually print the message
	ld a, [wOptions2]
	bit BATTLE_PREDICT, a
	jr nz, .predict
	ld hl, BattleText_EnemyAreAboutToUseWillPlayerSwitchPkmn
	call CheckPluralTrainer
	jr nz, .PlaceBattleChangeText
	ld hl, BattleText_EnemyIsAboutToUseWillPlayerSwitchPkmn
	jr .PlaceBattleChangeText
.predict
	ld hl, BattleText_EnemyAreAboutToSwitchWillPlayerSwitchPkmn
	call CheckPluralTrainer
	jr nz, .PlaceBattleChangeText
	ld hl, BattleText_EnemyIsAboutToSwitchWillPlayerSwitchPkmn

.PlaceBattleChangeText
	call StdBattleTextbox
	call YesNoBox
	ld a, [wMenuCursorY]
	dec a
	jr nz, .said_no
	call SetUpBattlePartyMenu_NoLoop
	call PickSwitchMonInBattle

	push af
	call ClearPalettes
	call ClearSprites
	call _LoadStatusIcons
	call DelayFrame
	call GetMemCGBLayout
	call SetPalettes
	call Call_LoadTempTileMapToTileMap
	pop af
	jr c, OfferSwitch

	; Player chose to switch. Force an explicit switch-out.
	ld a, [wCurPartyMon]
	inc a
	ld [wPlayerSwitchTarget], a

	ld a, 1 << SWITCH_EXPLICIT
	ld [wDeferredSwitch], a
	call SetPlayerTurn
	jmp ForceDeferredSwitch

.said_no
	ld [wCurPartyMon], a
	scf
	ret

Function_SetEnemyPkmnAndSendOutAnimation:
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetEnemyMonVariant
	call GetBaseData
	ld a, OTPARTYMON
	ld [wMonType], a
	predef CopyPkmnToTempMon
	call GetMonFrontpic

	xor a
	ld [wNumHits], a
	ld [wBattleAnimParam], a
	call SetEnemyTurn
	ld de, ANIM_SEND_OUT_MON
	call Call_PlayBattleAnim

	call BattleCheckEnemyShininess
	jr nc, .not_shiny
	ld a, 1 ; shiny anim
	ld [wBattleAnimParam], a
	ld de, ANIM_SEND_OUT_MON
	call Call_PlayBattleAnim
.not_shiny

	ld bc, wTempMonSpecies
	farcall CheckFaintedFrzSlp
	jr c, .skip_cry
	farcall CheckBattleEffects
	jr c, .cry_no_anim
	hlcoord 12, 0
	lb de, $0, ANIM_MON_SLOW
	predef AnimateFrontpic
	jr .skip_cry

.cry_no_anim
	ld a, $f
	ld [wCryTracks], a
	ld a, [wTempEnemyMonSpecies]
	call PlayStereoCry

.skip_cry
	call UpdateEnemyHUD
	ld a, $1
	ldh [hBGMapMode], a
	ret

NewEnemyMonStatus:
	xor a
	ld [wEnemySelectedMove], a
	ld [wLastPlayerCounterMove], a
	ld [wLastEnemyCounterMove], a
	ld [wLastEnemyMove], a
	ld hl, wEnemySubStatus1
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wEnemyDisableCount], a
	ld [wEnemyEncoreCount], a
	ld [wEnemyProtectCount], a
	ld [wEnemyToxicCount], a
	ld [wEnemyPerishCount], a
	ld [wPlayerWrapCount], a
	ld [wEnemyWrapCount], a
	ld [wEnemyTurnsTaken], a
	ld hl, wPlayerSubStatus2
	res SUBSTATUS_CANT_RUN, [hl]
	; fallthrough

ResetEnemyAbility:
	push hl
	ld hl, wEnemyMonPersonality
	ld a, [wEnemyMonSpecies]
	ld c, a
	call GetAbility
	pop hl
	ld a, b
	ld [wEnemyAbility], a
	xor a
	ret

ResetPlayerAbility:
	push hl
	ld hl, wBattleMonPersonality
	ld a, [wBattleMonSpecies]
	ld c, a
	call GetAbility
	pop hl
	ld a, b
	ld [wPlayerAbility], a
	xor a
	ret

CheckPlayerPartyForFitPkmn:
; Has the player any Pkmn in his Party that can fight?
	ld a, [wPartyCount]
	ld e, a
	xor a
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2 - (wPartyMon1 + 1)
.loop
	or [hl]
	inc hl
	or [hl]
	add hl, bc
	dec e
	jr nz, .loop
	ld d, a
	ret

CheckIfCurPartyMonIsFitToFight:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	ret nz

	ld a, [wTotalBattleTurns]
	and a
	jr z, .finish_fail

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1IsEgg
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	and IS_EGG_MASK
	ld hl, BattleText_AnEGGCantBattle
	jr nz, .print_textbox

	ld hl, BattleText_TheresNoWillToBattle

.print_textbox
	call StdBattleTextbox

.finish_fail
	xor a
	ret

BattleCheckPlayerShininess:
	call GetPartyMonPersonality
	jr BattleCheckShininess

BattleCheckEnemyShininess:
	call GetEnemyMonPersonality

BattleCheckShininess:
	ld b, h
	ld c, l
	farjp CheckShininess

GetPartyMonDVs:
	ld hl, wPartyMon1DVs
	ld a, [wCurBattleMon]
	jmp GetPartyLocation

GetEnemyMonDVs:
	ld hl, wOTPartyMon1DVs
	ld a, [wCurOTMon]
	jmp GetPartyLocation

GetPartyMonPersonality:
	ld hl, wPartyMon1Personality
	ld a, [wCurBattleMon]
	jmp GetPartyLocation

GetEnemyMonPersonality:
	ld hl, wOTPartyMon1Personality
	ld a, [wCurOTMon]
	jmp GetPartyLocation

SendOutPlayerMon:
	call GetBattleMonVariant
	hlcoord 1, 5
	lb bc, 7, 8
	call ClearBox
	call ApplyTilemapInVBlank
	xor a
	ldh [hBGMapMode], a
	call GetMonBackpic
	xor a
	ldh [hGraphicStartTile], a
	ld [wBattleMenuCursorBuffer], a
	ld [wCurMoveNum], a
	ld [wPlayerMoveStruct + MOVE_ANIM], a
	ld [wPlayerSelectedMove], a
	ld [wLastPlayerCounterMove], a
	ld [wLastEnemyCounterMove], a
	ld [wLastPlayerMove], a
	call CheckAmuletCoin
	call FinishBattleAnim
	xor a
	ld [wEnemyWrapCount], a
	call SetPlayerTurn
	xor a
	ld [wNumHits], a
	ld [wBattleAnimParam], a
	ld de, ANIM_SEND_OUT_MON
	call Call_PlayBattleAnim
	call BattleCheckPlayerShininess
	jr nc, .not_shiny
	ld a, 1
	ld [wBattleAnimParam], a
	ld de, ANIM_SEND_OUT_MON
	call Call_PlayBattleAnim

.not_shiny
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld b, h
	ld c, l
	farcall CheckFaintedFrzSlp
	jr c, .statused
	ld a, $f0
	ld [wCryTracks], a
	ld a, [wCurPartySpecies]
	call PlayStereoCry

.statused
	call UpdatePlayerHUD
	ld a, $1
	ldh [hBGMapMode], a
	ret

NewBattleMonStatus:
	xor a
	ld [wPlayerSelectedMove], a
	ld [wLastPlayerCounterMove], a
	ld [wLastEnemyCounterMove], a
	ld [wLastPlayerMove], a
	ld hl, wPlayerSubStatus1
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, wPlayerUsedMoves
rept NUM_MOVES - 1
	ld [hli], a
endr
	ld [hl], a
	ld [wPlayerDisableCount], a
	ld [wPlayerEncoreCount], a
	ld [wPlayerProtectCount], a
	ld [wPlayerToxicCount], a
	ld [wPlayerPerishCount], a
	ld [wEnemyWrapCount], a
	ld [wPlayerWrapCount], a
	ld [wPlayerTurnsTaken], a
	ld hl, wEnemySubStatus2
	res SUBSTATUS_CANT_RUN, [hl]
	jmp ResetPlayerAbility

BreakAttraction:
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_IN_LOVE, [hl]
	ld hl, wEnemySubStatus1
	res SUBSTATUS_IN_LOVE, [hl]
	ret

SpikesDamageBoth:
; for the first mon, Spikes logic doesn't run by itself, and we also want to perform
; speed checks to see whose air balloon to announce first.
	ldh a, [hBattleTurn]
	push af
	call SetFastestTurn
	call SpikesDamage
	call SwitchTurn
	call SpikesDamage
	pop af
	ldh [hBattleTurn], a
	ret

PostBattleTasks::
; Tasks that run unconditionally after battle.
; Some things (like Pickup) are seperate since black-out bypasses it.
	push bc
	push de
	call RestoreBattleItems
	ld a, [wPartyCount]
	and a
	jr z, .no_party
.loop
	dec a
	push af
	ld [wCurPartyMon], a
	farcall UpdatePkmnStats
	ld a, MON_STATUS
	call GetPartyParamLocation
	res TOX, [hl]
	pop af
	jr nz, .loop
.no_party
	pop de
	pop bc
	ret

RunBothActivationAbilities:
; runs both pokémon's activation abilities (Intimidate, etc.).
; The faster Pokémon activates abilities first. This mostly
; just matter for weather abilities.
	; Only show Neutralizing Gas message once.
	call GetTrueUserAbility
	cp NEUTRALIZING_GAS
	jr nz, .no_double_gas
	call GetOpponentAbility
	cp NEUTRALIZING_GAS
	jr nz, .no_double_gas
	ldh a, [hBattleTurn]
	push af
	call SetFastestTurn
	jr .single_run

.no_double_gas
	ldh a, [hBattleTurn]
	push af
	call SetFastestTurn
	farcall RunActivationAbilitiesInner
	call SwitchTurn
.single_run
	farcall RunActivationAbilitiesInner
	pop af
	ldh [hBattleTurn], a
	ret

RunActivationAbilities:
; Trace will, on failure, copy a later switched in Pokémon's
; Ability. To handle this correctly without redundancy except
; on double switch-ins or similar, we need to do some extra
; handling around it.
	farcall RunActivationAbilitiesInner
	call HasUserFainted
	call nz, HasOpponentFainted
	ret z

	call GetTrueUserAbility
	cp TRACE
	ret z ; trace failed, so don't check opponent trace
	call GetOpponentAbility
	cp TRACE
	ret nz
	; invert whose turn it is to properly handle abilities.
	call SwitchTurn
	farcall RunActivationAbilitiesInner
	jmp SwitchTurn

SpikesDamage_CheckMoldBreaker:
; Called when a Pokémon with Mold Breaker uses Roar/Whirlwind.
; This is neccessary because it negates Levitate (but not Magic Guard for some reason),
; but can't be checked unconditionally since other kind of switches ignore MB as usual.
	call SwitchTurn
	call GetOpponentAbilityAfterMoldBreaker
	ld b, a
	call SwitchTurn
	ld c, 1
	jr SpikesDamage_GotAbility
SpikesDamage:
	call GetTrueUserAbility
	ld b, a
	ld c, 0
SpikesDamage_GotAbility:
; Input: b: ability, c: 1 if forced out, 0 otherwise
	push bc
	call SetParticipant
	call HandleAirBalloon
	pop bc
	ret z

	push bc
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_HEAVY_BOOTS
	pop bc
	ret z
	cp HELD_IRON_BALL
	jr z, .iron_ball

	ld a, b
	cp LEVITATE
	ret z

	; Flying-types aren't affected by Spikes.
	push bc
	call CheckIfUserIsFlyingType
	pop bc
	ret z

.iron_ball
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerHazards
	jr z, .ok
	ld hl, wEnemyHazards
.ok
	push hl
	call .Spikes
	pop hl
	jr .ToxicSpikes

.Spikes:
	ld a, b
	cp MAGIC_GUARD
	ret z

	ld a, [hl]
	and HAZARDS_SPIKES
	ret z

	ld hl, GetEighthMaxHP
	sub HAZARDS_SPIKES / 3
	jr z, .got_hp
	ld hl, GetSixthMaxHP
	sub HAZARDS_SPIKES / 3
	jr z, .got_hp
	ld hl, GetQuarterMaxHP
.got_hp
	call _hl_
	predef SubtractHPFromUser
	call UpdateUserInParty

	ld hl, BattleText_UserHurtBySpikes
	jmp StdBattleTextbox

.ToxicSpikes:
	ld a, [hl]
	and HAZARDS_TOXIC_SPIKES
	ret z

	push af
	push bc
	push hl
	call CheckIfUserIsPoisonType
	pop hl
	pop bc
	jr nz, .no_poison_type
	pop af

	; Grounded Poison types absorb the Toxic Spikes
	xor [hl]
	ld [hl], a
	ret

.no_poison_type
	pop af
	push bc
	push hl
	call SwitchTurn
	ld b, c
	farcall CanPoisonTarget
	push af
	call SwitchTurn
	pop af
	pop hl
	pop bc
	ret nz

	ld a, [hl]
	and HAZARDS_TOXIC_SPIKES
	cp (HAZARDS_TOXIC_SPIKES / 3) * 2
	ld a, 1 << PSN
	ld hl, WasPoisonedText
	jr nz, .no_toxic
	or 1 << TOX
	ld hl, BadlyPoisonedText
.no_toxic
	push bc
	push hl
	push af
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	pop af
	ld [hl], a
	ld de, ANIM_PSN
	call Call_PlayBattleAnim
	call RefreshBattleHuds
	pop hl

	call SwitchTurn
	call StdBattleTextbox
	pop bc
	ld a, c
	and a
	jr z, .no_synchronize
	farcall PostStatusWithSynchronize
	jr .poststatus_done
.no_synchronize
	farcall PostStatus
.poststatus_done
	jmp SwitchTurn

HandleAirBalloon:
; prints air balloon msg and returns z if we have air balloon
	farcall GetUserItem
	ld a, b
	cp HELD_AIR_BALLOON
	ret nz
	call GetCurItemName
	ld hl, NotifyAirBalloonText
	call StdBattleTextbox
	xor a
	ret

PursuitSwitch:
	call CallOpponentTurn
.Function:
	farcall CheckOpponentWentFirst
	ret z

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld b, a
	call GetMoveEffect
	ld a, b
	cp EFFECT_PURSUIT
	ret nz
	call PerformMove
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld [hl], 0
	ret

StealDefendHitBerry:
; treat it as a stat boost berry
	farcall GetOpponentItem
	ld a, b
	cp HELD_DEFEND_HIT
	ret nz
	ld a, HELD_RAISE_STAT
	ld b, a
	ld a, c
	cp PHYSICAL
	ld a, DEFENSE
	jr z, .got_stat
	ld a, SP_DEFENSE
.got_stat
	ld c, a
	jr DoStealStatBoostBerry

StealStatBoostBerry:
	farcall GetOpponentItem
DoStealStatBoostBerry:
	call _HeldStatBoostBerry
	ret nz
	farjp ConsumeOpponentItem

QuarterPinchOrGluttony::
; Returns z if we're in a 1/4-HP pinch or if we have Gluttony
	call GetQuarterMaxHP
	call GetTrueUserAbility
	cp GLUTTONY
	call z, GetHalfMaxHP
	call CompareHP
	ret nc
	xor a
	ret

HandleStatBoostBerry:
	call QuarterPinchOrGluttony
	ret nz
	predef GetUserItemAfterUnnerve
	call _HeldStatBoostBerry
	ret nz
	farjp ConsumeUserItem

_HeldStatBoostBerry:
	ld a, b
	ld b, c
	cp HELD_RAISE_STAT
	jr z, .raise_stat
	cp HELD_RAISE_CRIT
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS4
	push hl
	call GetBattleVarAddr
	bit SUBSTATUS_FOCUS_ENERGY, [hl]
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	pop hl
	ret nz
	call ItemRecoveryAnim
	call GetCurItemName
	ld hl, BattleText_ItemRaisedCrit
	call StdBattleTextbox
	xor a
	ret

.raise_stat
	ld a, b
	and $f
	cp MULTIPLE_STATS
	jr nz, .got_stat

	farcall GetCappedStats
	farcall SelectRandomRaiseStat
	jr z, .failed
	ld a, $10
	or e
	ld b, a

.got_stat
	ld a, STAT_SKIPTEXT | STAT_SILENT
	farcall _ForceRaiseStat
	ld a, [wFailedMessage]
	and a
	ret nz
	farcall UseStatItemText
	xor a
	ret
.failed
	ld [wAttackMissed], a
	or 1
	ret

StealHPHealingItem:
; treat Enigma Berry as a HP-recovery berry
	call CheckFullHP
	ret z
	farcall GetOpponentItem
	ld a, b
	cp HELD_ENIGMA_BERRY
	jr nz, .continue
	ld b, HELD_BERRY
.continue
	call _HeldHPHealingItem
	ret nz
StealBattleItem:
	call RefreshBattleHuds
	farcall GetOpponentItem
	call GetCurItemName
	ld hl, RecoveredUsingText
	call StdBattleTextbox
	farjp ConsumeOpponentItem

HandleHPHealingItem:
	; only restore HP if HP<=1/2
	call GetHalfMaxHP
	call CompareHP
	jr z, .ok
	ret nc
.ok
	predef GetUserItemAfterUnnerve
	ld a, [hl]
	cp FIGY_BERRY
	jr nz, .figy_ok

	call QuarterPinchOrGluttony
	ret nz
.figy_ok
	predef GetUserItemAfterUnnerve
	call _HeldHPHealingItem
	ret nz
UseBattleItem:
	call RefreshBattleHuds
	farcall GetUserItem
	call GetCurItemName
	ld hl, RecoveredUsingText
	call StdBattleTextbox
	farjp ConsumeUserItem

_HeldHPHealingItem:
	ld a, b
	cp HELD_BERRY
	ret nz
	ld b, 0 ; bc contains HP to restore unless Figy or Sitrus
	ld a, [hl]
	; for Bug Bite, treat Enigma Berry as Sitrus Berry
	cp ENIGMA_BERRY
	jr z, .quarter_maxhp
	cp SITRUS_BERRY
	jr z, .quarter_maxhp
	cp FIGY_BERRY
	call z, GetThirdMaxHP
	jr .got_hp_to_restore

.quarter_maxhp
	call GetQuarterMaxHP
.got_hp_to_restore
	call ItemRecoveryAnim
	call RestoreHP
	xor a
	ret

ItemRecoveryAnim::
	push hl
	push de
	push bc
	call EmptyBattleTextbox
	ld a, RECOVER
	ld [wFXAnimIDLo], a
	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	predef PlayBattleAnim
	jmp PopBCDEHL

StealHeldStatusHealingItem:
	farcall GetOpponentItem
	call _HeldStatusHealingItem
	ret z
	jmp StealBattleItem

UseOpponentHeldStatusHealingItem:
	call CallOpponentTurn
UseHeldStatusHealingItem:
	predef GetUserItemAfterUnnerve
	call _HeldStatusHealingItem
	ret z
	jr UseBattleItem

_HeldStatusHealingItem:
	ld a, b
	cp HELD_HEAL_STATUS
	jr z, .item_ok

	; return z to mark that this held item has no effect
	xor a
	ret

.item_ok
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr

	; We can't use xor since SLP or PSN+TOX wont be nullified then.
	ld a, c
	and [hl]
	ret z
	xor a
	ld [hl], a
	push bc
	call UpdateUserInParty
	pop bc
	ld a, c
	cp ALL_STATUS
	jr nz, .skip_confuse
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CONFUSED, [hl]

.skip_confuse
	call ItemRecoveryAnim
	or 1
	ret

StealConfusionHealingItem:
	farcall GetOpponentItem
	call _HeldConfusionHealingItem
	ret z
	jmp StealBattleItem

UseOpponentConfusionHealingItem:
	call CallOpponentTurn
UseConfusionHealingItem:
	predef GetUserItemAfterUnnerve
	call _HeldConfusionHealingItem
	ret z
	jmp UseBattleItem

_HeldConfusionHealingItem:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_CONFUSED, a
	ret z
	ld a, b
	cp HELD_HEAL_CONFUSE
	jr z, .confusion_healing
	cp HELD_HEAL_STATUS
	jr nz, .ret_z
	ld a, c
	cp ALL_STATUS
	jr z, _HeldStatusHealingItem

.ret_z
	xor a
	ret

.confusion_healing
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CONFUSED, [hl]
	call ItemRecoveryAnim
	or 1
	ret

GetPartymonItem:
	ld hl, wPartyMon1Item
	ld a, [wCurBattleMon]
	call GetPartyLocation
	ld bc, wBattleMonItem
	ret

GetOTPartymonItem:
	ld hl, wOTPartyMon1Item
	ld a, [wCurOTMon]
	call GetPartyLocation
	ld bc, wEnemyMonItem
	ret

UpdateBattleHUDs:
	push hl
	push de
	push bc
	call DrawPlayerHUD
	ld hl, wPlayerHPPal
	call SetHPPal
	call CheckDanger
	call DrawEnemyHUD
	ld hl, wEnemyHPPal
	call SetHPPal
	jmp PopBCDEHL

UpdatePlayerHUD::
	push hl
	push de
	push bc
	call DrawPlayerHUD
	call UpdatePlayerHPPal
	call CheckDanger
	jmp PopBCDEHL

DrawPlayerHUD:
	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_FAINTED, a
	ret nz

	xor a
	ldh [hBGMapMode], a

	farcall ClearPlayerHUD

	; DrawPlayerHUDBorder
	hlcoord 19, 11
	ld [hl], "<XPEND>"
	hlcoord 10, 11
	ld a, "<XP1>"
	ld [hli], a
	ld [hl], "<XP2>"

	call PrintPlayerHUD

	; HP bar
	hlcoord 11, 9
	xor a ; PARTYMON
	ld [wMonType], a
	predef DrawPlayerHP

	; Exp bar
	push de
	ld a, [wCurBattleMon]
	ld hl, wPartyMon1Exp + 2
	call GetPartyLocation
	ld d, h
	ld e, l

	hlcoord 12, 11
	ld a, [wTempMonLevel]
	ld b, a
	call FillInExpBar
	pop de

	; Status icon
	farcall LoadPlayerStatusIcon
	hlcoord 12, 8
	ld a, $55
	ld [hli], a
	ld [hl], $56
	jmp FinishBattleAnim

CheckDanger:
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	jr z, .no_danger
	ld a, [wBattleLowHealthAlarm]
	and a
	ret nz
	ld a, [wPlayerHPPal]
	cp HP_RED
	jr z, .danger

.no_danger
	xor a
	ld [wLowHealthAlarm], a
	ret

.danger
	ld hl, wLowHealthAlarm
	set 7, [hl]
	ret

PrintPlayerHUD:
	ld de, wBattleMonNickname
	hlcoord 11, 7
	ld a, [wBattleMonNickname + MON_NAME_LENGTH - 2]
	cp "@"
	jr z, .short_name
	dec hl ; hlcoord 10, 7
.short_name
	rst PlaceString

	push bc

	ld a, [wCurBattleMon]
	ld hl, wPartyMon1DVs
	call GetPartyLocation
	ld de, wTempMonDVs
rept 4
	ld a, [hli]
	ld [de], a
	inc de
endr
	ld a, [hl]
	ld [de], a
	ld hl, wBattleMonLevel
	ld de, wTempMonLevel
	ld bc, wTempMonEnd - wTempMonLevel
	rst CopyBytes
	ld a, [wCurBattleMon]
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBattleMonVariant
	call GetBaseData

	pop hl
	dec hl

	ld bc, wBattleMonShiny
	farcall CheckShininess
	jr nc, .not_own_shiny
	ld a, "<STAR>"
	hlcoord 19, 8
	ld [hl], a

.not_own_shiny
	ld a, TEMPMON
	ld [wMonType], a
	farcall GetGender
	ld a, " "
	jr c, .got_gender_char
	ld a, "<MALE>"
	jr nz, .got_gender_char
	inc a ; "<FEMALE>"

.got_gender_char
	hlcoord 18, 8
	ld [hl], a

	hlcoord 15, 8
	ld a, [wBattleMonLevel]
	ld [wTempMonLevel], a
	jmp PrintLevel

UpdateEnemyHUD::
	push hl
	push de
	push bc
	call DrawEnemyHUD
	call UpdateEnemyHPPal
	jmp PopBCDEHL

DrawEnemyHUD:
	ld a, [wEnemySubStatus2]
	bit SUBSTATUS_FAINTED, a
	ret nz

	xor a
	ldh [hBGMapMode], a

	farcall ClearEnemyHUD

	farcall DrawEnemyHUDBorder

	ld a, [wTempEnemyMonSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetEnemyMonVariant
	call GetBaseData
	ld de, wEnemyMonNickname
	hlcoord 1, 0
	rst PlaceString
	ld h, b
	ld l, c
	dec hl

	call GetEnemyMonDVs
	ld de, wTempMonDVs
.ok
rept 4
	ld a, [hli]
	ld [de], a
	inc de
endr
	ld a, [hl]
	ld [de], a

	ld bc, wEnemyMonShiny
	farcall CheckShininess
	jr nc, .not_shiny
	ld a, "<STAR>"
	hlcoord 9, 1
	ld [hl], a

.not_shiny
	ld a, TEMPMON
	ld [wMonType], a
	farcall GetGender
	ld a, " "
	jr c, .got_gender
	ld a, "<MALE>"
	jr nz, .got_gender
	inc a ; "<FEMALE>"

.got_gender
	hlcoord 8, 1
	ld [hl], a

	hlcoord 5, 1
	ld a, [wEnemyMonLevel]
	ld [wTempMonLevel], a
	call PrintLevel

	ld hl, wEnemyMonHP
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a
	or [hl]
	jr nz, .not_fainted

	ld c, a
	ld e, a
	ld d, HP_BAR_LENGTH
	jr .draw_bar

.not_fainted
	xor a
	ldh [hMultiplicand], a
	ld a, HP_BAR_LENGTH_PX
	ldh [hMultiplier], a
	call Multiply
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ldh [hMultiplier], a
	ld a, b
	and a
	jr z, .less_than_256_max
	ldh a, [hMultiplier]
	srl b
	rra
	srl b
	rra
	ldh [hDivisor], a
	ldh a, [hProduct + 2]
	ld b, a
	srl b
	ldh a, [hProduct + 3]
	rra
	srl b
	rra
	ldh [hProduct + 3], a
	ld a, b
	ldh [hProduct + 2], a

.less_than_256_max
	ldh a, [hProduct + 2]
	ldh [hDividend + 0], a
	ldh a, [hProduct + 3]
	ldh [hDividend + 1], a
	ld a, 2
	ld b, a
	call Divide
	ldh a, [hQuotient + 2]
	ld e, a
	ld a, HP_BAR_LENGTH
	ld d, a
	ld c, a

.draw_bar
	xor a
	ld [wWhichHPBar], a
	hlcoord 1, 2
	call DrawBattleHPBar

	farcall LoadEnemyStatusIcon
	hlcoord 2, 1
	ld a, $57
	ld [hli], a
	ld [hl], $58
	jmp FinishBattleAnim

BattleAnimateHPBar:
	predef AnimateHPBar
	ld a, [wWhichHPBar]
	and a
	ld hl, wEnemyHPPal
	jr z, .got_hp_pal
	ld hl, wPlayerHPPal
.got_hp_pal
	ld a, [wCurHPAnimPal]
	ld [hl], a
	ret

UpdatePlayerHPPal:
	ld hl, wPlayerHPPal
	jr UpdateHPPal

UpdateEnemyHPPal:
	ld hl, wEnemyHPPal
	; fallthrough
UpdateHPPal:
	ld b, [hl]
	call SetHPPal
	ld a, [hl]
	cp b
	ret z
	jmp FinishBattleAnim

BattleMenu:
	xor a
	ldh [hBGMapMode], a
	call LoadTempTileMapToTileMap

	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .ok
	cp BATTLETYPE_SAFARI
	jr z, .ok
	call EmptyBattleTextbox
	call UpdateBattleHuds
	call EmptyBattleTextbox
	call LoadTileMapToTempTileMap
.ok

	call LoadWeatherIconSprite

.loop
	ld a, [wBattleType]
	cp BATTLETYPE_SAFARI
	jr z, .safari_game
	cp BATTLETYPE_CONTEST
	jr nz, .not_contest
	farcall ContestBattleMenu
	jr .next
.safari_game
	farcall SafariBattleMenu
	jr .next
.not_contest

	; Auto input: choose "ITEM"
	ld a, [wInputType]
	or a
	jr z, .skip_lyra_pack_select
	ld hl, .autoinput_down_a
	ld a, BANK(.autoinput_down_a)
	call StartAutoInput
.skip_lyra_pack_select

	farcall LoadBattleMenu

.next
	ld a, $1
	ldh [hBGMapMode], a
	ld a, [wBattleMenuCursorBuffer]
	dec a
	jr z, BattleMenu_Fight ; $1
	dec a
	jmp z, BattleMenu_PKMN ; $2
	dec a
	jmp z, BattleMenu_Pack ; $3
	dec a
	jmp z, BattleMenu_Run ; $4
	jr .loop

.autoinput_down_a
	db NO_INPUT, $40
	db D_DOWN,   $00
	db NO_INPUT, $40
	db A_BUTTON, $00
	db NO_INPUT, $ff ; end

BattleMenu_Fight:
	ld a, [wBattleType]
	cp BATTLETYPE_SAFARI
	jmp z, BattleMenu_SafariBall

	xor a
	ld [wNumFleeAttempts], a
	call Call_LoadTempTileMapToTileMap
	and a
	ret

BattleMenu_Bait:
	ld hl, BattleText_ThrewBait
	call StdBattleTextbox
	ld hl, wEnemyMonCatchRate
	srl [hl] ; halve catch rate
	; TODO: Play bait animation
	ld hl, wSafariMonEating
	ld de, wSafariMonAngerCount
	jr BattleMenu_BaitRock_Common

BattleMenu_Rock:
	call ClearSprites

	ld hl, BattleText_ThrewRock
	call StdBattleTextbox
	ld hl, wEnemyMonCatchRate
	ld a, [hl]
	add a ; double catch rate
	jr nc, .noCarry
	ld a, $ff
.noCarry
	ld [hl], a
	; TODO: Play the rock animation
	ld hl, wSafariMonAngerCount
	ld de, wSafariMonEating
	; fallthrough

BattleMenu_BaitRock_Common:
	xor a
	ld [de], a ; zero the Eating counter (rock) or the Anger counter (bait)
.randomLoop ; loop until a number less than 5 is generated
	call BattleRandom
	and 7
	cp 5
	jr nc, .randomLoop
	inc a ; increment the random number, giving a range from 1 to 5 inclusive
	ld b, a
	ld a, [hl]
	add b ; increase Eating or Anger counter appropriately
	jr nc, .noCarry
	ld a, $ff
.noCarry
	ld [hl], a
	and a
	ret

CheckSafariMonRan:
; Wildmon always runs when you are out of Safari Balls
	ld a, [wSafariBallsRemaining]
	and a
	jmp z, WildFled_EnemyFled_LinkBattleCanceled
; otherwise, check its speed, bait, and rock factors
; this probably could stand to be cleaned up or rewritten later
; it is basically taken directly from Gen 1
	ld a, [wEnemyMonSpeed + 1]
	add a
	ld b, a ; init b (which is later compared with random value) to (enemy speed % 256) * 2
	jmp c, WildFled_EnemyFled_LinkBattleCanceled ; if (enemy speed % 256) > 127, the enemy runs
	ld a, [wSafariMonEating]
	and a ; is bait factor 0?
	jr z, .checkEscapeFactor
; bait factor is not 0
; divide b by 4 (making the mon less likely to run)
	srl b
	srl b
.checkEscapeFactor
	ld a, [wSafariMonAngerCount]
	and a ; is escape factor 0?
	jr z, .compareWithRandomValue
; escape factor is not 0
; multiply b by 2 (making the mon more likely to run)
	sla b
	jr nc, .compareWithRandomValue
; cap b at 255
	ld b, $ff
.compareWithRandomValue
	call BattleRandom
	cp b
	ret nc
	jmp WildFled_EnemyFled_LinkBattleCanceled ; if b was greater than the random value, the enemy runs

BattleMenu_Pack:
	ld a, [wBattleType]
	cp BATTLETYPE_SAFARI
	jr z, BattleMenu_Rock
	; fallthrough

BattleMenu_SafariBall:
	call ClearSprites

	ld a, [wLinkMode]
	and a
	jr nz, .ItemsCantBeUsed

	ld a, [wInBattleTowerBattle]
	and a
	jr nz, .ItemsCantBeUsed

	call LoadStandardMenuHeader

	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .tutorial
	cp BATTLETYPE_CONTEST
	jr z, .contest
	cp BATTLETYPE_SAFARI
	jr z, .safari

	farcall BattlePack
	ld a, [wBattlePlayerAction]
	and a
	jr z, .didnt_use_item
	jr .UseItem

.tutorial
	farcall TutorialPack
	ld a, POKE_BALL
	ld [wCurItem], a
	call DoItemEffect
	jr .UseItem

.safari
	ld a, SAFARI_BALL
	ld [wCurItem], a
	call DoItemEffect
	jr .UseItem

.contest
	xor a ; PARK_BALL
	ld [wCurItem], a
	call DoItemEffect
	jr .UseItem

.didnt_use_item
	call ClearTileMap
	call ClearPalettes
	call DelayFrame
	call _LoadBattleFontsHPBar
	call GetMonBackpic
	call GetMonFrontpic
	call ExitMenu
	call ApplyTilemapInVBlank
	call FinishBattleAnim
	call LoadTileMapToTempTileMap
	jmp BattleMenu

.ItemsCantBeUsed:
	ld hl, BattleText_ItemsCantBeUsedHere
	call StdBattleTextbox
	jmp BattleMenu

.UseItem:
	ld a, [wWildMon]
	and a
	jr nz, .run
	farcall CheckItemPocket
	ld a, [wItemAttributeParamBuffer]
	cp BALL
	jr z, .ball
	call ClearBGPalettes
	call ClearTileMap
.ball
	xor a
	ldh [hBGMapMode], a
	call _LoadBattleFontsHPBar
	call ClearSprites
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .tutorial2
	cp BATTLETYPE_SAFARI
	call nz, GetMonBackpic
.tutorial2
	call GetMonFrontpic
	ld a, $1
	ld [wMenuCursorY], a
	call ExitMenu
	ld a, [wBattleType]
	cp BATTLETYPE_SAFARI
	call nz, UpdateBattleHUDs
	call ApplyTilemapInVBlank
	call LoadTileMapToTempTileMap
	call ClearWindowData
	call FinishBattleAnim
	and a
	ret

.run
	xor a
	ld [wWildMon], a
	ld a, [wBattleResult]
	and $c0
	ld [wBattleResult], a
	call ClearWindowData
	call SetPalettes
	scf
	ret

BattleMenu_PKMN:
	call ClearSprites

	ld a, [wBattleType]
	cp BATTLETYPE_SAFARI
	jmp z, BattleMenu_Bait ; "PKMN" is replaced with "Bait" in that mode

	call LoadStandardMenuHeader
BattleMenuPKMN_ReturnFromStats:
	call ExitMenu
	call LoadStandardMenuHeader
	call ClearBGPalettes
BattleMenuPKMN_Loop:
	call SetUpBattlePartyMenu
	xor a
	ld [wPartyMenuActionText], a
	call JumpToPartyMenuAndPrintText
	call SelectBattleMon
	jr c, .PressedB
.loop
	farcall FreezeMonIcons
	call .GetMenu
	jr c, .Cancel
	call PlaceHollowCursor
	ld a, [wMenuCursorY]
	dec a ; SWITCH
	jmp z, TryPlayerSwitch
	dec a ; STATS
	jr z, .Stats
	dec a ; MOVES
	jr z, .Moves
	dec a ; CANCEL
	jr z, .Cancel
	jr .loop

.Moves:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .Cancel
	farcall ManagePokemonMoves
	call GetMonBackpic

.Cancel: ; no-optimize stub jump
	jr BattleMenuPKMN_Loop

.Stats:
	call Battle_StatsScreen
	jr BattleMenuPKMN_ReturnFromStats

.PressedB:
	call ClearSprites
	call ClearPalettes
	call DelayFrame
	call _LoadStatusIcons
	call GetMonBackpic
	call CloseWindow
	call LoadTileMapToTempTileMap
	call GetMemCGBLayout
	call SetPalettes
	jmp BattleMenu

.GetMenu:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld hl, .MenuHeader
	jr z, .got_menuheader
	ld hl, .EggMenuHeader
.got_menuheader
	call CopyMenuHeader
	xor a
	ldh [hBGMapMode], a
	call MenuBox
	call UpdateSprites
	call PlaceVerticalMenuItems
	call ApplyTilemapInVBlank
	call CopyMenuData2
	ld a, [wMenuDataFlags]
	bit 7, a
	jr z, .set_carry
	call InitVerticalMenuCursor
	ld hl, w2DMenuFlags1
	set 6, [hl]
	call DoMenuJoypadLoop
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	ldh a, [hJoyPressed]
	bit B_BUTTON_F, a
	jr z, .clear_carry

.set_carry
	scf
	ret

.clear_carry
	and a
	ret

.MenuHeader:
	db $00 ; flags
	db 9, 11 ; start coords
	db 17, 19 ; end coords
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $c0 ; flags
	db 4 ; items
	db "Switch@"
	db "Stats@"
	db "Moves@"
	db "Cancel@"

.EggMenuHeader:
	db $00 ; flags
	db 11, 11 ; start coords
	db 17, 19 ; end coords
	dw .EggMenuData
	db 1 ; default option

.EggMenuData:
	db $c0 ; flags
	db 3 ; items
	db "Switch@"
	db "Stats@"
	db "Cancel@"

Battle_StatsScreen:
	call DisableLCD
	ld hl, vTiles2 tile $31
	ld de, vTiles0
	ld bc, $11 tiles
	rst CopyBytes
	ld hl, vTiles2
	ld de, vTiles0 tile $11
	ld bc, $31 tiles
	rst CopyBytes
	call EnableLCD
	farcall OpenPartyStats
	call DisableLCD
	ld hl, vTiles0
	ld de, vTiles2 tile $31
	ld bc, $11 tiles
	rst CopyBytes
	ld hl, vTiles0 tile $11
	ld de, vTiles2
	ld bc, $31 tiles
	rst CopyBytes
	jmp EnableLCD

AI_OpponentCanSwitch:
	call CallOpponentTurn
AI_UserCanSwitch:
; Wrapper around UserCanSwitch that also checks if we have any non-fainted in
; the party. Doesn't have a proper message for that case.
	farcall CheckAnyOtherAliveMons
	jr nz, UserCanSwitch
	or 1
	ret

UserCanSwitch:
; Returns z if the user can switch, with the message in hl if they can't.
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_SHED_SHELL
	ret z
	call CheckIfUserIsGhostType
	ret z
	farcall CheckIfTrappedByAbility
	jr nz, .check_other_trapped
	ld b, a
	farcall BufferAbility
	ld hl, BattleText_PkmnCantBeRecalledAbility
	or 1
	ret
.check_other_trapped
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerWrapCount]
	jr z, .got_wrap_count
	ld a, [wEnemyWrapCount]
.got_wrap_count
	and a
	ld hl, BattleText_PkmnCantBeRecalled
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVar
	bit SUBSTATUS_CANT_RUN, a
	ret

TryPlayerSwitch:
	ld a, [wCurBattleMon]
	ld d, a
	ld a, [wCurPartyMon]
	cp d
	jr nz, .check_trapped
	ld hl, BattleText_PkmnIsAlreadyOut
	call StdBattleTextbox
	jmp BattleMenuPKMN_Loop

.check_trapped
	call SetPlayerTurn
	call UserCanSwitch
	jr z, .try_switch
	ld hl, BattleText_PkmnCantBeRecalled
	call StdBattleTextbox
	jmp BattleMenuPKMN_Loop

.try_switch
	call CheckIfCurPartyMonIsFitToFight
	jmp z, BattleMenuPKMN_Loop

	ld a, [wCurPartyMon]
	inc a
	ld [wPlayerSwitchTarget], a
	ld a, 1
	ld [wBattlePlayerAction], a

	call ClearSprites
	call ClearPalettes
	call DelayFrame
	call _LoadStatusIcons
	call GetMonBackpic
	call CloseWindow
	call GetMemCGBLayout
	jmp SetPalettes

BattleMenu_Run:
	call ClearSprites

	call Call_LoadTempTileMapToTileMap
	ld a, $3
	ld [wMenuCursorY], a
	call CheckRunSpeed
	ret c
	ld a, [wBattlePlayerAction]
	and a
	ret nz
	jmp BattleMenu

CheckRunSpeed:
; In a safari battle, most of the battle engine is ignored, you have no active Pokemon, and can always run
	ld a, [wBattleType]
	cp BATTLETYPE_SAFARI
	jmp z, .can_escape

	; if enemy is also trying to flee, always succeed
	ld a, [wEnemyFleeing]
	and a
	jmp nz, .can_escape

; Sets up speed stats properly and attempts to flee.
	ldh a, [hBattleTurn]
	push af
	push bc
	ld d, 0 ; don't count quick claw
	call SetEnemyTurn
	call GetSpeed
	push bc
	call SetPlayerTurn
	call GetSpeed
	pop de
	ld h, b
	ld l, c
	pop bc
	pop af
	ldh [hBattleTurn], a

	; hl: player speed, de: enemy speed
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jmp z, .can_escape
	cp BATTLETYPE_SAFARI
	jmp z, .can_escape
	cp BATTLETYPE_GHOST
	jmp z, .can_escape
	cp BATTLETYPE_TRAP ; or BATTLETYPE_FORCEITEM, BATTLETYPE_RED_GYARADOS, BATTLETYPE_LEGENDARY
	jmp nc, .cant_escape

	ld a, [wLinkMode]
	and a
	jmp nz, .can_escape

	ld a, [wBattleMode]
	dec a
	jmp nz, .forfeit_to_trainer

	push hl
	call HasPlayerFainted
	pop hl
	jr z, .no_flee_ability
	call CheckNeutralizingGas
	jr z, .no_flee_ability
	ld a, [wPlayerAbility]
	cp RUN_AWAY
	jr nz, .no_flee_ability
	call SetPlayerTurn
	farcall DisableAnimations
	farcall ShowAbilityActivation
	jmp .can_escape
.no_flee_ability
	push hl
	push de
	ld a, [wBattleMonItem]
	ld [wNamedObjectIndex], a
	ld b, a
	farcall GetItemHeldEffect
	ld a, b
	cp HELD_ESCAPE
	pop de
	pop hl
	jr nz, .no_flee_item

	call SetPlayerTurn
	call GetItemName
	ld hl, BattleText_UserFledUsingAStringBuffer1
	call StdBattleTextbox
	jmp .can_escape

.no_flee_item
	push hl
	push de
	push bc
	call CheckIfUserIsGhostType
	pop bc
	pop de
	pop hl
	jmp z, .can_escape

	ld a, [wEnemySubStatus2]
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .cant_escape

	ld a, [wPlayerWrapCount]
	and a
	jr nz, .cant_escape

	push hl
	push de
	call SetPlayerTurn
	farcall CheckIfTrappedByAbility
	pop de
	pop hl
	jr z, .ability_prevents_escape

	ld a, [wNumFleeAttempts]
	inc a
	ld [wNumFleeAttempts], a

	; hl = player speed
	; de = enemy speed

	push hl
	push de
	call Call_LoadTempTileMapToTileMap
	pop de
	pop hl

	; compare hl and de
	ld a, l
	sub e
	ld a, h
	sbc d
	jmp nc, .can_escape
rept 5 ; multiply player speed by 32
	add hl, hl
endr
	; store PSpeed*32 into dividend
	ld a, h
	ldh [hDividend], a
	ld a, l
	ldh [hDividend + 1], a

	; divide ESpeed by 4
	srl d
	rr e
	srl d
	rr e
	ld a, e
	and a ; prevent division by 0
	jmp z, .can_escape
	; calculate PSpeed*32/(ESpeed/4)
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 1]
	and a ; player can escape if result is greater than 255
	jr nz, .can_escape
	ld a, [wNumFleeAttempts]
	ld c, a
	ldh a, [hQuotient + 2]
	jr .handleLoop
.loop
	add 30
	jr c, .can_escape
.handleLoop
	dec c
	jr nz, .loop
	ld c, a
	call BattleRandom
	ld b, a
	ld a, c
	cp b
	jr nc, .can_escape
	ld a, $1
	ld [wBattlePlayerAction], a
	ld hl, BattleText_CantEscape
	jr .print_inescapable_text

.cant_escape
	ld hl, BattleText_CantEscape
	jr .print_inescapable_text

.ability_prevents_escape
	call GetOpponentAbility
	ld b, a
	farcall BufferAbility
	ld hl, BattleText_PkmnCantBeRecalledAbility

.print_inescapable_text
	call StdBattleTextbox
.dont_forfeit
	call LoadTileMapToTempTileMap
	and a
	ret

.forfeit_to_trainer
	ld hl, BattleText_AskForfeitTrainerBattle
	call StdBattleTextbox
	ld hl, NoYesMenuDataHeader
	call CopyMenuHeader
	call VerticalMenu
	push af
	call Call_LoadTempTileMapToTileMap
	pop af
	jr c, .dont_forfeit
	ld a, [wMenuCursorY]
	cp $1
	jr z, .dont_forfeit

	call EmptyBattleTextbox
	call StopDangerSound
	call WaitSFX
	ld de, SFX_KINESIS
	call PlaySFX
	call PlayerMonFaintedAnimation
	farcall ClearPlayerHUD
	call WaitSFX
	ld a, BATTLEACTION_FORFEIT
	ld [wBattlePlayerAction], a
	ld a, $1
	ld [wBattleResult], a
	jmp LostBattle

.can_escape
	ld a, [wLinkMode]
	and a
	ld a, DRAW
	jr z, .fled
	call LoadTileMapToTempTileMap
	xor a
	ld [wBattlePlayerAction], a
	ld a, $f
	ld [wCurMoveNum], a
	xor a
	ld [wCurPlayerMove], a
	call LinkBattleSendReceiveAction
	call Call_LoadTempTileMapToTileMap

	; Got away safely
	ld a, [wBattleAction]
	cp BATTLEACTION_FORFEIT
	ld a, DRAW
	jr z, .fled
	dec a
.fled
	ld b, a
	ld a, [wBattleResult]
	and $c0
	add b
	ld [wBattleResult], a
	call StopDangerSound
	push de
	ld de, SFX_RUN
	call WaitPlaySFX
	pop de
	call WaitSFX
	ld hl, BattleText_GotAwaySafely
	call StdBattleTextbox
	call WaitSFX
	call LoadTileMapToTempTileMap
	scf
	ret

CheckAmuletCoin:
	push hl
	farcall GetPlayerItem
	pop hl
	ld a, b
	cp HELD_AMULET_COIN
	ret nz
	ld a, 1
	ld [wAmuletCoin], a
	ret

MoveSelectionScreen:
	; Maybe reset wPlayerSelectedMove if the move has disappeared
	; (possible if we learned a new move and replaced the old)
	ld a, [wMoveSelectionMenuType]
	cp 2
	jr z, .ether_elixer_menu
	push bc
	push hl
	ld hl, wBattleMonMoves
	ld a, [wPlayerSelectedMove]
	ld b, a
	ld c, 4
.loop
	ld a, [hli]
	and a
	jr z, .sanity_check_done
	cp b
	jr z, .sanity_check_done
	dec c
	jr nz, .loop
.sanity_check_done
	cp b
	jr z, .dont_kill_selectedmove
	xor a
	ld [wPlayerSelectedMove], a
.dont_kill_selectedmove
	pop hl
	pop bc
	ld a, [wMoveSelectionMenuType]
	and a
	jr nz, .ether_elixer_menu
	call SetPlayerTurn
	call CheckUsableMoves
	jmp nz, .struggle
	ld hl, wBattleMonMoves
	jr .got_menu_type

.ether_elixer_menu
	ld a, MON_MOVES
	call GetPartyParamLocation

.got_menu_type
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	rst CopyBytes
	xor a
	ldh [hBGMapMode], a

	hlcoord 4, 17 - NUM_MOVES - 1
	ld a, [wMoveSelectionMenuType]
	dec a
	jr nz, .got_dims
	hlcoord 4, 17 - NUM_MOVES - 1 - 4
.got_dims
	lb bc, 4, 14
	call Textbox

	hlcoord 6, 17 - NUM_MOVES
	ld a, [wMoveSelectionMenuType]
	dec a
	jr nz, .got_start_coord
	hlcoord 6, 17 - NUM_MOVES - 4
.got_start_coord
	ld a, SCREEN_WIDTH
	ld [wBuffer1], a
	predef ListMoves

	ld a, [wMoveSelectionMenuType]
	dec a
	ld a, 17 - NUM_MOVES
	jr nz, .got_default_coord
	ld a, 17 - NUM_MOVES - 4

.got_default_coord
	ld [w2DMenuCursorInitY], a
	ld a, 5
	ld [w2DMenuCursorInitX], a
	ld a, [wCurMoveNum]
	inc a
	ld [wMenuCursorY], a
	ld a, $1
	ld [wMenuCursorX], a
	ld a, [wNumMoves]
	inc a
	ld [w2DMenuNumRows], a
	ld a, $1
	ld [w2DMenuNumCols], a
	ld c, $2c

	ld a, [wMoveSelectionMenuType]
	ld b, D_DOWN | D_UP | A_BUTTON | B_BUTTON
	and a
	jr z, .check_link
	dec a
	jr z, .okay
	ld b, D_DOWN | D_UP | A_BUTTON
.check_link
	ld a, [wLinkMode]
	and a
	jr nz, .okay
	ld a, SELECT
	or b
	ld b, a

.okay
	ld a, b
	ld [wMenuJoypadFilter], a
	ld a, c
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	ld a, $10
	ld [w2DMenuCursorOffsets], a
.menu_loop
	ld a, [wMoveSelectionMenuType]
	dec a
	jr z, .interpret_joypad

	call MoveInfoBox
	ld a, [wMoveSwapBuffer]
	and a
	jr z, .interpret_joypad
	hlcoord 5, 13
	ld bc, SCREEN_WIDTH
	dec a
	rst AddNTimes
	ld [hl], "▷"

.interpret_joypad
	ld a, $1
	ldh [hBGMapMode], a
	call DoMenuJoypadLoop
	bit D_UP_F, a
	jmp nz, .pressed_up
	bit D_DOWN_F, a
	jmp nz, .pressed_down
	bit SELECT_F, a
	jmp nz, .pressed_select
	bit B_BUTTON_F, a
	; A button
	push af

	xor a
	ld [wMoveSwapBuffer], a
	ld a, [wMenuCursorY]
	dec a
	ld [wMenuCursorY], a
	ld b, a
	ld [wCurMoveNum], a

	ld a, [wMoveSelectionMenuType]
	and a
	jr z, .use_move
	pop af
	ret

.use_move
	pop af
	ret nz

	ld a, [wMenuCursorY]
	ld c, a
	call CheckUsableMove
	dec a
	jr z, .no_pp_left
	dec a
	jr z, .move_disabled
	dec a
	jr z, .choiced
	dec a
	jr z, .assault_vest
	sub 3 ; 5 or 6 gives the same message
	jr c, .encore_or_gorilla_tactics
	ld b, 0
	ld hl, wBattleMonMoves
	add hl, bc
	ld a, [hl]
	ld [wCurPlayerMove], a

	; Lock in the used move as last move
	call SetPlayerTurn
	call SetChoiceLock
	call LoadTempTileMapToTileMap
	ld a, CGB_BATTLE_COLORS
	call GetCGBLayout
	ld b, 2
	call SafeCopyTilemapAtOnce
	xor a
	ret

.move_disabled
	ld hl, BattleText_TheMoveIsDisabled
	jr .place_textbox_start_over

.encore_or_gorilla_tactics
	ld a, [wPlayerSelectedMove]
	ld [wNamedObjectIndex], a
	call GetMoveName

	ld hl, BattleText_MonCanOnlyUseMove
	jr .place_textbox_start_over

.choiced
	; Load item into wStringBuffer1, move into wStringBuffer2
	ld a, [wPlayerSelectedMove]
	ld [wNamedObjectIndex], a
	call GetMoveName

	; The above places move name into buffer 1, now copy into 2
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	ld bc, MOVE_NAME_LENGTH
	rst CopyBytes

	; now place item into wStringBuffer1
	ld a, [wBattleMonItem]
	ld [wNamedObjectIndex], a
	call GetItemName

	ld hl, BattleText_ItemOnlyAllowsMove
	jr .place_textbox_start_over

.assault_vest
	ld a, [wBattleMonItem]
	ld [wNamedObjectIndex], a
	call GetItemName

	ld hl, BattleText_ItemPreventsStatusMoves
	jr .place_textbox_start_over

.no_pp_left
	ld hl, BattleText_TheresNoPPLeftForThisMove

.place_textbox_start_over
	push hl
	call ClearSprites
	pop hl
	call StdBattleTextbox
	call Call_LoadTempTileMapToTileMap
	jmp MoveSelectionScreen

.pressed_up
	ld a, [wMenuCursorY]
	and a
	jmp nz, .menu_loop
	ld a, [wNumMoves]
	inc a
	ld [wMenuCursorY], a
	jmp .menu_loop

.pressed_down
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [wNumMoves]
	inc a
	inc a
	cp b
	jmp nz, .menu_loop
	ld a, $1
	ld [wMenuCursorY], a
	jmp .menu_loop

.pressed_select
	ld a, [wMoveSwapBuffer]
	and a
	jr z, .start_swap
	call SwapBattleMoves
	xor a
	ld [wMoveSwapBuffer], a
	jmp MoveSelectionScreen

.start_swap
	ld a, [wMenuCursorY]
	ld [wMoveSwapBuffer], a
	jmp MoveSelectionScreen

.struggle
	ld a, STRUGGLE
	ld [wCurPlayerMove], a
	ld hl, BattleText_PkmnHasNoMovesLeft
	call StdBattleTextbox
	ld c, 60
	call DelayFrames
	xor a
	ret

SetChoiceLock:
; Set choice lock to move choice c (0-3)
	push hl
	push bc
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerEncoreCount
	jr z, .got_encore_count
	ld hl, wEnemyEncoreCount
.got_encore_count
	ld a, [hl]
	and $f
	ld b, a
	ld a, c
	inc a
	swap a
	or b
	ld [hl], a
	pop bc
	pop hl
	ret

GetDisableEncoreMoves:
; Sets d to disabled move ID and e to encored/choiced move ID.
; Preserves bc, hl
	push hl
	push bc
	ldh a, [hBattleTurn]
	and a
	ld bc, wPlayerDisableCount
	ld de, wPlayerEncoreCount
	ld hl, wBattleMonMoves
	jr z, .got_disable_encore
	ld bc, wEnemyDisableCount
	ld de, wEnemyEncoreCount
	ld hl, wEnemyMonMoves
.got_disable_encore
	ld a, [bc]
	call .GetMove
	ld b, a
	ld a, [de]
	ld d, b
	call .GetMove
	ld e, a
	pop bc
	pop hl
	ret

.GetMove:
	swap a
	and $f
	ret z
	dec a
	push hl
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	pop hl
	ret

SetDisableEncoreMoves:
; With disabled move ID in d, encored move ID in e, set disabled/encored move
; state if the user still knows the move.
	push hl
	push bc
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves
	jr z, .got_moves
	ld hl, wEnemyMonMoves
.got_moves
	push hl
	ld a, d
	and a
	jr z, .disable_done
	ld d, 0
	farcall UserKnowsMove
	jr nz, .disable_done
	inc c
	swap c
	ld d, c
.disable_done
	pop hl
	ld a, e
	and a
	jr z, .encore_done
	ld e, 0
	farcall UserKnowsMove
	jr nz, .encore_done
	inc c
	swap c
	ld e, c
.encore_done
	ldh a, [hBattleTurn]
	and a
	ld bc, wPlayerDisableCount
	ld hl, wPlayerEncoreCount
	jr z, .got_disable_count
	ld bc, wEnemyDisableCount
	ld hl, wEnemyEncoreCount
.got_disable_count
	; If the move no longer exist in learnset, remove encore/disable status
	ld a, d
	and a
	jr z, .reset_disable
	ld a, [bc]
	and $f
	or d
.reset_disable
	ld [bc], a

	ld a, e
	and a
	jr z, .reset_encore
	ld a, [hl]
	and $f
	or e
.reset_encore
	ld [hl], a
	pop bc
	pop hl
	ret

SwapBattleMoves:
	call GetDisableEncoreMoves
	push de
	ld hl, wBattleMonMoves
	call .swap_bytes
	ld hl, wBattleMonPP
	call .swap_bytes
	pop de
	call SetDisableEncoreMoves

; Fixes the COOLTRAINER glitch
	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_TRANSFORMED, a
	ret nz
	ld hl, wPartyMon1Moves
	ld a, [wCurBattleMon]
	call GetPartyLocation
	push hl
	call .swap_bytes
	pop hl
	ld bc, MON_PP - MON_MOVES
	add hl, bc

.swap_bytes
	push hl
	ld a, [wMoveSwapBuffer]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wMenuCursorY]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	ret

MoveInfoBox:
	xor a
	ldh [hBGMapMode], a

	hlcoord 0, 8
	ld a, [hl]
	cp "┌"
	push af
	lb bc, 3, 9
	call Textbox

	ld hl, wMenuCursorY
	dec [hl]
	call SetPlayerTurn
	ld hl, wBattleMonMoves
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurPlayerMove], a

	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	ld a, WILDMON
	ld [wMonType], a
	farcall GetMaxPPOfMove

	ld hl, wMenuCursorY
	ld c, [hl]
	inc [hl]
	ld b, 0
	ld hl, wBattleMonPP
	add hl, bc
	ld a, [hl]
	and $3f
	ld [wStringBuffer1], a
	call .PrintPP

	farcall UpdateMoveData

	hlcoord 1, 10
	ld de, .PowAcc
	rst PlaceString

	ld hl, Moves + MOVE_POWER
	call GetCurMoveProperty
	hlcoord 1, 10
	cp 2
	jr c, .no_power
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	lb bc, 1, 3
	call PrintNum
	jr .place_accuracy
.no_power
	ld de, .NA
	rst PlaceString

.place_accuracy
	ld hl, Moves + MOVE_ACC
	call GetCurMoveProperty
	hlcoord 6, 10
	cp 2
	jr c, .no_acc
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	lb bc, 1, 3
	call PrintNum
	jr .icons
.no_acc
	ld de, .NA
	rst PlaceString

.icons
	farcall LoadBattleCategoryAndTypePals
	call SetPalettes
	ld hl, CategoryIconGFX
	ld bc, 2 tiles
	ld a, [wPlayerMoveStruct + MOVE_CATEGORY]
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles2 tile $59
	lb bc, BANK(CategoryIconGFX), 2
	call Request2bpp
	ld hl, TypeIconGFX
	ld bc, 4 * LEN_1BPP_TILE
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles2 tile $5b
	lb bc, BANK(TypeIconGFX), 4
	call Request1bpp
	hlcoord 1, 9
	ld b, 6
	ld a, $59
.loop
	ld [hli], a
	inc a
	dec b
	jr nz, .loop
	pop af
	call nz, ApplyTilemap
	ret

.PowAcc:
	db "   <BOLDP>/   %@"
.NA:
	db "---@"

.PrintPP:
	hlcoord 2, 11
	ld a, "<BOLDP>"
	ld [hli], a
	ld [hli], a
	inc hl
	push hl
	ld de, wStringBuffer1
	lb bc, 1, 2
	call PrintNum
	pop hl
	inc hl
	inc hl
	ld a, "/"
	ld [hli], a
	ld de, wNamedObjectIndex
	lb bc, 1, 2
	jmp PrintNum

CheckUsableMoves:
; Return nz if we have no usable moves
	ld a, 4
.loop
	dec a
	push af
	call CheckUsableMove
	jr z, .usable
	pop af
	and a
	jr nz, .loop
	inc a
	ret
.usable
	pop af
	xor a
	ret

CheckUsableMove:
; Check if move a in the move list is usable. Returns z if usable
; Note that the first move in the list is move 0, not move 1.
; If nz, a contains a number describing why it isn't usable:
; 1 - no PP
; 2 - disabled
; 3 - choiced item
; 4 - assault vest on status move
; 5 - encored
; 6 - choiced ability
	push hl
	push de
	push bc

	; Check if we're out of pp
	ld c, a
	ld b, 0
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonPP
	jr z, .got_pp
	ld hl, wEnemyMonPP
.got_pp
	add hl, bc
	ld a, [hl]
	and $3f
	ld a, 1
	jmp z, .end

	; Check Encore
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerEncoreCount]
	jr z, .got_encore_count
	ld a, [wEnemyEncoreCount]
.got_encore_count
	ld b, a
	and $f
	jr z, .not_encored
	ld a, b
	swap a
	and $f
	jr z, .not_encored
	dec a
	cp c
	ld a, 5
	jr nz, .end

.not_encored
	; Check Disable
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerDisableCount]
	jr z, .got_disable_count
	ld a, [wEnemyDisableCount]
.got_disable_count
	swap a
	and $f
	jr z, .not_disabled
	dec a
	cp c
	ld a, 2
	jr z, .end

.not_disabled
	; Check items. This requires the actual move so get it into c
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves
	jr z, .got_moves
	ld hl, wEnemyMonMoves
.got_moves
	ld b, 0
	add hl, bc
	ld b, [hl]
	push bc
	farcall GetUserItem
	ld a, b
	pop bc
	cp HELD_CHOICE
	jr z, .check_choiced
	cp HELD_ASSAULT_VEST
	jr z, .assault_vest

	; Check for Gorilla Tactics
	call GetTrueUserAbility
	cp GORILLA_TACTICS
	jr z, .check_choiced
	jr .usable

.assault_vest
	; Assault Vest check
	ld a, b
	call GetMoveFixedCategory
	cp STATUS
	ld a, 4
	jr z, .end
	jr .usable
.check_choiced
	; Check if we did a move yet
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerEncoreCount]
	jr z, .got_encore_count2
	ld a, [wEnemyEncoreCount]
.got_encore_count2
	swap a
	and $f
	jr z, .usable
	dec a
	cp c
	jr z, .usable

	; Choice items take priority over Gorilla Tactics message-wise
	farcall GetUserItem
	ld a, b
	cp HELD_CHOICE
	ld a, 3
	jr z, .end
	add a ; sets a to 6, which is what we want
	jr .end

	; fallthrough
.usable
	xor a
.end
	and a

	jmp PopBCDEHL

ParseEnemyAction:
	; Clear weather icon
	call ClearSprites

	; Unconditionally perform at least one link exchange
	ld a, [wLinkMode]
	and a
	call nz, LinkBattleSendReceiveAction
	call SetEnemyTurn
	call CheckLockedIn
	ret nz

	ld a, [wLinkMode]
	and a
	jr z, .no_linkswitch

	; For switching out in link, register action here
	ld a, [wBattleAction]
	sub BATTLEACTION_SWITCH1
	jr c, .no_linkswitch
	cp NUM_POKEMON
	jr nc, .no_linkswitch

	; Link enemy is switching
	inc a
	ld [wEnemySwitchTarget], a

.no_linkswitch
	ld a, [wEnemySwitchTarget]
	and a
	jr nz, .not_using_move
	ld a, [wEnemyFleeing]
	and a
	jr nz, .not_using_move
	farcall AI_TryItem
	jr nc, .using_move
.not_using_move
	call SetEnemyTurn
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	xor a
	ld [hl], a
	farcall UpdateMoveData
	jr .skip_load

.using_move
	ld a, [wLinkMode]
	and a
	jr z, .not_linked
	call EmptyBattleTextbox
	call LoadTileMapToTempTileMap
	call Call_LoadTempTileMapToTileMap
	ld a, [wBattleAction]
	cp BATTLEACTION_STRUGGLE
	jr z, .struggle
	cp BATTLEACTION_SWITCH1
	jr nc, ResetVarsForSubstatusRage
	ld [wCurEnemyMoveNum], a
	ld c, a
	ld a, [wEnemySubStatus3]
	and 1 << SUBSTATUS_CHARGED | 1 << SUBSTATUS_RAMPAGE | 1 << SUBSTATUS_ROLLOUT
	jr nz, .skip_load

	call SetEnemyTurn
	call CheckUsableMoves
	jr nz, .struggle

	call SetEnemyTurn
	ld a, [wCurEnemyMoveNum]
	ld c, a
	call SetChoiceLock
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
.finish
	ld [wCurEnemyMove], a
	ld [wCurEnemyMoveNum], a ; set move # to -1 to avoid disable issues
	jr .skip_load

.not_linked
	call SetEnemyTurn
	call CheckUsableMoves
	jr nz, .struggle

	call SetEnemyTurn
	ld a, [wCurEnemyMoveNum]
	ld c, a
	call SetChoiceLock
	call CheckLockedIn
	jr nz, ResetVarsForSubstatusRage

.skip_load
	call SetEnemyTurn
	farcall UpdateMoveData
	call CheckLockedIn
	jr nz, .raging
	xor a
	ld [wEnemyCharging], a

.raging
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_RAGE
	jr z, .no_rage
	ld hl, wEnemySubStatus4
	res SUBSTATUS_RAGE, [hl]

.no_rage
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_PROTECT
	ret z
	cp EFFECT_ENDURE
	ret z
	xor a
	ld [wEnemyProtectCount], a
	ret

.struggle
	ld a, STRUGGLE
	jr .finish

ResetVarsForSubstatusRage:
	xor a
	ld [wEnemyProtectCount], a
	ld hl, wEnemySubStatus4
	res SUBSTATUS_RAGE, [hl]
	ret

LinkBattleError:
; TODO: handle link battle errors gracefully
	ld hl, LinkBattleErrorText
	call StdBattleTextbox
	jmp SoftReset

LinkBattleSendReceiveAction:
; Note that only the lower 4 bits is usable. The higher 4 determines what kind
; of linking we are performing.
	call .StageForSend
	ld [wLinkBattleSentAction], a
	call PlaceWaitingText
	ld a, [wLinkBattleSentAction]
	ld [wPlayerLinkAction], a
	ld a, $ff
	ld [wOtherPlayerLinkAction], a

.waiting
	call LinkTransfer
	call DelayFrame
	ld a, [wOtherPlayerLinkAction]
	inc a
	jr z, .waiting

	ld b, 10
.receive
	call DelayFrame
	call LinkTransfer
	dec b
	jr nz, .receive

	ld b, 10
.acknowledge
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .acknowledge

	ld a, [wOtherPlayerLinkAction]
	ld [wBattleAction], a
	ret

.StageForSend:
	ld a, [wBattlePlayerAction]
	and a
	jr nz, .switch
	ld a, [wCurPlayerMove]
	inc a ; cp STRUGGLE
	ld a, BATTLEACTION_STRUGGLE
	jr z, .use_move
	ld a, [wCurMoveNum]
.use_move
	and $0f
	ret

.switch
	ld a, [wPlayerSwitchTarget]
	add BATTLEACTION_SWITCH1 - 1
	jr .use_move

LoadEnemyMon:
; Initialize wildmon data
	xor a
	ld [wOTPartyCount], a
	ld [wCurOTMon], a
	inc a
	ld [wMonType], a

	; Make sure everything knows what species we're working with
	ld a, [wTempEnemyMonSpecies]
	ld [wEnemyMonSpecies], a
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a

	; set [wCurForm] before TryAddMonToParty calls GetBaseData
	call GenerateWildForm

	predef TryAddMonToParty

	call CheckValidMagikarpLength
	jr c, LoadEnemyMon

	ld a, [wBaseCatchRate]
	ld [wEnemyMonCatchRate], a

	; Let's get the item:
	; Check for guranteed items
	ld a, [wBaseItems]
	inc a ; cp ALWAYS_ITEM_2
	ld a, [wBaseItems+1]
	jr z, .UpdateItem

	ld a, [wBattleType]
	cp BATTLETYPE_LEGENDARY
	ld a, [wBaseItems]
	jr z, .UpdateItem

	; Failing that, it's all up to chance

	call GetLeadAbility
	cp SUPER_LUCK
	jr z, .compound_eyes
if DEF(FAITHFUL)
	cp COMPOUND_EYES
	jr nz, .no_compound_eyes_or_amulet_coin
else
	cp COMPOUND_EYES
	jr z, .compound_eyes
	; If the party lead holds an Amulet Coin, chances are increased
	ld a, [wPartyMon1Item]
	cp AMULET_COIN
	jr nz, .no_compound_eyes_or_amulet_coin
endc

.compound_eyes:
	; 60% chance of getting Item1
	call BattleRandom
	cp 60 percent
	ld a, [wBaseItems]
	jr c, .UpdateItem

	; 20% chance of getting Item2 (50% of (100% - 60%) = 20%)
	call BattleRandom
	cp 50 percent
	ld a, [wBaseItems+1]
	jr c, .UpdateItem

	; 20% chance of not getting an item (100% - 60% - 20% = 20%)
	ld a, NO_ITEM
	jr .UpdateItem

.no_compound_eyes_or_amulet_coin:
	; 50% chance of getting Item1
	call BattleRandom
	cp 50 percent
	ld a, [wBaseItems]
	jr c, .UpdateItem

	; 5% chance of getting Item2 (10% of (100% - 50%) = 5%)
	call BattleRandom
	cp 10 percent
	ld a, [wBaseItems+1]
	jr c, .UpdateItem

	; 45% chance of not getting an item (100% - 50% - 5% = 45%)
	xor a ; NO_ITEM
.UpdateItem:
	ld [wOTPartyMon1Item], a

	; If we're headbutting trees, some monsters enter battle asleep
	call CheckSleepingTreeMon
	; a = carry ? TREEMON_SLEEP_TURNS : 0
	sbc a
	and TREEMON_SLEEP_TURNS
	ld hl, wOTPartyMon1Status
	ld [hli], a

	; Unused byte
	xor a
	ld [hli], a

	; Set roam mon HP
	ld a, [wBattleType]
	cp BATTLETYPE_ROAMING
	jr nz, .Moves

	; Grab HP
	call GetRoamMonHP
	ld a, [hl]
	; Check if it's been initialized again
	and a
	jr z, .InitRoamHP
	; Update from the struct if it has
	ld a, [hl]
	ld [wOTPartyMon1HP + 1], a
	call GetRoamMonStatus
	ld a, [hl]
	ld hl, wOTPartyMon1Status
	ld [hli], a
	jr .Moves

.InitRoamHP:
	; HP only uses the lo byte in the RoamMon struct since
	; Raikou/Entei/Suicune will have < 256 hp at level 40
	ld a, [wOTPartyMon1HP + 1]
	ld [hl], a
	call GetRoamMonStatus
	xor a
	ld [hl], a
	call GetRoamMonDVs
	ld d, h
	ld e, l
	ld hl, wOTPartyMon1DVs
	ld bc, 5
	rst CopyBytes

.Moves:
	farcall CheckUniqueWildMove

	; Fill wild PP
	ld hl, wOTPartyMon1Moves
	ld de, wOTPartyMon1PP
	predef_jump FillPP

ApplyLegendaryDVs:
	push de
	push bc
	ld a, [wBattleType]
	cp BATTLETYPE_RED_GYARADOS
	jr z, .okay

	push hl
	ld a, [wCurPartySpecies]
	ld hl, LegendaryMons
	call IsInByteArray
	pop hl
	jr nc, .done

.okay
	push hl

	; Generate 3 random stats to give perfect DVs to
.outer_loop
	lb bc, 0, 6
	call BattleRandom
.loop
	rlca
	jr nc, .dont_apply
	inc b
.dont_apply
	dec c
	jr nz, .loop
	ld c, a
	ld a, b
	cp 3
	jr nz, .outer_loop

	; Apply perfect DVs to the resulting stats
.stat_loop
	rrc c
	jr nc, .skip_low_nibble
	ld a, [hl]
	or $f
	ld [hl], a
.skip_low_nibble
	rrc c
	jr nc, .skip_high_nibble
	ld a, [hl]
	or $f0
	ld [hl], a
.skip_high_nibble
	dec hl
	dec b
	jr nz, .stat_loop
	pop hl
.done
	pop bc
	pop de
	ret

CheckSleepingTreeMon:
; Return carry if species is in the list
; for the current time of day

; Don't do anything if this isn't a tree encounter
	ld a, [wBattleType]
	cp BATTLETYPE_TREE
	jr nz, .NotSleeping

; Nor if the Pokémon has Insomnia/Vital Spirit
	ld hl, wEnemyMonPersonality ; ability is properly updated at this point, so OK to check
	ld a, [wTempEnemyMonSpecies]
	ld c, a
	call GetAbility
	ld a, b
	cp INSOMNIA
	jr z, .NotSleeping
	cp VITAL_SPIRIT
	jr z, .NotSleeping

; Get list for the time of day
	ld hl, AsleepTreeMonsMorn
	ld a, [wTimeOfDay]
	cp DAY
	jr c, .Check
	ld hl, AsleepTreeMonsDay
	jr z, .Check
	ld hl, AsleepTreeMonsNite

.Check:
	ld a, [wTempEnemyMonSpecies]
	call IsInByteArray
; If it's a match, the opponent is asleep
	ret c

.NotSleeping:
	and a
	ret

INCLUDE "data/wild/treemons_asleep.asm"

GenerateWildForm:
	push hl
	push de
	push bc
	ld a, [wWildMonForm]
	ld b, a
	and FORM_MASK
	ld a, b
	jr nz, .done
	ld a, [wTempEnemyMonSpecies]
	ld c, a
	ld hl, RandomWildSpeciesForms
.loop
	; Check species
	ld a, [hli]
	and a
	jr z, .ok
	cp c
	; Load and increase hl before jumping so we have a consistent hl value after
	ld a, [hli]
	jr nz, .next

	; Check extspecies
	xor b
	and EXTSPECIES_MASK
	jr z, .ok
.next
	inc hl
	inc hl
	jr .loop
.ok
	call IndirectHL
.done
	ld [wCurForm], a
	jmp PopBCDEHL

random_wild_form: MACRO
	if _NARG == 3
		dp \1, \2
		dw \3
	else
		dp \1
		dw \2
	endc
ENDM

RandomWildSpeciesForms:
	random_wild_form UNOWN,    .Unown
	random_wild_form MAGIKARP, .Magikarp
	random_wild_form EKANS,    .EkansArbok
	random_wild_form ARBOK,    .EkansArbok
	dbw 0,        .Default

.Unown:
	; Random Unown letter
	ld a, NUM_UNOWN
	call .RandomForm
	; Can't use any letters that haven't been unlocked
	call CheckUnownLetter
	jr nc, .Unown ; re-roll
	ret

.Magikarp:
	; Random Magikarp pattern
	ld a, NUM_MAGIKARP
	jr .RandomForm

.EkansArbok:
	; Random Arbok form (if not already specified)
	ld a, 2 ; ARBOK_JOHTO_FORM or ARBOK_KANTO_FORM
	; fallthrough
.RandomForm:
	call BattleRandomRange
	inc a
	ret

.Default:
	ld a, PLAIN_FORM
	ret

CheckUnownLetter:
; Return carry if the Unown letter in a has been unlocked.
	ld b, a
	ld a, [wUnlockedUnowns]
	ld c, a
	ld de, 0

.loop
; Don't check this set unless it's been unlocked
	srl c
	jr nc, .next

; Is our letter in the set?
	ld hl, UnlockedUnownLetterSets
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	push de
	push bc
	ld a, b
	call IsInByteArray
	pop bc
	pop de

	ret c ; unlocked letter, returns carry

.next
; Make sure we haven't gone past the end of the table
	inc e
	inc e
	ld a, e
	cp UnlockedUnownLetterSets.End - UnlockedUnownLetterSets
	jr c, .loop

	ret ; not unlocked or invalid letter, returns not carry

CheckValidMagikarpLength:
; Return carry if the Magikarp length is invalid for the current area

	ld a, [wTempEnemyMonSpecies]
	cp MAGIKARP
	jr nz, .okay

	; Get Magikarp's length
	ld de, wOTPartyMon1DVs
	ld bc, wPlayerID
	farcall CalcMagikarpLength

	; We're clear if the length is < 5'
	ld a, [wMagikarpLengthMmHi]
	cp 5 ; feet
	jr nz, .CheckMagikarpArea

	; 5% chance of skipping size checks
	call Random
	cp 5 percent
	jr c, .CheckMagikarpArea
	; Try again if > 3"
	ld a, [wMagikarpLengthMmLo]
	cp 3 ; inches
	jr nc, .redo

	; 20% chance of skipping this check
	call Random
	cp 20 percent - 1
	jr c, .CheckMagikarpArea
	; Try again if > 2"
	ld a, [wMagikarpLengthMmLo]
	cp 2 ; inches
	jr nc, .redo

.CheckMagikarpArea:
	ld a, [wMapGroup]
	cp GROUP_LAKE_OF_RAGE
	jr nz, .okay
	ld a, [wMapNumber]
	cp MAP_LAKE_OF_RAGE
	jr nz, .okay
.LakeOfRageMagikarp
	; 40% chance of not flooring
	call Random
	cp 40 percent - 2
	jr c, .okay
	; Floor at length 3'
	ld a, [wMagikarpLengthMmHi]
	cp 3 ; feet
	jr c, .redo

.okay:
	and a
	ret

.redo:
	scf
	ret

INCLUDE "data/wild/unlocked_unowns.asm"

FinalPkmnSlideInEnemyMonFrontpic:
	call FinishBattleAnim
	call GetMonFrontpic
	hlcoord 19, 0
	ld c, 0

.outer_loop
	inc c
	ld a, c
	cp 9
	ret z
	xor a
	ldh [hBGMapMode], a
	ldh [hBGMapHalf], a
	ld d, $0
	push bc
	push hl

.inner_loop
	call .CopyColumn
	inc hl
	ld a, 7
	add d
	ld d, a
	dec c
	jr nz, .inner_loop

	ld a, $1
	ldh [hBGMapMode], a
	ld c, 4
	call DelayFrames
	pop hl
	pop bc
	dec hl
	jr .outer_loop

.CopyColumn:
	push hl
	push de
	push bc
	ld e, 7

.loop
	ld a, d
	cp 7 * 7
	jr c, .ok
	ld a, " "
.ok
	ld [hl], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc d
	dec e
	jr nz, .loop

	jmp PopBCDEHL

BattleWinSlideInEnemyTrainerFrontpic:
	xor a
	ld [wTempEnemyMonSpecies], a
	call FinishBattleAnim
	ld a, [wOtherTrainerClass]
	ld [wTrainerClass], a
	ld de, vTiles2
	farcall GetTrainerPic
	hlcoord 19, 0
	ld c, 0

.outer_loop
	inc c
	ld a, c
	cp 7
	ret z
	xor a
	ldh [hBGMapMode], a
	ldh [hBGMapHalf], a
	ld d, $0
	push bc
	push hl

.inner_loop
	call .CopyColumn
	inc hl
	ld a, 7
	add d
	ld d, a
	dec c
	jr nz, .inner_loop

	ld a, $1
	ldh [hBGMapMode], a
	ld c, 4
	call DelayFrames
	pop hl
	pop bc
	dec hl
	jr .outer_loop

.CopyColumn:
	push hl
	push de
	push bc
	ld e, 7

.loop
	ld [hl], d
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc d
	dec e
	jr nz, .loop

	jmp PopBCDEHL

_LoadBattleFontsHPBar:
	farjp LoadBattleFontsHPBar

_LoadStatusIcons:
	farjp LoadStatusIcons

_BattleRandom::
; If the normal RNG is used in a link battle it'll desync.
; To circumvent this a shared PRNG is used instead.

; But if we're in a non-link battle we're safe to use it
	ld a, [wLinkMode]
	and a
	jmp z, Random

; The PRNG operates in streams of 10 values.

; Which value are we trying to pull?
	push hl
	push bc
	ld a, [wLinkBattleRNCount]
	ld c, a
	ld b, 0
	ld hl, wLinkBattleRNs
	add hl, bc
	inc a
	ld [wLinkBattleRNCount], a

; If we haven't hit the end yet, we're good
	cp 10 - 1 ; Exclude last value. See the closing comment
	ld a, [hl]
	pop bc
	pop hl
	ret c

; If we have, we have to generate new pseudorandom data
; Instead of having multiple PRNGs, ten seeds are used
	push hl
	push bc
	push af

; Reset count to 0
	xor a
	ld [wLinkBattleRNCount], a
	ld hl, wLinkBattleRNs
	ld b, 10 ; number of seeds

; Generate next number in the sequence for each seed
; The algorithm takes the form *5 + 1 % 256
.loop
	; get last #
	ld a, [hl]

	; a * 5 + 1
	ld c, a
	add a
	add a
	add c
	inc a

	; update #
	ld [hli], a
	dec b
	jr nz, .loop

; This has the side effect of pulling the last value first,
; then wrapping around. As a result, when we check to see if
; we've reached the end, we check the one before it.

	pop af
	pop bc
	pop hl
	ret

Call_PlayBattleAnim_OnlyIfVisible:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret nz

Call_PlayBattleAnim:
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a
	call ApplyTilemapInVBlank
	predef_jump PlayBattleAnim

FinishBattleAnim:
	push hl
	push de
	push bc
	push af
	ld a, CGB_BATTLE_COLORS
	call GetCGBLayout
	call SetPalettes
	call DelayFrame
	jmp PopAFBCDEHL

GiveExperiencePoints:
; Give experience.
; Don't give experience if linked or in the Battle Tower.
	ld a, [wLinkMode]
	and a
	ret nz

	ld a, [wInBattleTowerBattle]
	and a
	ret nz

	xor a
	ld [wCurPartyMon], a
	ld bc, wPartyMon1Species

.loop
	ld hl, MON_HP
	add hl, bc
	ld a, [hli]
	or [hl]
	jmp z, .next_mon ; fainted

	ld hl, wGivingExperienceToExpShareHolders
	push bc
	call .CheckParticipation
	pop bc
	jr nz, .participating
	push bc
	call GetParticipantVar
	call .CheckParticipation
	pop bc
	jmp z, .next_mon

.participating
	call GiveBattleEVs

	; No experience at level 100
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	cp MAX_LEVEL
	jmp z, .next_mon

	push bc
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [wEnemyMonBaseExp]
	ldh [hMultiplicand + 2], a
	ld a, [wInitialOptions]
	bit SCALED_EXP, a
	call nz, GetNewBaseExp
	ld a, [wEnemyMonLevel]
	ldh [hMultiplier], a
	call Multiply
	ld a, [wInitialOptions]
	bit SCALED_EXP, a
	ld a, 7
	jr z, .got_exp_divisor
	ld a, 5
.got_exp_divisor
	ldh [hDivisor], a
	ld b, 4
	call Divide

	; Boost Experience for traded Pokemon
	pop bc
	ld hl, MON_ID
	add hl, bc
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .boosted
	inc hl
	ld a, [wPlayerID + 1]
	cp [hl]
	ld a, 0
	jr z, .no_boost
	ld a, [wInitialOptions]
	bit TRADED_AS_OT_OPT, a
	ld a, 0
	jr nz, .no_boost

.boosted
	call BoostExp
	ld a, 1

.no_boost
; Boost experience for a trainer battle
	ld [wStringBuffer2 + 3], a
	ld a, [wBattleMode]
	dec a
	call nz, BoostExp
; Boost experience for Lucky Egg
	push bc
	ld hl, MON_ITEM
	add hl, bc
	ld a, [hl]
	cp LUCKY_EGG
	call z, BoostExp

	call .MaybeScaleExp

	; make sure to give at least 1 exp
	ld hl, hQuotient
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	jr nz, .exp_ok
	inc [hl]
.exp_ok
	ldh a, [hQuotient + 2]
	ld [wStringBuffer2 + 2], a
	ldh a, [hQuotient + 1]
	ld [wStringBuffer2 + 1], a
	ldh a, [hQuotient]
	ld [wStringBuffer2], a
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	ld hl, Text_PkmnGainedExpPoint
	call BattleTextbox
	ld a, [wStringBuffer2 + 2]
	ldh [hQuotient + 2], a
	ld a, [wStringBuffer2 + 1]
	ldh [hQuotient + 1], a
	ld a, [wStringBuffer2]
	ldh [hQuotient], a
	pop bc
	call AnimateExpBar
	push bc
	call LoadTileMapToTempTileMap
	pop bc
	ld hl, MON_EXP + 2
	add hl, bc
	ld d, [hl]
	ldh a, [hQuotient + 2]
	add d
	ld [hld], a
	ld d, [hl]
	ldh a, [hQuotient + 1]
	adc d
	ld [hl], a
	jr nc, .skip2
	dec hl
	inc [hl]
	jr nz, .skip2
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

.skip2
	ld a, [wCurPartyMon]
	ld e, a
	ld d, $0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wCurSpecies], a
	call GetCurPartyMonVariant
	call GetBaseData
	push bc
	ld d, MAX_LEVEL
	farcall CalcExpAtLevel
	pop bc
	ld hl, MON_EXP + 2
	add hl, bc
	push bc
	ldh a, [hQuotient]
	ld b, a
	ldh a, [hQuotient + 1]
	ld c, a
	ldh a, [hQuotient + 2]
	ld d, a
	ld a, [hld]
	sub d
	ld a, [hld]
	sbc c
	ld a, [hl]
	sbc b
	jr c, .not_max_exp
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, d
	ld [hld], a

.not_max_exp
	xor a ; PARTYMON
	ld [wMonType], a
	predef CopyPkmnToTempMon
	farcall CalcLevel
	pop bc
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	cp MAX_LEVEL
	jmp nc, .next_mon
	cp d
	jmp z, .next_mon
; <NICKNAME> grew to level ##!
	ld [wTempLevel], a
	ld a, [wCurPartyLevel]
	push af
	push bc
	ld hl, MON_MAXHP
	add hl, bc
	push de
	ld de, wStringBuffer3
	ld bc, 12
	rst CopyBytes
	pop de
	pop bc
	push bc
	ld hl, MON_LEVEL
	add hl, bc
	ld [hl], d
	farcall UpdatePkmnStats
	pop bc
	ld hl, MON_HP
	add hl, bc
	ld a, [wCurBattleMon]
	ld d, a
	ld a, [wCurPartyMon]
	cp d
	jr nz, .skip_animation
	ld de, wBattleMonHP
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld de, wBattleMonMaxHP
	push bc
	ld a, [wCurBattleMon]
	ld b, a
	ld a, [wCurPartyMon]
	cp b
	ld bc, PARTYMON_STRUCT_LENGTH - MON_MAXHP
	jr nz, .got_copy_length
	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_TRANSFORMED, a
	jr z, .got_copy_length
	ld bc, 2
.got_copy_length
	rst CopyBytes
	pop bc
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wBattleMonLevel], a
	xor a ; FALSE
	ld [wApplyStatLevelMultipliersToEnemy], a
	call UpdatePlayerHUD
	call EmptyBattleTextbox
	call LoadTileMapToTempTileMap
	ld a, $1
	ldh [hBGMapMode], a

.skip_animation
	farcall LevelUpHappinessMod
	ld a, [wCurBattleMon]
	ld b, a
	ld a, [wCurPartyMon]
	cp b
	jr z, .skip_animation2
	ld de, SFX_HIT_END_OF_EXP_BAR
	call PlaySFX
	call WaitSFX
	ld hl, BattleText_StringBuffer1GrewToLevel
	call StdBattleTextbox
	call LoadTileMapToTempTileMap

.skip_animation2
	xor a ; PARTYMON
	ld [wMonType], a
	predef CopyPkmnToTempMon
	farcall PrintStatDifferences
	call Call_LoadTempTileMapToTileMap
	xor a ; PARTYMON
	ld [wMonType], a
	ld a, [wCurSpecies]
	ld [wTempSpecies], a ; unused?
	ld a, [wCurPartyLevel]
	push af
	ld c, a
	ld a, [wTempLevel]
	ld b, a

.level_loop
	inc b
	ld a, b
	ld [wCurPartyLevel], a
	push bc
	predef LearnLevelMoves
	pop bc
	ld a, b
	cp c
	jr nz, .level_loop
	pop af
	ld [wCurPartyLevel], a
	ld hl, wEvolvableFlags
	ld a, [wCurPartyMon]
	ld c, a
	ld b, SET_FLAG
	predef FlagPredef
	pop af
	ld [wCurPartyLevel], a

.next_mon
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	ret z
	ld [wCurPartyMon], a
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld b, h
	ld c, l
	jmp .loop

.CheckParticipation:
	ld a, [wCurPartyMon]
	ld c, a
	ld b, CHECK_FLAG
	ld d, $0
	predef FlagPredef
	ld a, c
	and a
	ret

.MaybeScaleExp:
; Distribute Exp Points evenly among participants, and maybe scale Exp on level
	push bc

	; Distribute among participants as follows:
	; p=participats e=exp share holders
	; If p or e is zero, just do 1/p or 1/e.
	; Otherwise; P=e if participant, otherwise 0, E=p if holder, otherwise 0
	; exp = current(E+P)/(2ep)
	ld a, [wGivingExperienceToExpShareHolders]
	ld d, a
	call GetParticipantsNotFainted
	ld e, a
	and a
	ld a, d
	jr z, .single_factor
	and a
	ld a, e
	jr z, .single_factor

	; We are dealing with both participants and exp share holders.
	; First, verify that we are a participant.
	push de
	ld b, 0
	ld hl, wGivingExperienceToExpShareHolders
	push bc
	call .CheckParticipation
	pop bc
	pop de
	push af
	ld a, d
	call .GetBits
	ld d, a
	pop af
	jr z, .done_exp_share_pe
	inc b

.done_exp_share_pe
	push de
	push bc
	call GetParticipantVar
	call .CheckParticipation
	pop bc
	pop de
	push af
	ld a, e
	call .GetBits
	ld e, a
	pop af
	jr z, .done_participants_pe
	set 1, b

.done_participants_pe
	push de
	xor a
	bit 0, b
	jr z, .not_a_participant
	add e
.not_a_participant
	bit 1, b
	jr z, .not_a_holder
	add d
.not_a_holder
	ldh [hMultiplier], a
	call Multiply
	pop de
	ld a, d
	ld c, e
	call SimpleMultiply
	add a
	ldh [hDivisor], a
	ld b, 4
	call Divide
	jr .done_sharing_exp

.single_factor
	call .GetBits
	ldh [hDivisor], a
	ld b, 4
	call Divide

.done_sharing_exp
	ld a, [wInitialOptions]
	bit SCALED_EXP, a
	jr z, .done_scaling

	; Level multiplier
	ld a, [wEnemyMonLevel]
	ld c, a
	add a
	add 10
	ld d, a

	; Level divider
	ld hl, wPartyMon1Level
	ld a, [wCurPartyMon]
	call GetPartyLocation
	ld a, [hl]
	add c
	add 10
	ld e, a

	call .ScaleMod
	call .ScaleMod
	ld a, d
	call .GetSqrt
	ld d, a
	ld a, e
	call .GetSqrt
	ld e, a
	call .ScaleMod

.done_scaling
	pop bc
	ret

.ScaleMod:
	ld a, d
	ldh [hMultiplier], a
	call Multiply
	ld a, e
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

.GetSqrt:
	push bc
	cp 225
	ld c, 15
	jr nc, .got_result
	ld b, a
	ld c, 0
.squareloop
	inc c
	ld a, c
	call SimpleMultiply
	cp b
	jr c, .squareloop
	jr z, .got_result
	dec c
.got_result
	ld a, c
	pop bc
	ret

.GetBits:
; get amounts of bits set among bit 0-5 in a
	push bc
	lb bc, 6, 0
.bitloop
	rrca
	jr nc, .bitloopnext
	inc c
.bitloopnext
	dec b
	jr nz, .bitloop
	ld a, c
	pop bc
	ret

GiveBattleEVs:
; prepare registers for EV gain loop.
; b: contains EV yield data
; c: loop iterator
; d: bit 0 is set on pokérus, bit 1 on macho brace
; e: set to abcdef00, where a: HP EV boosted, etc, for
; power items
	push de
	lb de, 0, 0
	; check pokérus
	ld hl, MON_PKRUS
	add hl, bc
	ld a, [hl]
	and a
	jr z, .check_item
	set 0, d
.check_item
	; check held item
	push bc
	ld hl, wBattleMonItem
	ld b, [hl]
	farcall GetItemHeldEffect
	ld a, b
	cp HELD_EV_DOUBLE
	call z, .item_double
	cp HELD_EV_HP_UP
	call z, .item_hpup
	cp HELD_EV_ATK_UP
	call z, .item_atkup
	cp HELD_EV_DEF_UP
	call z, .item_defup
	cp HELD_EV_SPD_UP
	call z, .item_spdup
	cp HELD_EV_SAT_UP
	call z, .item_satup
	cp HELD_EV_SDF_UP
	call z, .item_sdfup
	pop bc
	ld hl, MON_EVS
	add hl, bc
	push bc
	push hl
	ld a, MON_SPECIES
	call OTPartyAttr
	ld [wCurSpecies], a
	call GetEnemyMonVariant
	pop hl
	call GetBaseData
	; EV yield format:
	; Byte 1: xxyyzzmm x: HP, y: Atk, z: Def, m: Spd
	; Byte 2: aabb0000 a: Sat, b: Sdf, 0: unused
	ld a, [wBaseEVYield1]
	ld b, a
	ld c, 6 ; iterator
.loop
	rlc b
	rlc b
	rlc e
	ld a, b
	and $3
	; Check power item. Since e is formatted as
	; abcdef00 (a=hp b=atk c=def etc), and we do rlc e on
	; each iteration, bit 0 will be 1 if we have the
	; power item for the current stat.
	bit 0, e
	jr z, .no_power_item
	add 8
.no_power_item
	; check EV doubling with pokerus or macho brace
	bit 0, d
	jr z, .no_pokerus
	add a
.no_pokerus
	bit 1, d
	jr z, .add
	add a
.add
	add [hl]
	jr c, .ev_overflow

	; Check if our EV is >252 in the stat, and if so,
	; revert it to 252.
	cp 252 + 1
	jr c, .add_done
.ev_overflow
	ld a, 252
.add_done
	ld [hli], a
	dec c
	jr z, .done
	; For Sat and Sdf, we want to use byte 2
	ld a, c
	cp 2
	jr nz, .loop
	ld a, [wBaseEVYield2]
	ld b, a
	jr .loop
.done
	pop bc
	pop de
	ret
.item_double
	set 1, d
	ret
.item_hpup
	set 7, e
	ret
.item_atkup
	set (6 - ATTACK), e ; 6
	ret
.item_defup
	set (6 - DEFENSE), e ; 5
	ret
.item_spdup
	set (6 - SPEED), e ; 4
	ret
.item_satup
	set (6 - SP_ATTACK), e ; 3
	ret
.item_sdfup
	set (6 - SP_DEFENSE), e ; 2
	ret

BoostExp:
	ln a, 3, 2 ; x1.5
	jmp MultiplyAndDivide

Text_PkmnGainedExpPoint:
	text_far Text_Gained
	text_asm
	ld hl, TextJump_StringBuffer2ExpPoints
	ld a, [wStringBuffer2 + 3] ; IsTradedMon
	and a
	ret z

	ld hl, TextJump_ABoostedStringBuffer2ExpPoints
	ret

TextJump_ABoostedStringBuffer2ExpPoints:
	text_far Text_ABoostedStringBuffer2ExpPoints
	text_end

TextJump_StringBuffer2ExpPoints:
	text_far Text_StringBuffer2ExpPoints
	text_end

AnimateExpBar:
	push bc

	ld hl, wCurPartyMon
	ld a, [wCurBattleMon]
	cp [hl]
	jmp nz, .finish

	ld a, [wBattleMonLevel]
	cp MAX_LEVEL
	jmp nc, .finish

	ldh a, [hQuotient + 2]
	ld [wExperienceGained + 2], a
	push af
	ldh a, [hQuotient + 1]
	ld [wExperienceGained + 1], a
	push af
	ldh a, [hQuotient]
	ld [wExperienceGained], a
	push af
	xor a ; PARTYMON
	ld [wMonType], a
	predef CopyPkmnToTempMon
	ld a, [wTempMonLevel]
	ld b, a
	ld e, a
	push de
	ld de, wTempMonExp + 2
	call CalcExpBar
	push bc
	ld hl, wTempMonExp + 2
	ld a, [wExperienceGained + 2]
	add [hl]
	ld [hld], a
	ld a, [wExperienceGained + 1]
	adc [hl]
	ld [hld], a
	jr nc, .NoOverflow
	inc [hl]
	jr nz, .NoOverflow
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

.NoOverflow:
	ld d, MAX_LEVEL
	farcall CalcExpAtLevel
	ldh a, [hProduct + 1]
	ld b, a
	ldh a, [hProduct + 2]
	ld c, a
	ldh a, [hProduct + 3]
	ld d, a
	ld hl, wTempMonExp + 2
	ld a, [hld]
	sub d
	ld a, [hld]
	sbc c
	ld a, [hl]
	sbc b
	jr c, .AlreadyAtMaxExp
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, d
	ld [hld], a

.AlreadyAtMaxExp:
	farcall CalcLevel
	ld a, d
	pop bc
	pop de
	ld d, a
	cp e
	jr nc, .LoopLevels
	ld a, e
	ld d, a

.LoopLevels:
	ld a, e
	cp MAX_LEVEL
	jr nc, .FinishExpBar
	cp d
	jr z, .FinishExpBar
	inc a
	ld [wTempMonLevel], a
	ld [wCurPartyLevel], a
	ld [wBattleMonLevel], a
	push de
	call .PlayExpBarSound
	ld c, $40
	call .LoopBarAnimation
	call PrintPlayerHUD
	ld hl, wBattleMonNickname
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	call TerminateExpBarSound
	ld de, SFX_HIT_END_OF_EXP_BAR
	call PlaySFX
	farcall AnimateEndOfExpBar
	call WaitSFX
	ld hl, BattleText_StringBuffer1GrewToLevel
	call StdBattleTextbox
	pop de
	inc e
	ld b, $0
	jr .LoopLevels

.FinishExpBar:
	push bc
	ld b, d
	ld de, wTempMonExp + 2
	call CalcExpBar
	ld a, b
	pop bc
	ld c, a
	call .PlayExpBarSound
	call .LoopBarAnimation
	call TerminateExpBarSound
	pop af
	ldh [hQuotient], a
	pop af
	ldh [hQuotient + 1], a
	pop af
	ldh [hQuotient + 2], a

.finish
	pop bc
	ret

.PlayExpBarSound:
	push bc
	call WaitSFX
	ld de, SFX_EXP_BAR
	call PlaySFX
	ld c, 10
	call DelayFrames
	pop bc
	ret

.LoopBarAnimation:
	ld d, 3
	dec b
.anim_loop
	inc b
	push bc
	push de
	hlcoord 12, 11
	call PlaceExpBar
	pop de
	call .delay
	pop bc
	ld a, c
	cp b
	jr z, .end_animation
	inc b
	push bc
	push de
	hlcoord 12, 11
	call PlaceExpBar
	pop de
	call .delay
	dec d
	jr nz, .min_number_of_frames
	ld d, 1
.min_number_of_frames
	pop bc
	ld a, c
	cp b
	jr nz, .anim_loop
.end_animation
	ld a, $1
	ldh [hBGMapMode], a
	ret

.delay
	xor a
	ldh [hCGBPalUpdate], a
	inc a
	ldh [hBGMapMode], a
	ldh [hBGMapHalf], a
	ld c, d
	call DelayFrames
	xor a
	ldh [hBGMapMode], a
	inc a
	ldh [hCGBPalUpdate], a
	ret

GetNewBaseExp:
; basic stage mons: BST*0.2
; stage 1 or non-evolver: BST*0.35
; stage 2 or legendaries: BST*0.45
; exceptions: Chansey, Blissey
	ld a, MON_SPECIES
	call OTPartyAttr
	ld hl, NewBaseExpExceptions
	ld de, 3
	call IsInArray
	jr nc, .calc_base_exp
	inc hl
	ld a, [hli]
	ldh [hMultiplicand + 2], a
	ld a, [hl]
	ldh [hMultiplicand + 1], a
	ret

.calc_base_exp
	ld hl, 0
	ld de, wBaseHP
	ld b, 6
.bst_loop
	ld a, [de]
	ld c, a
	inc de
	push bc
	ld b, 0
	add hl, bc
	pop bc
	dec b
	jr nz, .bst_loop

	ld a, h
	ldh [hMultiplicand + 1], a
	ld a, l
	ldh [hMultiplicand + 2], a

	ld a, [wCurSpecies]
	ld [wCurPartySpecies], a

	farcall GetPreEvolution
	jr c, .not_basic

	; let's see if we have an evolution
	; c = species
	ld a, [wCurPartySpecies]
	ld c, a
	; b = form
	ld a, MON_FORM
	call OTPartyAttr
	and SPECIESFORM_MASK
	ld b, a
	; bc = index
	call GetSpeciesAndFormIndex
	dec bc
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord

	ld a, BANK(EvosAttacks)
	call GetFarByte
	and a
	ld a, 4 ; basic mon (not evolved, but can evolve): *4/20 -> *0.2
	jr nz, .got_multiplier
	jr .stage_1_or_nonevolver

.not_basic
	ld hl, LegendaryMons
	call IsInByteArray
	jr c, .legendary
	farcall GetPreEvolution
.legendary
	ld a, 9 ; stage 2 or legendary: *9/20 -> *0.45
	jr c, .got_multiplier
.stage_1_or_nonevolver
	ld a, 7 ; stage 1 or non-evolver: *7/20 -> *0.35
.got_multiplier
	ldh [hMultiplier], a
	call Multiply
	ld a, 20
	ldh [hDivisor], a
	ld b, 4
	jmp Divide

INCLUDE "data/pokemon/base_exp_exceptions.asm"

Function_BattleTextEnemySentOut:
	farcall Battle_GetTrainerName
	ld hl, BattleText_EnemySentOut
	jmp StdBattleTextbox

UserSentOutText:
	ldh a, [hBattleTurn]
	and a
	jr nz, Function_BattleTextEnemySentOut

	ld a, [wLinkMode]
	and a
	jr z, .not_linked

	ld hl, JumpText_GoPkmn ; If we're in a LinkBattle print just "Go <PlayerMon>"

	ld a, [wTotalBattleTurns]
	and a
	jr z, .skip_to_textbox

.not_linked
; Depending on the HP of the enemy Pkmn, the game prints a different text
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ld hl, JumpText_GoPkmn
	jr z, .skip_to_textbox

	; compute enemy health remaining as a percentage
	xor a
	ldh [hMultiplicand + 0], a
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wEnemyHPAtTimeOfPlayerSwitch], a
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ld [wEnemyHPAtTimeOfPlayerSwitch + 1], a
	ldh [hMultiplicand + 2], a
	ld a, 25
	ldh [hMultiplier], a
	call Multiply
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b
	ld a, b
	ld b, 4
	ldh [hDivisor], a
	call Divide

	ldh a, [hQuotient + 2]
	ld hl, JumpText_GoPkmn
	cp 70
	jr nc, .skip_to_textbox

	ld hl, JumpText_DoItPkmn
	cp 40
	jr nc, .skip_to_textbox

	ld hl, JumpText_GoForItPkmn
	cp 10
	jr nc, .skip_to_textbox

	ld hl, JumpText_YourFoesWeakGetmPkmn
.skip_to_textbox
	jmp BattleTextbox

JumpText_GoPkmn:
	text_far Text_GoPkmn
	text_asm
	jr Function_TextJump_BattleMonNick01

JumpText_DoItPkmn:
	text_far Text_DoItPkmn
	text_asm
	jr Function_TextJump_BattleMonNick01

JumpText_GoForItPkmn:
	text_far Text_GoForItPkmn
	text_asm
	jr Function_TextJump_BattleMonNick01

JumpText_YourFoesWeakGetmPkmn:
	text_far Text_YourFoesWeakGetmPkmn
	text_asm
Function_TextJump_BattleMonNick01:
	ld hl, TextJump_BattleMonNick01
	ret

TextJump_BattleMonNick01:
	text_far Text_BattleMonNick01
	text_end

WithdrawPkmnText:
	ld hl, .WithdrawPkmnText
	jmp BattleTextbox

.WithdrawPkmnText:
	text_far Text_BattleMonNickComma
	text_asm
; Print text to withdraw Pkmn
; depending on HP the message is different
	push de
	push bc
	ld hl, wEnemyMonHP + 1
	ld de, wEnemyHPAtTimeOfPlayerSwitch + 1
	ld b, [hl]
	dec hl
	ld a, [de]
	sub b
	ldh [hMultiplicand + 2], a
	dec de
	ld b, [hl]
	ld a, [de]
	sbc b
	ldh [hMultiplicand + 1], a
	ld a, 25
	ldh [hMultiplier], a
	call Multiply
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b
	ld a, b
	ld b, 4
	ldh [hDivisor], a
	call Divide
	pop bc
	pop de
	ldh a, [hQuotient + 2]
	ld hl, TextJump_ThatsEnoughComeBack
	and a
	ret z

	ld hl, TextJump_ComeBack
	cp 30
	ret c

	ld hl, TextJump_OKComeBack
	cp 70
	ret c

	ld hl, TextJump_GoodComeBack
	ret

TextJump_ThatsEnoughComeBack:
	text_far Text_ThatsEnoughComeBack
	text_end

TextJump_OKComeBack:
	text_far Text_OKComeBack
	text_end

TextJump_GoodComeBack:
	text_far Text_GoodComeBack
	text_end

TextJump_ComeBack:
	text_far Text_ComeBack
	text_end

HandleSafariAngerEatingStatus:
	ld hl, wSafariMonEating
	ld a, [hl]
	and a
	jr z, .angry
	dec [hl]
	ld hl, BattleText_WildPkmnIsEating
	jr .finish

.angry
	dec hl ; wSafariMonAngerCount
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld hl, BattleText_WildPkmnIsAngry
	jr nz, .finish
	push hl
	; reset the catch rate to normal if bait/rock effects have worn off
	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	call GetEnemyMonVariant
	call GetBaseData
	ld a, [wBaseCatchRate]
	ld [wEnemyMonCatchRate], a
	pop hl

.finish
	push hl
	call Call_LoadTempTileMapToTileMap
	pop hl
	jmp StdBattleTextbox

FillInExpBar:
	push hl
	call CalcExpBar
	pop hl
PlaceExpBar:
	ld c, 7 ; number of tiles
.loop1
	ld a, b
	sub $8
	jr c, .next
	ld b, a
	ld a, "<FULLXP>"
	ld [hli], a
	dec c
	ret z
	jr .loop1

.next
	add $8
	jr z, .loop2
	add "<NOXP>"
	jr .skip

.loop2
	ld a, "<NOXP>"

.skip
	ld [hli], a
	ld a, "<NOXP>"
	dec c
	jr nz, .loop2
	ret

CalcExpBar:
; Calculate the percent exp between this level and the next
; Level in b
	push de
	ld d, b
	push de
	farcall CalcExpAtLevel
	pop de
; exp at current level gets pushed to the stack
	ld hl, hMultiplicand
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	ld a, [hl]
	push af
; next level
	inc d
	farcall CalcExpAtLevel
; back up the next level exp, and subtract the two levels
	ld hl, hMultiplicand + 2
	ld a, [hl]
	ldh [hMathBuffer + 2], a
	pop bc
	sub b
	ld [hld], a
	ld a, [hl]
	ldh [hMathBuffer + 1], a
	pop bc
	sbc b
	ld [hld], a
	ld a, [hl]
	ldh [hMathBuffer], a
	pop bc
	sbc b
	ld [hl], a
	pop de

	ld hl, hMultiplicand + 1
	ld a, [hli]
	push af
	ld a, [hl]
	push af

; get the amount of exp remaining to the next level
	ld a, [de]
	dec de
	ld c, a
	ldh a, [hMathBuffer + 2]
	sub c
	ld [hld], a
	ld a, [de]
	dec de
	ld b, a
	ldh a, [hMathBuffer + 1]
	sbc b
	ld [hld], a
	ld a, [de]
	ld c, a
	ldh a, [hMathBuffer]
	sbc c
	ld [hld], a
	xor a
	ld [hl], a
; multiply by (7 tiles * 8 px/tile) = 56 px
	ld a, 56
	ldh [hMultiplier], a
	call Multiply
	pop af
	ld c, a
	pop af
	ld b, a
.loop
	ld a, b
	and a
	jr z, .done
	srl b
	rr c
	ld hl, hProduct
	srl [hl]
	inc hl
	rr [hl]
	inc hl
	rr [hl]
	inc hl
	rr [hl]
	jr .loop

.done
	ld a, c
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	cpl
	add 56 + 1 ; a = 56 - a
	ld b, a
	ret

GetMonBackpic:
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	ld hl, BattleAnimCmd_RaiseSub
	jr nz, GetBackpic_DoAnim ; substitute

DropPlayerSub:
	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_MINIMIZED, a
	ld hl, BattleAnimCmd_MinimizeOpp
	jr nz, GetBackpic_DoAnim
	ld a, [wCurPartySpecies]
	push af
	ld a, [wBattleMonSpecies]
	ld [wCurPartySpecies], a
	call GetBattleMonVariant
	ld de, vTiles2 tile $31
	predef GetBackpic
	pop af
	ld [wCurPartySpecies], a
	ret

GetBackpic_DoAnim:
	ldh a, [hBattleTurn]
	push af
	xor a
	ldh [hBattleTurn], a
	ld a, BANK(BattleAnimCommands)
	call FarCall_hl
	pop af
	ldh [hBattleTurn], a
	ret

GetMonFrontpic:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	ld hl, BattleAnimCmd_RaiseSub
	jr nz, GetFrontpic_DoAnim

DropEnemySub:
	ld a, [wEnemySubStatus2]
	bit SUBSTATUS_MINIMIZED, a
	ld hl, BattleAnimCmd_MinimizeOpp
	jr nz, GetFrontpic_DoAnim

	ld a, [wCurPartySpecies]
	push af
	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetEnemyMonVariant
	call GetBaseData
	ld de, vTiles2
	predef FrontpicPredef
	pop af
	ld [wCurPartySpecies], a
	ret

GetFrontpic_DoAnim:
	ldh a, [hBattleTurn]
	push af
	call SetEnemyTurn
	ld a, BANK(BattleAnimCommands)
	call FarCall_hl
	pop af
	ldh [hBattleTurn], a
	ret

StartBattle:
; This check prevents you from entering a battle without any Pokemon.
; Those using walk-through-walls to bypass getting a Pokemon experience
; the effects of this check.
	ld a, [wPartyCount]
	and a
	ret z

	ld a, [wTimeOfDayPal]
	push af
	call BattleIntro
	call DoBattle
	call ExitBattle
	pop af
	ld [wTimeOfDayPal], a
	scf
	ret

BattleIntro:
	call LoadTrainerOrWildMonPic
	xor a
	ld [wTempBattleMonSpecies], a
	ld [wBattleMenuCursorBuffer], a
	xor a
	ldh [hMapAnims], a
	ld a, [wOtherTrainerClass]
	cp LYRA2
	jr z, .skip_music ; assume that the music is already playing
	farcall PlayBattleMusic
.skip_music
	farcall ShowLinkBattleParticipants
	farcall FindFirstAliveMonAndStartBattle
	call DisableSpriteUpdates
	farcall ClearBattleRAM
	call InitEnemy
	call BackUpBGMap2
	ld a, CGB_BATTLE_GRAYSCALE
	call GetCGBLayout
	ld hl, rLCDC
	res 6, [hl] ; win tilemap 0
	call InitBattleDisplay
	call BattleStartMessage
	ld hl, rLCDC
	set 6, [hl] ; win tilemap 1
	xor a
	ldh [hBGMapMode], a
	call EmptyBattleTextbox
	hlcoord 9, 7
	lb bc, 5, 11
	call ClearBox
	hlcoord 0, 0
	lb bc, 4, 12
	call ClearBox
	call ClearSprites
	ld a, [wBattleMode]
	dec a
	call z, UpdateEnemyHUD
	ld a, $1
	ldh [hBGMapMode], a
	ret

LoadTrainerOrWildMonPic:
	ld a, [wOtherTrainerClass]
	and a
	jr nz, .Trainer
	ld a, [wTempWildMonSpecies]
	ld [wCurPartySpecies], a

.Trainer:
	ld [wTempEnemyMonSpecies], a
	ret

BackUpBGMap2:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	ld hl, wDecompressScratch
	ld bc, $40 tiles ; vBGMap3 - vBGMap2
	ld a, $2
	rst ByteFill
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	ld de, wDecompressScratch
	hlbgcoord 0, 0 ; vBGMap2
	lb bc, BANK(BackUpBGMap2), $40
	call Request2bpp
	pop af
	ldh [rVBK], a
	pop af
	ldh [rSVBK], a
	ret

InitEnemy:
	ld a, [wOtherTrainerClass]
	and a
	jr z, InitEnemyWildmon ; wild
	; fallthrough

InitEnemyTrainer:
	ld [wTrainerClass], a
	xor a
	ld [wTempEnemyMonSpecies], a
	farcall GetTrainerAttributes
	farcall ReadTrainerParty
	farcall ComputeTrainerReward
	ld de, vTiles2
	farcall GetTrainerPic
	xor a
	ldh [hGraphicStartTile], a
	dec a
	ld [wEnemyItemState], a
	hlcoord 12, 0
	lb bc, 7, 7
	predef PlaceGraphic
	ld a, -1
	ld [wCurOTMon], a
	ld a, TRAINER_BATTLE
	ld [wBattleMode], a

	call IsBossTrainer
	ret nc
	xor a
	ld [wCurPartyMon], a
	ld a, [wPartyCount]
	ld b, a
.partyloop
	push bc
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	or [hl]
	jr z, .skipfaintedmon
	ld c, HAPPINESS_GYMBATTLE
	predef ChangeHappiness
.skipfaintedmon
	pop bc
	dec b
	ret z
	ld hl, wCurPartyMon
	inc [hl]
	jr .partyloop

InitEnemyWildmon:
	ld a, WILD_BATTLE
	ld [wBattleMode], a
	call LoadEnemyMon
	call SetEnemyTurn
	ld a, 1
	ld [wEnemySwitchTarget], a
	call SendInUserPkmn
	ld hl, wOTPartyMon1Form
	predef GetVariant

	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .skip_unown
	ld a, [wFirstUnownSeen]
	and a
	jr nz, .skip_unown
	ld a, [wCurForm]
	ld [wFirstUnownSeen], a
.skip_unown

	ld a, [wCurPartySpecies]
	cp MAGIKARP
	jr nz, .skip_magikarp
	ld a, [wFirstMagikarpSeen]
	and a
	jr nz, .skip_magikarp
	ld a, [wCurForm]
	ld [wFirstMagikarpSeen], a
.skip_magikarp

	ld de, vTiles2
	predef FrontpicPredef
	xor a
	ld [wTrainerClass], a
	ldh [hGraphicStartTile], a
	hlcoord 12, 0
	lb bc, 7, 7
	predef_jump PlaceGraphic

ExitBattle:
	call .HandleEndOfBattle
	call HandleNuzlockeFlags
	call BattleEnd_HandleRoamMons
	xor a
	ld [wLowHealthAlarm], a
	ld [wBattleMode], a
	ld [wBattleType], a
	ld [wAttackMissed], a
	ld [wTempWildMonSpecies], a
	ld [wOtherTrainerClass], a
	ld [wEnemyFleeing], a
	ld [wNumFleeAttempts], a
	ld [wPartyMenuCursor], a
	ld [wKeyItemsPocketCursor], a
	ld [wItemsPocketCursor], a
	ld [wBattleMenuCursorBuffer], a
	ld [wCurMoveNum], a
	ld [wBallsPocketCursor], a
	ld [wMenuScrollPosition], a
	ld [wKeyItemsPocketScrollPosition], a
	ld [wItemsPocketScrollPosition], a
	ld [wBallsPocketScrollPosition], a
	ld hl, wBattleSubStatusWRAM
	ld b, wBattleSubStatusWRAMEnd - wBattleSubStatusWRAM
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	jmp WaitSFX

.HandleEndOfBattle:
	ld a, [wLinkMode]
	and a
	jr z, .not_linked
	call ShowLinkBattleParticipantsAfterEnd
	ld c, 150
	call DelayFrames
	jmp ShowLinkBattleResult

.not_linked
	ld a, [wBattleResult]
	and $f
	ret nz
	call CheckPayDay
	xor a
	ld [wForceEvolution], a
	farcall EvolveAfterBattle
	farjp GivePokerusAndConvertBerries

HandleNuzlockeFlags:
	ld a, [wBattleMode]
	dec a
	ret nz

	; Dupes clause: don't count duplicate encounters
	ld a, [wTempEnemyMonSpecies]
	dec a
	call CheckCaughtMon
	ret nz

	; Only flag landmarks for Nuzlocke runs after getting Poké Balls
	eventflagcheck EVENT_LEARNED_TO_CATCH_POKEMON
	ret z

	; Get current landmark
	call GetCurrentLandmark

	; Use landmark as index into flag array
	ld c, a
	ld hl, wNuzlockeLandmarkFlags
	ld b, SET_FLAG
	predef_jump FlagPredef

CheckPayDay:
	ld hl, wPayDayMoney
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	ret z
	ld a, [wAmuletCoin]
	and a
	jr z, .okay
	ld hl, wPayDayMoney + 2
	sla [hl]
	dec hl
	rl [hl]
	dec hl
	rl [hl]
	jr nc, .okay
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

.okay
	ld hl, wPayDayMoney + 2
	ld de, wMoney + 2
	call AddBattleMoneyToAccount
	ld hl, BattleText_PlayerPickedUpPayDayMoney
	call StdBattleTextbox
	ld a, [wInBattleTowerBattle]
	and a
	ret z
	call ClearTileMap
	jmp ClearBGPalettes

ShowLinkBattleParticipantsAfterEnd:
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	call GetPartyLocation
	ld a, [wEnemyMonStatus]
	ld [hl], a
	call ClearTileMap
	farjp _ShowLinkBattleParticipants

ShowLinkBattleResult:
	ld a, [wBattleResult]
	and $f
	cp $1
	jr c, .victory
	jr z, .loss
	ld de, .Draw
	jr .store_result

.victory
	ld de, .Win
	jr .store_result

.loss
	ld de, .Lose
	; fallthrough

.store_result
	hlcoord 6, 8
	rst PlaceString
	ld c, 200
	call DelayFrames

	ld a, BANK(sLinkBattleStats)
	call GetSRAMBank

	call AddLastBattleToLinkRecord
	call ReadAndPrintLinkBattleRecord

	call CloseSRAM

	call WaitPressAorB_BlinkCursor
	jmp ClearTileMap

.Win:
	db "You Win@"
.Lose:
	db "You Lose@"
.Draw:
	db "  Draw@"

DisplayLinkRecord:
	ld a, BANK(sLinkBattleStats)
	call GetSRAMBank

	call ReadAndPrintLinkBattleRecord

	call CloseSRAM
	hlcoord 0, 0, wAttrMap
	xor a
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
	call ApplyAttrAndTilemapInVBlank
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call SetPalettes
	ld c, 8
	call DelayFrames
	jmp WaitPressAorB_BlinkCursor

ReadAndPrintLinkBattleRecord:
	call ClearTileMap
	call ClearSprites
	call .PrintBattleRecord
	hlcoord 0, 8
	ld b, NUM_LINK_BATTLE_RECORDS
	ld de, sLinkBattleRecord1Name
.loop
	push bc
	push hl
	push de
	ld a, [de]
	and a
	jr z, .PrintFormatString
	ld a, [wSavedAtLeastOnce]
	and a
	jr z, .PrintFormatString
	push hl
	push hl
	ld h, d
	ld l, e
	ld de, wLinkBattleRecordName
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	ld a, "@"
	ld [de], a
	inc de
	ld bc, 6
	rst CopyBytes
	ld de, wLinkBattleRecordName
	pop hl
	rst PlaceString
	pop hl
	ld de, 26
	add hl, de
	push hl
	ld de, wLinkBattleRecordWins
	lb bc, 2, 4
	call PrintNum
	pop hl
	ld de, 5
	add hl, de
	push hl
	ld de, wLinkBattleRecordLosses
	lb bc, 2, 4
	call PrintNum
	pop hl
	ld de, 5
	add hl, de
	ld de, wLinkBattleRecordDraws
	lb bc, 2, 4
	call PrintNum
	jr .next

.PrintFormatString:
	ld de, .Format
	rst PlaceString
.next
	pop hl
	ld bc, LINK_BATTLE_RECORD_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop
	ret

.PrintBattleRecord:
	hlcoord 1, 0
	ld de, .Record
	rst PlaceString

	hlcoord 0, 6
	ld de, .Result
	rst PlaceString

	hlcoord 0, 2
	ld de, .Total
	rst PlaceString

	hlcoord 6, 4
	ld de, sLinkBattleWins
	call .PrintZerosIfNoSaveFileExists
	ret c

	lb bc, 2, 4
	call PrintNum

	hlcoord 11, 4
	ld de, sLinkBattleLosses
	call .PrintZerosIfNoSaveFileExists

	lb bc, 2, 4
	call PrintNum

	hlcoord 16, 4
	ld de, sLinkBattleDraws
	call .PrintZerosIfNoSaveFileExists

	lb bc, 2, 4
	jmp PrintNum

.PrintZerosIfNoSaveFileExists:
	ld a, [wSavedAtLeastOnce]
	and a
	ret nz
	ld de, .Scores
	rst PlaceString
	scf
	ret

.Scores:
	db "   0    0    0@"

.Format:
	db "  ---  <LNBRK>"
	db "         -    -    -@"
.Record:
	db "<PLAYER>'s Record@"
.Result:
	db "Result Win Lose Draw@"
.Total:
	db "Total  Win Lose Draw@"

BattleEnd_HandleRoamMons:
	ld a, [wBattleType]
	cp BATTLETYPE_ROAMING
	jr nz, .not_roaming
	ld a, [wBattleResult]
	and $f
	jr z, .caught_or_defeated_roam_mon
	call GetRoamMonHP
	ld a, [wEnemyMonHP + 1]
	ld [hl], a

	; copy status, but preserve bad poison as regular poison
	call GetRoamMonStatus
	ld a, [wEnemyMonStatus]
	res TOX, a
	ld [hl], a
	jr .update_roam_mons

.caught_or_defeated_roam_mon
	call GetRoamMonHP
	ld [hl], $0
	ld a, wRoamMon1MapGroup - wRoamMon1
	call DoGetRoamMonData
	ld [hl], $ff
	ld a, wRoamMon1MapNumber - wRoamMon1
	call DoGetRoamMonData
	ld [hl], $ff
	xor a ; ld a, wRoamMon1Species - wRoamMon1
	call DoGetRoamMonData
	ld [hl], $0
	ret

.not_roaming
	call BattleRandom
	and $f
	ret nz

.update_roam_mons
	farjp UpdateRoamMons

GetRoamMonHP:
; output: hl = wRoamMon#HP
	ld a, wRoamMon1HP - wRoamMon1
	jr DoGetRoamMonData

GetRoamMonStatus:
; output: hl = wRoamMon#Status
	ld a, wRoamMon1Status - wRoamMon1
	jr DoGetRoamMonData

GetRoamMonDVs:
	ld a, wRoamMon1DVs - wRoamMon1
	; fallthrough

DoGetRoamMonData:
; output: hl = wRoamMon# + a
	push de
	ld d, 0
	ld e, a
	ld a, [wTempEnemyMonSpecies]
	ld hl, wRoamMon1Species
	cp [hl]
	jr z, .get_data
	ld hl, wRoamMon2Species
	cp [hl]
	jr z, .get_data
	ret z
	ld hl, wRoamMon3Species
.get_data
	add hl, de
	pop de
	ret

AddLastBattleToLinkRecord:
	ld hl, wOTPlayerID
	ld de, wStringBuffer1
	ld bc, 2
	rst CopyBytes
	ld hl, wOTPlayerName
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	ld hl, sLinkBattleResults
	call .StoreResult
	ld hl, sLinkBattleRecord
	ld d, 5
.loop
	push hl
	inc hl
	inc hl
	ld a, [hld]
	dec hl
	and a
	jr z, .copy
	push de
	ld c, 12
	ld de, wStringBuffer1
	call StringCmp
	pop de
	pop hl
	jr z, .done
	ld bc, 18
	add hl, bc
	dec d
	jr nz, .loop
	ld bc, -18
	add hl, bc
	push hl

.copy
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, 12
	rst CopyBytes
	ld b, 6
	xor a
.loop2
	ld [de], a
	inc de
	dec b
	jr nz, .loop2
	pop hl

.done
	call .StoreResult
	ld b, 5
	ld hl, sLinkBattleRecord + 17
	ld de, wLinkBattleRecordBuffer
.loop3
	push bc
	push de
	push hl
	call .LoadPointer
	pop hl
	ld a, e
	pop de
	ld [de], a
	inc de
	ld a, b
	ld [de], a
	inc de
	ld a, c
	ld [de], a
	inc de
	ld bc, 18
	add hl, bc
	pop bc
	dec b
	jr nz, .loop3
	lb bc, 0, 1
.loop4
	ld a, b
	add b
	add b
	ld e, a
	ld d, 0
	ld hl, wLinkBattleRecordBuffer
	add hl, de
	push hl
	ld a, c
	add c
	add c
	ld e, a
	ld d, 0
	ld hl, wLinkBattleRecordBuffer
	add hl, de
	ld d, h
	ld e, l
	pop hl
	push bc
	ld c, 3
	call StringCmp
	pop bc
	jr z, .equal
	jr nc, .done2

.equal
	inc c
	ld a, c
	cp $5
	jr nz, .loop4
	inc b
	ld c, b
	inc c
	ld a, b
	cp $4
	jr nz, .loop4
	ret

.done2
	push bc
	ld a, b
	ld bc, 18
	ld hl, sLinkBattleRecord
	rst AddNTimes
	push hl
	ld de, wLinkBattleRecordBuffer
	ld bc, 18
	rst CopyBytes
	pop hl
	pop bc
	push hl
	ld a, c
	ld bc, 18
	ld hl, sLinkBattleRecord
	rst AddNTimes
	pop de
	push hl
	ld bc, 18
	rst CopyBytes
	ld hl, wLinkBattleRecordBuffer
	ld bc, 18
	pop de
	rst CopyBytes
	ret

.LoadPointer:
	ld e, $0
	ld a, [hld]
	ld c, a
	ld a, [hld]
	ld b, a
	ld a, [hld]
	add c
	ld c, a
	ld a, [hld]
	adc b
	ld b, a
	jr nc, .okay2
	inc e

.okay2
	ld a, [hld]
	add c
	ld c, a
	ld a, [hl]
	adc b
	ld b, a
	ret nc
	inc e
	ret

.StoreResult:
	ld a, [wBattleResult]
	and $f
	cp $1
	ld bc, sLinkBattleWins + 1 - sLinkBattleResults
	jr c, .okay
	ld bc, sLinkBattleLosses + 1 - sLinkBattleResults
	jr z, .okay
	ld bc, sLinkBattleDraws + 1 - sLinkBattleResults
.okay
	add hl, bc
	call .CheckOverflow
	ret nc
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ret

.CheckOverflow:
	dec hl
	ld a, [hli]
	cp HIGH(MAX_LINK_RECORD)
	ret c
	ld a, [hl]
	cp LOW(MAX_LINK_RECORD)
	ret

InitBattleDisplay:
	call .InitBackPic
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	hlcoord 1, 5
	lb bc, 3, 7
	call ClearBox
	call LoadStandardFont
	call _LoadBattleFontsHPBar
	call .BlankBGMap
	xor a
	ldh [hMapAnims], a
	ldh [hSCY], a
	ld a, $90
	ldh [hWY], a
	ldh [rWY], a
	call ApplyTilemapInVBlank
	xor a
	ldh [hBGMapMode], a
	farcall BattleIntroSlidingPics
	ld a, $1
	ldh [hBGMapMode], a
	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 2, 6
	lb bc, 6, 6
	predef PlaceGraphic
	call ApplyTilemapInVBlank
	call HideSprites
	ld a, CGB_BATTLE_COLORS
	call GetCGBLayout
	call SetPalettes
	xor a
	ldh [hSCX], a
	ret

.BlankBGMap:
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a

	ld hl, wScratchTileMap
	ld bc, BG_MAP_WIDTH * BG_MAP_HEIGHT
	ld a, " "
	rst ByteFill

	ld de, wScratchTileMap
	hlbgcoord 0, 0
	lb bc, BANK(.BlankBGMap), $40
	call Request2bpp

	pop af
	ldh [rSVBK], a
	ret

.InitBackPic:
	call GetTrainerBackpic
	jr CopyBackpic

GetTrainerBackpic:
; Load the player character's backpic (6x6) into VRAM starting from vTiles2 tile $31.

; Special exception for Lyra.
	ld hl, LyraBackpic
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .Decompress

; What gender are we?
	ld hl, ChrisBackpic
	ld a, [wPlayerSpriteSetupFlags]
	bit 2, a ; transformed to male
	jr nz, .Decompress
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .Decompress

	ld hl, KrisBackpic

.Decompress:
	ld de, vTiles2 tile $31
	lb bc, BANK("Trainer Backpics"), 6 * 6
	jmp DecompressRequest2bpp

CopyBackpic:
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a
	ld hl, vTiles0
	ld de, vTiles2 tile $31
	ldh a, [hROMBank]
	ld b, a
	ld c, 7 * 7
	call Get2bpp
	pop af
	ldh [rSVBK], a
	call .LoadTrainerBackpicAsOAM
	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 2, 6
	lb bc, 6, 6
	predef_jump PlaceGraphic

.LoadTrainerBackpicAsOAM:
	ld hl, wVirtualOAM
	xor a
	ldh [hMapObjectIndexBuffer], a
	ld b, $6
	ld e, 21 * 8
.outer_loop
	ld c, $3
	ld d, 8 * 8
.inner_loop
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ldh a, [hMapObjectIndexBuffer]
	ld [hli], a
	inc a
	ldh [hMapObjectIndexBuffer], a
	ld a, $1
	ld [hli], a
	ld a, d
	add $8
	ld d, a
	dec c
	jr nz, .inner_loop
	ldh a, [hMapObjectIndexBuffer]
	add $3
	ldh [hMapObjectIndexBuffer], a
	ld a, e
	add $8
	ld e, a
	dec b
	jr nz, .outer_loop
	ret

BattleStartMessage:
	ld a, [wBattleMode]
	dec a
	jr z, .wild

	ld de, SFX_SHINE
	call PlaySFX
	call WaitSFX

	ld c, 20
	call DelayFrames

	farcall Battle_GetTrainerName

	ld hl, WantToBattleText
	call CheckPluralTrainer
	jr nz, .PlaceBattleStartText
	ld hl, WantsToBattleText
	jr .PlaceBattleStartText

.wild
	call BattleCheckEnemyShininess
	jr nc, .not_shiny

	xor a
	ld [wNumHits], a
	ld a, 1
	ldh [hBattleTurn], a
	ld a, 1
	ld [wBattleAnimParam], a
	ld de, ANIM_SEND_OUT_MON
	call Call_PlayBattleAnim

.not_shiny
	call CheckSleepingTreeMon
	jr c, .skip_cry

	farcall CheckBattleEffects
	jr c, .cry_no_anim

	hlcoord 12, 0
	lb de, $0, ANIM_MON_NORMAL
	predef AnimateFrontpic
	jr .skip_cry ; cry is played during the animation

.cry_no_anim
	ld a, $f
	ld [wCryTracks], a
	ld a, [wTempEnemyMonSpecies]
	call PlayStereoCry

.skip_cry
	ld a, [wBattleType]
	cp BATTLETYPE_FISH
	jr nz, .NotFishing
	ld hl, HookedPokemonAttackedText
	jr .PlaceBattleStartText

.NotFishing:
	ld hl, PokemonFellFromTreeText
	cp BATTLETYPE_TREE
	jr z, .PlaceBattleStartText
	ld hl, LegendaryAppearedText
	cp BATTLETYPE_ROAMING
	jr z, .PlaceBattleStartText
	cp BATTLETYPE_RED_GYARADOS ; or BATTLETYPE_LEGENDARY
	jr nc, .PlaceBattleStartText
	ld hl, WildPokemonAppearedText

.PlaceBattleStartText:
	push hl
	farcall BattleStart_TrainerHuds
	pop hl
	jmp StdBattleTextbox

CheckPluralTrainer:
	ld a, [wOtherTrainerClass]
	cp TWINS
	jr z, .plural
	cp SR_AND_JR
	jr z, .plural
	cp COUPLE
	jr z, .plural
	cp ACE_DUO
	jr z, .plural
	cp JESSIE_JAMES
	jr z, .plural
	xor a
	scf
	ret

.plural
	ld a, 1
	and a
	ret

AutomaticRainWhenOvercast:
	ld a, [wLinkMode]
	and a
	ret nz
	ld a, [wInBattleTowerBattle]
	and a
	ret nz
	call GetOvercastIndex
	and a
	ret z
	ld a, WEATHER_RAIN
	ld [wBattleWeather], a
	ld a, 255
	ld [wWeatherCount], a
	ld de, RAIN_DANCE
	call Call_PlayBattleAnim
	ld hl, DownpourText
	call StdBattleTextbox
	jmp EmptyBattleTextbox

BoostGiovannisArmoredMewtwo:
	ld a, [wOtherTrainerClass]
	cp GIOVANNI
	ret nz
	ld a, [wOtherTrainerID]
	cp GIOVANNI1
	ret nz
	call SetEnemyTurn
	ld de, ANIM_SHARPEN
	call Call_PlayBattleAnim
	ld b, ATTACK
	call .forceraisestat
	ld b, DEFENSE
	call .forceraisestat
	ld b, SPEED
	call .forceraisestat
	ld b, SP_ATTACK
	call .forceraisestat
	ld b, SP_DEFENSE
.forceraisestat
	farjp ForceRaiseStat

LoadWeatherIconSprite:
	ld a, [wBattleWeather]
	and a ; WEATHER_NONE?
	ret z
	dec a ; WEATHER_RAIN?
	ld hl, WeatherRainIconGFX
	lb bc, PAL_BATTLE_OB_BLUE, 4
	jr z, .ok
	dec a ; WEATHER_SUN?
	ld hl, WeatherSunIconGFX
	ld b, PAL_BATTLE_OB_YELLOW
	jr z, .ok
	dec a ; WEATHER_SANDSTORM?
	ld hl, WeatherSandstormIconGFX
	ld b, PAL_BATTLE_OB_BROWN
	jr z, .ok
	dec a ; WEATHER_HAIL?
	ld hl, WeatherHailIconGFX
	ld b, PAL_BATTLE_OB_GRAY
	ret nz

.ok
	push bc
	ld b, BANK("Weather Icons") ; c == 4
	ld de, vTiles0 tile $00
	call DecompressRequest2bpp
	pop bc
	ld hl, wVirtualOAM
	ld de, .WeatherIconOAMData
.loop
	ld a, [de]
	inc de
	ld [hli], a ; y
	ld a, [de]
	inc de
	ld [hli], a ; x
	dec c
	ld a, c
	ld [hli], a ; tile id
	ld a, b
	ld [hli], a ; attributes
	jr nz, .loop
	ret

.WeatherIconOAMData
	; y, x
	db $80 + 8, $14 + 8 ; 3: bottom-right
	db $80 + 8, $14 + 0 ; 2: bottom-left
	db $80 + 0, $14 + 8 ; 1: top-right
	db $80 + 0, $14 + 0 ; 0: top-left
