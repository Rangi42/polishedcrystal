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

	ld hl, wVramState
	bit 7, [hl]
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
	table_width 2, ScriptCommandTable
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
	dw Script_addval                     ; 16
	dw Script_random                     ; 17
	dw Script_readmem                    ; 18
	dw Script_writemem                   ; 19
	dw Script_loadmem                    ; 1a
	dw Script_readvar                    ; 1b
	dw Script_writevar                   ; 1c
	dw Script_loadvar                    ; 1d
	dw Script_giveitem                   ; 1e
	dw Script_takeitem                   ; 1f
	dw Script_checkitem                  ; 20
	dw Script_givemoney                  ; 21
	dw Script_takemoney                  ; 22
	dw Script_checkmoney                 ; 23
	dw Script_givecoins                  ; 24
	dw Script_takecoins                  ; 25
	dw Script_checkcoins                 ; 26
	dw Script_addcellnum                 ; 27
	dw Script_delcellnum                 ; 28
	dw Script_checkcellnum               ; 29
	dw Script_checktime                  ; 2a
	dw Script_checkpoke                  ; 2b
	dw Script_givepoke                   ; 2c
	dw Script_giveegg                    ; 2d
	dw Script_givepokemail               ; 2e
	dw Script_checkpokemail              ; 2f
	dw Script_checkevent                 ; 30
	dw Script_clearevent                 ; 31
	dw Script_setevent                   ; 32
	dw Script_checkflag                  ; 33
	dw Script_clearflag                  ; 34
	dw Script_setflag                    ; 35
	dw Script_wildon                     ; 36
	dw Script_wildoff                    ; 37
	dw Script_warpmod                    ; 38
	dw Script_blackoutmod                ; 39
	dw Script_warp                       ; 3a
	dw Script_getmoney                   ; 3b
	dw Script_getcoins                   ; 3c
	dw Script_getnum                     ; 3d
	dw Script_getmonname                 ; 3e
	dw Script_getitemname                ; 3f
	dw Script_getcurlandmarkname         ; 40
	dw Script_gettrainername             ; 41
	dw Script_getstring                  ; 42
	dw Script_itemnotify                 ; 43
	dw Script_pocketisfull               ; 44
	dw Script_opentext                   ; 45
	dw Script_refreshscreen              ; 46
	dw Script_closetext                  ; 47
	dw Script_farwritetext               ; 48
	dw Script_writetext                  ; 49
	dw Script_repeattext                 ; 4a
	dw Script_yesorno                    ; 4b
	dw Script_loadmenu                   ; 4c
	dw Script_closewindow                ; 4d
	dw Script_jumptextfaceplayer         ; 4e
	dw Script_farjumptext                ; 4f
	dw Script_jumptext                   ; 50
	dw Script_waitbutton                 ; 51
	dw Script_promptbutton               ; 52
	dw Script_pokepic                    ; 53
	dw Script_closepokepic               ; 54
	dw Script__2dmenu                    ; 55
	dw Script_verticalmenu               ; 56
	dw Script_randomwildmon              ; 57
	dw Script_loadtemptrainer            ; 58
	dw Script_loadwildmon                ; 59
	dw Script_loadtrainer                ; 5a
	dw Script_startbattle                ; 5b
	dw Script_reloadmapafterbattle       ; 5c
	dw Script_catchtutorial              ; 5d
	dw Script_trainertext                ; 5e
	dw Script_trainerflagaction          ; 5f
	dw Script_winlosstext                ; 60
	dw Script_scripttalkafter            ; 61
	dw Script_endifjustbattled           ; 62
	dw Script_checkjustbattled           ; 63
	dw Script_setlasttalked              ; 64
	dw Script_applymovement              ; 65
	dw Script_applymovementlasttalked    ; 66
	dw Script_faceplayer                 ; 67
	dw Script_faceobject                 ; 68
	dw Script_variablesprite             ; 69
	dw Script_disappear                  ; 6a
	dw Script_appear                     ; 6b
	dw Script_follow                     ; 6c
	dw Script_stopfollow                 ; 6d
	dw Script_moveobject                 ; 6e
	dw Script_writeobjectxy              ; 6f
	dw Script_loademote                  ; 70
	dw Script_showemote                  ; 71
	dw Script_turnobject                 ; 72
	dw Script_follownotexact             ; 73
	dw Script_earthquake                 ; 74
	dw Script_changemapblocks            ; 75
	dw Script_changeblock                ; 76
	dw Script_reloadmap                  ; 77
	dw Script_reloadmappart              ; 78
	dw Script_usestonetable              ; 79
	dw Script_playmusic                  ; 7a
	dw Script_encountermusic             ; 7b
	dw Script_musicfadeout               ; 7c
	dw Script_playmapmusic               ; 7d
	dw Script_dontrestartmapmusic        ; 7e
	dw Script_cry                        ; 7f
	dw Script_playsound                  ; 80
	dw Script_waitsfx                    ; 81
	dw Script_warpsound                  ; 82
	dw Script_specialsound               ; 83
	dw Script_autoinput                  ; 84
	dw Script_newloadmap                 ; 85
	dw Script_pause                      ; 86
	dw Script_deactivatefacing           ; 87
	dw Script_sdefer                     ; 88
	dw Script_warpcheck                  ; 89
	dw Script_stopandsjump               ; 8a
	dw Script_endcallback                ; 8b
	dw Script_end                        ; 8c
	dw Script_reloadend                  ; 8d
	dw Script_endall                     ; 8e
	dw Script_pokemart                   ; 8f
	dw Script_elevator                   ; 90
	dw Script_trade                      ; 91
	dw Script_askforphonenumber          ; 92
	dw Script_hangup                     ; 93
	dw Script_describedecoration         ; 94
	dw Script_fruittree                  ; 95
	dw Script_specialphonecall           ; 96
	dw Script_checkphonecall             ; 97
	dw Script_verbosegiveitem            ; 98
	dw Script_verbosegiveitemvar         ; 99
	dw Script_swarm                      ; 9a
	dw Script_halloffame                 ; 9b
	dw Script_credits                    ; 9c
	dw Script_warpfacing                 ; 9d
	dw Script_battletowertext            ; 9e
	dw Script_getlandmarkname            ; 9f
	dw Script_gettrainerclassname        ; a0
	dw Script_getname                    ; a1
	dw Script_wait                       ; a2
	dw Script_checksave                  ; a3
	dw Script_countseencaught            ; a4
	dw Script_trainerpic                 ; a5
	dw Script_givetmhm                   ; a6
	dw Script_checktmhm                  ; a7
	dw Script_verbosegivetmhm            ; a8
	dw Script_tmhmnotify                 ; a9
	dw Script_gettmhmname                ; aa
	dw Script_checkdarkness              ; ab
	dw Script_checkunits                 ; ac
	dw Script_unowntypeface              ; ad
	dw Script_restoretypeface            ; ae
	dw Script_jumpstashedtext            ; af
	dw Script_jumpopenedtext             ; b0
	dw Script_iftrue_jumptext            ; b1
	dw Script_iffalse_jumptext           ; b2
	dw Script_iftrue_jumptextfaceplayer  ; b3
	dw Script_iffalse_jumptextfaceplayer ; b4
	dw Script_iftrue_jumpopenedtext      ; b5
	dw Script_iffalse_jumpopenedtext     ; b6
	dw Script_writethistext              ; b7
	dw Script_jumpthistext               ; b8
	dw Script_jumpthistextfaceplayer     ; b9
	dw Script_jumpthisopenedtext         ; ba
	dw Script_showtext                   ; bb
	dw Script_showtextfaceplayer         ; bc
	dw Script_applyonemovement           ; bd
	dw Script_showcrytext                ; be
	dw Script_endtext                    ; bf
	dw Script_waitendtext                ; c0
	dw Script_iftrue_endtext             ; c1
	dw Script_iffalse_endtext            ; c2
	dw Script_loadgrottomon              ; c3
	dw Script_giveapricorn               ; c4
	dw Script_paintingpic                ; c5
	dw Script_checkegg                   ; c6
	dw Script_givekeyitem                ; c7
	dw Script_checkkeyitem               ; c8
	dw Script_takekeyitem                ; c9
	dw Script_verbosegivekeyitem         ; ca
	dw Script_keyitemnotify              ; cb
	dw Script_givebp                     ; cc
	dw Script_takebp                     ; cd
	dw Script_checkbp                    ; ce
	assert_table_length NUM_EVENT_COMMANDS

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
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, b
	jmp FarCall_hl

