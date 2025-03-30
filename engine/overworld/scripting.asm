; Event scripting commands.

EnableScriptMode::
	push af
	ld a, SCRIPT_READ
	ld [wScriptMode], a
	pop af
	ret

ScriptEvents::
	call StartScript
.loop
	ld a, [wScriptMode]
	ld hl, .modes
	call JumpTable
	call CheckScript
	jr nz, .loop
	ret

.modes
	dw StopScript
	dw RunScriptCommand
	dw WaitScriptMovement
	dw WaitScript

WaitScript:
	call StopScript

	ld hl, wScriptDelay
	dec [hl]
	ret nz

	farcall UnfreezeAllObjects

	ld a, SCRIPT_READ
	ld [wScriptMode], a
	jmp StartScript

WaitScriptMovement:
	call StopScript

	ld hl, wStateFlags
	bit SCRIPTED_MOVEMENT_STATE_F, [hl]
	ret nz

	farcall UnfreezeAllObjects

	ld a, SCRIPT_READ
	ld [wScriptMode], a
	jmp StartScript

RunScriptCommand:
	call GetScriptByte
	call StackJumpTable

ScriptCommandTable:
; entries correspond to *_command constants (see macros/scripts/events.asm)
	table_width 2
	dw Script_scall                      ; 00
	dw Script_farscall                   ; 01
	dw Script_memcall                    ; 02
	dw Script_sjump                      ; 03
	dw Script_farsjump                   ; 04
	dw Script_memjump                    ; 05
	dw Script_ifequal                    ; 06
	dw Script_ifnotequal                 ; 07
	dw Script_iffalse                    ; 08
	dw Script_iftrue                     ; 09
	dw Script_ifgreater                  ; 0a
	dw Script_ifless                     ; 0b
	dw Script_jumpstd                    ; 0c
	dw Script_callstd                    ; 0d
	dw Script_callasm                    ; 0e
	dw Script_special                    ; 0f
	dw Script_memcallasm                 ; 10
	dw Script_checkmapscene              ; 11
	dw Script_setmapscene                ; 12
	dw Script_checkscene                 ; 13
	dw Script_setscene                   ; 14
	dw Script_setval                     ; 15
	dw Script_setval16                   ; 16
	dw Script_addval                     ; 17
	dw Script_random                     ; 18
	dw Script_random16                   ; 19
	dw Script_readmem                    ; 1a
	dw Script_readmem16                  ; 1b
	dw Script_writemem                   ; 1c
	dw Script_loadmem                    ; 1d
	dw Script_readvar                    ; 1e
	dw Script_writevar                   ; 1f
	dw Script_loadvar                    ; 20
	dw Script_giveitem                   ; 21
	dw Script_takeitem                   ; 22
	dw Script_checkitem                  ; 23
	dw Script_givemoney                  ; 24
	dw Script_takemoney                  ; 25
	dw Script_checkmoney                 ; 26
	dw Script_givecoins                  ; 27
	dw Script_takecoins                  ; 28
	dw Script_checkcoins                 ; 29
	dw Script_addcellnum                 ; 2a
	dw Script_delcellnum                 ; 2b
	dw Script_checkcellnum               ; 2c
	dw Script_checktime                  ; 2d
	dw Script_checkpoke                  ; 2e
	dw Script_givepoke                   ; 2f
	dw Script_giveegg                    ; 30
	dw Script_givepokemail               ; 31
	dw Script_checkpokemail              ; 32
	dw Script_checkevent                 ; 33
	dw Script_clearevent                 ; 34
	dw Script_setevent                   ; 35
	dw Script_checkflag                  ; 36
	dw Script_clearflag                  ; 37
	dw Script_setflag                    ; 38
	dw Script_wildon                     ; 39
	dw Script_wildoff                    ; 3a
	dw Script_warpmod                    ; 3b
	dw Script_blackoutmod                ; 3c
	dw Script_warp                       ; 3d
	dw Script_getmoney                   ; 3e
	dw Script_getcoins                   ; 3f
	dw Script_getnum                     ; 40
	dw Script_getmonname                 ; 41
	dw Script_getitemname                ; 42
	dw Script_getcurlandmarkname         ; 43
	dw Script_gettrainername             ; 44
	dw Script_getstring                  ; 45
	dw Script_itemnotify                 ; 46
	dw Script_pocketisfull               ; 47
	dw Script_opentext                   ; 48
	dw Script_reanchormap                ; 49
	dw Script_closetext                  ; 4a
	dw Script_farwritetext               ; 4b
	dw Script_writetext                  ; 4c
	dw Script_repeattext                 ; 4d
	dw Script_yesorno                    ; 4e
	dw Script_loadmenu                   ; 4f
	dw Script_closewindow                ; 50
	dw Script_jumptextfaceplayer         ; 51
	dw Script_farjumptext                ; 52
	dw Script_jumptext                   ; 53
	dw Script_waitbutton                 ; 54
	dw Script_promptbutton               ; 55
	dw Script_pokepic                    ; 56
	dw Script_closepokepic               ; 57
	dw Script__2dmenu                    ; 58
	dw Script_verticalmenu               ; 59
	dw Script_randomwildmon              ; 5a
	dw Script_loadtemptrainer            ; 5b
	dw Script_loadwildmon                ; 5c
	dw Script_loadtrainer                ; 5d
	dw Script_startbattle                ; 5e
	dw Script_reloadmapafterbattle       ; 5f
	dw Script_catchtutorial              ; 60
	dw Script_trainertext                ; 61
	dw Script_trainerflagaction          ; 62
	dw Script_winlosstext                ; 63
	dw Script_scripttalkafter            ; 64
	dw Script_endifjustbattled           ; 65
	dw Script_checkjustbattled           ; 66
	dw Script_setlasttalked              ; 67
	dw Script_applymovement              ; 68
	dw Script_applymovementlasttalked    ; 69
	dw Script_faceplayer                 ; 6a
	dw Script_faceobject                 ; 6b
	dw Script_variablesprite             ; 6c
	dw Script_disappear                  ; 6d
	dw Script_appear                     ; 6e
	dw Script_follow                     ; 6f
	dw Script_stopfollow                 ; 70
	dw Script_moveobject                 ; 71
	dw Script_writeobjectxy              ; 72
	dw Script_loademote                  ; 73
	dw Script_showemote                  ; 74
	dw Script_turnobject                 ; 75
	dw Script_follownotexact             ; 76
	dw Script_earthquake                 ; 77
	dw Script_changemapblocks            ; 78
	dw Script_changeblock                ; 79
	dw Script_reloadmap                  ; 7a
	dw Script_refreshmap                 ; 7b
	dw Script_usestonetable              ; 7c
	dw Script_playmusic                  ; 7d
	dw Script_encountermusic             ; 7e
	dw Script_musicfadeout               ; 7f
	dw Script_playmapmusic               ; 80
	dw Script_dontrestartmapmusic        ; 81
	dw Script_cry                        ; 82
	dw Script_playsound                  ; 83
	dw Script_waitsfx                    ; 84
	dw Script_warpsound                  ; 85
	dw Script_specialsound               ; 86
	dw Script_autoinput                  ; 87
	dw Script_newloadmap                 ; 88
	dw Script_pause                      ; 89
	dw Script_deactivatefacing           ; 8a
	dw Script_sdefer                     ; 8b
	dw Script_warpcheck                  ; 8c
	dw Script_stopandsjump               ; 8d
	dw Script_endcallback                ; 8e
	dw Script_end                        ; 8f
	dw Script_reloadend                  ; 90
	dw Script_endall                     ; 91
	dw Script_pokemart                   ; 92
	dw Script_elevator                   ; 93
	dw Script_trade                      ; 94
	dw Script_askforphonenumber          ; 95
	dw Script_hangup                     ; 96
	dw Script_describedecoration         ; 97
	dw Script_fruittree                  ; 98
	dw Script_specialphonecall           ; 99
	dw Script_checkphonecall             ; 9a
	dw Script_verbosegiveitem            ; 9b
	dw Script_verbosegiveitemvar         ; 9c
	dw Script_swarm                      ; 9d
	dw Script_halloffame                 ; 9e
	dw Script_credits                    ; 9f
	dw Script_warpfacing                 ; a0
	dw Script_battletowertext            ; a1
	dw Script_getlandmarkname            ; a2
	dw Script_gettrainerclassname        ; a3
	dw Script_wait                       ; a4
	dw Script_checksave                  ; a5
	dw Script_trainerpic                 ; a6
	dw Script_givetmhm                   ; a7
	dw Script_checktmhm                  ; a8
	dw Script_verbosegivetmhm            ; a9
	dw Script_tmhmnotify                 ; aa
	dw Script_gettmhmname                ; ab
	dw Script_checkdarkness              ; ac
	dw Script_checkunits                 ; ad
	dw Script_unowntypeface              ; ae
	dw Script_restoretypeface            ; af
	dw Script_jumpstashedtext            ; b0
	dw Script_jumpopenedtext             ; b1
	dw Script_iftrue_jumptext            ; b2
	dw Script_iffalse_jumptext           ; b3
	dw Script_iftrue_jumptextfaceplayer  ; b4
	dw Script_iffalse_jumptextfaceplayer ; b5
	dw Script_iftrue_jumpopenedtext      ; b6
	dw Script_iffalse_jumpopenedtext     ; b7
	dw Script_writethistext              ; b8
	dw Script_jumpthistext               ; b9
	dw Script_jumpthistextfaceplayer     ; ba
	dw Script_jumpthisopenedtext         ; bb
	dw Script_showtext                   ; bc
	dw Script_showtextfaceplayer         ; bd
	dw Script_applyonemovement           ; be
	dw Script_showcrytext                ; bf
	dw Script_endtext                    ; c0
	dw Script_waitendtext                ; c1
	dw Script_iftrue_endtext             ; c2
	dw Script_iffalse_endtext            ; c3
	dw Script_loadgrottomon              ; c4
	dw Script_giveapricorn               ; c5
	dw Script_paintingpic                ; c6
	dw Script_checkegg                   ; c7
	dw Script_givekeyitem                ; c8
	dw Script_checkkeyitem               ; c9
	dw Script_takekeyitem                ; ca
	dw Script_verbosegivekeyitem         ; cb
	dw Script_keyitemnotify              ; cc
	dw Script_givebp                     ; cd
	dw Script_takebp                     ; ce
	dw Script_checkbp                    ; cf
	dw Script_sjumpfwd                   ; d0
	dw Script_ifequalfwd                 ; d1
	dw Script_iffalsefwd                 ; d2
	dw Script_iftruefwd                  ; d3
	dw Script_scalltable                 ; d4
	dw Script_setmapobjectmovedata       ; d5
	dw Script_setmapobjectpal            ; d6
	dw Script_givespecialitem            ; d7
	dw Script_givebadge                  ; d8
	dw Script_setquantity                ; d9
	dw Script_pluralize                  ; da
	assert_table_length NUM_EVENT_COMMANDS

