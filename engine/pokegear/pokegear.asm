; Pokégear cards
	const_def
	const POKEGEARCARD_CLOCK ; 0
	const POKEGEARCARD_MAP   ; 1
	const POKEGEARCARD_PHONE ; 2
	const POKEGEARCARD_RADIO ; 3
DEF NUM_POKEGEAR_CARDS EQU const_value

DEF PHONE_DISPLAY_HEIGHT EQU 4

; PokegearJumptable.Jumptable indexes
	const_def
	const POKEGEARSTATE_CLOCKINIT       ; 0
	const POKEGEARSTATE_CLOCKJOYPAD     ; 1
	const POKEGEARSTATE_MAPCHECKREGION  ; 2
	const POKEGEARSTATE_JOHTOMAPINIT    ; 3
	const POKEGEARSTATE_JOHTOMAPJOYPAD  ; 4
	const POKEGEARSTATE_KANTOMAPINIT    ; 5
	const POKEGEARSTATE_KANTOMAPJOYPAD  ; 6
	const POKEGEARSTATE_ORANGEMAPINIT   ; 7
	const POKEGEARSTATE_ORANGEMAPJOYPAD ; 8
	const POKEGEARSTATE_PHONEINIT       ; 9
	const POKEGEARSTATE_PHONEJOYPAD     ; a
	const POKEGEARSTATE_MAKEPHONECALL   ; b
	const POKEGEARSTATE_FINISHPHONECALL ; c
	const POKEGEARSTATE_RADIOINIT       ; d
	const POKEGEARSTATE_RADIOJOYPAD     ; e

PokeGear:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	ld [wInPokegear], a
	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a
	call .InitTilemap
	call DelayFrame
.loop
	call UpdateTime
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call PokegearJumptable
	farcall PlaySpriteAnimations
	call DelayFrame
	jr .loop

.done
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	call WaitSFX
	pop af
	ld [wStateFlags], a
	pop af
	ldh [hInMenu], a
	pop af
	ld [wOptions1], a
	call ClearBGPalettes
	xor a ; LOW(vBGMap0)
	ldh [hBGMapAddress], a
	ld [wInPokegear], a
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	ld a, $90
	ldh [hWY], a
	jmp ExitPokegearRadio_HandleMusic

.InitTilemap:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	ld a, $7
	ldh [hWX], a
	call Pokegear_LoadGFX
	call ClearSpriteAnims
	call InitPokegearModeIndicatorArrow
	ld a, 8
	call SkipMusic
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	call TownMap_InitCursorAndPlayerIconPositions
	xor a
	ld [wJumptableIndex], a ; POKEGEARSTATE_CLOCKINIT
	ld [wPokegearCard], a ; POKEGEARCARD_CLOCK
	ld [wPokegearMapRegion], a ; JOHTO_REGION
	ld [wPokegearPhoneScrollPosition], a
	ld [wPokegearPhoneCursorPosition], a
	ld [wPokegearPhoneSelectedPerson], a
	ld [wPokegearRadioChannelBank], a
	ld [wPokegearRadioChannelAddr], a
	ld [wPokegearRadioChannelAddr + 1], a
	ld [wDefaultSpawnpoint], a
	call InitPokegearTilemap
	ld a, CGB_POKEGEAR_PALS
	call GetCGBLayout
	call SetDefaultBGPAndOBP
	ld a, %11100100
	jmp DmgToCgbObjPal0

Pokegear_LoadGFX:
	call ClearVBank1
	ld hl, TownMapGFX
	ld de, vTiles2
	ld a, BANK(TownMapGFX)
	call FarDecompressToDE
	ld hl, PokegearGFX
	ld de, vTiles2 tile $50
	ld a, BANK(PokegearGFX)
	call Decompress
	ld hl, PokegearSpritesGFX
	ld de, vTiles0
	ld a, BANK(PokegearSpritesGFX)
	call Decompress
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld hl, FastShipGFX
	cp FAST_SHIP
	jr z, .load_alt_sprite
	ld hl, SinjohRuinsArrowGFX
	cp SINJOH_RUINS
	jr z, .load_alt_sprite
	cp MYSTRI_STAGE
	jr z, .load_alt_sprite
	farcall GetPlayerIcon
	ldh a, [rSVBK]
	push af
	ld a, 6
	ldh [rSVBK], a
	push de
	ld h, d
	ld l, e
	ld a, b
	; standing sprite
	push af
	ld de, vTiles0 tile $10
	ld bc, 4 tiles
	call FarCopyBytes
	pop af
	pop hl
	; walking sprite
	ld de, 12 tiles
	add hl, de
	ld de, vTiles0 tile $14
	ld bc, 4 tiles
	call FarCopyBytes
	pop af
	ldh [rSVBK], a
	ret

.load_alt_sprite
	ld de, vTiles0 tile $10
	ld a, BANK(FastShipGFX) ; aka BANK(SinjohRuinsArrowGFX)
	jmp Decompress

FastShipGFX:
INCBIN "gfx/town_map/fast_ship.2bpp.lz"

SinjohRuinsArrowGFX:
INCBIN "gfx/town_map/arrow.2bpp.lz"

InitPokegearModeIndicatorArrow:
	depixel 4, 2, 4, 0
	ld a, SPRITE_ANIM_INDEX_POKEGEAR_MODE_ARROW
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $0
	ret

AnimatePokegearModeIndicatorArrow:
	ld a, [wPokegearCard]
	swap a ; x coord = card id * $10
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

TownMap_InitCursorAndPlayerIconPositions:
	call GetCurrentLandmark
	ld [wPokegearMapPlayerIconLandmark], a
	ld [wPokegearMapCursorLandmark], a
	ret

InitPokegearTilemap:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, wTilemapEnd - wTilemap
	ld a, "<BLACK>"
	rst ByteFill
	ld a, [wPokegearCard]
	and $3
	add a
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _hl_
	call Pokegear_FinishTilemap
	call TownMapPals
	ld a, [wPokegearCard]
	cp POKEGEARCARD_MAP
	jr nz, .not_town_map
	ld a, [wJumptableIndex]
	cp 3 ; Johto
	call z, TownMapJohtoFlips
	ld a, [wJumptableIndex]
	cp 5 ; Kanto
	call z, TownMapKantoFlips
	ld a, [wJumptableIndex]
	cp 7 ; Orange
	call z, TownMapOrangeFlips
