FruitTreeScript::
	opentext
	writetext FruitBearingTreeText
	buttonsound
	copybytetovar wCurFruit
	callasm CheckFruitTree
	iffalse PickBerryScript
	writetext NothingHereText
	buttonsound
	checkitem MULCH
	iffalse_endtext
	writetext WantToUseMulchText
	yesorno
	iffalse_endtext
	takeitem MULCH
	copybytetovar wCurFruit
	callasm FertilizedFruitTree
	jumpopenedtext UsedMulchText

PickBerryScript:
	copybytetovar wCurFruit
	ifless NUM_APRICORNS+1, PickApricornScript
	itemtotext $0, $0
	writetext HeyItsFruitText
	callasm GetFruitTreeCount
	ifequal $1, .try_one
	ifequal $2, .try_two
	copybytetovar wCurFruit
	giveitem ITEM_FROM_MEM, 3
	iffalse .try_two
	buttonsound
	writetext ObtainedThreeFruitText
	jump .continue
.try_two
	copybytetovar wCurFruit
	giveitem ITEM_FROM_MEM, 2
	iffalse .try_one
	buttonsound
	writetext ObtainedTwoFruitText
	jump .continue
.try_one
	copybytetovar wCurFruit
	giveitem ITEM_FROM_MEM
	iffalse .packisfull
	buttonsound
	writetext ObtainedOneFruitText
.continue
	callasm PickedFruitTree
	specialsound
	itemnotify
	closetext
	end

.packisfull
	buttonsound
	jumpopenedtext FruitPackIsFullText

PickApricornScript:
	checkkeyitem APRICORN_BOX
	iffalse_jumpopenedtext NoApricornBoxText
	copybytetovar wCurFruit
	callasm .get_name
	writetext HeyItsFruitText
	callasm GetFruitTreeCount
	ifequal $1, .try_one
	ifequal $2, .try_two
	copybytetovar wCurFruit
	giveapricorn ITEM_FROM_MEM, 3
	iffalse .try_two
	buttonsound
	writetext ObtainedThreeFruitText
	jump .continue
.try_two
	copybytetovar wCurFruit
	giveapricorn ITEM_FROM_MEM, 2
	iffalse .try_one
	buttonsound
	writetext ObtainedTwoFruitText
	jump .continue
.try_one
	copybytetovar wCurFruit
	giveapricorn ITEM_FROM_MEM
	iffalse .packisfull
	buttonsound
	writetext ObtainedOneFruitText
.continue
	callasm PickedFruitTree
	specialsound
	jumpopenedtext PutAwayTheApricornText

.packisfull
	buttonsound
	jumpopenedtext FruitPackIsFullText

.get_name:
	ldh a, [hScriptVar]
	ld [wd265], a
	call GetApricornName
	ld de, wStringBuffer1
	ld hl, wStringBuffer3
	jp CopyName2

CheckFruitTree:
	ld b, CHECK_FLAG
	call GetFruitTreeFlag
	ld a, c
	ldh [hScriptVar], a
	ret

PickedFruitTree:
	ld b, SET_FLAG
	jr GetFruitTreeFlag

FertilizedFruitTree:
	ld b, RESET_FLAG
GetFruitTreeFlag:
	push hl
	push de
	ld a, [wCurFruitTree]
	dec a
	ld e, a
	ld d, 0
	ld hl, wFruitTreeFlags
	call FlagAction
	pop de
	pop hl
	ret

GetFruitTreeCount:
	ld a, 3
	call RandomRange
	inc a
	ldh [hScriptVar], a
	ret

FruitBearingTreeText:
	text_jump _FruitBearingTreeText
	text_end

HeyItsFruitText:
	text_jump _HeyItsFruitText
	text_end

ObtainedOneFruitText:
	text_jump _ObtainedOneFruitText
	text_end

ObtainedTwoFruitText:
	text_jump _ObtainedTwoFruitText
	text_end

ObtainedThreeFruitText:
	text_jump _ObtainedThreeFruitText
	text_end

FruitPackIsFullText:
	text_jump _FruitPackIsFullText
	text_end

NoApricornBoxText:
	text_jump _NoApricornBoxText
	text_end

ApricornBoxIsFullText:
	text_jump _ApricornBoxIsFullText
	text_end

PutAwayTheApricornText:
	text_jump _PutAwayTheApricornText
	text_end

NothingHereText:
	text_jump _NothingHereText
	text_end

WantToUseMulchText:
	text_jump _WantToUseMulchText
	text_end

UsedMulchText:
	text_jump _UsedMulchText
	text_end