GetScriptWordDE::
; Return byte at hScriptBank:hScriptPos in de.
	push hl
	call GetScriptWord
	ld e, l
	ld d, h
	pop hl
	ret

GetScriptWordBC::
; Return byte at hScriptBank:hScriptPos in bc.
	push hl
	call GetScriptWord
	ld b, l
	ld c, h
	pop hl
	ret

StartScript:
	ld hl, wScriptFlags
	set SCRIPT_RUNNING, [hl]
	ret

CheckScript:
	ld hl, wScriptFlags
	bit SCRIPT_RUNNING, [hl]
	ret

StopScript:
	ld hl, wScriptFlags
	res SCRIPT_RUNNING, [hl]
	ret

Script_callasm:
	call GetScriptByte
	ld b, a
	call GetScriptWord
	ld a, b
	jmp FarCall_hl

Script_special:
	call GetScriptByte
	ld e, a
	ld d, 0
	farjp Special

Script_memcallasm:
	call GetScriptWord
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, b
	jmp FarCall_hl

Script_iftrue_jumptextfaceplayer:
	ldh a, [hScriptVar]
	and a
	jr nz, Script_jumptextfaceplayer
	jmp SkipTwoScriptBytes

Script_iffalse_jumptextfaceplayer:
	ldh a, [hScriptVar]
	and a
	jmp nz, SkipTwoScriptBytes
	; fallthrough

Script_jumptextfaceplayer:
	call _GetTextPointer
	jr _Do_textfaceplayer

Script_jumpthistextfaceplayer:
	call _GetThisTextPointer
_Do_textfaceplayer:
	ld b, BANK(JumpTextFacePlayerScript)
	ld hl, JumpTextFacePlayerScript
	jmp ScriptJump

Script_iftrue_jumptext:
	ldh a, [hScriptVar]
	and a
	jr nz, Script_jumptext
	jmp SkipTwoScriptBytes

Script_iffalse_jumptext:
	ldh a, [hScriptVar]
	and a
	jmp nz, SkipTwoScriptBytes
	; fallthrough

Script_jumptext:
	call _GetTextPointer
	jr _Do_jumptext

Script_jumpthistext:
	call _GetThisTextPointer
_Do_jumptext:
	ld b, BANK(JumpTextScript)
	ld hl, JumpTextScript
	jmp ScriptJump

Script_iftrue_jumpopenedtext:
	ldh a, [hScriptVar]
	and a
	jr nz, Script_jumpopenedtext
	jmp SkipTwoScriptBytes

Script_iffalse_jumpopenedtext:
	ldh a, [hScriptVar]
	and a
	jmp nz, SkipTwoScriptBytes
	; fallthrough

Script_jumpopenedtext:
	call _GetTextPointer
	jr _Do_jumpopenedtext

Script_jumpthisopenedtext:
	call _GetThisTextPointer
_Do_jumpopenedtext:
	ld b, BANK(JumpOpenedTextScript)
	ld hl, JumpOpenedTextScript
	jmp ScriptJump

JumpTextFacePlayerScript:
	faceplayer
JumpTextScript:
	opentext
JumpOpenedTextScript:
	repeattext
	waitendtext

_GetTextPointer:
	ldh a, [hScriptBank]
	ld [wScriptTextBank], a
	call GetScriptByte
	ld [wScriptTextAddr], a
	call GetScriptByte
	ld [wScriptTextAddr + 1], a
	ret

_GetThisTextPointer:
	ldh a, [hScriptBank]
	ld [wScriptTextBank], a
	ldh a, [hScriptPos]
	ld [wScriptTextAddr], a
	ldh a, [hScriptPos + 1]
	ld [wScriptTextAddr + 1], a
	ret

Script_farjumptext:
	call GetScriptByte
	ld [wScriptTextBank], a
	call GetScriptByte
	ld [wScriptTextAddr], a
	call GetScriptByte
	ld [wScriptTextAddr + 1], a
	ld b, BANK(JumpTextScript)
	ld hl, JumpTextScript
	jmp ScriptJump

Script_jumpstashedtext:
	ldh a, [hScriptBank]
	ld [wScriptTextBank], a
	ld a, [wStashedTextPointer]
	ld [wScriptTextAddr], a
	ld a, [wStashedTextPointer + 1]
	ld [wScriptTextAddr + 1], a
	ld b, BANK(JumpTextScript)
	ld hl, JumpTextScript
	jmp ScriptJump

Script_writetext:
	call GetScriptWord
	ldh a, [hScriptBank]
	ld b, a
	jmp MapTextbox

Script_farwritetext:
	call GetScriptByte
	ld b, a
	call GetScriptWord
	jmp MapTextbox

Script_writethistext:
	ld hl, hScriptPos
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hScriptBank]
	ld b, a
	call MapTextbox
	ld a, l
	ldh [hScriptPos], a
	ld a, h
	ldh [hScriptPos + 1], a
	ret

Script_repeattext:
	ld hl, wScriptTextBank
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp MapTextbox

Script_promptbutton:
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a
	call ApplyTilemapInVBlank
	call ButtonSound
	pop af
	ldh [hOAMUpdate], a
	ret

Script_yesorno:
	call YesNoBox
	; a = carry (no) ? FALSE : TRUE
	sbc a
	inc a
	ldh [hScriptVar], a
	vc_hook Script_yesorno_ret
	ret

Script_loadmenu:
	call GetScriptWord
	ldh a, [hScriptBank]
	ld de, LoadMenuHeader
	call FarCall_de
	jmp UpdateSprites

Script_closewindow:
	call CloseWindow
	jmp UpdateSprites

