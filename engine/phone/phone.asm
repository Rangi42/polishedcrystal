AddPhoneNumber::
	call CheckCellNum
	jr c, .cant_add
	call Phone_FindOpenSlot
	jr nc, .cant_add
	ld [hl], c
	xor a
	ret

.cant_add
	scf
	ret

DelCellNum::
	call CheckCellNum
	jr nc, .not_in_list
	xor a
	ld [hl], a
	ret

.not_in_list
	scf
	ret

CheckCellNum::
	ld hl, wPhoneList
	ld b, CONTACT_LIST_SIZE
.loop
	ld a, [hli]
	cp c
	jr z, .got_it
	dec b
	jr nz, .loop
	xor a
	ret

.got_it
	dec hl
	scf
	ret

Phone_FindOpenSlot:
	call GetRemainingSpaceInPhoneList
	ld b, a
	ld hl, wPhoneList
.loop
	ld a, [hli]
	and a
	jr z, .FoundOpenSpace
	dec b
	jr nz, .loop
	xor a
	ret

.FoundOpenSpace:
	dec hl
	scf
	ret

GetRemainingSpaceInPhoneList:
	xor a
	ld [wBuffer1], a
	ld hl, PermanentNumbers
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	cp c
	jr z, .loop
	push bc
	push hl
	ld c, a
	call CheckCellNum
	jr c, .elm_or_mom_in_list
	ld hl, wBuffer1
	inc [hl]

.elm_or_mom_in_list
	pop hl
	pop bc
	jr .loop

.done
	ld a, CONTACT_LIST_SIZE
	ld hl, wBuffer1
	sub [hl]
	ret

INCLUDE "data/phone/permanent_numbers.asm"

CheckPhoneCall::
; Check if the phone is ringing in the overworld.

	ld a, [wPlayerStandingTile]
	cp COLL_DOOR
	jr z, .no_call
	cp COLL_STAIRCASE
	jr z, .no_call
	cp COLL_CAVE
	jr z, .no_call

	call .timecheck
	jr nc, .no_call

	call Random
	ld b, a
	and 50 percent
	cp b
	jr nz, .no_call

	call GetMapPhoneService
	and a
	jr nz, .no_call

	call GetAvailableCallers
	call ChooseRandomCaller
	jr nc, .no_call

	ld e, a
	call LoadCallerScript
	ld a, BANK(Script_ReceivePhoneCall)
	ld hl, Script_ReceivePhoneCall
	call CallScript
	scf
	ret

.no_call
	xor a
	ret

.timecheck
	farjp CheckReceiveCallTimer

CheckPhoneContactTimeOfDay:
	push hl
	push de
	push bc
	push af

	farcall CheckTime
	pop af
	and (1 << MORN) + (1 << DAY) + (1 << NITE) + (1 << EVE)
	and c

	jmp PopBCDEHL

ChooseRandomCaller:
; If no one is available to call, don't return anything.
	ld a, [wNumAvailableCallers]
	and a
	jr z, .NothingToSample

; Sample a random number between 0 and 31.
	ld c, a
	call Random
	ldh a, [hRandomAdd]
	swap a
	and $1f
; Compute that number modulo the number of available callers.
	call SimpleDivide
; Return the caller ID you just sampled.
	ld c, a
	ld b, 0
	ld hl, wAvailableCallers
	add hl, bc
	ld a, [hl]
	scf
	ret

.NothingToSample:
	xor a
	ret

GetAvailableCallers:
	farcall CheckTime
	ld a, c
	ld [wCheckedTime], a
	ld hl, wNumAvailableCallers
	ld bc, 11 ; bug: should be CONTACT_LIST_SIZE + 1 (only clears first 10 contacts)
	xor a
	rst ByteFill
	ld de, wPhoneList
	ld a, CONTACT_LIST_SIZE

.loop
	ld [wPhoneListIndex], a
	ld a, [de]
	and a
	jr z, .not_good_for_call
	ld hl, PhoneContacts + PHONE_CONTACT_SCRIPT2_TIME
	ld bc, PHONE_CONTACT_SIZE
	rst AddNTimes
	ld a, [wCheckedTime]
	and [hl]
	jr z, .not_good_for_call
	ld bc, PHONE_CONTACT_MAP_GROUP - PHONE_CONTACT_SCRIPT2_TIME
	add hl, bc
	ld a, [wMapGroup]
	cp [hl]
	jr nz, .different_map
	inc hl
	ld a, [wMapNumber]
	cp [hl]
	jr z, .not_good_for_call
.different_map
	ld a, [wNumAvailableCallers]
	ld c, a
	ld b, $0
	inc a
	ld [wNumAvailableCallers], a
	ld hl, wAvailableCallers
	add hl, bc
	ld a, [de]
	ld [hl], a
.not_good_for_call
	inc de
	ld a, [wPhoneListIndex]
	dec a
	jr nz, .loop
	ret