.not_town_map
	ld a, [wPokegearMapRegion]
	and a
	jr nz, .transition
	xor a ; LOW(vBGMap0)
	ldh [hBGMapAddress], a
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	call .UpdateBGMap
	ld a, $90
	jr .finish

.transition
	xor a ; LOW(vBGMap1)
	ldh [hBGMapAddress], a
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	call .UpdateBGMap
	xor a
.finish
	ldh [hWY], a
	ld a, [wPokegearMapRegion]
	and 1
	xor 1
	ld [wPokegearMapRegion], a
	ret

.UpdateBGMap:
	ld a, $2
	ldh [hBGMapMode], a
	ld c, 3
	call DelayFrames
	jmp ApplyTilemapInVBlank

.Jumptable:
	dw .Clock
	dw .Map
	dw .Phone
	dw .Radio

.Clock:
	ld hl, ClockTilemapRLE
	call Pokegear_LoadTilemapRLE
	hlcoord 12, 1
	ld de, .switch
	rst PlaceString
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	jmp Pokegear_UpdateClock

.switch
	db " Switch▶@"

.Map:
	call PokegearMap
	ld a, $07
	ld bc, 18
	hlcoord 1, 2
	rst ByteFill
	hlcoord 0, 2
	ld [hl], $06
	hlcoord 19, 2
	ld [hl], $17
	ld a, [wPokegearMapCursorLandmark]
	jmp PokegearMap_UpdateLandmarkName

.Radio:
	ld hl, RadioTilemapRLE
	call Pokegear_LoadTilemapRLE
	hlcoord 0, 12
	lb bc, 4, 18
	jmp Textbox

.Phone:
	ld hl, PhoneTilemapRLE
	call Pokegear_LoadTilemapRLE
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	call .PlacePhoneBars
	jmp PokegearPhone_UpdateDisplayList

.PlacePhoneBars:
	hlcoord 17, 1
	ld a, $68
	ld [hli], a
	inc a
	ld [hl], a
	hlcoord 17, 2
	inc a
	ld [hli], a
	call GetMapPhoneService
	and a
	ret nz
	hlcoord 18, 2
	ld [hl], $6b
	ret

Pokegear_FinishTilemap:
	hlcoord 0, 0
	ld bc, $8
	ld a, "<BLACK>"
	rst ByteFill
	hlcoord 0, 1
	ld bc, $8
	ld a, "<BLACK>"
	rst ByteFill
	ld de, wPokegearFlags
	ld a, [de]
	bit POKEGEAR_MAP_CARD_F, a
	call nz, .PlaceMapIcon
	ld a, [de]
	bit POKEGEAR_PHONE_CARD_F, a
	call nz, .PlacePhoneIcon
	ld a, [de]
	bit POKEGEAR_RADIO_CARD_F, a
	call nz, .PlaceRadioIcon
	hlcoord 0, 0
	ld a, $56
	jr .PlacePokegearCardIcon

.PlaceMapIcon:
	hlcoord 2, 0
	ld a, $50
	jr .PlacePokegearCardIcon

.PlacePhoneIcon:
	hlcoord 4, 0
	ld a, $54
	jr .PlacePokegearCardIcon

.PlaceRadioIcon:
	hlcoord 6, 0
	ld a, $52
.PlacePokegearCardIcon:
	ld [hli], a
	inc a
	ld [hld], a
	ld bc, $14
	add hl, bc
	add $f
	ld [hli], a
	inc a
	ld [hld], a
	ret

PokegearJumptable:
	call StandardStackJumpTable

.Jumptable:
	dw PokegearClock_Init
	dw PokegearClock_Joypad
	dw PokegearMap_CheckRegion
	dw PokegearMap_Init
	dw PokegearMap_JohtoMap
	dw PokegearMap_Init
	dw PokegearMap_KantoMap
	dw PokegearMap_Init
	dw PokegearMap_OrangeMap
	dw PokegearPhone_Init
	dw PokegearPhone_Joypad
	dw PokegearPhone_MakePhoneCall
	dw PokegearPhone_FinishPhoneCall
	dw PokegearRadio_Init
	dw PokegearRadio_Joypad

PokegearClock_Init:
	call InitPokegearTilemap
	ld hl, PokegearText_PressAnyButtonToExit
	call PrintText
	ld hl, wJumptableIndex
	inc [hl]
	jmp ExitPokegearRadio_HandleMusic

PokegearClock_Joypad:
	call .UpdateClock
	ld hl, hJoyLast
	ld a, [hl]
	and B_BUTTON | START | SELECT
	jr nz, .quit
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr nz, .quit
	ld a, [hl]
	and D_RIGHT
	ret z
	ld a, [wPokegearFlags]
	bit POKEGEAR_MAP_CARD_F, a
	jr z, .no_map_card
	lb bc, POKEGEARCARD_MAP, POKEGEARSTATE_MAPCHECKREGION
	jr .done

.no_map_card
	ld a, [wPokegearFlags]
	bit POKEGEAR_PHONE_CARD_F, a
	jr z, .no_phone_card
	lb bc, POKEGEARCARD_PHONE, POKEGEARSTATE_PHONEINIT
	jr .done

.no_phone_card
	ld a, [wPokegearFlags]
	bit POKEGEAR_RADIO_CARD_F, a
	ret z
	lb bc, POKEGEARCARD_RADIO, POKEGEARSTATE_RADIOINIT
.done
	jmp Pokegear_SwitchPage

.quit
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.UpdateClock:
	xor a
	ldh [hBGMapMode], a
	call Pokegear_UpdateClock
	ld a, $1
	ldh [hBGMapMode], a
	ret

Pokegear_UpdateClock:
	hlcoord 3, 5
	lb bc, 5, 14
	call ClearBox
	ldh a, [hHours]
	ld b, a
	ldh a, [hMinutes]
	ld c, a
	ld a, [wOptions2]
	bit CLOCK_FORMAT, a
	decoord 6, 8
	jr z, .h12
	decoord 8, 8
.h12
	call PrintHoursMins
	ld hl, .DayText
	bccoord 6, 6
	jmp PlaceWholeStringInBoxAtOnce

.DayText:
	text_far _GearTodayText
	text_end

PokegearMap_CheckRegion:
	ld a, [wPokegearMapPlayerIconLandmark]
	cp SHAMOUTI_LANDMARK
	jr nc, .orange
	cp KANTO_LANDMARK
	; a = carry ? 3 (johto) : 5 (kanto)
	sbc a
	sbc -5
	jr .done
