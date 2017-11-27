; Event scripting commands.

EnableScriptMode::
	push af
	ld a, SCRIPT_READ
	ld [ScriptMode], a
	pop af
	ret

ScriptEvents::
	call StartScript
.loop
	ld a, [ScriptMode]
	ld hl, .modes
	rst JumpTable
	call CheckScript
	jr nz, .loop
	ret

.modes
	dw EndScript
	dw RunScriptCommand
	dw WaitScriptMovement
	dw WaitScript

EndScript:
	jp StopScript

WaitScript:
	call StopScript

	ld hl, ScriptDelay
	dec [hl]
	ret nz

	farcall Function58b9

	ld a, SCRIPT_READ
	ld [ScriptMode], a
	jp StartScript

WaitScriptMovement:
	call StopScript

	ld hl, VramState
	bit 7, [hl]
	ret nz

	farcall Function58b9

	ld a, SCRIPT_READ
	ld [ScriptMode], a
	jp StartScript

RunScriptCommand:
	call GetScriptByte
	ld hl, ScriptCommandTable
	rst JumpTable
	ret


ScriptCommandTable:
	dw Script_scall                      ; 00
	dw Script_farscall                   ; 01
	dw Script_ptcall                     ; 02
	dw Script_jump                       ; 03
	dw Script_farjump                    ; 04
	dw Script_ptjump                     ; 05
	dw Script_if_equal                   ; 06
	dw Script_if_not_equal               ; 07
	dw Script_iffalse                    ; 08
	dw Script_iftrue                     ; 09
	dw Script_if_greater_than            ; 0a
	dw Script_if_less_than               ; 0b
	dw Script_jumpstd                    ; 0c
	dw Script_callstd                    ; 0d
	dw Script_callasm                    ; 0e
	dw Script_special                    ; 0f
	dw Script_ptcallasm                  ; 10
	dw Script_checkmaptriggers           ; 11
	dw Script_domaptrigger               ; 12
	dw Script_checktriggers              ; 13
	dw Script_dotrigger                  ; 14
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
	dw Script_textbox                    ; 45
	dw Script_refreshscreen              ; 46
	dw Script_closetext                  ; 47
	dw Script_farwritetext               ; 48
	dw Script_writetext                  ; 49
	dw Script_repeattext                 ; 4a
	dw Script_yesorno                    ; 4b
	dw Script_loadmenudata               ; 4c
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
	dw Script_faceperson                 ; 68
	dw Script_variablesprite             ; 69
	dw Script_disappear                  ; 6a
	dw Script_appear                     ; 6b
	dw Script_follow                     ; 6c
	dw Script_stopfollow                 ; 6d
	dw Script_moveperson                 ; 6e
	dw Script_writepersonxy              ; 6f
	dw Script_loademote                  ; 70
	dw Script_showemote                  ; 71
	dw Script_spriteface                 ; 72
	dw Script_follownotexact             ; 73
	dw Script_earthquake                 ; 74
	dw Script_changemap                  ; 75
	dw Script_changeblock                ; 76
	dw Script_reloadmap                  ; 77
	dw Script_reloadmappart              ; 78
	dw Script_writecmdqueue              ; 79
	dw Script_delcmdqueue                ; 7a
	dw Script_playmusic                  ; 7b
	dw Script_encountermusic             ; 7c
	dw Script_musicfadeout               ; 7d
	dw Script_playmapmusic               ; 7e
	dw Script_dontrestartmapmusic        ; 7f
	dw Script_cry                        ; 80
	dw Script_playsound                  ; 81
	dw Script_waitsfx                    ; 82
	dw Script_warpsound                  ; 83
	dw Script_specialsound               ; 84
	dw Script_passtoengine               ; 85
	dw Script_newloadmap                 ; 86
	dw Script_pause                      ; 87
	dw Script_deactivatefacing           ; 88
	dw Script_priorityjump               ; 89
	dw Script_warpcheck                  ; 8a
	dw Script_ptpriorityjump             ; 8b
	dw Script_return                     ; 8c
	dw Script_end                        ; 8d
	dw Script_reloadandreturn            ; 8e
	dw Script_end_all                    ; 8f
	dw Script_pokemart                   ; 90
	dw Script_elevator                   ; 91
	dw Script_trade                      ; 92
	dw Script_askforphonenumber          ; 93
	dw Script_phonecall                  ; 94
	dw Script_hangup                     ; 95
	dw Script_describedecoration         ; 96
	dw Script_fruittree                  ; 97
	dw Script_specialphonecall           ; 98
	dw Script_checkphonecall             ; 99
	dw Script_verbosegiveitem            ; 9a
	dw Script_verbosegiveitem2           ; 9b
	dw Script_swarm                      ; 9c
	dw Script_halloffame                 ; 9d
	dw Script_credits                    ; 9e
	dw Script_warpfacing                 ; 9f
	dw Script_battletowertext            ; a0
	dw Script_landmarktotext             ; a1
	dw Script_trainerclassname           ; a2
	dw Script_name                       ; a3
	dw Script_wait                       ; a4
	dw Script_check_save                 ; a5
	dw Script_count_seen_caught          ; a6
	dw Script_trainerpic                 ; a7
	dw Script_givetmhm                   ; a8
	dw Script_checktmhm                  ; a9
	dw Script_verbosegivetmhm            ; aa
	dw Script_tmhmnotify                 ; ab
	dw Script_tmhmtotext                 ; ac
	dw Script_checkdarkness              ; ad
	dw Script_checkunits                 ; ae
	dw Script_unowntypeface              ; af
	dw Script_restoretypeface            ; b0
	dw Script_jumpstashedtext            ; b1
	dw Script_jumpopenedtext             ; b2
	dw Script_iftrue_jumptext            ; b3
	dw Script_iffalse_jumptext           ; b4
	dw Script_iftrue_jumptextfaceplayer  ; b5
	dw Script_iffalse_jumptextfaceplayer ; b6
	dw Script_iftrue_jumpopenedtext      ; b7
	dw Script_iffalse_jumpopenedtext     ; b8
	dw Script_thistext                   ; b9
	dw Script_thistextfaceplayer         ; ba
	dw Script_thisopenedtext             ; bb
	dw Script_showtext                   ; bc
	dw Script_showtextfaceplayer         ; bd
	dw Script_applyonemovement           ; be
	dw Script_showcrytext                ; bf
	dw Script_endtext                    ; c0
	dw Script_waitendtext                ; c1
	dw Script_iftrue_endtext             ; c2
	dw Script_iffalse_endtext            ; c3
	dw Script_loadgrottomon              ; c4

