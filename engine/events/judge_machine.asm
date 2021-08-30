JUDGE_UP_DOWN_TILE    EQU $00
JUDGE_UNDERLINE_TILE  EQU $01
JUDGE_LINE_END_TILE   EQU $02
JUDGE_MALE_TILE       EQU $07
JUDGE_FEMALE_TILE     EQU $08
JUDGE_STAR_TILE       EQU $09
JUDGE_LEFT_RIGHT_TILE EQU $0a
JUDGE_BORDER_TILE     EQU $13
JUDGE_BLANK_TILE      EQU $64
JUDGE_WHITE_TILE      EQU $6d

JudgeMachine:
; Check that the machine is activated
	ld hl, wStatusFlags3
	bit 0, [hl] ; ENGINE_JUDGE_MACHINE
	ld hl, NewsMachineOffText
	jr z, .done
; Introduce machine
	ld hl, NewsMachineIntroText
.continue
	call PrintText
	call YesNoBox
	jr c, .cancel
; Choose a party Pokémon
	ld hl, NewsMachineWhichMonText
	call PrintText
	farcall SelectMonFromParty
	jr c, .cancel
; Can't judge an Egg
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	ld hl, NewsMachineEggText
	jr nz, .done
; Show the EV and IV charts
	ld hl, NewsMachinePrepText
	call PrintText
	call FadeToMenu
	call JudgeSystem
	call ExitAllMenus
; hLCDInterruptFunction gets overridden for drawing the radar chart.
; (It is not called as such because the LCD interrupt is disabled.)
; This restores it to the LCDGeneric function.
	ld a, LOW(LCDGeneric)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDGeneric)
	ldh [hFunctionTargetHi], a
	ld hl, NewsMachineContinueText
	jr .continue

.cancel
	ld hl, NewsMachineCancelText
.done
	jmp PrintText

NewsMachineOffText:
	text "It's the #mon"
	line "Judge Machine!"

	para "It's not in"
	line "operation yet…"
	done

NewsMachineIntroText:
	text "It's the #mon"
	line "Judge Machine!"

	para "Would you like to"
	line "judge a #mon's"
	cont "overall power?"
	done

NewsMachineWhichMonText:
	text "Please select"
	line "a #mon."
	prompt

NewsMachinePrepText:
	text "Visualizing your"
	line "#mon's power…"
	prompt

NewsMachineContinueText:
	text "Would you like"
	line "to judge another"
	cont "#mon?"
	done

NewsMachineCancelText:
	text "Goodbye!"
	done

NewsMachineEggText:
	text "An Egg doesn't"
	line "have any power"
	cont "yet to judge!"
	done

JudgeSystem::
; Start with the EV chart
	xor a
	ldh [hChartScreen], a

.restart
; Clear the screen
	call ClearBGPalettes
	call ClearTileMap
	call DisableLCD
	xor a
	ldh [hBGMapMode], a

; Load the party struct into wTempMon
	ld a, [wCurPartyMon]
	inc a
	ld c, a
	ld b, 1
	farcall CopyBetweenPartyAndTemp

; Load the frontpic graphics
	ld hl, wTempMonForm
	predef GetVariant
	call GetBaseData
	ld de, vTiles2
	predef GetFrontpic

; Load the blank chart graphics
	ld a, $1
	ldh [rVBK], a
	ld hl, JudgeSystemGFX
	ld de, vTiles5
	lb bc, BANK(JudgeSystemGFX), 10 * 12
	call DecompressRequest2bpp
	xor a
	ldh [rVBK], a

; Load the max stat sparkle and hyper trained bottle cap graphics
	ld hl, MaxStatSparkleGFX
	ld de, vTiles0
	ld bc, 2 tiles
	rst CopyBytes

; Place the up/down arrows and nickname
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call SkipNames
	ld d, h
	ld e, l
	hlcoord 0, 0
	ld a, JUDGE_UP_DOWN_TILE
	ld [hli], a
	rst PlaceString

