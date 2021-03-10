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
	jp StartScript

WaitScriptMovement:
	call StopScript

	ld hl, wVramState
	bit 7, [hl]
	ret nz

	farcall UnfreezeAllObjects

	ld a, SCRIPT_READ
	ld [wScriptMode], a
	jp StartScript

RunScriptCommand:
	call GetScriptByte
	call StackJumpTable

ScriptCommandTable:
	dw Script_scall                      ; 00
	dw Script_farscall                   ; 01
	dw Script_ptcall                     ; 02
	dw Script_jump                       ; 03
	dw Script_farjump                    ; 04
	dw Script_ptjump                     ; 05
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
	dw Script_ptcallasm                  ; 10
	dw Script_checkmapscene              ; 11
	dw Script_setmapscene                ; 12
	dw Script_checkscene                 ; 13
	dw Script_setscene                   ; 14
	dw Script_writebyte                  ; 15
	dw Script_addvar                     ; 16
	dw Script_random                     ; 17
	dw Script_copybytetovar              ; 18
	dw Script_copyvartobyte              ; 19
	dw Script_loadvar                    ; 1a
	dw Script_checkcode                  ; 1b
	dw Script_writevarcode               ; 1c
	dw Script_writecode                  ; 1d
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
	dw Script_givepokeitem               ; 2e
	dw Script_checkpokeitem              ; 2f
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
	dw Script_readmoney                  ; 3b
	dw Script_readcoins                  ; 3c
	dw Script_RAM2MEM                    ; 3d
	dw Script_pokenamemem                ; 3e
	dw Script_itemtotext                 ; 3f
	dw Script_mapnametotext              ; 40
	dw Script_trainertotext              ; 41
	dw Script_stringtotext               ; 42
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
	dw Script_buttonsound                ; 52
	dw Script_pokepic                    ; 53
	dw Script_closepokepic               ; 54
	dw Script__2dmenu                    ; 55
	dw Script_verticalmenu               ; 56
	dw Script_randomwildmon              ; 57
	dw Script_loadmemtrainer             ; 58
	dw Script_loadwildmon                ; 59
	dw Script_loadtrainer                ; 5a
	dw Script_startbattle                ; 5b
	dw Script_reloadmapafterbattle       ; 5c
	dw Script_catchtutorial              ; 5d
	dw Script_trainertext                ; 5e
	dw Script_trainerflagaction          ; 5f
	dw Script_winlosstext                ; 60
	dw Script_scripttalkafter            ; 61
	dw Script_end_if_just_battled        ; 62
	dw Script_check_just_battled         ; 63
	dw Script_setlasttalked              ; 64
	dw Script_applymovement              ; 65
	dw Script_applymovement2             ; 66
	dw Script_faceplayer                 ; 67
	dw Script_faceobject                 ; 68
	dw Script_variablesprite             ; 69
	dw Script_disappear                  ; 6a
	dw Script_appear                     ; 6b
	dw Script_follow                     ; 6c
	dw Script_stopfollow                 ; 6d
	dw Script_moveobject                 ; 6e
	dw Script_writepersonxy              ; 6f
	dw Script_loademote                  ; 70
	dw Script_showemote                  ; 71
	dw Script_turnobject                 ; 72
	dw Script_follownotexact             ; 73
	dw Script_earthquake                 ; 74
	dw Script_changemap                  ; 75
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
	dw Script_passtoengine               ; 84
	dw Script_newloadmap                 ; 85
	dw Script_pause                      ; 86
	dw Script_deactivatefacing           ; 87
	dw Script_priorityjump               ; 88
	dw Script_warpcheck                  ; 89
	dw Script_ptpriorityjump             ; 8a
	dw Script_return                     ; 8b
	dw Script_end                        ; 8c
	dw Script_reloadandreturn            ; 8d
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
	dw Script_verbosegiveitem2           ; 99
	dw Script_swarm                      ; 9a
	dw Script_halloffame                 ; 9b
	dw Script_credits                    ; 9c
	dw Script_warpfacing                 ; 9d
	dw Script_battletowertext            ; 9e
	dw Script_landmarktotext             ; 9f
	dw Script_trainerclassname           ; a0
	dw Script_name                       ; a1
	dw Script_wait                       ; a2
	dw Script_check_save                 ; a3
	dw Script_count_seen_caught          ; a4
	dw Script_trainerpic                 ; a5
	dw Script_givetmhm                   ; a6
	dw Script_checktmhm                  ; a7
	dw Script_verbosegivetmhm            ; a8
	dw Script_tmhmnotify                 ; a9
	dw Script_tmhmtotext                 ; aa
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
; parameters:
;     asm (AsmPointerParam)
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, b
	jp FarCall_hl

