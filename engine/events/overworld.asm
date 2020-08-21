FieldMoveJumptableReset:
	xor a
	ld hl, wBuffer1
	ld bc, 7
	rst ByteFill
	ret

FieldMoveJumptable:
	ld a, [wBuffer1]
	call JumpTable
	ld [wBuffer1], a
	bit 7, a
	jr nz, .okay
	and a
	ret

.okay
	and $7f
	scf
	ret

GetPartyNick:
; write wCurPartyMon nickname to wStringBuffer1-3
	ld hl, wPartyMonNicknames
	ld a, BOXMON
	ld [wMonType], a
	ld a, [wCurPartyMon]
	call GetNick
	call CopyName1
; copy text from wStringBuffer2 to wStringBuffer3
	ld de, wStringBuffer2
	ld hl, wStringBuffer3
	jp CopyName2

CheckEngineFlag:
; Check engine flag de
; Return carry if flag is not set
	ld b, CHECK_FLAG
	farcall EngineFlagAction
	ld a, c
	and a
	jr nz, .isset
	scf
	ret
.isset
	xor a
	ret

CheckBadge:
; Check engine flag a (ENGINE_ZEPHYRBADGE thru ENGINE_EARTHBADGE)
; Display "Badge required" text and return carry if the badge is not owned
	call CheckEngineFlag
	ret nc
	ld hl, .BadgeRequiredText
	call MenuTextBoxBackup ; push text to queue
	scf
	ret

.BadgeRequiredText:
	; Sorry! A new BADGE
	; is required.
	text_jump _BadgeRequiredText
	text_end

CheckPartyMove:
; Check if a monster in your party has move d.

	ld e, 0
	xor a
	ld [wCurPartyMon], a
.loop
	ld c, e
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	call IsAPokemon
	jr c, .no

	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Form
	ld a, e
	rst AddNTimes
	bit MON_IS_EGG_F, [hl]
	jr nz, .next
	ld bc, MON_MOVES - MON_FORM
	add hl, bc
	ld b, NUM_MOVES
.check
	ld a, [hli]
	cp d
	jr z, .yes
	dec b
	jr nz, .check

.next
	inc e
	jr .loop

.yes
	ld a, e
	ld [wCurPartyMon], a ; which mon has the move
	xor a
	ret
.no
	scf
	ret

CheckForSurfingPikachu:
	ld d, SURF
	call CheckPartyMove
	jr c, .no
	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	cp PIKACHU
	jr nz, .no
	ld a, TRUE
	ldh [hScriptVar], a
	ret

.no:
	xor a ; FALSE
	ldh [hScriptVar], a
	ret

FieldMovePokepicScript:
	copybytetovar wBuffer6
	refreshscreen
	pokepic 0
	cry 0
	waitsfx
	closepokepic
	reloadmappart
	end

FieldMoveFailed:
	ld hl, .CantUseHere
	jp MenuTextBoxBackup

.CantUseHere:
	; Can't use that here.
	text_jump UnknownText_0x1c05c8
	text_end

CutFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:

	dw .CheckAble
	dw .DoCut
	dw .FailCut

.CheckAble:
	ld de, ENGINE_HIVEBADGE
	call CheckBadge
	jr c, .nohivebadge
	call CheckMapForSomethingToCut
	jr c, .nothingtocut
	ld a, $1
	ret

.nohivebadge
	ld a, $80
	ret

.nothingtocut
	ld a, $2
	ret

.DoCut:
	ld hl, Script_CutFromMenu
	call QueueScript
	ld a, $81
	ret

.FailCut:
	ld hl, Text_NothingToCut
	call MenuTextBoxBackup
	ld a, $80
	ret

Text_NothingToCut:
	; There's nothing to CUT here.
	text_jump UnknownText_0x1c05ec
	text_end

CheckMapForSomethingToCut:
	call GetFacingObject
	jr c, .no_tree
	ld a, d
	cp SPRITEMOVEDATA_CUTTABLE_TREE
	jr z, .tree
.no_tree
	; Does the collision data of the facing tile permit cutting?
	call GetFacingTileCoord
	ld c, a
	push de
	farcall CheckCutCollision
	pop de
	jr nc, .fail
	; Get the location of the current block in wOverworldMapBlocks.
	call GetBlockLocation
	ld c, [hl]
	; See if that block contains something that can be cut.
	push hl
	ld hl, CutGrassBlockPointers
	call CheckOverworldTileArrays
	pop hl
	jr nc, .fail
	; Back up the wOverworldMapBlocks address to wBuffer3
	ld a, l
	ld [wBuffer3], a
	ld a, h
	ld [wBuffer4], a
	; Back up the replacement tile to wBuffer5
	ld a, b
	ld [wBuffer5], a
	; Back up the animation index to wBuffer6
	ld a, $1
	ld [wBuffer6], a
	xor a
	ret

.tree
	xor a
	ld [wBuffer6], a
	ret

.fail
	scf
	ret

Script_CutFromMenu:
	reloadmappart
	special UpdateTimePals
	callasm GetBuffer6
	ifequal $0, Script_CutTree