; Place the level
	hlcoord 14, 0
	call PrintLevel

; Place the gender icon
	farcall GetGender
	ld a, JUDGE_WHITE_TILE
	jr c, .got_gender
	ld a, JUDGE_MALE_TILE
	jr nz, .got_gender
	ld a, JUDGE_FEMALE_TILE
.got_gender
	hlcoord 18, 0
	ld [hli], a

; Place the shiny icon
	ld bc, wTempMonShiny
	farcall CheckShininess
	; a = carry ? JUDGE_STAR_TILE : JUDGE_WHITE_TILE
	sbc a
	and JUDGE_STAR_TILE - JUDGE_WHITE_TILE
	add JUDGE_WHITE_TILE
	ld [hli], a

; Place the top border
	ld bc, SCREEN_WIDTH
	ld a, JUDGE_BORDER_TILE
	rst ByteFill

; Place the heading underline
	hlcoord 0, 2
	ld [hl], JUDGE_LEFT_RIGHT_TILE
	hlcoord 0, 3
	ld bc, 10
	ld a, JUDGE_UNDERLINE_TILE
	rst ByteFill
	ld [hl], JUDGE_LINE_END_TILE

; Place the frontpic graphics
	hlcoord 0, 6
	farcall PlaceFrontpicAtHL

; Place the Pokédex number
	ld a, [wCurPartySpecies]
	ld [wTextDecimalByte], a
	hlcoord 1, 13
	ld a, "№"
	ld [hli], a
	ld a, "."
	ld [hli], a
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	ld de, wTextDecimalByte
	call PrintNum

; Place the chart
	hlcoord 8, 4
	ld de, SCREEN_WIDTH
	xor a
	ld b, 12
.chart_row
	ld c, 10
	push hl
.chart_col
	ld [hli], a
	inc a
	dec c
	jr nz, .chart_col
	pop hl
	add hl, de
	dec b
	jr nz, .chart_row

; Clear some non-chart tiles
	ld a, JUDGE_BLANK_TILE
	hlcoord 9, 4
	ld [hli], a
	ld [hl], a
	hlcoord 15, 4
	ld [hli], a
	ld [hl], a
	hlcoord 9, 15
	ld [hli], a
	ld [hl], a
	hlcoord 15, 15
	ld [hli], a
	ld [hl], a

; Place the stat names and values
	hlcoord 12, 2
	ld de, .HP
	ld bc, wTempMonMaxHP
	call .PrintTopStat
	hlcoord 17, 4
	ld de, .Atk
	ld bc, wTempMonAttack
	call .PrintTopStat
	hlcoord 17, 15
	ld de, .Def
	ld bc, wTempMonDefense
	call .PrintBottomStat
	hlcoord 12, 17
	ld de, .Spd
	ld bc, wTempMonSpeed
	call .PrintBottomStat
	hlcoord 6, 15
	ld de, .SDf
	ld bc, wTempMonSpclDef
	call .PrintBottomStat
	hlcoord 6, 4
	ld de, .SAt
	ld bc, wTempMonSpclAtk
	call .PrintTopStat

; Show the screen
	call EnableLCD
	ld a, CGB_JUDGE_SYSTEM
	call GetCGBLayout

.render
	call ClearSpriteAnims

; Display the current chart, EVs or IVs
	ldh a, [hChartScreen]
	and a
	jr z, .evs
	ld hl, IVChartPals
	ld de, .IVHeading
	ld bc, RenderIVChart
	jr .got_config
.evs
	ld hl, EVChartPals
	ld de, .EVHeading
	ld bc, RenderEVChart
.got_config
	call .PrepareChart

; Load the rendered chart graphics
	ld a, $1
	ldh [rVBK], a
	ld hl, vTiles5
	ld de, wDecompressScratch
	lb bc, BANK(wDecompressScratch), 10 * 12
	call Request2bppInWRA6
	xor a
	ldh [rVBK], a