Script_special:
; parameters:
;     predefined_script (SingleByteParam)
	call GetScriptByte
	ld e, a
	ld d, 0
	farjp Special

Script_ptcallasm:
; parameters:
;     asm (PointerToAsmPointerParam)
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
	jp FarCall_hl

Script_iftrue_jumptextfaceplayer:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ldh a, [hScriptVar]
	and a
	jr nz, Script_jumptextfaceplayer
	jp SkipTwoScriptBytes

Script_iffalse_jumptextfaceplayer:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ldh a, [hScriptVar]
	and a
	jp nz, SkipTwoScriptBytes
; fallthrough

Script_jumptextfaceplayer:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call _GetTextPointer
	jr _Do_textfaceplayer

Script_jumpthistextfaceplayer:
	call _GetThisTextPointer
_Do_textfaceplayer:
	ld b, BANK(JumpTextFacePlayerScript)
	ld hl, JumpTextFacePlayerScript
	jp ScriptJump

Script_iftrue_jumptext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ldh a, [hScriptVar]
	and a
	jr nz, Script_jumptext
	jp SkipTwoScriptBytes

Script_iffalse_jumptext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ldh a, [hScriptVar]
	and a
	jp nz, SkipTwoScriptBytes
; fallthrough

Script_jumptext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call _GetTextPointer
	jr _Do_jumptext

Script_jumpthistext:
	call _GetThisTextPointer
_Do_jumptext:
	ld b, BANK(JumpTextScript)
	ld hl, JumpTextScript
	jp ScriptJump

Script_iftrue_jumpopenedtext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ldh a, [hScriptVar]
	and a
	jr nz, Script_jumpopenedtext
	jp SkipTwoScriptBytes

Script_iffalse_jumpopenedtext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ldh a, [hScriptVar]
	and a
	jp nz, SkipTwoScriptBytes
; fallthrough

Script_jumpopenedtext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call _GetTextPointer
	jr _Do_jumpopenedtext

Script_jumpthisopenedtext:
	call _GetThisTextPointer
_Do_jumpopenedtext:
	ld b, BANK(JumpOpenedTextScript)
	ld hl, JumpOpenedTextScript
	jp ScriptJump

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
; parameters:
;     text_pointer (PointerLabelBeforeBank)
	call GetScriptByte
	ld [wScriptTextBank], a
	call GetScriptByte
	ld [wScriptTextAddr], a
	call GetScriptByte
	ld [wScriptTextAddr + 1], a
	ld b, BANK(JumpTextScript)
	ld hl, JumpTextScript
	jp ScriptJump

Script_jumpstashedtext:
	ld a, [wScriptBank]
	ld [wScriptTextBank], a
	ld a, [wStashedTextPointer]
	ld [wScriptTextAddr], a
	ld a, [wStashedTextPointer + 1]
	ld [wScriptTextAddr + 1], a
	ld b, BANK(JumpTextScript)
	ld hl, JumpTextScript
	jp ScriptJump

Script_writetext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [wScriptBank]
	ld b, a
	jp MapTextbox

Script_farwritetext:
; parameters:
;     text_pointer (PointerLabelBeforeBank)
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	jp MapTextbox

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
; parameters:
;     byte (SingleByteParam)
;     byte (SingleByteParam)
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
	jp MapTextbox

Script_buttonsound:
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
; parameters:
;     data (MenuDataPointerParam)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [wScriptBank]
	ld de, LoadMenuHeader
	call FarCall_de
	jp UpdateSprites

Script_closewindow:
	call CloseWindow
	jp UpdateSprites

Script_pokepic:
; parameters:
;     pokemon (PokemonParam)
;     flag (SingleByteParam)
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
; parameters:
;     pointer (PointerLabelBeforeBank)
;     memory (SingleByteParam)
	call SetUpTextbox
	call GetScriptByte
	ld c, a
	farjp BattleTowerText

Script_verbosegiveitem:
; parameters:
;     item (ItemLabelByte)
;     quantity (DecimalParam)
	call Script_giveitem
	call CurItemName
	ld de, wStringBuffer1
	ld a, 1
	call CopyConvertedText
	ld b, BANK(GiveItemScript)
	ld de, GiveItemScript
	jp ScriptCall

GiveItemScript:
	farwritetext _ReceivedItemText
	iffalse .Full
	specialsound
	waitbutton
	itemnotify
	end

.Full:
	buttonsound
	pocketisfull
	end

Script_verbosegiveitem2:
; parameters:
;     item (ItemLabelByte)
;     var (SingleByteParam)
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
	jp ScriptCall