;Script_CutGrass:
	callasm PrepareOverworldMove
	farwritetext UnknownText_0x1c05dd
	closetext
	scall FieldMovePokepicScript
	callasm CutDownGrass
	endtext

GetBuffer6:
	ld a, [wBuffer6]
	ldh [hScriptVar], a
	ret

CutDownGrass:
	ld hl, wBuffer3 ; OverworldMapTile
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wBuffer5] ; ReplacementTile
	ld [hl], a
	xor a
	ldh [hBGMapMode], a
	call LoadMapPart
	call UpdateSprites
	call DelayFrame
	ld a, [wBuffer6] ; Animation type (always 1)
	ld e, a
	farcall OWCutAnimation
	call BufferScreen
	call GetMovementPermissions
	call UpdateSprites
	jp DelayFrame

CheckOverworldTileArrays:
	; Input: c contains the tile you're facing
	; Output: Replacement tile in b and effect on wild encounters in c, plus carry set.
	;         Carry is not set if the facing tile cannot be replaced, or if the tileset
	;         does not contain a tile you can replace.

	; Dictionary lookup for pointer to tile replacement table
	push bc
	ld a, [wMapTileset]
	ld de, 3
	call IsInArray
	pop bc
	jr nc, .nope
	; Load the pointer
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; Look up the tile you're facing
	ld de, 2
	ld a, c
	call IsInArray
	jr nc, .nope
	; Load the replacement to b
	inc hl
	ld b, [hl]
	scf
	ret

.nope
	xor a
	ret

INCLUDE "data/events/field_move_blocks.asm"

Script_CutTree:
	callasm PrepareOverworldMove
	farwritetext UnknownText_0x1c05dd
	closetext
	waitsfx
	scall FieldMovePokepicScript
	setflag ENGINE_AUTOCUT_ACTIVE
	disappear -2
	callasm CutDownTree
	endtext

AutoCutTreeScript:
	callasm RefreshScreenFast
	disappear -2
	callasm CutDownTree
	endtext

CutDownTree:
	xor a
	ldh [hBGMapMode], a
	call LoadMapPart
	call UpdateSprites
	call DelayFrame
	xor a ; Animation type
	ld e, a
	farcall OWCutAnimation
	call BufferScreen
	call GetMovementPermissions
	call UpdateSprites
	call DelayFrame
	jp LoadStandardFont

OWFlash:
	call .CheckUseFlash
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.CheckUseFlash:
; Flash
	push hl
	farcall SpecialAerodactylChamber
	pop hl
	jr c, .useflash
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	jr nz, .notadarkcave
.useflash
	call UseFlash
	ld a, $81
	ret

.notadarkcave
	call FieldMoveFailed
	ld a, $80
	ret

UseFlash:
	ld hl, Script_UseFlash
	jp QueueScript

Script_UseFlash:
	reloadmappart
	special UpdateTimePals
	callasm PrepareOverworldMove
	scall FieldMovePokepicScript
	opentext
	writetext UnknownText_0xc8f3
	callasm BlindingFlash
	endtext

UnknownText_0xc8f3:
	text_jump UnknownText_0x1c0609
	start_asm
	call WaitSFX
	ld de, SFX_FLASH
	call PlaySFX
	call WaitSFX
	ld hl, EmptyString
	ret

SurfFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .TrySurf
	dw .DoSurf
	dw .FailSurf
	dw .AlreadySurfing

.TrySurf:
	ld de, ENGINE_FOGBADGE
	call CheckBadge
	jr c, .asm_c956
	ld hl, wOWState
	bit OWSTATE_BIKING_FORCED, [hl]
	jr nz, .cannotsurf
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .alreadyfail
	cp PLAYER_SURF_PIKA
	jr z, .alreadyfail
	call GetFacingTileCoord
	call GetTileCollision
	dec a ; cp WATER_TILE
	jr nz, .cannotsurf
	call CheckDirection
	jr c, .cannotsurf
	farcall CheckFacingObject
	jr c, .cannotsurf
	ld a, $1
	ret
.asm_c956
	ld a, $80
	ret
.alreadyfail
	ld a, $3
	ret
.cannotsurf
	ld a, $2
	ret

.DoSurf:
	call GetSurfType
	ld [wBuffer2], a
	call GetPartyNick
	ld hl, SurfFromMenuScript
	call QueueScript
	ld a, $81
	ret

.FailSurf:
	ld hl, CantSurfText
	call MenuTextBoxBackup
	ld a, $80
	ret

.AlreadySurfing:
	ld hl, AlreadySurfingText
	call MenuTextBoxBackup
	ld a, $80
	ret

SurfFromMenuScript:
	special UpdateTimePals

UsedSurfScript:
	callasm PrepareOverworldMove
	farwritetext _UsedSurfText
	waitbutton
	closetext

	setflag ENGINE_AUTOSURF_ACTIVE
	scall FieldMovePokepicScript

