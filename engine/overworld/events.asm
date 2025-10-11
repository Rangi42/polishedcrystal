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
	ld [wEnabledPlayerEvents], a
	ret

EnableEvents::
	ld a, $ff
	ld [wEnabledPlayerEvents], a
	ret

EnableWildEncounters:
	ld hl, wEnabledPlayerEvents
	set 4, [hl]
	ret

CheckWarpConnectionsEnabled:
	ld hl, wEnabledPlayerEvents
	bit 2, [hl]
	ret

CheckCoordEventsEnabled:
	ld hl, wEnabledPlayerEvents
	bit 1, [hl]
	ret

CheckStepCountEnabled:
	ld hl, wEnabledPlayerEvents
	bit 0, [hl]
	ret

CheckWildEncountersEnabled:
	ld hl, wEnabledPlayerEvents
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
	jmp DeleteSavedMusic

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
	farcall DoOverworldWeather
	xor a
	ret

MapEvents:
	ld a, [wMapEventStatus]
	and a
	ret nz
	call PlayerEvents
	call DisableEvents
	jmp ScriptEvents

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
	jmp PopBCDEHL

HandleMapTimeAndJoypad:
	ld a, [wMapEventStatus]
	cp MAPEVENTS_OFF
	ret z

	call UpdateTime
	call GetJoypad
	jmp TimeOfDayPals

HandleMapObjects:
	farcall HandleNPCStep ; engine/map_objects.asm
	farcall _HandlePlayerStep
	ld hl, wPlayerStepFlags
	bit PLAYERSTEP_STOP_F, [hl]
	ret z
	farjp CheckObjectEnteringVisibleRange

HandleMapBackground:
	farcall _UpdateSprites
	farcall ScrollScreen
	farcall PlaceMapNameSign
	farjp OWFadePalettesStep

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

PlayerEvents:
	xor a
; If there's already a player event, don't interrupt it.
	ld a, [wScriptRunning]
	and a
	ret nz

	call CheckTrainerEvent
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

CheckTrainerEvent:
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

	call CheckWarpConnectionsEnabled
	jr z, .connections_disabled

	farcall CheckMovingOffEdgeOfMap
	jr c, .map_connection

	call CheckWarpTile
	jr c, .warp_tile

.connections_disabled
	call CheckCoordEventsEnabled
	jr z, .coord_events_disabled

	call CheckCurrentMapCoordEvents
	jr c, .coord_event

.coord_events_disabled
	ld hl, wPlayerStepFlags
	bit PLAYERSTEP_STOP_F, [hl]
	jr z, .no_tile_effects

	ld a, [wPlayerTileCollision]
	cp COLL_COAST_SAND
	call z, RenderShamoutiCoastSand

.no_tile_effects
	call CheckStepCountEnabled
	jr z, .step_count_disabled

	call CountStep
	ret c

.step_count_disabled
	call CheckWildEncountersEnabled
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
	ld a, [wPlayerTileCollision]
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
	jmp CallScript

RenderShamoutiCoastSand:
	call GetBGMapPlayerOffset
	ld de, wFootprintQueue
	ld bc, TILEMAP_WIDTH

	; assume coast sand is tile $1:4f in TILESET_SHAMOUTI_ISLAND;
	; footprint tiles must be in the same VRAM bank
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr z, .bicycle
; walking
	ld a, [wPlayerDirection]
	and %1100
	cp 8
	jr c, .vertical
; horizontal
	add hl, bc
	ld a, $5a ; upper horizontal footprint
	call QueueVolatileTiles
	inc hl
	ld a, $5b ; lower horizontal footprint
	call QueueVolatileTiles
	jmp FinishVolatileTiles

.vertical
	inc hl
	ld a, $58 ; upper-right vertical footprint
	call QueueVolatileTiles
	add hl, bc
	dec hl
	ld a, $59 ; lower-left vertical footprint
	call QueueVolatileTiles
	jmp FinishVolatileTiles

