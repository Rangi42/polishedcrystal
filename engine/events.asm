INCLUDE "constants.asm"


SECTION "Events", ROMX

OverworldLoop:: ; 966b0
	xor a
	ld [MapStatus], a
.loop
	ld a, [MapStatus]
	ld hl, .jumps
	rst JumpTable
	ld a, [MapStatus]
	cp 3 ; done
	jr nz, .loop
.done
	ret

.jumps
	dw StartMap
	dw EnterMap
	dw HandleMap
	dw .done
; 966cb

DisableEvents: ; 966cb
	xor a
	ld [ScriptFlags3], a
	ret
; 966d0

EnableEvents:: ; 966d0
	ld a, $ff
	ld [ScriptFlags3], a
	ret
; 966d6

EnableWildEncounters: ; 96706
	ld hl, ScriptFlags3
	set 4, [hl]
	ret
; 9670c

CheckWarpConnxnScriptFlag: ; 9670c
	ld hl, ScriptFlags3
	bit 2, [hl]
	ret
; 96712

CheckCoordEventScriptFlag: ; 96712
	ld hl, ScriptFlags3
	bit 1, [hl]
	ret
; 96718

CheckStepCountScriptFlag: ; 96718
	ld hl, ScriptFlags3
	bit 0, [hl]
	ret
; 9671e

CheckWildEncountersScriptFlag: ; 9671e
	ld hl, ScriptFlags3
	bit 4, [hl]
	ret
; 96724

StartMap: ; 96724
	xor a
	ld [ScriptVar], a
	xor a
	ld [ScriptRunning], a
	ld hl, MapStatus
	ld bc, wMapStatusEnd - MapStatus
	call ByteFill
	farcall InitCallReceiveDelay
	call ClearJoypad
EnterMap: ; 9673e
	call SetUpFiveStepWildEncounterCooldown
	farcall RunMapSetupScript
	call DisableEvents

	ld a, [hMapEntryMethod]
	cp MAPSETUP_CONNECTION
	jr nz, .dont_enable
	call EnableEvents
.dont_enable

	ld a, [hMapEntryMethod]
	cp MAPSETUP_RELOADMAP
	jr nz, .dontresetpoison
	xor a
	ld [PoisonStepCount], a
.dontresetpoison

	xor a ; end map entry
	ld [hMapEntryMethod], a
	ld a, 2 ; HandleMap
	ld [MapStatus], a
	jp DeleteSavedMusic
; 9676d

HandleMap: ; 96773
	call ResetOverworldDelay
	call HandleMapTimeAndJoypad
	call HandleCmdQueue
	call MapEvents

; Not immediately entering a connected map will cause problems.
	ld a, [MapStatus]
	cp 2 ; HandleMap
	ret nz

	call HandleMapObjects
	call NextOverworldFrame
	call HandleMapBackground
	jp CheckPlayerState
; 96795

MapEvents: ; 96795
	ld a, [MapEventStatus]
	ld hl, .jumps
	rst JumpTable
	ret

.jumps
	dw .events
	dw .no_events
; 967a1

.events ; 967a1
	call PlayerEvents
	call DisableEvents
	farcall ScriptEvents
.no_events ; 967ae
	ret
; 967ae

MaxOverworldDelay: ; 967af
	db 2
; 967b0

ResetOverworldDelay: ; 967b0
	ld a, [MaxOverworldDelay]
	ld [OverworldDelay], a
	ret
; 967b7

NextOverworldFrame: ; 967b7
	ld a, [OverworldDelay]
	and a
	ret z
	ld c, a
	jp DelayFrames
; 967c1

HandleMapTimeAndJoypad: ; 967c1
	ld a, [MapEventStatus]
	cp 1 ; no events
	ret z

	call UpdateTime
	call GetJoypad
	jp TimeOfDayPals
; 967d1

HandleMapObjects: ; 967d1
	farcall HandleNPCStep ; engine/map_objects.asm
	farcall _HandlePlayerStep
	jp _CheckObjectEnteringVisibleRange
; 967e1

HandleMapBackground: ; 967e1
	farcall _UpdateSprites
	farcall ScrollScreen
	farjp PlaceMapNameSign
; 967f4