Script_itemnotify:
	call GetPocketName
	call CurItemName
	ld b, BANK(_PutItemInPocketText)
	ld hl, _PutItemInPocketText
	jp MapTextbox

Script_pocketisfull:
	call GetPocketName
	call CurItemName
	ld b, BANK(_PocketIsFullText)
	ld hl, _PocketIsFullText
	jp MapTextbox

Script_specialsound:
	ld de, SFX_ITEM
	call WaitPlaySFX
	jp WaitSFX

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
	jp CopyName2

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
	jp CopyName2

TMHMPocketName:
	db "TM Pocket@"

CurItemName:
	ld a, [wCurItem]
	ld [wd265], a
	jp GetItemName

CurTMHMName:
	ld a, [wCurTMHM]
	ld [wd265], a
	jp GetTMHMName

Script_pokemart:
; parameters:
;     dialog_id (SingleByteParam)
;     mart_id (SingleByteParam)
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
	jp Script_endtext

Script_elevator:
; parameters:
;     floor_list_pointer (PointerLabelParam)
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
; parameters:
;     trade_id (SingleByteParam)
	call Script_faceplayer
	call Script_opentext
	call GetScriptByte
	ld e, a
	farcall NPCTrade
	jp Script_waitendtext

Script_hangup:
	farjp HangUp

Script_askforphonenumber:
; parameters:
;     number (SingleByteParam)
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
; parameters:
;     byte (SingleByteParam)
	call GetScriptByte
	ld b, a
	farcall DescribeDecoration
	ld h, d
	ld l, e
	jp ScriptJump

Script_fruittree:
; parameters:
;     tree_id (SingleByteParam)
;     fruit_id (SingleByteParam)
	call GetScriptByte
	ld [wCurFruitTree], a
	call GetScriptByte
	ld [wCurFruit], a
	ld b, BANK(FruitTreeScript)
	ld hl, FruitTreeScript
	jp ScriptJump

Script_swarm:
; parameters:
;     flag (SingleByteParam)
;     map_group (MapGroupParam)
;     map_id (MapIdParam)
	call GetScriptByte
	ld c, a
	call GetScriptByte
	ld d, a
	call GetScriptByte
	ld e, a
	farjp StoreSwarmMapIndices

Script_trainertext:
; parameters:
;     which_text (SingleByteParam)
	call GetScriptByte
	ld c, a
	ld b, 0
	ld hl, wWalkingX
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSeenTrainerBank]
	ld b, a
	jp MapTextbox

Script_scripttalkafter:
	ld hl, wScriptAfterPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSeenTrainerBank]
	ld b, a
	jp ScriptJump

Script_trainerflagaction:
; parameters:
;     action (SingleByteParam)
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
; parameters:
;     win_text_pointer (TextPointerLabelParam)
;     loss_text_pointer (TextPointerLabelParam)
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

Script_end_if_just_battled:
	ld a, [wRunningTrainerBattleScript]
	and a
	ret z
	jp Script_end

Script_check_just_battled:
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
; parameters:
;     music_pointer (SingleByteParam)
	ld de, MUSIC_NONE
	call PlayMusic
	xor a
	ld [wMusicFade], a
	call MaxVolume
	call GetScriptByte
	ld e, a
	ld d, 0
	jp PlayMusic

Script_musicfadeout:
; parameters:
;     music (SingleByteParam)
;     fadetime (SingleByteParam)
	call GetScriptByte
	ld [wMusicFadeID], a
	xor a
	ld [wMusicFadeID + 1], a
	call GetScriptByte
	and $7f
	ld [wMusicFade], a
	ret

Script_playsound:
; parameters:
;     sound_pointer (SingleByteParam)
	call GetScriptByte
	ld e, a
	ld d, 0
	jp WaitPlaySFX

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
	jp PlaySFX

Script_cry:
; parameters:
;     cry_id (SingleByteParam)
	call GetScriptByte
	and a
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	jp PlayCry

Script_setlasttalked:
; parameters:
;     person (SingleByteParam)
	call GetScriptByte
	ldh [hLastTalked], a
	ret

Script_applyonemovement:
; parameters:
;     person (SingleByteParam)
;     data (MovementDataParam)
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
	jp StopScript

Script_applymovement:
; parameters:
;     person (SingleByteParam)
;     data (MovementPointerLabelParam)
	call GetScriptByte
	ld c, a
	jr ApplyMovement