CheckSpecialPhoneCall::
	ld a, [wSpecialPhoneCallID]
	and a
	jr z, .NoPhoneCall

	dec a
	ld c, a
	ld b, 0
	ld hl, SpecialPhoneCallList
	ld a, 6
	rst AddNTimes
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _hl_
	jr nc, .NoPhoneCall

	call .DoSpecialPhoneCall
	inc hl
	inc hl
	ld a, [hli]
	ld e, a
	push hl
	call LoadCallerScript
	pop hl
	ld de, wCallerContact + PHONE_CONTACT_SCRIPT2_BANK
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, BANK(.script)
	ld hl, .script
	call CallScript
	scf
	ret
.NoPhoneCall:
	xor a
	ret

.script
	pause 30
	sjump Script_ReceivePhoneCall

.DoSpecialPhoneCall:
	ld a, [wSpecialPhoneCallID]
	dec a
	ld c, a
	ld b, 0
	ld hl, SpecialPhoneCallList
	ld a, 6
	rst AddNTimes
	ret

SpecialCallOnlyWhenOutside:
	ld a, [wEnvironment]
	cp TOWN
	jr z, SpecialCallWhereverYouAre
	cp ROUTE
	jr z, SpecialCallWhereverYouAre
	xor a
	ret

SpecialCallWhereverYouAre:
	scf
	ret

MakePhoneCallFromPokegear:
	; Don't do the call if you're in a link communication
	ld a, [wLinkMode]
	and a
	jr nz, .OutOfArea
	; If you're in an area without phone service, don't do the call
	call GetMapPhoneService
	and a
	jr nz, .OutOfArea
	; If the person can't take a call at that time, don't do the call
	ld a, b
	ld [wCurCaller], a
	ld hl, PhoneContacts
	ld bc, PHONE_CONTACT_SIZE
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, PHONE_CONTACT_SCRIPT1_TIME
	add hl, de
	ld a, [hl]
	call CheckPhoneContactTimeOfDay
	jr z, .OutOfArea
	; If we're in the same map as the person we're calling,
	; use the "Just talk to that person" script.
	ld hl, PHONE_CONTACT_MAP_GROUP
	add hl, de
	ld a, [wMapGroup]
	cp [hl]
	jr nz, .GetPhoneScript
	ld hl, PHONE_CONTACT_MAP_NUMBER
	add hl, de
	ld a, [wMapNumber]
	cp [hl]
	jr nz, .GetPhoneScript
	ld b, BANK(PhoneScript_JustTalkToThem)
	ld hl, PhoneScript_JustTalkToThem
	jr .DoPhoneCall

.GetPhoneScript:
	ld hl, PHONE_CONTACT_SCRIPT1_BANK
	add hl, de
	ld b, [hl]
	ld hl, PHONE_CONTACT_SCRIPT1_ADDR
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr .DoPhoneCall

.OutOfArea:
	ld b, BANK(LoadOutOfAreaScript)
	ld de, LoadOutOfAreaScript
	jmp ExecuteCallbackScript

.DoPhoneCall:
	ld a, b
	ld [wPhoneScriptBank], a
	ld a, l
	ld [wPhoneCaller], a
	ld a, h
	ld [wPhoneCaller+1], a
	ld b, BANK(LoadPhoneScriptBank)
	ld de, LoadPhoneScriptBank
	jmp ExecuteCallbackScript

LoadPhoneScriptBank:
	memcall wPhoneScriptBank
	endcallback

LoadOutOfAreaScript:
	scall PhoneOutOfAreaScript
	endcallback

PhoneOutOfAreaScript:
	farwritetext _PhoneOutOfAreaText
	end

PhoneScript_JustTalkToThem:
	farwritetext _PhoneJustTalkToThemText
	end

Script_ReceivePhoneCall:
	refreshscreen
	callasm RingTwice_StartCall
	memcall wCallerContact + PHONE_CONTACT_SCRIPT2_BANK
	waitbutton
	callasm HangUp
	closetext
	callasm InitCallReceiveDelay
	end

Script_SpecialBillCall::
	callasm .LoadBillScript
	sjump Script_ReceivePhoneCall

.LoadBillScript:
	ld e, PHONE_BILL
	; fallthrough

LoadCallerScript:
	ld a, e
	ld [wCurCaller], a
	and a
	jr nz, .actualcaller
	ld a, BANK(WrongNumber)
	ld hl, WrongNumber
	jr .proceed

.actualcaller
	ld hl, PhoneContacts
	ld bc, 12
	ld a, e
	rst AddNTimes
	ld a, BANK(PhoneContacts)
.proceed
	ld de, wPhoneListIndex
	ld bc, 12
	jmp FarCopyBytes

WrongNumber:
	db TRAINER_NONE, PHONE_00
	dba .script
.script
	farjumptext _PhoneWrongNumberText

RingTwice_StartCall:
	call .Ring
.Ring:
	call Phone_StartRinging
	call Phone_Wait20Frames
	call Phone_CallerTextboxWithName
	call Phone_Wait20Frames
	call Phone_CallerTextbox
	call Phone_Wait20Frames
Phone_CallerTextboxWithName:
	ld a, [wCurCaller]
	ld b, a
