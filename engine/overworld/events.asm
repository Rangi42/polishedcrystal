INCLUDE "constants.asm"


SECTION "Events", ROMX

OverworldLoop::
	xor a ; MAPSTATUS_START
	ld [wMapStatus], a
.loop
	ld a, [wMapStatus]
	ld hl, .jumps
	call JumpTable
	ld a, [wMapStatus]
	cp MAPSTATUS_DONE
	jr nz, .loop
	ret

.jumps
	dw StartMap
	dw EnterMap
	dw HandleMap
	dw DoNothing

DisableEvents:
	xor a
	ld [wScriptFlags3], a
	ret

EnableEvents::
	ld a, $ff
	ld [wScriptFlags3], a
	ret

EnableWildEncounters:
	ld hl, wScriptFlags3
	set 4, [hl]
	ret

CheckWarpConnxnScriptFlag:
	ld hl, wScriptFlags3
	bit 2, [hl]
	ret

CheckCoordEventScriptFlag:
	ld hl, wScriptFlags3
	bit 1, [hl]
	ret

CheckStepCountScriptFlag:
	ld hl, wScriptFlags3
	bit 0, [hl]
	ret

CheckWildEncountersScriptFlag:
	ld hl, wScriptFlags3
	bit 4, [hl]
	ret

StartMap:
	xor a
	ldh [hScriptVar], a
	xor a
	ld [wScriptRunning], a
	ld hl, wMapStatus
	ld bc, wMapStatusEnd - wMapStatus
	rst ByteFill
	farcall InitCallReceiveDelay
	call ClearJoypad
EnterMap:
	call SetUpFiveStepWildEncounterCooldown
	farcall RunMapSetupScript
	call DisableEvents

	ldh a, [hMapEntryMethod]
	cp MAPSETUP_CONNECTION
	call z, EnableEvents

	ldh a, [hMapEntryMethod]
	cp MAPSETUP_RELOADMAP
	jr nz, .dontresetpoison
	xor a
	ld [wPoisonStepCount], a
.dontresetpoison

	xor a ; end map entry
	ldh [hMapEntryMethod], a
	ld a, MAPSTATUS_HANDLE
	ld [wMapStatus], a
	jp DeleteSavedMusic

HandleMap:
	call HandleMapTimeAndJoypad
	call HandleStoneTable
	call MapEvents

; Not immediately entering a connected map will cause problems.
	ld a, [wMapStatus]
	cp MAPSTATUS_HANDLE
	ret nz

	call HandleMapObjects
	call NextOverworldFrame
	call HandleMapBackground
	call CheckPlayerState
	xor a
	ret

MapEvents:
	ld a, [wMapEventStatus]
	and a
	ret nz
	call PlayerEvents
	call DisableEvents
	jp ScriptEvents

NextOverworldFrame:
	; If we haven't already performed a delay outside DelayFrame as a result
	; of a busy LY overflow, perform that now.
	ld a, [wOverworldDelaySkip]
	and a
	jr nz, .done
	ldh a, [hDelayFrameLY]
	inc a
	jr nz, .LoadMapGraphicsAndDelay
	xor a
	ldh [hDelayFrameLY], a
.done
	ld a, [wOverworldDelaySkip]
	and a
	ret z
	dec a
	ld [wOverworldDelaySkip], a
	ret

.LoadMapGraphicsAndDelay:
	push hl
	push de
	push bc
	ldh a, [rVBK]
	push af
	xor a
	ldh [hDelayFrameLY], a

	; only allow this if we have time to spare
	ldh a, [rLY]
	cp $20
	jr nc, .gfx_done

	ld a, [wPendingOverworldGraphics]
	and a
	jr z, .gfx_done

	dec a
	ld [wPendingOverworldGraphics], a
	call _LoadTilesetGFX
	xor a
	ldh [hTileAnimFrame], a

.gfx_done
	ldh a, [hDelayFrameLY]
	and a
	call z, DelayFrame
	pop af
	ldh [rVBK], a
	jp PopBCDEHL