Script_pokepic:
	; 1 or 2 parameters: 1 if the first is 0. Otherwise, first param is
	; species, the second ext+form.
	call GetScriptByte
	ld [wCurPartySpecies], a
	call GetCurPartyMonSpeciesIfZero

	; While we actually have species+form stored right now if zero, we need to
	; handle color variation. Thus, notify Pokepic that we want a partymon.
	ld a, -1
	ld [wCurForm], a
	jr z, .pokepic
	call GetScriptByte
	ld [wCurForm], a
.pokepic
	farjp Pokepic

GetCurPartyMonSpeciesIfZero:
	and a
	ret nz
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld c, a
	ld [wCurPartySpecies], a
	ld a, MON_FORM
	call GetPartyParamLocationAndValue
	ld b, a
	ld [wCurForm], a
	xor a
	ret

Script_closepokepic:
	farjp ClosePokepic

Script_verticalmenu:
	ldh a, [hScriptBank]
	ld hl, VerticalMenu
	call FarCall_hl
	ld a, [wMenuCursorY]
	jr nc, .ok
	xor a
.ok
	ldh [hScriptVar], a
	ret

Script__2dmenu:
	ldh a, [hScriptBank]
	ld hl, _2DMenu
	call FarCall_hl
	ld a, [wMenuCursorBuffer]
	jr nc, .ok
	xor a
.ok
	ldh [hScriptVar], a
	ret

Script_battletowertext:
	call SetUpTextbox
	call GetScriptByte
	ld c, a
	farjp BattleTowerText

Script_verbosegiveitem:
	call Script_giveitem
	call GetCurItemName
	ld a, STRING_BUFFER_4
	call CopyConvertedText
	ld b, BANK(GiveItemScript)
	ld de, GiveItemScript
	jmp ScriptCall

GiveItemScript:
	readmem wItemQuantityChangeBuffer
	ifequalfwd 1, .OneItem
	pluralize wStringBuffer4
	farwritetext _GainedMultipleItemsText
	sjumpfwd .FinishGiveItem
.OneItem:
	farwritetext _GainedItemText
	; fallthrough
.FinishGiveItem:
	special ShowItemIcon
	iffalsefwd .Full
	specialsound
	waitbutton
	itemnotify
	end

.Full:
	promptbutton
	pocketisfull
	end

Script_verbosegiveitemvar:
	call GetScriptByte
	cp -1
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wCurItem], a
	call GetScriptByte
	call GetVarAction
	ld a, [de]
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call ReceiveItem
	; a = carry ? TRUE : FALSE
	sbc a
	and TRUE
	ldh [hScriptVar], a
	call GetCurItemName
	ld a, STRING_BUFFER_4
	call CopyConvertedText
	ld b, BANK(GiveItemScript)
	ld de, GiveItemScript
	jmp ScriptCall

Script_itemnotify:
	call GetPocketName
	call GetCurItemName
	ld b, BANK(_PutItemInPocketText)
	ld hl, _PutItemInPocketText
	call MapTextbox
	; The item icon overwrites nine font tiles, including
	; the "▶" needed by the right cursor arrow.
	farjp LoadFonts_NoOAMUpdate

Script_pocketisfull:
	call GetPocketName
	call GetCurItemName
	ld b, BANK(_PocketIsFullText)
	ld hl, _PocketIsFullText
	jmp MapTextbox

Script_specialsound:
	ld de, SFX_ITEM
	call WaitPlaySFX
	jmp WaitSFX

GetPocketName:
	farcall CheckItemPocket
	ld a, [wItemAttributeParamBuffer]
	dec a
	ld hl, ItemPocketNames
	and $7
	ld e, a
	ld d, 0
	add hl, de
	ld e, [hl]
	add hl, de
	ld e, l
	ld d, h
	ld hl, wStringBuffer3
	jmp CopyName2

INCLUDE "data/items/pocket_names.asm"

GetKeyItemPocketName:
	ld hl, KeyPocketName
	jr CopySpecialPocketName

KeyPocketName:
	db "Key Pocket@"

GetTMHMPocketName:
	ld hl, TMHMPocketName
CopySpecialPocketName:
	ld d, h
	ld e, l
	ld hl, wStringBuffer3
	jmp CopyName2

TMHMPocketName:
	db "TM Pocket@"

Script_pokemart:
	call Script_faceplayer
	call Script_opentext
	call GetScriptByte
	ld c, a
	call GetScriptByte
	ld e, a
	ld d, 0
	ldh a, [hScriptBank]
	ld b, a
	farcall OpenMartDialog
	jmp Script_endtext

Script_elevator:
	xor a
	ldh [hScriptVar], a
	call GetScriptWordDE
	ldh a, [hScriptBank]
	ld b, a
	farcall Elevator
	ret c
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_trade:
	call Script_faceplayer
	call Script_opentext
	call GetScriptByte
	ld e, a
	farcall NPCTrade
	jmp Script_waitendtext

Script_hangup:
	farjp HangUp

Script_askforphonenumber:
	call YesNoBox
	jr c, .refused
	call GetScriptByte
	ld c, a
	farcall AddPhoneNumber
	jr c, .phonefull
	xor a
	jr .done
.phonefull
	ld a, 1
	jr .done
.refused
	call GetScriptByte
	ld a, 2
.done
	ldh [hScriptVar], a
	ret

Script_describedecoration:
	call GetScriptByte
	ld b, a
	farcall DescribeDecoration
	ld h, d
	ld l, e
	jmp ScriptJump

Script_fruittree:
	call GetScriptByte
	ld [wCurFruitTree], a
	call GetScriptByte
	ld [wCurFruit], a
	ld b, BANK(FruitTreeScript)
	ld hl, FruitTreeScript
	jmp ScriptJump

Script_swarm:
	call GetScriptByte
	ld c, a
	call GetScriptByte
	ld d, a
	call GetScriptByte
	ld e, a
	farjp StoreSwarmMapIndices

Script_trainertext:
	call GetScriptByte
	ld c, a
	ld b, 0
	ld hl, wSeenTextPointer
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSeenTrainerBank]
	ld b, a
	jmp MapTextbox

Script_scripttalkafter:
	ld hl, wScriptAfterPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSeenTrainerBank]
	ld b, a
	jmp ScriptJump

Script_trainerflagaction:
	xor a
	ldh [hScriptVar], a
	ld hl, wTempTrainerEventFlagLo
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call GetScriptByte
	ld b, a
	call EventFlagAction
	ret z
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_winlosstext:
	ld hl, wWinTextPointer
	call GetScriptByte
	ld [hli], a
	call GetScriptByte
	ld [hli], a
	call GetScriptByte
	ld [hli], a
	call GetScriptByte
	ld [hli], a
	ret

Script_endifjustbattled:
	ld a, [wRunningTrainerBattleScript]
	and a
	ret z
	jmp Script_end

Script_checkjustbattled:
	ld a, TRUE
	ldh [hScriptVar], a
	ld a, [wRunningTrainerBattleScript]
	and a
	ret nz
	xor a
	ldh [hScriptVar], a
	ret

Script_encountermusic:
	ld a, [wOtherTrainerClass]
	ld e, a
	farjp PlayTrainerEncounterMusic

Script_playmusic:
	ld e, MUSIC_NONE
	call PlayMusic
	xor a
	ld [wMusicFade], a
	call MaxVolume
	call GetScriptByte
	ld e, a
	ld d, 0
	jmp PlayMusic

Script_musicfadeout:
	call GetScriptByte
	ld [wMusicFadeID], a
	xor a
	ld [wMusicFadeID + 1], a
	call GetScriptByte
	and $7f
	ld [wMusicFade], a
	ret

Script_playsound:
	call GetScriptByte
	ld e, a
	ld d, 0
	jmp WaitPlaySFX

Script_warpsound:
	ld a, [wPlayerTileCollision]
	ld de, SFX_ENTER_DOOR
	cp COLL_DOOR
	jr z, .play
	ld de, SFX_WARP_TO
	cp COLL_WARP_PANEL
	jr z, .play
	ld de, SFX_EXIT_BUILDING
.play
	jmp PlaySFX

Script_cry:
	; 1 or 2 parameters: 1 if the first is 0. Otherwise, first param is
	; species, the second ext+form.
	call GetScriptByte
	call GetCurPartyMonSpeciesIfZero
	jmp z, PlayMonCry
	ld c, a
	call GetScriptByte
	ld b, a
	jmp PlayMonCry