.orange
	ld a, POKEGEARSTATE_ORANGEMAPINIT
.done
	ld [wJumptableIndex], a
	jmp ExitPokegearRadio_HandleMusic

PokegearMap_Init:
	call InitPokegearTilemap
	call TownMap_InitFlyPossible
	ld a, [wPokegearMapPlayerIconLandmark]
	call PokegearMap_InitPlayerIcon
	ld a, [wPokegearMapCursorLandmark]
	call PokegearMap_InitCursor
	ld a, c
	ld [wPokegearMapCursorObjectPointer], a
	ld a, b
	ld [wPokegearMapCursorObjectPointer + 1], a
	ld a, [wTownMapCanShowFly]
	and a
	jr z, .no_fly
	ld a, [wPokegearMapPlayerIconLandmark]
	cp SHAMOUTI_LANDMARK
	depixel 18, 12, 0, 0
	jr nc, .got_coords
	ld e, 13 * 8 ; depixel 18, 13, 0, 0
.got_coords
	ld a, SPRITE_ANIM_INDEX_TOWN_MAP_FLY
	call InitSpriteAnimStruct
.no_fly
	ld hl, wJumptableIndex
	inc [hl]
	ret

PokegearMap_JohtoMap:
	call TownMap_GetJohtoLandmarkLimits
	jr PokegearMap_ContinueMap

PokegearMap_KantoMap:
	call TownMap_GetKantoLandmarkLimits
	jr PokegearMap_ContinueMap

PokegearMap_OrangeMap:
	call TownMap_GetOrangeLandmarkLimits
PokegearMap_ContinueMap:
	ld hl, hJoyLast
	ld a, [hl]
	and A_BUTTON
	jr nz, .fly
	ld a, [hl]
	and B_BUTTON
	jr nz, .cancel
	ld a, [hl]
	and D_RIGHT
	jr nz, .right
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	jr .DPad

.right
	ld a, [wPokegearFlags]
	bit POKEGEAR_PHONE_CARD_F, a
	jr z, .no_phone
	lb bc, POKEGEARCARD_PHONE, POKEGEARSTATE_PHONEINIT
	jr .done

.no_phone
	ld a, [wPokegearFlags]
	bit POKEGEAR_RADIO_CARD_F, a
	ret z
	lb bc, POKEGEARCARD_RADIO, POKEGEARSTATE_RADIOINIT
	jr .done

.left
	lb bc, POKEGEARCARD_CLOCK, POKEGEARSTATE_CLOCKINIT
.done
	jmp Pokegear_SwitchPage

.fly
	ld a, [wTownMapCanFlyHere]
	and a
	ret z
	ld a, [wPokegearMapCursorSpawnpoint]
	ld [wDefaultSpawnpoint], a
	ld a, BANK(FlyFunction.FlyScript)
	ld hl, FlyFunction.FlyScript
	call FarQueueScript
	; fallthrough
.cancel
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.DPad:
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .up
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	ret

.up
	ld hl, wPokegearMapCursorLandmark
	ld a, [hl]
	cp d
	jr c, .wrap_around_up
	ld a, e
	dec a
	ld [hl], a
.wrap_around_up
	inc [hl]
	call SkipHiddenOrangeIslandsUp
	jr .done_dpad

.down
	ld hl, wPokegearMapCursorLandmark
	ld a, [hl]
	cp e
	jr nz, .wrap_around_down
	ld a, d
	inc a
	ld [hl], a
.wrap_around_down
	dec [hl]
	call SkipHiddenOrangeIslandsDown

.done_dpad
	ld a, [wPokegearMapCursorLandmark]
	call PokegearMap_UpdateLandmarkName
	ld a, [wPokegearMapCursorObjectPointer]
	ld c, a
	ld a, [wPokegearMapCursorObjectPointer + 1]
	ld b, a
	ld a, [wPokegearMapCursorLandmark]
	jmp PokegearMap_UpdateCursorPosition

SkipHiddenOrangeIslandsUp:
	call CheckSkipNavelRock
	jr nz, .not_after_navel_rock
	inc [hl]
.not_after_navel_rock
	call CheckSkipFarawayIsland
	jr nz, .not_after_faraway_island
	inc [hl]
.not_after_faraway_island
	ld a, [hl]
	cp FARAWAY_ISLAND + 1
	ret nz
	ld [hl], SHAMOUTI_ISLAND
	ret

SkipHiddenOrangeIslandsDown:
	call CheckSkipFarawayIsland
	jr nz, .not_before_faraway_island
	dec [hl]
.not_before_faraway_island
	call CheckSkipNavelRock
	ret nz
	dec [hl]
	ret

CheckSkipNavelRock:
	ld a, [hl]
	cp NAVEL_ROCK
	ret nz
	push hl
	eventflagcheck EVENT_VISITED_NAVEL_ROCK
	pop hl
	ret

CheckSkipFarawayIsland:
	ld a, [hl]
	cp FARAWAY_ISLAND
	ret nz
	push hl
	eventflagcheck EVENT_VISITED_FARAWAY_ISLAND
	pop hl
	ret

PokegearMap_InitPlayerIcon:
	push af
	call InitializePokegearPlayerIcon
	pop af
	ld e, a
	push bc
	farcall GetLandmarkCoords
	pop bc
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], e
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

PokegearMap_InitCursor:
	push af
	depixel 0, 0
	ld a, SPRITE_ANIM_INDEX_POKEGEAR_MODE_ARROW
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $4
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_NULL
	pop af
	push bc
	call PokegearMap_UpdateCursorPosition
	pop bc
	ret

TownMap_UpdateLandmarkName:
	hlcoord 0, 0
	jr _UpdateLandmarkName

PokegearMap_UpdateLandmarkName:
	hlcoord 8, 0
	; fallthrough
_UpdateLandmarkName:
	push hl
	push af
	lb bc, 2, 12
	call ClearBox
	pop af
	ld e, a
	push de
	farcall GetLandmarkName
	pop de
	pop hl
	ld a, $44 ; up/down arrow
	ld [hli], a
	push hl
	ld hl, wStringBuffer1
	ld d, h
	ld e, l
.loop
	ld a, [hl]
	cp "@"
	jr z, .end
	cp "¯"
	jr z, .line_break
	inc hl
	jr .loop