Script_special:
	call GetScriptByte
	ld e, a
	ld d, 0
	farjp Special

Script_memcallasm:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld b, [hl]
	inc hl
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
	repeattext -1, -1
	waitendtext

_GetTextPointer:
	ld a, [wScriptBank]
	ld [wScriptTextBank], a
	call GetScriptByte
	ld [wScriptTextAddr], a
	call GetScriptByte
	ld [wScriptTextAddr + 1], a
	ret

_GetThisTextPointer:
	ld a, [wScriptBank]
	ld [wScriptTextBank], a
	ld a, [wScriptPos]
	ld [wScriptTextAddr], a
	ld a, [wScriptPos + 1]
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
	ld a, [wScriptBank]
	ld [wScriptTextBank], a
	ld a, [wStashedTextPointer]
	ld [wScriptTextAddr], a
	ld a, [wStashedTextPointer + 1]
	ld [wScriptTextAddr + 1], a
	ld b, BANK(JumpTextScript)
	ld hl, JumpTextScript
	jmp ScriptJump

Script_writetext:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [wScriptBank]
	ld b, a
	jmp MapTextbox

Script_farwritetext:
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	jmp MapTextbox

Script_writethistext:
	ld hl, wScriptPos
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wScriptBank]
	ld b, a
	call MapTextbox
	ld a, l
	ld [wScriptPos], a
	ld a, h
	ld [wScriptPos + 1], a
	ret

