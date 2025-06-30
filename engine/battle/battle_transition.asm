DoBattleTransition:
	farcall ReanchorBGMap_NoOAMUpdate
	call UpdateSprites
	call DelayFrame

	ld de, .TrainerBattlePokeballTile
	ld hl, vTiles0 tile "<PHONE>"
	lb bc, BANK(.TrainerBattlePokeballTile), 1
	call Request2bpp

	ld b, 3
	call SafeCopyTilemapAtOnce

	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	call DelayFrame

	xor a
	ldh [hBGMapMode], a
	ld hl, wJumptableIndex
	ld [hli], a
	ld [hli], a
	ld [hl], a

	call WipeLYOverrides

	ldh a, [rBGP]
	ld [wBGP], a
	ldh a, [rOBP0]
	ld [wOBP0], a
	ldh a, [rOBP1]
	ld [wOBP1], a
	call DelayFrame
	ld hl, hVBlank
	ld a, [hl]
	push af
	ld [hl], 3

	jr .handleLoop
.loop
	ld hl, .BattleTransitionScenes
	call JumpTable
	call DelayFrame
.handleLoop
	ld a, [wJumptableIndex]
	bit 7, a
	jr z, .loop

	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rWBK], a

	ld hl, wBGPals1
if !DEF(MONOCHROME)
	ld bc, 8 palettes
	xor a ; RGB 00, 00, 00
	rst ByteFill
else
	ld b, (8 palettes) / 2
.mono_loop
	ld a, LOW(PAL_MONOCHROME_BLACK)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_BLACK)
	ld [hli], a
	dec b
	jr nz, .mono_loop
endc

	pop af
	ldh [rWBK], a

	ld a, %11111111
	ld [wBGP], a
	call DmgToCgbBGPals
	call DelayFrame

	ld hl, rIE
	res B_IE_STAT, [hl]

	xor a
	ldh [hLCDCPointer], a
	ldh [hLYOverrideStart], a
	ldh [hLYOverrideEnd], a
	ldh [hSCY], a

	ld a, BANK(wEnemyMon)
	ldh [rWBK], a

	pop af
	ldh [hVBlank], a
	jmp DelayFrame

.TrainerBattlePokeballTile:
INCBIN "gfx/overworld/trainer_battle_pokeball_tile.2bpp"

.BattleTransitionScenes
	dw StartTrainerBattle_DetermineWhichAnimation ; 00

	; Animation 1: cave
	dw StartTrainerBattle_LoadPokeBallGraphics ; 01
	dw StartTrainerBattle_SetUpBGMap ; 02
	dw StartTrainerBattle_Flash ; 03
	dw StartTrainerBattle_Flash ; 04
	dw StartTrainerBattle_Flash ; 05
	dw StartTrainerBattle_NextScene ; 06
	dw StartTrainerBattle_SetUpForWavyOutro ; 07
	dw StartTrainerBattle_SineWave ; 08

	; Animation 2: cave, stronger
	dw StartTrainerBattle_LoadPokeBallGraphics ; 09
	dw StartTrainerBattle_SetUpBGMap ; 0a
	dw StartTrainerBattle_Flash ; 0b
	dw StartTrainerBattle_Flash ; 0c
	dw StartTrainerBattle_Flash ; 0d
	dw StartTrainerBattle_NextScene ; 0e
	; There is no setup for this one
	dw StartTrainerBattle_ZoomToBlack ; 0f

	; Animation 3: no cave
	dw StartTrainerBattle_LoadPokeBallGraphics ; 10
	dw StartTrainerBattle_SetUpBGMap ; 11
	dw StartTrainerBattle_Flash ; 12
	dw StartTrainerBattle_Flash ; 13
	dw StartTrainerBattle_Flash ; 14
	dw StartTrainerBattle_NextScene ; 15
	dw StartTrainerBattle_SetUpForSpinOutro ; 16
	dw StartTrainerBattle_SpinToBlack ; 17

	; Animation 4: no cave, stronger
	dw StartTrainerBattle_LoadPokeBallGraphics ; 18
	dw StartTrainerBattle_SetUpBGMap ; 19
	dw StartTrainerBattle_Flash ; 1a
	dw StartTrainerBattle_Flash ; 1b
	dw StartTrainerBattle_Flash ; 1c
	dw StartTrainerBattle_NextScene ; 1d
	dw StartTrainerBattle_SetUpForRandomScatterOutro ; 1e
	dw StartTrainerBattle_SpeckleToBlack ; 1f

	; All animations jump to here.
	dw StartTrainerBattle_Finish ; 20

