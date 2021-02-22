	const_def
	const DAYCARETEXT_MAN_INTRO
	const DAYCARETEXT_MAN_EGG
	const DAYCARETEXT_LADY_INTRO
	const DAYCARETEXT_LADY_EGG
	const DAYCARETEXT_WHICH_ONE
	const DAYCARETEXT_DEPOSIT
	const DAYCARETEXT_CANT_BREED_EGG
	const DAYCARETEXT_LAST_MON
	const DAYCARETEXT_LAST_ALIVE_MON
	const DAYCARETEXT_COME_BACK_LATER
	const DAYCARETEXT_REMOVE_MAIL
	const DAYCARETEXT_GENIUSES
	const DAYCARETEXT_ASK_WITHDRAW
	const DAYCARETEXT_WITHDRAW
	const DAYCARETEXT_TOO_SOON
	const DAYCARETEXT_PARTY_FULL
	const DAYCARETEXT_NOT_ENOUGH_MONEY
	const DAYCARETEXT_OH_FINE
	const DAYCARETEXT_COME_AGAIN
	const DAYCARETEXT_13

Special_DayCareMan:
	ld hl, wDayCareMan
	bit 0, [hl]
	jr nz, .AskWithdrawMon
	ld hl, wDayCareMan
	ld a, DAYCARETEXT_MAN_INTRO
	call DayCareManIntroText
	jr c, .cancel
	call DayCareAskDepositPokemon
	jr c, .print_text
	farcall DepositMonWithDayCareMan
	ld hl, wDayCareMan
	set 0, [hl]
	call DayCare_DepositPokemonText
	jp DayCare_InitBreeding

.AskWithdrawMon:
	farcall GetBreedMon1LevelGrowth
	ld hl, wBreedMon1Nick
	call GetPriceToRetrieveBreedmon
	call DayCare_AskWithdrawBreedMon
	jr c, .print_text
	farcall RetrievePokemonFromDayCareMan
	call DayCare_TakeMoney_PlayCry
	ld hl, wDayCareMan
	res 0, [hl]
	res 5, [hl]
	jr .cancel

.print_text
	call PrintDayCareText

.cancel
	ld a, DAYCARETEXT_13
	jp PrintDayCareText

Special_DayCareLady:
	ld hl, wDayCareLady
	bit 0, [hl]
	jr nz, .AskWithdrawMon
	ld hl, wDayCareLady
	ld a, DAYCARETEXT_LADY_INTRO
	call DayCareLadyIntroText
	jr c, .cancel
	call DayCareAskDepositPokemon
	jr c, .print_text
	farcall DepositMonWithDayCareLady
	ld hl, wDayCareLady
	set 0, [hl]
	call DayCare_DepositPokemonText
	jp DayCare_InitBreeding

.AskWithdrawMon:
	farcall GetBreedMon2LevelGrowth
	ld hl, wBreedMon2Nick
	call GetPriceToRetrieveBreedmon
	call DayCare_AskWithdrawBreedMon
	jr c, .print_text
	farcall RetrievePokemonFromDayCareLady
	call DayCare_TakeMoney_PlayCry
	ld hl, wDayCareLady
	res 0, [hl]
	ld hl, wDayCareMan
	res 5, [hl]
	jr .cancel

.print_text
	call PrintDayCareText

.cancel
	ld a, DAYCARETEXT_13
	jp PrintDayCareText

DayCareLadyIntroText:
	bit 7, [hl]
	jr nz, DayCarePersonIntroText
	inc a
DayCareManIntroText:
	set 7, [hl]
DayCarePersonIntroText:
	call PrintDayCareText
	jp YesNoBox

DayCareAskDepositPokemon:
	ld a, [wPartyCount]
	cp 2
	jr c, .OnlyOneMon
	ld a, DAYCARETEXT_WHICH_ONE
	call PrintDayCareText
	ld b, PARTYMENUACTION_GIVE_MON
	farcall SelectTradeOrDayCareMon
	jr c, .Declined
	ld hl, wPartyMon1IsEgg
	ld a, [wCurPartyMon]
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .Egg
	farcall CheckCurPartyMonFainted
	jr c, .OutOfUsableMons
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld d, [hl]
	call ItemIsMail
	jr c, .HoldingMail
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNick
	and a
	ret

