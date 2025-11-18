UpdateTimeOfDayPal::
	call UpdateTime
	ld a, [wTimeOfDay]
	ld [wCurTimeOfDay], a
	call GetTimePalette
	ld [wTimeOfDayPal], a
	ret

_TimeOfDayPals::
; return carry if pals are changed

; forced pals?
	ld hl, wTimeOfDayPalFlags
	bit 7, [hl]
	jr nz, .dontchange

; do we need to bother updating?
	ld a, [wTimeOfDay]
	ld hl, wCurTimeOfDay
	cp [hl]
	jr z, .dontchange

; if so, the time of day has changed
	ld a, [wTimeOfDay]
	ld [wCurTimeOfDay], a

; get palette id
	call GetTimePalette

; same palette as before?
	ld hl, wTimeOfDayPal
	cp [hl]
	jr z, .dontchange

; update palette id
	ld [wTimeOfDayPal], a

; save bg palette 7
	ld hl, wBGPals1 palette 7

; save wram bank
	ldh a, [rWBK]
	ld b, a
; wram bank 5
	ld a, 5
	ldh [rWBK], a

; push palette
	ld c, 4 ; PAL_COLORS
.push
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	push de
	dec c
	jr nz, .push

; restore wram bank
	ld a, b
	ldh [rWBK], a

; update cgb pals
	ld a, CGB_MAPPALS
	call GetCGBLayout

; restore bg palette 7
	ld hl, wBGPals1 palette 7 + 1 palettes - 1 ; last byte in UnknBGPals

; save wram bank
	ldh a, [rWBK]
	ld d, a
; wram bank 5
	ld a, 5
	ldh [rWBK], a

; pop palette
	ld e, 4 ; PAL_COLORS
.pop
	pop bc
	ld a, c
	ld [hld], a
	ld a, b
	ld [hld], a
	dec e
	jr nz, .pop

; restore wram bank
	ld a, d
	ldh [rWBK], a

; update palettes
	farcall LoadMapPalettes
	farcall EnableDynPalUpdatesNoApply
	farcall OWFadePalettesInit

; successful change
	scf
	ret

.dontchange
; no change occurred
	and a
	ret

_UpdateTimePals::
	ld c, $9 ; normal
UpdatePalFromC::
	call GetTimePalFade
	jr DmgToCgbTimePals

FadeInPalettes_EnableDynNoApply:
	farcall EnableDynPalUpdatesNoApply
	; fallthrough
FadeInPalettes::
	ld c, 10
	jmp FadePalettes

FadeOutPalettes::
	ld c, 10
	jmp FadeToWhite

Special_FadeInQuickly:
	ld c, $0
	call GetTimePalFade
	ld b, $4
	jr ConvertTimePalsIncHL

Special_FadeBlackQuickly:
	ld c, $9
	call GetTimePalFade
	ld b, $4
	jr ConvertTimePalsDecHL

ReplaceTimeOfDayPals:
	ld a, [wMapTimeOfDay]
	and IN_DARKNESS ; needs Flash
	jr z, .not_dark
	ld a, [wStatusFlags]
	bit 2, a ; Flash
	jr nz, .not_dark
	ld a, DARKNESS_PALSET
	ld [wTimeOfDayPalset], a
	ret

.not_dark
	ld hl, .BrightnessLevels
	ld a, [wMapTimeOfDay]
	and $7
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wTimeOfDayPalset], a
	ret

MACRO brightlevel
	db (\1 << 6) | (\2 << 4) | (\3 << 2) | \4
ENDM

.BrightnessLevels:
	brightlevel 3, 2, 1, 0 ; PALETTE_AUTO
	brightlevel 1, 1, 1, 1 ; PALETTE_DAY
	brightlevel 2, 2, 2, 2 ; PALETTE_NITE
	brightlevel 0, 0, 0, 0 ; PALETTE_MORN
	brightlevel 3, 3, 3, 3 ; PALETTE_EVE

GetTimePalette:
	ld a, [wTimeOfDay]
	call StackJumpTable

.TimePalettes:
	dw .MorningPalette
	dw .DayPalette
	dw .NitePalette
	dw .EvePalette

.MorningPalette:
	ld a, [wTimeOfDayPalset]
	and %00000011 ; 0
	ret

.DayPalette:
	ld a, [wTimeOfDayPalset]
	and %00001100 ; 1
	srl a
	srl a
	ret

.NitePalette:
	ld a, [wTimeOfDayPalset]
	and %00110000 ; 2
	swap a
	ret

.EvePalette:
	ld a, [wTimeOfDayPalset]
	and %11000000 ; 3
	rlca
	rlca
	ret

DmgToCgbTimePals:
	push hl
	push de
	ld a, [hli]
	call DmgToCgbBGPals
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call DmgToCgbObjPals
	pop de
	pop hl
	ret

ConvertTimePalsIncHL:
.loop
	call DmgToCgbTimePals
	inc hl
	inc hl
	inc hl
	ld c, 2
	call DelayFrames
	dec b
	jr nz, .loop
	ret

ConvertTimePalsDecHL:
.loop
	call DmgToCgbTimePals
	dec hl
	dec hl
	dec hl
	ld c, 2
	call DelayFrames
	dec b
	jr nz, .loop
	ret

GetTimePalFade:
	ld hl, .cgbfade
	ld b, $0
	add hl, bc
	ret

.cgbfade
	db %11111111, %11111111, %11111111
	db %11111110, %11111110, %11111110
	db %11111001, %11111001, %11111001
	db %11100100, %11100100, %11100100
	db %10010000, %10010000, %10010000
	db %01000000, %01000000, %01000000
	db %00000000, %00000000, %00000000