; Wait for input
.input_loop
	farcall PlaySpriteAnimations
	call DelayFrame
	call JoyTextDelay
	ldh a, [hJoyLast]
	; B button quits
	bit B_BUTTON_F, a
	ret nz
	; Up or down switches between party members
	bit D_UP_F, a
	jr nz, .prev_mon
	bit D_DOWN_F, a
	jr nz, .next_mon
	; Left or right toggles between EVs and IVs
	and D_LEFT | D_RIGHT
	jr z, .input_loop
	ldh a, [hChartScreen]
	cpl
	ldh [hChartScreen], a
	jr .render

.prev_mon
	ld a, [wCurPartyMon]
.more_prev
	and a
	jr z, .input_loop
	dec a
	ld hl, wPartyMon1IsEgg
	push af
	call GetPartyLocation
	pop af
	bit MON_IS_EGG_F, [hl]
	jr nz, .more_prev
	jr .switch_mon

.next_mon
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
.more_next
	inc a
	cp b
	jr z, .input_loop
	ld hl, wPartyMon1IsEgg
	push af
	call GetPartyLocation
	pop af
	bit MON_IS_EGG_F, [hl]
	jr nz, .more_next
.switch_mon
	ld [wCurPartyMon], a
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	inc a
	ld [wPartyMenuCursor], a
	ld a, [hl]
	ld [wCurPartySpecies], a
	call ClearSpriteAnims
	jmp .restart

.EVHeading:
	db "Effort   @"

.IVHeading:
	db "Potential@"


.PrintTopStat:
; hl = coords, de = string, bc = stat
	push bc
	rst PlaceString
	ld de, SCREEN_WIDTH
	jr ._FinishPrintStat

.PrintBottomStat:
; hl = coords, de = string, bc = stat
	push bc
	rst PlaceString
	ld de, -SCREEN_WIDTH
._FinishPrintStat:
	add hl, de
	pop de
	lb bc, 2, 3
	jmp PrintNum

.HP:  db "HP@"
.Atk: db "Atk@"
.Def: db "Def@"
.Spd: db "Spd@"
.SDf: db "SDf@"
.SAt: db "SAt@"

.PrepareChart:
; hl = palettes, de = title string, bc = chart function
	push bc
	push de
; Load the palettes
	ld de, wBGPals1
	ld bc, 6 palettes
	call FarCopyColorWRAM
; Place the title
	pop de
	hlcoord 1, 2
	rst PlaceString
; Render the chart when this returns (bc is on the stack)
	ld b, 2
	jmp SafeCopyTilemapAtOnce

SparkleMaxStat:
; Show a sparkle sprite at (d, e) if a is 255
; Returns carry if the sprite is shown
	inc a
	ret nz
	ld a, SPRITE_ANIM_INDEX_MAX_STAT_SPARKLE
	jr _InitSpriteAnimStruct_PreserveHL

SparkleMaxStatOrShowBottleCap:
; Show a sparkle sprite at (d, e) if a is 255,
; or a bottle cap sprite if [hl] bit 7 is 1 (shifts [hl] regardless)
; Returns carry if either sprite is shown
	rlc [hl] ; sets carry if hyper trained
	inc a ; sets z if if max stat; does not affect carry
	ld a, SPRITE_ANIM_INDEX_MAX_STAT_SPARKLE
	jr z, _InitSpriteAnimStruct_PreserveHL
	assert SPRITE_ANIM_INDEX_MAX_STAT_SPARKLE + 1 == SPRITE_ANIM_INDEX_HYPER_TRAINED_STAT
	inc a ; does not affect carry
	ret nc
_InitSpriteAnimStruct_PreserveHL:
	push hl
	call _InitSpriteAnimStruct
	pop hl
	scf
	ret