AutoSurfScript:
	copybytetovar wBuffer2
	writevarcode VAR_MOVEMENT

	special UpdatePlayerSprite
	special PlayMapMusic
; step into the water
	special Special_SurfStartStep ; (slow_step_x, step_end)
	applymovement PLAYER, wMovementBuffer ; PLAYER, MovementBuffer
	end

CantSurfText:
	text_jump _CantSurfText
	text_end

AlreadySurfingText:
	text_jump _AlreadySurfingText
	text_end

GetSurfType:
; Surfing on Pikachu uses an alternate sprite.
; This is done by using a separate movement type.

	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de

	ld a, [hl]
	cp PIKACHU
	ld a, PLAYER_SURF_PIKA
	ret z
	ld a, PLAYER_SURF
	ret

CheckDirection:
; Return carry if a tile permission prevents you
; from moving in the direction you're facing.

; Get player direction
	ld a, [wPlayerDirection]
	and %00001100 ; bits 2 and 3 contain direction
	rrca
	rrca
	ld e, a
	ld d, 0
	ld hl, .Directions
	add hl, de

; Can you walk in this direction?
	ld a, [wTilePermissions]
	and [hl]
	jr nz, .quit
	xor a
	ret

.quit
	scf
	ret

.Directions:
	db FACE_DOWN
	db FACE_UP
	db FACE_LEFT
	db FACE_RIGHT

TrySurfOW::
; Checking a tile in the overworld.
; Return carry if fail is allowed.

; Don't ask to surf if already fail.
	ld a, [wPlayerState]
	cp PLAYER_SURF_PIKA
	jr z, .quit
	cp PLAYER_SURF
	jr z, .quit

; Must be facing water.
	ld a, [wEngineBuffer1]
	call GetTileCollision
	dec a ; cp WATER_TILE
	jr nz, .quit

; Check tile permissions.
	call CheckDirection
	jr c, .quit

	ld de, ENGINE_FOGBADGE
	call CheckEngineFlag
	jr c, .quit

	ld d, SURF
	call CheckPartyMove
	jr c, .quit

	ld hl, wOWState
	bit OWSTATE_BIKING_FORCED, [hl]
	jr nz, .quit

	call GetSurfType
	ld [wBuffer2], a
	call GetPartyNick

	ld a, BANK(AskSurfScript)
	ld hl, AskSurfScript
	call CallScript

	scf
	ret

.quit
	xor a
	ret

AskSurfScript:
	checkflag ENGINE_AUTOSURF_ACTIVE
	iftrue AutoSurfScript
	opentext
	farwritetext _AskSurfText
	yesorno
	iftrue UsedSurfScript
	endtext

CheckFlyAllowedOnMap:
; returns z is fly is allowed
	call GetMapEnvironment
	call CheckOutdoorMap
	ret z
; assumes all special roof maps are in different groups
	ld a, [wMapGroup]
	cp GROUP_GOLDENROD_DEPT_STORE_ROOF
	jr z, .goldenrod_dept_store_roof_group
	cp GROUP_CELADON_MANSION_ROOF
	jr z, .celadon_mansion_roof_group
	cp GROUP_TIN_TOWER_ROOF
	jr z, .tin_tower_roof_group
	cp GROUP_OLIVINE_LIGHTHOUSE_ROOF
	ret nz
	ld a, [wMapNumber]
	cp MAP_OLIVINE_LIGHTHOUSE_ROOF
	ret
.goldenrod_dept_store_roof_group
	ld a, [wMapNumber]
	cp MAP_GOLDENROD_DEPT_STORE_ROOF
	ret
.celadon_mansion_roof_group
	ld a, [wMapNumber]
	cp MAP_CELADON_MANSION_ROOF
	ret
.tin_tower_roof_group
	ld a, [wMapNumber]
	cp MAP_TIN_TOWER_ROOF
	ret

FlyFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .TryFly
	dw .DoFly
	dw .FailFly

.TryFly:
; Fly
	ld de, ENGINE_STORMBADGE
	call CheckBadge
	jr c, .nostormbadge
	call CheckFlyAllowedOnMap
	jr nz, .indoors

	ld a, [wMapGroup]
	cp GROUP_SHAMOUTI_ISLAND
	jr z, .indoors
	cp GROUP_VALENCIA_ISLAND
	jr z, .indoors
	cp GROUP_SHAMOUTI_SHRINE_RUINS
	jr nz, .outdoors
	ld a, [wMapNumber]
	cp MAP_SHAMOUTI_SHRINE_RUINS
	jr z, .indoors

.outdoors
	xor a
	ldh [hMapAnims], a
	call LoadStandardMenuHeader
	call ClearSprites
	farcall _FlyMap
	ld a, e
	cp -1
	jr z, .illegal
	cp NUM_SPAWNS
	jr nc, .illegal

	ld [wDefaultSpawnpoint], a
	call CloseWindow
	ld a, $1
	ret

.nostormbadge
	ld a, $82
	ret

.indoors
	ld a, $2
	ret

.illegal
	call CloseWindow
	call ApplyTilemapInVBlank
	ld a, $80
	ret

