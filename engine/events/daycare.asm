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

Special_DayCareMan: ; 166d6
	ld hl, wDaycareMan
	bit 0, [hl]
	jr nz, .AskWithdrawMon
	ld hl, wDaycareMan
	ld a, DAYCARETEXT_MAN_INTRO
	call DayCareManIntroText
	jr c, .cancel
	call DayCareAskDepositPokemon
	jr c, .print_text
	farcall DepositMonWithDaycareMan
	ld hl, wDaycareMan
	set 0, [hl]
	call DayCare_DepositPokemonText
	jp DayCare_InitBreeding

.AskWithdrawMon:
	farcall GetBreedMon1LevelGrowth
	ld hl, wBreedMon1Nick
	call GetPriceToRetrieveBreedmon
	call DayCare_AskWithdrawBreedMon
	jr c, .print_text
	farcall RetrievePokemonFromDaycareMan
	call DayCare_TakeMoney_PlayCry
	ld hl, wDaycareMan
	res 0, [hl]
	res 5, [hl]
	jr .cancel

.print_text
	call PrintDayCareText

.cancel
	ld a, DAYCARETEXT_13
	jp PrintDayCareText
; 1672a

Special_DayCareLady: ; 1672a
	ld hl, wDaycareLady
	bit 0, [hl]
	jr nz, .AskWithdrawMon
	ld hl, wDaycareLady
	ld a, DAYCARETEXT_LADY_INTRO
	call DayCareLadyIntroText
	jr c, .cancel
	call DayCareAskDepositPokemon
	jr c, .print_text
	farcall DepositMonWithDaycareLady
	ld hl, wDaycareLady
	set 0, [hl]
	call DayCare_DepositPokemonText
	jp DayCare_InitBreeding

.AskWithdrawMon:
	farcall GetBreedMon2LevelGrowth
	ld hl, wBreedMon2Nick
	call GetPriceToRetrieveBreedmon
	call DayCare_AskWithdrawBreedMon
	jr c, .print_text
	farcall RetrievePokemonFromDaycareLady
	call DayCare_TakeMoney_PlayCry
	ld hl, wDaycareLady
	res 0, [hl]
	ld hl, wDaycareMan
	res 5, [hl]
	jr .cancel

.print_text
	call PrintDayCareText

.cancel
	ld a, DAYCARETEXT_13
	jp PrintDayCareText
; 16781

DayCareLadyIntroText: ; 16781
	bit 7, [hl]
	jr nz, DayCarePersonIntroText
	inc a
DayCareManIntroText: ; 1678f
	set 7, [hl]
DayCarePersonIntroText
	call PrintDayCareText
	jp YesNoBox
; 16798

DayCareAskDepositPokemon: ; 16798
	ld a, [PartyCount]
	cp 2
	jr c, .OnlyOneMon
	ld a, DAYCARETEXT_WHICH_ONE
	call PrintDayCareText
	ld b, 6
	farcall SelectTradeOrDaycareMon
	jr c, .Declined
	ld a, [CurPartySpecies]
	cp EGG
	jr z, .Egg
	farcall CheckCurPartyMonFainted
	jr c, .OutOfUsableMons
	ld hl, PartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [CurPartyMon]
	call AddNTimes
	ld d, [hl]
	call ItemIsMail
	jr c, .HoldingMail
	ld hl, PartyMonNicknames
	ld a, [CurPartyMon]
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
; 167f1

DayCare_DepositPokemonText: ; 167f6
	ld a, DAYCARETEXT_DEPOSIT
	call PrintDayCareText
	ld a, [CurPartySpecies]
	call PlayCry
	ld a, DAYCARETEXT_COME_BACK_LATER
	jp PrintDayCareText
; 16807

DayCare_AskWithdrawBreedMon: ; 16807
	ld a, [StringBuffer2 + 1]
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
	ld de, Money
	ld bc, StringBuffer2 + 2
	farcall CompareMoney
	jr c, .not_enough_money
	ld a, [PartyCount]
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
; 16850

DayCare_TakeMoney_PlayCry: ; 16850
	ld bc, StringBuffer2 + 2
	ld de, Money
	farcall TakeMoney
	ld a, DAYCARETEXT_WITHDRAW
	call PrintDayCareText
	ld a, [CurPartySpecies]
	call PlayCry
	ld a, DAYCARETEXT_TOO_SOON
	jp PrintDayCareText
; 1686d

