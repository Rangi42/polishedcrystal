INCLUDE "constants.asm"


SECTION "Credits", ROMX

	const_def
	const SATOSHI_TAJIRI
	const JUNICHI_MASUDA
	const TETSUYA_WATANABE
	const SHIGEKI_MORIMOTO
	const SOUSUKE_TAMADA
	const TAKENORI_OOTA
	const KEN_SUGIMORI
	const MOTOFUMI_FUJIWARA
	const ATSUKO_NISHIDA
	const MUNEO_SAITO
	const SATOSHI_OOTA
	const RENA_YOSHIKAWA
	const JUN_OKUTANI
	const HIRONOBU_YOSHIDA
	const ASUKA_IWASHITA
	const GO_ICHINOSE
	const MORIKAZU_AOKI
	const KOHJI_NISHINO
	const KENJI_MATSUSHIMA
	const TOSHINOBU_MATSUMIYA
	const SATORU_IWATA
	const NOBUHIRO_SEYA
	const KAZUHITO_SEKINE
	const TETSUJI_OOTA
	const NCL_SUPER_MARIO_CLUB
	const SARUGAKUCHO
	const AKITO_MORI
	const TAKAHIRO_HARADA
	const TOHRU_HASHIMOTO
	const NOBORU_MATSUMOTO
	const TAKEHIRO_IZUSHI
	const TAKASHI_KAWAGUCHI
	const TSUNEKAZU_ISHIHARA
	const HIROSHI_YAMAUCHI
	const KENJI_SAIKI
	const ATSUSHI_TADA
	const NAOKO_KAWAKAMI
	const HIROYUKI_ZINNAI
	const KUNIMI_KAWAMURA
	const HISASHI_SOGABE
	const KEITA_KAGAYA
	const YOSHINORI_MATSUDA
	const HITOMI_SATO
	const TORU_OSAWA
	const TAKAO_OHARA
	const YUICHIRO_ITO
	const TAKAO_SHIMIZU
	const PLANNING
	const KEITA_NAKAMURA
	const HIROTAKA_UEMURA
	const HIROAKI_TAMURA
	const NORIAKI_SAKAGUCHI
	const MIYUKI_SATO
	const GAKUZI_NOMOTO
	const AI_MASHIMA
	const MIKIHIRO_ISHIKAWA
	const HIDEYUKI_HASHIMOTO
	const SATOSHI_YAMATO
	const SHIGERU_MIYAMOTO
	const GAIL_TILDEN
	const NOB_OGASAWARA
	const SETH_MCMAHILL
	const HIROTO_ALEXANDER
	const TERESA_LILLYGREN
	const THOMAS_HERTZOG
	const ERIK_JOHNSON
	const HIRO_NAKAMURA
	const TERUKI_MURAKAWA
	const KAZUYOSHI_OSAWA
	const KIMIKO_NAKAMICHI
	const CREDIT_END
	const CREDIT_UNKNOWN
	const STAFF
	const DIRECTOR
	const CODIRECTOR
	const PROGRAMMERS
	const GRAPHICS_DIRECTOR
	const MONSTER_DESIGN
	const GRAPHICS_DESIGN
	const CREDIT_MUSIC
	const CREDIT_SOUND_EFFECTS
	const GAME_DESIGN
	const GAME_SCENARIO
	const TOOL_PROGRAMMING
	const PARAMETRIC_DESIGN
	const SCRIPT_DESIGN
	const MAP_DATA_DESIGN
	const MAP_DESIGN
	const PRODUCT_TESTING
	const SPECIAL_THANKS
	const PRODUCERS
	const EXECUTIVE_PRODUCER
	const POKEMON_ANIMATION
	const POKEDEX_TEXT
	const MOBILE_PRJ_LEADER
	const MOBILE_SYSTEM_AD
	const MOBILE_STADIUM_DIR
	const COORDINATION
	const COPYRIGHT
	const US_VERSION_STAFF
	const US_COORDINATION
	const TEXT_TRANSLATION
	const PAAD_TESTING

	const_def -7
	const CREDITS_THEEND
	const CREDITS_WAIT2
	const CREDITS_MUSIC
	const CREDITS_CLEAR
	const CREDITS_SCENE
	const CREDITS_WAIT
	const CREDITS_END


SetCreditsSpawn::
	ld a, b
	ld [wCreditsSpawn], a
	ret


Credits:: ; 109847
	xor a
	bit 6, b ; Hall Of Fame
	jr z, .okay
	ld a, $40
.okay
	ld [wJumptableIndex], a

	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a

	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites

	ld hl, wCreditsFaux2bpp
	ld c, $80
	lb de, %11111111, %00000000 ; solid light gray hue