.DoFly:
	ld hl, .FlyScript
	call QueueScript
	ld a, $81
	ret

.FailFly:
	call FieldMoveFailed
	ld a, $82
	ret

.FlyScript:
	reloadmappart
	callasm HideSprites
	special UpdateTimePals
	callasm PrepareOverworldMove
	scall FieldMovePokepicScript
	callasm FlyFromAnim
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	callasm SkipUpdateMapSprites
	writecode VAR_MOVEMENT, PLAYER_NORMAL
	newloadmap MAPSETUP_FLY
	callasm FlyToAnim
	special WaitSFX
	callasm .ReturnFromFly
	end

.ReturnFromFly:
	farcall ReturnFromFly_SpawnOnlyPlayer
	call DelayFrame
	jp UpdatePlayerSprite

WaterfallFunction:
	call .TryWaterfall
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.TryWaterfall:
; Waterfall
	ld de, ENGINE_RISINGBADGE
	farcall CheckBadge
	ld a, $80
	ret c
	call CheckMapCanWaterfall
	jr c, .failed
	ld hl, Script_WaterfallFromMenu
	call QueueScript
	ld a, $81
	ret

.failed
	call FieldMoveFailed
	ld a, $80
	ret

CheckMapCanWaterfall:
	ld a, [wPlayerDirection]
	and FACE_UP | FACE_DOWN
	cp FACE_UP
	jr nz, .failed
	ld a, [wTilePermissions]
	and FACE_UP
	jr nz, .failed
	ld a, [wTileUp]
	cp COLL_WATERFALL
	jr nz, .failed
	xor a
	ret

.failed
	scf
	ret

Script_WaterfallFromMenu:
	reloadmappart
	special UpdateTimePals

Script_UsedWaterfall:
	callasm PrepareOverworldMove
	farwritetext UnknownText_0x1c068e
	waitbutton
	closetext
	scall FieldMovePokepicScript
	setflag ENGINE_AUTOWATERFALL_ACTIVE
Script_AutoWaterfall:
	playsound SFX_BUBBLE_BEAM
.loop
	applymovement PLAYER, .WaterfallStep
	callasm .CheckContinueWaterfall
	iffalse .loop
	end

.CheckContinueWaterfall:
	xor a
	ldh [hScriptVar], a
	ld a, [wPlayerStandingTile]
	cp COLL_WATERFALL
	ret z
	ld a, $1
	ldh [hScriptVar], a
	ret

.WaterfallStep:
	turn_waterfall_up
	step_end

TryWaterfallOW::
	ld d, WATERFALL
	call CheckPartyMove
	jr c, .failed
	ld de, ENGINE_RISINGBADGE
	call CheckEngineFlag
	jr c, .failed
	call CheckMapCanWaterfall
	jr c, .failed
	ld a, BANK(Script_AskWaterfall)
	ld hl, Script_AskWaterfall
	call CallScript
	scf
	ret

.failed
	ld a, BANK(Script_CantDoWaterfall)
	ld hl, Script_CantDoWaterfall
	call CallScript
	scf
	ret

Script_CantDoWaterfall:
	farjumptext UnknownText_0x1c06a3

Script_AskWaterfall:
	checkflag ENGINE_AUTOWATERFALL_ACTIVE
	iftrue Script_AutoWaterfall
	opentext
	farwritetext UnknownText_0x1c06bf
	yesorno
	iftrue Script_UsedWaterfall
	endtext

EscapeRopeFunction:
	call FieldMoveJumptableReset
	ld a, $1
	jr EscapeRopeOrDig

DigFunction:
	call FieldMoveJumptableReset
	ld a, $2

EscapeRopeOrDig:
	ld [wBuffer2], a
.loop
	ld hl, .DigTable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.DigTable:
	dw .CheckCanDig
	dw .DoDig
	dw .FailDig

.CheckCanDig:
	call GetMapEnvironment
	cp CAVE
	jr z, .incave
	cp DUNGEON
	jr z, .incave
.fail
	ld a, $2
	ret

.incave
	ld hl, wDigWarpNumber
	ld a, [hli]
	and a
	jr z, .fail
	ld a, [hli]
	and a
	jr z, .fail
	ld a, [hl]
	and a
	jr z, .fail
	ld a, $1
	ret

.DoDig:
	ld hl, wDigWarpNumber
	ld de, wNextWarp
	ld bc, 3
	rst CopyBytes
	ld a, [wBuffer2]
	cp $2
	jr nz, .escaperope
	call GetPartyNick
	ld hl, .UsedDigScript
	call QueueScript
	ld a, $81
	ret

.escaperope
	farcall SpecialKabutoChamber
	ld hl, .UsedEscapeRopeScript
	call QueueScript
	ld a, $81
	ret

.FailDig:
	ld a, [wBuffer2]
	cp $2
	jr nz, .failescaperope
	ld hl, .Text_CantUseHere
	call MenuTextBox
	call WaitPressAorB_BlinkCursor
	call CloseWindow