GetPriceToRetrieveBreedmon: ; 1686d
	ld a, b
	ld [StringBuffer2], a
	ld a, d
	ld [StringBuffer2 + 1], a
	ld de, StringBuffer1
	ld bc, NAME_LENGTH
	call CopyBytes
	ld hl, 0
	ld bc, 100
	ld a, [StringBuffer2 + 1]
	call AddNTimes
	ld de, 100
	add hl, de
	xor a
	ld [StringBuffer2 + 2], a
	ld a, h
	ld [StringBuffer2 + 3], a
	ld a, l
	ld [StringBuffer2 + 4], a
	ret
; 1689b

PrintDayCareText: ; 1689b
	ld e, a
	ld d, 0
	ld hl, .TextTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp PrintText
; 168aa

.TextTable: ; 168aa
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
; 168d2

.DayCareManIntro: ; 0x168d2
	; I'm the DAY-CARE MAN. Want me to raise a #MON?
	text_jump UnknownText_0x1bdaa9
	db "@"
; 0x168d7

.DayCareManOddEgg: ; 0x168d7
	; I'm the DAY-CARE MAN. Do you know about EGGS? I was raising #MON with my wife, you see. We were shocked to find an EGG! How incredible is that? So, want me to raise a #MON?
	text_jump UnknownText_0x1bdad8
	db "@"
; 0x168dc

.DayCareLadyIntro: ; 0x168dc
	; I'm the DAY-CARE LADY. Should I raise a #MON for you?
	text_jump UnknownText_0x1bdb85
	db "@"
; 0x168e1

.DayCareLadyOddEgg: ; 0x168e1
	; I'm the DAY-CARE LADY. Do you know about EGGS? My husband and I were raising some #MON, you see. We were shocked to find an EGG! How incredible could that be? Should I raise a #MON for you?
	text_jump UnknownText_0x1bdbbb
	db "@"
; 0x168e6

.WhichOne: ; 0x168e6
	; What should I raise for you?
	text_jump UnknownText_0x1bdc79
	db "@"
; 0x168eb

.JustOneMon: ; 0x168eb
	; Oh? But you have just one #MON.
	text_jump UnknownText_0x1bdc97
	db "@"
; 0x168f0

.CantAcceptEgg: ; 0x168f0
	; Sorry, but I can't accept an EGG.
	text_jump UnknownText_0x1bdcb8
	db "@"
; 0x168f5

.RemoveMail: ; 0x168f5
	; Remove MAIL before you come see me.
	text_jump UnknownText_0x1bdcda
	db "@"
; 0x168fa

.LastHealthyMon: ; 0x168fa
	; If you give me that, what will you battle with?
	text_jump UnknownText_0x1bdcff
	db "@"
; 0x168ff

.OkayIllRaiseYourMon: ; 0x168ff
	; OK. I'll raise your @ .
	text_jump UnknownText_0x1bdd30
	db "@"
; 0x16904

.ComeBackForItLater: ; 0x16904
	; Come back for it later.
	text_jump UnknownText_0x1bdd4b
	db "@"
; 0x16909

.AreWeGeniusesOrWhat: ; 0x16909
	; Are we geniuses or what? Want to see your @ ?
	text_jump UnknownText_0x1bdd64
	db "@"
; 0x1690e

.AskRetrieveMon: ; 0x1690e
	; Your @ has grown a lot. By level, it's grown by @ . If you want your #MON back, it will cost ¥@ .
	text_jump UnknownText_0x1bdd96
	db "@"
; 0x16913

.PerfectHeresYourMon: ; 0x16913
	; Perfect! Here's your #MON.
	text_jump UnknownText_0x1bde04
	db "@"
; 0x16918

.GotBackMon: ; 0x16918
	; got back @ .
	text_jump UnknownText_0x1bde1f
	db "@"
; 0x1691d

.ImmediatelyWithdrawMon: ; 0x1691d
	; Huh? Back already? Your @ needs a little more time with us. If you want your #MON back, it will cost ¥100.
	text_jump UnknownText_0x1bde32
	db "@"
; 0x16922

.PartyFull: ; 0x16922
	; You have no room for it.
	text_jump UnknownText_0x1bdea2
	db "@"
; 0x16927

.NotEnoughMoney: ; 0x16927
	; You don't have enough money.
	text_jump UnknownText_0x1bdebc
	db "@"
; 0x1692c

.OhFineThen: ; 0x1692c
	; Oh, fine then.
	text_jump UnknownText_0x1bded9
	db "@"
; 0x16931

.ComeAgain: ; 0x16931
	; Come again.
	text_jump UnknownText_0x1bdee9
	db "@"
; 0x16936

