FruitTreeScript::
	opentext
	farwritetext _FruitBearingTreeText
	promptbutton
	readmem wCurFruit
	callasm CheckFruitTree
	iffalsefwd PickBerryScript
	farwritetext _NothingHereText
	promptbutton
	checkitem MULCH
	iffalse_endtext
	farwritetext _WantToUseMulchText
	yesorno
	iffalse_endtext
	takeitem MULCH
	readmem wCurFruit
	callasm FertilizedFruitTree
	jumpthisopenedtext

	text_far _UsedMulchText
	text_end

PickBerryScript:
	readmem wCurFruit
	ifless NUM_APRICORNS+1, PickApricornScript
	getitemname USE_SCRIPT_VAR, STRING_BUFFER_3
	farwritetext _HeyItsFruitText
	callasm GetFruitTreeCount
	setquantity
	pluralize wStringBuffer3
	ifequalfwd $1, .try_one
	ifequalfwd $2, .try_two
	readmem wCurFruit
	giveitem ITEM_FROM_MEM, 3
	iffalsefwd .try_two
	promptbutton
	farwritetext _ObtainedThreeFruitText
	callasm .ShowBerryIcon
	sjumpfwd .continue
.try_two
	readmem wCurFruit
	giveitem ITEM_FROM_MEM, 2
	iffalsefwd .try_one
	promptbutton
	farwritetext _ObtainedTwoFruitText
	callasm .ShowBerryIcon
	sjumpfwd .continue
.try_one
	readmem wCurFruit
	giveitem ITEM_FROM_MEM
	iffalsefwd .packisfull
	promptbutton
	farwritetext _ObtainedOneFruitText
	callasm .ShowBerryIcon
.continue
	callasm PickedFruitTree
	specialsound
	itemnotify
	closetext
	end

.packisfull
	promptbutton
	jumpthisopenedtext

	text_far _FruitPackIsFullText
	text_end

.ShowBerryIcon:
	ld a, [wCurFruit]
	push af
	call LoadItemIconForOverworld
	pop af
	farcall LoadItemIconPaletteFromA
	jmp PrintOverworldItemIcon

PickApricornScript:
	checkkeyitem APRICORN_BOX
	iffalse_jumpopenedtext NoApricornBoxText
	readmem wCurFruit
	callasm .GetApricornName
	farwritetext _HeyItsFruitText
	callasm GetFruitTreeCount
	ifequalfwd $1, .try_one
	ifequalfwd $2, .try_two
	readmem wCurFruit
	giveapricorn ITEM_FROM_MEM, 3
	iffalsefwd .try_two
	promptbutton
	farwritetext _ObtainedThreeFruitText
	callasm .ShowApricornIcon
	sjumpfwd .continue
.try_two
	readmem wCurFruit
	giveapricorn ITEM_FROM_MEM, 2
	iffalsefwd .try_one
	promptbutton
	farwritetext _ObtainedTwoFruitText
	callasm .ShowApricornIcon
	sjumpfwd .continue
.try_one
	readmem wCurFruit
	giveapricorn ITEM_FROM_MEM
	iffalsefwd .packisfull
	promptbutton
	farwritetext _ObtainedOneFruitText
	callasm .ShowApricornIcon
.continue
	callasm PickedFruitTree
	specialsound
	jumpthisopenedtext

	text_far _PutAwayTheApricornText
	text_end

.packisfull
	promptbutton
	jumpthisopenedtext

	text_far _ApricornBoxIsFullText
	text_end

.GetApricornName:
	ldh a, [hScriptVar]
	ld [wNamedObjectIndex], a
	call GetApricornName
	ld de, wStringBuffer1
	ld hl, wStringBuffer3
	jmp CopyName2

.ShowApricornIcon:
	ld a, [wCurFruit]
	push af
	call LoadApricornIconForOverworld
	pop af
	ld bc, ApricornIconPalettes - COLOR_SIZE * 2
	farcall LoadIconPalette
	jmp PrintOverworldItemIcon

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
	text_far _NoApricornBoxText
	text_end
