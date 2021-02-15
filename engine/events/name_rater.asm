NameRater:
; Introduce himself
	ld hl, NameRaterIntroText
	call PrintText
	call YesNoBox
	jp c, .cancel
; Select a Pokemon from your party
	ld hl, NameRaterWhichMonText
	call PrintText
	farcall SelectMonFromParty
	jp c, .cancel

	ld a, MON_FORM
	call GetPartyParamLocation
	ld [wCurForm], a
; He can't rename an egg...
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .egg
; ... or a Pokemon you got from a trade.
	call GetCurNick
	ld a, [wInitialOptions]
	bit TRADED_AS_OT_OPT, a
	jr nz, .no_name_lock
	call CheckIfMonIsYourOT
	jr c, .traded
.no_name_lock
; This name is good, but we can do better.  How about it?
	ld hl, NameRaterIsGoodText
	call PrintText
	call YesNoBox
	jr c, .cancel
; What name shall I give it then?
	ld hl, NameRaterWhichNameText
	call PrintText
; Load the new nickname into wStringBuffer2
	xor a ; PARTYMON
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	ld [wd265], a
	ld [wCurSpecies], a
	call GetBaseData
	ld b, $0 ; pokemon
	ld de, wStringBuffer2
	farcall _NamingScreen
; If the new name is empty, treat it as unchanged.
	call IsNewNameEmpty
	ld hl, NameRaterSameAsBeforeText
	jr c, .samename
; If the new name is the same as the old name, treat it as unchanged.
	call CompareNewToOld
	ld hl, NameRaterSameAsBeforeText
	jr c, .samename
; Copy the new name from wStringBuffer2
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld e, l
	ld d, h
	ld hl, wStringBuffer2
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ld hl, NameRaterEvenBetterText

.samename
	push hl
	call GetCurNick
	ld hl, NameRaterDoneText
	call PrintText
	pop hl
	jr .done

.traded
	ld hl, NameRaterTradedText
	jr .done

.cancel
	ld hl, NameRaterCancelText
	jr .done

.egg
	ld hl, NameRaterEggText

.done
	jp PrintText

CheckIfMonIsYourOT:
; Checks to see if the partymon loaded in [wCurPartyMon] has the different OT as you.  Returns carry if not.
	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wPlayerName
	ld c, NAME_LENGTH
	call .loop
	jr c, .nope

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wPlayerID
	ld c, 2 ; number of bytes in which your ID is stored
.loop
	ld a, [de]
	cp [hl]
	jr nz, .nope
	inc hl
	inc de
	dec c
	jr nz, .loop
	and a
	ret

.nope
	scf
	ret

IsNewNameEmpty:
; Checks to see if the nickname loaded in wStringBuffer2 is empty.  If so, return carry.
	ld hl, wStringBuffer2
	ld c, MON_NAME_LENGTH - 1
.loop
	ld a, [hli]
	cp "@"
	jr z, .terminator
	cp " "
	jr nz, .nonspace
	dec c
	jr nz, .loop

.terminator
	scf
	ret

.nonspace
	and a
	ret

CompareNewToOld:
; Compares the nickname in wStringBuffer2 to the previous nickname.  If they are the same, return carry.
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	push hl
	call GetNicknameLength
	ld b, c
	ld hl, wStringBuffer2
	call GetNicknameLength
	pop hl
	ld a, c
	cp b
	jr nz, .different
	ld de, wStringBuffer2
.loop
	ld a, [de]
	cp "@"
	jr z, .terminator
	cp [hl]
	jr nz, .different
	inc hl
	inc de
	jr .loop

.different
	and a
	ret

.terminator
	scf
	ret

GetNicknameLength:
; Gets the length of the name starting at hl and returns it in c.
	ld c, 0
.loop
	ld a, [hli]
	cp "@"
	ret z
	inc c
	ld a, c
	cp MON_NAME_LENGTH - 1
	jr nz, .loop
	ret

NameRaterIntroText:
	; Hello, hello! I'm the NAME RATER.
	; I rate the names of #MON.
	; Would you like me to rate names?
	text_jump _NameRaterHelloText
	text_end

NameRaterWhichMonText:
	; Which #MON's nickname should I rate for you?
	text_jump _NameRaterWhichMonText
	text_end

NameRaterIsGoodText:
	; Hm… @ … That's a fairly decent name.
	; But, how about a slightly better nickname?
	; Want me to give it a better name?
	text_jump _NameRaterBetterNameText
	text_end

NameRaterWhichNameText:
	; All right. What name should we give it, then?
	text_jump _NameRaterWhatNameText
	text_end

NameRaterEvenBetterText:
	; That's a better name than before! Well done!
	text_jump _NameRaterFinishedText
	text_end

NameRaterCancelText:
	; OK, then. Come again sometime.
	text_jump _NameRaterComeAgainText
	text_end

NameRaterTradedText:
	; Hm… @ ? What a great name! It's perfect.
	; Treat @ with loving care.
	text_jump _NameRaterPerfectNameText
	text_end

NameRaterEggText:
	; Whoa… That's just an EGG.
	text_jump _NameRaterEggText
	text_end

NameRaterSameAsBeforeText:
	; It might look the different as before,
	; but this new name is much better! Well done!
	text_jump _NameRaterSameNameText
	text_end

NameRaterDoneText:
	; All right. This #MON is now named @ .
	text_jump _NameRaterNamedText
	text_end