.bicycle
	ld a, [wPlayerDirection]
	and %1100
	cp 8
	jr c, .vertical_bicycle
; horizontal
	add hl, bc
	ld a, $5c ; horizontal bicycle track
	call QueueVolatileTiles
	inc hl
	ld a, $5c ; horizontal bicycle track
	call QueueVolatileTiles
	jmp FinishVolatileTiles

.vertical_bicycle
	ld a, $5d ; vertical bicycle track
	call QueueVolatileTiles
	add hl, bc
	ld a, $5d ; vertical bicycle track
	call QueueVolatileTiles
	jmp FinishVolatileTiles

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
	call GetFarWord
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

	ld hl, wDeferredScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wDeferredScriptBank]
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
	and PAD_A
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

	ldh a, [hObjectStructIndexBuffer]
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	ldh [hLastTalked], a

	call GetMapObject
	ld hl, MAPOBJECT_TYPE
	add hl, bc
	ld a, [hl]

	; failsafe
	cp NUM_OBJECT_TYPES
	ret nc

	cp SILENT_OBJECT_TYPES
	jr nc, .skip_click_sfx
	push af
	call PlayTalkObject
	pop af
.skip_click_sfx

	call StackJumpTable

.Jumptable:
	table_width 2
	dw .script   ; OBJECTTYPE_SCRIPT
	dw .itemball ; OBJECTTYPE_ITEMBALL
	dw .trainer  ; OBJECTTYPE_TRAINER
	dw .trainer  ; OBJECTTYPE_GENERICTRAINER
	dw .pokemon  ; OBJECTTYPE_POKEMON
	dw .command  ; OBJECTTYPE_COMMAND
	dw .script   ; OBJECTTYPE_SCRIPT_SILENT
	dw DoNothing ; OBJECTTYPE_DONOTHING
	assert_table_length NUM_OBJECT_TYPES

.script:
	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapScriptsBank]
	jmp CallScript

.itemball:
	ld hl, MAPOBJECT_SIGHT_RANGE
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
	ld hl, MAPOBJECT_RADIUS
	add hl, bc
	ld a, [hl]
	ld bc, MAPOBJECT_SIGHT_RANGE - MAPOBJECT_RADIUS
	add hl, bc
	ld b, [hl]
	ld c, a
	inc hl
	ld de, wTempScriptBuffer
	ld a, showcrytext_command
	ld [de], a
	inc de
rept 2
	ld a, [hli]
	ld [de], a
	inc de
endr
	ld a, c
	ld [de], a
	inc de
	ld a, b
	ld [de], a
	inc de
	ld a, end_command
	ld [de], a
	jr .callTemporaryScriptBuffer

.command:
	ld hl, MAPOBJECT_SIGHT_RANGE
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
	jmp CallScript

TryBGEvent:
	call CheckFacingBGEvent
	jr c, .IsBGEvent
	xor a
	ret

.IsBGEvent:
	ld a, [wCurBGEventType]
	cp BGEVENT_ITEM
	jr nc, BGEventJumptable.itemifset
	call StackJumpTable

BGEventJumptable:
	table_width 2
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
	assert_table_length NUM_BGEVENTS

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
	jr nz, .dontread

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
	jr nz, .dontread
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
	ld [hl], setval_command ; just to be safe (as opposed to directly writing to hScriptVar)
	jr .callMapScriptAndReturnCarry

CheckBGEventFlag:
	ld hl, wCurBGEventScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, [wMapScriptsBank]
	call GetFarWord
	ld e, l
	ld d, h
	ld b, CHECK_FLAG
	call EventFlagAction
	pop hl
	ret

INCLUDE "engine/events/hidden_item.asm"

PlayerMovement:
	farcall DoPlayerMovement
	ld a, c
	ld hl, PlayerMovementPointers
	call JumpTable
	ld a, c
	ret