.load_loop
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	dec c
	jr nz, .load_loop

	ld de, CreditsBorderGFX
	ld hl, VTiles2 tile $20
	lb bc, BANK(CreditsBorderGFX), $09
	call Request2bpp

	ld de, CopyrightGFX
	ld hl, VTiles2 tile $60
	lb bc, BANK(CopyrightGFX), $1d
	call Request2bpp

	ld de, TheEndGFX
	ld hl, VTiles2 tile $40
	lb bc, BANK(TheEndGFX), $10
	call Request2bpp

	ld a, $ff
	ld [wCreditsBorderFrame], a
	xor a
	ld [wCreditsBorderMon], a

	call Credits_LoadBorderGFX
	ld e, l
	ld d, h
	ld hl, VTiles2
	lb bc, BANK(CreditsMonsGFX), 16
	call Request2bpp

	call ConstructCreditsTilemap
	xor a
	ld [wCreditsLYOverride], a

	ld hl, LYOverrides
	ld bc, $100
	xor a
	call ByteFill

	ld a, rSCX - $ff00
	ld [hLCDCPointer], a

	call GetCreditsPalette
	call SetPalettes
	ld a, [hVBlank]
	push af
	ld a, $5
	ld [hVBlank], a
	ld a, $1
	ld [hInMenu], a
	xor a
	ld [hBGMapMode], a
	ld [CreditsPos], a
	ld [CreditsPos+1], a
	ld [CreditsTimer], a

.execution_loop
	call Credits_HandleBButton
	call Credits_HandleAButton
	jr nz, .exit_credits

	call Credits_Jumptable
	call DelayFrame
	jr .execution_loop

.exit_credits
	call ClearBGPalettes
	xor a
	ld [hLCDCPointer], a
	ld [hBGMapAddress], a
	pop af
	ld [hVBlank], a
	pop af
	ld [rSVBK], a
	ret
; 1098fd

Credits_HandleAButton: ; 1098fd
	ld a, [hJoypadDown]
	and A_BUTTON
	ret z
	ld a, [wJumptableIndex]
	bit 7, a
	ret
; 109908

Credits_HandleBButton: ; 109908
	ld a, [hJoypadDown]
	and B_BUTTON
	ret z
	ld a, [wJumptableIndex]
	bit 6, a
	ret z
	ld hl, CreditsPos
	ld a, [hli]
	cp $d
	jr nc, .okay
	ld a, [hli]
	and a
	ret z
.okay
	ld hl, CreditsTimer
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret
; 109926

Credits_Jumptable: ; 109926
	ld a, [wJumptableIndex]
	and $f
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
; 109937


.Jumptable: ; 109937 (42:5937)

	dw ParseCredits
	dw Credits_Next
	dw Credits_Next
	dw Credits_PrepBGMapUpdate
	dw Credits_UpdateGFXRequestPath
	dw Credits_RequestGFX
	dw Credits_LYOverride
	dw Credits_Next
	dw Credits_Next
	dw Credits_Next
	dw Credits_UpdateGFXRequestPath
	dw Credits_RequestGFX
	dw Credits_LoopBack


Credits_Next: ; 109951 (42:5951)
	ld hl, wJumptableIndex
	inc [hl]
	ret

Credits_LoopBack: ; 109956 (42:5956)
	ld hl, wJumptableIndex
	ld a, [hl]
	and $f0
	ld [hl], a
	ret

Credits_PrepBGMapUpdate: ; 10995e (42:595e)
	xor a
	ld [hBGMapMode], a
	jp Credits_Next

Credits_UpdateGFXRequestPath: ; 109964 (42:5964)
	call Credits_LoadBorderGFX
	ld a, l
	ld [Requested2bppSource], a
	ld a, h
	ld [Requested2bppSource + 1], a
	ld a, VTiles2 % $100
	ld [Requested2bppDest], a
	ld a, VTiles2 / $100
	ld [Requested2bppDest + 1], a
	; fallthrough

Credits_RequestGFX: ; 10997b (42:597b)
	xor a
	ld [hBGMapMode], a
	ld a, $8
	ld [Requested2bpp], a
	jp Credits_Next

Credits_LYOverride: ; 109986 (42:5986)
	ld a, [rLY]
	cp $30
	jr c, Credits_LYOverride
	ld a, [wCreditsLYOverride]
	dec a
	dec a
	ld [wCreditsLYOverride], a
	ld hl, LYOverrides + $1f
	call .Fill
	ld hl, LYOverrides + $87
	call .Fill
	jp Credits_Next

.Fill: ; 1099a3 (42:59a3)
	ld c, $8
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret
; 1099aa


ParseCredits: ; 1099aa
	ld hl, wJumptableIndex
	bit 7, [hl]
	jp nz, .done

; Wait until the timer has run out to parse the next command.
	ld hl, CreditsTimer
	ld a, [hl]
	and a
	jr z, .parse

; One tick has passed.
	dec [hl]
	jp .done

.parse
; First, let's clear the current text display,
; starting from line 5.
	xor a
	ld [hBGMapMode], a
	hlcoord 0, 5
	ld bc, 20 * 12
	ld a, " "
	call ByteFill

; Then read the script.

.loop
	call .get

; Commands:
	cp CREDITS_END
	jp z, .end
	cp CREDITS_WAIT
	jp z, .wait
	cp CREDITS_SCENE
	jr z, .scene
	cp CREDITS_CLEAR
	jr z, .clear
	cp CREDITS_MUSIC
	jr z, .music
	cp CREDITS_WAIT2
	jr z, .wait2
	cp CREDITS_THEEND
	jr z, .theend

; If it's not a command, it's a string identifier.

	push af
	ld e, a
	ld d, 0
	ld hl, CreditsStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop af

; Strings spanning multiple lines have special cases.

	cp COPYRIGHT
	jr z, .copyright

	cp STAFF
	jr c, .staff