CheckPlayerState: ; 967f4
	ld a, [wPlayerStepFlags]
	bit 5, a ; in the middle of step
	jr z, .events
	bit 6, a ; stopping step
	jr z, .noevents
	bit 4, a ; in midair
	jr nz, .noevents
	call EnableEvents
.events
	xor a ; events
	ld [MapEventStatus], a
	ret

.noevents
	ld a, 1 ; no events
	ld [MapEventStatus], a
	ret
; 96812

_CheckObjectEnteringVisibleRange: ; 96812
	ld hl, wPlayerStepFlags
	bit 6, [hl]
	ret z
	farjp CheckObjectEnteringVisibleRange
; 9681f

PlayerEvents: ; 9681f
	xor a
; If there's already a player event, don't interrupt it.
	ld a, [ScriptRunning]
	and a
	ret nz

	call CheckTrainerBattle3
	jr c, .ok

	call CheckTileEvent
	jr c, .ok

	call RunMemScript
	jr c, .ok

	call DoMapTrigger
	jr c, .ok

	call CheckTimeEvents
	jr c, .ok

	call OWPlayerInput
	jr c, .ok

	xor a
	ret

.ok
	push af
	farcall EnableScriptMode
	pop af

	ld [ScriptRunning], a
	call DoPlayerEvent
	ld a, [ScriptRunning]
	cp PLAYEREVENT_CONNECTION
	jr z, .ok2
	cp PLAYEREVENT_JOYCHANGEFACING
	jr z, .ok2

	xor a
	ld [wLandmarkSignTimer], a

.ok2
	scf
	ret
; 96867

CheckTrainerBattle3: ; 96867
	call CheckTrainerBattle2
	jr nc, .nope

	ld a, PLAYEREVENT_SEENBYTRAINER
	scf
	ret

.nope
	xor a
	ret
; 96874

CheckTileEvent: ; 96874
; Check for warps, tile triggers or wild battles.

	call CheckWarpConnxnScriptFlag
	jr z, .connections_disabled

	farcall CheckMovingOffEdgeOfMap
	jr c, .map_connection

	call CheckWarpTile
	jr c, .warp_tile

.connections_disabled
	call CheckCoordEventScriptFlag
	jr z, .coord_events_disabled

	call CheckCurrentMapXYTriggers
	jr c, .coord_event

.coord_events_disabled
	call CheckStepCountScriptFlag
	jr z, .step_count_disabled

	call CountStep
	ret c

.step_count_disabled
	call CheckWildEncountersScriptFlag
	jr z, .ok

	call RandomEncounter
	ret c

.ok
	xor a
	ret

.map_connection
	ld a, PLAYEREVENT_CONNECTION
	scf
	ret

.warp_tile
	ld a, [PlayerStandingTile]
	cp COLL_HOLE
	jr nz, .not_pit
	ld a, PLAYEREVENT_FALL
	scf
	ret

.not_pit
	ld a, PLAYEREVENT_WARP
	scf
	ret

.coord_event
	ld hl, wCurCoordEventScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [MapScriptHeaderBank]
	jp CallScript
; 968c7

CheckWildEncounterCooldown: ; 968c7
	ld hl, wWildEncounterCooldown
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret z
	scf
	ret
; 968d1

SetUpFiveStepWildEncounterCooldown: ; 968d1
	ld a, 5
	ld [wWildEncounterCooldown], a
	ret
; 968d7

DoMapTrigger: ; 968ec
	ld a, [wCurrMapTriggerCount]
	and a
	jr z, .nope

	ld c, a
	call CheckTriggers
	cp c
	jr nc, .nope

	add a
	ld e, a
	ld d, 0
	ld hl, wCurrMapTriggerHeaderPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de

	ld a, [MapScriptHeaderBank]
	ld b, a
	call GetFarHalfword
	ld a, b
	call GetFarByte
	cp end_command
	ret z ; boost efficiency of maps with dummy triggers
	ld a, b
	call CallScript

	ld hl, ScriptFlags
	res 3, [hl]

	farcall EnableScriptMode
	farcall ScriptEvents

	ld hl, ScriptFlags
	bit 3, [hl]
	jr z, .nope

	ld hl, wPriorityScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wPriorityScriptBank]
	call CallScript
	scf
	ret