Script_setlasttalked:
	call GetScriptByte
	ldh [hLastTalked], a
	ret

Script_applyonemovement:
	call GetScriptByte
	ld c, a

	push bc
	ld a, c
	farcall FreezeAllOtherObjects
	pop bc

	push bc
	farcall _UnfreezeFollowerObject
	pop bc

	ld hl, hScriptPos
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call SkipTwoScriptBytes
	ldh a, [hScriptBank]
	ld b, a
	call GetMovementData
	ret c

	ld a, SCRIPT_WAIT_MOVEMENT
	ld [wScriptMode], a
	jmp StopScript

Script_applymovement:
	call GetScriptByte
	ld c, a
	jr ApplyMovement

Script_applymovementlasttalked:
	ldh a, [hLastTalked]
	ld c, a
	; fallthrough

ApplyMovement:
	push bc
	ld a, c
	farcall FreezeAllOtherObjects
	pop bc

	push bc
	farcall _UnfreezeFollowerObject
	pop bc

	call GetScriptWord
	ldh a, [hScriptBank]
	ld b, a
	call GetMovementData
	ret c

	ld a, SCRIPT_WAIT_MOVEMENT
	ld [wScriptMode], a
	jmp StopScript

Script_faceplayer:
	ldh a, [hLastTalked]
	and a
	ret z
	ld d, 0
	ld e, a
	farcall GetRelativeFacing
	ld a, d
	add a
	add a
	ld e, a
	ldh a, [hLastTalked]
	ld d, a
	jr ApplyObjectFacing

Script_faceobject:
	call GetScriptByte
	cp LAST_TALKED
	jr c, .ok
	ldh a, [hLastTalked]
.ok
	ld e, a
	call GetScriptByte
	cp LAST_TALKED
	jr nz, .ok2
	ldh a, [hLastTalked]
.ok2
	ld d, a
	push de
	farcall GetRelativeFacing
	pop bc
	ret c
	ld a, d
	add a
	add a
	ld e, a
	ld d, c
	jr ApplyObjectFacing

Script_turnobject:
	call GetScriptByte
	cp LAST_TALKED
	jr nz, .ok
	ldh a, [hLastTalked]
.ok
	ld d, a
	call GetScriptByte
	add a
	add a
	ld e, a
	; fallthrough

ApplyObjectFacing::
	ld a, d
	push de
	call CheckObjectVisibility
	jr c, .not_visible
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	push bc
	farcall DoesSpriteHaveFacings
	pop bc
	jr c, .not_visible ; STANDING_SPRITE
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit FIXED_FACING_F, [hl]
	jr nz, .not_visible
	pop de
	ld a, e
	call SetSpriteDirection
	ld hl, wStateFlags
	bit TEXT_STATE_F, [hl]
	jr nz, .text_state
	call LoadMapPart
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.loop
	res 7, [hl]
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop
.text_state
	jmp UpdateSprites

.not_visible
	pop de
	scf
	ret

Script_variablesprite:
	call GetScriptByte
	ld e, a
	ld d, $0
	ldh [hUsedSpriteIndex], a
	ld hl, wVariableSprites
	add hl, de
	call GetScriptByte
	ld [hl], a
	farjp ReloadSpriteIndex

Script_appear:
	call GetScriptByte
	call _CopyObjectStruct
	ldh a, [hMapObjectIndexBuffer]
	ld b, 0 ; clear
	; fallthrough

ApplyEventActionAppearDisappear:
	push bc
	call GetMapObject
	ld hl, MAPOBJECT_EVENT_FLAG
	add hl, bc
	pop bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld a, -1
	cp e
	jr nz, .okay
	cp d
	jr nz, .okay
	xor a
	ret
.okay
	jmp EventFlagAction

Script_disappear:
	call GetScriptByte
	cp LAST_TALKED
	jr nz, .ok
	ldh a, [hLastTalked]
.ok
	call DeleteObjectStruct
	ldh a, [hMapObjectIndexBuffer]
	ld b, 1 ; set
	call ApplyEventActionAppearDisappear
	farjp _UpdateSprites

Script_follow:
	call GetScriptWordBC
	farjp StartFollow

Script_stopfollow:
	farjp StopFollow

Script_moveobject:
	call GetScriptByte
	ld b, a
	call GetScriptByte
	add 4
	ld d, a
	call GetScriptByte
	add 4
	ld e, a
	farjp CopyDECoordsToMapObject

Script_writeobjectxy:
	call GetScriptByte
	cp LAST_TALKED
	jr nz, .ok
	ldh a, [hLastTalked]
.ok
	ld b, a
	farjp WritePersonXY

Script_follownotexact:
	call GetScriptWordBC
	farjp FollowNotExact

Script_loademote:
	call GetScriptByte
	cp -1
	jr nz, .not_var_emote
	ldh a, [hScriptVar]
.not_var_emote
	ld c, a
	farjp LoadEmote

Script_showemote:
	call GetScriptByte
	ldh [hScriptVar], a
	call GetScriptByte
	cp LAST_TALKED
	jr z, .ok
	ldh [hLastTalked], a
.ok
	call GetScriptByte
	ld [wScriptDelay], a
	ld b, BANK(ShowEmoteScript)
	ld de, ShowEmoteScript
	jmp ScriptCall

ShowEmoteScript:
	loademote EMOTE_FROM_MEM
	applymovementlasttalked .Show
	pause 0
	applymovementlasttalked .Hide
	end

.Show:
	show_emote
	step_sleep_1
	step_end

.Hide:
	hide_emote
	step_sleep_1
	step_end

Script_earthquake:
	ld hl, EarthquakeMovement
	ld de, wEarthquakeMovementDataBuffer
	ld bc, EarthquakeMovementEnd - EarthquakeMovement
	rst CopyBytes
	call GetScriptByte
	ld [wEarthquakeMovementDataBuffer + 1], a
	and %111111
	add a
	ld [wEarthquakeMovementDataBuffer + 3], a
	ld b, BANK(.script)
	ld de, .script
	jmp ScriptCall

.script
	applymovement PLAYER, wEarthquakeMovementDataBuffer
	end

EarthquakeMovement:
	step_shake 16 ; the 16 gets overwritten with the script byte
	step_sleep 16 ; the 16 gets overwritten with the lower 6 bits of the script byte
	step_end
EarthquakeMovementEnd:

Script_randomwildmon:
	xor a
	ld [wBattleScriptFlags], a
	ret

Script_loadtemptrainer:
	ld a, (1 << 7) | 1
	ld [wBattleScriptFlags], a
	ld a, [wTempTrainerClass]
	ld [wOtherTrainerClass], a
	ld a, [wTempTrainerID]
	ld [wOtherTrainerID], a
	ret

Script_loadwildmon:
	ld a, (1 << 7)
	ld [wBattleScriptFlags], a
	call GetScriptByte
	ld [wTempWildMonSpecies], a
	call GetScriptByte
	ld [wWildMonForm], a
	call GetScriptByte
	ld [wCurPartyLevel], a
	ret

Script_loadtrainer:
	ld a, (1 << 7) | 1
	ld [wBattleScriptFlags], a
	call GetScriptByte
	ld [wOtherTrainerClass], a
	call GetScriptByte
	ld [wOtherTrainerID], a
	ret

Script_startbattle:
	call BufferScreen
	predef StartBattle
	ld a, [wBattleResult]
	and ~BATTLERESULT_BITMASK
	ldh [hScriptVar], a
	ret

Script_catchtutorial:
	call GetScriptByte
	ld [wBattleType], a
	call BufferScreen
	farcall CatchTutorial
	ld a, 1
	ld [wDontPlayMapMusicOnReload], a
	jr Script_reloadmap

Script_reloadmapafterbattle:
	ld hl, wBattleScriptFlags
	ld d, [hl]
	xor a
	ld [hli], a ; wBattleScriptFlags
	ld [hl], a ; wWildMonForm
	ld hl, wWildBattlePanic
	ld [hl], d
	ld a, [wBattleResult]
	and ~BATTLERESULT_BITMASK
	cp LOSE
	jr nz, .notblackedout
	ld b, BANK(Script_BattleWhiteout)
	ld hl, Script_BattleWhiteout
	jmp ScriptJump

.notblackedout
	bit 0, d
	jr z, .was_wild
	farcall MomTriesToBuySomething
	farcall RunPostBattleAbilities
	jr .done