PlayerMovementPointers:
; entries correspond to PLAYERMOVEMENT_* constants
	table_width 2
	dw .normal
	dw .warp
	dw .turn
	dw .force_turn
	dw .finish
	dw .continue
	dw .exit_water
	dw .jump
	assert_table_length NUM_PLAYER_MOVEMENTS

.normal:
.finish:
	xor a
	ld c, a
	ret

.jump: ; functionally the same as normal/finish?
	xor a
	ld c, a
	ret

.warp:
	ld a, PLAYEREVENT_WARP
	ld c, a
	scf
	ret

.turn:
	ld a, PLAYEREVENT_JOYCHANGEFACING
	ld c, a
	scf
	ret

.force_turn:
	ld a, BANK(Script_ForcedMovement)
	ld hl, Script_ForcedMovement
	call CallScript
	ld c, a
	scf
	ret

.continue:
.exit_water:
	ld a, -1
	ld c, a
	and a
	ret

CheckMenuOW:
	xor a
	ldh [hMenuReturn], a
	ldh [hMenuReturn + 1], a

	ld a, [wPanningAroundTinyMap]
	and a
	jr nz, .PanningAroundSnowtopMountain

	ldh a, [hJoyPressed]
	bit B_PAD_SELECT, a
	jr nz, .Select
	bit B_PAD_START, a
	jr nz, .Start

	xor a
	ret

.Start:
	ld a, BANK(StartMenuScript)
	ld hl, StartMenuScript
	call CallScript
	scf
	ret

.Select:
	ld a, BANK(SelectMenuScript)
	ld hl, SelectMenuScript
	call CallScript
	scf
	ret

.PanningAroundSnowtopMountain:
	ldh a, [hJoyPressed]
	and PAD_B
	ret z
	ld a, BANK(SnowtopMountainOutsideStopPanningScript)
	ld hl, SnowtopMountainOutsideStopPanningScript
	call CallScript
	scf
	ret

StartMenuScript:
	callasm StartMenu
	sjumpfwd StartMenuCallback

SelectMenuScript:
	callasm SelectMenu
	sjumpfwd SelectMenuCallback

StartMenuCallback:
SelectMenuCallback:
	readmem hMenuReturn
	ifequalfwd HMENURETURN_SCRIPT, .Script
	ifequalfwd HMENURETURN_ASM, .Asm
	end

.Script:
	memjump wQueuedScriptBank

.Asm:
	memcallasm wQueuedScriptBank
	end

CountStep:
	; Don't count steps in link communication rooms.
	ld a, [wLinkMode]
	and a
	jr nz, .done

	; Don't count steps while panning in Snowtop Mountain
	ld a, [wPanningAroundTinyMap]
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
	ldh [hScriptBank], a
	ld a, [hli]
	ldh [hScriptPos], a
	ld a, [hl]
	ldh [hScriptPos + 1], a
	ret

PlayerEventScriptPointers:
; entries correspond to PLAYEREVENT_* constants
	table_width 3
	dba InvalidEventScript       ; PLAYEREVENT_NONE
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
	dba InvalidEventScript       ; (NUM_PLAYER_EVENTS)
	assert_table_length NUM_PLAYER_EVENTS + 1

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
	applymovement PLAYER, .SkyfallMovement
	playsound SFX_STRENGTH
	scall LandAfterPitfallScript
	end

.SkyfallMovement:
	skyfall
	step_end

LandAfterPitfallScript:
	earthquake 16
	end

EdgeWarpScript: ; 4
	reloadend MAPSETUP_CONNECTION

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

LoadMemScript::
; If there's already a script here, don't overwrite.
	ld hl, wMapReentryScriptQueueFlag
	ld a, [hl]
	and a
	ret nz
; Set the flag
	inc a ; 1
	ld [hli], a
