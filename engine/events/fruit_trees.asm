FruitTreeScript::
	opentext
	writetext FruitBearingTreeText
	buttonsound
	callasm TryResetFruitTrees
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

TryResetFruitTrees:
	ld hl, wDailyFlags
	bit 4, [hl] ; ENGINE_ALL_FRUIT_TREES
	ret nz
	xor a
	ld hl, wFruitTreeFlags
rept (NUM_FRUIT_TREES + 7) / 8 - 1
	ld [hli], a
endr
	ld [hl], a
	ld hl, wDailyFlags
	set 4, [hl] ; ENGINE_ALL_FRUIT_TREES
	ret

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
	db "@"

HeyItsFruitText:
	text_jump _HeyItsFruitText
	db "@"

ObtainedOneFruitText:
	text_jump _ObtainedOneFruitText
	db "@"

ObtainedTwoFruitText:
	text_jump _ObtainedTwoFruitText
	db "@"

ObtainedThreeFruitText:
	text_jump _ObtainedThreeFruitText
	db "@"

FruitPackIsFullText:
	text_jump _FruitPackIsFullText
	db "@"

NoApricornBoxText:
	text_jump _NoApricornBoxText
	db "@"

ApricornBoxIsFullText:
	text_jump _ApricornBoxIsFullText
	db "@"

PutAwayTheApricornText:
	text_jump _PutAwayTheApricornText
	db "@"

NothingHereText:
	text_jump _NothingHereText
	db "@"

WantToUseMulchText:
	text_jump _WantToUseMulchText
	db "@"

UsedMulchText:
	text_jump _UsedMulchText
	db "@"