Script_applymovement2:
; apply movement to last talked
; parameters:
;     data (MovementPointerLabelParam)
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
	jp StopScript

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
; parameters:
;     person1 (SingleByteParam)
;     person2 (SingleByteParam)
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
; parameters:
;     person (SingleByteParam)
;     facing (SingleByteParam)
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
	jp UpdateSprites

.not_visible
	pop de
	scf
	ret

Script_variablesprite:
; parameters:
;     byte (SingleByteParam)
;     sprite (SingleByteParam)
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
; parameters:
;     person (SingleByteParam)
	call GetScriptByte
	call _CopyObjectStruct
	ldh a, [hMapObjectIndexBuffer]
	ld b, 0 ; clear
	jp ApplyEventActionAppearDisappear

Script_disappear:
; parameters:
;     person (SingleByteParam)
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
	jp EventFlagAction

Script_follow:
; parameters:
;     person2 (SingleByteParam)
;     person1 (SingleByteParam)
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld c, a
	farjp StartFollow

Script_stopfollow:
	farjp StopFollow

Script_moveobject:
; parameters:
;     person (SingleByteParam)
;     x (SingleByteParam)
;     y (SingleByteParam)
	call GetScriptByte
	ld b, a
	call GetScriptByte
	add 4
	ld d, a
	call GetScriptByte
	add 4
	ld e, a
	farjp CopyDECoordsToMapObject

Script_writepersonxy:
; parameters:
;     person (SingleByteParam)
	call GetScriptByte
	cp LAST_TALKED
	jr nz, .ok
	ldh a, [hLastTalked]
.ok
	ld b, a
	farjp WritePersonXY

Script_follownotexact:
; parameters:
;     person2 (SingleByteParam)
;     person1 (SingleByteParam)
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld c, a
	farjp FollowNotExact

Script_loademote:
; parameters:
;     bubble (SingleByteParam)
	call GetScriptByte
	cp -1
	jr nz, .not_var_emote
	ldh a, [hScriptVar]
.not_var_emote
	ld c, a
	farjp LoadEmote

Script_showemote:
; parameters:
;     bubble (SingleByteParam)
;     person (SingleByteParam)
;     time (DecimalParam)
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
	jp ScriptCall

ShowEmoteScript:
	loademote EMOTE_FROM_MEM
	applymovement2 .Show
	pause 0
	applymovement2 .Hide
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
; parameters:
;     param (DecimalParam)
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
	jp ScriptCall

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

Script_loadmemtrainer:
	ld a, (1 << 7) | 1
	ld [wBattleScriptFlags], a
	ld a, [wTempTrainerClass]
	ld [wOtherTrainerClass], a
	ld a, [wTempTrainerID]
	ld [wOtherTrainerID], a
	ret

Script_loadwildmon:
; parameters:
;     pokemon (PokemonParam)
;     level (DecimalParam)
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
; parameters:
;     trainer_group (TrainerGroupParam)
;     trainer_id (TrainerIdParam)
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
; parameters:
;     byte (SingleByteParam)
	call GetScriptByte
	ld [wBattleType], a
	call BufferScreen
	farcall CatchTutorial
	ld a, 1
	ld [wDontPlayMapMusicOnReload], a
	jp Script_reloadmap

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
	jp ScriptJump

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
	jp StopScript

Script_scall:
; parameters:
;     pointer (ScriptPointerLabelParam)
	ld a, [wScriptBank]
	ld b, a
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	jr ScriptCall

Script_farscall:
; parameters:
;     pointer (ScriptPointerLabelBeforeBank)
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	jr ScriptCall

Script_ptcall:
; parameters:
;     pointer (PointerLabelToScriptPointer)
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
	jp ScriptCall

Script_jump:
; parameters:
;     pointer (ScriptPointerLabelParam)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [wScriptBank]
	ld b, a
	jp ScriptJump

Script_farjump:
; parameters:
;     pointer (ScriptPointerLabelBeforeBank)
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	jp ScriptJump

Script_ptjump:
; parameters:
;     pointer (PointerLabelToScriptPointer)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld b, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp ScriptJump

Script_iffalse:
; parameters:
;     pointer (ScriptPointerLabelParam)
	ldh a, [hScriptVar]
	and a
	jp nz, SkipTwoScriptBytes
	jp Script_jump

Script_iftrue:
; parameters:
;     pointer (ScriptPointerLabelParam)
	ldh a, [hScriptVar]
	and a
	jp nz, Script_jump
	jp SkipTwoScriptBytes

Script_ifequal:
; parameters:
;     byte (SingleByteParam)
;     pointer (ScriptPointerLabelParam)
	call GetScriptByte
	ld hl, hScriptVar
	cp [hl]
	jr z, Script_jump
	jr SkipTwoScriptBytes

Script_ifnotequal:
; parameters:
;     byte (SingleByteParam)
;     pointer (ScriptPointerLabelParam)
	call GetScriptByte
	ld hl, hScriptVar
	cp [hl]
	jr nz, Script_jump
	jr SkipTwoScriptBytes

Script_ifgreater:
; parameters:
;     byte (SingleByteParam)
;     pointer (ScriptPointerLabelParam)
	ldh a, [hScriptVar]
	ld b, a
	call GetScriptByte
	cp b
	jr c, Script_jump
	jr SkipTwoScriptBytes

Script_ifless:
; parameters:
;     byte (SingleByteParam)
;     pointer (ScriptPointerLabelParam)
	call GetScriptByte
	ld b, a
	ldh a, [hScriptVar]
	cp b
	jr c, Script_jump
	jr SkipTwoScriptBytes

Script_jumpstd:
; parameters:
;     predefined_script (SingleByteParam)
	call StdScript
	jr ScriptJump

Script_callstd:
; parameters:
;     predefined_script (SingleByteParam)
	call StdScript
	ld d, h
	ld e, l
	jp ScriptCall

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
	jp GetFarHalfword

SkipTwoScriptBytes:
	call GetScriptByte
	jp GetScriptByte

ScriptJump:
	ld a, b
	ld [wScriptBank], a
	ld a, l
	ld [wScriptPos], a
	ld a, h
	ld [wScriptPos + 1], a
	ret

Script_priorityjump:
; parameters:
;     pointer (ScriptPointerLabelParam)
	ld a, [wScriptBank]
	ld [wPriorityScriptBank], a
	call GetScriptByte
	ld [wPriorityScriptAddr], a
	call GetScriptByte
	ld [wPriorityScriptAddr + 1], a
	ld hl, wScriptFlags
	set 3, [hl]
	ret

Script_checkscene:
	call CheckScenes
	jr z, _NoTriggers
	ldh [hScriptVar], a
	ret

Script_checkmapscene:
; parameters:
;     map_group (SingleByteParam)
;     map_id (SingleByteParam)
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
; parameters:
;     trigger_id (SingleByteParam)
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	jr DoTrigger

Script_setmapscene:
; parameters:
;     map_group (MapGroupParam)
;     map_id (MapIdParam)
;     trigger_id (SingleByteParam)
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

Script_copybytetovar:
; parameters:
;     address (RAMAddressParam)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [hl]
	ldh [hScriptVar], a
	ret

Script_copyvartobyte:
; parameters:
;     address (RAMAddressParam)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ldh a, [hScriptVar]
	ld [hl], a
	ret

Script_loadvar:
; parameters:
;     address (RAMAddressParam)
;     value (SingleByteParam)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	call GetScriptByte
	ld [hl], a
	ret

Script_writebyte:
; parameters:
;     value (SingleByteParam)
	call GetScriptByte
	ldh [hScriptVar], a
	ret

Script_addvar:
; parameters:
;     value (SingleByteParam)
	call GetScriptByte
	ld hl, hScriptVar
	add [hl]
	ld [hl], a
	ret

Script_random:
; parameters:
;     input (SingleByteParam)
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

Script_checkcode:
; parameters:
;     variable_id (SingleByteParam)
	call GetScriptByte
	call GetVarAction
	ld a, [de]
	ldh [hScriptVar], a
	ret

Script_writevarcode:
; parameters:
;     variable_id (SingleByteParam)
	call GetScriptByte
	call GetVarAction
	ldh a, [hScriptVar]
	ld [de], a
	ret

Script_writecode:
; parameters:
;     variable_id (SingleByteParam)
;     value (SingleByteParam)
	call GetScriptByte
	call GetVarAction
	call GetScriptByte
	ld [de], a
	ret

GetVarAction:
	ld c, a
	farjp _GetVarAction

Script_pokenamemem:
; parameters:
;     pokemon (PokemonParam); leave $0 to draw from script var
;     memory (SingleByteParam)
	call GetScriptByte
	and a
	jr nz, .gotit
	ldh a, [hScriptVar]
.gotit
	ld [wd265], a
	call GetPokemonName
	ld de, wStringBuffer1

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
	jp CopyName2

Script_itemtotext:
; parameters:
;     item (ItemLabelByte); use 0 to draw from hScriptVar
;     memory (SingleByteParam)
	call GetScriptByte
	and a
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wd265], a
	call GetItemName
	ld de, wStringBuffer1
	jr ConvertMemToText

Script_mapnametotext:
; parameters:
;     memory (SingleByteParam)
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation

ConvertLandmarkToText:
	ld e, a
	farcall GetLandmarkName
	ld de, wStringBuffer1
	jp ConvertMemToText

Script_landmarktotext:
; parameters:
;     id (SingleByteParam)
;     memory (SingleByteParam)
	call GetScriptByte
	jr ConvertLandmarkToText

Script_trainertotext:
; parameters:
;     trainer_id (TrainerGroupParam)
;     trainer_group (TrainerIdParam)
;     memory (SingleByteParam)
	call GetScriptByte
	ld c, a
	call GetScriptByte
	ld b, a
	farcall GetTrainerName
	jr ConvertMemToText

Script_name:
; parameters:
;     type (SingleByteParam)
;     id (SingleByteParam)
;     memory (SingleByteParam)
	call GetScriptByte
	ld [wNamedObjectTypeBuffer], a

ContinueToGetName:
	call GetScriptByte
	ld [wCurSpecies], a
	call GetName
	ld de, wStringBuffer1
	jp ConvertMemToText

Script_trainerclassname:
; parameters:
;     id (SingleByteParam)
;     memory (SingleByteParam)
	ld a, TRAINER_NAME
	ld [wNamedObjectTypeBuffer], a
	jr ContinueToGetName

Script_readmoney:
; parameters:
;     account (SingleByteParam)
;     memory (SingleByteParam)
	call ResetStringBuffer1
	call GetMoneyAccount
	ld hl, wStringBuffer1
	lb bc, PRINTNUM_LEFTALIGN | 3, 6
	call PrintNum
	ld de, wStringBuffer1
	jp ConvertMemToText

Script_readcoins:
; parameters:
;     memory (SingleByteParam)
	call ResetStringBuffer1
	ld hl, wStringBuffer1
	ld de, wCoins
	lb bc, PRINTNUM_LEFTALIGN | 2, 6
	call PrintNum
	ld de, wStringBuffer1
	jp ConvertMemToText

Script_RAM2MEM:
; parameters:
;     memory (SingleByteParam)
	call ResetStringBuffer1
	ld hl, wStringBuffer1
	ld de, hScriptVar
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
	call PrintNum
	ld de, wStringBuffer1
	jp ConvertMemToText

ResetStringBuffer1:
	ld hl, wStringBuffer1
	ld bc, NAME_LENGTH
	ld a, "@"
	rst ByteFill
	ret

Script_stringtotext:
; parameters:
;     text_pointer (EncodedTextLabelParam)
;     memory (SingleByteParam)
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld a, [wScriptBank]
	ld hl, CopyName1
	call FarCall_hl
	ld de, wStringBuffer2
	jp ConvertMemToText

Script_givepokeitem:
; parameters:
;     pointer (PointerParamToItemAndLetter)
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

Script_checkpokeitem:
; parameters:
;     pointer (PointerParamToItemAndLetter)
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld a, [wScriptBank]
	ld b, a
	farjp CheckPokeItem

Script_giveitem:
; parameters:
;     item (ItemLabelByte)
;     quantity (SingleByteParam)
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
; parameters:
;     item (ItemLabelByte)
;     quantity (DecimalParam)
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
; parameters:
;     item (ItemLabelByte)
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
; parameters:
;     account (SingleByteParam)
;     money (MoneyByteParam)
	call GetMoneyAccount
	call LoadMoneyAmountToMem
	farjp GiveMoney

Script_takemoney:
; parameters:
;     account (SingleByteParam)
;     money (MoneyByteParam)
	call GetMoneyAccount
	call LoadMoneyAmountToMem
	farjp TakeMoney

Script_checkmoney:
; parameters:
;     account (SingleByteParam)
;     money (MoneyByteParam)
	call GetMoneyAccount
	call LoadMoneyAmountToMem
	farcall CompareMoney

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
; parameters:
;     coins (CoinByteParam)
	call LoadCoinAmountToMem
	farjp GiveCoins

Script_takecoins:
; parameters:
;     coins (CoinByteParam)
	call LoadCoinAmountToMem
	farjp TakeCoins

