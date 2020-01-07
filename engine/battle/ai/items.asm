AI_MaybeSwitch:
	and a

	ld a, [wBattleMode]
	dec a
	ret z

	ld a, [wLinkMode]
	and a
	ret nz

	farcall GetEnemyItem
	ld a, b
	cp HELD_SHED_SHELL
	jr z, .can_switch

	; check if we're trapped by an ability
	ld a, [hBattleTurn]
	push af
	call SetEnemyTurn
	farcall CheckIfTrappedByAbility
	pop bc
	ld a, b
	ld [hBattleTurn], a
	ret z
	call SetEnemyTurn
	push bc
	call CheckIfUserIsGhostType
	pop bc
	ld a, b
	ld [hBattleTurn], a
	jr z, .can_switch

	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_CANT_RUN, a
	ret nz

	ld a, [wEnemyWrapCount]
	and a
	ret nz

.can_switch
	ld hl, TrainerClassAttributes + TRNATTR_AI_ITEM_SWITCH
	ld a, [wInBattleTowerBattle] ; Load always the first wTrainerClass for BattleTower-Trainers
	and a
	jr nz, .ok

	ld a, [wTrainerClass]
	dec a
	ld bc, 7
	rst AddNTimes
.ok
	bit SWITCH_OFTEN_F, [hl]
	jp nz, SwitchOften
	bit SWITCH_RARELY_F, [hl]
	jp nz, SwitchRarely
	bit SWITCH_SOMETIMES_F, [hl]
	jp nz, SwitchSometimes
	ret

SwitchOften: ; 38045
	farcall AIWantsSwitchCheck
	ld a, [wEnemySwitchMonParam]
	and $f0
	ret z

	cp $10
	jr nz, .not_10
	call Random
	cp 1 + 50 percent
	jr c, .switch
	ret
.not_10

	cp $20
	jr nz, .not_20
	call Random
	cp -1 + 79 percent
	jr c, .switch
	ret
.not_20

	; $30
	call Random
	cp 4 percent
	ret c

.switch
	ld a, [wEnemySwitchMonParam]
	and $f
	inc a
	; In register 'a' is the number (1-6) of the Pkmn to switch to
	ld [wEnemySwitchMonIndex], a
	jp AI_TrySwitch
; 38083

SwitchRarely: ; 38083
	farcall AIWantsSwitchCheck
	ld a, [wEnemySwitchMonParam]
	and $f0
	ret z

	cp $10
	jr nz, .not_10
	call Random
	cp 8 percent
	jr c, .switch
	ret
.not_10

	cp $20
	jr nz, .not_20
	call Random
	cp 12 percent
	jr c, .switch
	ret
.not_20

	; $30
	call Random
	cp -1 + 79 percent
	ret c

.switch
	ld a, [wEnemySwitchMonParam]
	and $f
	inc a
	ld [wEnemySwitchMonIndex], a
	jp AI_TrySwitch
; 380c1

SwitchSometimes: ; 380c1
	farcall AIWantsSwitchCheck
	ld a, [wEnemySwitchMonParam]
	and $f0
	ret z

	cp $10
	jr nz, .not_10
	call Random
	cp -1 + 20 percent
	jr c, .switch
	ret
.not_10

	cp $20
	jr nz, .not_20
	call Random
	cp 1 + 50 percent
	jr c, .switch
	ret
.not_20

	; $30
	call Random
	cp -1 + 20 percent
	ret c

.switch
	ld a, [wEnemySwitchMonParam]
	and $f
	inc a
	ld [wEnemySwitchMonIndex], a
	jp AI_TrySwitch
; 380ff


AI_TryItem: ; 38105
	; items are not allowed in the BattleTower
	ld a, [wInBattleTowerBattle]
	and a
	ret nz

	ld a, [wEnemyTrainerItem1]
	ld b, a
	ld a, [wEnemyTrainerItem2]
	or b
	ret z

	call .IsHighestLevel
	ret nc

	ld a, [wTrainerClass]
	dec a
	ld hl, TrainerClassAttributes + TRNATTR_AI_ITEM_SWITCH
	ld bc, NUM_TRAINER_ATTRIBUTES
	rst AddNTimes
	ld b, h
	ld c, l
	ld hl, AI_Items