Script_repeattext:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	cp -1
	ret nz
	ld a, l
	cp -1
	ret nz
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
	ret

Script_loadmenu:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [wScriptBank]
	ld de, LoadMenuHeader
	call FarCall_de
	jmp UpdateSprites

Script_closewindow:
	call CloseWindow
	jmp UpdateSprites

Script_pokepic:
	call GetScriptByte
	and a
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wCurPartySpecies], a
	call GetScriptByte
	ld [wCurForm], a
	farjp Pokepic

Script_closepokepic:
	farjp ClosePokepic

Script_verticalmenu:
	ld a, [wScriptBank]
	ld hl, VerticalMenu
	call FarCall_hl
	ld a, [wMenuCursorY]
	jr nc, .ok
	xor a
.ok
	ldh [hScriptVar], a
	ret

Script__2dmenu:
	ld a, [wScriptBank]
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
	call CurItemName
	ld de, wStringBuffer1
	ld a, 1
	call CopyConvertedText
	ld b, BANK(GiveItemScript)
	ld de, GiveItemScript
	jmp ScriptCall

GiveItemScript:
	farwritetext _ReceivedItemText
	iffalse .Full
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
	call CurItemName
	ld de, wStringBuffer1
	ld a, 1
	call CopyConvertedText
	ld b, BANK(GiveItemScript)
	ld de, GiveItemScript
	jmp ScriptCall

Script_itemnotify:
	call GetPocketName
	call CurItemName
	ld b, BANK(_PutItemInPocketText)
	ld hl, _PutItemInPocketText
	jmp MapTextbox

Script_pocketisfull:
	call GetPocketName
	call CurItemName
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
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
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

CurItemName:
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	jmp GetItemName

CurTMHMName:
	ld a, [wCurTMHM]
	ld [wNamedObjectIndex], a
	jmp GetTMHMName

Script_pokemart:
	call Script_faceplayer
	call Script_opentext
	call GetScriptByte
	ld c, a
	call GetScriptByte
	ld e, a
	ld d, 0
	ld a, [wScriptBank]
	ld b, a
	farcall OpenMartDialog
	jmp Script_endtext

Script_elevator:
	xor a
	ldh [hScriptVar], a
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld a, [wScriptBank]
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
	ld e, [hl]
	inc hl
	ld d, [hl]
	call GetScriptByte
	ld b, a
	call EventFlagAction
	ld a, c
	and a
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
	ld de, MUSIC_NONE
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
	ld a, [wPlayerStandingTile]
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
	call GetScriptByte
	and a
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	jmp PlayCry

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

	ld hl, wScriptPos
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call SkipTwoScriptBytes
	ld a, [wScriptBank]
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

	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [wScriptBank]
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
	ld d, $0
	ldh a, [hLastTalked]
	ld e, a
	farcall GetRelativeFacing
	ld a, d
	add a
	add a
	ld e, a
	ldh a, [hLastTalked]
	ld d, a
	jr ApplyPersonFacing

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
	jr ApplyPersonFacing

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

ApplyPersonFacing::
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
	ld hl, wVramState
	bit 6, [hl]
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
	ld e, [hl]
	inc hl
	ld d, [hl]
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
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld c, a
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
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld c, a
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
	and $3f
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
	farcall PostBattleTasks
	ld hl, wBattleScriptFlags
	ld d, [hl]
	xor a
	ld [hli], a ; wBattleScriptFlags
	ld [hl], a ; wWildMonForm
	ld hl, wWildBattlePanic
	ld [hl], d
	ld a, [wBattleResult]
	and $3f
	cp $1
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
	bit 7, a
	jr z, .done
	ld b, BANK(Script_SpecialBillCall)
	ld de, Script_SpecialBillCall
	call LoadScriptBDE
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
	ld a, [wScriptBank]
	ld b, a
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	jr ScriptCall

Script_farscall:
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	jr ScriptCall

Script_memcall:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld b, [hl]
	inc hl
	ld e, [hl]
	inc hl
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
	ld a, [wScriptBank]
	ld [hli], a
	ld a, [wScriptPos]
	ld [hli], a
	ld a, [wScriptPos + 1]
	ld [hl], a
	ld a, b
	ld [wScriptBank], a
	ld a, e
	ld [wScriptPos], a
	ld a, d
	ld [wScriptPos + 1], a
	ret

CallCallback::
	ld a, [wScriptBank]
	or $80
	ld [wScriptBank], a
	jr ScriptCall

Script_sjump:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [wScriptBank]
	ld b, a
	jmp ScriptJump

Script_farsjump:
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	jr ScriptJump

Script_memjump:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld b, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr ScriptJump

Script_iffalse:
	ldh a, [hScriptVar]
	and a
	jr nz, SkipTwoScriptBytes
	jr Script_sjump

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
	call GetScriptByte
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
	add hl, de
	ld a, BANK(StdScripts)
	call GetFarByte
	ld b, a
	inc hl
	ld a, BANK(StdScripts)
	jmp GetFarWord

ScriptJump:
	ld a, b
	ld [wScriptBank], a
	ld a, l
	ld [wScriptPos], a
	ld a, h
	ld [wScriptPos + 1], a
	ret

Script_sdefer:
	ld a, [wScriptBank]
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
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld c, a
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
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld c, a
DoTrigger:
	call GetMapSceneID
	ld a, d
	or e
	ret z
	call GetScriptByte
	ld [de], a
	ret

Script_readmem:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [hl]
	ldh [hScriptVar], a
	ret

Script_writemem:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ldh a, [hScriptVar]
	ld [hl], a
	ret

Script_loadmem:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	call GetScriptByte
	ld [hl], a
	ret

Script_setval:
	call GetScriptByte
	ldh [hScriptVar], a
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

	ld c, a
	call .Divide256byC
	and a
	jr z, .no_restriction ; 256 % b == 0
	ld b, a
	xor a
	sub b
	ld b, a
.loop
	push bc
	call Random
	pop bc
	ldh a, [hRandomAdd]
	cp b
	jr nc, .loop
	jr .finish

.no_restriction
	push bc
	call Random
	pop bc
	ldh a, [hRandomAdd]

.finish
	push af
	ldh a, [hScriptVar]
	ld c, a
	pop af
	call SimpleDivide
	ldh [hScriptVar], a
	ret

.Divide256byC:
	xor a
	ld b, a
	sub c
.mod_loop
	inc b
	sub c
	jr nc, .mod_loop
	dec b
	add c
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
	call GetScriptByte
	and a
	jr nz, .gotit
	ldh a, [hScriptVar]
.gotit
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld de, wStringBuffer1
	; fallthrough

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
	ld de, wStringBuffer1
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
	farcall GetLandmarkName
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

Script_getname:
	call GetScriptByte
	ld [wNamedObjectTypeBuffer], a
	; fallthrough

ContinueToGetName:
	call GetScriptByte
	ld [wCurSpecies], a
	call GetName
	ld de, wStringBuffer1
	jr ConvertMemToText

Script_gettrainerclassname:
	ld a, TRAINER_NAME
	ld [wNamedObjectTypeBuffer], a
	jr ContinueToGetName

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
	jmp ConvertMemToText

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
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld a, [wScriptBank]
	ld hl, CopyName1
	call FarCall_hl
	ld de, wStringBuffer2
	jmp ConvertMemToText

Script_givepokemail:
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [wScriptBank]
	call GetFarByte
	ld b, a
	push bc
	inc hl
	ld bc, MAIL_MSG_LENGTH
	ld de, wMonMailMessageBuffer
	ld a, [wScriptBank]
	call FarCopyBytes
	pop bc
	farjp GivePokeItem

Script_checkpokemail:
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld a, [wScriptBank]
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
	xor a
	jr .done
.one
	ld a, 1
	jr .done
.two
	ld a, 2
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
	ld hl, wPartySpecies
	call IsInByteArray
	ret nc
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
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
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
	ld hl, wScriptPos
	ld e, [hl]
	inc hl
	ld d, [hl]
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
	xor a
	ld [wOTPartyCount], a
	ld [wCurItem], a
	ld [wCurPlayerMove], a
	inc a
	ld [wMonType], a  ; OTPARTYMON
	ld [wBattleMode], a
	ld [wCurPartyLevel], a ; EGG_LEVEL
	ld a, POKE_BALL
	ld [wGiftMonBall], a
	call GetScriptByte
	ld [wCurPartySpecies], a
	ld [wEnemyMonSpecies], a
	call GetScriptByte
	ld [wCurForm], a
	farcall GivePoke
	ld a, b
	ldh [hScriptVar], a
	ret

Script_setevent:
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld b, SET_FLAG
	jmp EventFlagAction

Script_clearevent:
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld b, RESET_FLAG
	jmp EventFlagAction

Script_checkevent:
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jr z, .false
	ld a, TRUE
.false
	ldh [hScriptVar], a
	ret

Script_setflag:
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld b, SET_FLAG
	jr _EngineFlagAction

Script_clearflag:
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld b, RESET_FLAG
_EngineFlagAction:
	farjp EngineFlagAction

Script_checkflag:
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
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

Script_reloadmappart::
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
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	pop af
	jmp StartAutoInput

Script_pause:
	call GetScriptByte
	and a
	jr z, .loop
	ld [wScriptDelay], a
.loop
	ld c, 2
	call DelayFrames
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
	ld [wScriptBank], a
	ld a, [hli]
	ld e, a
	ld [wScriptPos], a
	ld a, [hl]
	ld d, a
	ld [wScriptPos + 1], a
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
	ld hl, wGameTimerPaused
	res 0, [hl]
	farcall HallOfFame
	ld hl, wGameTimerPaused
	set 0, [hl]
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

Script_countseencaught:
	ld hl, wPokedexSeen
	ld b, wEndPokedexSeen - wPokedexSeen
	call CountSetBits
	ld [wTempPokedexSeenCount], a
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld [wTempPokedexCaughtCount], a
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
	call CurTMHMName
	ld de, wStringBuffer1
	ld a, 1
	call CopyConvertedText
	ld b, BANK(GiveTMHMScript)
	ld de, GiveTMHMScript
	jmp ScriptCall

GiveTMHMScript:
	farwritetext _ReceivedItemText
	playsound SFX_GET_TM
	waitsfx
	waitbutton
	tmhmnotify
	end

Script_tmhmnotify:
	call GetTMHMPocketName
	call CurTMHMName
	ld b, BANK(_PutItemInPocketText)
	ld hl, _PutItemInPocketText
	jmp MapTextbox

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
	and $ff - FONT_MASK
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
	ld [wTempWildMonSpecies], a
	call PlayCry
	ld a, (1 << 7)
	ld [wBattleScriptFlags], a
	farcall GetCurHiddenGrottoLevel
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
	and a
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
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
	ld de, wStringBuffer1
	ld a, 1
	call CopyConvertedText
	ld b, BANK(GiveKeyItemScript)
	ld de, GiveKeyItemScript
	jmp ScriptCall

GiveKeyItemScript:
	farwritetext _ReceivedItemText
	playsound SFX_KEY_ITEM
	waitbutton
	keyitemnotify
	end

Script_keyitemnotify:
	call GetKeyItemPocketName
	call GetCurKeyItemName
	ld b, BANK(_PutItemInPocketText)
	ld hl, _PutItemInPocketText
	jmp MapTextbox
