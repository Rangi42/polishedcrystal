
ContestDropOffMons: ; 13a12
	ld hl, PartyMon1HP
	ld a, [hli]
	or [hl]
	jr z, .fainted
; Mask the rest of your party by setting the count to 1...
	ld hl, PartyCount
	ld a, 1
	ld [hli], a
	inc hl
; ... backing up the second mon index somewhere...
	ld a, [hl]
	ld [wBugContestSecondPartySpecies], a
; ... and replacing it with the terminator byte
	ld [hl], $ff
	xor a
	ld [ScriptVar], a
	ret

.fainted
	ld a, $1
	ld [ScriptVar], a
	ret
; 13a31

ContestReturnMons: ; 13a31
; Restore the species of the second mon.
	ld hl, PartySpecies + 1
	ld a, [wBugContestSecondPartySpecies]
	ld [hl], a
; Restore the party count, which must be recomputed.
	ld b, $1
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	inc b
	jr .loop

.done
	ld a, b
	ld [PartyCount], a
	ret
; 13a47

Special_GiveParkBalls: ; 135db
	xor a
	ld [wContestMon], a
	ld a, 20
	ld [wParkBallsRemaining], a
	farjp StartBugContestTimer


BugCatchingContestBattleScript:: ; 0x135eb
	writecode VAR_BATTLETYPE, BATTLETYPE_CONTEST
	randomwildmon
	startbattle
	reloadmapafterbattle
	copybytetovar wParkBallsRemaining
	iffalse .OutOfBalls
	end

.OutOfBalls: ; 0x13603
	playsound SFX_ELEVATOR_END
	opentext
	writetext .ContestIsOver
	waitbutton
	jump BugCatchingContestReturnToGateScript

.ContestIsOver: ; 0x13614
	; ANNOUNCER: The Contest is over!
	text_jump UnknownText_0x1bd2e7
	db "@"

BugCatchingContestOverScript:: ; 0x135f8
	playsound SFX_ELEVATOR_END
	opentext
	writetext .BeeepTimesUp
	waitbutton
	jump BugCatchingContestReturnToGateScript

.BeeepTimesUp: ; 0x1360f
	; ANNOUNCER: BEEEP! Time's up!
	text_jump UnknownText_0x1bd2ca
	db "@"

BugCatchingContestReturnToGateScript: ; 0x1360b
	closetext
	jumpstd bugcontestresultswarp

Script_AbortBugContest: ; 0x122c1
	checkflag ENGINE_BUG_CONTEST_TIMER
	iffalse .finish
	setflag ENGINE_DAILY_BUG_CONTEST
	special ContestReturnMons
.finish
	end


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
	add hl, bc
	add hl, bc
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

INCLUDE "data/events/bug_contest_winners.asm"

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
	ld de, wBugContestFirstPlacePersonID
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
	ld de, wBugContestSecondPlacePersonID
	jr CopyTempContestant

.not_second_place
	ld de, wBugContestTempScore
	ld hl, wBugContestThirdPlaceScore
	ld c, 2
	call StringCmp
	ret c
	ld de, wBugContestThirdPlacePersonID
	; fallthrough

CopyTempContestant: ; 138a0
	ld hl, wBugContestTempPersonID
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
	inc a
	inc a
	ld [wBugContestTempPersonID], a
	dec a
	ld c, a
	ld b, 0
	ld hl, BugContestantPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	inc hl
.loop2
	call Random
	and 3
	cp 3
	jr z, .loop2
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
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

Special_SelectRandomBugContestContestants: ; 139a8
; Select five random people to participate in the current contest.

; First we have to make sure that any old data is cleared away.
	ld c, 10 ; Number of people to choose from.
	ld hl, BugCatchingContestantEventFlagTable
.loop1
	push bc
	push hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, RESET_FLAG
	call EventFlagAction
	pop hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz, .loop1

; Now that that's out of the way, we can get on to the good stuff.
	ld c, 5
.loop2
	push bc
.next
; Choose a flag at uniform random to be set.
	call Random
	cp 250
	jr nc, .next
	ld c, 25
	call SimpleDivide
	ld e, b
	ld d, 0
	ld hl, BugCatchingContestantEventFlagTable
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	push de
; If we've already set it, it doesn't count.
	ld b, CHECK_FLAG
	call EventFlagAction
	pop de
	ld a, c
	and a
	jr nz, .next
; Set the flag.  This will cause that sprite to not be visible in the contest.
	ld b, SET_FLAG
	call EventFlagAction
	pop bc
; Check if we're done.  If so, return.  Otherwise, choose the next victim.
	dec c
	jr nz, .loop2
	ret
; 139ed

Special_CheckBugContestContestantFlag: ; 139ed
; Checks the flag of the Bug Catching Contestant whose index is loaded in a.
; Bug: If a >= 10 when this is called, it will read beyond the table.
	ld hl, BugCatchingContestantEventFlagTable
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, CHECK_FLAG
	jp EventFlagAction
; 139fe

INCLUDE "data/events/bug_contest_flags.asm"