.line_break
	ld [hl], "<LNBRK>"
.end
	pop hl
	rst PlaceString
	ret

PokegearMap_UpdateCursorPosition:
	push bc
	ld e, a
	farcall GetLandmarkCoords
	pop bc
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], e
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

TownMap_GetJohtoLandmarkLimits:
	lb de, SILVER_CAVE, NEW_BARK_TOWN
	ret

TownMap_GetKantoLandmarkLimits:
	lb de, ROUTE_28, ROUTE_27
	ld a, [wStatusFlags]
	bit STATUSFLAGS_HALL_OF_FAME_F, a
	ret z
	ld e, PALLET_TOWN
	ret

TownMap_GetOrangeLandmarkLimits:
	lb de, FARAWAY_ISLAND, SHAMOUTI_ISLAND
	ret

PokegearRadio_Init:
	call InitPokegearTilemap
	depixel 4, 10, 4, 4
	ld a, SPRITE_ANIM_INDEX_RADIO_TUNING_KNOB
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $8
	call UpdateRadioStation
	ld hl, wJumptableIndex
	inc [hl]
	ret

PokegearRadio_Joypad:
	ld hl, hJoyLast
	ld a, [hl]
	and B_BUTTON
	jr nz, .cancel
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ld hl, wPokegearRadioChannelAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wPokegearRadioChannelBank]
	and a
	ret z
	jmp FarCall_hl

.left
	ld a, [wPokegearFlags]
	bit POKEGEAR_PHONE_CARD_F, a
	jr z, .no_phone
	lb bc, POKEGEARCARD_PHONE, POKEGEARSTATE_PHONEINIT
	jr Pokegear_SwitchPage

.no_phone
	ld a, [wPokegearFlags]
	bit POKEGEAR_MAP_CARD_F, a
	jr z, .no_map
	lb bc, POKEGEARCARD_MAP, POKEGEARSTATE_MAPCHECKREGION
	jr Pokegear_SwitchPage

.no_map
	lb bc, POKEGEARCARD_CLOCK, POKEGEARSTATE_CLOCKINIT
	jr Pokegear_SwitchPage

.cancel
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Pokegear_SwitchPage:
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	ld a, c
	ld [wJumptableIndex], a
	ld a, b
	ld [wPokegearCard], a
	ld hl, wSpriteAnim2
	ld bc, wSpriteAnimationStructsEnd - wSpriteAnim2
	xor a
	rst ByteFill
	ld a, 2
	ld [wSpriteAnimCount], a
	ret

ExitPokegearRadio_HandleMusic:
	ld a, [wPokegearRadioMusicPlaying]
	cp $fe
	jr z, .restart_map_music
	cp $ff
	call z, PlayMapMusicBike
	xor a
	ld [wPokegearRadioMusicPlaying], a
	ret

.restart_map_music
	call RestartMapMusic
	xor a
	ld [wPokegearRadioMusicPlaying], a
	ret

Pokegear_LoadTilemapRLE:
	; Format: repeat count, tile ID
	; Terminated with $ff
	decoord 0, 0
	jmp CopyRLE

PokegearText_WhomToCall:
	; Whom do you want to call?
	text_far _PokegearAskWhoCallText
	text_end

PokegearText_PressAnyButtonToExit:
	; Press any button to exit.
	text_far _PokegearPressButtonText
	text_end

PokegearText_DeleteStoredNumber:
	; Delete this stored phone number?
	text_far _PokegearAskDeleteText
	text_end

PokegearSpritesGFX:
INCBIN "gfx/pokegear/pokegear_sprites.2bpp.lz"

RadioTilemapRLE:
INCBIN "gfx/pokegear/radio.tilemap.rle"
PhoneTilemapRLE:
INCBIN "gfx/pokegear/phone.tilemap.rle"
ClockTilemapRLE:
INCBIN "gfx/pokegear/clock.tilemap.rle"

; called from engine/sprite_anims.asm

AnimateTuningKnob:
	push bc
	call .TuningKnob
	pop bc
	ld a, [wRadioTuningKnob]
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.TuningKnob:
	ld hl, hJoyLast
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	ld a, [hl]
	and D_UP
	jr nz, .up
	ret

.down
	ld hl, wRadioTuningKnob
	ld a, [hl]
	and a
	ret z
	dec [hl]
	dec [hl]
	jr UpdateRadioStation

.up
	ld hl, wRadioTuningKnob
	ld a, [hl]
	cp 80
	ret nc
	inc [hl]
	inc [hl]
	; fallthrough

UpdateRadioStation:
	ld hl, wRadioTuningKnob
	ld d, [hl]
	ld hl, RadioChannels
.loop
	ld a, [hli]
	cp -1
	jmp z, NoRadioStation
	cp d
	jr z, .foundstation
	inc hl
	inc hl
	jr .loop

.foundstation
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _hl_
	ld a, [wPokegearRadioChannelBank]
	and a
	ret z
	xor a
	ldh [hBGMapMode], a
	hlcoord 2, 9
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ret

RadioChannels:
; frequencies and the shows that play on them.

; frequency value given here = 4 × ingame_frequency − 2
	dbw 16, .PkmnTalkAndPokedexShow
	dbw 28, .PokemonMusic
	dbw 32, .LuckyChannel
	dbw 40, .BuenasPassword
	dbw 52, .RuinsOfAlphRadio
	dbw 64, .PlacesAndPeople
	dbw 72, .LetsAllSing
	dbw 78, .PokeFluteRadio
	dbw 80, .EvolutionRadio
	db -1

.PkmnTalkAndPokedexShow:
; Pokédex Show in the morning

; Oak's Pokémon Talk in the afternoon and evening
	call .InJohto
	jr nc, NoRadioStation
	ld a, [wTimeOfDay]
	and a
	jmp z, LoadStation_PokedexShow
	jmp LoadStation_OaksPokemonTalk

.PokemonMusic:
	call .InJohto
	jr nc, NoRadioStation
	jmp LoadStation_PokemonMusic

.LuckyChannel:
	call .InJohto
	jr nc, NoRadioStation
	jmp LoadStation_LuckyChannel

.BuenasPassword:
	call .InJohto
	jr nc, NoRadioStation
	jmp LoadStation_BuenasPassword

.RuinsOfAlphRadio:
	ld a, [wPokegearMapPlayerIconLandmark]
	cp RUINS_OF_ALPH
	jr nz, NoRadioStation
	jmp LoadStation_UnownRadio