.failescaperope
	ld a, $80
	ret

.Text_CantUseHere:
	; Can't use that here.
	text_jump UnknownText_0x1c0705
	text_end

.UsedEscapeRopeScript:
	reloadmappart
	special UpdateTimePals
	farwritetext UnknownText_0x1c06ed
	waitbutton
	closetext
	jump .UsedDigOrEscapeRopeScript

.UsedDigScript:
	reloadmappart
	special UpdateTimePals
	callasm PrepareOverworldMove
	farwritetext UnknownText_0x1c06de
	waitbutton
	closetext
	scall FieldMovePokepicScript

.UsedDigOrEscapeRopeScript:
	playsound SFX_WARP_TO
	applymovement PLAYER, .DigOut
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	writecode VAR_MOVEMENT, PLAYER_NORMAL
	newloadmap MAPSETUP_DOOR
	playsound SFX_WARP_FROM
	applymovement PLAYER, .DigReturn
	end

.DigOut:
	step_dig 32
	hide_object
	step_end

.DigReturn:
	show_object
	return_dig 32
	step_end

TeleportFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, .Jumptable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.Jumptable:
	dw .TryTeleport
	dw .DoTeleport
	dw .FailTeleport

.TryTeleport:
	call CheckFlyAllowedOnMap
	jr nz, .nope
	ld a, [wLastSpawnMapGroup]
	ld d, a
	ld a, [wLastSpawnMapNumber]
	ld e, a
	farcall IsSpawnPoint
	jr nc, .nope
	ld a, c
	ld [wDefaultSpawnpoint], a
	ld a, $1
	ret

.nope
	ld a, $2
	ret

.DoTeleport:
	call GetPartyNick
	ld hl, .TeleportScript
	call QueueScript
	ld a, $81
	ret

.FailTeleport:
	ld hl, .Text_CantUseHere
	call MenuTextBoxBackup
	ld a, $80
	ret

.Text_CantUseHere:
	; Can't use that here.
	text_jump UnknownText_0x1c073b
	text_end

.TeleportScript:
	reloadmappart
	special UpdateTimePals
	playsound SFX_WARP_TO
	applymovement PLAYER, .TeleportFrom
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	writecode VAR_MOVEMENT, PLAYER_NORMAL
	newloadmap MAPSETUP_TELEPORT
	playsound SFX_WARP_FROM
	applymovement PLAYER, .TeleportTo
	end

.TeleportFrom:
	teleport_from
	step_end

.TeleportTo:
	teleport_to
	step_end

StrengthFunction:
	call .TryStrength
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.TryStrength:
; Strength
	ld de, ENGINE_PLAINBADGE
	call CheckBadge
	jr nc, .UseStrength

.Failed:
	ld a, $80
	ret

.UseStrength:
	ld hl, Script_StrengthFromMenu
	call QueueScript
	ld a, $81
	ret

SetStrengthFlag:
	ld hl, wOWState
	set OWSTATE_STRENGTH, [hl]
PrepareOverworldMove:
	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wBuffer6], a
	jp GetPartyNick

Script_StrengthFromMenu:
	reloadmappart
	special UpdateTimePals

Script_UsedStrength:
	callasm SetStrengthFlag
	farwritetext UnknownText_0x1c0774
	waitbutton
	closetext
	scall FieldMovePokepicScript
	opentext
	farwritetext UnknownText_0x1c0788
	endtext

AskStrengthScript:
	callasm TryStrengthOW
	iffalse .AskStrength
	ifequal $1, .DontMeetRequirements
	jump .AlreadyUsedStrength

.DontMeetRequirements:
	farjumptext UnknownText_0x1c07f4

.AlreadyUsedStrength:
	farjumptext UnknownText_0x1c07d8

.AskStrength:
	opentext
	farwritetext UnknownText_0x1c07a0
	yesorno
	iftrue Script_UsedStrength
	endtext

TryStrengthOW:
	ld d, STRENGTH
	call CheckPartyMove
	jr c, .nope

	ld de, ENGINE_PLAINBADGE
	call CheckEngineFlag
	jr c, .nope

	ld hl, wOWState
	bit OWSTATE_STRENGTH, [hl]
	jr z, .already_using

	ld a, 2
	jr .done

.nope
	ld a, 1
	jr .done

.already_using
	xor a
	; fallthrough

.done
	ldh [hScriptVar], a
	ret

WhirlpoolFunction:
	call FieldMoveJumptableReset
.loop
	ld hl, Jumptable_cdae
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

Jumptable_cdae:
	dw .TryWhirlpool
	dw .DoWhirlpool
	dw .FailWhirlpool

.TryWhirlpool:
	ld de, ENGINE_GLACIERBADGE
	call CheckBadge
	jr c, .noglacierbadge
	call TryWhirlpoolMenu
	jr c, .failed
	ld a, $1
	ret

.failed
	ld a, $2
	ret

.noglacierbadge
	ld a, $80
	ret

.DoWhirlpool:
	ld hl, Script_WhirlpoolFromMenu
	call QueueScript
	ld a, $81
	ret