.nope
	xor a
	ret
; 9693a

CheckTimeEvents: ; 9693a
	ld a, [wLinkMode]
	and a
	jr nz, .nothing

	ld hl, StatusFlags2
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	jr z, .do_daily

	farcall CheckBugContestTimer
	jr c, .end_bug_contest
	xor a
	ret

.do_daily
	farcall CheckDailyResetTimer
	farcall CheckPokerusTick
	farcall CheckPhoneCall
	ret c

.nothing
	xor a
	ret

.end_bug_contest
	ld a, BANK(BugCatchingContestOverScript)
	ld hl, BugCatchingContestOverScript
	call CallScript
	scf
	ret
; 96970

OWPlayerInput: ; 96974

	call PlayerMovement
	ret c
	and a
	jr nz, .NoAction

; Can't perform button actions while sliding on ice.
	farcall CheckStandingOnIce
	jr c, .NoAction

	call CheckAPressOW
	jr c, .Action

	call CheckMenuOW
	jr c, .Action

.NoAction:
	xor a
	ret

.Action:
	push af
	farcall StopPlayerForEvent
	pop af
	scf
	ret
; 96999

CheckAPressOW: ; 96999
	ld a, [hJoyPressed]
	and A_BUTTON
	ret z
	call TryObjectEvent
	ret c
	call TryReadSign
	ret c
	call CheckFacingTileEvent
	ret c
	xor a
	ret
; 969ac

PlayTalkObject: ; 969ac
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	ret
; 969b5

TryObjectEvent: ; 969b5
	farcall CheckFacingObject
	ret nc

	call PlayTalkObject
	ld a, [hObjectStructIndexBuffer]
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	ld [hLastTalked], a

	ld a, [hLastTalked]
	call GetMapObject
	ld hl, MAPOBJECT_COLOR
	add hl, bc
	ld a, [hl]
	and %00001111

	cp NUM_PERSONTYPES
	ret nc

	ld hl, .pointers
	rst JumpTable
	ret

.pointers:
	dw .script   ; PERSONTYPE_SCRIPT
	dw .pokeball ; PERSONTYPE_POKEBALL
	dw .trainer  ; PERSONTYPE_TRAINER
	dw .trainer  ; PERSONTYPE_GENERICTRAINER
	dw .pokemon  ; PERSONTYPE_POKEMON
	dw .command  ; PERSONTYPE_COMMAND

.script:
	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [MapScriptHeaderBank]
	jp CallScript
; 96a12

.pokeball:
	ld hl, MAPOBJECT_RANGE
	add hl, bc
	ld a, [hli]
	push af
	ld a, [hli]
	ld [CurItemBallContents], a
	ld a, [hl]
	ld [CurItemBallQuantity], a
	pop af
	scf
	ret

.trainer:
	call TalkToTrainer
	ld a, PLAYEREVENT_TALKTOTRAINER
	scf
	ret

.pokemon:
	ld hl, MAPOBJECT_RANGE
	add hl, bc
	ld a, [hli]
	ld [ScriptVar], a
	ld de, wTemporaryScriptBuffer
	ld a, showcrytext_command
	ld [de], a
	inc de
rept 2
	ld a, [hli]
	ld [de], a
	inc de
endr
	xor a
	ld [de], a
	inc de
	ld a, end_command
	ld [de], a
	jr .callTemporaryScriptBuffer

.command:
	ld hl, MAPOBJECT_RANGE
	add hl, bc
	ld de, wTemporaryScriptBuffer
rept 3
	ld a, [hli]
	ld [de], a
	inc de
endr
	ld a, [hl]
	ld [de], a
.callTemporaryScriptBuffer:
	ld hl, wTemporaryScriptBuffer
	ld a, [MapScriptHeaderBank]
	jp CallScript

TryReadSign: ; 96a38
	call CheckFacingSign
	jr c, .IsSign
	xor a
	ret

.IsSign:
	ld a, [EngineBuffer3]
	cp SIGNPOST_ITEM
	jp nc, .itemifset
	ld hl, .signs
	rst JumpTable
	ret

