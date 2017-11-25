_BugContestJudging: ; 1369d
	call ContestScore
	call BugContest_JudgeContestants
	ld a, [wBugContestThirdPlacePersonID]
	call LoadContestantName
	ld a, [wBugContestThirdPlaceMon]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, BugContest_ThirdPlaceText
	call PrintText
	ld a, [wBugContestSecondPlacePersonID]
	call LoadContestantName
	ld a, [wBugContestSecondPlaceMon]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, BugContest_SecondPlaceText
	call PrintText
	ld a, [wBugContestFirstPlacePersonID]
	call LoadContestantName
	ld a, [wBugContestFirstPlaceMon]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, BugContest_FirstPlaceText
	call PrintText
	jp BugContest_GetPlayersResult
; 136eb

BugContest_FirstPlaceText: ; 0x136eb
	text_jump ContestJudging_FirstPlaceText
	start_asm
	ld de, SFX_1ST_PLACE
	call PlaySFX
	call WaitSFX
	ld hl, BugContest_FirstPlaceScoreText
	ret
; 136fd

BugContest_FirstPlaceScoreText: ; 0x136fd
	; The winning score was @  points!
	text_jump ContestJudging_FirstPlaceScoreText
	db "@"
; 0x13702

BugContest_SecondPlaceText: ; 0x13702
	; Placing second was @ , who caught a @ !@ @
	text_jump ContestJudging_SecondPlaceText
	start_asm
	ld de, SFX_2ND_PLACE
	call PlaySFX
	call WaitSFX
	ld hl, BugContest_SecondPlaceScoreText
	ret
; 13714

BugContest_SecondPlaceScoreText: ; 0x13714
	; The score was @  points!
	text_jump ContestJudging_SecondPlaceScoreText
	db "@"
; 0x13719

BugContest_ThirdPlaceText: ; 0x13719
	; Placing third was @ , who caught a @ !@ @
	text_jump ContestJudging_ThirdPlaceText
	start_asm
	ld de, SFX_3RD_PLACE
	call PlaySFX
	call WaitSFX
	ld hl, BugContest_ThirdPlaceScoreText
	ret
; 1372b

BugContest_ThirdPlaceScoreText: ; 0x1372b
	; The score was @  points!
	text_jump ContestJudging_ThirdPlaceScoreText
	db "@"
; 0x13730

LoadContestantName: ; 13730

; If a = 0, get your name.
	dec a
	jr z, .player
; Find the pointer for the trainer class of the Bug Catching Contestant whose ID is in a.
	ld c, a
	ld b, 0
	ld hl, BugContestantPointers
rept 2
	add hl, bc
endr
	ld a, [hli]
	ld h, [hl]
	ld l, a
; Copy the Trainer Class to c.
	ld a, [hli]
	ld c, a
; Save hl and bc for later.
	push hl
	push bc
; Get the Trainer Class name and copy it into wBugContestWinnerName.
	farcall GetTrainerClassName
	ld hl, StringBuffer1
	ld de, wBugContestWinnerName
	ld bc, TRAINER_CLASS_NAME_LENGTH
	call CopyBytes
	ld hl, wBugContestWinnerName
; Delete the trailing terminator and replace it with a space.
.next
	ld a, [hli]
	cp "@"
	jr nz, .next
	dec hl
	ld [hl], " "
	inc hl
	ld d, h
	ld e, l
; Restore the Trainer Class ID and Trainer ID pointer.  Save de for later.
	pop bc
	pop hl
	push de
; Get the name of the trainer with class c and ID b.
	ld a, [hl]
	ld b, a
	farcall GetTrainerName
; Append the name to wBugContestWinnerName.
	ld hl, StringBuffer1
	pop de
	ld bc, NAME_LENGTH - 1
	jp CopyBytes

.player
	ld hl, PlayerName
	ld de, wBugContestWinnerName
	ld bc, NAME_LENGTH
	jp CopyBytes
; 13783