.was_wild
	ld a, [wBattleResult]
	bit 1, a ; set on fleeing
	jr nz, .skip_pickup
	farcall RunPostBattleAbilities
.skip_pickup
	ld a, [wBattleResult]
	bit BATTLERESULT_BOX_FULL_F, a
	jr z, .done
	ld b, BANK(Script_SpecialBillCall)
	ld de, Script_SpecialBillCall
	call LoadMemScript
.done
	; fallthrough

Script_reloadmap:
	xor a
	ld hl, wBattleScriptFlags
	ld [hli], a ; wBattleScriptFlags
	ld [hl], a ; wWildMonForm
	ld a, MAPSETUP_RELOADMAP
	ldh [hMapEntryMethod], a
	ld a, 1
	ld [wMapStatus], a
	jmp StopScript

Script_scall:
	ldh a, [hScriptBank]
	ld b, a
	call GetScriptWordDE
	jr ScriptCall

Script_farscall:
	call GetScriptByte
	ld b, a
	call GetScriptWordDE
	jr ScriptCall

Script_memcall:
	call GetScriptWord
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld e, a
	ld d, [hl]
	; fallthrough

ScriptCall:
; Bug: The script stack has a capacity of 5 scripts, yet there is
; nothing to stop you from pushing a sixth script.  The high part
; of the script address can then be overwritten by modifications
; to wScriptDelay, causing the script to return to the rst/interrupt
; space.

	push de
	ld hl, wScriptStackSize
	ld e, [hl]
	inc [hl]
	ld d, $0
	ld hl, wScriptStack
	add hl, de
	add hl, de
	add hl, de
	pop de
	ldh a, [hScriptBank]
	ld [hli], a
	ldh a, [hScriptPos]
	ld [hli], a
	ldh a, [hScriptPos + 1]
	ld [hl], a
	ld a, b
	ldh [hScriptBank], a
	ld a, e
	ldh [hScriptPos], a
	ld a, d
	ldh [hScriptPos + 1], a
	ret

CallCallback::
	ldh a, [hScriptBank]
	or $80
	ldh [hScriptBank], a
	jr ScriptCall

Script_scalltable:
	call GetScriptWord
	ldh a, [hScriptVar]
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ldh a, [hScriptBank]
	ld b, a
	call GetFarByte
	ld e, a
	inc hl
	ldh a, [hScriptBank]
	call GetFarByte
	ld d, a
	jr ScriptCall

Script_sjump:
	call GetScriptWord
	jmp ScriptJumpInCurrentBank

Script_farsjump:
	call GetScriptByte
	ld b, a
	call GetScriptWord
	jmp ScriptJump

Script_memjump:
	call GetScriptWord
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr ScriptJump

Script_iffalse:
	ldh a, [hScriptVar]
	and a
	jr z, Script_sjump
	jr SkipTwoScriptBytes

Script_iftrue:
	ldh a, [hScriptVar]
	and a
	jr nz, Script_sjump
	jr SkipTwoScriptBytes

Script_ifequal:
	call GetScriptByte
	ld hl, hScriptVar
	cp [hl]
	jr z, Script_sjump
	jr SkipTwoScriptBytes

Script_ifnotequal:
	call GetScriptByte
	ld hl, hScriptVar
	cp [hl]
	jr nz, Script_sjump
	jr SkipTwoScriptBytes

Script_ifgreater:
	ldh a, [hScriptVar]
	ld b, a
	call GetScriptByte
	cp b
	jr c, Script_sjump
	jr SkipTwoScriptBytes

Script_ifless:
	call GetScriptByte
	ld b, a
	ldh a, [hScriptVar]
	cp b
	jr c, Script_sjump
	; fallthrough

SkipTwoScriptBytes:
	push hl
	call GetScriptWord
	pop hl
	ret

Script_iffalsefwd:
	ldh a, [hScriptVar]
	and a
	jr z, Script_sjumpfwd
	jmp GetScriptByte

Script_iftruefwd:
	ldh a, [hScriptVar]
	and a
	jr nz, Script_sjumpfwd
	jmp GetScriptByte

Script_ifequalfwd:
	call GetScriptByte
	ld hl, hScriptVar
	cp [hl]
	jr z, Script_sjumpfwd
	jmp GetScriptByte

Script_jumpstd:
	call StdScript
	jr ScriptJump

Script_callstd:
	call StdScript
	ld d, h
	ld e, l
	jmp ScriptCall

StdScript:
	call GetScriptByte
	ld e, a
	ld d, 0
	ld hl, StdScripts
	add hl, de
	add hl, de
	ld b, BANK(StdScripts)
	ld a, b
	jmp GetFarWord

ScriptJump:
	ld a, b
	ldh [hScriptBank], a
ScriptJumpInCurrentBank:
	ld a, l
	ldh [hScriptPos], a
	ld a, h
	ldh [hScriptPos + 1], a
	ret

Script_sjumpfwd:
	ld hl, hScriptPos
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	call GetScriptByte
	ld b, 0
	ld c, a
	add hl, bc
	jr ScriptJumpInCurrentBank

Script_sdefer:
	ldh a, [hScriptBank]
	ld [wDeferredScriptBank], a
	call GetScriptByte
	ld [wDeferredScriptAddr], a
	call GetScriptByte
	ld [wDeferredScriptAddr + 1], a
	ld hl, wScriptFlags
	set 3, [hl]
	ret

Script_checkscene:
	call CheckScenes
	jr z, _NoTriggers
	ldh [hScriptVar], a
	ret

Script_checkmapscene:
	call GetScriptWordBC
	call GetMapSceneID
	ld a, d
	or e
	jr z, _NoTriggers
	ld a, [de]
	ldh [hScriptVar], a
	ret

_NoTriggers:
	ld a, $ff
	ldh [hScriptVar], a
	ret

Script_setscene:
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	jr DoTrigger

Script_setmapscene:
	call GetScriptWordBC
DoTrigger:
	call GetMapSceneID
	ld a, d
	or e
	ret z
	call GetScriptByte
	ld [de], a
	ret

Script_readmem:
	call GetScriptWord
	ld a, [hl]
	ldh [hScriptVar], a
	ret

Script_readmem16:
	call Script_readmem
	call GetScriptWord
	ld a, [hl]
	ldh [hScriptVar+1], a
	ret

Script_writemem:
	call GetScriptWord
	ldh a, [hScriptVar]
	ld [hl], a
	ret

Script_loadmem:
	call GetScriptWord
	call GetScriptByte
	ld [hl], a
	ret

Script_setval:
	call GetScriptByte
	ldh [hScriptVar], a
	ret

Script_setval16:
	call Script_setval
	call GetScriptByte
	ldh [hScriptVar+1], a
	ret

Script_addval:
	call GetScriptByte
	ld hl, hScriptVar
	add [hl]
	ld [hl], a
	ret

Script_random:
	call GetScriptByte
	ldh [hScriptVar], a
	and a
	ret z
	call RandomRange
	ldh [hScriptVar], a
	ret

Script_random16:
	call GetScriptByte
	ldh [hScriptVar+1], a
	ld c, a
	call GetScriptByte
	ldh [hScriptVar], a
	ld b, a
	or c
	ret z
	call RandomRange16
	ld b, a
	ldh [hScriptVar], a
	ld c, a
	ldh [hScriptVar+1], a
	ret

Script_readvar:
	call GetScriptByte
	call GetVarAction
	ld a, [de]
	ldh [hScriptVar], a
	ret

Script_writevar:
	call GetScriptByte
	call GetVarAction
	ldh a, [hScriptVar]
	ld [de], a
	ret

Script_loadvar:
	call GetScriptByte
	call GetVarAction
	call GetScriptByte
	ld [de], a
	ret

GetVarAction:
	ld c, a
	farjp _GetVarAction

Script_getmonname:
	call GetScriptWordDE
	ld a, e
	and a
	jr nz, .gotit
	ldh a, [hScriptVar]
	ld d, a
	ldh a, [hScriptVar+1]
.gotit
	ld hl, wNamedObjectIndex
	ld [hli], a
	ld [hl], d
	call GetPokemonName

ConvertMemToText:
	call GetScriptByte
	cp 3
	jr c, .ok
	xor a
.ok