RenderEVChart:
; Read the EVs and round them up to the nearest 4
; HP
	ld a, [wTempMonHPEV]
	or %11
	ldh [hChartHP], a
	depixel 2, 12
	call SparkleMaxStat
; Atk
	ld a, [wTempMonAtkEV]
	or %11
	ldh [hChartAtk], a
	depixel 4, 17
	call SparkleMaxStat
; Def
	ld a, [wTempMonDefEV]
	or %11
	ldh [hChartDef], a
	depixel 15, 17
	call SparkleMaxStat
; Spd
	ld a, [wTempMonSpdEV]
	or %11
	ldh [hChartSpd], a
	depixel 17, 12
	call SparkleMaxStat
; SAt
	ld a, [wTempMonSatEV]
	or %11
	ldh [hChartSat], a
	depixel 4, 6
	call SparkleMaxStat
; SDf
	ld a, [wTempMonSdfEV]
	or %11
	ldh [hChartSdf], a
	depixel 15, 6
	call SparkleMaxStat
	jr RenderChart

RenderIVChart:
; Read the IVs and scale them to 255 instead of 31
	ld hl, wBuffer1
	ld a, [wTempMonHyperTraining]
	ld [hl], a
; HP
	ld a, [wTempMonHPAtkDV]
	and $f0
	ld b, a
	swap a
	or b
	ldh [hChartHP], a
	depixel 2, 12
	call SparkleMaxStatOrShowBottleCap
; Atk
	ld a, [wTempMonHPAtkDV]
	and $0f
	ld b, a
	swap a
	or b
	ldh [hChartAtk], a
	depixel 4, 17
	call SparkleMaxStatOrShowBottleCap
; Def
	ld a, [wTempMonDefSpdDV]
	and $f0
	ld b, a
	swap a
	or b
	ldh [hChartDef], a
	depixel 15, 17
	call SparkleMaxStatOrShowBottleCap
; Spd
	ld a, [wTempMonDefSpdDV]
	and $0f
	ld b, a
	swap a
	or b
	ldh [hChartSpd], a
	depixel 17, 12
	call SparkleMaxStatOrShowBottleCap
; SAt
	ld a, [wTempMonSatSdfDV]
	and $f0
	ld b, a
	swap a
	or b
	ldh [hChartSat], a
	depixel 4, 6
	call SparkleMaxStatOrShowBottleCap
; SDf
	ld a, [wTempMonSatSdfDV]
	and $0f
	ld b, a
	swap a
	or b
	ldh [hChartSdf], a
	depixel 15, 6
	call SparkleMaxStatOrShowBottleCap
	; fallthrough

RenderChart:
; Decompress blank chart graphics
	ld hl, JudgeSystemGFX
	ld b, BANK(JudgeSystemGFX)
	call FarDecompressWRA6InB
; Render the radar chart onto the graphics
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	call OutlineRadarChart
	ld a, $1
	ldh [rSVBK], a
	ret

CalcBTimesCOver256:
; a = b * c / 256
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, b
	ldh [hMultiplicand + 2], a
	ld a, c
	ldh [hMultiplier], a
	call Multiply
	ldh a, [hProduct + 2]
	ret

OutlineRadarChart:
; de = point for HP axis
	ldh a, [hChartHP]
	ld b, a
	; x = 39
	ld a, 39
	ld d, a
	; y = 46 - v * 47 / 256
	ld c, 47
	call CalcBTimesCOver256
	cpl
	add 46 + 1 ; a = 46 - a
	ld e, a

; Store the HP point to close the polygon
	push de
	push de

; de = Atk point
	ldh a, [hChartAtk]
	ld b, a
	; x = 41 + v * 39 / 256
	ld c, 39
	call CalcBTimesCOver256
	add 41
	ld d, a
	; y = ForwardSlashAxisYCoords[x] (~= 46 - v * 23 / 256)
	add LOW(ForwardSlashAxisYCoords)
	ld c, a
	adc HIGH(ForwardSlashAxisYCoords)
	sub c
	ld b, a
	ld a, [bc]
	ld e, a