.loop
	ld de, wEnemyTrainerItem1
	ld a, [hl]
	; Reset carry so the battle loop doesn't think we ended up performing a move...
	and a
	inc a
	ret z

	ld a, [de]
	cp [hl]
	jr z, .has_item
	inc de
	ld a, [de]
	cp [hl]
	jr z, .has_item

	inc hl
	inc hl
	inc hl
	jr .loop

.has_item
	inc hl

	push hl
	push de
	ld de, .callback
	push de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
.callback
	pop de
	pop hl

	inc hl
	inc hl
	jr c, .loop

.used_item

	ld hl, wEnemySubStatus4
	res SUBSTATUS_RAGE, [hl]

	xor a
	ld [de], a
	ld [wCurEnemyMove], a
	ld [wLastPlayerCounterMove], a
	ld [wEnemyProtectCount], a

	inc a
	ld [wEnemyGoesFirst], a
	ld [wEnemyUsingItem], a

	scf
	ret


.IsHighestLevel: ; 38170
	ld a, [wOTPartyCount]
	ld d, a
	ld e, 0
	ld hl, wOTPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
.next
	ld a, [hl]
	cp e
	jr c, .ok
	ld e, a
.ok
	add hl, bc
	dec d
	jr nz, .next

	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Level
	rst AddNTimes
	ld a, [hl]
	cp e
	jr nc, .yes

.no
	and a
	ret

.yes
	scf
	ret
; 38196


AI_Items: ; 39196
	dbw FULL_RESTORE, .FullRestore
	dbw MAX_POTION,   .MaxPotion
	dbw HYPER_POTION, .HyperPotion
	dbw SUPER_POTION, .SuperPotion
	dbw POTION,       .Potion
	dbw FULL_HEAL,    .FullHeal
	dbw GUARD_SPEC,   .GuardSpec
	dbw DIRE_HIT,     .DireHit
	dbw X_ATTACK,     .XAttack
	dbw X_DEFEND,     .XDefend
	dbw X_SPEED,      .XSpeed
	dbw X_SPCL_ATK,   .XSpclAtk
	dbw X_SPCL_DEF,   .XSpclDef
	dbw X_ACCURACY,   .XAccuracy
	db $ff
; 381be

.FullHeal: ; 381be
	call .Status
	jp c, .DontUse
	call EnemyUsedFullHeal
	jp .Use
; 381ca

.Status: ; 381ca (e:41ca)
	ld a, [wEnemyMonStatus]
	and a
	jp z, .DontUse

	ld a, [bc]
	bit CONTEXT_USE_F, a
	jr nz, .StatusCheckContext
	ld a, [bc]
	bit ALWAYS_USE_F, a
	jp nz, .Use
	call Random
	cp -1 + 20 percent
	jp c, .Use
	jp .DontUse

.StatusCheckContext:
	ld a, [wEnemyMonStatus]
	bit TOX, a
	jr z, .FailToxicCheck
	ld a, [wEnemyToxicCount]
	cp 4
	jr c, .FailToxicCheck
	call Random
	cp 1 + 50 percent
	jp c, .Use
.FailToxicCheck:
	ld a, [wEnemyMonStatus]
	and 1 << FRZ | SLP
	jp z, .DontUse
	jp .Use
; 38208

.FullRestore: ; 38208
	call .HealItem
	jp nc, .UseFullRestore
	ld a, [bc]
	bit CONTEXT_USE_F, a
	jp z, .DontUse
	call .Status
	jp c, .DontUse

.UseFullRestore:
	call EnemyUsedFullRestore
	jp .Use
; 38220

.MaxPotion: ; 38220
	call .HealItem
	jp c, .DontUse
	call EnemyUsedMaxPotion
	jp .Use

.HealItem: ; 3822c (e:422c)
	ld a, [bc]
	bit CONTEXT_USE_F, a
	jr nz, .CheckHalfOrQuarterHP
	farcall AICheckEnemyHalfHP
	jp c, .DontUse
	ld a, [bc]
	bit UNKNOWN_USE_F, a
	jp nz, .CheckQuarterHP
	farcall AICheckEnemyQuarterHP
	jp nc, .UseHealItem
	call Random
	cp 1 + 50 percent
	jp c, .UseHealItem
	jp .DontUse

.CheckQuarterHP: ; 38254 (e:4254)
	farcall AICheckEnemyQuarterHP
	jp c, .DontUse
	call Random
	cp -1 + 20 percent
	jp c, .DontUse
	jr .UseHealItem

