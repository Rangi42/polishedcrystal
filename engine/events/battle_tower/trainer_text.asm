BattleTowerText::
; Print text c for trainer [wOtherTrainerClass]
; 1: Intro text
; 2: Player lost
; 3: Player won
	ld a, [wOtherTrainerClass]
	cp TOWERTYCOON
	jr z, .tycoon
	cp FACTORYHEAD
	jr z, .head

	push bc
	dec a
	ld c, a
	ld b, CHECK_FLAG
	ld hl, BTTrainerClassGenders
	ld d, BANK(BTTrainerClassGenders)
	farcall SmallFlagAction
	ld a, c
	pop bc
	and a
	jr nz, .female

	; generate a random number between 0 and 24
	ld a, 25
	call RandomRange
	ld hl, BTMaleTrainerTexts
	jr .proceed

.tycoon
	; always use the number 0
	xor a
	ld hl, BTTycoonTexts
	jr .proceed

.head
	; always use the number 0
	xor a
	ld hl, BFHeadTexts
	jr .proceed

.female
	; generate a random number between 0 and 14
	ld a, 15
	call RandomRange
	ld hl, BTFemaleTrainerTexts
	; fallthrough
.proceed
	ld b, 0
	dec c
	jr nz, .restore
	ld [wBT_TrainerTextIndex], a
	jr .okay2

.restore
	ld a, [wBT_TrainerTextIndex]

.okay2
	push af
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld h, a
	ld l, c
	pop af
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld l, c
	ld h, a
	bccoord 1, 14
	jmp PlaceWholeStringInBoxAtOnce

INCLUDE "data/trainers/genders.asm"

BTMaleTrainerTexts:
	dw .Greetings
	dw .PlayerLost
	dw .PlayerWon

.Greetings:
	dw BTGreetingM1
	dw BTGreetingM2
	dw BTGreetingM3
	dw BTGreetingM4
	dw BTGreetingM5
	dw BTGreetingM6
	dw BTGreetingM7
	dw BTGreetingM8
	dw BTGreetingM9
	dw BTGreetingM10
	dw BTGreetingM11
	dw BTGreetingM12
	dw BTGreetingM13
	dw BTGreetingM14
	dw BTGreetingM15
	dw BTGreetingM16
	dw BTGreetingM17
	dw BTGreetingM18
	dw BTGreetingM19
	dw BTGreetingM20
	dw BTGreetingM21
	dw BTGreetingM22
	dw BTGreetingM23
	dw BTGreetingM24
	dw BTGreetingM25

.PlayerLost:
	dw BTLossM1
	dw BTLossM2
	dw BTLossM3
	dw BTLossM4
	dw BTLossM5
	dw BTLossM6
	dw BTLossM7
	dw BTLossM8
	dw BTLossM9
	dw BTLossM10
	dw BTLossM11
	dw BTLossM12
	dw BTLossM13
	dw BTLossM14
	dw BTLossM15
	dw BTLossM16
	dw BTLossM17
	dw BTLossM18
	dw BTLossM19
	dw BTLossM20
	dw BTLossM21
	dw BTLossM22
	dw BTLossM23
	dw BTLossM24
	dw BTLossM25

.PlayerWon:
	dw BTWinM1
	dw BTWinM2
	dw BTWinM3
	dw BTWinM4
	dw BTWinM5
	dw BTWinM6
	dw BTWinM7
	dw BTWinM8
	dw BTWinM9
	dw BTWinM10
	dw BTWinM11
	dw BTWinM12
	dw BTWinM13
	dw BTWinM14
	dw BTWinM15
	dw BTWinM16
	dw BTWinM17
	dw BTWinM18
	dw BTWinM19
	dw BTWinM20
	dw BTWinM21
	dw BTWinM22
	dw BTWinM23
	dw BTWinM24
	dw BTWinM25

BTFemaleTrainerTexts:
	dw .Greetings
	dw .PlayerLost
	dw .PlayerWon

.Greetings:
	dw BTGreetingF1
	dw BTGreetingF2
	dw BTGreetingF3
	dw BTGreetingF4
	dw BTGreetingF5
	dw BTGreetingF6
	dw BTGreetingF7
	dw BTGreetingF8
	dw BTGreetingF9
	dw BTGreetingF10
	dw BTGreetingF11
	dw BTGreetingF12
	dw BTGreetingF13
	dw BTGreetingF14
	dw BTGreetingF15