; Draw a line from HP to Atk
	pop bc
	push de
	ld a, LOW(FillRadarDown)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(FillRadarDown)
	ldh [hFunctionTargetHi], a
	call DrawAndFillRadarEdge

; de = Def point
	ldh a, [hChartDef]
	ld b, a
	; x = 41 + v * 39 / 256
	ld c, 39
	call CalcBTimesCOver256
	add 41
	ld d, a
	; y = BackslashAxisYCoords[x] (~= 49 + v * 23 / 256)
	add LOW(BackslashAxisYCoords)
	ld c, a
	adc HIGH(BackslashAxisYCoords)
	sub c
	ld b, a
	ld a, [bc]
	ld e, a

; Draw a line from Atk to Def
	pop bc
	push de
	ld a, LOW(FillRadarLeft)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(FillRadarLeft)
	ldh [hFunctionTargetHi], a
	call DrawAndFillRadarEdge

; de = Spd point
	ldh a, [hChartSpd]
	ld b, a
	; x = 40
	ld a, 40
	ld d, a
	; y = 49 + v * 47 / 256
	ld c, 47
	call CalcBTimesCOver256
	add 49
	ld e, a

; Draw a line from Def to Spd
	pop bc
	push de
	ld a, LOW(FillRadarUp)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(FillRadarUp)
	ldh [hFunctionTargetHi], a
	call DrawAndFillRadarEdge

; de = SDf point
	ldh a, [hChartSdf]
	ld b, a
	; x = 38 - v * 39 / 256
	ld c, 39
	call CalcBTimesCOver256
	cpl
	add 38 + 1 ; a = 38 - a
	ld d, a
	; y = ForwardSlashAxisYCoords[x] (~= 49 + v * 23 / 256)
	add LOW(ForwardSlashAxisYCoords)
	ld c, a
	adc HIGH(ForwardSlashAxisYCoords)
	sub c
	ld b, a
	ld a, [bc]
	ld e, a

; Draw a line from Spd to SDf
	pop bc
	push de
	; hFunctionTarget is already FillRadarUp
	call DrawAndFillRadarEdge

; de = SAt point
	ldh a, [hChartSat]
	ld b, a
	; x = 38 - v * 39 / 256
	ld c, 39
	call CalcBTimesCOver256
	cpl
	add 38 + 1 ; a = 38 - a
	ld d, a
	; y = BackslashAxisYCoords[x] (~= 46 - v * 23 / 256)
	add LOW(BackslashAxisYCoords)
	ld c, a
	adc HIGH(BackslashAxisYCoords)
	sub c
	ld b, a
	ld a, [bc]
	ld e, a

; Draw a line from SDf to SAt
	pop bc
	push de
	ld a, LOW(FillRadarRight)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(FillRadarRight)
	ldh [hFunctionTargetHi], a
	call DrawAndFillRadarEdge

; Draw a line from SAt to HP, closing the polygon
	pop bc
	pop de
	ld a, LOW(FillRadarDown)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(FillRadarDown)
	ldh [hFunctionTargetHi], a
	; fallthrough

DrawAndFillRadarEdge:
; Draw a line from (b, c) to (d, e) and fill it in with hFunction

; Calculate |x1 - x0|
	ld a, d
	sub b
	jr nc, .x_sorted
	cpl
	inc a ; a = -a
.x_sorted
	ldh [hDX], a
	ld l, a

; Calculate |y1 - y0|
	ld a, e
	sub c
	jr nc, .y_sorted
	cpl
	inc a ; a = -a
.y_sorted
	ldh [hDY], a

; Branch based on slope
	cp l
	jr nc, DrawHighRadarLine ; dy (a) >= dx (l)
	; fallthrough

DrawLowRadarLine:
; Draw a line from (b, c) to (d, e), left to right, where dx > dy