CopyConvertedText:
	ld hl, wStringBuffer3
	ld bc, wStringBuffer4 - wStringBuffer3
	rst AddNTimes
	jmp CopyName2

Script_getitemname:
	call GetScriptByte
	and a
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wNamedObjectIndex], a
	call GetItemName
	jr ConvertMemToText

Script_getcurlandmarkname:
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	; fallthrough

ConvertLandmarkToText:
	ld e, a
	call GetLandmarkName
	ld de, wStringBuffer1
	jr ConvertMemToText

Script_getlandmarkname:
	call GetScriptByte
	jr ConvertLandmarkToText

Script_gettrainername:
	call GetScriptByte
	ld c, a
	call GetScriptByte
	ld b, a
	farcall GetTrainerName
	jr ConvertMemToText

Script_gettrainerclassname:
	call GetScriptByte
	ld [wNamedObjectIndex], a
	call GetTrainerClassName
	jr ConvertMemToText

Script_getmoney:
	call ResetStringBuffer1
	call GetMoneyAccount
	ld hl, wStringBuffer1
	lb bc, PRINTNUM_LEFTALIGN | 3, 6
	call PrintNum
	ld de, wStringBuffer1
	jr ConvertMemToText

Script_getcoins:
	call ResetStringBuffer1
	ld hl, wStringBuffer1
	ld de, wCoins
	lb bc, PRINTNUM_LEFTALIGN | 2, 6
	call PrintNum
	ld de, wStringBuffer1
	jr ConvertMemToText

Script_getnum:
	call ResetStringBuffer1
	ld hl, wStringBuffer1
	ld de, hScriptVar
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
	call PrintNum
	ld de, wStringBuffer1
	jmp ConvertMemToText

ResetStringBuffer1:
	ld hl, wStringBuffer1
	ld bc, NAME_LENGTH
	ld a, "@"
	rst ByteFill
	ret

Script_getstring:
	call GetScriptWordDE
	ldh a, [hScriptBank]
	ld hl, CopyName1
	call FarCall_hl
	ld de, wStringBuffer2
	jmp ConvertMemToText

Script_givepokemail:
	call GetScriptWord
	ldh a, [hScriptBank]
	call GetFarByte
	ld b, a
	push bc
	inc hl
	ld bc, MAIL_MSG_LENGTH
	ld de, wMonMailMessageBuffer
	ldh a, [hScriptBank]
	call FarCopyBytes
	pop bc
	farjp GivePokeItem

Script_checkpokemail:
	call GetScriptWordDE
	ldh a, [hScriptBank]
	ld b, a
	farjp CheckPokeItem

Script_giveitem:
	call GetScriptByte
	cp ITEM_FROM_MEM
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wCurItem], a
	call GetScriptByte
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call ReceiveItem
	jr _ItemResult

Script_takeitem:
	call GetScriptByte
	cp ITEM_FROM_MEM
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wCurItem], a
	call GetScriptByte
	ld [wItemQuantityChangeBuffer], a
	ld a, -1
	ld [wCurItemQuantity], a
	ld hl, wNumItems
	call TossItem
	jr _ItemResult

Script_checkitem:
	xor a
	ldh [hScriptVar], a
	call GetScriptByte
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
_ItemResult:
	; a = carry ? TRUE : FALSE
	sbc a
	and TRUE
	ldh [hScriptVar], a
	ret

Script_givemoney:
	call GetMoneyAccount
	call LoadMoneyAmountToMem
	farjp GiveMoney

Script_takemoney:
	call GetMoneyAccount
	call LoadMoneyAmountToMem
	farjp TakeMoney

Script_checkmoney:
	call GetMoneyAccount
	call LoadMoneyAmountToMem
	farcall CompareMoney
	; fallthrough

CompareMoneyAction:
	jr c, .two
	jr z, .one
	xor a ; ld a, HAVE_MORE
	jr .done
.one
	ld a, HAVE_AMOUNT
	jr .done
.two
	ld a, HAVE_LESS
.done
	ldh [hScriptVar], a
	ret

GetMoneyAccount:
	call GetScriptByte
	and a
	ld de, wMoney
	ret z
	ld de, wMomsMoney
	ret

LoadMoneyAmountToMem:
	ld bc, hMoneyTemp
	push bc
	call GetScriptByte
	ld [bc], a
	inc bc
	call GetScriptByte
	ld [bc], a
	inc bc
	call GetScriptByte
	ld [bc], a
	pop bc
	ret

Script_givecoins:
	call LoadCoinAmountToMem
	farjp GiveCoins

Script_takecoins:
	call LoadCoinAmountToMem
	farjp TakeCoins

Script_checkcoins:
	call LoadCoinAmountToMem
	farcall CheckCoins
	jr CompareMoneyAction

Script_givebp:
	call LoadCoinAmountToMem
	farjp GiveBP

Script_takebp:
	call LoadCoinAmountToMem
	farjp TakeBP

Script_checkbp:
	call LoadCoinAmountToMem
	farcall CheckBP
	jr CompareMoneyAction

LoadCoinAmountToMem:
	call GetScriptByte
	ldh [hMoneyTemp + 1], a
	call GetScriptByte
	ldh [hMoneyTemp], a
	ld bc, hMoneyTemp
	ret

Script_checktime:
	xor a
	ldh [hScriptVar], a
	farcall CheckTime
	call GetScriptByte
	and c
	ret z
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_checkpoke:
	xor a
	ldh [hScriptVar], a
	call GetScriptByte
	ld c, a
	call GetScriptByte
	ld b, a
	farcall FindThatSpecies
	ret z
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_checkegg:
	xor a
	ldh [hScriptVar], a
	ld a, [wCurPartyMon]
	push af
	ld a, [wPartyCount]
.loop
	dec a
	push af
	ld [wCurPartyMon], a
	ld a, MON_FORM
	call GetPartyParamLocationAndValue
	bit MON_IS_EGG_F, a
	jr z, .next
	ld a, TRUE
	ldh [hScriptVar], a
.next
	pop af
	jr nz, .loop
	pop af
	ld [wCurPartyMon], a
	ret

Script_addcellnum:
	xor a
	ldh [hScriptVar], a
	call GetScriptByte
	ld c, a
	farcall AddPhoneNumber
	ret nc
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_delcellnum:
	xor a
	ldh [hScriptVar], a
	call GetScriptByte
	ld c, a
	farcall DelCellNum
	ret nc
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_checkcellnum:
; returns false if the cell number is not in your phone
	xor a
	ldh [hScriptVar], a
	call GetScriptByte
	ld c, a
	farcall CheckCellNum
	ret nc
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_specialphonecall:
	call GetScriptByte
	ld [wSpecialPhoneCallID], a
	xor a
	ld [wSpecialPhoneCallID + 1], a
	ret

Script_checkphonecall:
; returns false if no special phone call is stored

	ld a, [wSpecialPhoneCallID]
	and a
	jr z, .ok
	ld a, TRUE
.ok
	ldh [hScriptVar], a
	ret

Script_givepoke:
; return 0 in hScriptVar if no room in party or box
; return 1 if sent to party, return 2 if sent to box
	call GetScriptByte
	ld [wCurPartySpecies], a
	call GetScriptByte
	ld [wCurForm], a
	call GetScriptByte
	ld [wCurPartyLevel], a
	call GetScriptByte
	ld [wCurItem], a
	call GetScriptByte
	ld [wGiftMonBall], a
	call GetScriptByte
	ld [wCurPlayerMove], a
	call GetScriptByte
	and a
	ld b, a
	jr z, .ok
	ld hl, hScriptPos
	ld a, [hli]
	ld d, [hl]
	ld e, a
rept 6
	call GetScriptByte
endr
.ok
	farcall GivePoke
	ld a, b
	ldh [hScriptVar], a
	ret

Script_giveegg:
; return 0 in hScriptVar if no room in party or box
; return 1 if sent to party, return 2 if sent to box
	call GetScriptByte
	ld [wCurPartySpecies], a
	call GetScriptByte
	ld [wCurForm], a
	xor a
	ld [wCurItem], a
	ld [wCurPlayerMove], a
	ld b, a
	inc a
	assert EGG_LEVEL == 1
	ld [wCurPartyLevel], a
	assert POKE_BALL == 1
	ld [wGiftMonBall], a

	farcall GivePoke
	ld a, b
	ldh [hScriptVar], a
	ret