.PlayerLost:
	dw BTLossF1
	dw BTLossF2
	dw BTLossF3
	dw BTLossF4
	dw BTLossF5
	dw BTLossF6
	dw BTLossF7
	dw BTLossF8
	dw BTLossF9
	dw BTLossF10
	dw BTLossF11
	dw BTLossF12
	dw BTLossF13
	dw BTLossF14
	dw BTLossF15

.PlayerWon:
	dw BTWinF1
	dw BTWinF2
	dw BTWinF3
	dw BTWinF4
	dw BTWinF5
	dw BTWinF6
	dw BTWinF7
	dw BTWinF8
	dw BTWinF9
	dw BTWinF10
	dw BTWinF11
	dw BTWinF12
	dw BTWinF13
	dw BTWinF14
	dw BTWinF15

BTTycoonTexts:
	dw .Greetings
	dw .PlayerLost
	dw .PlayerWon

.Greetings:
	dw BTGreetingTycoon

.PlayerLost:
	dw BTLossTycoon

.PlayerWon:
	dw BTWinTycoon

BFHeadTexts:
	dw .Greetings
	dw .PlayerLost
	dw .PlayerWon

.Greetings:
	dw BTGreetingHead

.PlayerLost:
	dw BTLossHead

.PlayerWon:
	dw BTWinHead

BTGreetingM1:
	text_farend _BTGreetingM1Text
BTLossM1:
	text_farend _BTLossM1Text
BTWinM1:
	text_farend _BTWinM1Text
BTGreetingM2:
	text_farend _BTGreetingM2Text
BTLossM2:
	text_farend _BTLossM2Text
BTWinM2:
	text_farend _BTWinM2Text
BTGreetingM3:
	text_farend _BTGreetingM3Text
BTLossM3:
	text_farend _BTLossM3Text
BTWinM3:
	text_farend _BTWinM3Text
BTGreetingM4:
	text_farend _BTGreetingM4Text
BTLossM4:
	text_farend _BTLossM4Text
BTWinM4:
	text_farend _BTWinM4Text
BTGreetingM5:
	text_farend _BTGreetingM5Text
BTLossM5:
	text_farend _BTLossM5Text
BTWinM5:
	text_farend _BTWinM5Text
BTGreetingM6:
	text_farend _BTGreetingM6Text
BTLossM6:
	text_farend _BTLossM6Text
BTWinM6:
	text_farend _BTWinM6Text
BTGreetingM7:
	text_farend _BTGreetingM7Text
BTLossM7:
	text_farend _BTLossM7Text
BTWinM7:
	text_farend _BTWinM7Text
BTGreetingM8:
	text_farend _BTGreetingM8Text
BTLossM8:
	text_farend _BTLossM8Text
BTWinM8:
	text_farend _BTWinM8Text
BTGreetingM9:
	text_farend _BTGreetingM9Text
BTLossM9:
	text_farend _BTLossM9Text
BTWinM9:
	text_farend _BTWinM9Text
BTGreetingM10:
	text_farend _BTGreetingM10Text
BTLossM10:
	text_farend _BTLossM10Text
BTWinM10:
	text_farend _BTWinM10Text
BTGreetingM11:
	text_farend _BTGreetingM11Text
BTLossM11:
	text_farend _BTLossM11Text
BTWinM11:
	text_farend _BTWinM11Text
BTGreetingM12:
	text_farend _BTGreetingM12Text
BTLossM12:
	text_farend _BTLossM12Text
BTWinM12:
	text_farend _BTWinM12Text
BTGreetingM13:
	text_farend _BTGreetingM13Text
BTLossM13:
	text_farend _BTLossM13Text
BTWinM13:
	text_farend _BTWinM13Text
BTGreetingM14:
	text_farend _BTGreetingM14Text
BTLossM14:
	text_farend _BTLossM14Text
BTWinM14:
	text_farend _BTWinM14Text
BTGreetingM15:
	text_farend _BTGreetingM15Text
BTLossM15:
	text_farend _BTLossM15Text
BTWinM15:
	text_farend _BTWinM15Text
BTGreetingM16:
	text_farend _BTGreetingM16Text
BTLossM16:
	text_farend _BTLossM16Text
BTWinM16:
	text_farend _BTWinM16Text
BTGreetingM17:
	text_farend _BTGreetingM17Text
BTLossM17:
	text_farend _BTLossM17Text
BTWinM17:
	text_farend _BTWinM17Text
BTGreetingM18:
	text_farend _BTGreetingM18Text
BTLossM18:
	text_farend _BTLossM18Text
BTWinM18:
	text_farend _BTWinM18Text