.signs
	dw .read     ; SIGNPOST_READ
	dw .up       ; SIGNPOST_UP
	dw .down     ; SIGNPOST_DOWN
	dw .right    ; SIGNPOST_RIGHT
	dw .left     ; SIGNPOST_LEFT
	dw .ifset    ; SIGNPOST_IFSET
	dw .ifnotset ; SIGNPOST_IFNOTSET
	dw .jumptext ; SIGNPOST_JUMPTEXT
	dw .jumpstd  ; SIGNPOST_JUMPSTD
	dw .ifnotset ; SIGNPOST_GROTTOITEM
; 96a59

.up
	ld b, OW_UP
	jr .checkdir
.down
	ld b, OW_DOWN
	jr .checkdir
.right
	ld b, OW_RIGHT
	jr .checkdir
.left
	ld b, OW_LEFT
	; fallthrough

.checkdir
	ld a, [PlayerDirection]
	and %1100
	cp b
	jp nz, .dontread

.read
	call PlayTalkObject
	ld hl, EngineBuffer4
	ld a, [hli]
	ld h, [hl]
	ld l, a
.callMapScriptAndReturnCarry
	ld a, [MapScriptHeaderBank]
.callScriptAndReturnCarry
	call CallScript
	scf
	ret

.itemifset
	ld a, [wCurSignpostScriptAddr]
	ld e, a
	ld a, [wCurSignpostScriptAddr+1]
	ld d, a
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jp nz, .dontread
	call PlayTalkObject
	ld hl, EngineBuffer1
	ld a, [wCurSignpostScriptAddr]
	ld [hli], a
	ld a, [wCurSignpostScriptAddr+1]
	ld [hli], a
	ld a, [wCurSignpostType]
	sub SIGNPOST_ITEM
	ld [hl], a
	ld a, BANK(HiddenItemScript)
	ld hl, HiddenItemScript
	jr .callScriptAndReturnCarry

.ifset
	call CheckSignFlag
	jr z, .dontread
	jr .thenread

.ifnotset
	call CheckSignFlag
	jr nz, .dontread

.thenread
	push hl
	call PlayTalkObject
	pop hl
	inc hl
	inc hl
	jr .callMapScriptAndReturnCarry

.dontread
	xor a
	ret

.jumptext
	call PlayClickSFX
	ld hl, wTemporaryScriptBuffer + 2
	ld a, [wCurSignpostScriptAddr + 1]
	ld [hld], a
	ld a, [wCurSignpostScriptAddr]
	ld [hld], a
	ld [hl], jumptext_command
	jr .callMapScriptAndReturnCarry

.jumpstd
	call PlayClickSFX
	ld hl, wTemporaryScriptBuffer + 3
	ld a, [wCurSignpostScriptAddr]
	ld [hld], a
	ld a, jumpstd_command
	ld [hld], a
	ld a, [wCurSignpostScriptAddr + 1]
	ld [hld], a
	ld [hl], writebyte_command ; just to be safe (as opposed to directly writing to hScriptVar)
	jr .callMapScriptAndReturnCarry
; 96ad8

CheckSignFlag: ; 96ad8
	ld hl, EngineBuffer4
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, [MapScriptHeaderBank]
	call GetFarHalfword
	ld e, l
	ld d, h
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	pop hl
	ret
; 96af0

HiddenItemScript: ; 0x13625
	opentext
	copybytetovar EngineBuffer3
	itemtotext $0, $0
	writetext .found_text
	giveitem ITEM_FROM_MEM
	iffalse .bag_full
	callasm SetMemEvent
	specialsound
	itemnotify
	endtext

.bag_full ; 0x1363e
	buttonsound
	pocketisfull
	endtext

.found_text ; 0x13645
	; found @ !
	text_jump UnknownText_0x1c0a1c
	db "@"

SetMemEvent: ; 1364f
	ld hl, EngineBuffer1
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld b, SET_FLAG
	jp EventFlagAction

PlayerMovement: ; 96af0
	farcall DoPlayerMovement
	ld a, c
	ld hl, .pointers
	rst JumpTable
	ld a, c
	ret
; 96afd

.pointers
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .five
	dw .six
	dw .seven

.zero
.four ; 96b0d
	xor a
	ld c, a
	ret
; 96b10

.seven ; 96b10
	xor a
	ld c, a
	ret
