FruitTreeScript:: ; 44000
	opentext
	writetext FruitBearingTreeText
	buttonsound
	callasm TryResetFruitTrees
	copybytetovar CurFruit
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
	copybytetovar CurFruit
	callasm FertilizedFruitTree
	jumpopenedtext UsedMulchText

PickBerryScript:
	copybytetovar CurFruit
	ifless NUM_APRICORNS+1, PickApricornScript
	itemtotext $0, $0
	writetext HeyItsFruitText
	callasm GetFruitTreeCount
	ifequal $1, .try_one
	ifequal $2, .try_two
	copybytetovar CurFruit
	giveitem ITEM_FROM_MEM, 3
	iffalse .try_two
	buttonsound
	writetext ObtainedThreeFruitText
	jump .continue
.try_two
	copybytetovar CurFruit
	giveitem ITEM_FROM_MEM, 2
	iffalse .try_one
	buttonsound
	writetext ObtainedTwoFruitText
	jump .continue
.try_one
	copybytetovar CurFruit
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
; 44041

PickApricornScript:
	checkitem APRICORN_BOX
	iffalse_jumpopenedtext NoApricornBoxText
	copybytetovar CurFruit
	callasm .get_name
	writetext HeyItsFruitText
	callasm GetFruitTreeCount
	ifequal $1, .try_one
	ifequal $2, .try_two
	copybytetovar CurFruit
	giveapricorn ITEM_FROM_MEM, 3
	iffalse .try_two
	buttonsound
	writetext ObtainedThreeFruitText
	jump .continue
.try_two
	copybytetovar CurFruit
	giveapricorn ITEM_FROM_MEM, 2
	iffalse .try_one
	buttonsound
	writetext ObtainedTwoFruitText
	jump .continue
.try_one
	copybytetovar CurFruit
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
	ld a, [ScriptVar]
	ld [wd265], a
	call GetApricornName
	ld de, StringBuffer1
	ld hl, StringBuffer3
	jp CopyName2

TryResetFruitTrees: ; 4404c
	ld hl, DailyFlags
	bit 4, [hl] ; ENGINE_ALL_FRUIT_TREES
	ret nz
	xor a
	ld hl, FruitTreeFlags
rept (NUM_FRUIT_TREES + 7) / 8 - 1
	ld [hli], a
endr
	ld [hl], a
	ld hl, DailyFlags
	set 4, [hl] ; ENGINE_ALL_FRUIT_TREES
	ret
; 44078

CheckFruitTree: ; 44055
	ld b, CHECK_FLAG
	call GetFruitTreeFlag
	ld a, c
	ld [ScriptVar], a
	ret
; 4405f

PickedFruitTree: ; 4405f
	ld b, SET_FLAG
	jr GetFruitTreeFlag
; 4406a

FertilizedFruitTree:
	ld b, RESET_FLAG
GetFruitTreeFlag: ; 44078
	push hl
	push de
	ld a, [CurFruitTree]
	dec a
	ld e, a
	ld d, 0
	ld hl, FruitTreeFlags
	call FlagAction
	pop de
	pop hl
	ret
; 4408a

GetFruitTreeCount:
	ld a, 3
	call RandomRange
	inc a
	ld [ScriptVar], a
	ret

FruitBearingTreeText: ; 440b5
	text_jump _FruitBearingTreeText
	db "@"
; 440ba

HeyItsFruitText: ; 440ba
	text_jump _HeyItsFruitText
	db "@"
; 440bf

ObtainedOneFruitText: ; 440bf
	text_jump _ObtainedOneFruitText
	db "@"
; 440c4

ObtainedTwoFruitText:
	text_jump _ObtainedTwoFruitText
	db "@"

ObtainedThreeFruitText:
	text_jump _ObtainedThreeFruitText
	db "@"

FruitPackIsFullText: ; 440c4
	text_jump _FruitPackIsFullText
	db "@"
; 440c9

NoApricornBoxText:
	text_jump _NoApricornBoxText
	db "@"

ApricornBoxIsFullText:
	text_jump _ApricornBoxIsFullText
	db "@"

PutAwayTheApricornText:
	text_jump _PutAwayTheApricornText
	db "@"

NothingHereText: ; 440c9
	text_jump _NothingHereText
	db "@"
; 440ce

WantToUseMulchText:
	text_jump _WantToUseMulchText
	db "@"

UsedMulchText:
	text_jump _UsedMulchText
	db "@"