Script_setevent:
	call GetScriptWordDE
	ld b, SET_FLAG
	jmp EventFlagAction

Script_clearevent:
	call GetScriptWordDE
	ld b, RESET_FLAG
	jmp EventFlagAction

Script_checkevent:
	call GetScriptWordDE
	ld b, CHECK_FLAG
	call EventFlagAction
	jr z, .false
	ld a, TRUE
.false
	ldh [hScriptVar], a
	ret

Script_setflag:
	call GetScriptWordDE
	ld b, SET_FLAG
	jr _EngineFlagAction

Script_clearflag:
	call GetScriptWordDE
	ld b, RESET_FLAG
_EngineFlagAction:
	farjp EngineFlagAction

Script_checkflag:
	call GetScriptWordDE
	ld b, 2 ; check
	call _EngineFlagAction
	ld a, c
	and a
	jr z, .false
	ld a, TRUE
.false
	ldh [hScriptVar], a
	ret

Script_wildoff:
	ld hl, wStatusFlags
	set 5, [hl] ; wild encounters on/off
	ret

Script_wildon:
	ld hl, wStatusFlags
	res 5, [hl] ; wild encounters on/off
	ret

Script_warpfacing:
	call GetScriptByte
	and $3
	ld c, a
	ld a, [wPlayerSpriteSetupFlags]
	set 5, a
	or c
	ld [wPlayerSpriteSetupFlags], a
; fall through

Script_warp:
; This seems to be some sort of error handling case.
	call GetScriptByte
	and a
	jr z, .not_ok
	ld [wMapGroup], a
	call GetScriptByte
	ld [wMapNumber], a
	call GetScriptByte
	ld [wXCoord], a
	call GetScriptByte
	ld [wYCoord], a
	ld a, -1
	ld [wDefaultSpawnpoint], a
	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	ld a, 1
	ld [wMapStatus], a
	jmp StopScript

.not_ok
	call GetScriptByte
	call GetScriptByte
	call GetScriptByte
	ld a, -1
	ld [wDefaultSpawnpoint], a
	ld a, MAPSETUP_BADWARP
	ldh [hMapEntryMethod], a
	ld a, 1
	ld [wMapStatus], a
	jmp StopScript

Script_warpmod:
	call GetScriptByte
	ld [wBackupWarpNumber], a
	call GetScriptByte
	ld [wBackupMapGroup], a
	call GetScriptByte
	ld [wBackupMapNumber], a
	ret

Script_blackoutmod:
	call GetScriptByte
	ld [wLastSpawnMapGroup], a
	call GetScriptByte
	ld [wLastSpawnMapNumber], a
	ret

Script_dontrestartmapmusic:
	ld a, 1
	ld [wDontPlayMapMusicOnReload], a
	ret

Script_usestonetable:
	call GetScriptByte
	ld [wStoneTableAddress], a
	call GetScriptByte
	ld [wStoneTableAddress+1], a
	ret

Script_changemapblocks:
	call GetScriptByte
	ld [wMapBlocksBank], a
	call GetScriptByte
	ld [wMapBlocksPointer], a
	call GetScriptByte
	ld [wMapBlocksPointer + 1], a
	call ChangeMap
	jmp BufferScreen

Script_changeblock:
	call GetScriptByte
	add 4
	ld d, a
	call GetScriptByte
	add 4
	ld e, a
	call GetBlockLocation
	call GetScriptByte
	ld [hl], a
	jmp BufferScreen

Script_refreshmap::
	xor a
	ldh [hBGMapMode], a
	call LoadMapPart
	call GetMovementPermissions
	farcall ReloadMapPart
	jmp UpdateSprites

Script_warpcheck:
	call WarpCheck
	ret nc
	jmp EnableEvents

Script_newloadmap:
	call GetScriptByte
	ldh [hMapEntryMethod], a
	ld a, 1
	ld [wMapStatus], a
	jmp StopScript

Script_reloadend:
	call Script_newloadmap
	jr Script_end

Script_showtextfaceplayer:
	call Script_faceplayer
	; fallthrough

Script_showtext:
	call Script_opentext
	call Script_writetext
	call Script_waitbutton
	; fallthrough

Script_closetext:
	call BGMapAnchorTopLeft
	jmp CloseText

Script_autoinput:
	call GetScriptByte
	push af
	call GetScriptWord
	pop af
	jmp StartAutoInput

Script_pause:
	call GetScriptByte
	and a
	jr z, .loop
	ld [wScriptDelay], a
.loop
rept 2
	farcall DoOverworldWeather
	call DelayFrame
endr
	ld hl, wScriptDelay
	dec [hl]
	jr nz, .loop
	ret

Script_deactivatefacing:
	call GetScriptByte
	and a
	jr z, .no_time
	ld [wScriptDelay], a
.no_time
	ld a, SCRIPT_WAIT
	ld [wScriptMode], a
	jmp StopScript

Script_stopandsjump:
	call StopScript
	jmp Script_sjump

Script_end:
	call ExitScriptSubroutine
	ret nc
	xor a
	ld [wScriptRunning], a
	ld a, SCRIPT_OFF
	ld [wScriptMode], a
	ld hl, wScriptFlags
	res 0, [hl]
	jmp StopScript

Script_endcallback:
	call ExitScriptSubroutine
	ld hl, wScriptFlags
	res 0, [hl]
	jmp StopScript

ExitScriptSubroutine:
; Return carry if there's no parent to return to.

	ld hl, wScriptStackSize
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ld e, [hl]
	ld d, $0
	ld hl, wScriptStack
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld b, a
	and " "
	ldh [hScriptBank], a
	ld a, [hli]
	ld e, a
	ldh [hScriptPos], a
	ld a, [hl]
	ld d, a
	ldh [hScriptPos + 1], a
	and a
	ret
.done
	scf
	ret

Script_endall:
	xor a
	ld [wScriptStackSize], a
	ld [wScriptRunning], a
	ld a, SCRIPT_OFF
	ld [wScriptMode], a
	ld hl, wScriptFlags
	res 0, [hl]
	jmp StopScript

Script_halloffame:
	xor a ; FALSE
	ld [wGameTimerPaused], a
	farcall HallOfFame
	ld a, TRUE
	ld [wGameTimerPaused], a
	jr ReturnFromCredits

Script_credits:
	farcall LeafCredits
ReturnFromCredits:
	call Script_endall
	ld a, 3
	ld [wMapStatus], a
	jmp StopScript

Script_wait:
	push bc
	call GetScriptByte
.loop
	push af
	ld c, 6
	call DelayFrames
	pop af
	dec a
	jr nz, .loop
	pop bc
	ret

Script_checksave:
	farcall CheckSave
	ld a, c
	ldh [hScriptVar], a
	ret

Script_trainerpic:
	call GetScriptByte
	and a
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wTrainerClass], a
	farjp Trainerpic

Script_givetmhm:
	call GetScriptByte
	ld [wCurTMHM], a
	call ReceiveTMHM
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_checktmhm:
	xor a
	ldh [hScriptVar], a
	call GetScriptByte
	ld [wCurTMHM], a
	call CheckTMHM
	ret nc
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_verbosegivetmhm:
	call Script_givetmhm
	call GetCurTMHMName
	ld de, wStringBuffer1
	ld a, STRING_BUFFER_4
	call CopyConvertedText
	; off by one error?
	ld hl, wTempTMHM
	inc [hl]
	predef GetTMHMMove
	ld b, BANK(GiveTMHMScript)
	ld de, GiveTMHMScript
	jmp ScriptCall

GiveTMHMScript:
	farwritetext _GainedItemText
	special ShowTMHMIcon
	playsound SFX_GET_TM
	waitsfx
	waitbutton
	tmhmnotify
	end

Script_tmhmnotify:
	call GetTMHMPocketName
	call GetCurTMHMName
	ld b, BANK(_PutItemInPocketText)
	ld hl, _PutItemInPocketText
	call MapTextbox
	; The tm/hm icon overwrites nine font tiles, including
	; the "▶" needed by the right cursor arrow.
	farjp LoadFonts_NoOAMUpdate

Script_gettmhmname:
	call GetScriptByte
	and a
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wNamedObjectIndex], a
	call GetTMHMName
	ld de, wStringBuffer1
	call ConvertMemToText

	; off by one error?
	ld a, [wNamedObjectIndex]
	inc a
	ld [wTempTMHM], a

	predef GetTMHMMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	call GetMoveName

	ld hl, wStringBuffer3 + 4 ; assume all TM names are 4 characters, "TM##"
	ld a, " "
	ld [hli], a
	jmp CopyName2