BugContestantPointers: ; 13783
	dw BugContestant_BugCatcherDon ; This reverts back to the player
	dw BugContestant_BugCatcherDon
	dw BugContestant_BugCatcherEd
	dw BugContestant_CooltrainerMNick
	dw BugContestant_PokefanMWilliam
	dw BugContestant_BugCatcherBenny
	dw BugContestant_CamperBarry
	dw BugContestant_PicnickerCindy
	dw BugContestant_BugCatcherJosh
	dw BugContestant_SchoolboyJohnny
	dw BugContestant_SchoolboyKipp
; 13799

BugContestant_BugCatcherDon:
	db BUG_CATCHER, DON
	dbw KAKUNA,     300
	dbw METAPOD,    285
	dbw CATERPIE,   226

BugContestant_BugCatcherEd:
	db BUG_CATCHER, ED
	dbw YANMA,      286
	dbw BUTTERFREE, 251
	dbw CATERPIE,   237

BugContestant_CooltrainerMNick:
	db COOLTRAINERM, NICK
	dbw SCYTHER,    357
	dbw BUTTERFREE, 349
	dbw PINSIR,     368

BugContestant_PokefanMWilliam:
	db POKEFANM, WILLIAM
	dbw VENOMOTH,   332
	dbw BUTTERFREE, 324
	dbw VENONAT,    321

BugContestant_BugCatcherBenny:
	db BUG_CATCHER, BENNY
	dbw BUTTERFREE, 318
	dbw WEEDLE,     295
	dbw CATERPIE,   285

BugContestant_CamperBarry:
	db CAMPER, BARRY
	dbw PINSIR,     366
	dbw VENONAT,    329
	dbw KAKUNA,     314

BugContestant_PicnickerCindy:
	db PICNICKER, CINDY
	dbw BUTTERFREE, 341
	dbw METAPOD,    301
	dbw CATERPIE,   264

BugContestant_BugCatcherJosh:
	db BUG_CATCHER, JOSH
	dbw SCYTHER,    326
	dbw BUTTERFREE, 292
	dbw METAPOD,    282

BugContestant_SchoolboyJohnny:
	db SCHOOLBOY, JOHNNY
	dbw WEEDLE,     270
	dbw PINSIR,     282
	dbw CATERPIE,   251

BugContestant_SchoolboyKipp:
	db SCHOOLBOY, KIPP
	dbw VENONAT,    267
	dbw PARAS,      254
	dbw KAKUNA,     259
; 13807

BugContest_GetPlayersResult: ; 13807
	ld hl, wBugContestThirdPlacePersonID
	ld de, -4
	ld b, 3
.loop
	ld a, [hl]
	cp 1 ; Player
	ret z
	add hl, de
	dec b
	jr nz, .loop
	ret
; 13819

BugContest_JudgeContestants: ; 13819
	call ClearContestResults
	call ComputeAIContestantScores
	ld hl, wBugContestTempPersonID
	ld a, 1 ; Player
	ld [hli], a
	ld a, [wContestMon]
	ld [hli], a
	ld a, [hProduct]
	ld [hli], a
	ld a, [hProduct + 1]
	ld [hl], a
	jp DetermineContestWinners
; 13833

ClearContestResults: ; 13833
	ld hl, wBugContestResults
	ld b, wBugContestWinnersEnd - wBugContestResults
	xor a
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret
; 1383e

DetermineContestWinners: ; 1383e
	ld de, wBugContestTempScore
	ld hl, wBugContestFirstPlaceScore
	ld c, 2
	call StringCmp
	jr c, .not_first_place
	ld hl, wBugContestSecondPlacePersonID
	ld de, wBugContestThirdPlacePersonID
	ld bc, 4
	call CopyBytes
	ld hl, wBugContestFirstPlacePersonID
	ld de, wBugContestSecondPlacePersonID
	ld bc, 4
	call CopyBytes
	ld hl, wBugContestFirstPlacePersonID
	jr CopyTempContestant

.not_first_place
	ld de, wBugContestTempScore
	ld hl, wBugContestSecondPlaceScore
	ld c, 2
	call StringCmp
	jr c, .not_second_place
	ld hl, wBugContestSecondPlacePersonID
	ld de, wBugContestThirdPlacePersonID
	ld bc, 4
	call CopyBytes
	ld hl, wBugContestSecondPlacePersonID
	jr CopyTempContestant

