_SweetHoney:
	farcall CanUseSweetHoney
	jr nc, .no_battle
	farcall GetMapEncounterRate
	ld a, b
	and a
	jr z, .no_battle
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .contest
	farcall ChooseWildEncounter
	jr nz, .no_battle
	ld a, [wPartyMon1Level]
	ld [wCurPartyLevel], a
.battle
	ld a, TRUE
	jr .done
.contest
	; Leave [wCurPartyLevel] alone during the Bug-Catching Contest
	; so the score formula won't get too high
	farcall _ChooseWildEncounter_BugContest
	jr c, .battle
.no_battle
	xor a
	ld [wBattleType], a
.done
	ldh [hScriptVar], a
	ld [wFieldMoveSucceeded], a
	ld hl, SweetHoneyScript
	jmp QueueScript

SweetHoneyScript:
	reloadmappart
	special UpdateTimePals
	writetext UseSweetHoneyText
	waitbutton
	; [hScriptVar] was set by _SweetHoney
	iffalse_jumpopenedtext SweetHoneyNothingText
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugCatchingContest
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

.BugCatchingContest:
	farsjump BugCatchingContestBattleScript

UseSweetHoneyText:
	text_far _UseSweetHoneyText
	text_end

SweetHoneyNothingText:
	text_far _SweetHoneyNothingText
	text_end