; 96b16

.one ; 96b16
	ld a, 5
	ld c, a
	scf
	ret
; 96b1b

.two ; 96b1b
	ld a, 9
	ld c, a
	scf
	ret
; 96b20

.three ; 96b20
; force the player to move in some direction
	ld a, BANK(Script_ForcedMovement)
	ld hl, Script_ForcedMovement
	call CallScript
;	ld a, -1
	ld c, a
	scf
	ret
; 96b2b

.five
.six ; 96b2b
	ld a, -1
	ld c, a
	and a
	ret
; 96b30

CheckMenuOW: ; 96b30
	xor a
	ld [hMenuReturn], a
	ld [hMenuReturn + 1], a
	ld a, [hJoyPressed]

	bit 2, a ; SELECT
	jr nz, .Select

	bit 3, a ; START
	jr z, .NoMenu

	ld a, BANK(StartMenuScript)
	ld hl, StartMenuScript
	call CallScript
	scf
	ret

.NoMenu:
	xor a
	ret

.Select:
	call PlayTalkObject
	ld a, BANK(SelectMenuScript)
	ld hl, SelectMenuScript
	call CallScript
	scf
	ret
; 96b58

StartMenuScript: ; 96b58
	callasm StartMenu
	jump StartMenuCallback
; 96b5f

SelectMenuScript: ; 96b5f
	callasm SelectMenu
	jump SelectMenuCallback
; 96b66

StartMenuCallback:
SelectMenuCallback: ; 96b66
	copybytetovar hMenuReturn
	ifequal HMENURETURN_SCRIPT, .Script
	ifequal HMENURETURN_ASM, .Asm
	end
; 96b72

.Script: ; 96b72
	ptjump wQueuedScriptBank
; 96b75

.Asm: ; 96b75
	ptcallasm wQueuedScriptBank
	end
; 96b79

CountStep: ; 96b79
	; Don't count steps in link communication rooms.
	ld a, [wLinkMode]
	and a
	jr nz, .done

	; If there is a special phone call, don't count the step.
	farcall CheckSpecialPhoneCall
	jr c, .doscript

	; If Repel wore off, don't count the step.
	call DoRepelStep
	jr c, .doscript

	; Count the step for poison and total steps
	ld hl, PoisonStepCount
	inc [hl]
	ld hl, StepCount
	inc [hl]
	; Every 256 steps, increase the happiness of all your Pokemon.
	jr nz, .skip_happiness

	farcall StepHappiness

.skip_happiness
	; Every 256 steps, offset from the happiness incrementor by 128 steps,
	; decrease the hatch counter of all your eggs until you reach the first
	; one that is ready to hatch.
	ld a, [StepCount]
	cp $80
	jr nz, .skip_egg

	farcall DoEggStep
	jr nz, .hatch

.skip_egg
	; Increase the EXP of (both) DayCare Pokemon by 1.
	farcall DaycareStep

	; Every four steps, deal damage to all Poisoned Pokemon
	ld hl, PoisonStepCount
	ld a, [hl]
	cp 4
	jr c, .skip_poison
	ld [hl], 0

	farcall DoPoisonStep
	jr c, .doscript

.skip_poison
	farcall DoBikeStep

.done
	xor a
	ret

.doscript
	ld a, -1
	scf
	ret

.hatch
	ld a, 8
	scf
	ret
; 96bd3

DoRepelStep: ; 96bd7
	ld a, [wRepelEffect]
	and a
	ret z

	dec a
	ld [wRepelEffect], a
	ret nz

	ld a, [wRepelType]
	ld [CurItem], a
	ld hl, NumItems
	call CheckItem

	ld a, BANK(RepelWoreOffScript)
	ld hl, RepelWoreOffScript
	jr nc, .okay
	ld a, BANK(UseAnotherRepelScript)
	ld hl, UseAnotherRepelScript
.okay
	call CallScript
	scf
	ret
; 96beb

RepelWoreOffScript: ; 0x13619
	thistext

	; REPEL's effect wore off.
	text_jump UnknownText_0x1bd308
	db "@"

UseAnotherRepelScript:
	opentext
	writetext .text
	yesorno
	iffalse_endtext
	callasm DoItemEffect
	endtext