StartScript:
	ld hl, ScriptFlags
	set SCRIPT_RUNNING, [hl]
	ret

CheckScript:
	ld hl, ScriptFlags
	bit SCRIPT_RUNNING, [hl]
	ret

StopScript:
	ld hl, ScriptFlags
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
	ld a, [ScriptVar]
	and a
	jr nz, Script_jumptextfaceplayer
	jp SkipTwoScriptBytes

Script_iffalse_jumptextfaceplayer:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ld a, [ScriptVar]
	and a
	jp nz, SkipTwoScriptBytes
; fallthrough

Script_jumptextfaceplayer:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call _GetTextPointer
	jr _Do_textfaceplayer

Script_thistextfaceplayer:
	call _GetThisTextPointer
_Do_textfaceplayer:
	ld b, BANK(JumpTextFacePlayerScript)
	ld hl, JumpTextFacePlayerScript
	jp ScriptJump

Script_iftrue_jumptext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ld a, [ScriptVar]
	and a
	jr nz, Script_jumptext
	jp SkipTwoScriptBytes

Script_iffalse_jumptext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ld a, [ScriptVar]
	and a
	jp nz, SkipTwoScriptBytes
; fallthrough

Script_jumptext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call _GetTextPointer
	jr _Do_jumptext

Script_thistext:
	call _GetThisTextPointer
_Do_jumptext:
	ld b, BANK(JumpTextScript)
	ld hl, JumpTextScript
	jp ScriptJump

Script_iftrue_jumpopenedtext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ld a, [ScriptVar]
	and a
	jr nz, Script_jumpopenedtext
	jp SkipTwoScriptBytes

Script_iffalse_jumpopenedtext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	ld a, [ScriptVar]
	and a
	jp nz, SkipTwoScriptBytes
; fallthrough

Script_jumpopenedtext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call _GetTextPointer
	jr _Do_jumpopenedtext

Script_thisopenedtext:
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
	ld a, [ScriptBank]
	ld [wScriptTextBank], a
	call GetScriptByte
	ld [wScriptTextAddr], a
	call GetScriptByte
	ld [wScriptTextAddr + 1], a
	ret

_GetThisTextPointer:
	ld a, [ScriptBank]
	ld [wScriptTextBank], a
	ld a, [ScriptPos]
	ld [wScriptTextAddr], a
	ld a, [ScriptPos + 1]
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
	ld a, [ScriptBank]
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
	ld a, [ScriptBank]
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

Script_waitbutton:
	jp WaitButton

Script_buttonsound:
	ld a, [hOAMUpdate]
	push af
	ld a, $1
	ld [hOAMUpdate], a
	call WaitBGMap
	call ButtonSound
	pop af
	ld [hOAMUpdate], a
	ret

Script_yesorno:
	call YesNoBox
	ld a, FALSE
	jr c, .no
	ld a, TRUE
.no
	ld [ScriptVar], a
	ret

Script_loadmenudata:
; parameters:
;     data (MenuDataPointerParam)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld de, LoadMenuDataHeader
	ld a, [ScriptBank]
	call Call_a_de
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
	ld a, [ScriptVar]
.ok
	ld [CurPartySpecies], a
	call GetScriptByte
	ld [IsCurMonInParty], a
	farjp Pokepic

Script_closepokepic:
	farjp ClosePokepic

Script_verticalmenu:
	ld a, [ScriptBank]
	ld hl, VerticalMenu
	call FarCall_hl
	ld a, [wMenuCursorY]
	jr nc, .ok
	xor a
.ok
	ld [ScriptVar], a
	ret

Script__2dmenu:
	ld a, [ScriptBank]
	ld hl, _2DMenu
	call FarCall_hl
	ld a, [wMenuCursorBuffer]
	jr nc, .ok
	xor a
.ok
	ld [ScriptVar], a
	ret

Script_battletowertext:
; parameters:
;     pointer (PointerLabelBeforeBank)
;     memory (SingleByteParam)
	call SetUpTextBox
	call GetScriptByte
	ld c, a
	farjp BattleTowerText

Script_verbosegiveitem:
; parameters:
;     item (ItemLabelByte)
;     quantity (DecimalParam)
	call Script_giveitem
	call CurItemName
	ld de, StringBuffer1
	ld a, 1
	call CopyConvertedText
	ld b, BANK(GiveItemScript)
	ld de, GiveItemScript
	jp ScriptCall

GiveItemScript:
	writetext ReceivedItemText
	iffalse .Full
	waitsfx
	specialsound
	waitbutton
	itemnotify
	end