Special_DayCareManOutside: ; 16936
	ld hl, wDaycareMan
	bit 6, [hl]
	jr nz, .AskGiveEgg
	ld hl, .NotYet
	jp PrintText

.NotYet: ; 0x16944
	; Not yet…
	text_jump UnknownText_0x1bdef6
	db "@"
; 0x16949

.AskGiveEgg: ; 16949
	ld hl, .IntroText
	call PrintText
	call YesNoBox
	jr c, .Declined
	ld a, [PartyCount]
	cp PARTY_LENGTH
	jr nc, .PartyFull
	call DayCare_GiveEgg
	ld hl, wDaycareMan
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
	ld [ScriptVar], a
	ret

.PartyFull:
	ld hl, .PartyFullText
	call PrintText
	ld a, $1
	ld [ScriptVar], a
	ret
; 16993

.IntroText: ; 0x16993
	; Ah, it's you! We were raising your #MON, and my goodness, were we surprised! Your #MON had an EGG! We don't know how it got there, but your #MON had it. You want it?
	text_jump UnknownText_0x1bdf00
	db "@"
; 0x16998

.GotEggText: ; 0x16998
	; received the EGG!
	text_jump UnknownText_0x1bdfa5
	db "@"
; 0x1699d

.TakeGoodCareOfItText: ; 0x1699d
	; Take good care of it.
	text_jump UnknownText_0x1bdfba
	db "@"
; 0x169a2

.IllKeepItThanksText: ; 0x169a2
	; Well then, I'll keep it. Thanks!
	text_jump UnknownText_0x1bdfd1
	db "@"
; 0x169a7

.PartyFullText: ; 0x169a7
	; You have no room in your party. Come back later.
	text_jump UnknownText_0x1bdff2
	db "@"
; 0x169ac

DayCare_GiveEgg: ; 169ac
	ld a, [wEggMonLevel]
	ld [CurPartyLevel], a
	ld hl, PartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	jr nc, .PartyFull
	inc a
	ld [hl], a

	ld c, a
	ld b, 0
	add hl, bc
	ld a, EGG
	ld [hli], a
	ld a, [wEggMonSpecies]
	ld [CurSpecies], a
	ld [CurPartySpecies], a
	ld a, -1
	ld [hl], a

	ld hl, PartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	call DayCare_GetCurrentPartyMember
	ld hl, wEggNick
	call CopyBytes

	ld hl, PartyMonOT
	ld bc, NAME_LENGTH
	call DayCare_GetCurrentPartyMember
	ld hl, wEggOT
	call CopyBytes

	ld hl, PartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call DayCare_GetCurrentPartyMember
	ld hl, wEggMon
	ld bc, wEggMonEnd - wEggMon
	call CopyBytes

	call GetBaseData
	ld a, [PartyCount]
	dec a
	ld hl, PartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
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
; 16a31

DayCare_GetCurrentPartyMember:
	ld a, [PartyCount]
	dec a
	call AddNTimes
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
; from parent DVs in hl. Returns z if we successfully inherited it.
; Preserves de+hl
	; Figure out if we can inherit the DV
	; Have we inherited as much as we can?
	ld a, b
	and a
	jr z, .cant_inherit

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
	jr z, .cant_inherit

	; Mark the stat as inherited and decrease inherit counter
	or c
	ld c, a
	dec b

	; Inherit the stat
	ld a, e
	push de
	push hl
	ld de, wEggMonDVs
	srl a
	; inc/dec doesn't alter carry flag
	inc a
.find_dv_loop
	dec a
	jr z, .found_dv
	inc de
	inc hl
	jr .find_dv_loop
.found_dv
	push de
	jr nc, .swap_done
	push de
	ld d, h
	ld e, l
	pop hl
.swap_done
	; Take the high nibble from hl and the low from de and put into
	; the uppermost stack addr (eggmon DV)
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
	xor a
	ret
.cant_inherit
	or 1
	ret

DayCare_InitBreeding: ; 16a3b
	ld a, [wDaycareLady]
	bit 0, a
	ret z
	ld a, [wDaycareMan]
	bit 0, a
	ret z
	farcall CheckBreedmonCompatibility
	ld a, [wd265]
	and a
	ret z
	ld hl, wDaycareMan
	set 5, [hl]