.text:
	text_jump UseAnotherRepelText
	db "@"

DoPlayerEvent: ; 96beb
	ld a, [ScriptRunning]
	and a
	ret z

	cp PLAYEREVENT_MAPSCRIPT ; run script
	ret z

	cp NUM_PLAYER_EVENTS
	ret nc

	ld c, a
	ld b, 0
	ld hl, PlayerEventScriptPointers
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [ScriptBank], a
	ld a, [hli]
	ld [ScriptPos], a
	ld a, [hl]
	ld [ScriptPos + 1], a
	ret
; 96c0c

PlayerEventScriptPointers: ; 96c0c
	dba Invalid_0x96c2d          ; PLAYEREVENT_NONE
	dba SeenByTrainerScript      ; PLAYEREVENT_SEENBYTRAINER
	dba TalkToTrainerScript      ; PLAYEREVENT_TALKTOTRAINER
	dba FindItemInBallScript     ; PLAYEREVENT_ITEMBALL
	dba EdgeWarpScript           ; PLAYEREVENT_CONNECTION
	dba WarpToNewMapScript       ; PLAYEREVENT_WARP
	dba FallIntoMapScript        ; PLAYEREVENT_FALL
	dba Script_OverworldWhiteout ; PLAYEREVENT_WHITEOUT
	dba HatchEggScript           ; PLAYEREVENT_HATCH
	dba ChangeDirectionScript    ; PLAYEREVENT_JOYCHANGEFACING
	dba FindTMHMInBallScript     ; PLAYEREVENT_TMHMBALL
	dba Invalid_0x96c2d          ; NUM_PLAYER_EVENTS
; 96c2d

HatchEggScript: ; 96c2f
	callasm OverworldHatchEgg
Invalid_0x96c2d: ; 96c2d
	end
; 96c34

WarpToNewMapScript: ; 96c34
	warpsound
	newloadmap MAPSETUP_DOOR
	end
; 96c38

FallIntoMapScript: ; 96c38
	newloadmap MAPSETUP_FALL
	playsound SFX_KINESIS
	applymovement PLAYER, MovementData_0x96c48
	playsound SFX_STRENGTH
	scall LandAfterPitfallScript
	end
; 96c48

MovementData_0x96c48: ; 96c48
	skyfall
	step_end
; 96c4a

LandAfterPitfallScript: ; 96c4a
	earthquake 16
	end
; 96c4d

EdgeWarpScript: ; 4
	reloadandreturn MAPSETUP_CONNECTION
; 96c4f

ChangeDirectionScript: ; 9
	deactivatefacing 3
	callasm EnableWildEncounters
	end
; 96c56

; More overworld event handling.

WarpToSpawnPoint:: ; 97c28
	ld hl, StatusFlags2
	res 1, [hl] ; ENGINE_SAFARI_ZONE?
	res 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	ret
; 97c30

RunMemScript: ; 97c30
; If there is no script here, we don't need to be here.
	ld a, [wMapReentryScriptQueueFlag]
	and a
	ret z
; Execute the script at (wMapReentryScriptBank):(wMapReentryScriptAddress).
	ld hl, wMapReentryScriptAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapReentryScriptBank]
	call CallScript
	scf
; Clear the buffer for the next script.
	push af
	xor a
	ld hl, wMapReentryScriptQueueFlag
	ld bc, 8
	call ByteFill
	pop af
	ret
; 97c4f

LoadScriptBDE:: ; 97c4f
; If there's already a script here, don't overwrite.
	ld hl, wMapReentryScriptQueueFlag
	ld a, [hl]
	and a
	ret nz
; Set the flag
	ld [hl], 1
	inc hl
; Load the script pointer b:de into (wMapReentryScriptBank):(wMapReentryScriptAddress)
	ld [hl], b
	inc hl
	ld [hl], e
	inc hl
	ld [hl], d
	scf
	ret
; 97c5f

CheckFacingTileEvent: ; 97c5f
	call GetFacingTileCoord
	ld [EngineBuffer1], a
	ld c, a
	farcall CheckFacingTileForStd
	jr c, .done

	ld a, [EngineBuffer1]
	cp COLL_WHIRLPOOL
	jr z, .whirlpool
	cp COLL_WATERFALL
	jr z, .waterfall
	cp COLL_HEADBUTT_TREE
	jr z, .headbutt
	farcall TrySurfOW
	jr nc, .noevent