.Declined:
	ld a, DAYCARETEXT_COME_AGAIN
	scf
	ret

.Egg:
	ld a, DAYCARETEXT_CANT_BREED_EGG
	scf
	ret

.OnlyOneMon:
	ld a, DAYCARETEXT_LAST_MON
	scf
	ret

.OutOfUsableMons:
	ld a, DAYCARETEXT_LAST_ALIVE_MON
	scf
	ret

.HoldingMail:
	ld a, DAYCARETEXT_REMOVE_MAIL
	scf
	ret

DayCare_DepositPokemonText:
	ld a, DAYCARETEXT_DEPOSIT
	call PrintDayCareText
	ld a, [wCurPartySpecies]
	call PlayCry
	ld a, DAYCARETEXT_COME_BACK_LATER
	jp PrintDayCareText

DayCare_AskWithdrawBreedMon:
	ld a, [wStringBuffer2 + 1]
	and a
	jr nz, .grew_at_least_one_level
	ld a, DAYCARETEXT_PARTY_FULL
	call PrintDayCareText
	call YesNoBox
	jr c, .refused
	jr .check_money

.grew_at_least_one_level
	ld a, DAYCARETEXT_GENIUSES
	call PrintDayCareText
	call YesNoBox
	jr c, .refused
	ld a, DAYCARETEXT_ASK_WITHDRAW
	call PrintDayCareText
	call YesNoBox
	jr c, .refused

.check_money
	ld de, wMoney
	ld bc, wStringBuffer2 + 2
	call CompareMoney
	jr c, .not_enough_money
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nc, .PartyFull
	and a
	ret

.refused
	ld a, DAYCARETEXT_COME_AGAIN
	scf
	ret

.not_enough_money
	ld a, DAYCARETEXT_OH_FINE
	scf
	ret

.PartyFull:
	ld a, DAYCARETEXT_NOT_ENOUGH_MONEY
	scf
	ret

DayCare_TakeMoney_PlayCry:
	ld bc, wStringBuffer2 + 2
	ld de, wMoney
	call TakeMoney
	ld a, DAYCARETEXT_WITHDRAW
	call PrintDayCareText
	ld a, [wCurPartySpecies]
	call PlayCry
	ld a, DAYCARETEXT_TOO_SOON
	jp PrintDayCareText

GetPriceToRetrieveBreedmon:
	ld a, b
	ld [wStringBuffer2], a
	ld a, d
	ld [wStringBuffer2 + 1], a
	ld de, wStringBuffer1
	ld bc, NAME_LENGTH
	rst CopyBytes
	ld hl, 0
	ld bc, 100
	ld a, [wStringBuffer2 + 1]
	rst AddNTimes
	ld de, 100
	add hl, de
	xor a
	ld [wStringBuffer2 + 2], a
	ld a, h
	ld [wStringBuffer2 + 3], a
	ld a, l
	ld [wStringBuffer2 + 4], a
	ret

PrintDayCareText:
	ld e, a
	ld d, 0
	ld hl, .TextTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp PrintText

.TextTable:
	dw .DayCareManIntro ; 00
	dw .DayCareManOddEgg ; 01
	dw .DayCareLadyIntro ; 02
	dw .DayCareLadyOddEgg ; 03
	dw .WhichOne ; 04
	dw .OkayIllRaiseYourMon ; 05
	dw .CantAcceptEgg ; 06
	dw .JustOneMon ; 07
	dw .LastHealthyMon ; 08
	dw .ComeBackForItLater ; 09
	dw .RemoveMail ; 0a
	dw .AreWeGeniusesOrWhat ; 0b
	dw .AskRetrieveMon ; 0c
	dw .PerfectHeresYourMon ; 0d
	dw .GotBackMon ; 0e
	dw .ImmediatelyWithdrawMon ; 0f
	dw .PartyFull ; 10
	dw .NotEnoughMoney ; 11
	dw .OhFineThen ; 12
	dw .ComeAgain ; 13

