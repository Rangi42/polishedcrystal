AI_MaybeSwitch:
	; This function can be called twice in case of choice-locking. If so,
	; dismiss the second run of the function if the first gave a target.
	ld a, [wEnemySwitchTarget]
	and a
	ret nz

	ld a, [wBattleMode]
	dec a
	ret z

	ld a, [wLinkMode]
	and a
	ret nz

	farcall AI_UserCanSwitch
	ret nz

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
	jr nz, SwitchOften
	bit SWITCH_RARELY_F, [hl]
	jr nz, SwitchRarely
	bit SWITCH_SOMETIMES_F, [hl]
	jr nz, SwitchSometimes
	ret

SwitchOften:
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
	jmp AI_TrySwitch

SwitchRarely:
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
	jmp AI_TrySwitch

SwitchSometimes:
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
	jmp AI_TrySwitch

AI_TryItem:
	; items are not allowed in the BattleTower
	ld a, [wInBattleTowerBattle]
	and a
	ret nz

	ld a, [wLinkMode]
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
	call IndirectHL
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
	ld [wLastEnemyCounterMove], a
	ld [wEnemyProtectCount], a

	inc a
	ld [wEnemyGoesFirst], a
	ld [wEnemyUsingItem], a

	scf
	ret

.IsHighestLevel:
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

AI_Items:
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

.FullHeal:
	call .Status
	jmp c, .DontUse
	call EnemyUsedFullHeal
	jmp .Use

.Status:
	ld a, [wEnemyMonStatus]
	and a
	jmp z, .DontUse

	ld a, [bc]
	bit CONTEXT_USE_F, a
	jr nz, .StatusCheckContext
	ld a, [bc]
	bit ALWAYS_USE_F, a
	jmp nz, .Use
	call Random
	cp -1 + 20 percent
	jmp c, .Use
	jmp .DontUse

.StatusCheckContext:
	ld a, [wEnemyMonStatus]
	bit TOX, a
	jr z, .FailToxicCheck
	ld a, [wEnemyToxicCount]
	cp 4
	jr c, .FailToxicCheck
	call Random
	cp 1 + 50 percent
	jmp c, .Use
.FailToxicCheck:
	ld a, [wEnemyMonStatus]
	and 1 << FRZ | SLP
	jmp z, .DontUse
	jmp .Use

.FullRestore:
	call .HealItem
	jr nc, .UseFullRestore
	ld a, [bc]
	bit CONTEXT_USE_F, a
	jmp z, .DontUse
	call .Status
	jmp c, .DontUse
.UseFullRestore:
	call EnemyUsedFullRestore
	jmp .Use

.MaxPotion:
	call .HealItem
	jmp c, .DontUse
	call EnemyUsedMaxPotion
	jmp .Use

.HealItem:
	ld a, [bc]
	bit CONTEXT_USE_F, a
	jr nz, .CheckHalfOrQuarterHP
	call AICheckEnemyHalfHP
	jmp c, .DontUse
	ld a, [bc]
	bit UNKNOWN_USE_F, a
	jr nz, .CheckQuarterHP
	call AICheckEnemyQuarterHP
	jmp nc, .Use
	call Random
	cp 1 + 50 percent
	jmp nc, .DontUse
	jmp .Use

.CheckQuarterHP:
	call AICheckEnemyQuarterHP
	jmp c, .DontUse
	call Random
	cp -1 + 20 percent
	jmp c, .DontUse
	jmp .Use

.CheckHalfOrQuarterHP:
	call AICheckEnemyHalfHP
	jmp c, .DontUse
	call AICheckEnemyQuarterHP
	jmp nc, .Use
	call Random
	cp -1 + 20 percent
	jmp nc, .DontUse
	jmp .Use

.HyperPotion:
	call .HealItem
	jmp c, .DontUse
	ld b, 120
	call EnemyUsedHyperPotion
	jmp .Use

.SuperPotion:
	call .HealItem
	jmp c, .DontUse
	ld b, 60
	call EnemyUsedSuperPotion
	jmp .Use

.Potion:
	call .HealItem
	jmp c, .DontUse
	ld b, 20
	call EnemyUsedPotion
	jmp .Use

.GuardSpec:
	call .XItem
	jr c, .DontUse
	ld a, [wEnemyGuards]
	and GUARD_MIST
	jr nz, .DontUse
	call EnemyUsedGuardSpec
	jr .Use

.DireHit:
	call .XItem
	jr c, .DontUse
	call EnemyUsedDireHit
	jr .Use

.XAttack:
	call .XItem
	ret c
	ld a, X_ATTACK
	jmp EnemyUsedXItem