.PlacesAndPeople:
	call .InJohto
	jr c, NoRadioStation
	ld a, [wPokegearFlags]
	bit POKEGEAR_EXPN_CARD_F, a
	jr z, NoRadioStation
	jmp LoadStation_PlacesAndPeople

.LetsAllSing:
	call .InJohto
	jr c, NoRadioStation
	ld a, [wPokegearFlags]
	bit POKEGEAR_EXPN_CARD_F, a
	jr z, NoRadioStation
	jmp LoadStation_LetsAllSing

.PokeFluteRadio:
	call .InJohto
	jr c, NoRadioStation
	ld a, [wPokegearFlags]
	bit POKEGEAR_EXPN_CARD_F, a
	jr z, NoRadioStation
	jmp LoadStation_PokeFluteRadio

.EvolutionRadio:
; This station airs in the Lake of Rage area when Rocket are still in Mahogany.
	ld a, [wStatusFlags]
	bit STATUSFLAGS_ROCKET_SIGNAL_F, a
	jr z, NoRadioStation
	ld a, [wPokegearMapPlayerIconLandmark]
	cp MAHOGANY_TOWN
	jr z, .ok
	cp ROUTE_43
	jr z, .ok
	cp LAKE_OF_RAGE
	jr nz, NoRadioStation
.ok
	jmp LoadStation_EvolutionRadio

.InJohto:
; if in Johto or on the S.S. Aqua, set carry
; otherwise clear carry
	ld a, [wPokegearMapPlayerIconLandmark]
	cp KANTO_LANDMARK
	jr nc, .kanto_or_orange
	scf
	ret

.kanto_or_orange
	and a
	ret

NoRadioStation:
	call NoRadioMusic
	call NoRadioName
	xor a
	ld [wPokegearRadioChannelBank], a
	ld [wPokegearRadioChannelAddr], a
	ld [wPokegearRadioChannelAddr + 1], a
	ld a, $1
	ldh [hBGMapMode], a
	ret

LoadStation_OaksPokemonTalk:
	xor a ; OAKS_POKEMON_TALK
	ld de, OaksPkmnTalkName
LoadRadioStation:
	ld [wCurRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	ld hl, wPokegearRadioChannelBank
	ld a, BANK(PlayRadioShow)
	ld [hli], a
	ld a, LOW(PlayRadioShow)
	ld [hli], a
	ld a, HIGH(PlayRadioShow)
	ld [hli], a
	ret

LoadStation_PokedexShow:
	ld a, POKEDEX_SHOW
	ld de, PokedexShowName
	jr LoadRadioStation

LoadStation_PokemonMusic:
	ld a, POKEMON_MUSIC
	ld de, PokemonMusicName
	jr LoadRadioStation

LoadStation_LuckyChannel:
	ld a, LUCKY_CHANNEL
	ld de, LuckyChannelName
	jr LoadRadioStation

LoadStation_BuenasPassword:
	ld de, EmptyString
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_ROCKETS_IN_RADIO_TOWER_F, a
	jr z, .ok
	ld de, BuenasPasswordName
.ok
	ld a, BUENAS_PASSWORD
	jr LoadRadioStation

BuenasPasswordName: db "Buena's Password@"

LoadStation_UnownRadio:
	ld a, UNOWN_RADIO
	ld de, UnknownStationName
	jr LoadRadioStation

LoadStation_PlacesAndPeople:
	ld a, PLACES_AND_PEOPLE
	ld de, PlacesAndPeopleName
	jr LoadRadioStation

LoadStation_LetsAllSing:
	ld a, LETS_ALL_SING
	ld de, LetsAllSingName
	jr LoadRadioStation

LoadStation_RocketRadio:
	ld a, ROCKET_RADIO
	ld de, LetsAllSingName
	jr LoadRadioStation

LoadStation_PokeFluteRadio:
	ld a, POKE_FLUTE_RADIO
	ld de, PokeFluteStationName
	jr LoadRadioStation

LoadStation_EvolutionRadio:
	ld a, EVOLUTION_RADIO
	ld de, UnknownStationName
	jr LoadRadioStation

RadioMusicRestart:
	push de
	ld a, e
	ld [wPokegearRadioMusicPlaying], a
	ld e, MUSIC_NONE
	call PlayMusic
	pop de
	ld a, e
	ld [wMapMusic], a
	jmp PlayMusic

RadioMusicRestartPokemonChannel:
	push de
	ld a, $fe
	ld [wPokegearRadioMusicPlaying], a
	ld e, MUSIC_NONE
	call PlayMusic
	pop de
	ld e, MUSIC_POKEMON_CHANNEL
	jmp PlayMusic

NoRadioMusic:
	ld e, MUSIC_NONE
	call PlayMusic
	ld a, $ff
	ld [wPokegearRadioMusicPlaying], a
	ret

NoRadioName:
	xor a
	ldh [hBGMapMode], a
	hlcoord 1, 8
	lb bc, 3, 18
	call ClearBox
	hlcoord 0, 12
	ld bc, $412
	jmp Textbox

OaksPkmnTalkName:     db "Oak's <PK><MN> Talk@"
PokedexShowName:      db "#dex Show@"
PokemonMusicName:     db "#mon Music@"
LuckyChannelName:     db "Lucky Channel@"
UnknownStationName:   db "?????@"

PlacesAndPeopleName:  db "Places & People@"
LetsAllSingName:      db "Let's All Sing!@"
PokeFluteStationName: db "# Flute@"

_TownMap:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]

	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a

	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a

	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	farcall InitPokegearPalettes
	call Pokegear_LoadGFX
	call ClearSpriteAnims
	ld a, 8
	call SkipMusic
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	call TownMap_InitCursorAndPlayerIconPositions
	ld [wTownMapPlayerIconLandmark], a
	ld [wTownMapCursorLandmark], a
	xor a
	ldh [hBGMapMode], a
	call .InitTilemap
	call ApplyAttrAndTilemapInVBlank
	ld a, [wTownMapPlayerIconLandmark]
	call PokegearMap_InitPlayerIcon
	ld a, [wTownMapCursorLandmark]
	call PokegearMap_InitCursor
	ld a, c
	ld [wTownMapCursorObjectPointer], a
	ld a, b
	ld [wTownMapCursorObjectPointer + 1], a
	ld a, CGB_POKEGEAR_PALS
	call GetCGBLayout
	call SetDefaultBGPAndOBP
	ld a, %11100100
	call DmgToCgbObjPal0
	call DelayFrame

	ld a, [wTownMapPlayerIconLandmark]
	cp SHAMOUTI_LANDMARK
	jr nc, .orange
	cp KANTO_LANDMARK
	jr nc, .kanto
	call TownMap_GetJohtoLandmarkLimits
	jr .resume