StartTrainerBattle_DetermineWhichAnimation:
; The screen flashes a different number of
; times depending on the level of your lead
; Pokemon relative to the opponent's.
	ld de, 0

	ld a, [wOtherTrainerClass]
	and a
	jr z, .wild
	farcall SetTrainerBattleLevel
.wild

; Get the first Pokemon in your party that isn't fainted.
	ld hl, wPartyMon1HP
	ld bc, PARTYMON_STRUCT_LENGTH - 1
.loop
	ld a, [hli]
	or [hl]
	jr nz, .ok
	add hl, bc
	jr .loop
.ok
; to PartyMonLevel
rept 4
	dec hl
endr
	ld a, [hl]
	add 3

; Compare with wild encounter level
	ld hl, wCurPartyLevel
	cp [hl]
	jr nc, .okay
	set 0, e
.okay
	ld a, [wEnvironment]
	cp CAVE
	jr z, .okay2
	cp ISOLATED
	jr z, .okay2
	cp DUNGEON
	jr z, .okay2
	set 1, e
.okay2
	ld hl, .StartingPoints
	add hl, de
	ld a, [hl]
	ld [wJumptableIndex], a
	ret

.StartingPoints:
	db 1,  9
	db 16, 24

StartTrainerBattle_Finish:
	call ClearSprites
	ld a, $80
	ld [wJumptableIndex], a
	ret

StartTrainerBattle_Flash:
	ldh a, [hBattlePalFadeMode]
	ld [wPalFadeMode], a
	ld c, 10
	call DoFadePalettes
	; fallthrough

StartTrainerBattle_NextScene:
	ld hl, wJumptableIndex
	inc [hl]
	ret

StartTrainerBattle_SetUpBGMap:
	call StartTrainerBattle_NextScene
	xor a
	ld [wBattleTransitionCounter], a
	ldh [hBGMapMode], a
	ret

StartTrainerBattle_SetUpForWavyOutro:
	farcall BattleStart_HideAllSpritesExceptBattleParticipants
	ld a, BANK(wLYOverrides)
	ldh [rWBK], a

	call StartTrainerBattle_NextScene

	ld hl, rIE
	set B_IE_STAT, [hl]
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	xor a
	ldh [hLYOverrideStart], a
	ld a, $90
	ldh [hLYOverrideEnd], a
	xor a
	ld [wBattleTransitionCounter], a
	ld [wBattleTransitionSineWaveOffset], a
	ret

StartTrainerBattle_SineWave:
	ld a, [wBattleTransitionCounter]
	cp $60
	jr c, .DoSineWave
	ld a, $20
	ld [wJumptableIndex], a
	ret

.DoSineWave:
	ld hl, wBattleTransitionSineWaveOffset
	ld a, [hl]
	inc [hl]
	ld hl, wBattleTransitionCounter
	ld d, [hl]
	add [hl]
	ld [hl], a
	ld a, wLYOverridesEnd - wLYOverrides
	ld bc, wLYOverrides
	ld e, $0

.loop
	push af
	push de
	ld a, e
	call Sine
	ld [bc], a
	inc bc
	pop de
	inc e
	inc e
	pop af
	dec a
	jr nz, .loop
	ret

StartTrainerBattle_SetUpForSpinOutro:
	farcall BattleStart_HideAllSpritesExceptBattleParticipants
	ld a, BANK(wLYOverrides)
	ldh [rWBK], a
	call StartTrainerBattle_NextScene
	xor a
	ld [wBattleTransitionCounter], a
	ret