.CheckHalfOrQuarterHP: ; 38267 (e:4267)
	farcall AICheckEnemyHalfHP
	jp c, .DontUse
	farcall AICheckEnemyQuarterHP
	jp nc, .UseHealItem
	call Random
	cp -1 + 20 percent
	jp nc, .DontUse

.UseHealItem: ; 38281 (e:4281)
	jp .Use
; 38284

.HyperPotion: ; 38284
	call .HealItem
	jp c, .DontUse
	ld b, 120
	call EnemyUsedHyperPotion
	jp .Use
; 38292 (e:4292)

.SuperPotion: ; 38292
	call .HealItem
	jp c, .DontUse
	ld b, 60
	call EnemyUsedSuperPotion
	jp .Use
; 382a0

.Potion: ; 382a0
	call .HealItem
	jp c, .DontUse
	ld b, 20
	call EnemyUsedPotion
	jp .Use
; 382ae

.GuardSpec: ; 38305
	call .XItem
	jp c, .DontUse
	call EnemyUsedGuardSpec
	jp .Use
; 38311

.DireHit: ; 38311
	call .XItem
	jp c, .DontUse
	call EnemyUsedDireHit
	jp .Use
; 3831d (e:431d)

.XAttack:
	call .XItem
	ret c
	ld a, X_ATTACK
	jp EnemyUsedXItem

.XDefend:
	call .XItem
	ret c
	ld a, X_DEFEND
	jp EnemyUsedXItem

.XSpeed:
	call .XItem
	ret c
	ld a, X_SPEED
	jp EnemyUsedXItem

.XSpclAtk:
	call .XItem
	ret c
	ld a, X_SPCL_ATK
	jp EnemyUsedXItem

.XSpclDef: ; 38341
	call .XItem
	ret c
	ld a, X_SPCL_DEF
	jp EnemyUsedXItem

.XAccuracy: ; 382f9
	call .XItem
	ret c
	ld a, X_ACCURACY
	jp EnemyUsedXItem

.XItem: ; 3834d (e:434d)
	ld a, [wEnemyTurnsTaken]
	and a
	jr nz, .notfirstturnout
	ld a, [bc]
	bit ALWAYS_USE_F, a
	jp nz, .Use
	call Random
	cp 1 + 50 percent
	jp c, .DontUse
	ld a, [bc]
	bit CONTEXT_USE_F, a
	jp nz, .Use
	call Random
	cp 1 + 50 percent
	jp c, .DontUse
	jp .Use
.notfirstturnout
	ld a, [bc]
	bit ALWAYS_USE_F, a
	jp z, .DontUse
	call Random
	cp -1 + 20 percent
	jp nc, .DontUse
	jp .Use

.DontUse:
	scf
	ret

.Use:
	and a
	ret


AIUpdateHUD: ; 38387
	call UpdateEnemyMonInParty
	farcall UpdateEnemyHUD
	ld a, $1
	ld [hBGMapMode], a
	ld hl, wEnemyItemState
	dec [hl]
	scf
	ret
; 3839a

AIUsedItemSound: ; 3839a
	push de
	ld de, SFX_FULL_HEAL
	call PlaySFX
	pop de
	ret
; 383a3


EnemyUsedFullHeal: ; 383a3 (e:43a3)
	call AIUsedItemSound
	call AI_HealStatus
	ld a, FULL_HEAL
	jp PrintText_UsedItemOn_AND_AIUpdateHUD

EnemyUsedMaxPotion: ; 383ae (e:43ae)
	ld a, MAX_POTION
	ld [wCurEnemyItem], a
	jr FullRestoreContinue

EnemyUsedFullRestore: ; 383b5 (e:43b5)
	call AI_HealStatus
	ld a, FULL_RESTORE
	ld [wCurEnemyItem], a
	ld hl, wEnemySubStatus3
	res SUBSTATUS_CONFUSED, [hl]
	xor a
	ld [wEnemyConfuseCount], a

FullRestoreContinue: ; 383c6
	ld de, wCurHPAnimOldHP
	ld hl, wEnemyMonHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld hl, wEnemyMonMaxHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld [wCurHPAnimMaxHP], a
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld [de], a
	ld [wCurHPAnimMaxHP + 1], a
	ld [wEnemyMonHP], a
	jr EnemyPotionFinish
; 383e8 (e:43e8)

