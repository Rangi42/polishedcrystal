NUM_INITIAL_OPTIONS EQU 6

SetInitialOptions:
	ld a, $10
	ld [MusicFade], a

	xor a ; MUSIC_NONE
	ld [MusicFadeIDLo], a
	ld [MusicFadeIDHi], a
	ld c, 8
	call DelayFrames

	call ClearBGPalettes
	call LoadFontsExtra

	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	call ByteFill

	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	call ByteFill

	ld hl, .BGPalette
	ld de, UnknBGPals
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	ld de, .BGTile
	ld hl, VTiles2 tile $00
	lb bc, BANK(.BGTile), 1
	call Get2bpp

	farcall ApplyPals

	call WaitBGMap2
	call SetPalettes

	ld hl, .InitialOptionsText
	call PrintText

	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], $1

;	call ClearBGPalettes

	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBox

	hlcoord 2, 2
	ld de, .InitialOptionsString
	call PlaceString

;	ld b, CGB_DIPLOMA
;	call GetCGBLayout
;	call SetPalettes

	xor a
	ld [wJumptableIndex], a
	ld [hJoyPressed], a
	ld c, NUM_INITIAL_OPTIONS
.print_text_loop ; this next will display the settings of each option when the menu is opened
	push bc
	xor a
	ld [hJoyLast], a
	call GetInitialOptionPointer
	pop bc
	ld hl, wJumptableIndex
	inc [hl]
	dec c
	jr nz, .print_text_loop

	xor a
	ld [wJumptableIndex], a
	inc a
	ld [hBGMapMode], a
	call WaitBGMap

.joypad_loop
	call JoyTextDelay
	ld a, [hJoyPressed]
	and START | B_BUTTON
	jr nz, .ExitOptions
	call InitialOptionsControl
	jr c, .dpad
	call GetInitialOptionPointer
	jr c, .ExitOptions

.dpad
	call InitialOptions_UpdateCursorPosition
	ld c, 3
	call DelayFrames
	jr .joypad_loop

.ExitOptions:
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	pop af
	ld [hInMenu], a
	ret
; e4241

.InitialOptionsText:
	text_jump _InitialOptionsText
	db "@"

.BGPalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 09, 30, 31
	RGB 01, 11, 31
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc

.BGTile:
INCBIN "gfx/new_game/init_bg.2bpp"

.InitialOptionsString:
	db "Natures<LNBRK>"
	db "            :<LNBRK>"
	db "Abilities<LNBRK>"
	db "            :<LNBRK>"
	db "Color variation<LNBRK>"
	db "            :<LNBRK>"
	db "Perfect IVs<LNBRK>"
	db "            :<LNBRK>"
	db "Traded #mon<LNBRK>"
	db "treat you as OT<LNBRK>"
	db "            :<LNBRK>"
	db "Nuzlocke mode<LNBRK>"
	db "            :<LNBRK>"
	db "<LNBRK>"
	db "Done@"

GetInitialOptionPointer: ; e42d6
	ld a, [wJumptableIndex] ; load the cursor position to a
	ld e, a ; copy it to de
	ld d, 0
	ld hl, .Pointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to the code of the current highlighted item
; e42e5

.Pointers:
	dw InitialOptions_Natures
	dw InitialOptions_Abilities
	dw InitialOptions_ColorVariation
	dw InitialOptions_PerfectIVs
	dw InitialOptions_TradedMon
	dw InitialOptions_NuzlockeMode
	dw InitialOptions_Done

InitialOptions_Natures:
	ld hl, InitialOptions
	ld a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit NATURES_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit NATURES_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res NATURES_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set NATURES_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 3
	call PlaceString
	and a
	ret

InitialOptions_Abilities:
	ld hl, InitialOptions
	ld a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit ABILITIES_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit ABILITIES_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res ABILITIES_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set ABILITIES_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 5
	call PlaceString
	and a
	ret

InitialOptions_ColorVariation:
	ld hl, InitialOptions
	ld a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit COLOR_VARY_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit COLOR_VARY_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res COLOR_VARY_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set COLOR_VARY_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 7
	call PlaceString
	and a
	ret

InitialOptions_PerfectIVs:
	ld hl, InitialOptions
	ld a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit PERFECT_IVS_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit PERFECT_IVS_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res PERFECT_IVS_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set PERFECT_IVS_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 9
	call PlaceString
	and a
	ret

InitialOptions_TradedMon:
	ld hl, InitialOptions
	ld a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit TRADED_AS_OT_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit TRADED_AS_OT_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res TRADED_AS_OT_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set TRADED_AS_OT_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 12
	call PlaceString
	and a
	ret

InitialOptions_NuzlockeMode:
	ld hl, InitialOptions
	ld a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit NUZLOCKE_MODE, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit NUZLOCKE_MODE, [hl]
	jr z, .SetYes
.SetNo:
	res NUZLOCKE_MODE, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set NUZLOCKE_MODE, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 14
	call PlaceString
	and a
	ret

InitialOptions_Done:
	ld hl, InitialOptions
	res RESET_INIT_OPTS, [hl]
	ld a, [hJoyPressed]
	and A_BUTTON
	jr nz, .Exit
	and a
	ret

.Exit:
	scf
	ret

NoString:
	db "No @"
YesString:
	db "Yes@"

InitialOptionsControl: ; e452a
	ld hl, wJumptableIndex
	ld a, [hJoyLast]
	cp D_DOWN
	jr z, .DownPressed
	cp D_UP
	jr z, .UpPressed
	and a
	ret

.DownPressed:
	ld a, [hl] ; load the cursor position to a
	cp NUM_INITIAL_OPTIONS
	jr nz, .Increase
	ld [hl], -1
.Increase:
	inc [hl]
	scf
	ret

.UpPressed:
	ld a, [hl]
	and a
	jr nz, .Decrease
	ld [hl], NUM_INITIAL_OPTIONS + 1
.Decrease:
	dec [hl]
	scf
	ret
; e455c

InitialOptions_UpdateCursorPosition: ; e455c
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, SCREEN_HEIGHT - 2
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	ld hl, .InitialOptions_CursorPositions
	ld a, [wJumptableIndex]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	; hlcoord 1, a
	ld hl, TileMap
	ld bc, SCREEN_WIDTH
	call AddNTimes
	inc hl
	ld [hl], "▶"
	ret
; e4579

.InitialOptions_CursorPositions:
	db 2, 4, 6, 8, 10, 13, 16