.kanto
	call TownMap_GetKantoLandmarkLimits
	jr .resume
.orange
	call TownMap_GetOrangeLandmarkLimits

.resume
	call .loop
	pop af
	ld [wStateFlags], a
	pop af
	ldh [hInMenu], a
	pop af
	ld [wOptions1], a
	jmp ClearBGPalettes

.loop
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	ret nz

	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .pressed_up

	ld a, [hl]
	and D_DOWN
	jr nz, .pressed_down
.loop2
	push de
	farcall PlaySpriteAnimations
	pop de
	call DelayFrame
	jr .loop

.pressed_up
	ld hl, wTownMapCursorLandmark
	ld a, [hl]
	cp d
	jr c, .okay
	ld a, e
	dec a
	ld [hl], a

.okay
	inc [hl]
	push de
	call SkipHiddenOrangeIslandsUp
	jr .next

.pressed_down
	ld hl, wTownMapCursorLandmark
	ld a, [hl]
	cp e
	jr nz, .okay2
	ld a, d
	inc a
	ld [hl], a

.okay2
	dec [hl]
	push de
	call SkipHiddenOrangeIslandsDown

.next
	ld a, [wTownMapCursorLandmark]
	call TownMap_UpdateLandmarkName
	ld a, [wTownMapCursorObjectPointer]
	ld c, a
	ld a, [wTownMapCursorObjectPointer + 1]
	ld b, a
	ld a, [wTownMapCursorLandmark]
	call PokegearMap_UpdateCursorPosition
	pop de
	jr .loop2

.InitTilemap:
	call PokegearMap
	ld a, $06
	hlcoord 12, 0
	ld [hl], a
	hlcoord 12, 1
	ld [hl], $16
	hlcoord 0, 2
	ld [hli], a
	inc a
	ld bc, NAME_LENGTH
	hlcoord 1, 2
	rst ByteFill
	ld [hl], $27
	ld a, [wTownMapCursorLandmark]
	call TownMap_UpdateLandmarkName
	call TownMapPals

	ld a, [wTownMapPlayerIconLandmark]
	cp SHAMOUTI_LANDMARK
	jmp nc, TownMapOrangeFlips
	cp KANTO_LANDMARK
	jmp nc, TownMapKantoFlips
	jmp TownMapJohtoFlips

TownMap_InitFlyPossible:
	lb de, FLY, HM_FLY
	farcall CheckPartyMove
	jr c, .no_fly
	ld de, ENGINE_STORMBADGE
	farcall CheckBadge
	jr c, .no_fly
	farcall CheckFlyAllowedOnMap
	jr nz, .no_fly
	ld a, TRUE
	jr .done
.no_fly
	xor a ; FALSE
	ld [wTownMapCanFlyHere], a
.done
	ld [wTownMapCanShowFly], a
	ret

AnimateTownMapFly:
	push bc
	ld a, [wPokegearMapCursorLandmark]
	ld b, a
	ld hl, Flypoints
.loop
	ld a, [hli]
	inc a
	jr z, .done
	dec a
	cp b
	jr nz, .skip
	ld a, [hli]
	ld c, a
	ld [wPokegearMapCursorSpawnpoint], a
	call HasVisitedSpawn
	and a
	jr z, .loop
	ld a, 144
	jr .done
.skip
	inc hl
	jr .loop
.done
	pop bc
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], a
	ld [wTownMapCanFlyHere], a
	ret

PlayRadio:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .PlayStation
	ld c, 100
	call DelayFrames
.loop
	call JoyTextDelay
	ldh a, [hJoyPressed]
	and A_BUTTON | B_BUTTON
	jr nz, .stop
	ld hl, wPokegearRadioChannelAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wPokegearRadioChannelBank]
	and a
	call nz, FarCall_hl
	call DelayFrame
	jr .loop

.stop
	pop af
	ld [wOptions1], a
	jmp ExitPokegearRadio_HandleMusic

.PlayStation:
	ld a, -1
	ld [wPokegearRadioMusicPlaying], a
	ld hl, PlayRadioStationPointers
	ld d, $0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _hl_
	push de
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	hlcoord 1, 14
	ld [hl], "“"
	pop de
	hlcoord 2, 14
	rst PlaceString
	ld h, b
	ld l, c
	ld [hl], "”"
	jmp ApplyTilemapInVBlank

PlayRadioStationPointers:
; entries correspond to MAPRADIO_* constants
	table_width 2
	dw LoadStation_PokemonChannel
	dw LoadStation_OaksPokemonTalk
	dw LoadStation_PokedexShow
	dw LoadStation_PokemonMusic
	dw LoadStation_LuckyChannel
	dw LoadStation_UnownRadio
	dw LoadStation_PlacesAndPeople
	dw LoadStation_LetsAllSing
	dw LoadStation_RocketRadio
	assert_table_length NUM_MAP_RADIO_STATIONS

LoadStation_PokemonChannel:
	call GetCurrentLandmark
	cp KANTO_LANDMARK
	jr nc, .kanto_or_orange
	call UpdateTime
	ld a, [wTimeOfDay]
	and a
	jmp z, LoadStation_PokedexShow
	jmp LoadStation_OaksPokemonTalk

.kanto_or_orange:
	jmp LoadStation_PlacesAndPeople

PokegearMap:
	call LoadTownMapGFX
	ld a, [wPokegearMapPlayerIconLandmark]
	cp SHAMOUTI_LANDMARK
	jmp nc, FillOrangeMap
	cp KANTO_LANDMARK
	jmp nc, FillKantoMap
	jmp FillJohtoMap

_FlyMap:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], $1
	xor a
	ldh [hBGMapMode], a
	call ClearSpriteAnims
	call LoadTownMapGFX
	call FlyMap
	ld a, CGB_FLY_MAP
	call GetCGBLayout
	call SetDefaultBGPAndOBP