.DayCareManIntro:
	; I'm the DAY-CARE MAN. Want me to raise a #MON?
	text_jump _DayCareManIntroText
	text_end

.DayCareManOddEgg:
	; I'm the DAY-CARE MAN. Do you know about EGGS? I was raising #MON with my wife, you see. We were shocked to find an EGG! How incredible is that? So, want me to raise a #MON?
	text_jump _DayCareManIntroEggText
	text_end

.DayCareLadyIntro:
	; I'm the DAY-CARE LADY. Should I raise a #MON for you?
	text_jump _DayCareLadyIntroText
	text_end

.DayCareLadyOddEgg:
	; I'm the DAY-CARE LADY. Do you know about EGGS? My husband and I were raising some #MON, you see. We were shocked to find an EGG! How incredible could that be? Should I raise a #MON for you?
	text_jump _DayCareLadyIntroEggText
	text_end

.WhichOne:
	; What should I raise for you?
	text_jump _WhatShouldIRaiseText
	text_end

.JustOneMon:
	; Oh? But you have just one #MON.
	text_jump _OnlyOneMonText
	text_end

.CantAcceptEgg:
	; Sorry, but I can't accept an EGG.
	text_jump _CantAcceptEggText
	text_end

.RemoveMail:
	; Remove MAIL before you come see me.
	text_jump _RemoveMailText
	text_end

.LastHealthyMon:
	; If you give me that, what will you battle with?
	text_jump _LastHealthyMonText
	text_end

.OkayIllRaiseYourMon:
	; OK. I'll raise your @ .
	text_jump _IllRaiseYourMonText
	text_end

.ComeBackForItLater:
	; Come back for it later.
	text_jump _ComeBackLaterText
	text_end

.AreWeGeniusesOrWhat:
	; Are we geniuses or what? Want to see your @ ?
	text_jump _AreWeGeniusesText
	text_end

.AskRetrieveMon:
	; Your @ has grown a lot. By level, it's grown by @ . If you want your #MON back, it will cost ¥@ .
	text_jump _YourMonHasGrownText
	text_end

.PerfectHeresYourMon:
	; Perfect! Here's your #MON.
	text_jump _PerfectHeresYourMonText
	text_end

.GotBackMon:
	; got back @ .
	text_jump _GotBackMonText
	text_end

.ImmediatelyWithdrawMon:
	; Huh? Back already? Your @ needs a little more time with us. If you want your #MON back, it will cost ¥100.
	text_jump _BackAlreadyText
	text_end

.PartyFull:
	; You have no room for it.
	text_jump _HaveNoRoomText
	text_end

.NotEnoughMoney:
	; You don't have enough money.
	text_jump _NotEnoughMoneyText
	text_end

.OhFineThen:
	; Oh, fine then.
	text_jump _OhFineThenText
	text_end

.ComeAgain:
	; Come again.
	text_jump _ComeAgainText
	text_end

Special_DayCareManOutside:
	ld hl, wDayCareMan
	bit 6, [hl]
	jr nz, .AskGiveEgg
	ld hl, .NotYet
	jp PrintText

.NotYet:
	; Not yet…
	text_jump _NotYetText
	text_end

.AskGiveEgg:
	ld hl, .IntroText
	call PrintText
	call YesNoBox
	jr c, .Declined
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nc, .PartyFull
	call DayCare_GiveEgg
	ld hl, wDayCareMan
	res 6, [hl]
	call DayCare_InitBreeding
	ld hl, .GotEggText
	call PrintText
	ld de, SFX_GET_EGG_FROM_DAYCARE_LADY
	call PlaySFX
	ld c, 120
	call DelayFrames
	ld hl, .TakeGoodCareOfItText
	jr .Load0

.Declined:
	ld hl, .IllKeepItThanksText

.Load0:
	call PrintText
	xor a
	ldh [hScriptVar], a
	ret

.PartyFull:
	ld hl, .PartyFullText
	call PrintText
	ld a, $1
	ldh [hScriptVar], a
	ret

