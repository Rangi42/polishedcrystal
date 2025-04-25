ContestDropOffMons:
	ld hl, wPartyMon1HP
	ld a, [hli]
	or [hl]
	jr z, .fainted
; Mask the rest of your party by setting the count to 1,
; backing up the party count somewhere
	ld hl, wPartyCount
	ld a, [hl]
	ld [wBugContestBackupPartyCount], a
	xor a
	ldh [hScriptVar], a
	inc a
	ld [hl], a
	ret

.fainted
	ld a, $1
	ldh [hScriptVar], a
	ret

ContestReturnMons:
; Restore the party count from backup.
	ld a, [wBugContestBackupPartyCount]
	ld [wPartyCount], a
	ret

Special_GiveParkBalls:
	xor a
	ld [wContestMon], a
	ld a, BUG_CONTEST_BALLS
	ld [wParkBallsRemaining], a
	jmp StartBugContestTimer

BugCatchingContestBattleScript::
	loadvar VAR_BATTLETYPE, BATTLETYPE_CONTEST
	randomwildmon
	startbattle
	reloadmapafterbattle
	readmem wParkBallsRemaining
	iffalsefwd .OutOfBalls
	end

.OutOfBalls:
	playsound SFX_ELEVATOR_END
	opentext
	farwritetext _BugCatchingContestIsOverText
	waitbutton
	sjumpfwd BugCatchingContestReturnToGateScript

BugCatchingContestOverScript::
	playsound SFX_ELEVATOR_END
	opentext
	farwritetext _BugCatchingContestTimeUpText
	waitbutton

BugCatchingContestReturnToGateScript:
	closetext
	jumpstd bugcontestresultswarp

Script_AbortBugContest:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iffalsefwd .finish
	setflag ENGINE_DAILY_BUG_CONTEST
	special ContestReturnMons
.finish
	end

_BugContestJudging:
	call ContestScore
	call BugContest_JudgeContestants
	ld a, [wBugContestThirdPlacePersonID]
	call LoadContestantName
	ld hl, wNamedObjectIndex
	ld a, [wBugContestThirdPlaceMon]
	ld [hli], a
	ld a, [wBugContestThirdPlaceForm]
	ld [hl], a
	call GetPokemonName
	ld hl, BugContest_ThirdPlaceText
	call PrintText
	ld a, [wBugContestSecondPlacePersonID]
	call LoadContestantName
	ld hl, wNamedObjectIndex
	ld a, [wBugContestSecondPlaceMon]
	ld [hli], a
	ld a, [wBugContestSecondPlaceForm]
	ld [hl], a
	call GetPokemonName
	ld hl, BugContest_SecondPlaceText
	call PrintText
	ld a, [wBugContestFirstPlacePersonID]
	call LoadContestantName
	ld hl, wNamedObjectIndex
	ld a, [wBugContestFirstPlaceMon]
	ld [hli], a
	ld a, [wBugContestFirstPlaceForm]
	ld [hl], a
	call GetPokemonName
	ld hl, BugContest_FirstPlaceText
	call PrintText
	ld hl, wBugContestThirdPlacePersonID
	ld de, -5
	ld b, 3
.loop
	ld a, [hl]
	dec a ; Player = 1
	ret z
	add hl, de
	dec b
	jr nz, .loop
	ret

BugContest_FirstPlaceText:
	text_far ContestJudging_FirstPlaceText
	text_asm
	ld de, SFX_1ST_PLACE
	call PlaySFX
	call WaitSFX
	ld hl, BugContest_FirstPlaceScoreText
	ret

BugContest_FirstPlaceScoreText:
	; The winning score was @  points!
	text_far ContestJudging_FirstPlaceScoreText
	text_end

BugContest_SecondPlaceText:
	; Placing second was @ , who caught a @ !@ @
	text_far ContestJudging_SecondPlaceText
	text_asm
	ld de, SFX_2ND_PLACE
	call PlaySFX
	call WaitSFX
	ld hl, BugContest_SecondPlaceScoreText
	ret

BugContest_SecondPlaceScoreText:
	; The score was @  points!
	text_far ContestJudging_SecondPlaceScoreText
	text_end

BugContest_ThirdPlaceText:
	; Placing third was @ , who caught a @ !@ @
	text_far ContestJudging_ThirdPlaceText
	text_asm
	ld de, SFX_3RD_PLACE
	call PlaySFX
	call WaitSFX
	ld hl, BugContest_ThirdPlaceScoreText
	ret

BugContest_ThirdPlaceScoreText:
	; The score was @  points!
	text_far ContestJudging_ThirdPlaceScoreText
	text_end

LoadContestantName:
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
; Copy the Trainer Class to [wNamedObjectIndex].
	ld a, [hli]
	ld [wNamedObjectIndex], a
; Save hl and bc for later.
	push hl
	push bc
; Get the Trainer Class name and copy it into wBugContestWinnerName.
	call GetTrainerClassName
	ld hl, wStringBuffer1
	ld de, wBugContestWinnerName
	ld bc, TRAINER_CLASS_NAME_LENGTH
	rst CopyBytes
	ld hl, wBugContestWinnerName