.FailWhirlpool:
	call FieldMoveFailed
	ld a, $80
	ret

TryWhirlpoolMenu:
	call GetFacingTileCoord
	ld c, a
	cp COLL_WHIRLPOOL
	jr nz, .failed
	call GetBlockLocation
	ld c, [hl]
	push hl
	ld hl, WhirlpoolBlockPointers
	call CheckOverworldTileArrays
	pop hl
	jr nc, .failed
	ld a, l
	ld [wBuffer3], a
	ld a, h
	ld [wBuffer4], a
	ld a, b
	ld [wBuffer5], a
	xor a
	ld [wBuffer6], a
	ret

.failed
	scf
	ret

Script_WhirlpoolFromMenu:
	reloadmappart
	special UpdateTimePals

Script_UsedWhirlpool:
	callasm PrepareOverworldMove
	farwritetext UnknownText_0x1c0816
	closetext
	scall FieldMovePokepicScript
	setflag ENGINE_AUTOWHIRLPOOL_ACTIVE
	waitsfx

Script_AutoWhirlpool:
	playsound SFX_SURF
	checkcode VAR_FACING
	ifequal UP, .Up
	ifequal DOWN, .Down
	ifequal RIGHT, .Right
	applymovement PLAYER, .LeftMovementData
	end

.Up:
	applymovement PLAYER, .UpMovementData
	end

.Right:
	applymovement PLAYER, .RightMovementData
	end

.Down:
	applymovement PLAYER, .DownMovementData
	end

.UpMovementData:
	slow_step_up
	slow_step_up
	step_end

.RightMovementData:
	slow_step_right
	slow_step_right
	step_end

.DownMovementData:
	slow_step_down
	slow_step_down
	step_end

.LeftMovementData:
	slow_step_left
	slow_step_left
	step_end

TryWhirlpoolOW::
	ld d, WHIRLPOOL
	call CheckPartyMove
	jr c, .failed
	ld de, ENGINE_GLACIERBADGE
	call CheckEngineFlag
	jr c, .failed
	call TryWhirlpoolMenu
	jr c, .failed
	ld a, BANK(Script_AskWhirlpoolOW)
	ld hl, Script_AskWhirlpoolOW
	call CallScript
	scf
	ret

.failed
	ld a, BANK(Script_MightyWhirlpool)
	ld hl, Script_MightyWhirlpool
	call CallScript
	scf
	ret

Script_MightyWhirlpool:
	farjumptext UnknownText_0x1c082b

Script_AskWhirlpoolOW:
	checkflag ENGINE_AUTOWHIRLPOOL_ACTIVE
	iftrue Script_AutoWhirlpool
	opentext
	farwritetext UnknownText_0x1c0864
	yesorno
	iftrue Script_UsedWhirlpool
	endtext

HeadbuttFunction:
	call TryHeadbuttFromMenu
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

TryHeadbuttFromMenu:
	call GetFacingTileCoord
	cp COLL_HEADBUTT_TREE
	jr nz, .no_tree

	ld hl, HeadbuttFromMenuScript
	call QueueScript
	ld a, $81
	ret

.no_tree
	call FieldMoveFailed
	ld a, $80
	ret

HeadbuttFromMenuScript:
	reloadmappart
	special UpdateTimePals

HeadbuttScript:
	callasm PrepareOverworldMove
	farwritetext UnknownText_0x1c0897
	closetext

	scall FieldMovePokepicScript
	setflag ENGINE_HEADBUTT_ACTIVE

AutoHeadbuttScript:
	refreshscreen
	callasm ShakeHeadbuttTree

	callasm TreeMonEncounter
	iffalse .no_battle
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

.no_battle
	callasm TreeItemEncounter
	iffalse .no_item
	opentext
	verbosegiveitem ITEM_FROM_MEM
	endtext

.no_item
	farjumptext UnknownText_0x1c08ac

TryHeadbuttOW::
	ld d, HEADBUTT
	call CheckPartyMove
	jr c, .no

	ld a, BANK(AskHeadbuttScript)
	ld hl, AskHeadbuttScript
	call CallScript
	scf
	ret

.no
	xor a
	ret

AskHeadbuttScript:
	checkflag ENGINE_HEADBUTT_ACTIVE
	iftrue AutoHeadbuttScript
	opentext
	farwritetext UnknownText_0x1c08bc
	yesorno
	iftrue HeadbuttScript
	endtext

RockSmashFunction:
	call TryRockSmashFromMenu
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

TryRockSmashFromMenu:
	call GetFacingObject
	jr c, .no_rock
	ld a, d
	cp SPRITEMOVEDATA_SMASHABLE_ROCK
	jr nz, .no_rock

	ld hl, RockSmashFromMenuScript
	call QueueScript
	ld a, $81
	ret

.no_rock
	call FieldMoveFailed
	ld a, $80
	ret

GetFacingObject:
	farcall CheckFacingObject
	jr nc, .fail

	ldh a, [hObjectStructIndexBuffer]
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	ldh [hLastTalked], a
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	ld d, a
	and a
	ret

