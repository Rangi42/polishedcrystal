FruitTreeScript::
	opentext
	farwritetext _FruitBearingTreeText
	buttonsound
	copybytetovar wCurFruit
	callasm CheckFruitTree
	iffalse PickBerryScript
	farwritetext _NothingHereText
	buttonsound
	checkitem MULCH
	iffalse_endtext
	farwritetext _WantToUseMulchText
	yesorno
	iffalse_endtext
	takeitem MULCH
	copybytetovar wCurFruit
	callasm FertilizedFruitTree
	thisopenedtext

	text_jump _UsedMulchText
	text_end

PickBerryScript:
	copybytetovar wCurFruit
	ifless NUM_APRICORNS+1, PickApricornScript
	itemtotext $0, $0
	farwritetext _HeyItsFruitText
	callasm GetFruitTreeCount
	ifequal $1, .try_one
	ifequal $2, .try_two
	copybytetovar wCurFruit
	giveitem ITEM_FROM_MEM, 3
	iffalse .try_two
	buttonsound
	farwritetext _ObtainedThreeFruitText
	jump .continue
.try_two
	copybytetovar wCurFruit
	giveitem ITEM_FROM_MEM, 2
	iffalse .try_one
	buttonsound
	farwritetext _ObtainedTwoFruitText
	jump .continue
.try_one
	copybytetovar wCurFruit
	giveitem ITEM_FROM_MEM
	iffalse .packisfull
	buttonsound
	farwritetext _ObtainedOneFruitText
.continue
	callasm PickedFruitTree
	specialsound
	itemnotify
	closetext
	end

.packisfull
	buttonsound
	thisopenedtext

	text_jump _FruitPackIsFullText
	text_end

PickApricornScript:
	checkkeyitem APRICORN_BOX
	iffalse_jumpopenedtext NoApricornBoxText
	copybytetovar wCurFruit
	callasm .get_name
	farwritetext _HeyItsFruitText
	callasm GetFruitTreeCount
	ifequal $1, .try_one
	ifequal $2, .try_two
	copybytetovar wCurFruit
	giveapricorn ITEM_FROM_MEM, 3
	iffalse .try_two
	buttonsound
	farwritetext _ObtainedThreeFruitText
	jump .continue
.try_two
	copybytetovar wCurFruit
	giveapricorn ITEM_FROM_MEM, 2
	iffalse .try_one
	buttonsound
	farwritetext _ObtainedTwoFruitText
	jump .continue
.try_one
	copybytetovar wCurFruit
	giveapricorn ITEM_FROM_MEM
	iffalse .packisfull
	buttonsound
	farwritetext _ObtainedOneFruitText
.continue
	callasm PickedFruitTree
	specialsound
	thisopenedtext

	text_jump _PutAwayTheApricornText
	text_end

.packisfull
	buttonsound
	thisopenedtext

	text_jump _ApricornBoxIsFullText
	text_end

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

NoApricornBoxText:
	text_jump _NoApricornBoxText
	text_end