; The rest start from line 6.

	hlcoord 0, 6
	jr .print

.copyright
	hlcoord 2, 6
	jr .print

.staff
	hlcoord 0, 6

.print
; Print strings spaced every two lines.
	call .get
	ld bc, 20 * 2
	call AddNTimes
	call PlaceString
	jr .loop

.theend
; Display "The End" graphic.
	call Credits_TheEnd
	jr .loop

.scene
; Update the scene number and corresponding palette.

	ld a, [wCreditsSpawn]
	cp SPAWN_LEAF
	jr z, .leaf_scene
	call .get
	ld [wCreditsBorderMon], a ; scene
	jr .got_scene
.leaf_scene
	call .get
	add 4
	ld [wCreditsBorderMon], a ; scene
.got_scene
	xor a
	ld [wCreditsBorderFrame], a ; frame
	call GetCreditsPalette
	call SetPalettes ; update hw pal registers
	jr .loop

.clear
; Clear the banner.
	ld a, $ff
	ld [wCreditsBorderFrame], a ; frame
	jp .loop

.music
; Play the credits music.
	ld de, MUSIC_CREDITS
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	pop de
	call PlayMusic
	jp .loop

.wait2
; Wait for some amount of ticks.
	call .get
	ld [CreditsTimer], a
	jr .done

.wait
; Wait for some amount of ticks, and do something else.
	call .get
	ld [CreditsTimer], a

	xor a
	ld [hBGMapThird], a
	ld a, 1
	ld [hBGMapMode], a

.done
	jp Credits_Next

.end
; Stop execution.
	ld hl, wJumptableIndex
	set 7, [hl]
	ld a, 32
	ld [MusicFade], a
	ld a, MUSIC_POST_CREDITS % $100
	ld [MusicFadeID], a
	ld a, MUSIC_POST_CREDITS / $100
	ld [MusicFadeIDHi], a
	ret

.get
; Get byte CreditsPos from CreditsScript
	push hl
	push de
	ld a, [CreditsPos]
	ld e, a
	ld a, [CreditsPos+1]
	ld d, a
	ld hl, CreditsScript
	add hl, de

	inc de
	ld a, e
	ld [CreditsPos], a
	ld a, d
	ld [CreditsPos+1], a
	ld a, [hl]
	pop de
	pop hl
	ret
; 109a95


ConstructCreditsTilemap: ; 109a95 (42:5a95)
	xor a
	ld [hBGMapMode], a
	ld a, $c
	ld [hBGMapAddress], a

	ld a, $28
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	call ByteFill

	ld a, $7f
	hlcoord 0, 4
	ld bc, (SCREEN_HEIGHT - 4) * SCREEN_WIDTH
	call ByteFill

	hlcoord 0, 4
	ld a, $24
	call DrawCreditsBorder

	hlcoord 0, 17
	ld a, $20
	call DrawCreditsBorder

	hlcoord 0, 0, AttrMap
	ld bc, 4 * SCREEN_WIDTH
	xor a
	call ByteFill

	hlcoord 0, 4, AttrMap
	ld bc, SCREEN_WIDTH
	ld a, $1
	call ByteFill

	hlcoord 0, 5, AttrMap
	ld bc, 12 * SCREEN_WIDTH
	ld a, $2
	call ByteFill

	hlcoord 0, 17, AttrMap
	ld bc, SCREEN_WIDTH
	ld a, $1
	call ByteFill

	call WaitBGMap2
	xor a
	ld [hBGMapMode], a
	ld [hBGMapAddress], a
	hlcoord 0, 0
	call .InitTopPortion
	jp WaitBGMap2

.InitTopPortion: ; 109aff (42:5aff)
	ld b, 5
.outer_loop
	push hl
	ld de, SCREEN_WIDTH - 3
	ld c, 4
	xor a
.inner_loop
rept 3
	ld [hli], a
	inc a
endr
	ld [hl], a
	inc a
	add hl, de
	dec c
	jr nz, .inner_loop
	pop hl
rept 4
	inc hl
endr
	dec b
	jr nz, .outer_loop
	ret

DrawCreditsBorder: ; 109b1d (42:5b1d)
	ld c, SCREEN_WIDTH / 4
.loop
	push af
rept 3
	ld [hli], a
	inc a
endr
	ld [hli], a
	pop af
	dec c
	jr nz, .loop
	ret

GetCreditsPalette: ; 109b2c
	call .GetPalAddress

	push hl
	xor a
	call .UpdatePals
	pop hl
	ret

.GetPalAddress:
; Each set of palette data is 24 bytes long.
	ld a, [wCreditsBorderMon] ; scene
	and 7
	add a
	add a
	add a
	ld e, a
	ld d, 0
	ld hl, CreditsPalettes
	add hl, de
	add hl, de
	add hl, de
	ret

.UpdatePals:
; Update the first three colors in both palette buffers.

	push af
	push hl
	add UnknBGPals % $100
	ld e, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc UnknBGPals / $100
	ld d, a
	ld bc, 24
	call CopyBytes

	pop hl
	pop af
	add BGPals % $100
	ld e, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc BGPals / $100
	ld d, a
	ld bc, 24
	jp CopyBytes


CreditsPalettes:

if !DEF(MONOCHROME)
; Pichu
	RGB 31, 00, 31
	RGB 31, 25, 00
	RGB 11, 14, 31
	RGB 07, 07, 07

	RGB 31, 05, 05
	RGB 11, 14, 31
	RGB 11, 14, 31
	RGB 31, 31, 31

	RGB 31, 05, 05
	RGB 00, 00, 00
	RGB 31, 31, 31
	RGB 31, 31, 31

; Sentret
	RGB 31, 31, 31
	RGB 22, 15, 10
	RGB 31, 19, 09
	RGB 07, 07, 07

	RGB 31, 31, 31
	RGB 31, 19, 09
	RGB 31, 19, 09
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 00, 00, 00

; Ditto
	RGB 31, 31, 31
	RGB 23, 12, 28
	RGB 31, 22, 00
	RGB 07, 07, 07

	RGB 03, 20, 00
	RGB 31, 22, 00
	RGB 31, 22, 00
	RGB 31, 31, 31

	RGB 03, 20, 00
	RGB 00, 00, 00
	RGB 31, 31, 31
	RGB 31, 31, 31

; Togepi
	RGB 31, 31, 31
	RGB 30, 26, 11
	RGB 31, 11, 27
	RGB 07, 07, 07

	RGB 04, 19, 31
	RGB 31, 11, 27
	RGB 31, 11, 27
	RGB 31, 31, 31

	RGB 04, 19, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

; Smoochum
	RGB 31, 31, 31
	RGB 31, 27, 00
	RGB 26, 06, 31
	RGB 07, 07, 07

	RGB 03, 13, 31
	RGB 20, 00, 24
	RGB 26, 06, 31
	RGB 31, 31, 31

	RGB 03, 13, 31
	RGB 00, 00, 00
	RGB 31, 31, 31
	RGB 31, 31, 31

; Munchlax
	RGB 31, 31, 31
	RGB 08, 17, 17
	RGB 30, 28, 16
	RGB 07, 07, 07

	RGB 16, 15, 08
	RGB 30, 28, 16
	RGB 30, 28, 16
	RGB 31, 31, 31

	RGB 16, 15, 08
	RGB 00, 00, 00
	RGB 31, 31, 31
	RGB 31, 31, 31

; Elekid
	RGB 31, 31, 31
	RGB 31, 31, 05
	RGB 17, 23, 31
	RGB 07, 07, 07

	RGB 29, 05, 05
	RGB 17, 23, 31
	RGB 17, 23, 31
	RGB 00, 00, 00

	RGB 29, 05, 05
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

; Bellossom
	RGB 30, 30, 10
	RGB 29, 08, 27
	RGB 15, 24, 12
	RGB 07, 07, 07

	RGB 27, 27, 12
	RGB 15, 24, 12
	RGB 15, 24, 12
	RGB 00, 00, 00

	RGB 27, 27, 12
	RGB 09, 15, 07
	RGB 09, 15, 07
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR

	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR

	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR

	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR

	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR

	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR

	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR

	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc
; 109bca

Credits_LoadBorderGFX: ; 109bca (42:5bca)
	ld hl, wCreditsBorderFrame
	ld a, [hl]
	cp $ff
	jr z, .init

	and 7
	ld e, a
	inc a
	and 7
	ld [hl], a
	ld a, [wCreditsBorderMon]
	and 7
	add a
	add a
	add a
	add e
	add a
	ld e, a
	ld d, 0
	ld hl, .Frames
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.init
	ld hl, wCreditsFaux2bpp
	ret
; 109bf1 (42:5bf1)

.Frames: ; 109bf1
	dw CreditsPichuGFX
	dw CreditsPichuGFX     + 16 tiles
	dw CreditsPichuGFX     + 32 tiles
	dw CreditsPichuGFX     + 48 tiles
	dw CreditsPichuGFX
	dw CreditsPichuGFX     + 16 tiles
	dw CreditsPichuGFX     + 32 tiles
	dw CreditsPichuGFX     + 48 tiles
	dw CreditsSentretGFX
	dw CreditsSentretGFX
	dw CreditsSentretGFX   + 16 tiles
	dw CreditsSentretGFX   + 16 tiles
	dw CreditsSentretGFX   + 32 tiles
	dw CreditsSentretGFX   + 32 tiles
	dw CreditsSentretGFX   + 48 tiles
	dw CreditsSentretGFX   + 48 tiles
	dw CreditsDittoGFX
	dw CreditsDittoGFX     + 16 tiles
	dw CreditsDittoGFX     + 32 tiles
	dw CreditsDittoGFX     + 48 tiles
	dw CreditsDittoGFX
	dw CreditsDittoGFX     + 16 tiles
	dw CreditsDittoGFX     + 32 tiles
	dw CreditsDittoGFX     + 48 tiles
	dw CreditsTogepiGFX
	dw CreditsTogepiGFX
	dw CreditsTogepiGFX    + 16 tiles
	dw CreditsTogepiGFX    + 16 tiles
	dw CreditsTogepiGFX    + 32 tiles
	dw CreditsTogepiGFX    + 32 tiles
	dw CreditsTogepiGFX    + 48 tiles
	dw CreditsTogepiGFX    + 48 tiles
	dw CreditsSmoochumGFX
	dw CreditsSmoochumGFX  + 16 tiles
	dw CreditsSmoochumGFX  + 32 tiles
	dw CreditsSmoochumGFX  + 48 tiles
	dw CreditsSmoochumGFX
	dw CreditsSmoochumGFX  + 16 tiles
	dw CreditsSmoochumGFX  + 32 tiles
	dw CreditsSmoochumGFX  + 48 tiles
	dw CreditsMunchlaxGFX
	dw CreditsMunchlaxGFX
	dw CreditsMunchlaxGFX  + 16 tiles
	dw CreditsMunchlaxGFX  + 16 tiles
	dw CreditsMunchlaxGFX  + 32 tiles
	dw CreditsMunchlaxGFX  + 32 tiles
	dw CreditsMunchlaxGFX  + 48 tiles
	dw CreditsMunchlaxGFX  + 48 tiles
	dw CreditsElekidGFX
	dw CreditsElekidGFX
	dw CreditsElekidGFX    + 16 tiles
	dw CreditsElekidGFX    + 16 tiles
	dw CreditsElekidGFX    + 32 tiles
	dw CreditsElekidGFX    + 32 tiles
	dw CreditsElekidGFX    + 48 tiles
	dw CreditsElekidGFX    + 48 tiles
	dw CreditsBellossomGFX
	dw CreditsBellossomGFX
	dw CreditsBellossomGFX + 16 tiles
	dw CreditsBellossomGFX + 16 tiles
	dw CreditsBellossomGFX + 32 tiles
	dw CreditsBellossomGFX + 32 tiles
	dw CreditsBellossomGFX + 48 tiles
	dw CreditsBellossomGFX + 48 tiles