HandleMapTimeAndJoypad:
	ld a, [wMapEventStatus]
	cp MAPEVENTS_OFF
	ret z

	call UpdateTime
	call GetJoypad
	jp TimeOfDayPals

HandleMapObjects:
	farcall HandleNPCStep ; engine/map_objects.asm
	farcall _HandlePlayerStep
	jp _CheckObjectEnteringVisibleRange

HandleMapBackground:
	farcall _UpdateSprites
	farcall ScrollScreen
	farjp PlaceMapNameSign

CheckPlayerState:
	ld a, [wPlayerStepFlags]
	bit PLAYERSTEP_CONTINUE_F, a
	jr z, .events
	bit PLAYERSTEP_STOP_F, a
	jr z, .noevents
	bit PLAYERSTEP_MIDAIR_F, a
	jr nz, .noevents
	call EnableEvents
.events
	xor a ; MAPEVENTS_ON
	ld [wMapEventStatus], a
	ret

.noevents
	ld a, MAPEVENTS_OFF
	ld [wMapEventStatus], a
	ret

_CheckObjectEnteringVisibleRange:
	ld hl, wPlayerStepFlags
	bit PLAYERSTEP_STOP_F, [hl]
	ret z
	farjp CheckObjectEnteringVisibleRange

PlayerEvents:
	xor a
; If there's already a player event, don't interrupt it.
	ld a, [wScriptRunning]
	and a
	ret nz

	call CheckTrainerBattle_GetPlayerEvent
	jr c, .ok

	call CheckTileEvent
	jr c, .ok

	call RunMemScript
	jr c, .ok

	call RunSceneScript
	jr c, .ok

	call CheckTimeEvents
	jr c, .ok

	call OWPlayerInput
	jr c, .ok

	xor a
	ret

.ok
	push af
	call EnableScriptMode
	pop af

	ld [wScriptRunning], a
	call DoPlayerEvent
	ld a, [wScriptRunning]
	cp PLAYEREVENT_CONNECTION
	jr z, .ok2
	cp PLAYEREVENT_JOYCHANGEFACING
	jr z, .ok2

	xor a
	ld [wLandmarkSignTimer], a

.ok2
	scf
	ret

CheckTrainerBattle_GetPlayerEvent:
	call CheckTrainerBattle
	jr nc, .nope

	ld a, PLAYEREVENT_SEENBYTRAINER
	scf
	ret

.nope
	xor a
	ret

CheckTileEvent:
; Check for warps, coord events, or wild battles.

	call CheckWarpConnxnScriptFlag
	jr z, .connections_disabled

	farcall CheckMovingOffEdgeOfMap
	jr c, .map_connection

	call CheckWarpTile
	jr c, .warp_tile

.connections_disabled
	call CheckCoordEventScriptFlag
	jr z, .coord_events_disabled

	call CheckCurrentMapCoordEvents
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
	ld a, [wPlayerStandingTile]
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
	ld a, [wMapScriptsBank]
	jp CallScript

CheckWildEncounterCooldown:
	ld hl, wWildEncounterCooldown
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret z
	scf
	ret

SetUpFiveStepWildEncounterCooldown:
	ld a, 5
	ld [wWildEncounterCooldown], a
	ret

RunSceneScript:
	ld a, [wCurMapSceneScriptCount]
	and a
	jr z, .nope

	ld c, a
	call CheckScenes
	cp c
	jr nc, .nope

	add a
	ld e, a
	ld d, 0
	ld hl, wCurMapSceneScriptsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de

	ld a, [wMapScriptsBank]
	ld b, a
	call GetFarHalfword
	ld a, b
	call GetFarByte
	cp end_command
	ret z ; boost efficiency of maps with dummy triggers
	ld a, b
	call CallScript

	ld hl, wScriptFlags
	res 3, [hl]

	call EnableScriptMode
	call ScriptEvents

	ld hl, wScriptFlags
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

CheckTimeEvents:
	ld a, [wLinkMode]
	and a
	jr nz, .nothing

	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
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

OWPlayerInput:
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