MACRO spintable_entry
	db \1
	dw .wedge\2
	dw \4 * SCREEN_WIDTH + \3 + wAttrmap
ENDM

; quadrants
	const_def
	const UPPER_LEFT
	const UPPER_RIGHT
	const LOWER_LEFT
	const LOWER_RIGHT

StartTrainerBattle_SpinToBlack:
	xor a
	ldh [hBGMapMode], a
	ld a, [wBattleTransitionCounter]
	ld e, a
	ld d, 0
	ld hl, .spintable
rept 5
	add hl, de
endr
	ld a, [hli]
	cp -1
	jr z, .end
	ld [wBattleTransitionSpinQuadrant], a
	call .load
	ld a, $2
	ldh [hBGMapMode], a
	ld hl, wBattleTransitionCounter
	ld a, [hl]
	inc [hl]
.mod_3
	; Ensure that music lines up with the transistion
	sub 3
	jr nc, .mod_3
	add 3
	ret z
	jmp DelayFrame

.end
	xor a
	ldh [hBGMapMode], a
	ld a, $20
	ld [wJumptableIndex], a
	ret

.spintable
	spintable_entry UPPER_LEFT,   1,  9,  8
	spintable_entry UPPER_LEFT,   2,  1,  6
	spintable_entry UPPER_LEFT,   3,  0,  4
	spintable_entry UPPER_LEFT,   4,  0,  2
	spintable_entry UPPER_LEFT,   5,  0,  0
	spintable_entry UPPER_LEFT,   6,  1,  0
	spintable_entry UPPER_LEFT,   7,  3,  0
	spintable_entry UPPER_LEFT,   8,  5,  0
	spintable_entry UPPER_LEFT,   9,  7,  0
	spintable_entry UPPER_LEFT,  10,  9,  0
	spintable_entry UPPER_RIGHT, 10, 10,  0
	spintable_entry UPPER_RIGHT,  9, 12,  0
	spintable_entry UPPER_RIGHT,  8, 14,  0
	spintable_entry UPPER_RIGHT,  7, 16,  0
	spintable_entry UPPER_RIGHT,  6, 18,  0
	spintable_entry UPPER_RIGHT,  5, 19,  0
	spintable_entry UPPER_RIGHT,  4, 19,  2
	spintable_entry UPPER_RIGHT,  3, 19,  4
	spintable_entry UPPER_RIGHT,  2, 18,  6
	spintable_entry UPPER_RIGHT,  1, 10,  8
	spintable_entry LOWER_RIGHT,  1, 10,  9
	spintable_entry LOWER_RIGHT,  2, 18, 11
	spintable_entry LOWER_RIGHT,  3, 19, 13
	spintable_entry LOWER_RIGHT,  4, 19, 15
	spintable_entry LOWER_RIGHT,  5, 19, 17
	spintable_entry LOWER_RIGHT,  6, 18, 17
	spintable_entry LOWER_RIGHT,  7, 16, 17
	spintable_entry LOWER_RIGHT,  8, 14, 17
	spintable_entry LOWER_RIGHT,  9, 12, 17
	spintable_entry LOWER_RIGHT, 10, 10, 17
	spintable_entry LOWER_LEFT,  10,  9, 17
	spintable_entry LOWER_LEFT,   9,  7, 17
	spintable_entry LOWER_LEFT,   8,  5, 17
	spintable_entry LOWER_LEFT,   7,  3, 17
	spintable_entry LOWER_LEFT,   6,  1, 17
	spintable_entry LOWER_LEFT,   5,  0, 17
	spintable_entry LOWER_LEFT,   4,  0, 15
	spintable_entry LOWER_LEFT,   3,  0, 13
	spintable_entry LOWER_LEFT,   2,  1, 11
	spintable_entry LOWER_LEFT,   1,  9,  9
	db -1

.load
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	push hl
	ld a, [de]
	ld c, a
	inc de
.loop1
	ld a, [hl]
	and ~OAM_PALETTE
	or PAL_BG_TEXT ; black
	ld [hl], a
	ld a, [wBattleTransitionSpinQuadrant]
	bit 0, a
	jr z, .leftside
	inc hl
	jr .okay1