Phone_TextboxWithName:
	push bc
	call Phone_CallerTextbox
	hlcoord 1, 1
	ld a, "<PHONE>"
	ld [hli], a
	inc hl
	ld d, h
	ld e, l
	pop bc
GetCallerClassAndName:
	ld h, d
	ld l, e
	ld a, b
	call GetCallerTrainerClass
GetCallerName:
	ld a, c
	and a
	jr z, .NotTrainer

	call Phone_GetTrainerName
	push hl
	push bc
	rst PlaceString
	ld a, ":"
	ld [bc], a
	pop bc
	pop hl
	ld de, SCREEN_WIDTH + 3
	add hl, de
	call Phone_GetTrainerClassName
	rst PlaceString
	ret

.NotTrainer:
	ld a, b
	and a
	jr z, .Blank
	push hl
	ld c, b
	ld b, 0
	ld hl, NonTrainerCallerNames
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	rst PlaceString
	ret

.Blank:
	ld a, "<SHARP>"
	ld [hli], a
	ld a, [wPokegearPhoneScrollPosition]
	ld b, a
	ld a, [wPokegearPhoneLoadNameBuffer]
	add b
	inc a
	ld de, wPokegearNumberBuffer
	ld [de], a
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	call PrintNum
	ld de, .filler
	rst PlaceString
	ret

.filler
	db " -------@"

Phone_NoSignal:
	ld de, SFX_NO_SIGNAL
	call PlaySFX
	jr Phone_CallEnd

HangUp::
	call HangUp_Beep
	call HangUp_Wait20Frames
Phone_CallEnd:
	call HangUp_BoopOn
	call HangUp_Wait20Frames
	call SpeechTextbox
	call HangUp_Wait20Frames
	call HangUp_BoopOn
	call HangUp_Wait20Frames
	call SpeechTextbox
	call HangUp_Wait20Frames
	call HangUp_BoopOn
	call HangUp_Wait20Frames
	call SpeechTextbox
	; fallthrough

HangUp_Wait20Frames:
Phone_Wait20Frames:
	ld c, 20
	call DelayFrames
	jmp ApplyTilemap

HangUp_Beep:
	ld hl, PhoneClickText
	call PrintText
	ld de, SFX_HANG_UP
	jmp PlaySFX

PhoneClickText:
	text_far _PhoneClickText
	text_end

HangUp_BoopOn:
	ld hl, PhoneEllipseText
	jmp PrintText

PhoneEllipseText:
	text_far _PhoneEllipseText
	text_end

Phone_StartRinging:
	call WaitSFX
	ld de, SFX_CALL
	call PlaySFX
	call Phone_CallerTextbox
	call UpdateSprites
	jmp ApplyTilemap

Phone_CallerTextbox:
	hlcoord 0, 0
	lb bc, 2, SCREEN_WIDTH - 2
	jmp Textbox

CheckCanDeletePhoneNumber:
	ld a, c
	call GetCallerTrainerClass
;	ld a, c
;	and a
;	ret nz
	ld a, b
	cp PHONECONTACT_MOM
	ret z
	cp PHONECONTACT_ELM
	ret z
	cp PHONECONTACT_LYRA
	ret z
	ld c, $1
	ret

GetCallerTrainerClass:
	push hl
	ld hl, PhoneContacts + PHONE_CONTACT_TRAINER_CLASS
	ld bc, PHONE_CONTACT_SIZE
	rst AddNTimes
	ld a, [hli]
	ld b, [hl]
	ld c, a
	pop hl
	ret

Phone_GetTrainerName:
	push hl
	push bc
	farcall GetTrainerName
	pop bc
	pop hl
	ret

Phone_GetTrainerClassName:
	push hl
	push bc
	farcall GetTrainerClassName
	pop bc
	pop hl
	ret

GetCallerLocation:
	ld a, [wCurCaller]
	call GetCallerTrainerClass
	ld d, c
	ld e, b
	push de
	ld a, [wCurCaller]
	ld hl, PhoneContacts + PHONE_CONTACT_MAP_GROUP
	ld bc, PHONE_CONTACT_SIZE
	rst AddNTimes
	ld b, [hl]
	inc hl
	ld c, [hl]
	push bc
	call GetWorldMapLocation
	ld e, a
	farcall GetLandmarkName
	pop bc
	pop de
	ret

NonTrainerCallerNames:
	dw EmptyString
	dw .mom
	dw .bikeshop
	dw .bill
	dw .elm
	dw .lyra
	dw .buena

.mom:      db "Mom:@"
.bill:     db "Bill:<LNBRK>   #maniac@"
.elm:      db "Prof.Elm:<LNBRK>   #mon Prof.@"
.bikeshop: db "Miracle Cycle:@"
.lyra:     db "Lyra:<LNBRK>   <PK><MN> Trainer@"
.buena:    db "Buena:<LNBRK>   Disc Jockey@"

INCLUDE "data/phone/phone_contacts.asm"

INCLUDE "data/phone/special_calls.asm"