.XDefend:
	call .XItem
	ret c
	ld a, X_DEFEND
	jmp EnemyUsedXItem

.XSpeed:
	call .XItem
	ret c
	ld a, X_SPEED
	jmp EnemyUsedXItem

.XSpclAtk:
	call .XItem
	ret c
	ld a, X_SPCL_ATK
	jmp EnemyUsedXItem

.XSpclDef:
	call .XItem
	ret c
	ld a, X_SPCL_DEF
	jmp EnemyUsedXItem

.XAccuracy:
	call .XItem
	ret c
	ld a, X_ACCURACY
	jmp EnemyUsedXItem

.XItem:
	ld a, [wEnemyTurnsTaken]
	and a
	jr nz, .notfirstturnout
	ld a, [bc]
	bit ALWAYS_USE_F, a
	jr nz, .Use
	call Random
	cp 1 + 50 percent
	jr c, .DontUse
	ld a, [bc]
	bit CONTEXT_USE_F, a
	jr nz, .Use
	call Random
	cp 1 + 50 percent
	jr c, .DontUse
	jr .Use
.notfirstturnout
	ld a, [bc]
	bit ALWAYS_USE_F, a
	jr z, .DontUse
	call Random
	cp -1 + 20 percent
	jr c, .Use

.DontUse:
	scf
	ret

.Use:
	and a
	ret

AIUpdateHUD:
	call UpdateEnemyMonInParty
	farcall UpdateEnemyHUD
	ld a, $1
	ldh [hBGMapMode], a
	ld hl, wEnemyItemState
	dec [hl]
	scf
	ret

AIUsedItemSound:
	push de
	ld de, SFX_FULL_HEAL
	call PlaySFX
	pop de
	ret

EnemyUsedFullHeal:
	call AIUsedItemSound
	call AI_HealStatus
	ld a, FULL_HEAL
	jmp PrintText_UsedItemOn_AND_AIUpdateHUD

EnemyUsedMaxPotion:
	ld a, MAX_POTION
	ld [wCurEnemyItem], a
	jr FullRestoreContinue

EnemyUsedFullRestore:
	call AI_HealStatus
	ld a, FULL_RESTORE
	ld [wCurEnemyItem], a
	ld hl, wEnemySubStatus3
	res SUBSTATUS_CONFUSED, [hl]
	xor a
	ld [wEnemyConfuseCount], a

FullRestoreContinue:
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

EnemyUsedPotion:
	ld a, POTION
	ld b, 20
	jr EnemyPotionContinue

EnemyUsedSuperPotion:
	ld a, SUPER_POTION
	ld b, 50
	jr EnemyPotionContinue

EnemyUsedHyperPotion:
	ld a, HYPER_POTION
	ld b, 200

EnemyPotionContinue:
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

EnemyPotionFinish:
	call PrintText_UsedItemOn
	hlcoord 1, 2
	xor a
	ld [wWhichHPBar], a
	call AIUsedItemSound
	farcall BattleAnimateHPBar
	jmp AIUpdateHUD

AI_TrySwitch:
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
	jr nc, AI_Switch
	and a
	ret

AI_Switch:
	ld a, [wEnemySwitchMonIndex]
	ld [wEnemySwitchTarget], a
	scf
	ret

AI_HealStatus:
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

EnemyUsedGuardSpec:
	call AIUsedItemSound
	ld a, 5 << 4
	ld hl, wEnemyGuards
	or [hl]
	ld [hl], a
	ld a, GUARD_SPEC
	ld [wNamedObjectIndex], a
	call PrintText_CopyItemName
	ld hl, TextJump_EnemyUsed
	call PrintText
	ld hl, MistText
	call StdBattleTextbox
	jmp AIUpdateHUD

EnemyUsedDireHit:
	call AIUsedItemSound
	ld hl, wEnemySubStatus4
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	ld a, DIRE_HIT
	; fallthrough

PrintText_UsedItemOn_AND_AIUpdateHUD:
; a = ITEM_CONSTANT
	ld [wCurEnemyItem], a
	call PrintText_UsedItemOn
	jmp AIUpdateHUD

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

PrintText_UsedItemOn:
	ld a, [wCurEnemyItem]
	ld [wNamedObjectIndex], a
	call PrintText_CopyItemName
	ld hl, TextJump_EnemyUsedOn
	jmp PrintText

PrintText_CopyItemName:
	call GetItemName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes
	ret

TextJump_EnemyUsed:
	text_far Text_EnemyUsed
	text_end

TextJump_EnemyUsedOn:
	text_far Text_EnemyUsedOn
	text_end