.Full:
	buttonsound
	pocketisfull
	end

ReceivedItemText:
	text_jump UnknownText_0x1c4719
	db "@"

Script_verbosegiveitem2:
; parameters:
;     item (ItemLabelByte)
;     var (SingleByteParam)
	call GetScriptByte
	cp -1
	jr nz, .ok
	ld a, [ScriptVar]
.ok
	ld [CurItem], a
	call GetScriptByte
	call GetVarAction
	ld a, [de]
	ld [wItemQuantityChangeBuffer], a
	ld hl, NumItems
	call ReceiveItem
	ld a, TRUE
	jr c, .ok2
	xor a
.ok2
	ld [ScriptVar], a
	call CurItemName
	ld de, StringBuffer1
	ld a, 1
	call CopyConvertedText
	ld b, BANK(GiveItemScript)
	ld de, GiveItemScript
	jp ScriptCall

Script_itemnotify:
	call GetPocketName
	call CurItemName
	ld b, BANK(PutItemInPocketText)
	ld hl, PutItemInPocketText
	jp MapTextbox

Script_pocketisfull:
	call GetPocketName
	call CurItemName
	ld b, BANK(PocketIsFullText)
	ld hl, PocketIsFullText
	jp MapTextbox

Script_specialsound:
	farcall CheckItemPocket
	ld a, [wItemAttributeParamBuffer]
	cp TM_HM
	ld de, SFX_GET_TM
	jr z, .play
	ld de, SFX_ITEM
.play
	call PlaySFX
	jp WaitSFX

GetPocketName:
	farcall CheckItemPocket
	ld a, [wItemAttributeParamBuffer]
	dec a
	ld hl, .Pockets
	and $7
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, StringBuffer3
	jp CopyName2

.Pockets:
	dw .Item
	dw .Medicine
	dw .Ball
	dw .TM ; impossible
	dw .Berry
	dw .Key

.Item:
	db "Item Pocket@"
.Medicine:
	db "Med.Pocket@"
.Ball:
	db "Ball Pocket@"
.TM:
	db "TM Pocket@"
.Berry:
	db "Berry Pocket@"
.Key:
	db "Key Pocket@"

GetTMHMPocketName:
	ld hl, .TMHMPocket
	ld d, h
	ld e, l
	ld hl, StringBuffer3
	jp CopyName2

.TMHMPocket:
	db "TM Pocket@"

CurItemName:
	ld a, [CurItem]
	ld [wd265], a
	jp GetItemName

CurTMHMName:
	ld a, [CurTMHM]
	ld [wd265], a
	jp GetTMHMName

PutItemInPocketText:
	text_jump UnknownText_0x1c472c
	db "@"

PocketIsFullText:
	text_jump UnknownText_0x1c474b
	db "@"

Script_pokemart:
; parameters:
;     dialog_id (SingleByteParam)
;     mart_id (SingleByteParam)
	call Script_faceplayer
	call Script_textbox
	call GetScriptByte
	ld c, a
	call GetScriptByte
	ld e, a
	ld d, 0
	ld a, [ScriptBank]
	ld b, a
	farcall OpenMartDialog
	jp Script_endtext

Script_elevator:
; parameters:
;     floor_list_pointer (PointerLabelParam)
	xor a
	ld [ScriptVar], a
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld a, [ScriptBank]
	ld b, a
	farcall Elevator
	ret c
	ld a, TRUE
	ld [ScriptVar], a
	ret

Script_trade:
; parameters:
;     trade_id (SingleByteParam)
	call Script_faceplayer
	call Script_textbox
	call GetScriptByte
	ld e, a
	farcall NPCTrade
	jp Script_waitendtext

Script_phonecall:
; parameters:
;     caller_name (RawTextPointerLabelParam)
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld a, [ScriptBank]
	ld b, a
	farjp PhoneCall

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
	ld [ScriptVar], a
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
	ld [CurFruitTree], a
	call GetScriptByte
	ld [CurFruit], a
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
	ld hl, WalkingX
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [EngineBuffer1]
	ld b, a
	jp MapTextbox

Script_scripttalkafter:
	ld hl, wScriptAfterPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [EngineBuffer1]
	ld b, a
	jp ScriptJump

Script_trainerflagaction:
; parameters:
;     action (SingleByteParam)
	xor a
	ld [ScriptVar], a
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
	ld [ScriptVar], a
	ret

Script_winlosstext:
; parameters:
;     win_text_pointer (TextPointerLabelParam)
;     loss_text_pointer (TextPointerLabelParam)
	ld hl, wWinTextPointer ; d047
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
	ld [ScriptVar], a
	ld a, [wRunningTrainerBattleScript]
	and a
	ret nz
	xor a
	ld [ScriptVar], a
	ret

Script_encountermusic:
	ld a, [OtherTrainerClass]
	ld e, a
	farjp PlayTrainerEncounterMusic

Script_playmapmusic:
	jp PlayMapMusic

Script_playmusic:
; parameters:
;     music_pointer (SingleByteParam)
	ld de, MUSIC_NONE
	call PlayMusic
	xor a
	ld [MusicFade], a
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
	ld [MusicFadeID], a
	xor a
	ld [MusicFadeID + 1], a
	call GetScriptByte
	and $7f
	ld [MusicFade], a
	ret

Script_playsound:
; parameters:
;     sound_pointer (SingleByteParam)
	call GetScriptByte
	ld e, a
	ld d, 0
	jp PlaySFX

Script_waitsfx:
	jp WaitSFX

Script_warpsound:
	ld a, [PlayerStandingTile]
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
	ld a, [ScriptVar]