.IntroText:
	; Ah, it's you! We were raising your #MON, and my goodness, were we surprised! Your #MON had an EGG! We don't know how it got there, but your #MON had it. You want it?
	text_jump _FoundAnEggText
	text_end

.GotEggText:
	; received the EGG!
	text_jump _ReceivedEggText
	text_end

.TakeGoodCareOfItText:
	; Take good care of it.
	text_jump _TakeGoodCareOfEggText
	text_end

.IllKeepItThanksText:
	; Well then, I'll keep it. Thanks!
	text_jump _IllKeepItThanksText
	text_end

.PartyFullText:
	; You have no room in your party. Come back later.
	text_jump _NoRoomForEggText
	text_end

DayCare_GiveEgg:
	ld a, [wEggMonLevel]
	ld [wCurPartyLevel], a
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	jp nc, .PartyFull
	inc a
	ld [hl], a

	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wEggMonSpecies]
	ld [hli], a
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a

	; Red Gyarados' Eggs should be plain
	cp MAGIKARP
	jr nz, .not_red_magikarp
	ld a, [wEggMonForm]
	and BASEMON_MASK
	cp GYARADOS_RED_FORM
	jr c, .not_red_magikarp
	ld a, [wEggMonForm]
	and $ff - BASEMON_MASK
	or PLAIN_FORM
	ld [wEggMonForm], a
.not_red_magikarp

	ld [hl], -1

	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call DayCare_GetCurrentPartyMember
	ld hl, wEggNick
	rst CopyBytes

	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	call DayCare_GetCurrentPartyMember
	ld hl, wEggOT
	rst CopyBytes

	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call DayCare_GetCurrentPartyMember
	ld hl, wEggMon
	ld bc, wEggMonEnd - wEggMon
	rst CopyBytes

	ld a, [wEggMonForm]
	ld [wCurForm], a
	call GetBaseData
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld b, h
	ld c, l
	ld hl, MON_ID + 1
	add hl, bc
	push hl
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	push bc
	ld b, FALSE
	predef CalcPkmnStats
	pop bc
	ld hl, MON_HP
	add hl, bc
	xor a
	ld [hli], a
	ld [hl], a
	and a
	ret

.PartyFull:
	scf
	ret

DayCare_GetCurrentPartyMember:
	ld a, [wPartyCount]
	dec a
	rst AddNTimes
	ld d, h
	ld e, l
	ret

CheckParentItem:
; Returns nz if a parent has given item a. a is set to 1 or 2 depending
; on whether parent 1 or 2 had the item. If both have it, a is set
; at random
	push bc
	ld b, a
	ld a, [wBreedMon1Item]
	cp b
	jr z, .maybe_both
	ld a, [wBreedMon2Item]
	cp b
	pop bc
	ld a, 2
	jr z, .ret_nz
	xor a
	ret
.maybe_both
	ld a, [wBreedMon2Item]
	cp b
	pop bc
	ld a, 1
	ret nz
	inc a
	call RandomRange
	inc a
.ret_nz
	and a
	ret

GetParentAddr:
; if a = 2, get parent 2 instead of 1 (assumed on hl). Best used in
; conjuction with CheckParentItem.
	cp 2
	ret nz
	push bc
	ld bc, wBreedMon2 - wBreedMon1
	add hl, bc
	pop bc
	ret

DoPowerItemInheritance:
	ld hl, PowerItems
	ld e, 0
.loop
	ld a, [hli]
	cp -1
	ret z
	call CheckParentItem
	jr z, .next
	push hl
	ld hl, wBreedMon1DVs
	call GetParentAddr
	call InheritDV
	pop hl
.next
	inc e
	jr .loop

PowerItems:
; Ordered in HP/Atk/Def/Speed/SpAtk/SpDef, doesn't care about actual order
	db POWER_WEIGHT
	db POWER_BRACER
	db POWER_BELT
	db POWER_ANKLET
	db POWER_LENS
	db POWER_BAND
	db -1