; Ensure that x0 < x1 (b < d)
	ld a, b
	cp d
	jr c, .x_sorted
	; swap bc and de
	ld a, b
	ld b, d
	ld d, a
	ld a, c
	ld c, e
	ld e, a
.x_sorted

; Shift up or down depending on dy
	ld a, c
	cp e
	ld a, $0c ; inc c
	jr c, .y_sorted
	jr z, DrawHorizontalRadarLine ; c == e, so y is constant
	inc a ; $0d ; dec c
.y_sorted
	ldh [hSingleOpcode], a

; D = 2 * dy - dx
	ldh a, [hDX]
	ld l, a
	ldh a, [hDY]
	add a
	sub l
	ldh [hErr], a

; For x from b to d, draw a point at (x, c)
	ld a, d
	ldh [hChartLineCoord], a
.loop
	call hLCDInterruptFunction ; FillRadarUp/Down/Left/Right

; Update D and y
	ldh a, [hErr]
	cp $80 ; high bit means negative
	jr nc, .not_positive
	call hSingleOperation
	ldh a, [hDX]
	ld l, a
	ldh a, [hErr]
	sub l
	sub l
	ldh [hErr], a
.not_positive
	ld hl, hDY
	add [hl]
	add [hl]
	ldh [hErr], a

	inc b
	ldh a, [hChartLineCoord]
	cp b
	jr nc, .loop
	ret

DrawHighRadarLine:
; Draw a line from (b, c) to (d, e), top to bottom, where dx <= dy

; Ensure that y0 < y1 (c < e)
	ld a, c
	cp e
	jr c, .y_sorted
	; swap bc and de
	ld a, b
	ld b, d
	ld d, a
	ld a, c
	ld c, e
	ld e, a
.y_sorted

; Shift right or left depending on dx
	ld a, b
	cp d
	ld a, $04 ; inc b
	jr c, .x_sorted
	jr z, DrawVerticalRadarLine ; b == d, so x is constant
	inc a ; $05 ; dec b
.x_sorted
	ldh [hSingleOpcode], a

; D = 2 * dx - dy
	ldh a, [hDY]
	ld l, a
	ldh a, [hDX]
	add a
	sub l
	ldh [hErr], a

; For y from c to e, draw a point at (b, y)
	ld a, e
	ldh [hChartLineCoord], a
.loop
	call hLCDInterruptFunction ; FillRadarUp/Down/Left/Right

; Update D and x
	ldh a, [hErr]
	cp $80
	jr nc, .not_positive
	call hSingleOperation
	ldh a, [hDY]
	ld l, a
	ldh a, [hErr]
	sub l
	sub l
	ldh [hErr], a
.not_positive
	ld hl, hDX
	add [hl]
	add [hl]
	ldh [hErr], a

	inc c
	ldh a, [hChartLineCoord]
	cp c
	jr nc, .loop
	ret

DrawHorizontalRadarLine:
; Draw from (b, c) to (d, e), where c == e and b < d

; Ensure that x0 < x1 (b < d)
	ld a, b
	cp d
	jr c, .x_sorted
	ld b, d
	ld d, a
.x_sorted

; For x from b to d, draw a point at (x, c)
	ld a, d
	ldh [hChartLineCoord], a
.loop
	call hLCDInterruptFunction ; FillRadarUp/Down/Left/Right
	inc b
	ldh a, [hChartLineCoord]
	cp b
	jr nc, .loop
	ret

DrawVerticalRadarLine:
; Draw a line from (b, c) to (d, e), where b == d

; Ensure that y0 < y1 (c < e)
	ld a, c
	cp e
	jr c, .y_sorted
	ld c, e
	ld e, a
.y_sorted

; For y from c to e, draw a point at (b, y)
	ld a, e
	ldh [hChartLineCoord], a
.loop
	call hLCDInterruptFunction ; FillRadarUp/Down/Left/Right
	inc c
	ldh a, [hChartLineCoord]
	cp c
	jr nc, .loop
	ret

FillRadarUp:
; Draw a vertical line up from (b, c) to the lower diagonal half-axes
	ld hl, LowerSlashAxesYCoords
	jr _FillRadarVertical

FillRadarDown:
; Draw a vertical line down from (b, c) to the upper diagonal half-axes
	ld hl, UpperSlashAxesYCoords
	; fallthrough

_FillRadarVertical:
; Draw a vertical line from (b, c) to (b, y), where y = hl[b]

	push bc

; de = point on the diagonal axes
	ld e, b
	ld d, 0
	add hl, de
	ld a, [hl]
	ld e, a
	ld d, b

; Ensure that y0 < y1 (c < e)
	ld a, c
	cp e
	jr c, .y_sorted
	ld c, e
	ld e, a
.y_sorted

; For y from c to e, draw a point at (b, y)
	ld a, e
	ldh [hChartFillCoord], a
.loop
	call DrawRadarPointBC
	inc c
	ldh a, [hChartFillCoord]
	cp c
	jr nc, .loop

	pop bc
	ret

FillRadarLeft:
; Draw a horizontal line left from (b, c) to the right diagonal half-axes
	ld hl, RightSlashAxesXCoords
	jr _FillRadarHorizontal

FillRadarRight:
; Draw a horizontal line right from (b, c) to the left diagonal half-axes
	ld hl, LeftSlashAxesXCoords
	; fallthrough

_FillRadarHorizontal:
; Draw a horizontal line from (b, c) to the vertical axis

	push bc

; de = point on the diagonal axes
	ld a, c
	sub 24
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	ld d, a
	ld e, c

; Ensure that x0 < x1 (b < d)
	ld a, b
	cp d
	jr c, .x_sorted
	ld b, d
	ld d, a
.x_sorted

; For x from b to d, draw a point at (x, c)
	ld a, d
	ldh [hChartFillCoord], a
.loop
	call DrawRadarPointBC
	inc b
	ldh a, [hChartFillCoord]
	cp b
	jr nc, .loop

	pop bc
	ret

DrawRadarPointBC:
; Draw a point at (b, c), where 0 <= b < 80 and 0 <= c < 96

; Byte: wDecompressScratch + ((y & $f8) * 10 + (x & $f8) + (y & $7)) * 2 + 1
	; hl = (y & $f8) * 10
	ld a, c
	and $f8
	add a
	ld l, a
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	; hl += (x & $f8) + (y & $7)
	ld a, b
	and $f8
	ld e, a
	ld a, c
	and $7
	add e
	ld e, a
	add hl, de
	; hl = wDecompressScratch + hl * 2 + 1 (second byte of 8 pixels)
	add hl, hl
	ld de, wDecompressScratch + 1
	add hl, de

; Set the (7 - (x & $7))th bit in the byte: white -> dark, black -> black (no light hue)
	; $c6 | (a << 3) = the 'set {a}, [hl]' opcode
	ld a, b
	add a
	add a
	add a
	and $7 << 3
	xor $c6 ^ ($7 << 3) ; this is 'xor $fe', so 'cpl / dec a' would also work
	ldh [hBitwiseOpcode], a
	jmp hBitwiseOperation

atk_y_coords: MACRO
	db 47, 46, 46, 45, 45, 44, 43, 43, 42, 42, 41, 40, 40, 39, 39, 38, 37, 37, 36, 36
	db 35, 34, 34, 33, 33, 32, 31, 31, 30, 30, 29, 29, 28, 27, 27, 26, 26, 25, 25, 24
ENDM

def_y_coords: MACRO
	db 48, 48, 49, 49, 50, 51, 51, 52, 52, 53, 53, 54, 55, 55, 56, 56, 57, 58, 58, 59
	db 59, 60, 61, 61, 62, 62, 63, 64, 64, 65, 65, 66, 67, 67, 68, 68, 69, 70, 70, 71
ENDM

spcl_atk_y_coords: MACRO
	db 24, 25, 25, 26, 26, 27, 27, 28, 29, 29, 30, 30, 31, 31, 32, 33, 33, 34, 34, 35
	db 36, 36, 37, 37, 38, 39, 39, 40, 40, 41, 42, 42, 43, 43, 44, 45, 45, 46, 46, 47
ENDM

spcl_def_y_coords: MACRO
	db 71, 70, 70, 69, 68, 68, 67, 67, 66, 65, 65, 64, 64, 63, 62, 62, 61, 61, 60, 59
	db 59, 58, 58, 57, 56, 56, 55, 55, 54, 53, 53, 52, 52, 51, 51, 50, 49, 49, 48, 48
ENDM

ForwardSlashAxisYCoords:
	spcl_def_y_coords
	atk_y_coords

BackslashAxisYCoords:
	spcl_atk_y_coords
	def_y_coords

UpperSlashAxesYCoords:
	spcl_atk_y_coords
	atk_y_coords

LowerSlashAxesYCoords:
	spcl_def_y_coords
	def_y_coords

LeftSlashAxesXCoords:
	db  0,  2,  4,  6,  7,  9, 11, 13, 14, 16, 18, 19, 21, 23, 24, 26, 28, 29, 31, 33, 34, 36, 38, 39
	db 38, 37, 35, 34, 32, 30, 28, 27, 25, 23, 22, 20, 18, 17, 15, 13, 12, 10,  8,  7,  5,  3,  2,  0

RightSlashAxesXCoords:
	db 79, 77, 75, 73, 72, 70, 68, 66, 65, 63, 61, 60, 58, 56, 55, 53, 51, 50, 48, 46, 45, 43, 41, 40
	db 41, 42, 44, 45, 47, 49, 51, 52, 54, 56, 57, 59, 61, 62, 64, 66, 67, 69, 71, 72, 74, 76, 77, 79

JudgeSystemGFX:
INCBIN "gfx/stats/judge.2bpp.lz"

MaxStatSparkleGFX:
INCBIN "gfx/stats/sparkle.2bpp"

EVChartPals:
if !DEF(MONOCHROME)
	RGB 23,28,21, 22,26,20, 10,17,16, 00,00,00 ; main bg
	RGB 31,31,31, 23,28,21, 31,25,02, 00,00,00 ; top text (incl. shiny)
	RGB 23,28,21, 31,31,31, 00,00,00, 02,06,13 ; stat values and B button
	RGB 23,28,21, 31,00,31, 31,00,31, 03,15,29 ; lowered stat
	RGB 23,28,21, 31,00,31, 31,00,31, 23,07,03 ; raised stat
	RGB 18,27,29, 23,28,21, 02,10,20, 10,17,16 ; chart
else
; main bg
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
; top text
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
; stat values and B button
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
; lowered stat
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_BLACK
; raised stat
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_BLACK
; chart
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_DARK
endc

IVChartPals:
if !DEF(MONOCHROME)
	RGB 28,21,14, 26,20,13, 27,14,13, 00,00,00 ; main bg
	RGB 31,31,31, 28,21,14, 31,25,02, 00,00,00 ; top text (incl. shiny)
	RGB 28,21,14, 31,31,31, 00,00,00, 02,06,13 ; stat values and B button
	RGB 28,21,14, 31,00,31, 31,00,31, 03,15,29 ; lowered stat
	RGB 28,21,14, 31,00,31, 31,00,31, 23,07,03 ; raised stat
	RGB 18,27,29, 28,21,14, 02,10,20, 27,14,13 ; chart
else
; main bg
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
; top text
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
; stat values and B button
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
; lowered stat
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_BLACK
; raised stat
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_BLACK
; chart
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_DARK
endc