.ok
	jp PlayCry

Script_setlasttalked:
; parameters:
;     person (SingleByteParam)
	call GetScriptByte
	ld [hLastTalked], a
	ret

Script_applyonemovement:
; parameters:
;     person (SingleByteParam)
;     data (MovementDataParam)
	call GetScriptByte
	ld c, a

	push bc
	ld a, c
	farcall SetFlagsForMovement_1
	pop bc

	push bc
	farcall SetFlagsForMovement_2
	pop bc

	ld a, [ScriptPos]
	ld l, a
	ld a, [ScriptPos + 1]
	ld h, a
	call SkipTwoScriptBytes
	ld a, [ScriptBank]
	ld b, a
	call GetMovementData
	ret c

	ld a, SCRIPT_WAIT_MOVEMENT
	ld [ScriptMode], a
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
	ld a, [hLastTalked]
	ld c, a
; fallthrough

ApplyMovement:
	push bc
	ld a, c
	farcall SetFlagsForMovement_1
	pop bc

	push bc
	farcall SetFlagsForMovement_2
	pop bc

	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [ScriptBank]
	ld b, a
	call GetMovementData
	ret c

	ld a, SCRIPT_WAIT_MOVEMENT
	ld [ScriptMode], a
	jp StopScript

Script_faceplayer:
	ld a, [hLastTalked]
	and a
	ret z
	ld d, $0
	ld a, [hLastTalked]
	ld e, a
	farcall GetRelativeFacing
	ld a, d
	add a
	add a
	ld e, a
	ld a, [hLastTalked]
	ld d, a
	jr ApplyPersonFacing

Script_faceperson:
; parameters:
;     person1 (SingleByteParam)
;     person2 (SingleByteParam)
	call GetScriptByte
	cp LAST_TALKED
	jr c, .ok
	ld a, [hLastTalked]
.ok
	ld e, a
	call GetScriptByte
	cp LAST_TALKED
	jr nz, .ok2
	ld a, [hLastTalked]
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

Script_spriteface:
; parameters:
;     person (SingleByteParam)
;     facing (SingleByteParam)
	call GetScriptByte
	cp LAST_TALKED
	jr nz, .ok
	ld a, [hLastTalked]
.ok
	ld d, a
	call GetScriptByte
	add a
	add a
	ld e, a
	; fallthrough

ApplyPersonFacing:
	ld a, d
	push de
	call CheckObjectVisibility
	jr c, .not_visible
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	push bc
	call DoesSpriteHaveFacings
	pop bc
	jr c, .not_visible ; STILL_SPRITE
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit FIXED_FACING, [hl]
	jr nz, .not_visible
	pop de
	ld a, e
	call SetSpriteDirection
	ld hl, VramState
	bit 6, [hl]
	jr nz, .text_state
	call .DisableTextTiles
.text_state
	jp UpdateSprites

.not_visible
	pop de
	scf
	ret

.DisableTextTiles:
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
	ret

Script_variablesprite:
; parameters:
;     byte (SingleByteParam)
;     sprite (SingleByteParam)
	call GetScriptByte
	ld e, a
	ld d, $0
	ld hl, VariableSprites
	add hl, de
	call GetScriptByte
	ld [hl], a
	ret

Script_appear:
; parameters:
;     person (SingleByteParam)
	call GetScriptByte
	call _CopyObjectStruct
	ld a, [hMapObjectIndexBuffer]
	ld b, 0 ; clear
	jp ApplyEventActionAppearDisappear

Script_disappear:
; parameters:
;     person (SingleByteParam)
	call GetScriptByte
	cp LAST_TALKED
	jr nz, .ok
	ld a, [hLastTalked]
.ok
	call DeleteObjectStruct
	ld a, [hMapObjectIndexBuffer]
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

Script_moveperson:
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
	ld a, [hLastTalked]
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
	ld a, [ScriptVar]
.not_var_emote
	ld c, a
	farjp LoadEmote

Script_showemote:
; parameters:
;     bubble (SingleByteParam)
;     person (SingleByteParam)
;     time (DecimalParam)
	call GetScriptByte
	ld [ScriptVar], a
	call GetScriptByte
	cp LAST_TALKED
	jr z, .ok
	ld [hLastTalked], a
.ok
	call GetScriptByte
	ld [ScriptDelay], a
	ld b, BANK(ShowEmoteScript)
	ld de, ShowEmoteScript
	jp ScriptCall

ShowEmoteScript:
	loademote EMOTE_MEM
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
	call CopyBytes
	call GetScriptByte
	ld [wEarthquakeMovementDataBuffer + 1], a
	and %111111
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
EarthquakeMovementEnd

Script_randomwildmon:
	xor a
	ld [wBattleScriptFlags], a
	ret

Script_loadmemtrainer:
	ld a, (1 << 7) | 1
	ld [wBattleScriptFlags], a
	ld a, [wTempTrainerClass]
	ld [OtherTrainerClass], a
	ld a, [wTempTrainerID]
	ld [OtherTrainerID], a
	ret

Script_loadwildmon:
; parameters:
;     pokemon (PokemonParam)
;     level (DecimalParam)
	ld a, (1 << 7)
	ld [wBattleScriptFlags], a
	call GetScriptByte
	ld [TempWildMonSpecies], a
	call GetScriptByte
	ld [CurPartyLevel], a
	ret

Script_loadtrainer:
; parameters:
;     trainer_group (TrainerGroupParam)
;     trainer_id (TrainerIdParam)
	ld a, (1 << 7) | 1
	ld [wBattleScriptFlags], a
	call GetScriptByte
	ld [OtherTrainerClass], a
	call GetScriptByte
	ld [OtherTrainerID], a
	ret