InheritDV:
; Inherit DV e (0=HP, 1=Atk, 2=Def, 3=Speed, 4=Sp.Atk, 5=Sp.Def)
; from parent DVs in hl. Returns nz if we can't inherit anything else.
; b: inheritance counts left, c: already inherited bitfield
; Preserves de+hl
	; Figure out if we can inherit the DV
	; Have we inherited as much as we can?
	ld a, b
	and a
	jr z, .cant_inherit_any_more

	; Have we inherited every stat?
	ld a, c
	cp %111111
	jr z, .cant_inherit_any_more

	; Have we already inherited the given stat?
	push de
	ld d, %000001
	inc e
.dv_check_loop
	dec e
	jr z, .got_dv_bit
	sla d
	jr .dv_check_loop
.got_dv_bit
	ld a, d
	and c
	ld a, d
	pop de
	jr nz, .cant_inherit_this_stat

	; Mark the stat as inherited and decrease inherit counter
	or c
	ld c, a
	dec b

	; Inherit the stat
	; inc/dec doesn't alter carry flag
	; DV is stored as %xxxxyyyy, %zzzzaaaa, %bbbbcccc
	; x=HP, y=Atk, z=Def, a=Speed, b=SpAtk, c=SpDef
	; To inherit the correct nibble, copy high from HL, low from DE
	; a=0, 2 or 4 :: HL is Parent, DE is Egg
	; a=1, 3 or 5 :: HL is Egg, DE is Parent
	ld a, e
	push de
	push hl
	ld de, wEggMonDVs
	; halve A; 0-1: first byte, 2-3: second, 4-5: third
	srl a ; sets carry if a is odd, maintained thorough the loop
	inc a
.find_dv_loop
	dec a
	jr z, .found_dv
	inc de
	inc hl
	jr .find_dv_loop
.found_dv
	push de ; Egg DVs inherited to
	; current HL is Parent, DE is Egg, if a is odd, swap
	call c, SwapHLDE
	; inherit x from HL, y from DE in %xxxxyyyy
	; This means that half is "inherited" from Egg, half from Parent
	ld a, [hl]
	and $f0
	ld h, a
	ld a, [de]
	and $f
	or h
	pop de
	ld [de], a
	pop hl
	pop de
.cant_inherit_this_stat
	xor a
	ret
.cant_inherit_any_more
	or 1
	ret

DayCare_InitBreeding:
	ld a, [wDayCareLady]
	bit 0, a
	ret z
	ld a, [wDayCareMan]
	bit 0, a
	ret z
	call CheckBreedmonCompatibility
	ld a, [wd265]
	and a
	ret z
	ld hl, wDayCareMan
	set 5, [hl]
.loop
	call Random
	cp 150
	jr c, .loop
	ld [wStepsToEgg], a
	xor a
	ld hl, wEggMon
	ld bc, wEggMonEnd - wEggMon
	rst ByteFill
	ld hl, wEggNick
	ld bc, MON_NAME_LENGTH
	rst ByteFill
	ld hl, wEggOT
	ld bc, NAME_LENGTH
	rst ByteFill
	ld a, [wBreedMon1Species]
	ld [wCurPartySpecies], a
	ld a, [wBreedMon1Gender]
	ld [wTempMonGender], a
	ld a, $3
	ld [wMonType], a
	ld a, [wBreedMon1Species]
	cp DITTO
	ld a, 1
	jr z, .LoadWhichBreedmonIsTheMother
	ld a, [wBreedMon2Species]
	cp DITTO
	ld a, 0
	jr z, .LoadWhichBreedmonIsTheMother
	farcall GetGender
	ld a, 0
	jr z, .LoadWhichBreedmonIsTheMother
	inc a

.LoadWhichBreedmonIsTheMother:
	; load wCurForm for base data check later
	ld [wBreedMotherOrNonDitto], a
	and a
	ld a, [wBreedMon1Form]
	ld [wCurForm], a
	ld a, [wBreedMon1Species]
	jr z, .GotMother
	ld a, [wBreedMon2Form]
	ld [wCurForm], a
	ld a, [wBreedMon2Species]