; Load the script pointer b:de into (wMapReentryScriptBank):(wMapReentryScriptAddress)
	ld a, b
	ld [hli], a
	ld a, e
	ld [hli], a
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
	jr c, .done
	farcall TryFlashOW
	jr nc, .noevent
.done
	call PlayClickSFX
	ld a, PLAYEREVENT_MAPSCRIPT
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
	call CanUseSweetHoney
	jr nc, .nope
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_SAFARI_GAME_F, [hl]
	jr nz, .safari_game
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .bug_contest
	farcall TryWildEncounter
	jr nz, .nope
.ok
	ld a, [wTempWildMonSpecies]
	cp SUICUNE
	jr nz, .notroamingsuicune
	ld a, BANK(RoamingSuicuneBattleScript)
	ld hl, RoamingSuicuneBattleScript
	jr .done
.notroamingsuicune
	cp RAIKOU
	jr nz, .notroamingraikou
	ld a, BANK(RoamingRaikouBattleScript)
	ld hl, RoamingRaikouBattleScript
	jr .done
.notroamingraikou
	cp ENTEI
	jr nz, .notroaming
	ld a, BANK(RoamingEnteiBattleScript)
	ld hl, RoamingEnteiBattleScript
	jr .done
.notroaming
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

RoamingSuicuneBattleScript:
	randomwildmon
	startbattle
	reloadmapafterbattle
	special CheckBattleCaughtResult
	iffalsefwd .nocatch
	setflag ENGINE_PLAYER_CAUGHT_SUICUNE
.nocatch
	end

RoamingRaikouBattleScript:
	randomwildmon
	startbattle
	reloadmapafterbattle
	special CheckBattleCaughtResult
	iffalsefwd .nocatch
	setflag ENGINE_PLAYER_CAUGHT_RAIKOU
.nocatch
	end

RoamingEnteiBattleScript:
	randomwildmon
	startbattle
	reloadmapafterbattle
	special CheckBattleCaughtResult
	iffalsefwd .nocatch
	setflag ENGINE_PLAYER_CAUGHT_ENTEI
.nocatch
	end

CanUseSweetHoney::
	ld hl, wStatusFlags
	bit STATUSFLAGS_NO_WILD_ENCOUNTERS_F, [hl]
	jr nz, .no
	ld a, [wPlayerTileCollision]
	cp COLL_ICE
	jr z, .no
	and $f0
	cp HI_NYBBLE_CURRENT
	jr z, .no
	ld a, [wEnvironment]
	cp CAVE
	jr z, .skip_grass_check
	cp DUNGEON
	jr z, .skip_grass_check
	farcall CheckGrassCollision
	jr nc, .no
.skip_grass_check
	scf
	ret

.no
	and a
	ret

GetContestLocations:
; Writes to wDexAreaMons. Assumes we're in the correct WRAM bank for this.
; Parameters: e = type, d = region, c = species, b = form.
	; Only Johto has Contests.
	inc d
	dec d
	scf
	ret nz

	ld hl, ContestMons + 1
	ld e, (ContestMonsEnd - ContestMons) / 5
.loop
	ld a, [hli]
	cp c
	ld a, [hli]
	inc hl ; skip level min
	inc hl ; skip level max
	inc hl ; skip (next mon's) encounter rate
	jr nz, .next
	call DexCompareWildForm
	jr z, .found_mon
.next
	dec e
	jr nz, .loop
	scf
	ret
.found_mon
	lb de, GROUP_NATIONAL_PARK, MAP_NATIONAL_PARK
	xor a ; ld a, JOHTO_REGION
	farjp Pokedex_SetWildLandmark

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
	ld de, 5
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
; Form
	ld a, [hli]
	ld [wCurForm], a
	ld [wWildMonForm], a
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
	ld a, [wPlayerTileCollision]
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
	ld a, e
	ld [hld], a
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

INCLUDE "engine/overworld/landmarks.asm"
INCLUDE "engine/overworld/stone_table.asm"
INCLUDE "engine/overworld/scripting.asm"