Script_startbattle:
	call BufferScreen
	predef StartBattle
	ld a, [wBattleResult]
	and $3f
	ld [ScriptVar], a
	ret

Script_catchtutorial:
; parameters:
;     byte (SingleByteParam)
	call GetScriptByte
	ld [BattleType], a
	call BufferScreen
	farcall CatchTutorial
	ld a, 1
	ld [wDontPlayMapMusicOnReload], a
	jp Script_reloadmap

Script_reloadmapafterbattle:
	push bc
	push de
	call RestoreBattleItems
	pop de
	pop bc
	ld hl, wBattleScriptFlags
	ld d, [hl]
	ld [hl], $0
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
	farcall RemoveToxicAfterBattle
	jr .done

.was_wild
	ld a, [wBattleResult]
	bit 1, a ; set on fleeing
	jr nz, .skip_pickup
	farcall RunPostBattleAbilities
	farcall RemoveToxicAfterBattle
.skip_pickup
	ld a, [wBattleResult]
	bit 7, a
	jr z, .done
	ld b, BANK(Script_SpecialBillCall)
	ld de, Script_SpecialBillCall
	farcall LoadScriptBDE
.done
; fallthrough

Script_reloadmap:
	xor a
	ld [wBattleScriptFlags], a
	ld a, MAPSETUP_RELOADMAP
	ld [hMapEntryMethod], a
	ld a, $1
	call LoadMapStatus
	jp StopScript

Script_scall:
; parameters:
;     pointer (ScriptPointerLabelParam)
	ld a, [ScriptBank]
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
; to ScriptDelay, causing the script to return to the rst/interrupt
; space.

	push de
	ld hl, wScriptStackSize
	ld e, [hl]
	inc [hl]
	ld d, $0
	ld hl, wScriptStack
rept 3
	add hl, de
endr
	pop de
	ld a, [ScriptBank]
	ld [hli], a
	ld a, [ScriptPos]
	ld [hli], a
	ld a, [ScriptPos + 1]
	ld [hl], a
	ld a, b
	ld [ScriptBank], a
	ld a, e
	ld [ScriptPos], a
	ld a, d
	ld [ScriptPos + 1], a
	ret

CallCallback::
	ld a, [ScriptBank]
	or $80
	ld [ScriptBank], a
	jp ScriptCall

Script_jump:
; parameters:
;     pointer (ScriptPointerLabelParam)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [ScriptBank]
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
	ld a, [ScriptVar]
	and a
	jp nz, SkipTwoScriptBytes
	jp Script_jump

Script_iftrue:
; parameters:
;     pointer (ScriptPointerLabelParam)
	ld a, [ScriptVar]
	and a
	jp nz, Script_jump
	jp SkipTwoScriptBytes

Script_if_equal:
; parameters:
;     byte (SingleByteParam)
;     pointer (ScriptPointerLabelParam)
	call GetScriptByte
	ld hl, ScriptVar
	cp [hl]
	jr z, Script_jump
	jr SkipTwoScriptBytes

Script_if_not_equal:
; parameters:
;     byte (SingleByteParam)
;     pointer (ScriptPointerLabelParam)
	call GetScriptByte
	ld hl, ScriptVar
	cp [hl]
	jr nz, Script_jump
	jr SkipTwoScriptBytes

Script_if_greater_than:
; parameters:
;     byte (SingleByteParam)
;     pointer (ScriptPointerLabelParam)
	ld a, [ScriptVar]
	ld b, a
	call GetScriptByte
	cp b
	jr c, Script_jump
	jr SkipTwoScriptBytes

Script_if_less_than:
; parameters:
;     byte (SingleByteParam)
;     pointer (ScriptPointerLabelParam)
	call GetScriptByte
	ld b, a
	ld a, [ScriptVar]
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
rept 3
	add hl, de
endr
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
	ld [ScriptBank], a
	ld a, l
	ld [ScriptPos], a
	ld a, h
	ld [ScriptPos + 1], a
	ret

Script_priorityjump:
; parameters:
;     pointer (ScriptPointerLabelParam)
	ld a, [ScriptBank]
	ld [wPriorityScriptBank], a
	call GetScriptByte
	ld [wPriorityScriptAddr], a
	call GetScriptByte
	ld [wPriorityScriptAddr + 1], a
	ld hl, ScriptFlags
	set 3, [hl]
	ret

Script_checktriggers:
	call CheckTriggers
	jr z, .no_triggers
	ld [ScriptVar], a
	ret

.no_triggers
	ld a, $ff
	ld [ScriptVar], a
	ret

Script_checkmaptriggers:
; parameters:
;     map_group (SingleByteParam)
;     map_id (SingleByteParam)
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld c, a
	call GetMapTrigger
	ld a, d
	or e
	jr z, .no_triggers
	ld a, [de]
	ld [ScriptVar], a
	ret

.no_triggers
	ld a, $ff
	ld [ScriptVar], a
	ret

Script_dotrigger:
; parameters:
;     trigger_id (SingleByteParam)
	ld a, [MapGroup]
	ld b, a
	ld a, [MapNumber]
	ld c, a
	jr DoTrigger

Script_domaptrigger:
; parameters:
;     map_group (MapGroupParam)
;     map_id (MapIdParam)
;     trigger_id (SingleByteParam)
	call GetScriptByte
	ld b, a
	call GetScriptByte
	ld c, a
DoTrigger:
	call GetMapTrigger
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
	ld [ScriptVar], a
	ret