.GotMother:
	ld [wCurPartySpecies], a
	farcall GetPreEvolution
	farcall GetPreEvolution
	ld a, EGG_LEVEL
	ld [wCurPartyLevel], a

	ld a, [wCurPartySpecies]
	cp NIDORAN_F
	jr nz, .GotEggSpecies

	; random Nidoran offspring
	call Random
	cp 1 + 50 percent
	; a = carry ? NIDORAN_F : NIDORAN_M
	sbc a
	and NIDORAN_F - NIDORAN_M
	add NIDORAN_M
.GotEggSpecies:
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld [wEggMonSpecies], a

	; Form inheritance: from the mother or non-Ditto. If both
	; parents share species, pick at random.
	; Must assign [wCurForm] before GetBaseData.
	ld hl, wBreedMon1Form
	call .inherit_mother_unless_samespecies
	ld a, [hl]
	and BASEMON_MASK
	ld [wCurForm], a

	call GetBaseData

	; Set name and item
	ld hl, wEggNick
	ld de, .String_EGG
	call CopyName2
	ld hl, wPlayerName
	ld de, wEggOT
	ld bc, NAME_LENGTH
	rst CopyBytes
	xor a
	ld [wEggMonItem], a

	; Set moves for the egg
	call InitEggMoves

	; Set OTID to the player
	ld hl, wEggMonID
	ld a, [wPlayerID]
	ld [hli], a
	ld a, [wPlayerID + 1]
	ld [hl], a

	; Zero EXP
	ld hl, wEggMonExp
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	; Zero EVs
	ld b, wEggMonDVs - wEggMonEVs
	ld hl, wEggMonEVs
.loop2
	ld [hli], a
	dec b
	jr nz, .loop2

	; Set random DVs
	ld hl, wEggMonDVs
	call Random
	ld [hli], a
	call Random
	ld [hli], a
	call Random
	ld [hl], a

	; Figure out DV inheritance. Normal inheritance is 3 random
	; DVs from the parents at random. 5 with Destiny Knot.
	ld a, DESTINY_KNOT
	call CheckParentItem
	ld a, 5
	jr nz, .got_dv_inheritance_count
	ld a, 3
.got_dv_inheritance_count
	ld b, a
	ld c, %000000 ; Already inherited

	; Power items gurantee certain DVs to be inherited
	call DoPowerItemInheritance

	; Do the rest of the DVs
.dv_inherit_loop
	ld a, 12
	call RandomRange
	srl a
	push af
	ld a, 2
	ld hl, wBreedMon1DVs
	call c, GetParentAddr
	pop af
	ld e, a
	call InheritDV
	jr z, .dv_inherit_loop

	; Zero the personality data
	xor a
	ld [wEggMonPersonality], a
	ld [wEggMonPersonality + 1], a

	; Do Ability
	; Ability Capsules greatly boosts HA rate of child: it makes it
	; so that it gets the HA 25% of the time (50% if both parents
	; hold it)
	ld b, 3
	ld a, [wBreedMon1Item]
	cp ABILITY_CAP
	jr nz, .no_parent1_abilitycap
	dec b
.no_parent1_abilitycap
	ld a, [wBreedMon2Item]
	cp ABILITY_CAP
	jr nz, .no_parent2_abilitycap
	dec b
.no_parent2_abilitycap
	ld a, b
	cp 3
	jr z, .no_ha_boost
	sla a
	call BattleRandomRange
	and a
	jr nz, .no_ha_boost
	ld a, HIDDEN_ABILITY
	jr z, .got_ability

.no_ha_boost
	; 60% to get mother's ability
	; (after coincidences: 79% to inherit ability 1 or 2, 62% to inherit HA)
	ld a, [wBreedMotherOrNonDitto]
	and a
	ld a, [wBreedMon1Ability]
	jr z, .got_mother_ability
	ld a, [wBreedMon2Ability]
.got_mother_ability
	ld b, a

	; 2/5 = 40% random ability
	ld a, 5
	call RandomRange
	cp 2
	jr c, .random_ability

	ld a, b
	and ABILITY_MASK
	jr .got_ability