EnemyUsedPotion: ; 383e8
	ld a, POTION
	ld b, 20
	jr EnemyPotionContinue

EnemyUsedSuperPotion: ; 383ee
	ld a, SUPER_POTION
	ld b, 50
	jr EnemyPotionContinue

EnemyUsedHyperPotion: ; 383f4 (e:43f4)
	ld a, HYPER_POTION
	ld b, 200

EnemyPotionContinue: ; 383f8
	ld [wCurEnemyItem], a
	ld hl, wEnemyMonHP + 1
	ld a, [hl]
	ld [wCurHPAnimOldHP], a
	add b
	ld [hld], a
	ld [wCurHPAnimNewHP], a
	ld a, [hl]
	ld [wCurHPAnimOldHP + 1], a
	ld [wCurHPAnimNewHP + 1], a
	jr nc, .ok
	inc a
	ld [hl], a
	ld [wCurHPAnimNewHP + 1], a
.ok
	inc hl
	ld a, [hld]
	ld b, a
	ld de, wEnemyMonMaxHP + 1
	ld a, [de]
	dec de
	ld [wCurHPAnimMaxHP], a
	sub b
	ld a, [hli]
	ld b, a
	ld a, [de]
	ld [wCurHPAnimMaxHP + 1], a
	sbc b
	jr nc, EnemyPotionFinish
	inc de
	ld a, [de]
	dec de
	ld [hld], a
	ld [wCurHPAnimNewHP], a
	ld a, [de]
	ld [hl], a
	ld [wCurHPAnimNewHP + 1], a

EnemyPotionFinish: ; 38436
	call PrintText_UsedItemOn
	hlcoord 1, 2
	xor a
	ld [wWhichHPBar], a
	call AIUsedItemSound
	farcall BattleAnimateHPBar
	jp AIUpdateHUD


AI_TrySwitch: ; 3844b
; Determine whether the AI can switch based on how many Pokemon are still alive.
; If it can switch, it will.
	ld a, [wOTPartyCount]
	ld c, a
	ld hl, wOTPartyMon1HP
	ld d, 0
.SwitchLoop:
	ld a, [hli]
	ld b, a
	ld a, [hld]
	or b
	jr z, .fainted
	inc d
.fainted
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .SwitchLoop

	ld a, d
	cp 2
	jp nc, AI_Switch
	and a
	ret

AI_Switch:
	ld a, [wEnemySwitchMonIndex]
	ld [wEnemySwitchTarget], a
	scf
	ret

AI_HealStatus: ; 384e0
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	xor a
	ld [hl], a
	ld [wEnemyMonStatus], a
	ld hl, wEnemySubStatus3
	res SUBSTATUS_CONFUSED, [hl]
	ret
; 384f7

EnemyUsedGuardSpec: ; 38504
	call AIUsedItemSound
	ld hl, wEnemySubStatus4
	set SUBSTATUS_MIST, [hl]
	ld a, GUARD_SPEC
	jp PrintText_UsedItemOn_AND_AIUpdateHUD
; 38511

EnemyUsedDireHit: ; 38511
	call AIUsedItemSound
	ld hl, wEnemySubStatus4
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	ld a, DIRE_HIT
	jp PrintText_UsedItemOn_AND_AIUpdateHUD
; 3851e

EnemyUsedXItem:
	ld [wCurEnemyItem], a
	ld b, a
	farcall GetItemHeldEffect
	ld b, c

	ld a, STAT_SKIPTEXT | STAT_SILENT
	farcall _ForceRaiseStat
	ld a, [wFailedMessage]
	and a
	jr nz, .fail

	push bc
	call PrintText_UsedItemOn
	pop bc

	farcall PrintStatChange
	call AIUpdateHUD
	xor a
	ret

.fail
	xor a
	ld [wCurEnemyItem], a
	scf
	ret

; Parameter
; a = ITEM_CONSTANT
PrintText_UsedItemOn_AND_AIUpdateHUD: ; 38568
	ld [wCurEnemyItem], a
	call PrintText_UsedItemOn
	jp AIUpdateHUD
; 38571

PrintText_UsedItemOn: ; 38571
	ld a, [wCurEnemyItem]
	ld [wd265], a
	call GetItemName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes
	ld hl, TextJump_EnemyUsedOn
	jp PrintText
; 3858c

TextJump_EnemyUsedOn: ; 3858c
	text_jump Text_EnemyUsedOn
	db "@"
; 38591