.done
	call PlayClickSFX
	ld a, $ff
	scf
	ret

.whirlpool
	farcall TryWhirlpoolOW
	jr .done

.waterfall
	farcall TryWaterfallOW
	jr .done

.headbutt
	farcall TryHeadbuttOW
	jr c, .done
.noevent
	xor a
	ret
; 97cc0


RandomEncounter:: ; 97cc0
; Random encounter
	call CheckWildEncounterCooldown
	jr c, .nope
	call CanUseSweetScent
	jr nc, .nope
	ld hl, StatusFlags2
	bit 1, [hl] ; ENGINE_SAFARI_GAME
	jr nz, .safari_game
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	jr nz, .bug_contest
	farcall TryWildEncounter
	jr nz, .nope
.ok
	ld a, BANK(WildBattleScript)
	ld hl, WildBattleScript
.done
	call CallScript
	scf
	ret

.safari_game
	farcall TryWildEncounter
	jr nz, .nope
	ld a, BANK(SafariGameBattleScript)
	ld hl, SafariGameBattleScript
	jr .done

.bug_contest
	call _TryWildEncounter_BugContest
	jr nc, .nope
	ld a, BANK(BugCatchingContestBattleScript)
	ld hl, BugCatchingContestBattleScript
	jr .done

.nope
	ld a, 1
	and a
	ret
; 97cf9

WildBattleScript: ; 97cf9
	randomwildmon
	startbattle
	reloadmapafterbattle
	end
; 97cfd

CanUseSweetScent:: ; 97cfd
	ld hl, StatusFlags
	bit 5, [hl]
	jr nz, .no
	ld a, [wPermission]
	cp CAVE
	jr z, .ice_check
	cp DUNGEON
	jr z, .ice_check
	farcall CheckGrassCollision
	jr nc, .no

.ice_check
	ld a, [PlayerStandingTile]
	cp COLL_ICE
	jr z, .no
	scf
	ret

.no
	and a
	ret
; 97d23

_TryWildEncounter_BugContest: ; 97d23
	call TryWildEncounter_BugContest
	ret nc
; Pick a random mon out of ContestMons.
.loop
	call Random
	cp 100 << 1
	jr nc, .loop
	srl a
	ld hl, ContestMons
	ld de, 4
.CheckMon:
	sub [hl]
	jr c, .GotMon
	add hl, de
	jr .CheckMon
.GotMon:
	inc hl
; Species
	ld a, [hli]
	ld [TempWildMonSpecies], a
; Min level
	ld a, [hli]
	ld d, a
; Max level
	ld a, [hl]
	sub d
	jr nz, .RandomLevel
; If min and max are the same.
	ld a, d
	jr .GotLevel
.RandomLevel:
; Get a random level between the min and max.
	ld c, a
	inc c
	call Random
	ld a, [hRandomAdd]
	call SimpleDivide
	add d
.GotLevel:
	ld [CurPartyLevel], a
	xor a
	farjp CheckRepelEffect
; 97d31

TryWildEncounter_BugContest: ; 97d64
	ld a, [PlayerStandingTile]
	cp COLL_LONG_GRASS
	ld b, 40 percent
	jr z, .ok
	ld b, 20 percent

.ok
	farcall ApplyMusicEffectOnEncounterRate
	farcall ApplyCleanseTagEffectOnEncounterRate
	call Random
	ld a, [hRandomAdd]
	cp b
	ret c
	ld a, 1
	and a
	ret
; 97d87

INCLUDE "data/wild/bug_contest_mons.asm"

DoBikeStep:: ; 97db3
	; If the bike shop owner doesn't have our number, or
	; if we've already gotten the call, we don't have to
	; be here.
	ld hl, StatusFlags2
	bit 4, [hl] ; ENGINE_BIKE_SHOP_CALL_ENABLED
	jr z, .NoCall

	; If we're not on the bike, we don't have to be here.
	ld a, [PlayerState]
	cp PLAYER_BIKE
	jr nz, .NoCall

	; If we're not in an area of phone service, we don't
	; have to be here.
	call GetMapHeaderPhoneServiceNybble
	and a
	jr nz, .NoCall

	; Check the bike step count and check whether we've
	; taken 65536 of them yet.
	ld hl, wBikeStep
	ld a, [hli]
	ld d, a
	ld e, [hl]
	cp 255
	jr nz, .increment
	ld a, e
	cp 255
	jr z, .dont_increment