.random_ability
	; 2/40 = 5% HA; 19/40 = 47.5% either other ability
	ld a, 40
	call RandomRange
	cp 2
	jr c, .hidden_ability
	cp 21
	; a = carry ? ABILITY_2 : ABILITY_1
	sbc a
	and ABILITY_2 - ABILITY_1
	add ABILITY_1
	jr .got_ability
.hidden_ability
	ld a, HIDDEN_ABILITY
.got_ability
	ld hl, wEggMonAbility
	or [hl]
	ld [hl], a

	; Nature. If a parent holds an Everstone, always inherit that
	ld hl, wBreedMon1Nature
	ld a, EVERSTONE
	call CheckParentItem
	jr z, .random_nature
	call GetParentAddr
	ld a, [hl]
	and NATURE_MASK
	jr .got_nature

.random_nature
	ld a, NUM_NATURES
	call RandomRange
.got_nature
	ld hl, wEggMonNature
	or [hl]
	ld [hl], a

	call Random
	and a
	jr nz, .not_shiny ; 255/256 not shiny

	; Shiny. Shiny rate after the above pass is:
	; 1/16 - Usual
	; 3/16 - Shiny Charm (+2 shiny modifier)
	; 6/16 - Masuda (+5 shiny modifier)
	; 8/16 - Both (+7 shiny modifier)
	ld a, 16
	call RandomRange
	ld b, a
	ld c, 1

	; Check Shiny Charm
	ld a, SHINY_CHARM
	ld [wCurKeyItem], a
	push hl
	push bc
	push de
	call CheckKeyItem
	pop de
	pop bc
	pop hl
	jr nc, .shiny_charm_done
	inc c
	inc c
.shiny_charm_done
	; The "Masuda method" in the official games is a shiny booster
	; for when parents of different nationalities trade. Consider
	; "different OTID" as different nationalities here.
	ld a, [wBreedMon1ID]
	ld d, a
	ld a, [wBreedMon1ID + 1]
	ld e, a
	ld a, [wBreedMon2ID]
	cp d
	jr nz, .masuda_ok
	ld a, [wBreedMon2ID + 1]
	cp e
	jr z, .masuda_done
.masuda_ok
	ld a, 5
	add c
	ld c, a
.masuda_done
	ld a, b
	cp c
	jr nc, .not_shiny
	ld a, SHINY_MASK
	ld hl, wEggMonShiny
	or [hl]
	ld [hl], a
.not_shiny

	; Gender
	ld a, [wEggMonSpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	call GetGenderRatio
	; if rnd(0..7) < c: female, else male
	ld a, 8
	call RandomRange
	cp c
	; a = carry (rnd(0..7) < c) ? FEMALE : MALE (0)
	sbc a
	and FEMALE
	ld hl, wEggMonGender
	or [hl]
	ld [hl], a

	; Form (same byte as gender) was already determined
	ld a, [wCurForm]
	or [hl]
	ld [hl], a

	; Mark as an egg (same byte as form)
	set MON_IS_EGG_F, [hl]

	; Ball inheritance: from the mother or non-Ditto. If both
	; parents share species, pick at random.
	ld hl, wBreedMon1CaughtBall
	call .inherit_mother_unless_samespecies
	ld a, [hl]
	ld [wEggMonCaughtBall], a

	; PP, egg cycles, level
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, NAME_LENGTH
	rst CopyBytes
	ld hl, wEggMonMoves
	ld de, wEggMonPP
	predef FillPP
	ld hl, wMonOrItemNameBuffer
	ld de, wStringBuffer1
	ld bc, NAME_LENGTH
	rst CopyBytes
	ld a, [wBaseEggSteps]
	and $f
	inc a
	ld b, a
	add a
	add a
	add b
	ld hl, wEggMonHappiness
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, [wCurPartyLevel]
	ld [wEggMonLevel], a
	ret

.inherit_mother_unless_samespecies
	ld a, [wBreedMon1Species]
	ld b, a
	ld a, [wBreedMon2Species]
	cp b
	ld a, [wBreedMotherOrNonDitto]
	jr nz, .use_mother
	call Random
	and 1
.use_mother
	inc a
	call GetParentAddr
	ld a, [hl]
	ret

.String_EGG:
	db "Egg@"