.fail
	scf
	ret

RockSmashFromMenuScript:
	reloadmappart
	special UpdateTimePals

RockSmashScript:
	callasm PrepareOverworldMove
	farwritetext UnknownText_0x1c08f0
	closetext
	waitsfx
	scall FieldMovePokepicScript
	setflag ENGINE_ROCK_SMASH_ACTIVE
AutoRockSmashScript:
	playsound SFX_STRENGTH
	earthquake 84
	applymovement2 MovementData_0xcf55
	disappear -2

	callasm RockMonEncounter
	copybytetovar wTempWildMonSpecies
	iffalse .no_battle
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

.no_battle
	callasm RockItemEncounter
	iffalse .no_item
	opentext
	verbosegiveitem ITEM_FROM_MEM
	closetext
.no_item
	end

MovementData_0xcf55:
	rock_smash 10
	step_end

AskRockSmashScript:
	callasm HasRockSmash
	ifequal 1, .no

	checkflag ENGINE_ROCK_SMASH_ACTIVE
	iftrue AutoRockSmashScript
	opentext
	farwritetext UnknownText_0x1c0924
	yesorno
	iftrue RockSmashScript
	endtext

.no
	farjumptext UnknownText_0x1c0906

HasRockSmash:
	ld d, ROCK_SMASH
	call CheckPartyMove
	; a = carry ? 1 : 0
	sbc a
	and 1
	ldh [hScriptVar], a
	ret

FishFunction:
	ld a, e
	push af
	call FieldMoveJumptableReset
	pop af
	ld [wBuffer2], a
.loop
	ld hl, .FishTable
	call FieldMoveJumptable
	jr nc, .loop
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.FishTable:
	dw .TryFish
	dw .FishNoBite
	dw .FishGotSomething
	dw .FailFish
	dw .FishNoFish
	dw .FishGotItem

.TryFish:
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .fail
	cp PLAYER_SURF_PIKA
	jr z, .fail
	call GetFacingTileCoord
	call GetTileCollision
	dec a ; cp WATER_TILE
	jr z, .facingwater
.fail
	ld a, $3
	ret

.facingwater
	call GetFishingGroup
	and a
	jr nz, .goodtofish
	ld a, $4
	ret

.goodtofish
	ld d, a
	ld a, [wBuffer2]
	ld e, a

	; Suction Cups and Sticky Hold boost bite rate. This is done
	; by having these abilities result in 2 attempts being made
	; for getting an encounter.
	call GetLeadAbility
	cp SUCTION_CUPS
	jr z, .fish_attempt1
	cp STICKY_HOLD
	jr nz, .fish_attempt2
.fish_attempt1
	push de
	farcall Fish
	ld a, d
	and a
	jr nz, .gotabite1
	pop de
.fish_attempt2
	farcall Fish
	ld a, d
	and a
	jr nz, .gotabite2
	ld a, e
	and a
	jr z, .nonibble
.gotanitem
	ld a, e
	ld [wCurItem], a
	ld a, $5
	ret

.gotabite1
	ld [wTempWildMonSpecies], a
	ld a, e
	pop de
	ld e, a
	ld a, [wTempWildMonSpecies]
.gotabite2
	ld [wTempWildMonSpecies], a
	ld a, e
	ld [wCurPartyLevel], a
	ld a, BATTLETYPE_FISH
	ld [wBattleType], a
	ld a, $2
	ret

.nonibble
	ld a, $1
	ret

.FailFish:
	ld a, $80
	ret

.FishGotSomething:
	ld a, $1
	ld [wBuffer6], a
	ld hl, Script_GotABite
	call QueueScript
	ld a, $81
	ret

.FishNoBite:
	ld a, $2
	ld [wBuffer6], a
	ld hl, Script_NotEvenANibble
	call QueueScript
	ld a, $81
	ret

.FishNoFish:
	xor a
	ld [wBuffer6], a
	ld hl, Script_NotEvenANibble
	call QueueScript
	ld a, $81
	ret

.FishGotItem:
	ld a, $1
	ld [wBuffer6], a
	ld hl, Script_GotAnItem
	call QueueScript
	ld a, $81
	ret

Script_NotEvenANibble:
	scall Script_FishCastRod
	farwritetext UnknownText_0x1c0965
	closetext
	callasm PutTheRodAway
	end

Script_GotAnItem:
	scall Script_FishCastRod
	iffalse .NotFacingUp
	applymovement PLAYER, Movement_HookedItemFacingUp
	jump .GetTheHookedItem
.NotFacingUp:
	applymovement PLAYER, Movement_HookedItemNotFacingUp
.GetTheHookedItem:
	pause 40
	applymovement PLAYER, Movement_RestoreRod
	callasm PutTheRodAway
	callasm CurItemToScriptVar
	opentext
	verbosegiveitem ITEM_FROM_MEM
	endtext

Script_GotABite:
	scall Script_FishCastRod
	callasm Fishing_CheckFacingUp
	iffalse .NotFacingUp
	applymovement PLAYER, Movement_BiteFacingUp
	jump .FightTheHookedPokemon