.increment
	inc de
	ld [hl], e
	dec hl
	ld [hl], d

.dont_increment
	; If we've taken at least 1024 steps, have the bike
	;  shop owner try to call us.
	ld a, d
	cp 1024 >> 8
	jr c, .NoCall

	; If a call has already been queued, don't overwrite
	; that call.
	ld a, [wSpecialPhoneCallID]
	and a
	jr nz, .NoCall

	; Queue the call.
	ld a, SPECIALCALL_BIKESHOP
	ld [wSpecialPhoneCallID], a
	xor a
	ld [wSpecialPhoneCallID + 1], a
	ld hl, StatusFlags2
	res 4, [hl] ; ENGINE_BIKE_SHOP_CALL_ENABLED
	scf
	ret

.NoCall:
	xor a
	ret
; 97df9

; TODO: simplify command queue engine to just handle stone tables

ClearCmdQueue:: ; 97df9
	ld hl, wCmdQueue
	ld de, CMDQUEUE_ENTRY_SIZE
	ld c, CMDQUEUE_CAPACITY
	xor a
.loop
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret
; 97e08

HandleCmdQueue:: ; 97e08
	ld hl, wCmdQueue
	xor a
.loop
	ld [hMapObjectIndexBuffer], a
	ld a, [hl]
	and a
	jr z, .skip
	push hl
	ld b, h
	ld c, l
	call HandleQueuedCommand
	pop hl

.skip
	ld de, CMDQUEUE_ENTRY_SIZE
	add hl, de
	ld a, [hMapObjectIndexBuffer]
	inc a
	cp CMDQUEUE_CAPACITY
	jr nz, .loop
	ret
; 97e25

WriteCmdQueue:: ; 97e31
	push bc
	push de
	call .GetNextEmptyEntry
	ld d, h
	ld e, l
	pop hl
	pop bc
	ret c
	ld a, b
	ld bc, CMDQUEUE_ENTRY_SIZE - 1
	call FarCopyBytes
	xor a
	ld [hl], a
	ret
; 97e45

.GetNextEmptyEntry: ; 97e45
	ld hl, wCmdQueue
	ld de, CMDQUEUE_ENTRY_SIZE
	ld c, CMDQUEUE_CAPACITY
.loop
	ld a, [hl]
	and a
	jr z, .done
	add hl, de
	dec c
	jr nz, .loop
	scf
	ret

.done
	ld a, CMDQUEUE_CAPACITY
	sub c
	and a
	ret
; 97e5c

DelCmdQueue:: ; 97e5c
	ld hl, wCmdQueue
	ld de, CMDQUEUE_ENTRY_SIZE
	ld c, CMDQUEUE_CAPACITY
.loop
	ld a, [hl]
	cp b
	jr z, .done
	add hl, de
	dec c
	jr nz, .loop
	and a
	ret

.done
	xor a
	ld [hl], a
	scf
	ret
; 97e72

HandleQueuedCommand: ; 97f42
	ld de, PlayerStruct
	ld a, NUM_OBJECT_STRUCTS
.loop
	push af

	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next

	ld hl, OBJECT_MOVEMENTTYPE
	add hl, de
	ld a, [hl]
	cp SPRITEMOVEDATA_STRENGTH_BOULDER
	jr nz, .next

	ld hl, OBJECT_NEXT_TILE
	add hl, de
	ld a, [hl]
	cp COLL_HOLE
	jr nz, .next

	ld hl, OBJECT_DIRECTION_WALKING
	add hl, de
	ld a, [hl]
	cp STANDING
	jr nz, .next
	call HandleStoneQueue
	jr c, .fall_down_hole

.next
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	dec a
	jr nz, .loop
	ret

.fall_down_hole
	pop af
	ret
; 97ea3

INCLUDE "engine/scripting.asm"
