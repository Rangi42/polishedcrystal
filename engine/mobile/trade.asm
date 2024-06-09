LoadMobileTradePalettes:
	ld hl, MobileTradeBorderPalettes
	ld de, wBGPals1
	ld bc, 8 palettes
	call FarCopyColorWRAM
	ld hl, MobileTradeLightsPalettes
	ld de, wOBPals1
	ld bc, 4 palettes
	call FarCopyColorWRAM
	farcall ApplyPals
	jmp SetDefaultBGPAndOBP

LoadMobileTradeScreenGFX:
	ld hl, MobileTradeScreenGFX
	ld de, vTiles2
	lb bc, BANK(MobileTradeScreenGFX), 41
	call DecompressRequest2bpp
	ld hl, MobileTradeLightsGFX
	ld de, vTiles0
	lb bc, BANK(MobileTradeLightsGFX), 4
	call DecompressRequest2bpp
	ret

DoNextStepForMobileTradeLights:
	ld a, [wMobileLightsTimer]
	and %1111111
	jr nz, .done
	ld a, $01
	ldh [hOAMUpdate], a
	call ClearSprites
	ld de, wShadowOAM
	call UpdateMobileTradeLights
	ld hl, wMobileLightsFlags
	bit MOBILE_LIGHTS_CYCLE_DOWN_F, [hl]
	jr nz, .cycle_down
	ld a, [wMobileLightsStep]
	inc a
	cp $2c
	ld [wMobileLightsStep], a
	jr z, .init_cycle_down

.done
	ld a, [wMobileLightsTimer]
	inc a
	ld [wMobileLightsTimer], a
	xor a
	ldh [hOAMUpdate], a
	ret

.init_cycle_down
	ld hl, wMobileLightsFlags
	set MOBILE_LIGHTS_CYCLE_DOWN_F, [hl]
	jr .done

.cycle_down
	ld a, [wMobileLightsStep]
	dec a
	ld [wMobileLightsStep], a
	jr z, .init_cycle_up
	jr .done

.init_cycle_up
	ld hl, wMobileLightsFlags
	res MOBILE_LIGHTS_CYCLE_DOWN_F, [hl]
	jr .done

UpdateMobileTradeLights:
	ld a, [wMobileLightsStep]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, MobileTradeLightSteps
	add hl, bc
	ld b, $30
	ld c, $08
.loop
	ld a, 0
	add [hl]
	inc hl
	push hl

	add a
	add a

	add LOW(Unknown_10327a)
	ld l, a
	ld a, HIGH(Unknown_10327a)
	adc 0
	ld h, a

	ld a, b
	add [hl]
	inc hl
	ld [de], a
	inc de
	ld a, $0a
	add [hl]
	inc hl
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	pop hl
	ld a, b
	add $08
	ld b, a
	dec c
	jr nz, .loop
	ret

MobileTradeLightSteps:
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $01, $00, $00, $00, $00, $00, $00, $00
	db $02, $01, $00, $00, $00, $00, $00, $00
	db $03, $02, $01, $00, $00, $00, $00, $00
	db $04, $03, $02, $01, $00, $00, $00, $00
	db $04, $04, $03, $02, $01, $00, $00, $00
	db $04, $04, $04, $03, $02, $01, $00, $00
	db $04, $04, $04, $04, $03, $02, $01, $00
	db $04, $04, $04, $04, $04, $03, $02, $01
	db $04, $04, $04, $04, $04, $04, $03, $02
	db $04, $04, $04, $04, $04, $04, $04, $03
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $03, $04, $04, $04, $04, $04, $04, $04
	db $02, $03, $04, $04, $04, $04, $04, $04
	db $01, $02, $03, $04, $04, $04, $04, $04
	db $00, $01, $02, $03, $04, $04, $04, $04
	db $00, $00, $01, $02, $03, $04, $04, $04
	db $00, $00, $00, $01, $02, $03, $04, $04
	db $00, $00, $00, $00, $01, $02, $03, $04
	db $00, $00, $00, $00, $00, $01, $02, $03
	db $00, $00, $00, $00, $00, $00, $01, $02
	db $00, $00, $00, $00, $00, $00, $00, $01
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00

Unknown_10327a:
	db $00, $00, $00, $00
	db $00, $00, $01, $00
	db $00, $00, $02, $00
	db $00, $00, $03, $00
	db $00, $00, $01, $01
	db $00, $00, $00, $00
	db $00, $00, $01, $02
	db $00, $00, $02, $02
	db $00, $00, $03, $02
	db $00, $00, $01, $03

MobileTradeScreenGFX:: INCBIN "gfx/mobile/mobile_trade_screen.2bpp.lz"

MobileTradeLightsGFX:: INCBIN "gfx/mobile/mobile_trade_lights.2bpp.lz"

MobileTradeBorderPalettes:: INCLUDE "gfx/mobile/mobile_border.pal"

MobileTradeLightsPalettes:: INCLUDE "gfx/mobile/mobile_trade_lights.pal"