.leftside
	dec hl
.okay1
	dec c
	jr nz, .loop1
	pop hl
	ld a, [wBattleTransitionSpinQuadrant]
	bit 1, a
	ld bc, SCREEN_WIDTH
	jr z, .upper
	ld bc, -SCREEN_WIDTH
.upper
	add hl, bc
	ld a, [de]
	inc de
	cp -1
	ret z
	and a
	jr z, .loop
	ld c, a
.loop2
	ld a, [wBattleTransitionSpinQuadrant]
	bit 0, a
	jr z, .leftside2
	dec hl
	jr .okay2
.leftside2
	inc hl
.okay2
	dec c
	jr nz, .loop2
	jr .loop

; wedgeN: db width towards edge, x increment or -1 if done
.wedge1 db 10, -1
.wedge2 db 2, 4, 6, -1
.wedge3 db 1, 2, 3, 2, 3, 3, 2, -1
.wedge4 db 1, 1, 2, 2, 3, 1, 2, 2, 2, 1, 1, -1
.wedge5 db 1, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, -1
.wedge6 db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, -1
.wedge7 db 2, 1, 2, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, -1
.wedge8 db 2, 1, 2, 0, 2, 1, 2, 0, 1, 1, 2, 0, 1, 1, 1, -1
.wedge9 db 2, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, -1
.wedge10 db 2, 0, 2, 0, 2, 0, 1, 0, 1, 0, 1, -1

StartTrainerBattle_SetUpForRandomScatterOutro:
	farcall BattleStart_HideAllSpritesExceptBattleParticipants
	ld a, BANK(wLYOverrides)
	ldh [rWBK], a
	call StartTrainerBattle_NextScene
	ld a, $10
	ld [wBattleTransitionCounter], a
	ld a, $2
	ldh [hBGMapMode], a
	ret

StartTrainerBattle_SpeckleToBlack:
	ld hl, wBattleTransitionCounter
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ld c, $c
.loop
	push bc
	call .BlackOutRandomTile
	pop bc
	dec c
	jr nz, .loop
	ret

.done
	ld a, $2
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ld a, $20
	ld [wJumptableIndex], a
	ret

.BlackOutRandomTile:
.y_loop
	call Random
	cp SCREEN_HEIGHT
	jr nc, .y_loop
	ld b, a

.x_loop
	call Random
	cp SCREEN_WIDTH
	jr nc, .x_loop
	ld c, a

	hlcoord 0, -1, wAttrmap
	ld de, SCREEN_WIDTH
	inc b

.row_loop
	add hl, de
	dec b
	jr nz, .row_loop
	add hl, bc

; If the tile has already been blacked out,
; sample a new tile
	ld a, [hl]
	and OAM_PALETTE
	cp PAL_BG_TEXT ; black
	jr z, .y_loop
	ld a, [hl]
	and ~OAM_PALETTE
	or PAL_BG_TEXT ; black
	ld [hl], a
	ret

StartTrainerBattle_LoadPokeBallGraphics:
	xor a
	ldh [hBGMapMode], a

	; store this in HRAM to avoid bank-switching later
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	ld a, 4 << 3 ; darkness offset
	jr z, .got_offset
	ld a, [wTimeOfDayPal]
	and %00000011
	add a
	add a
	add a