Script_checkcoins:
; parameters:
;     coins (CoinByteParam)
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
; parameters:
;     time (SingleByteParam)
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
; parameters:
;     pkmn (PokemonParam)
	xor a
	ldh [hScriptVar], a
	call GetScriptByte
	ld hl, wPartySpecies
	ld de, 1
	call IsInArray
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
; parameters:
;     person (SingleByteParam)
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
; parameters:
;     person (SingleByteParam)
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
; parameters:
;     person (SingleByteParam)
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
; parameters:
;     call_id (SingleByteParam)
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
; parameters:
;     pokemon (PokemonParam)
;     form (DecimalParam)
;     level (DecimalParam)
;     item (ItemLabelByte)
;     trainer (DecimalParam)
;     trainer_name_pointer (MultiByteParam)
;     pkmn_nickname (MultiByteParam)
	call GetScriptByte
	ld [wCurPartySpecies], a
	call GetScriptByte
	ld [wCurForm], a
	call GetScriptByte
	ld [wCurPartyLevel], a
	call GetScriptByte
	ld [wCurItem], a
	call GetScriptByte
	and a
	ld b, a
	jr z, .ok
	ld hl, wScriptPos
	ld e, [hl]
	inc hl
	ld d, [hl]
	call GetScriptByte
	call GetScriptByte
	call GetScriptByte
	call GetScriptByte
.ok
	farcall GivePoke
	ld a, b
	ldh [hScriptVar], a
	ret

Script_giveegg:
; parameters:
;     pkmn (PokemonParam)
;     form (DecimalParam)
;     level (DecimalParam)
; if no room in the party, return 0 in hScriptVar; else, return 2

	xor a ; PARTYMON
	ldh [hScriptVar], a
	ld [wMonType], a
	call GetScriptByte
	ld [wCurPartySpecies], a
	call GetScriptByte
	ld [wCurForm], a
	call GetScriptByte
	ld [wCurPartyLevel], a
	farcall GiveEgg
	ret nc
	ld a, 2
	ldh [hScriptVar], a
	ret

Script_setevent:
; parameters:
;     bit_number (MultiByteParam)
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld b, SET_FLAG
	jp EventFlagAction

Script_clearevent:
; parameters:
;     bit_number (MultiByteParam)
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld b, RESET_FLAG
	jp EventFlagAction

Script_checkevent:
; parameters:
;     bit_number (MultiByteParam)
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
; parameters:
;     bit_number (MultiByteParam)
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld b, SET_FLAG
	jp _EngineFlagAction

Script_clearflag:
; parameters:
;     bit_number (MultiByteParam)
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld b, RESET_FLAG
	jp _EngineFlagAction

Script_checkflag:
; parameters:
;     bit_number (MultiByteParam)
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

_EngineFlagAction:
	farjp EngineFlagAction

Script_wildoff:
	ld hl, wStatusFlags
	set 5, [hl] ; wild encounters on/off
	ret

Script_wildon:
	ld hl, wStatusFlags
	res 5, [hl] ; wild encounters on/off
	ret

Script_warpfacing:
; parameters:
;     facing (SingleByteParam)
;     map_group (MapGroupParam)
;     map_id (MapIdParam)
;     x (SingleByteParam)
;     y (SingleByteParam)
	call GetScriptByte
	and $3
	ld c, a
	ld a, [wPlayerSpriteSetupFlags]
	set 5, a
	or c
	ld [wPlayerSpriteSetupFlags], a
; fall through

Script_warp:
; parameters:
;     map_group (MapGroupParam)
;     map_id (MapIdParam)
;     x (SingleByteParam)
;     y (SingleByteParam)
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
	jp StopScript

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
	jp StopScript

Script_warpmod:
; parameters:
;     warp_id (SingleByteParam)
;     map_group (MapGroupParam)
;     map_id (MapIdParam)
	call GetScriptByte
	ld [wBackupWarpNumber], a
	call GetScriptByte
	ld [wBackupMapGroup], a
	call GetScriptByte
	ld [wBackupMapNumber], a
	ret

Script_blackoutmod:
; parameters:
;     map_group (MapGroupParam)
;     map_id (MapIdParam)
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
; parameters:
;     stonetable_pointer (MultiByteParam)
	call GetScriptByte
	ld [wStoneTableAddress], a
	call GetScriptByte
	ld [wStoneTableAddress+1], a
	ret

Script_changemap:
; parameters:
;     map_data_pointer (MapDataPointerParam)
	call GetScriptByte
	ld [wMapBlocksBank], a
	call GetScriptByte
	ld [wMapBlocksPointer], a
	call GetScriptByte
	ld [wMapBlocksPointer + 1], a
	call ChangeMap
	jp BufferScreen

Script_changeblock:
; parameters:
;     x (SingleByteParam)
;     y (SingleByteParam)
;     block (SingleByteParam)
	call GetScriptByte
	add 4
	ld d, a
	call GetScriptByte
	add 4
	ld e, a
	call GetBlockLocation
	call GetScriptByte
	ld [hl], a
	jp BufferScreen

Script_reloadmappart::
	xor a
	ldh [hBGMapMode], a
	call LoadMapPart
	call GetMovementPermissions
	farcall ReloadMapPart
	jp UpdateSprites