Script_copyvartobyte:
; parameters:
;     address (RAMAddressParam)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [ScriptVar]
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
	ld [ScriptVar], a
	ret

Script_addvar:
; parameters:
;     value (SingleByteParam)
	call GetScriptByte
	ld hl, ScriptVar
	add [hl]
	ld [hl], a
	ret

Script_random:
; parameters:
;     input (SingleByteParam)
	call GetScriptByte
	ld [ScriptVar], a
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
	ld a, [hRandomAdd]
	cp b
	jr nc, .loop
	jr .finish

.no_restriction
	push bc
	call Random
	pop bc
	ld a, [hRandomAdd]

.finish
	push af
	ld a, [ScriptVar]
	ld c, a
	pop af
	call SimpleDivide
	ld [ScriptVar], a
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
	ld [ScriptVar], a
	ret

Script_writevarcode:
; parameters:
;     variable_id (SingleByteParam)
	call GetScriptByte
	call GetVarAction
	ld a, [ScriptVar]
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
	ld a, [ScriptVar]
.gotit
	ld [wd265], a
	call GetPokemonName
	ld de, StringBuffer1

ConvertMemToText:
	call GetScriptByte
	cp 3
	jr c, .ok
	xor a
.ok

CopyConvertedText:
	ld hl, StringBuffer3
	ld bc, StringBuffer4 - StringBuffer3
	call AddNTimes
	jp CopyName2

Script_itemtotext:
; parameters:
;     item (ItemLabelByte); use 0 to draw from ScriptVar
;     memory (SingleByteParam)
	call GetScriptByte
	and a
	jr nz, .ok
	ld a, [ScriptVar]
.ok
	ld [wd265], a
	call GetItemName
	ld de, StringBuffer1
	jr ConvertMemToText

Script_mapnametotext:
; parameters:
;     memory (SingleByteParam)
	ld a, [MapGroup]
	ld b, a
	ld a, [MapNumber]
	ld c, a
	call GetWorldMapLocation

ConvertLandmarkToText:
	ld e, a
	farcall GetLandmarkName
	ld de, StringBuffer1
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
	ld [CurSpecies], a
	call GetName
	ld de, StringBuffer1
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
	ld hl, StringBuffer1
	lb bc, PRINTNUM_RIGHTALIGN | 3, 6
	call PrintNum
	ld de, StringBuffer1
	jp ConvertMemToText

Script_readcoins:
; parameters:
;     memory (SingleByteParam)
	call ResetStringBuffer1
	ld hl, StringBuffer1
	ld de, Coins
	lb bc, PRINTNUM_RIGHTALIGN | 2, 6
	call PrintNum
	ld de, StringBuffer1
	jp ConvertMemToText

Script_RAM2MEM:
; parameters:
;     memory (SingleByteParam)
	call ResetStringBuffer1
	ld hl, StringBuffer1
	ld de, ScriptVar
	lb bc, PRINTNUM_RIGHTALIGN | 1, 3
	call PrintNum
	ld de, StringBuffer1
	jp ConvertMemToText

ResetStringBuffer1:
	ld hl, StringBuffer1
	ld bc, NAME_LENGTH
	ld a, "@"
	jp ByteFill

Script_stringtotext:
; parameters:
;     text_pointer (EncodedTextLabelParam)
;     memory (SingleByteParam)
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld a, [ScriptBank]
	ld hl, CopyName1
	call FarCall_hl
	ld de, StringBuffer2
	jp ConvertMemToText

Script_givepokeitem:
; parameters:
;     pointer (PointerParamToItemAndLetter)
	call GetScriptByte
	ld l, a
	call GetScriptByte
	ld h, a
	ld a, [ScriptBank]
	call GetFarByte
	ld b, a
	push bc
	inc hl
	ld bc, MAIL_MSG_LENGTH
	ld de, wd002
	ld a, [ScriptBank]
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
	ld a, [ScriptBank]
	ld b, a
	farjp CheckPokeItem

Script_giveitem:
; parameters:
;     item (ItemLabelByte)
;     quantity (SingleByteParam)
	call GetScriptByte
	cp ITEM_FROM_MEM
	jr nz, .ok
	ld a, [ScriptVar]
.ok
	ld [CurItem], a
	call GetScriptByte
	ld [wItemQuantityChangeBuffer], a
	ld hl, NumItems
	call ReceiveItem
	jr nc, .full
	ld a, TRUE
	ld [ScriptVar], a
	ret
.full
	xor a
	ld [ScriptVar], a
	ret

Script_takeitem:
; parameters:
;     item (ItemLabelByte)
;     quantity (DecimalParam)
	call GetScriptByte
	cp ITEM_FROM_MEM
	jr nz, .ok
	ld a, [ScriptVar]
.ok
	ld [CurItem], a
	call GetScriptByte
	ld [wItemQuantityChangeBuffer], a
	ld a, -1
	ld [CurItemQuantity], a
	ld hl, NumItems
	call TossItem
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
	ret

Script_checkitem:
; parameters:
;     item (ItemLabelByte)
	xor a
	ld [ScriptVar], a
	call GetScriptByte
	ld [CurItem], a
	ld hl, NumItems
	call CheckItem
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
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
	ld [ScriptVar], a
	ret

GetMoneyAccount:
	call GetScriptByte
	and a
	ld de, Money
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

LoadCoinAmountToMem:
	call GetScriptByte
	ld [hMoneyTemp + 1], a
	call GetScriptByte
	ld [hMoneyTemp], a
	ld bc, hMoneyTemp
	ret