; 109c11

Credits_TheEnd: ; 109c11 (42:5c11)
	ld a, $40
	hlcoord 6, 9
	call .Load
	hlcoord 6, 10
.Load: ; 109c1c (42:5c1c)
	ld c, 8
.loop
	ld [hli], a
	inc a
	dec c
	jr nz, .loop
	ret
; 109c24 (42:5c24)


CreditsBorderGFX:    INCBIN "gfx/credits/border.2bpp"

CreditsMonsGFX:
CreditsPichuGFX:     INCBIN "gfx/credits/pichu.2bpp"
CreditsSentretGFX:   INCBIN "gfx/credits/sentret.2bpp"
CreditsDittoGFX:     INCBIN "gfx/credits/ditto.2bpp"
CreditsTogepiGFX:    INCBIN "gfx/credits/togepi.2bpp"
CreditsSmoochumGFX:  INCBIN "gfx/credits/smoochum.2bpp"
CreditsMunchlaxGFX:  INCBIN "gfx/credits/munchlax.2bpp"
CreditsElekidGFX:    INCBIN "gfx/credits/elekid.2bpp"
CreditsBellossomGFX: INCBIN "gfx/credits/bellossom.2bpp"

TheEndGFX::          INCBIN "gfx/credits/theend.2bpp"


CreditsScript: ; 10acb4

; Clear the banner.
	db CREDITS_CLEAR

; Pokemon Crystal Version Staff
	db                STAFF, 1

	db CREDITS_WAIT, 8

; Play the credits music.
	db CREDITS_MUSIC

	db CREDITS_WAIT2, 10

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 0 ; Pichu or Smoochum

	db             DIRECTOR, 1
	db       SATOSHI_TAJIRI, 2

	db CREDITS_WAIT, 12

	db           CODIRECTOR, 1
	db       JUNICHI_MASUDA, 2

	db CREDITS_WAIT, 12

	db          PROGRAMMERS, 0
	db       SOUSUKE_TAMADA, 1
	db       HISASHI_SOGABE, 2
	db         KEITA_KAGAYA, 3
	db    YOSHINORI_MATSUDA, 4

	db CREDITS_WAIT, 12

	db          PROGRAMMERS, 0
	db     SHIGEKI_MORIMOTO, 1
	db     TETSUYA_WATANABE, 2
	db        TAKENORI_OOTA, 3

	db CREDITS_WAIT, 12

	db    GRAPHICS_DIRECTOR, 1
	db         KEN_SUGIMORI, 2

	db CREDITS_WAIT, 12

	db       MONSTER_DESIGN, 0
	db         KEN_SUGIMORI, 1
	db    MOTOFUMI_FUJIWARA, 2
	db     SHIGEKI_MORIMOTO, 3
	db     HIRONOBU_YOSHIDA, 4
	db         SATOSHI_OOTA, 5

	db CREDITS_WAIT, 12

	db       MONSTER_DESIGN, 0
	db       ATSUKO_NISHIDA, 1
	db          MUNEO_SAITO, 2
	db       RENA_YOSHIKAWA, 3

	db CREDITS_WAIT, 12

	db    POKEMON_ANIMATION, 1
	db     HIRONOBU_YOSHIDA, 2
	db          JUN_OKUTANI, 3

	db CREDITS_WAIT, 12

; Clear the banner.
	db CREDITS_CLEAR

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 1 ; Sentret or Munchlax

	db      GRAPHICS_DESIGN, 0
	db     HIRONOBU_YOSHIDA, 1
	db          JUN_OKUTANI, 2
	db       ASUKA_IWASHITA, 3
	db     TETSUYA_WATANABE, 4

	db CREDITS_WAIT, 12

	db         CREDIT_MUSIC, 0
	db       JUNICHI_MASUDA, 1
	db        MORIKAZU_AOKI, 2
	db          GO_ICHINOSE, 3

	db CREDITS_WAIT, 12

	db CREDIT_SOUND_EFFECTS, 0
	db        MORIKAZU_AOKI, 1
	db       JUNICHI_MASUDA, 2
	db     TETSUYA_WATANABE, 3

	db CREDITS_WAIT, 12

	db          GAME_DESIGN, 0
	db       JUNICHI_MASUDA, 1
	db     SHIGEKI_MORIMOTO, 2
	db        KOHJI_NISHINO, 3

	db CREDITS_WAIT, 12

	db          GAME_DESIGN, 0
	db         TETSUJI_OOTA, 1
	db          HITOMI_SATO, 2
	db     KENJI_MATSUSHIMA, 3

	db CREDITS_WAIT, 12

	db        GAME_SCENARIO, 0
	db       JUNICHI_MASUDA, 1
	db        KOHJI_NISHINO, 2
	db  TOSHINOBU_MATSUMIYA, 3
	db     KENJI_MATSUSHIMA, 4

	db CREDITS_WAIT, 12

	db         POKEDEX_TEXT, 1
	db  TOSHINOBU_MATSUMIYA, 2

	db CREDITS_WAIT, 12

	db     TOOL_PROGRAMMING, 1
	db       SOUSUKE_TAMADA, 2
	db        TAKENORI_OOTA, 3

	db CREDITS_WAIT, 12

	db    PARAMETRIC_DESIGN, 1
	db        KOHJI_NISHINO, 2

	db CREDITS_WAIT, 12

; Clear the banner.
	db CREDITS_CLEAR

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 2 ; Ditto or Elekid

	db        SCRIPT_DESIGN, 1
	db         TETSUJI_OOTA, 2
	db        NOBUHIRO_SEYA, 3

	db CREDITS_WAIT, 12

	db      MAP_DATA_DESIGN, 1
	db         TETSUJI_OOTA, 2
	db      KAZUHITO_SEKINE, 3

	db CREDITS_WAIT, 12

	db           MAP_DESIGN, 0
	db         TETSUJI_OOTA, 1
	db        KOHJI_NISHINO, 2
	db        NOBUHIRO_SEYA, 3

	db CREDITS_WAIT, 12

	db         COORDINATION, 1
	db      HIROYUKI_ZINNAI, 2

	db CREDITS_WAIT, 12

	db            PRODUCERS, 0
	db         SATORU_IWATA, 1
	db       SATOSHI_YAMATO, 2
	db     SHIGERU_MIYAMOTO, 3

	db CREDITS_WAIT, 12

	db            PRODUCERS, 1
	db   TSUNEKAZU_ISHIHARA, 2

	db CREDITS_WAIT, 12

; Clear the banner.
	db CREDITS_CLEAR

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 3 ; Togepi or Bellossom

	db     US_VERSION_STAFF, 2

	db CREDITS_WAIT, 9

	db      US_COORDINATION, 1
	db          GAIL_TILDEN, 2
	db        HIRO_NAKAMURA, 3

	db CREDITS_WAIT, 12

	db      US_COORDINATION, 1
	db       JUNICHI_MASUDA, 2
	db        SETH_MCMAHILL, 3

	db CREDITS_WAIT, 12

	db      US_COORDINATION, 1
	db     HIROTO_ALEXANDER, 2
	db     TERESA_LILLYGREN, 3

	db CREDITS_WAIT, 12

	db     TEXT_TRANSLATION, 1
	db        NOB_OGASAWARA, 2

	db CREDITS_WAIT, 12

	db          PROGRAMMERS, 1
	db      TERUKI_MURAKAWA, 2
	db      KAZUYOSHI_OSAWA, 3

	db CREDITS_WAIT, 12

	db         PAAD_TESTING, 1
	db       THOMAS_HERTZOG, 2
	db         ERIK_JOHNSON, 3

	db CREDITS_WAIT, 12

	db      PRODUCT_TESTING, 0
	db             PLANNING, 1

	db CREDITS_WAIT, 12

	db      PRODUCT_TESTING, 0
	db       KEITA_NAKAMURA, 1
	db      HIROTAKA_UEMURA, 2
	db       HIROAKI_TAMURA, 3
	db    NORIAKI_SAKAGUCHI, 4

	db CREDITS_WAIT, 12

	db      PRODUCT_TESTING, 0
	db NCL_SUPER_MARIO_CLUB, 1
	db          KENJI_SAIKI, 2
	db         ATSUSHI_TADA, 3
	db          MIYUKI_SATO, 4

	db CREDITS_WAIT, 12

	db       SPECIAL_THANKS, 0
	db     KIMIKO_NAKAMICHI, 1
	db           AKITO_MORI, 2

	db CREDITS_WAIT, 12

	db       SPECIAL_THANKS, 0
	db        GAKUZI_NOMOTO, 1
	db           AI_MASHIMA, 2
	db      KUNIMI_KAWAMURA, 3

	db CREDITS_WAIT, 12

	db       SPECIAL_THANKS, 0
	db    MIKIHIRO_ISHIKAWA, 1
	db   HIDEYUKI_HASHIMOTO, 2

	db CREDITS_WAIT, 12

	db   EXECUTIVE_PRODUCER, 1
	db     HIROSHI_YAMAUCHI, 2

	db CREDITS_WAIT, 12

	db            COPYRIGHT, 1

	db CREDITS_WAIT, 9

; Display "The End" graphic.
	db CREDITS_THEEND

	db CREDITS_WAIT, 20

	db CREDITS_END
; 10ae13


CreditsStrings:
	dw .SatoshiTajiri
	dw .JunichiMasuda
	dw .TetsuyaWatanabe
	dw .ShigekiMorimoto
	dw .SousukeTamada
	dw .TakenoriOota
	dw .KenSugimori
	dw .MotofumiFujiwara
	dw .AtsukoNishida
	dw .MuneoSaito
	dw .SatoshiOota
	dw .RenaYoshikawa
	dw .JunOkutani
	dw .HironobuYoshida
	dw .AsukaIwashita
	dw .GoIchinose
	dw .MorikazuAoki
	dw .KohjiNishino
	dw .KenjiMatsushima
	dw .ToshinobuMatsumiya
	dw .SatoruIwata
	dw .NobuhiroSeya
	dw .KazuhitoSekine
	dw .TetsujiOota
	dw .NclSuperMarioClub
	dw .Sarugakucho
	dw .AkitoMori
	dw .TakahiroHarada
	dw .TohruHashimoto
	dw .NoboruMatsumoto
	dw .TakehiroIzushi
	dw .TakashiKawaguchi
	dw .TsunekazuIshihara
	dw .HiroshiYamauchi
	dw .KenjiSaiki
	dw .AtsushiTada
	dw .NaokoKawakami
	dw .HiroyukiZinnai
	dw .KunimiKawamura
	dw .HisashiSogabe
	dw .KeitaKagaya
	dw .YoshinoriMatsuda
	dw .HitomiSato
	dw .ToruOsawa
	dw .TakaoOhara
	dw .YuichiroIto
	dw .TakaoShimizu
	dw .Planning
	dw .KeitaNakamura
	dw .HirotakaUemura
	dw .HiroakiTamura
	dw .NoriakiSakaguchi
	dw .MiyukiSato
	dw .GakuziNomoto
	dw .AiMashima
	dw .MikihiroIshikawa
	dw .HideyukiHashimoto
	dw .SatoshiYamato
	dw .ShigeruMiyamoto
	dw .GailTilden
	dw .NobOgasawara
	dw .SethMcMahill
	dw .HirotoAlexander
	dw .TeresaLillygren
	dw .ThomasHertzog
	dw .ErikJohnson
	dw .HiroNakamura
	dw .TerukiMurakawa
	dw .KazuyoshiOsawa
	dw .KimikoNakamichi
	dw .End
	dw .Unknown
	dw .Staff
	dw .Director
	dw .CoDirector
	dw .Programmers
	dw .GraphicsDirector
	dw .MonsterDesign
	dw .GraphicsDesign
	dw .Music
	dw .SoundEffects
	dw .GameDesign
	dw .GameScenario
	dw .ToolProgramming
	dw .ParametricDesign
	dw .ScriptDesign
	dw .MapDataDesign
	dw .MapDesign
	dw .ProductTesting
	dw .SpecialThanks
	dw .Producers
	dw .ExecutiveProducer
	dw .PokemonAnimation
	dw .PokedexText
	dw .MobilePrjLeader
	dw .MobileSystemAd
	dw .MobileStadiumDir
	dw .Coordination
	dw .Copyright
	dw .UsVersionStaff
	dw .UsCoordination
	dw .TextTranslation
	dw .PaadTesting

.SatoshiTajiri:       db "   Satoshi Tajiri@"
.JunichiMasuda:       db "   Junichi Masuda@"
.TetsuyaWatanabe:     db "  Tetsuya Watanabe@"
.ShigekiMorimoto:     db "  Shigeki Morimoto@"
.SousukeTamada:       db "   Sousuke Tamada@"
.TakenoriOota:        db "   Takenori Oota@"
.KenSugimori:         db "    Ken Sugimori@"
.MotofumiFujiwara:    db " Motofumi Fujiwara@"
.AtsukoNishida:       db "   Atsuko Nishida@"
.MuneoSaito:          db "    Muneo Saito@"
.SatoshiOota:         db "    Satoshi Oota@"
.RenaYoshikawa:       db "   Rena Yoshikawa@"
.JunOkutani:          db "    Jun Okutani@"
.HironobuYoshida:     db "  Hironobu Yoshida@"
.AsukaIwashita:       db "   Asuka Iwashita@"
.GoIchinose:          db "    Go Ichinose@"
.MorikazuAoki:        db "   Morikazu Aoki@"
.KohjiNishino:        db "   Kohji Nishino@"
.KenjiMatsushima:     db "  Kenji Matsushima@"
.ToshinobuMatsumiya:  db "Toshinobu Matsumiya@"
.SatoruIwata:         db "    Satoru Iwata@"
.NobuhiroSeya:        db "   Nobuhiro Seya@"
.KazuhitoSekine:      db "  Kazuhito Sekine@"
.TetsujiOota:         db "    Tetsuji Oota@"
.NclSuperMarioClub:   db "NCL Super Mario Club@"
.Sarugakucho:         db "    Sarugakucho@"
.AkitoMori:           db "     Akito Mori@"
.TakahiroHarada:      db "  Takahiro Harada@"
.TohruHashimoto:      db "  Tohru Hashimoto@"
.NoboruMatsumoto:     db "  Noboru Matsumoto@"
.TakehiroIzushi:      db "  Takehiro Izushi@"
.TakashiKawaguchi:    db " Takashi Kawaguchi@"
.TsunekazuIshihara:   db " Tsunekazu Ishihara@"
.HiroshiYamauchi:     db "  Hiroshi Yamauchi@"
.KenjiSaiki:          db "    Kenji Saiki@"
.AtsushiTada:         db "    Atsushi Tada@"
.NaokoKawakami:       db "   Naoko Kawakami@"
.HiroyukiZinnai:      db "  Hiroyuki Zinnai@"
.KunimiKawamura:      db "  Kunimi Kawamura@"
.HisashiSogabe:       db "   Hisashi Sogabe@"
.KeitaKagaya:         db "    Keita Kagaya@"
.YoshinoriMatsuda:    db " Yoshinori Matsuda@"
.HitomiSato:          db "    Hitomi Sato@"
.ToruOsawa:           db "     Toru Osawa@"
.TakaoOhara:          db "    Takao Ohara@"
.YuichiroIto:         db "    Yuichiro Ito@"
.TakaoShimizu:        db "   Takao Shimizu@"
.Planning:            db " Special Production"
                    next "      Planning"
                    next " & Development Dept.@"
.KeitaNakamura:       db "   Keita Nakamura@"
.HirotakaUemura:      db "  Hirotaka Uemura@"
.HiroakiTamura:       db "   Hiroaki Tamura@"
.NoriakiSakaguchi:    db " Noriaki Sakaguchi@"
.MiyukiSato:          db "    Miyuki Sato@"
.GakuziNomoto:        db "   Gakuzi Nomoto@"
.AiMashima:           db "     Ai Mashima@"
.MikihiroIshikawa:    db " Mikihiro Ishikawa@"
.HideyukiHashimoto:   db " Hideyuki Hashimoto@"
.SatoshiYamato:       db "   Satoshi Yamato@"
.ShigeruMiyamoto:     db "  Shigeru Miyamoto@"
.End:                 db "        End@"
.Unknown:             db "      ????????@"
.GailTilden:          db "    Gail Tilden@"
.NobOgasawara:        db "   Nob Ogasawara@"
.SethMcMahill:        db "   Seth McMahill@"
.HirotoAlexander:     db "  Hiroto Alexander@"
.TeresaLillygren:     db "  Teresa Lillygren@"
.ThomasHertzog:       db "   Thomas Hertzog@"
.ErikJohnson:         db "    Erik Johnson@"
.HiroNakamura:        db "   Hiro Nakamura@"
.TerukiMurakawa:      db "  Teruki Murakawa@"
.KazuyoshiOsawa:      db "  Kazuyoshi Osawa@"
.KimikoNakamichi:     db "  Kimiko Nakamichi@"
.Staff:               db "      #mon"
                    next "  Crystal Version"
                    next "       Staff@"
.Director:            db "      Director@"
.CoDirector:          db "    Co-Director@"
.Programmers:         db "    Programmers@"
.GraphicsDirector:    db " Graphics Director@"
.MonsterDesign:       db "   Monster Design@"
.GraphicsDesign:      db "  Graphics Design@"
.Music:               db "       Music@"
.SoundEffects:        db "   Sound Effects@"
.GameDesign:          db "    Game Design@"
.GameScenario:        db "   Game Scenario@"
.ToolProgramming:     db "  Tool Programming@"
.ParametricDesign:    db " Parametric Design@"
.ScriptDesign:        db "   Script Design@"
.MapDataDesign:       db "  Map Data Design@"
.MapDesign:           db "     Map Design@"
.ProductTesting:      db "  Product Testing@"
.SpecialThanks:       db "   Special Thanks@"
.Producers:           db "     Producers@"
.ExecutiveProducer:   db " Executive Producer@"
.PokemonAnimation:    db " #mon Animation@"
.PokedexText:         db "    #dex Text@"
.MobilePrjLeader:     db " Mobile Prj. Leader@"
.MobileSystemAd:      db " Mobile System Ad.@"
.MobileStadiumDir:    db "Mobile Stadium Dir.@"
.Coordination:        db "    Coordination@"
.UsVersionStaff:      db "  US Version Staff@"
.UsCoordination:      db "  US Coordination@"
.TextTranslation:     db "  Text Translation@"
.PaadTesting:         db "    PAAD Testing@"

.Copyright:
	;    (C) 1  9  9  5 - 2  0  0  1     N  i  n  t  e  n  d  o
	db   $60,$61,$62,$63,$64,$65,$66, $67, $68, $69, $6a, $6b, $6c
	;    (C) 1  9  9  5 - 2  0  0  1    C  r  e  a  t  u  r  e  s      i  n  c .
	next $60,$61,$62,$63,$64,$65,$66, $6d, $6e, $6f, $70, $71, $72,  $7a, $7b, $7c
	;    (C) 1  9  9  5 - 2  0  0  1  G   A   M   E   F   R   E   A   K     i  n  c .
	next $60,$61,$62,$63,$64,$65,$66, $73, $74, $75, $76, $77, $78, $79,  $7a, $7b, $7c
	db "@"