CheckAPressOW:
	ldh a, [hJoyPressed]
	and A_BUTTON
	ret z
	call TryObjectEvent
	ret c
	call TryBGEvent
	ret c
	call TryTileCollisionEvent
	ret c
	xor a
	ret

PlayTalkObject:
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	push bc
	ld c, 3
	call SFXDelayFrames
	pop bc
	ret

TryObjectEvent:
	farcall CheckFacingObject
	ret nc

	call PlayTalkObject
	ldh a, [hObjectStructIndexBuffer]
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	ldh [hLastTalked], a

	call GetMapObject
	ld hl, MAPOBJECT_COLOR
	add hl, bc
	ld a, [hl]
	and %00001111

	cp NUM_OBJECTTYPES
	ret nc

	call StackJumpTable

.pointers:
	dw .script   ; OBJECTTYPE_SCRIPT
	dw .itemball ; OBJECTTYPE_ITEMBALL
	dw .trainer  ; OBJECTTYPE_TRAINER
	dw .trainer  ; OBJECTTYPE_GENERICTRAINER
	dw .pokemon  ; OBJECTTYPE_POKEMON
	dw .command  ; OBJECTTYPE_COMMAND

.script:
	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapScriptsBank]
	jp CallScript

.itemball:
	ld hl, MAPOBJECT_RANGE
	add hl, bc
	ld a, [hli]
	push af
	ld a, [hli]
	ld [wItemBallItemID], a
	ld a, [hl]
	ld [wItemBallQuantity], a
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
	ldh [hScriptVar], a
	ld de, wTempScriptBuffer
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
	ld de, wTempScriptBuffer
rept 3
	ld a, [hli]
	ld [de], a
	inc de
endr
	ld a, [hl]
	ld [de], a
.callTemporaryScriptBuffer:
	ld hl, wTempScriptBuffer
	ld a, [wMapScriptsBank]
	jp CallScript

TryBGEvent:
	call CheckFacingBGEvent
	jr c, .IsBGEvent
	xor a
	ret

.IsBGEvent:
	ld a, [wCurBGEventType]
	cp BGEVENT_ITEM
	jp nc, .itemifset
	call StackJumpTable

.signs
	dw .read     ; BGEVENT_READ
	dw .up       ; BGEVENT_UP
	dw .down     ; BGEVENT_DOWN
	dw .right    ; BGEVENT_RIGHT
	dw .left     ; BGEVENT_LEFT
	dw .ifset    ; BGEVENT_IFSET
	dw .ifnotset ; BGEVENT_IFNOTSET
	dw .jumptext ; BGEVENT_JUMPTEXT
	dw .jumpstd  ; BGEVENT_JUMPSTD
	dw .ifnotset ; BGEVENT_GROTTOITEM

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
	ld a, [wPlayerDirection]
	and %1100
	cp b
	jp nz, .dontread

.read
	call PlayTalkObject
	ld hl, wCurBGEventScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
.callMapScriptAndReturnCarry
	ld a, [wMapScriptsBank]
.callScriptAndReturnCarry
	call CallScript
	scf
	ret

.itemifset
	ld a, [wCurBGEventScriptAddr]
	ld e, a
	ld a, [wCurBGEventScriptAddr+1]
	ld d, a
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jp nz, .dontread
	call PlayTalkObject
	ld hl, wHiddenItemEvent
	ld a, [wCurBGEventScriptAddr]
	ld [hli], a ; wHiddenItemEvent
	ld a, [wCurBGEventScriptAddr+1]
	ld [hli], a ; wHiddenItemEvent + 1
	ld a, [wCurBGEventType]
	sub BGEVENT_ITEM
	ld [hl], a ; wHiddenItemID
	ld a, BANK(HiddenItemScript)
	ld hl, HiddenItemScript
	jr .callScriptAndReturnCarry

.ifset
	call CheckBGEventFlag
	jr z, .dontread
	jr .thenread

.ifnotset
	call CheckBGEventFlag
	jr nz, .dontread
	; fallthrough

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
	ld hl, wTempScriptBuffer + 2
	ld a, [wCurBGEventScriptAddr + 1]
	ld [hld], a
	ld a, [wCurBGEventScriptAddr]
	ld [hld], a
	ld [hl], jumptext_command
	jr .callMapScriptAndReturnCarry