Script_warpcheck:
	call WarpCheck
	ret nc
	jp EnableEvents

Script_newloadmap:
; parameters:
;     which_method (SingleByteParam)
	call GetScriptByte
	ldh [hMapEntryMethod], a
	ld a, 1
	ld [wMapStatus], a
	jp StopScript

Script_reloadandreturn:
	call Script_newloadmap
	jp Script_end

Script_showtextfaceplayer:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call Script_faceplayer
; fallthrough

Script_showtext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call Script_opentext
	call Script_writetext
	call Script_waitbutton
; fallthrough

Script_closetext:
	call BGMapAnchorTopLeft
	jp CloseText

Script_passtoengine:
; parameters:
;     data_pointer (PointerLabelBeforeBank)
	call GetScriptByte
	push af
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	pop af
	jp StartAutoInput

Script_pause:
; parameters:
;     length (DecimalParam)
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
; parameters:
;     time (SingleByteParam)
	call GetScriptByte
	and a
	jr z, .no_time
	ld [wScriptDelay], a
.no_time
	ld a, SCRIPT_WAIT
	ld [wScriptMode], a
	jp StopScript

Script_ptpriorityjump:
; parameters:
;     pointer (ScriptPointerLabelParam)
	call StopScript
	jp Script_jump

Script_end:
	call ExitScriptSubroutine
	ret nc
	xor a
	ld [wScriptRunning], a
	ld a, SCRIPT_OFF
	ld [wScriptMode], a
	ld hl, wScriptFlags
	res 0, [hl]
	jp StopScript

Script_return:
	call ExitScriptSubroutine
	ld hl, wScriptFlags
	res 0, [hl]
	jp StopScript

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
	jp StopScript

Script_halloffame:
	ld hl, wGameTimerPause
	res 0, [hl]
	farcall HallOfFame
	ld hl, wGameTimerPause
	set 0, [hl]
	jr ReturnFromCredits

Script_credits:
	farcall LeafCredits
ReturnFromCredits:
	call Script_endall
	ld a, 3
	ld [wMapStatus], a
	jp StopScript

Script_wait:
; parameters:
;     unknown (SingleByteParam)
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

Script_check_save:
	farcall CheckSave
	ld a, c
	ldh [hScriptVar], a
	ret

Script_count_seen_caught:
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
; parameters:
;     trainer (TrainerParam)
	call GetScriptByte
	and a
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wTrainerClass], a
	farjp Trainerpic

Script_givetmhm:
; parameters:
;     tmhm (TMHMLabelByte)
	call GetScriptByte
	ld [wCurTMHM], a
	call ReceiveTMHM
	ld a, TRUE
	ldh [hScriptVar], a
	ret

Script_checktmhm:
; parameters:
;     tmhm (TMHMLabelByte)
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
; parameters:
;     tmhm (TMHMLabelByte)
	call Script_givetmhm
	call CurTMHMName
	ld de, wStringBuffer1
	ld a, 1
	call CopyConvertedText
	ld b, BANK(GiveTMHMScript)
	ld de, GiveTMHMScript
	jp ScriptCall

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
	jp MapTextbox

Script_tmhmtotext:
; parameters:
;     tmhm (TMHMLabelByte); use 0 to draw from hScriptVar
;     memory (SingleByteParam)
	call GetScriptByte
	and a
	jr nz, .ok
	ldh a, [hScriptVar]
.ok
	ld [wd265], a
	call GetTMHMName
	ld de, wStringBuffer1
	call ConvertMemToText

	; off by one error?
	ld a, [wd265]
	inc a
	ld [wd265], a

	predef GetTMHMMove
	ld a, [wd265]
	ld [wPutativeTMHMMove], a
	call GetMoveName

	ld hl, wStringBuffer3 + 4 ; assume all TM names are 4 characters, "TM##"
	ld a, " "
	ld [hli], a
	jp CopyName2

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
	jp LoadStandardFont

Script_restoretypeface:
	ld a, [wOptionsBuffer]
	ld [wOptions2], a
	xor a
	ld [wOptionsBuffer], a
	jp LoadStandardFont

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
	jp Script_end

Script_showcrytext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
;     cry_id (SingleByteParam)
	call Script_opentext
	call Script_writetext
	call Script_cry
	call Script_waitbutton
	jp Script_closetext

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
; parameters:
;     apricorn (SingleByteParam)
;     quantity (SingleByteParam)
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
; parameters:
;     painting (PaintingParam)
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
	jp ScriptCall

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
	jp MapTextbox