.got_offset
	ldh [hTimeOfDayPalOffset], a

	ld a, [wOtherTrainerClass]
	and a
	jr nz, .trainer_battle

	; wild battles just need PAL_BG_TEXT to be black, and do flash PAL_BG_GRAY
	ld a, PALFADE_BG | PALFADE_FLASH
	ldh [hBattlePalFadeMode], a
	ldh a, [rWBK]
	push af
	ld a, $5 ; WRAM5 = palettes
	ldh [rWBK], a
	ld hl, .black_pals
	call .timeofdaypal
	ld de, wBGPals1 palette PAL_BG_TEXT ; black
	call .copy
	pop af
	ldh [rWBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	call DelayFrame
	call CopyTilemapAtOnce
	jmp StartTrainerBattle_NextScene

.trainer_battle
	; don't flash PAL_BG_GRAY, the poke ball palette
	ld a, PALFADE_BG | PALFADE_FLASH | PALFADE_SKIP_FIRST
	ldh [hBattlePalFadeMode], a

	; use PAL_BG_RED for the whole flashing screen
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_AREA
.loop1
	ld a, [hl]
	and ~OAM_PALETTE
	or PAL_BG_RED ; flashing overworld
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .loop1

	ld a, [wOtherTrainerClass]
	farcall IsJohtoGymLeader
	ld de, GymLeaderTransition
	jr c, .got_transition
	ld a, [wOtherTrainerClass]
	ld hl, RocketTrainerClasses
	call IsInByteArray
	ld de, RocketTransition
	jr c, .got_transition
	ld de, PokeBallTransition
.got_transition
	hlcoord 2, 1
	ld b, SCREEN_WIDTH - 4
.loop2
	push hl
	ld c, 2
.loop3
	push hl
	ld a, [de]
	inc de
.loop4
; Loading is done bit by bit
	and a
	jr z, .done
	add a
	jr nc, .no_load

	; poke ball tile; use PAL_BG_GRAY, bank 0, no flips or priority
	ld [hl], "<PHONE>"
	push hl
	push bc
	ld bc, wAttrmap - wTilemap
	add hl, bc
	ld [hl], PAL_BG_GRAY ; poke ball
	pop bc
	pop hl

.no_load
	inc hl
	jr .loop4

.done
	pop hl
	push bc
	ld bc, (SCREEN_WIDTH - 4) / 2
	add hl, bc
	pop bc
	dec c
	jr nz, .loop3

	pop hl
	push bc
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop2

	ld hl, .armored_mewtwo_pals
	ld a, [wOtherTrainerClass]
	cp GIOVANNI
	jr nz, .not_armored_mewtwo
	ld a, [wOtherTrainerID]
	cp GIOVANNI1
	jr z, .got_palette

.not_armored_mewtwo
	ld hl, .timepals
	call .timeofdaypal
.got_palette
	ldh a, [rWBK]
	push af
	ld a, $5 ; WRAM5 = palettes
	ldh [rWBK], a
	call .copypals
	pop af
	ldh [rWBK], a
	farcall ClearSavedObjPals
	farcall CheckForUsedObjPals
	farcall _UpdateSprites
	ld a, $1
	ldh [hCGBPalUpdate], a
	call DelayFrame
	call CopyTilemapAtOnce
	jmp StartTrainerBattle_NextScene

.copypals
	ld de, wBGPals1 palette PAL_BG_GRAY ; red poke ball, doesn't flash
	call .copy
	ld de, wBGPals1 palette PAL_BG_RED ; flashing overworld
	call .copy
	ld de, wBGPals1 palette PAL_BG_GREEN
	call .copy
	ld de, wBGPals1 palette PAL_BG_WATER
	call .copy
	ld de, wBGPals1 palette PAL_BG_YELLOW
	call .copy
	ld de, wBGPals1 palette PAL_BG_BROWN
	call .copy
	ld de, wBGPals1 palette PAL_BG_ROOF
	call .copy
	ld hl, .black_pals
	call .timeofdaypal
	ld de, wBGPals1 palette PAL_BG_TEXT ; black

.copy
	push hl
	push de
	ld bc, 1 palettes
	rst CopyBytes
	pop de
	ld hl, wBGPals2 - wBGPals1
	add hl, de
	ld d, h
	ld e, l
	pop hl
	push hl
	ld bc, 1 palettes
	rst CopyBytes
	pop hl
	ret

.timeofdaypal
	ldh a, [hTimeOfDayPalOffset]
	push bc
	ld b, 0
	ld c, a
	add hl, bc
	pop bc
	ret

.timepals
INCLUDE "gfx/overworld/trainer_battle.pal"

.armored_mewtwo_pals
INCLUDE "gfx/overworld/mewtwo_battle.pal"

.black_pals
INCLUDE "gfx/overworld/black.pal"

pusho b.X

PokeBallTransition:
	bigdw %......XXXX......
	bigdw %....XXXXXXXX....
	bigdw %..XXXX....XXXX..
	bigdw %..XX........XX..
	bigdw %.XX..........XX.
	bigdw %.XX...XXXX...XX.
	bigdw %XX...XX..XX...XX
	bigdw %XXXXXX....XXXXXX
	bigdw %XXXXXX....XXXXXX
	bigdw %XX...XX..XX...XX
	bigdw %.XX...XXXX...XX.
	bigdw %.XX..........XX.
	bigdw %..XX........XX..
	bigdw %..XXXX....XXXX..
	bigdw %....XXXXXXXX....
	bigdw %......XXXX......

RocketTransition:
	bigdw %XXXXXXXXXXXX....
	bigdw %XXXXXXXXXXXXXX..
	bigdw %XXXXXXXXXXXXXXX.
	bigdw %XXXXXXXXXXXXXXX.
	bigdw %XXXXX.....XXXXXX
	bigdw %XXXXX......XXXXX
	bigdw %XXXXX.....XXXXXX
	bigdw %XXXXXXXXXXXXXXX.
	bigdw %XXXXXXXXXXXXXXX.
	bigdw %XXXXXXXXXXXXXX..
	bigdw %XXXXXXXXXXXXX...
	bigdw %XXXXX....XXXXX..
	bigdw %XXXXX....XXXXX..
	bigdw %XXXXX.....XXXXX.
	bigdw %XXXXX......XXXXX
	bigdw %XXXXX......XXXXX

GymLeaderTransition:
	bigdw %.....XX......XX.
	bigdw %...XXXXXX.XXXXX.
	bigdw %..XXX..XXXXXXX..
	bigdw %.XX......X..XX..
	bigdw %.XX..XX.X..XX...
	bigdw %XX..X..X...XX...
	bigdw %XX..X..X..XX....
	bigdw %.XXX.XX...XX....
	bigdw %.XX......XX.....
	bigdw %..XXX....XX.....
	bigdw %...XXXX.XX......
	bigdw %.....XX.XX......
	bigdw %......XXX.......
	bigdw %......XXX.......
	bigdw %......XX........
	bigdw %......XX........

popo

INCLUDE "data/trainers/team_rocket.asm"

WipeLYOverrides:
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a

	ld hl, wLYOverrides
	call .wipe
	ld hl, wLYOverridesBackup
	call .wipe

	pop af
	ldh [rWBK], a
	ret

.wipe
	xor a
	ld c, SCREEN_HEIGHT_PX
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

MACRO zoombox
; width, height, start y, start x
	db \1, \2
	dw \4 * SCREEN_WIDTH + \3 + wAttrmap
ENDM

StartTrainerBattle_ZoomToBlack:
	farcall BattleStart_HideAllSpritesExceptBattleParticipants
	ld de, .boxes

.loop
	ld a, [de]
	cp -1
	jr z, .done
	inc de
	ld c, a
	ld a, [de]
	inc de
	ld b, a
	ld a, [de]
	inc de
	ld l, a
	ld a, [de]
	inc de
	ld h, a
	xor a
	ldh [hBGMapMode], a
	call .Copy
	call ApplyAttrmapInVBlank
	jr .loop

.done
	ld a, $20
	ld [wJumptableIndex], a
	ret

.boxes
	zoombox  4,  2,  8, 8
	zoombox  6,  4,  7, 7
	zoombox  8,  6,  6, 6
	zoombox 10,  8,  5, 5
	zoombox 12, 10,  4, 4
	zoombox 14, 12,  3, 3
	zoombox 16, 14,  2, 2
	zoombox 18, 16,  1, 1
	zoombox 20, 18,  0, 0
	db -1

.Copy:
.row
	push bc
	push hl
.col
	ld a, [hl]
	and ~OAM_PALETTE
	or PAL_BG_TEXT ; black
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret
