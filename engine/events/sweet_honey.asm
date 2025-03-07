_SweetHoney:
	farcall CanUseSweetHoney
	jr nc, .no_battle
	farcall GetMapEncounterRate
	ld a, b
	and a
	jr z, .no_battle
	ld hl, wStatusFlags2
	; Items can't be used during the Bug-Catching Contest anyway
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .no_battle

.disallow_roamer_loop
	farcall ChooseWildEncounter
	jr nz, .no_battle
	ld a, [wBattleType]
	cp BATTLETYPE_ROAMING
	jr z, .disallow_roamer_loop

	; This might do useless things due to improperly filled level data.
	; This is harmless, because we only run this to deal with Magnet Pull,
	; Static, etc.
	farcall ApplyAbilityEffectsOnEncounterMon

	; Force the mon to be the same level as the lead, not necessarily the one
	; we send out.
	ld a, [wPartyMon1Level]
	ld [wCurPartyLevel], a
	ld a, TRUE
	jr .done
.no_battle
	xor a
	ld [wBattleType], a
.done
	ldh [hScriptVar], a
	ld [wFieldMoveSucceeded], a
	ld hl, SweetHoneyScript
	jmp QueueScript

SweetHoneyScript:
	refreshmap
	special UpdateTimePals
	writetext UseSweetHoneyText
	waitbutton
	; [hScriptVar] was set by _SweetHoney
	iffalse_jumpopenedtext SweetHoneyNothingText
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftruefwd .BugCatchingContest
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