.loop
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .pressedB
	ld a, [hl]
	and A_BUTTON
	jr nz, .pressedA
	call FlyMapScroll
	call GetMapCursorCoordinates
	farcall PlaySpriteAnimations
	call DelayFrame
	jr .loop

.pressedB
	ld a, -1
	jr .exit

.pressedA
	ld a, [wTownMapPlayerIconLandmark]
	ld l, a
	ld h, 0
	add hl, hl
	ld de, Flypoints + 1
	add hl, de
	ld a, [hl]
.exit
	ld [wTownMapPlayerIconLandmark], a
	pop af
	ldh [hInMenu], a
	call ClearBGPalettes
	ld a, $90
	ldh [hWY], a
	xor a ; LOW(vBGMap0)
	ldh [hBGMapAddress], a
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	ld a, [wTownMapPlayerIconLandmark]
	ld e, a
	ret

FlyMapScroll:
	ld a, [wStartFlypoint]
	ld e, a
	ld a, [wEndFlypoint]
	ld d, a
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .ScrollNext
	ld a, [hl]
	and D_DOWN
	jr nz, .ScrollPrev
	ret

.ScrollNext:
	ld hl, wTownMapPlayerIconLandmark
	ld a, [hl]
	cp d
	jr nz, .NotAtEndYet
	ld a, e
	dec a
	ld [hl], a
.NotAtEndYet:
	inc [hl]
	call CheckIfVisitedFlypoint
	jr z, .ScrollNext
	jr .Finally

.ScrollPrev:
	ld hl, wTownMapPlayerIconLandmark
	ld a, [hl]
	cp e
	jr nz, .NotAtStartYet
	ld a, d
	inc a
	ld [hl], a
.NotAtStartYet:
	dec [hl]
	call CheckIfVisitedFlypoint
	jr z, .ScrollPrev
.Finally:
	call TownMapBubble
	call ApplyTilemapInVBlank
	xor a
	ldh [hBGMapMode], a
	ret

TownMapBubble:
; Draw the bubble containing the location text in the town map HUD

; Top-left corner
	hlcoord 1, 0
	ld a, $40
	ld [hli], a
; Top row
	ld bc, 16
	ld a, " "
	rst ByteFill
; Top-right corner
	ld [hl], $41
	hlcoord 1, 1

; Middle row
	ld bc, 18
	ld a, " "
	rst ByteFill

; Bottom-left corner
	hlcoord 1, 2
	ld a, $42
	ld [hli], a
; Bottom row
	ld bc, 16
	ld a, " "
	rst ByteFill
; Bottom-right corner
	ld [hl], $43

; Print "Where?"
	hlcoord 2, 0
	ld de, .Where
	rst PlaceString
; Print the name of the default flypoint
	call .Name
; Up/down arrows
	hlcoord 18, 1
	ld [hl], $44
	ret

.Where:
	db "Where?@"

.Name:
; We need the map location of the default flypoint
	ld a, [wTownMapPlayerIconLandmark]
	ld l, a
	ld h, 0
	add hl, hl ; two bytes per flypoint
	ld de, Flypoints
	add hl, de
	ld e, [hl]
	farcall GetLandmarkName
	hlcoord 2, 1
	ld de, wStringBuffer1
	rst PlaceString
	ret

GetMapCursorCoordinates:
	ld a, [wTownMapPlayerIconLandmark]
	ld l, a
	ld h, 0
	add hl, hl
	ld de, Flypoints
	add hl, de
	ld e, [hl]
	farcall GetLandmarkCoords
	ld hl, wTownMapCursorCoordinates
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, 4
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

CheckIfVisitedFlypoint:
; Check if the flypoint loaded in [hl] has been visited yet.
	push bc
	push de
	push hl
	ld l, [hl]
	ld h, 0
	add hl, hl
	ld de, Flypoints + 1
	add hl, de
	ld c, [hl]
	call HasVisitedSpawn
	pop hl
	pop de
	pop bc
	and a
	ret

HasVisitedSpawn:
; Check if spawn point c has been visited.
	ld hl, wVisitedSpawns
	ld b, CHECK_FLAG
	ld d, 0
	predef FlagPredef
	ld a, c
	ret

INCLUDE "data/maps/flypoints.asm"

FlyMap:
	call GetCurrentLandmark
	cp SHAMOUTI_LANDMARK
	jr nc, .OrangeFlyMap
	cp KANTO_LANDMARK
	jr nc, .KantoFlyMap
; Note that .NoKanto should be modified in tandem with this branch
	push af
; Start from New Bark Town
	ld a, FLY_NEW_BARK
	ld [wTownMapPlayerIconLandmark], a
; Flypoints begin at New Bark Town...
	ld [wStartFlypoint], a
; ..and end at Silver Cave
	ld a, FLY_MT_SILVER
	ld [wEndFlypoint], a
; Fill out the map
	call FillJohtoMap
	call TownMapBubble
	call TownMapPals
	call TownMapJohtoFlips
	call .MapHud
	pop af
	jmp TownMapPlayerIcon

.OrangeFlyMap:
	push af
; Start from Shamouti Island
	ld a, FLY_SHAMOUTI
	ld [wTownMapPlayerIconLandmark], a
; Flypoints begin at Shamouti Island...
	ld [wStartFlypoint], a
; ..and end at Navel Rock
	ld a, FLY_NAVEL
	ld [wEndFlypoint], a
; Fill out the map
	call FillOrangeMap
	call TownMapBubble
	call TownMapPals
	call TownMapOrangeFlips
	call .MapHud
	pop af
	jmp TownMapPlayerIcon

.KantoFlyMap:
; The event that there are no flypoints enabled in a map is not
; accounted for. As a result, if you attempt to select a flypoint
; when there are none enabled, the game will crash. Additionally,
; the flypoint selection has a default starting point that
; can be flown to even if none are enabled
; To prevent both of these things from happening when the player
; enters Kanto, fly access is restricted until Indigo Plateau is
; visited and its flypoint enabled
	push af
	ld c, SPAWN_INDIGO
	call HasVisitedSpawn
	and a
	jr z, .NoKanto
; Kanto's map is only loaded if we've visited Indigo Plateau

; Flypoints begin at Pallet Town...
	ld a, FLY_PALLET
	ld [wStartFlypoint], a
; ...and end at Indigo Plateau
	ld a, FLY_INDIGO
	ld [wEndFlypoint], a
; Because Indigo Plateau is the first flypoint the player