Script_checktime:
; parameters:
;     time (SingleByteParam)
	xor a
	ld [ScriptVar], a
	farcall CheckTime
	call GetScriptByte
	and c
	ret z
	ld a, TRUE
	ld [ScriptVar], a
	ret

Script_checkpoke:
; parameters:
;     pkmn (PokemonParam)
	xor a
	ld [ScriptVar], a
	call GetScriptByte
	ld hl, PartySpecies
	ld de, 1
	call IsInArray
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
	ret

Script_addcellnum:
; parameters:
;     person (SingleByteParam)
	xor a
	ld [ScriptVar], a
	call GetScriptByte
	ld c, a
	farcall AddPhoneNumber
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
	ret

Script_delcellnum:
; parameters:
;     person (SingleByteParam)
	xor a
	ld [ScriptVar], a
	call GetScriptByte
	ld c, a
	farcall DelCellNum
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
	ret

Script_checkcellnum:
; parameters:
;     person (SingleByteParam)
; returns false if the cell number is not in your phone

	xor a
	ld [ScriptVar], a
	call GetScriptByte
	ld c, a
	farcall CheckCellNum
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
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
	ld [ScriptVar], a
	ret

Script_givepoke:
; parameters:
;     pokemon (PokemonParam)
;     level (DecimalParam)
;     item (ItemLabelByte)
;     trainer (DecimalParam)
;     trainer_name_pointer (MultiByteParam)
;     pkmn_nickname (MultiByteParam)
	call GetScriptByte
	ld [CurPartySpecies], a
	call GetScriptByte
	ld [CurPartyLevel], a
	call GetScriptByte
	ld [CurItem], a
	call GetScriptByte
	and a
	ld b, a
	jr z, .ok
	ld hl, ScriptPos
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
	ld [ScriptVar], a
	ret

Script_giveegg:
; parameters:
;     pkmn (PokemonParam)
;     level (DecimalParam)
; if no room in the party, return 0 in ScriptVar; else, return 2

	xor a ; PARTYMON
	ld [ScriptVar], a
	ld [MonType], a
	call GetScriptByte
	ld [CurPartySpecies], a
	call GetScriptByte
	ld [CurPartyLevel], a
	farcall GiveEgg
	ret nc
	ld a, 2
	ld [ScriptVar], a
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
	ld [ScriptVar], a
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
	ld [ScriptVar], a
	ret

_EngineFlagAction:
	farjp EngineFlagAction

Script_wildoff:
	ld hl, StatusFlags
	set 5, [hl] ; wild encounters on/off
	ret

Script_wildon:
	ld hl, StatusFlags
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
	ld [MapGroup], a
	call GetScriptByte
	ld [MapNumber], a
	call GetScriptByte
	ld [XCoord], a
	call GetScriptByte
	ld [YCoord], a
	ld a, -1
	ld [DefaultSpawnpoint], a
	ld a, MAPSETUP_WARP
	ld [hMapEntryMethod], a
	ld a, 1
	call LoadMapStatus
	jp StopScript

.not_ok
	call GetScriptByte
	call GetScriptByte
	call GetScriptByte
	ld a, -1
	ld [DefaultSpawnpoint], a
	ld a, MAPSETUP_BADWARP
	ld [hMapEntryMethod], a
	ld a, 1
	call LoadMapStatus
	jp StopScript

Script_warpmod:
; parameters:
;     warp_id (SingleByteParam)
;     map_group (MapGroupParam)
;     map_id (MapIdParam)
	call GetScriptByte
	ld [BackupWarpNumber], a
	call GetScriptByte
	ld [BackupMapGroup], a
	call GetScriptByte
	ld [BackupMapNumber], a
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

Script_writecmdqueue:
; parameters:
;     queue_pointer (MultiByteParam)
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	ld a, [ScriptBank]
	ld b, a
	jp WriteCmdQueue

Script_delcmdqueue:
; parameters:
;     byte (SingleByteParam)
	xor a
	ld [ScriptVar], a
	call GetScriptByte
	ld b, a
	call DelCmdQueue
	ret c
	ld a, 1
	ld [ScriptVar], a
	ret

Script_changemap:
; parameters:
;     map_data_pointer (MapDataPointerParam)
	call GetScriptByte
	ld [MapBlockDataBank], a
	call GetScriptByte
	ld [MapBlockDataPointer], a
	call GetScriptByte
	ld [MapBlockDataPointer + 1], a
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
	ld [hBGMapMode], a
	call OverworldTextModeSwitch
	call GetMovementPermissions
	farcall ReloadMapPart
	jp UpdateSprites

Script_warpcheck:
	call WarpCheck
	ret nc
	farjp EnableEvents

Script_newloadmap:
; parameters:
;     which_method (SingleByteParam)
	call GetScriptByte
	ld [hMapEntryMethod], a
	ld a, 1
	call LoadMapStatus
	jp StopScript

Script_reloadandreturn:
	call Script_newloadmap
	jp Script_end

Script_textbox:
	jp OpenText

Script_refreshscreen:
	jp RefreshScreen

Script_showtextfaceplayer:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call Script_faceplayer
; fallthrough

Script_showtext:
; parameters:
;     text_pointer (RawTextPointerLabelParam)
	call Script_textbox
	call Script_writetext
	call Script_waitbutton
; fallthrough

Script_closetext:
	call _OpenAndCloseMenu_HDMATransferTileMapAndAttrMap
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
	ld [ScriptDelay], a
.loop
	ld c, 2
	call DelayFrames
	ld hl, ScriptDelay
	dec [hl]
	jr nz, .loop
	ret