.jumpstd
	call PlayClickSFX
	ld hl, wTempScriptBuffer + 3
	ld a, [wCurBGEventScriptAddr]
	ld [hld], a
	ld a, jumpstd_command
	ld [hld], a
	ld a, [wCurBGEventScriptAddr + 1]
	ld [hld], a
	ld [hl], writebyte_command ; just to be safe (as opposed to directly writing to hScriptVar)
	jr .callMapScriptAndReturnCarry

CheckBGEventFlag:
	ld hl, wCurBGEventScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, [wMapScriptsBank]
	call GetFarHalfword
	ld e, l
	ld d, h
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	pop hl
	ret

INCLUDE "engine/events/hidden_item.asm"

PlayerMovement:
	farcall DoPlayerMovement
	ld a, c
	ld hl, .pointers
	call JumpTable
	ld a, c
	ret

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
.four
	xor a
	ld c, a
	ret

.seven ; functionally the same as zero/four?
	xor a
	ld c, a
	ret

.one
	ld a, 5
	ld c, a
	scf
	ret

.two
	ld a, 9
	ld c, a
	scf
	ret

.three
; force the player to move in some direction
	ld a, BANK(Script_ForcedMovement)
	ld hl, Script_ForcedMovement
	call CallScript
;	ld a, -1
	ld c, a
	scf
	ret

.five
.six
	ld a, -1
	ld c, a
	and a
	ret

CheckMenuOW:
	xor a
	ldh [hMenuReturn], a
	ldh [hMenuReturn + 1], a
	ldh a, [hJoyPressed]

	bit SELECT_F, a
	jr nz, .Select

	bit START_F, a
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
	ld a, BANK(SelectMenuScript)
	ld hl, SelectMenuScript
	call CallScript
	scf
	ret

StartMenuScript:
	callasm StartMenu
	jump StartMenuCallback

SelectMenuScript:
	callasm SelectMenu
	jump SelectMenuCallback

StartMenuCallback:
SelectMenuCallback:
	copybytetovar hMenuReturn
	ifequal HMENURETURN_SCRIPT, .Script
	ifequal HMENURETURN_ASM, .Asm
	end

.Script:
	ptjump wQueuedScriptBank

.Asm:
	ptcallasm wQueuedScriptBank
	end

CountStep:
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
	ld hl, wPoisonStepCount
	inc [hl]
	ld hl, wStepCount
	inc [hl]
	; Every 256 steps, increase the happiness of all your Pokemon.
	jr nz, .skip_happiness

	farcall StepHappiness

.skip_happiness
	; Every 256 steps, offset from the happiness incrementor by 128 steps,
	; decrease the hatch counter of all your eggs until you reach the first
	; one that is ready to hatch.
	ld a, [wStepCount]
	cp $80
	jr nz, .skip_egg

	farcall DoEggStep
	jr nz, .hatch

.skip_egg
	; Increase the EXP of (both) DayCare Pokemon by 1.
	farcall DayCareStep

	; Every four steps, deal damage to all Poisoned Pokemon
	ld hl, wPoisonStepCount
	ld a, [hl]
	cp 4
	jr c, .skip_poison
	ld [hl], 0

	farcall DoPoisonStep
	jr c, .doscript

.skip_poison
	call DoBikeStep

.done
	xor a
	ret

.doscript
	ld a, -1
	scf
	ret

.hatch
	ld a, PLAYEREVENT_HATCH
	scf
	ret

DoRepelStep:
	ld a, [wRepelEffect]
	and a
	ret z

	dec a
	ld [wRepelEffect], a
	ret nz

	ld a, [wRepelType]
	ld [wCurItem], a
	ld hl, wNumItems
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

RepelWoreOffScript:
	farjumptext _RepelWoreOffText

UseAnotherRepelScript:
	opentext
	farwritetext UseAnotherRepelText
	yesorno
	iffalse_endtext
	callasm DoItemEffect
	endtext

