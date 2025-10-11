PhoneFlagAction:
; Valid contacts start from index 1, but the flag array starts at index 0.
	push bc
	dec c
	ld d, 0
	ld hl, wPhoneList
	predef FlagPredef
	pop bc
	ret

AddPhoneNumber::
; Adds phone number c to the contact list. Returns carry if already present.
	call CheckCellNum
	ret c
	ld b, SET_FLAG
	jr DoAddOrDelPhoneNumber

DelCellNum::
; Deletes phone number c from the contact list. Returns carry if not present.
	call CheckCellNum
	ccf
	ret c
	ld b, RESET_FLAG
	; fallthrough
DoAddOrDelPhoneNumber:
	call PhoneFlagAction
	xor a
	ret

CheckCellNum::
; Returns carry if phone number c is in the contact list.
	ld b, CHECK_FLAG
	call PhoneFlagAction
	scf
	ret nz
	xor a
	ret

CheckPhoneCall::
; Check if the phone is ringing in the overworld.

	ld a, [wPlayerTileCollision]
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
; Returns a random available caller in a. Returns carry if one is found,
; otherwise nc.
	farcall CheckTime
	ld d, c
	xor a
	ld b, a
	ld c, NUM_PHONE_CONTACTS ; also the last phone contact.
	push af
.loop
	call .IsValidCaller
	jr nc, .next
	inc b

	; Check if we should replace our current caller. We should do this if
	; a random number between 0 and b-1 returns 0.
	ld a, b
	call RandomRange
	and a
	jr nz, .next
	pop af
	ld a, c
	scf
	push af

.next
	dec c
	jr nz, .loop
	pop af
	ret

.IsValidCaller:
	; First, check if the number is in our contact list in the first place.
	push bc
	push de
	call CheckCellNum
	pop de
	jr nc, .invalid

	; Check if the trainer is active during this time.
	ld a, c
	ld hl, PhoneContacts + PHONE_CONTACT_SCRIPT2_TIME
	ld bc, PHONE_CONTACT_SIZE
	rst AddNTimes
	ld a, d
	and [hl]
	jr z, .invalid

	; Don't let trainers call us if they're in the same map as us.
	ld bc, PHONE_CONTACT_MAP_GROUP - PHONE_CONTACT_SCRIPT2_TIME
	add hl, bc
	ld a, [wMapGroup]
	cp [hl]
	jr nz, .valid
	inc hl
	ld a, [wMapNumber]
	cp [hl]
.valid
	scf
	jr nz, .done
.invalid
	xor a
.done
	pop bc
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
	sjumpfwd Script_ReceivePhoneCall

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
	reanchormap
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
	ld bc, PHONE_CONTACT_SIZE
	ld a, e
	rst AddNTimes
	ld a, BANK(PhoneContacts)
.proceed
	ld de, wCallerContact
	ld bc, PHONE_CONTACT_SIZE
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
	push bc
	call Phone_CallerTextbox
	hlcoord 1, 1
	ld a, '<PHONE>'
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
	ld a, c
	and a
	jr z, .NotTrainer
	ld [wNamedObjectIndex], a
	push hl
	push bc
	farcall GetTrainerName
	pop bc
	pop hl
	push hl
	push bc
	rst PlaceString
	ld a, ':'
	ld [bc], a
	pop bc
	pop hl
	ld de, SCREEN_WIDTH + 3
	add hl, de
	call GetTrainerClassName
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
	ld de, .filler
	rst PlaceString
	ret

.filler
	db "----------@"

Phone_NoSignal:
	ld de, SFX_NO_SIGNAL
	call PlaySFX
	jr Phone_CallEnd

HangUp::
	ld hl, PhoneClickText
	call PrintText
	ld de, SFX_HANG_UP
	call PlaySFX
	call Phone_Wait20Frames
	; fallthrough
Phone_CallEnd:
	call .BoopWaitTextWait
	call .BoopWaitTextWait
	; fallthrough
.BoopWaitTextWait:
	ld hl, PhoneEllipseText
	call PrintText
	call Phone_Wait20Frames
	call SpeechTextbox
	; fallthrough
Phone_Wait20Frames:
	ld c, 20
	call DelayFrames
	jmp ApplyTilemap

PhoneClickText:
	text_far _PhoneClickText
	text_end

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
	ld a, [hli]
	ld c, [hl]
	ld b, a
	push bc
	call GetWorldMapLocation
	ld e, a
	farcall GetLandmarkName
	pop bc
	pop de
	ret

INCLUDE "data/phone/non_trainer_names.asm"

INCLUDE "data/phone/phone_contacts.asm"

INCLUDE "data/phone/special_calls.asm"