BTGreetingM19:
	text_farend _BTGreetingM19Text
BTLossM19:
	text_farend _BTLossM19Text
BTWinM19:
	text_farend _BTWinM19Text
BTGreetingM20:
	text_farend _BTGreetingM20Text
BTLossM20:
	text_farend _BTLossM20Text
BTWinM20:
	text_farend _BTWinM20Text
BTGreetingM21:
	text_farend _BTGreetingM21Text
BTLossM21:
	text_farend _BTLossM21Text
BTWinM21:
	text_farend _BTWinM21Text
BTGreetingM22:
	text_farend _BTGreetingM22Text
BTLossM22:
	text_farend _BTLossM22Text
BTWinM22:
	text_farend _BTWinM22Text
BTGreetingM23:
	text_farend _BTGreetingM23Text
BTLossM23:
	text_farend _BTLossM23Text
BTWinM23:
	text_farend _BTWinM23Text
BTGreetingM24:
	text_farend _BTGreetingM24Text
BTLossM24:
	text_farend _BTLossM24Text
BTWinM24:
	text_farend _BTWinM24Text
BTGreetingM25:
	text_farend _BTGreetingM25Text
BTLossM25:
	text_farend _BTLossM25Text
BTWinM25:
	text_farend _BTWinM25Text
BTGreetingF1:
	text_farend _BTGreetingF1Text
BTLossF1:
	text_farend _BTLossF1Text
BTWinF1:
	text_farend _BTWinF1Text
BTGreetingF2:
	text_farend _BTGreetingF2Text
BTLossF2:
	text_farend _BTLossF2Text
BTWinF2:
	text_farend _BTWinF2Text
BTGreetingF3:
	text_farend _BTGreetingF3Text
BTLossF3:
	text_farend _BTLossF3Text
BTWinF3:
	text_farend _BTWinF3Text
BTGreetingF4:
	text_farend _BTGreetingF4Text
BTLossF4:
	text_farend _BTLossF4Text
BTWinF4:
	text_farend _BTWinF4Text
BTGreetingF5:
	text_farend _BTGreetingF5Text
BTLossF5:
	text_farend _BTLossF5Text
BTWinF5:
	text_farend _BTWinF5Text
BTGreetingF6:
	text_farend _BTGreetingF6Text
BTLossF6:
	text_farend _BTLossF6Text
BTWinF6:
	text_farend _BTWinF6Text
BTGreetingF7:
	text_farend _BTGreetingF7Text
BTLossF7:
	text_farend _BTLossF7Text
BTWinF7:
	text_farend _BTWinF7Text
BTGreetingF8:
	text_farend _BTGreetingF8Text
BTLossF8:
	text_farend _BTLossF8Text
BTWinF8:
	text_farend _BTWinF8Text
BTGreetingF9:
	text_farend _BTGreetingF9Text
BTLossF9:
	text_farend _BTLossF9Text
BTWinF9:
	text_farend _BTWinF9Text
BTGreetingF10:
	text_farend _BTGreetingF10Text
BTLossF10:
	text_farend _BTLossF10Text
BTWinF10:
	text_farend _BTWinF10Text
BTGreetingF11:
	text_farend _BTGreetingF11Text
BTLossF11:
	text_farend _BTLossF11Text
BTWinF11:
	text_farend _BTWinF11Text
BTGreetingF12:
	text_farend _BTGreetingF12Text
BTLossF12:
	text_farend _BTLossF12Text
BTWinF12:
	text_farend _BTWinF12Text
BTGreetingF13:
	text_farend _BTGreetingF13Text
BTLossF13:
	text_farend _BTLossF13Text
BTWinF13:
	text_farend _BTWinF13Text
BTGreetingF14:
	text_farend _BTGreetingF14Text
BTLossF14:
	text_farend _BTLossF14Text
BTWinF14:
	text_farend _BTWinF14Text
BTGreetingF15:
	text_farend _BTGreetingF15Text
BTLossF15:
	text_farend _BTLossF15Text
BTWinF15:
	text_farend _BTWinF15Text
BTGreetingTycoon:
	text_farend BattleTowerText_GreetingTycoon
BTLossTycoon:
	text_farend BattleTowerText_LossTycoon
BTWinTycoon:
	text_farend BattleTowerText_WinTycoon
BTGreetingHead:
	text_farend BattleFactoryText_GreetingHead
BTLossHead:
	text_farend BattleFactoryText_LossHead
BTWinHead:
	text_farend BattleFactoryText_WinHead