.not_second_place
	ld de, wBugContestTempScore
	ld hl, wBugContestThirdPlaceScore
	ld c, 2
	call StringCmp
	ret c
	ld hl, wBugContestThirdPlacePersonID
	; fallthrough

CopyTempContestant: ; 138a0
	ld de, wBugContestTempPersonID
	ld bc, 4
	jp CopyBytes
; 138b0

ComputeAIContestantScores: ; 138b0
	ld e, 0
.loop
	push de
	call Special_CheckBugContestContestantFlag
	pop de
	jr nz, .done
	ld a, e
rept 2
	inc a
endr
	ld [wBugContestTempPersonID], a
	dec a
	ld c, a
	ld b, 0
	ld hl, BugContestantPointers
rept 2
	add hl, bc
endr
	ld a, [hli]
	ld h, [hl]
	ld l, a
rept 2
	inc hl
endr
.loop2
	call Random
	and 3
	cp 3
	jr z, .loop2
	ld c, a
	ld b, 0
rept 3
	add hl, bc
endr
	ld a, [hli]
	ld [wBugContestTempMon], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Random
	and 7
	ld c, a
	ld b, 0
	add hl, bc
	ld a, h
	ld [wBugContestTempScore], a
	ld a, l
	ld [wBugContestTempScore + 1], a
	push de
	call DetermineContestWinners
	pop de

.done
	inc e
	ld a, e
	cp 10
	jr nz, .loop
	ret
; 13900

ContestScore: ; 13900
; Determine the player's score in the Bug Catching Contest.

	xor a
	ld [hProduct], a
	ld [hMultiplicand], a

	ld a, [wContestMonSpecies] ; Species
	and a
	ret z

	; Tally the following:

	; Max HP * 4
	ld a, [wContestMonMaxHP + 1]
	call .AddContestStat
	ld a, [wContestMonMaxHP + 1]
	call .AddContestStat
	ld a, [wContestMonMaxHP + 1]
	call .AddContestStat
	ld a, [wContestMonMaxHP + 1]
	call .AddContestStat

	; Stats
	ld a, [wContestMonAttack  + 1]
	call .AddContestStat
	ld a, [wContestMonDefense + 1]
	call .AddContestStat
	ld a, [wContestMonSpeed   + 1]
	call .AddContestStat
	ld a, [wContestMonSpclAtk + 1]
	call .AddContestStat
	ld a, [wContestMonSpclDef + 1]
	call .AddContestStat

	; DVs (6 points per DV that's at least 8)
	lb bc, 0, 6

	ld a, [wContestMonDVs + 0]
	and $f
	cp $8
	jr c, .low_attack
	ld a, b
	add c
	ld b, a
.low_attack

	ld a, [wContestMonDVs + 0]
	swap a
	and $f
	cp $8
	jr c, .low_hp
	ld a, b
	add c
	ld b, a
.low_hp

	ld a, [wContestMonDVs + 1]
	and $f
	cp $8
	jr c, .low_speed
	ld a, b
	add c
	ld b, a
.low_speed

	ld a, [wContestMonDVs + 1]
	swap a
	and $f
	cp $8
	jr c, .low_defense
	ld a, b
	add c
	ld b, a
.low_defense

	ld a, [wContestMonDVs + 2]
	and $f
	cp $8
	jr c, .low_spcl_def
	ld a, b
	add c
	ld b, a
.low_spcl_def

	ld a, [wContestMonDVs + 2]
	swap a
	and $f
	cp $8
	jr c, .low_spcl_atk
	ld a, b
	add c
	ld b, a
.low_spcl_atk

	ld a, b
	call .AddContestStat

	; Remaining HP / 8
	ld a, [wContestMonHP + 1]
	srl a
	srl a
	srl a
	call .AddContestStat

	; Whether it's holding an item
	ld a, [wContestMonItem]
	and a
	ret z

	ld a, 1
	; fallthrough

.AddContestStat: ; 1397f
	ld hl, hMultiplicand
	add [hl]
	ld [hl], a
	ret nc
	dec hl
	inc [hl]
	ret
; 13988