; visits, it's made the default flypoint
	ld [wTownMapPlayerIconLandmark], a
; Fill out the map
	call FillKantoMap
	call TownMapBubble
	call TownMapPals
	call TownMapKantoFlips
	call .MapHud
	pop af
	jmp TownMapPlayerIcon

.NoKanto:
; If Indigo Plateau hasn't been visited, we use Johto's map instead

; Start from New Bark Town
	ld a, FLY_NEW_BARK
	ld [wTownMapPlayerIconLandmark], a
; Flypoints begin at New Bark Town...
	ld [wStartFlypoint], a
; ..and end at Silver Cave
	ld a, FLY_MT_SILVER
	ld [wEndFlypoint], a
	call FillJohtoMap
	pop af
	call TownMapBubble
	call TownMapPals
	call TownMapJohtoFlips
.MapHud:
	hlbgcoord 0, 0 ; BG Map 0
	call TownMapBGUpdate
	call TownMapMon
	ld a, c
	ld [wTownMapCursorCoordinates], a
	ld a, b
	ld [wTownMapCursorCoordinates + 1], a
	ret

TownMapBGUpdate:
; Update BG Map tiles and attributes

; BG Map address
	ld a, l
	ldh [hBGMapAddress], a
	ld a, h
	ldh [hBGMapAddress + 1], a
; BG Map mode 2 (palettes)
	ld a, 2
	ldh [hBGMapMode], a
; The BG Map is updated in thirds, so we wait
; 3 frames to update the whole screen's palettes.
	ld c, 3
	call DelayFrames
; Update BG Map tiles
	call ApplyTilemapInVBlank
; Turn off BG Map update
	xor a
	ldh [hBGMapMode], a
	ret

FillJohtoMap:
	ld de, JohtoMap
	jr FillTownMap

FillOrangeMap:
	ld de, OrangeMap
	call FillTownMap
	eventflagcheck EVENT_VISITED_FARAWAY_ISLAND
	ret nz
	ld a, $a
	hlcoord 1, 12
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	hlcoord 5, 13
	ld [hl], a
	hlcoord 2, 14
	ld [hli], a
	ld [hli], a
	inc hl
	ld [hl], a
	hlcoord 2, 15
	ld [hli], a
	ld [hli], a
	inc hl
	ld [hl], a
	hlcoord 5, 16
	ld [hl], a
	ret

FillKantoMap:
	ld de, KantoMap
FillTownMap:
	hlcoord 0, 0
.loop
	ld a, [de]
	cp -1
	ret z
	; [de] == yxTTTTTT
	ld a, [de]
	and %00111111
	; a == 00TTTTTT
	ld [hli], a
	inc de
	jr .loop

TownMapPals:
; Assign palettes based on tile ids
	hlcoord 0, 0
	decoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.loop
	ld a, [hli]
	push hl
	cp $40 ; tiles after TownMapGFX use palette 0
	jr nc, .pal0
	call GetNextTownMapTilePalette
	jr .update
.pal0
	xor a
.update
	pop hl
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

GetNextTownMapTilePalette:
; The palette data is condensed to nybbles, least-significant first.
	ld hl, .PalMap
	srl a
	jr c, .odd
; Even-numbered tile ids take the bottom nybble...
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	and %111
	ret

.odd
; ...and odd ids take the top.
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	swap a
	and %111
	ret

.PalMap:
MACRO townmappals
	rept _NARG / 2
		dn \2, \1
		shift 2
	endr
ENDM
	townmappals 2, 2, 2, 3, 3, 6, 1, 1, 4, 4, 4, 5, 6, 7, 7, 6
	townmappals 2, 2, 2, 3, 3, 6, 1, 1, 4, 4, 4, 6, 4, 4, 1, 1
	townmappals 2, 2, 2, 6, 6, 6, 1, 1, 4, 4, 4, 7, 2, 4, 1, 1
	townmappals 2, 2, 2, 2, 4, 4, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0

TownMapJohtoFlips:
	decoord 0, 0, JohtoMap
	jr TownMapFlips

TownMapKantoFlips:
	decoord 0, 0, KantoMap
	jr TownMapFlips

TownMapOrangeFlips:
	decoord 0, 0, OrangeMap
TownMapFlips:
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.loop
	; [de] == YXtttttt
	ld a, [de]
	and %11000000
	srl a
	; a == 0YX00000
	or [hl]
	ld [hli], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

TownMapMon:
; Draw the FlyMon icon at town map location in

	farcall SetFlyMonColor
; Get FlyMon icon
	ld e, 8 ; starting tile in VRAM
	farcall FlyFunction_GetMonIcon
; Animation/palette
	depixel 0, 0
	ld a, SPRITE_ANIM_INDEX_PARTY_MON
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $8
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_NULL
	ret

TownMapPlayerIcon:
; Draw the player icon at town map location in a
	push af
	farcall GetPlayerIcon
; Standing icon
	ld hl, vTiles0 tile $10
	ld c, 4 ; # tiles
	push bc
	push de
	call Request2bppInWRA6
	pop de
	pop bc
; Walking icon
	ld hl, $c0
	add hl, de
	ld d, h
	ld e, l
	ld hl, vTiles0 tile $14
	call Request2bppInWRA6
; Animation/palette
	call InitializePokegearPlayerIcon
	pop af
	ld e, a
	push bc
	farcall GetLandmarkCoords
	pop bc
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], e
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

InitializePokegearPlayerIcon:
	depixel 0, 0
	ld a, [wPlayerGender]
	ld b, SPRITE_ANIM_INDEX_RED_WALK
	and a ; PLAYER_MALE
	jr z, .got_gender
	ld b, SPRITE_ANIM_INDEX_BLUE_WALK
	dec a ; PLAYER_FEMALE
	jr z, .got_gender
	; PLAYER_ENBY
	ld b, SPRITE_ANIM_INDEX_GREEN_WALK
.got_gender
	ld a, b
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $10
	ret

LoadTownMapGFX:
	ld de, vTiles2
	ld hl, TownMapGFX
	lb bc, BANK(TownMapGFX), $45
	jmp DecompressRequest2bpp

JohtoMap:
INCBIN "gfx/town_map/johto.bin"

KantoMap:
INCBIN "gfx/town_map/kanto.bin"

OrangeMap:
INCBIN "gfx/town_map/orange.bin"

PokegearGFX:
INCBIN "gfx/pokegear/pokegear.2bpp.lz"