.loop
	call Random
	cp 150
	jr c, .loop
	ld [wStepsToEgg], a
	xor a
	ld hl, wEggMon
	ld bc, wEggMonEnd - wEggMon
	call ByteFill
	ld hl, wEggNick
	ld bc, PKMN_NAME_LENGTH
	call ByteFill
	ld hl, wEggOT
	ld bc, NAME_LENGTH
	call ByteFill
	ld a, [wBreedMon1Species]
	ld [CurPartySpecies], a
	ld a, $3
	ld [MonType], a
	ld a, [wBreedMon1Species]
	cp DITTO
	ld a, $1
	jr z, .LoadWhichBreedmonIsTheMother
	ld a, [wBreedMon2Species]
	cp DITTO
	ld a, 0 ; not xor a; preserve carry flag
	jr z, .LoadWhichBreedmonIsTheMother
	farcall GetGender
	ld a, 0 ; not xor a; preserve carry flag
	jr z, .LoadWhichBreedmonIsTheMother
	inc a

.LoadWhichBreedmonIsTheMother:
	ld [wBreedMotherOrNonDitto], a
	and a
	ld a, [wBreedMon1Species]
	jr z, .GotMother
	ld a, [wBreedMon2Species]

.GotMother:
	ld [CurPartySpecies], a
	farcall GetPreEvolution
	farcall GetPreEvolution
	ld a, EGG_LEVEL
	ld [CurPartyLevel], a

	ld a, [CurPartySpecies]
	cp NIDORAN_F
	jr z, .NidoranFamilyMother
	cp NIDORINA
	jr z, .NidoranFamilyMother
	cp NIDOQUEEN
	jr nz, .GotEggSpecies
.NidoranFamilyMother:
	call Random
	cp 1 + 50 percent
	ld a, NIDORAN_F
	jr c, .GotEggSpecies
	ld a, NIDORAN_M
.GotEggSpecies:
	ld [CurPartySpecies], a
	ld [CurSpecies], a
	ld [wEggMonSpecies], a

	call GetBaseData

	; Set name and item
	ld hl, wEggNick
	ld de, .String_EGG
	call CopyName2
	ld hl, PlayerName
	ld de, wEggOT
	ld bc, NAME_LENGTH
	call CopyBytes
	xor a
	ld [wEggMonItem], a

	; Set moves for the egg
	ld de, wEggMonMoves
	xor a
	ld [Buffer1], a
	predef FillMoves
	farcall InitEggMoves

	; Set OTID to the player
	ld hl, wEggMonID
	ld a, [PlayerID]
	ld [hli], a
	ld a, [PlayerID + 1]
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
	; 80% to get mother's ability
	ld a, [wBreedMotherOrNonDitto]
	and a
	ld a, [wBreedMon1Ability]
	jr z, .got_mother_ability
	ld a, [wBreedMon2Ability]
.got_mother_ability
	ld b, a
	
	ld a, 5
	call RandomRange
	and a
	jr z, .random_ability

	ld a, b
	and ABILITY_MASK
	jr .got_ability

.random_ability
	ld a, 40
	call RandomRange
	cp 2
	jr c, .hidden_ability
	cp 21
	jr c, .ability2
	ld a, ABILITY_1
	jr .got_ability
.ability2
	ld a, ABILITY_2
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
	ld [CurItem], a
	push hl
	push bc
	push de
	ld hl, NumKeyItems
	call CheckItem
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
	ld a, 8
	call RandomRange
	ld b, a
	ld a, [wEggMonSpecies]
	dec a
	push bc
	ld hl, BASEMON_GENDER
	ld bc, BASEMON_STRUCT_LENGTH
	ld a, BANK(BaseData)
	call GetFarByte
	swap a
	and $f
	pop bc
	ld c, a
	ld a, b
	; if rnd(0..7) < c: female, else male
	cp c
	ld a, FEMALE
	jr c, .got_gender
	xor a ; ld a, MALE
.got_gender
	ld hl, wEggMonGender
	or [hl]
	ld [hl], a

	; Ball inheritance: from the mother or non-Ditto. If both
	; parents share species, pick at random.
	ld hl, wBreedMon1CaughtBall
	call .inherit_mother_unless_samespecies
	ld a, [hl]
	ld [wEggMonCaughtBall], a

	; Form works the same as Ball
	ld hl, wBreedMon1Form
	call .inherit_mother_unless_samespecies
	ld a, [hl]
	and FORM_MASK
	ld hl, wEggMonForm
	or [hl]
	ld [hl], a

	; PP, egg cycles, level
	ld hl, StringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, NAME_LENGTH
	call CopyBytes
	ld hl, wEggMonMoves
	ld de, wEggMonPP
	predef FillPP
	ld hl, wMonOrItemNameBuffer
	ld de, StringBuffer1
	ld bc, NAME_LENGTH
	call CopyBytes
	ld a, [BaseEggSteps]
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
	ld a, [CurPartyLevel]
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