.NotFacingUp:
	applymovement PLAYER, Movement_BiteNotFacingUp
.FightTheHookedPokemon:
	pause 40
	applymovement PLAYER, Movement_RestoreRod
	farwritetext UnknownText_0x1c0958
	closetext
	callasm PutTheRodAway
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

Movement_BiteNotFacingUp:
	fish_got_bite
	fish_got_bite
	fish_got_bite
Movement_HookedItemNotFacingUp:
	fish_got_bite
	show_emote
	step_end

Movement_BiteFacingUp:
	fish_got_bite
	fish_got_bite
	fish_got_bite
Movement_HookedItemFacingUp:
	fish_got_bite
	step_sleep_1
	show_emote
	step_end

Movement_RestoreRod:
	hide_emote
	fish_cast_rod
	step_end

Fishing_CheckFacingUp:
	ld a, [wPlayerDirection]
	and $c
	cp OW_UP
	ld a, $1
	jr z, .up
	xor a

.up
	ldh [hScriptVar], a
	ret

Script_FishCastRod:
	reloadmappart
	loadvar hBGMapMode, $0
	special UpdateTimePals
	callasm LoadFishingGFX
	loademote EMOTE_SHOCK
	applymovement PLAYER, MovementData_0xd093
	pause 40
	end

MovementData_0xd093:
	fish_cast_rod
	step_end

PutTheRodAway:
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ld [wPlayerAction], a
	call UpdateSprites
	jp UpdatePlayerSprite

CurItemToScriptVar:
	ld a, [wCurItem]
	ldh [hScriptVar], a
	ret

BikeFunction:
	call .TryBike
	and $7f
	ld [wFieldMoveSucceeded], a
	ret

.TryBike:
	call .CheckEnvironment
	jr c, .CannotUseBike
	ld a, [wPlayerState]
	and a ; cp PLAYER_NORMAL
	jr z, .GetOnBike
	cp PLAYER_BIKE
	jr z, .GetOffBike
	jr .CannotUseBike

.GetOnBike:
	ld hl, Script_GetOnBike
	ld de, Script_GetOnBike_Register
	call .CheckIfRegistered
	jr .done

.GetOffBike:
	ld hl, wOWState
	bit OWSTATE_BIKING_FORCED, [hl]
	jr nz, .CantGetOffBike
	ld hl, Script_GetOffBike
	ld de, Script_GetOffBike_Register
	call .CheckIfRegistered
	jr .done

.CantGetOffBike:
	ld hl, Script_CantGetOffBike
	jr .done

.CannotUseBike:
	xor a
	ret

.done
	call QueueScript
	ld a, $1
	ret

.CheckIfRegistered:
	ld a, [wUsingItemWithSelect]
	and a
	ret z
	ld h, d
	ld l, e
	ret

.CheckEnvironment:
	call GetMapEnvironment
	call CheckOutdoorMap
	jr z, .ok
	cp CAVE
	jr z, .ok
	cp GATE
	jr z, .ok
	cp ENVIRONMENT_5
	jr nz, .nope

.ok
	call GetPlayerStandingTile
	and a ; LAND_TILE (can't use our bike except on land)
	jr nz, .nope
	xor a
	ret

.nope
	scf
	ret

Script_GetOnBike:
	reloadmappart
	special UpdateTimePals
	writecode VAR_MOVEMENT, PLAYER_BIKE
	farwritetext UnknownText_0x1c09b2
	waitbutton
FinishGettingOnBike:
	closetext
	special UpdatePlayerSprite
	special PlayMapMusic
	end

Script_GetOnBike_Register:
	writecode VAR_MOVEMENT, PLAYER_BIKE
	jump FinishGettingOnBike

Script_GetOffBike:
	reloadmappart
	special UpdateTimePals
	writecode VAR_MOVEMENT, PLAYER_NORMAL
	farwritetext UnknownText_0x1c09c7
	waitbutton
FinishGettingOffBike:
	closetext
	special UpdatePlayerSprite
	special PlayMapMusic
	end

Script_GetOffBike_Register:
	writecode VAR_MOVEMENT, PLAYER_NORMAL
	jump FinishGettingOffBike

Script_CantGetOffBike:
	farwritetext UnknownText_0x1c099a
	waitendtext

HasCutAvailable::
	ld d, CUT
	call CheckPartyMove
	jr c, .no

	ld de, ENGINE_HIVEBADGE
	call CheckEngineFlag
	jr c, .no

.yes
	xor a
	jr .done

.no
	ld a, 1
.done
	ldh [hScriptVar], a
	ret

AskCutTreeScript:
	callasm HasCutAvailable
	ifequal 1, .no

	checkflag ENGINE_AUTOCUT_ACTIVE
	iftrue AutoCutTreeScript
	opentext
	farwritetext UnknownText_0x1c09dd
	yesorno
	iftrue Script_CutTree
	endtext

.no
	farjumptext UnknownText_0x1c0a05