Script_deactivatefacing:
; parameters:
;     time (SingleByteParam)
	call GetScriptByte
	and a
	jr z, .no_time
	ld [ScriptDelay], a
.no_time
	ld a, SCRIPT_WAIT
	ld [ScriptMode], a
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
	ld [ScriptRunning], a
	ld a, SCRIPT_OFF
	ld [ScriptMode], a
	ld hl, ScriptFlags
	res 0, [hl]
	jp StopScript

Script_return:
	call ExitScriptSubroutine
	ld hl, ScriptFlags
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
rept 3
	add hl, de
endr
	ld a, [hli]
	ld b, a
	and " "
	ld [ScriptBank], a
	ld a, [hli]
	ld e, a
	ld [ScriptPos], a
	ld a, [hl]
	ld d, a
	ld [ScriptPos + 1], a
	and a
	ret
.done
	scf
	ret

Script_end_all:
	xor a
	ld [wScriptStackSize], a
	ld [ScriptRunning], a
	ld a, SCRIPT_OFF
	ld [ScriptMode], a
	ld hl, ScriptFlags
	res 0, [hl]
	jp StopScript

Script_halloffame:
	ld hl, GameTimerPause
	res 0, [hl]
	farcall HallOfFame
	ld hl, GameTimerPause
	set 0, [hl]
	jr ReturnFromCredits

Script_credits:
	farcall LeafCredits
ReturnFromCredits:
	call Script_end_all
	ld a, $3
	call LoadMapStatus
	jp StopScript
; 97c051

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
	ld [ScriptVar], a
	ret

Script_count_seen_caught:
	ld hl, PokedexSeen
	ld b, EndPokedexSeen - PokedexSeen
	call CountSetBits
	ld [wd002], a
	ld hl, PokedexCaught
	ld b, EndPokedexCaught - PokedexCaught
	call CountSetBits
	ld [wd003], a
	ret

Script_trainerpic:
; parameters:
;     trainer (TrainerParam)
	call GetScriptByte
	and a
	jr nz, .ok
	ld a, [ScriptVar]
.ok
	ld [TrainerClass], a
	farjp Trainerpic

Script_givetmhm:
; parameters:
;     tmhm (TMHMLabelByte)
	call GetScriptByte
	ld [CurTMHM], a
	ld [wItemQuantityChangeBuffer], a
	call ReceiveTMHM
	jr nc, .full
	ld a, TRUE
	ld [ScriptVar], a
	ret
.full
	xor a
	ld [ScriptVar], a
	ret

Script_checktmhm:
; parameters:
;     tmhm (TMHMLabelByte)
	xor a
	ld [ScriptVar], a
	call GetScriptByte
	ld [CurTMHM], a
	call CheckTMHM
	ret nc
	ld a, TRUE
	ld [ScriptVar], a
	ret

Script_verbosegivetmhm:
; parameters:
;     tmhm (TMHMLabelByte)
	call Script_givetmhm
	call CurTMHMName
	ld de, StringBuffer1
	ld a, 1
	call CopyConvertedText
	ld b, BANK(GiveTMHMScript)
	ld de, GiveTMHMScript
	jp ScriptCall

GiveTMHMScript:
	writetext ReceivedItemText
	waitsfx
	specialsound
	waitbutton
	tmhmnotify
	end

Script_tmhmnotify:
	call GetTMHMPocketName
	call CurTMHMName
	ld b, BANK(PutItemInPocketText)
	ld hl, PutItemInPocketText
	jp MapTextbox

Script_tmhmtotext:
; parameters:
;     tmhm (TMHMLabelByte); use 0 to draw from ScriptVar
;     memory (SingleByteParam)
	call GetScriptByte
	and a
	jr nz, .ok
	ld a, [ScriptVar]
.ok
	ld [wd265], a
	call GetTMHMName
	ld de, StringBuffer1
	call ConvertMemToText

	; off by one error?
	ld a, [wd265]
	inc a
	ld [wd265], a

	predef GetTMHMMove
	ld a, [wd265]
	ld [wPutativeTMHMMove], a
	call GetMoveName

	ld hl, StringBuffer3 + 4 ; assume all TM names are 4 characters, "TM##"
	ld a, " "
	ld [hli], a
	jp CopyName2

Script_checkdarkness:
	xor a
	ld [ScriptVar], a
	push hl
	ld hl, StatusFlags
	bit 2, [hl] ; Flash
	pop hl
	ret nz
	ld a, TRUE
	ld [ScriptVar], a
	ret

Script_checkunits:
	ld a, [Options2]
	bit POKEDEX_UNITS, a
	ld [ScriptVar], a
	ret

Script_unowntypeface:
	ld a, [Options2]
	ld [OptionsBuffer], a
	and $ff - FONT_MASK
	or UNOWN_FONT
	ld [Options2], a
	jp LoadStandardFont

Script_restoretypeface:
	ld a, [OptionsBuffer]
	ld [Options2], a
	xor a
	ld [OptionsBuffer], a
	jp LoadStandardFont

Script_iftrue_endtext:
	ld a, [ScriptVar]
	and a
	ret z
	jr Script_endtext

Script_iffalse_endtext:
	ld a, [ScriptVar]
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
	call Script_textbox
	call Script_writetext
	call Script_cry
	call Script_waitbutton
	jp Script_closetext

Script_loadgrottomon:
	farcall GetHiddenGrottoContents
	ld [TempWildMonSpecies], a
	call PlayCry
	ld a, (1 << 7)
	ld [wBattleScriptFlags], a
	farcall GetCurHiddenGrottoLevel
	ld [CurPartyLevel], a
	ret