; Delete the trailing terminator and replace it with a space.
.next
	ld a, [hli]
	cp "@"
	jr nz, .next
	dec hl
	ld a, " "
	ld [hli], a
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
	ld hl, wStringBuffer1
	pop de
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	ret

.player
	ld hl, wPlayerName
	ld de, wBugContestWinnerName
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret

INCLUDE "data/events/bug_contest_winners.asm"

ClearContestResults:
	ld hl, wBugContestResults
	ld b, wBugContestWinnersEnd - wBugContestResults
	xor a
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

BugContest_JudgeContestants:
	call ClearContestResults
	call ComputeAIContestantScores
	ld hl, wBugContestTempPersonID
	ld a, 1 ; Player
	ld [hli], a
	ld a, [wContestMonSpecies]
	ld [hli], a
	ld a, [wContestMonForm]
	ld [hli], a
	ldh a, [hProduct]
	ld [hli], a
	ldh a, [hProduct + 1]
	ld [hl], a
	; fallthrough

DetermineContestWinners:
	ld de, wBugContestTempScore
	ld hl, wBugContestFirstPlaceScore
	ld c, 2
	call StringCmp
	jr c, .not_first_place
	ld hl, wBugContestSecondPlacePersonID
	ld de, wBugContestThirdPlacePersonID
	ld bc, 4
	rst CopyBytes
	ld hl, wBugContestFirstPlacePersonID
	ld de, wBugContestSecondPlacePersonID
	ld bc, 4
	rst CopyBytes
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
	rst CopyBytes
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

CopyTempContestant:
	ld hl, wBugContestTempPersonID
	ld bc, 5
	rst CopyBytes
	ret

ComputeAIContestantScores:
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
	ld a, 3
	call RandomRange
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [wBugContestTempMon], a
	ld a, [hli]
	ld [wBugContestTempForm], a
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

ContestScore:
; Determine the player's score in the Bug Catching Contest.

	xor a
	ldh [hProduct], a
	ldh [hMultiplicand], a

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
	ld a, [wContestMonSpAtk   + 1]
	call .AddContestStat
	ld a, [wContestMonSpDef   + 1]
	call .AddContestStat

	; DVs (6 points per DV that's at least 8)
	lb bc, 0, 6
	ld a, [wContestMonDVs + 0]
	call .AddDVBonus
	ld a, [wContestMonDVs + 0]
	swap a
	call .AddDVBonus
	ld a, [wContestMonDVs + 1]
	call .AddDVBonus
	ld a, [wContestMonDVs + 1]
	swap a
	call .AddDVBonus
	ld a, [wContestMonDVs + 2]
	call .AddDVBonus
	ld a, [wContestMonDVs + 2]
	swap a
	call .AddDVBonus
	ld a, b
	call .AddContestStat

	; Remaining HP / 8
	ld a, [wContestMonHP + 1]
	rrca
	rrca
	rrca
	and %00011111
	call .AddContestStat

	; Whether it's shiny (150 points)
	ld a, [wContestMonShiny]
	and SHINY_MASK
	jr z, .not_shiny
	ld a, 150
	call .AddContestStat
.not_shiny

	; Whether it's holding an item (1 point)
	ld a, [wContestMonItem]
	and a
	ret z
	ld a, 1
	; fallthrough
.AddContestStat:
	ld hl, hMultiplicand
	add [hl]
	ld [hl], a
	ret nc
	dec hl
	inc [hl]
	ret

.AddDVBonus:
	and %1000
	ret nz
	ld a, b
	add c
	ld b, a
	ret

Special_SelectRandomBugContestContestants:
; Select five random people to participate in the current contest.

; First we have to make sure that any old data is cleared away.
	lb bc, RESET_FLAG, 10 ; Action, Number of people to choose from.
	ld de, EVENT_BUG_CATCHING_CONTESTANT_1A ; First event in the sequence.
.loop1
	push bc
	push de
	call EventFlagAction
	pop de
	inc de
	pop bc
	dec c
	jr nz, .loop1

; Now that that's out of the way, we can get on to the good stuff.
	ld c, 5
.loop2
	push bc
.next
; Choose a flag at uniform random to be set.
	ld a, 10
	call RandomRange
; If we've already set it, it doesn't count.
	call Special_CheckBugContestContestantFlag
	jr nz, .next
; Set the flag.  This will cause that sprite to not be visible in the contest.
	ld b, SET_FLAG
	call EventFlagAction
	pop bc
; Check if we're done.  If so, return.  Otherwise, choose the next victim.
	dec c
	jr nz, .loop2
	ret

Special_CheckBugContestContestantFlag:
; Checks the flag of the Bug Catching Contestant whose index is loaded in a.
; Returns de = EVENT_BUG_CATCHING_CONTESTANT_{d:a}A.
	add LOW(EVENT_BUG_CATCHING_CONTESTANT_1A)
	ld e, a
	adc HIGH(EVENT_BUG_CATCHING_CONTESTANT_1A)
	sub e
	ld d, a
	ld b, CHECK_FLAG
	push de
	call EventFlagAction
	pop de
	ret