DoPlayerEvent:
	ld a, [wScriptRunning]
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
	ld [wScriptBank], a
	ld a, [hli]
	ld [wScriptPos], a
	ld a, [hl]
	ld [wScriptPos + 1], a
	ret

PlayerEventScriptPointers:
	dba InvalidEventScript          ; PLAYEREVENT_NONE
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
	dba FindKeyItemInBallScript  ; PLAYEREVENT_KEYITEMBALL
	dba InvalidEventScript          ; NUM_PLAYER_EVENTS

HatchEggScript:
	callasm OverworldHatchEgg
InvalidEventScript:
	end

WarpToNewMapScript:
	warpsound
	newloadmap MAPSETUP_DOOR
	end

FallIntoMapScript:
	newloadmap MAPSETUP_FALL
	playsound SFX_KINESIS
	applymovement PLAYER, MovementData_0x96c48
	playsound SFX_STRENGTH
	scall LandAfterPitfallScript
	end

MovementData_0x96c48:
	skyfall
	step_end

LandAfterPitfallScript:
	earthquake 16
	end

EdgeWarpScript: ; 4
	reloadandreturn MAPSETUP_CONNECTION

ChangeDirectionScript: ; 9
	deactivatefacing 6
	callasm EnableWildEncounters
	end

; More overworld event handling.

WarpToSpawnPoint::
	ld hl, wStatusFlags2
	res STATUSFLAGS2_SAFARI_GAME_F, [hl]
	res STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ret

RunMemScript:
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
	rst ByteFill
	pop af
	ret

LoadScriptBDE::
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

TryTileCollisionEvent:
	call GetFacingTileCoord
	ld [wFacingTileID], a
	ld c, a
	farcall CheckFacingTileForStdScript
	jr c, .done

	ld a, [wFacingTileID]
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

RandomEncounter::
; Random encounter
	call CheckWildEncounterCooldown
	jr c, .nope
	call CanUseSweetScent
	jr nc, .nope
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_SAFARI_GAME_F, [hl]
	jr nz, .safari_game
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
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

WildBattleScript:
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

CanUseSweetScent::
	ld hl, wStatusFlags
	bit STATUSFLAGS_NO_WILD_ENCOUNTERS_F, [hl]
	jr nz, .no
	ld a, [wEnvironment]
	cp CAVE
	jr z, .ice_check
	cp DUNGEON
	jr z, .ice_check
	farcall CheckGrassCollision
	jr nc, .no

.ice_check
	ld a, [wPlayerStandingTile]
	cp COLL_ICE
	jr z, .no
	scf
	ret

.no
	and a
	ret

_TryWildEncounter_BugContest:
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
	ld [wTempWildMonSpecies], a
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
	ldh a, [hRandomAdd]
	call SimpleDivide
	add d
.GotLevel:
	ld [wCurPartyLevel], a
	xor a
	farjp CheckRepelEffect

TryWildEncounter_BugContest:
	ld a, [wPlayerStandingTile]
	cp COLL_LONG_GRASS
	ld b, 40 percent
	jr z, .ok
	ld b, 20 percent

.ok
	farcall ApplyMusicEffectOnEncounterRate
	farcall ApplyCleanseTagEffectOnEncounterRate
	call Random
	ldh a, [hRandomAdd]
	cp b
	ret c
	ld a, 1
	and a
	ret

INCLUDE "data/wild/bug_contest_mons.asm"

DoBikeStep::
	; If the bike shop owner doesn't have our number, or
	; if we've already gotten the call, we don't have to
	; be here.
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BIKE_SHOP_CALL_F, [hl]
	jr z, .NoCall

	; If we're not on the bike, we don't have to be here.
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .NoCall

	; If we're not in an area of phone service, we don't
	; have to be here.
	call GetMapPhoneService
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
	cp HIGH(1024)
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
	ld hl, wStatusFlags2
	res STATUSFLAGS2_BIKE_SHOP_CALL_F, [hl]
	scf
	ret

.NoCall:
	xor a
	ret

INCLUDE "engine/overworld/stone_table.asm"
INCLUDE "engine/overworld/scripting.asm"