Script_checkdarkness:
	xor a
	ldh [hScriptVar], a
	push hl
	ld hl, wStatusFlags
	bit 2, [hl] ; Flash
	pop hl
	ret nz
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_checkunits:
	ld a, [wOptions2]
	bit POKEDEX_UNITS, a
	ldh [hScriptVar], a
	ret

Script_unowntypeface:
	ld a, [wOptions2]
	ld [wOptionsBuffer], a
	and ~FONT_MASK
	or UNOWN_FONT
	ld [wOptions2], a
	jmp LoadStandardFont

Script_restoretypeface:
	ld a, [wOptionsBuffer]
	ld [wOptions2], a
	xor a
	ld [wOptionsBuffer], a
	jmp LoadStandardFont

Script_iftrue_endtext:
	ldh a, [hScriptVar]
	and a
	ret z
	jr Script_endtext

Script_iffalse_endtext:
	ldh a, [hScriptVar]
	and a
	ret nz
	jr Script_endtext

Script_waitendtext:
	call Script_waitbutton
Script_endtext:
	call Script_closetext
	jmp Script_end

Script_showcrytext:
	call Script_opentext
	call Script_writetext
	call Script_cry
	call Script_waitbutton
	jmp Script_closetext

Script_loadgrottomon:
	farcall GetHiddenGrottoContents
	ld a, c
	ld [wTempWildMonSpecies], a
	ld a, b
	ld [wWildMonForm], a
	ld [wCurForm], a
	call PlayMonCry
	ld a, (1 << 7)
	ld [wBattleScriptFlags], a
	farcall SetBadgeBaseLevel
	farcall GetCurHiddenGrottoLevel
	farcall AdjustLevelForBadges
	ld [wCurPartyLevel], a
	ret

Script_giveapricorn:
	call GetScriptByte
	cp ITEM_FROM_MEM
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wCurItem], a
	call GetScriptByte
	ld [wItemQuantityChangeBuffer], a

	ld hl, wApricorns
	ld a, [wCurItem]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wItemQuantityChangeBuffer]
	add [hl]
	cp 100
	jr nc, .full
	ld [hl], a
	ld a, TRUE
	ldh [hScriptVar], a
	ret

.full
	xor a
	ldh [hScriptVar], a
	ret

Script_paintingpic:
	call GetScriptByte
	ld [wTrainerClass], a
	farjp Paintingpic

Script_givekeyitem:
	call GetScriptByte
	ld [wCurKeyItem], a
	ld [wItemQuantityChangeBuffer], a
	call ReceiveKeyItem
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_checkkeyitem:
	call GetScriptByte
	ld [wCurKeyItem], a
	ld [wItemQuantityChangeBuffer], a
	call CheckKeyItem
	; a = carry ? TRUE : FALSE
	sbc a
	and TRUE
	ldh [hScriptVar], a
	ret

Script_takekeyitem:
	call GetScriptByte
	ld [wCurKeyItem], a
	ld [wItemQuantityChangeBuffer], a
	call TossKeyItem
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_verbosegivekeyitem:
	call Script_givekeyitem
	call GetCurKeyItemName
	ld a, STRING_BUFFER_4
	call CopyConvertedText
	ld b, BANK(GiveKeyItemScript)
	ld de, GiveKeyItemScript
	jmp ScriptCall

GiveKeyItemScript:
	farwritetext _GainedItemText
	special ShowKeyItemIcon
	playsound SFX_KEY_ITEM
	waitsfx
	waitbutton
	keyitemnotify
	end

Script_keyitemnotify:
	call GetKeyItemPocketName
	call GetCurKeyItemName
	ld b, BANK(_PutItemInPocketText)
	ld hl, _PutItemInPocketText
	call MapTextbox
	; The key item icon overwrites nine font tiles, including
	; the "▶" needed by the right cursor arrow.
	farjp LoadFonts_NoOAMUpdate

Script_setmapobjectmovedata:
	call GetScriptByte
	cp LAST_TALKED
	jr nz, .ok
	ldh a, [hLastTalked]
.ok
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp -1
	ret z
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	call GetScriptByte
	ld [hl], a
	ret

Script_setmapobjectpal:
	call GetScriptByte
	call GetMapObject
	ld hl, MAPOBJECT_PALETTE
	add hl, bc
	call GetScriptByte
	ld [hl], a
	ret

Script_givespecialitem:
	call GetScriptByte
	ld [wNamedObjectIndex], a
	ld [wCurSpecialItem], a
	call GetSpecialItemName
	ld a, STRING_BUFFER_4
	call CopyConvertedText
	ld b, BANK(GiveSpecialItemScript)
	ld de, GiveSpecialItemScript
	jmp ScriptCall

GiveSpecialItemScript:
	farwritetext _GotTheItemText
	callasm ShowSpecialItemIcon
	playsound SFX_ITEM
	waitsfx
	writetext ClearText
	callasm LoadFonts_NoOAMUpdate
	end

Script_givebadge:
	call GetScriptByte
	assert JOHTO_REGION == KANTO_REGION - 1
	cp KANTO_REGION << 4 ; region is in high nybble
	assert JOHTO_REGION == 0 && NUM_JOHTO_BADGES == 8
	jr c, .got_region
	xor KANTO_REGION << 4 | NUM_JOHTO_BADGES
.got_region
	ld [wNamedObjectIndex], a
	ld [wCurBadge], a
	assert ENGINE_BADGES + NUM_BADGES < $100
	ld de, ENGINE_BADGES
	add e
	ld e, a
	ld b, SET_FLAG
	farcall EngineFlagAction
	call GetBadgeName
	ld a, STRING_BUFFER_4
	call CopyConvertedText
	ld b, BANK(GiveBadgeScript)
	ld de, GiveBadgeScript
	jmp ScriptCall

GiveBadgeScript:
	farwritetext _ReceivedTheBadgeText
	callasm ShowBadgeIcon
	playsound SFX_GET_BADGE
	waitsfx
	writetext ClearText
	special LoadMapPalettes
	callasm SetDefaultBGPAndOBP
	special LoadFonts_NoOAMUpdate
	end

ShowBadgeIcon:
	ld a, [wCurBadge]
	assert JOHTO_REGION == 0 && KANTO_REGION == 1
	cp NUM_JOHTO_BADGES
	ld b, BANK(BadgeGFX)
	ld hl, BadgeGFX
	jr c, .got_region
	sub NUM_JOHTO_BADGES
	ld b, BANK(BadgeGFX2)
	ld hl, BadgeGFX2
.got_region
	push af
	call FarDecompressWRA6InB
	pop af
	ld bc, 4 tiles
	ld hl, wDecompressScratch
	rst AddNTimes
	ld d, h
	ld e, l
	ld c, 4
	ld hl, vTiles0 tile "↑"
	call Request2bppInWRA6
	farcall LoadSingleBadgePalette
	ld a, "↑"
	hlcoord 17, 13
	ld [hli], a
	inc a
	ld [hl], a
	inc a
	hlcoord 17, 14
	ld [hli], a
	inc a
	ld [hl], a
	ld b, 2
	jmp SafeCopyTilemapAtOnce

Script_setquantity:
; Sets wItemQuantityChangeBuffer to hScriptVar, for text_plural benefit.
	ldh a, [hScriptVar]
	ld [wItemQuantityChangeBuffer], a
	ret

Script_pluralize:
; Pluralizes a string buffer. This is needed for non-instant/scrolling text.
; The reason is that otherwise, we can end up scrolling "Oran Berry", then
; replace "y" with "ies" which looks silly.
; This assumes that we can safely write to (string buffer)-1!
	call GetScriptWord
	; fallthrough (input in hl)
Pluralize:
	; Avoid going beyond the beginning of the string.
	dec hl
	ld a, [hl]
	push hl
	push af
	ld a, "@"
	ld [hli], a

	; Track down the terminator.
.terminator_loop
	ld a, [hli]
	cp "@"
	jr nz, .terminator_loop
	ld b, h
	ld c, l
	dec bc
	call TextCommand_PLURAL
	pop af
	pop hl
	ld [hl], a
	ret
