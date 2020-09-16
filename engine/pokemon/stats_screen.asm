StatsScreenInit:
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a ; disable overworld tile animations
	ld a, [wBoxAlignment] ; whether sprite is to be mirrorred
	push af
	ld a, [wJumptableIndex]
	ld b, a
	ld a, [wcf64]
	ld c, a

	push bc
	call ClearBGPalettes
	call ClearTileMap
	call UpdateSprites
	call LoadFontsBattleExtra
	ld hl, GFX_Stats
	ld de, vTiles2 tile $31
	lb bc, BANK(GFX_Stats), 41
	call DecompressRequest2bpp
	call StatsScreenMain
	call ClearBGPalettes
	call ClearTileMap
	pop bc

	; restore old values
	ld a, b
	ld [wJumptableIndex], a
	ld a, c
	ld [wcf64], a
	pop af
	ld [wBoxAlignment], a
	pop af
	ldh [hMapAnims], a
	ret

StatsScreenMain:
	xor a
	ld [wJumptableIndex], a
	ld [wcf64], a
.loop
	ld a, [wJumptableIndex]
	and $7f
	ld hl, StatsScreenPointerTable
	call JumpTable
	call StatsScreen_WaitAnim ; check for keys?
	ld a, [wJumptableIndex]
	bit 7, a
	jr z, .loop
	ret

StatsScreenPointerTable:
	dw MonStatsInit       ; regular pokémon
	dw EggStatsInit       ; egg
	dw StatsScreenWaitCry
	dw EggStatsJoypad
	dw StatsScreen_LoadPage
	dw StatsScreenWaitCry
	dw MonStatsJoypad
	dw StatsScreen_Exit

StatsScreen_WaitAnim:
	ld hl, wcf64
	bit 6, [hl]
	jr nz, .try_anim
	bit 5, [hl]
	jr nz, .finish
	jp DelayFrame

.try_anim
	farcall SetUpPokeAnim
	jr nc, .finish
	ld hl, wcf64
	res 6, [hl]
.finish
	ld hl, wcf64
	res 5, [hl]
	farjp HDMATransferTileMapToWRAMBank3

StatsScreen_SetJumptableIndex:
	ld a, [wJumptableIndex]
	and $80
	or h
	ld [wJumptableIndex], a
	ret

StatsScreen_Exit:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

MonStatsInit:
	ld hl, wcf64
	res 6, [hl]
	call ClearBGPalettes
	call ClearTileMap
	farcall HDMATransferTileMapToWRAMBank3
	call StatsScreen_CopyToTempMon
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	jr nz, .egg
	call StatsScreen_InitUpperHalf
	ld hl, wcf64
	set 4, [hl]
	ld h, 4
	jp StatsScreen_SetJumptableIndex

.egg
	ld h, 1
	jp StatsScreen_SetJumptableIndex

EggStatsInit:
	ld a, [wCurPartySpecies]
	push af
	ld a, EGG
	ld [wCurPartySpecies], a
	call EggStatsScreen
	pop af
	ld [wCurPartySpecies], a
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret

EggStatsJoypad:
	call StatsScreen_GetJoypad
	jr nc, .check
	ld h, 0
	jp StatsScreen_SetJumptableIndex

.check
	bit A_BUTTON_F, a
	jr nz, .quit
	and D_DOWN | D_UP | A_BUTTON | B_BUTTON
	jp StatsScreen_JoypadAction

.quit
	ld h, 7
	jp StatsScreen_SetJumptableIndex

StatsScreen_LoadPage:
	call StatsScreen_LoadGFX
	ld hl, wcf64
	res 4, [hl]
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret

MonStatsJoypad:
	call StatsScreen_GetJoypad
	jr nc, .next
	ld h, 0
	jp StatsScreen_SetJumptableIndex

.next
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON
	jp StatsScreen_JoypadAction

StatsScreenWaitCry:
	call IsSFXPlaying
	ret nc
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret

StatsScreen_CopyToTempMon:
	ld a, [wMonType]
	cp TEMPMON
	jr nz, .breedmon
	ld a, [wBufferMon]
	ld [wCurSpecies], a
	ld a, [wBufferMonForm]
	and FORM_MASK
	ld [wCurForm], a
	call GetBaseData
	ld hl, wBufferMon
	ld de, wTempMon
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	jr .done

.breedmon
	farcall CopyPkmnOrEggToTempMon
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	jr nz, .done
	ld a, [wMonType]
	cp BOXMON
	jr c, .done
	ld hl, StatsScreen_OTNamePointers
	call GetNicknamePointer
	farcall CalcTempmonStats
.done
	and a
	ret

StatsScreen_GetJoypad:
	call GetJoypad
	ld a, [wMonType]
	cp TEMPMON
	jr nz, .notbreedmon
	push hl
	push de
	push bc
	farcall StatsScreenDPad
	pop bc
	pop de
	pop hl
	ld a, [wMenuJoypad]
	and D_DOWN | D_UP
	jr nz, .set_carry
	ld a, [wMenuJoypad]
	jr .clear_flags

.notbreedmon
	ldh a, [hJoyPressed]
.clear_flags
	and a
	ret

.set_carry
	scf
	ret

StatsScreen_JoypadAction:
	push af
	ld a, [wcf64]
	and $3
	ld c, a
	pop af
	bit B_BUTTON_F, a
	jp nz, .b_button
	bit D_LEFT_F, a
	jr nz, .d_left
	bit D_RIGHT_F, a
	jr nz, .d_right
	bit A_BUTTON_F, a
	jr nz, .a_button
	bit D_UP_F, a
	jr nz, .d_up
	bit D_DOWN_F, a
	jr nz, .d_down
	ret

.d_down
	ld a, [wMonType]
	cp BOXMON
	ret nc
	and a
	ld a, [wPartyCount]
	jr z, .next_mon
	ld a, [wOTPartyCount]
.next_mon
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	ret z
	ld [wCurPartyMon], a
	ld b, a
	ld a, [wMonType]
	and a
	jr nz, .load_mon
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	jr .load_mon

.d_up
	ld a, [wCurPartyMon]
	and a
	ret z
	dec a
	ld [wCurPartyMon], a
	ld b, a
	ld a, [wMonType]
	and a
	jr nz, .load_mon
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	jr .load_mon

.a_button
	ld a, c
	cp $3
	jr z, .b_button
.d_right
	inc c
	ld a, $3
	cp c
	jr nc, .set_page
	ld c, 0
	jr .set_page

.d_left
	ld a, c
	dec c
	and a
	jr nz, .set_page
	ld c, $3
	; fallthrough

.set_page
	ld a, [wcf64]
	and %11111100
	or c
	ld [wcf64], a
	ld h, 4
	jp StatsScreen_SetJumptableIndex

.load_mon
	ld h, 0
	jp StatsScreen_SetJumptableIndex

.b_button
	ld h, 7
	jp StatsScreen_SetJumptableIndex

StatsScreen_InitUpperHalf:
	call .PlaceHPBar
	xor a
	ldh [hBGMapMode], a
	ld a, [wCurPartySpecies]
	ld [wd265], a
	ld [wCurSpecies], a
	hlcoord 8, 0
	ld [hl], "№"
	inc hl
	ld [hl], "."
	inc hl
	hlcoord 10, 0
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	ld de, wd265
	call PrintNum
	hlcoord 14, 0
	call PrintLevel
	ld hl, .NicknamePointers
	call GetNicknamePointer
	call CopyNickname
	hlcoord 8, 2
	rst PlaceString
	hlcoord 18, 0
	call .PlaceGenderChar
	hlcoord 9, 4
	ld a, "/"
	ld [hli], a
	ld a, [wCurSpecies]
	ld [wd265], a
	call GetPokemonName
	rst PlaceString
	call StatsScreen_PlacePageSwitchArrows
	jp StatsScreen_PlaceShinyIcon

.PlaceHPBar:
	ld hl, wTempMonHP
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wTempMonMaxHP
	ld a, [hli]
	ld d, a
	ld e, [hl]
	farcall ComputeHPBarPixels
	ld hl, wCurHPPal
	call SetHPPal
	ld a, CGB_STATS_SCREEN_HP_PALS
	call GetCGBLayout
	jp DelayFrame

.PlaceGenderChar:
	push hl
	farcall GetGender
	pop hl
	ret c
	ld a, "<MALE>"
	jr nz, .got_gender
	inc a ; "<FEMALE>"
.got_gender
	ld [hl], a
	ret

.NicknamePointers:
	dw wPartyMonNicknames
	dw wOTPartyMonNicknames
	dw sBoxMonNicknames
	dw wBufferMonNick

StatsScreen_PlaceHorizontalDivider:
	hlcoord 0, 7
	ld b, SCREEN_WIDTH
	ld a, $36
.loop
	ld [hli], a
	dec b
	jr nz, .loop

	; Place T divider
	ld a, [wcf64]
	and $3
	ld c, a
	rrca
	jr c, .skip_t_divider
	and a
	hlcoord 9, 7
	jr z, .got_vertical_pos
	inc hl
.got_vertical_pos
	ld [hl], $37
.skip_t_divider
	hlcoord 0, 7, wAttrMap
	ld a, c
	add $3
	ld b, SCREEN_WIDTH
.loop2
	ld [hli], a
	dec b
	jr nz, .loop2
	ld b, 0
	ret

StatsScreen_PlaceEggDivider:
	hlcoord 0, 7
	ld b, SCREEN_WIDTH
	ld a, $3e
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

StatsScreen_PlacePageSwitchArrows:
	hlcoord 10, 6
	ld [hl], "◀"
	hlcoord 19, 6
	ld [hl], "▶"
	ret

StatsScreen_PlaceShinyIcon:
	ld bc, wTempMonShiny
	farcall CheckShininess
	ret nc
	hlcoord 19, 0
	ld [hl], "★"
	ret

StatsScreen_LoadGFX:
	ld a, [wCurPartySpecies]
	ld [wd265], a
	ld [wCurSpecies], a
	xor a
	ldh [hBGMapMode], a
	call .ClearBox
	call .LoadPokeBall
	call .PageTilemap
	call .LoadPals
	ld hl, wcf64
	bit 4, [hl]
	call nz, StatsScreen_PlaceFrontpic
	ld b, 2
	jp SafeCopyTilemapAtOnce

.ClearBox:
	ld a, [wcf64]
	and $3
	ld c, a
	call StatsScreen_LoadPageIndicators
	call StatsScreen_PlaceHorizontalDivider
	hlcoord 0, 8
	lb bc, 10, 20
	jp ClearBox

.LoadPokeBall:
	; draw border
	hlcoord 8, 5
	ld [hl], $32 ; top
	hlcoord 7, 6
	ld [hl], $33 ; left
	hlcoord 9, 6
	ld [hl], $34 ; right
	hlcoord 8, 7
	ld [hl], $35 ; bottom
	; draw center
	; index = $40 + [wTempMonCaughtBall]
	ld a, [wTempMonCaughtBall]
	and CAUGHTBALL_MASK
	add $40
	hlcoord 8, 6
	ld [hl], a ; center
	ret

.LoadPals:
	ld a, [wcf64]
	and $3
	ld c, a
	farcall LoadStatsScreenPals
	call DelayFrame
	ld hl, wcf64
	set 5, [hl]
	ret

.PageTilemap:
	ld a, [wcf64]
	and $3
	call StackJumpTable

.Jumptable:
	dw .PinkPage
	dw .GreenPage
	dw .BluePage
	dw .OrangePage

.PinkPage:
	ld de, .Status_Type
	hlcoord 0, 9
	rst PlaceString
	ld a, [wTempMonPokerusStatus]
	ld b, a
	and $f
	jr nz, .HasPokerus
	ld a, b
	and $f0
	jr z, .NotImmuneToPkrs
	hlcoord 8, 8
	ld [hl], "."
.NotImmuneToPkrs:
	ld a, [wMonType]
	cp BOXMON
	jr z, .StatusOK
	hlcoord 5, 10
	push hl
	ld de, wTempMonStatus
	farcall PlaceStatusString
	pop hl
	jr nz, .done_status
	jr .StatusOK
.HasPokerus:
	ld de, .PkrsStr
	hlcoord 1, 10
	rst PlaceString
	jr .done_status
.StatusOK:
	ld de, .OK_str
	rst PlaceString
.done_status
	hlcoord 1, 12
	farcall PrintMonTypes
	call .PlaceOTInfo
	hlcoord 9, 8
	ld de, SCREEN_WIDTH
	ld b, 10
	ld a, $31 ; vertical divider
.vertical_divider
	ld [hl], a
	add hl, de
	dec b
	jr nz, .vertical_divider
	ld de, .ExpPointStr
	hlcoord 10, 9
	rst PlaceString
	hlcoord 17, 14
	call .PrintNextLevel
	hlcoord 13, 10
	lb bc, 3, 7
	ld de, wTempMonExp
	call PrintNum
	call .CalcExpToNextLevel
	hlcoord 13, 13
	lb bc, 3, 7
	ld de, wBuffer1
	call PrintNum
	ld de, .LevelUpStr
	hlcoord 10, 12
	rst PlaceString
	ld de, .ToStr
	hlcoord 14, 14
	rst PlaceString
	hlcoord 12, 16
	ld a, [wTempMonLevel]
	ld b, a
	ld de, wTempMonExp + 2
	farcall FillInExpBar
	hlcoord 10, 16
	ld [hl], "<XP1>"
	inc hl
	ld [hl], "<XP2>"
	hlcoord 19, 16
	ld [hl], "<XPEND>" ; exp bar end cap
	ret

.PrintNextLevel:
	ld a, [wTempMonLevel]
	push af
	cp MAX_LEVEL
	jr z, .AtMaxLevel
	inc a
	ld [wTempMonLevel], a
.AtMaxLevel:
	call PrintLevel
	pop af
	ld [wTempMonLevel], a
	ret

.CalcExpToNextLevel:
	ld a, [wTempMonLevel]
	cp MAX_LEVEL
	jr z, .AlreadyAtMaxLevel
	inc a
	ld d, a
	farcall CalcExpAtLevel
	ld hl, wTempMonExp + 2
	ldh a, [hQuotient + 2]
	sub [hl]
	dec hl
	ld [wBuffer3], a
	ldh a, [hQuotient + 1]
	sbc [hl]
	dec hl
	ld [wBuffer2], a
	ldh a, [hQuotient]
	sbc [hl]
	ld [wBuffer1], a
	ret

.AlreadyAtMaxLevel:
	ld hl, wBuffer1
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

.PlaceOTInfo:
	ld de, .OT_ID_str
	hlcoord 0, 14
	rst PlaceString
	hlcoord 3, 16
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	ld de, wTempMonID
	call PrintNum
	ld hl, StatsScreen_OTNamePointers
	call GetNicknamePointer
	call CopyNickname
	hlcoord 1, 15
	rst PlaceString
	ld a, [wTempMonCaughtGender]
	and FEMALE
	jr z, .male
	ld a, "♀"
	jr .got_gender
.male
	ld a, "♂"
.got_gender
	hlcoord 8, 15
	ld [hl], a
	ret

.Status_Type:
	db   "Status/"
	next "Type/@"

.OK_str:
	db " OK@"

.OT_ID_str:
	db   "OT/"
	next "<ID>№.@"

.ExpPointStr:
	db "Exp.Points@"

.LevelUpStr:
	db "Level Up@"

.ToStr:
	db "to@"

.PkrsStr:
	db "#rus@"

.GreenPage:
	ld de, .Item
	hlcoord 0, 8
	rst PlaceString
	call .GetItemName
	hlcoord 8, 8
	rst PlaceString
	ld de, .Move
	hlcoord 0, 10
	rst PlaceString
	ld hl, wTempMonMoves
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	rst CopyBytes
	hlcoord 8, 10
	ld a, SCREEN_WIDTH * 2
	ld [wBuffer1], a
	predef ListMoves
	hlcoord 12, 11
	ld a, SCREEN_WIDTH * 2
	ld [wBuffer1], a
	predef_jump ListMovePP

.GetItemName:
	ld de, .ThreeDashes
	ld a, [wTempMonItem]
	and a
	ret z
	ld [wd265], a
	jp GetItemName

.Item:
	db "Item@"

.ThreeDashes:
	db "---@"

.Move:
	db "Moves@"

.BluePage:
	hlcoord 0, 9
	predef DrawPlayerHP
	call .PlaceNatureInfo
	call TN_PrintCharacteristics
	hlcoord 10, 8
	ld de, SCREEN_WIDTH
	ld b, 10
	ld a, $31 ; vertical divider
.BluePageVerticalDivider:
	ld [hl], a
	add hl, de
	dec b
	jr nz, .BluePageVerticalDivider
	hlcoord 11, 8
	ld bc, 6
	farcall PrintTempMonStats

	; Print Hyper Training statistics
	ld hl, StatsScreen_OTNamePointers
	call GetNicknamePointer
	ld bc, PLAYER_NAME_LENGTH
	add hl, bc
	ld a, [hl]
	hlcoord 0, 10
	ld de, -4
	call .CheckHyper
	ld de, SCREEN_WIDTH * 2
	ld b, 5
.hyper_loop
	call .CheckHyper
	dec b
	jr nz, .hyper_loop
	ret

.CheckHyper:
	rlca
	jr nc, .no_hyper_star
	ld [hl], "★"
.no_hyper_star
	add hl, de
	ret

.PlaceNatureInfo:
	ld de, .NatureString
	hlcoord 0, 12
	rst PlaceString
	ld a, [wTempMonNature]
	ld b, a
	call GetNature
	hlcoord 1, 13
	farjp PrintNature

.NatureString:
	db "Nature/@"

.OrangePage:
	farjp OrangePage_

; Fourth stats page code by TPP Anniversary Crystal 251
; Ported by FredrIQ
OrangePage_:
	call TN_PrintToD
	call TN_PrintLV
	call TN_PrintLocation
	hlcoord 0, 11
	ld bc, SCREEN_WIDTH
	ld a, $3e
	rst ByteFill
	hlcoord 1, 12
	ld de, .ability
	rst PlaceString
	ld a, [wTempMonAbility]
	and ABILITY_MASK
	swap a
	rrca
	ld e, a
	ld d, 0
	ld hl, .ability_tiles - 1 ; ability constants start at 1
	add hl, de
	ld a, [hl]
	hlcoord 9, 12
	ld [hl], a
	ld hl, wTempMonPersonality
	ld a, [wTempMonSpecies]
	ld c, a
	call GetAbility
	; PlaceString as used in PrintAbility doesn't preserve any register, so push it.
	push bc
	farcall PrintAbility
	pop bc
	farjp PrintAbilityDescription

.ability
	db "Ability/@"

.ability_tiles
	db "1", "2", $3f ; bold H

StatsScreen_OTNamePointers:
	dw wPartyMonOT
	dw wOTPartyMonOT
	dw sBoxMonOT
	dw wBufferMonOT

TN_PrintToD:
	ld de, .caughtat
	hlcoord 1, 8
	rst PlaceString
	hlcoord 3, 9
	ld a, [wTempMonCaughtTime]
	farjp PlaceCaughtTimeOfDayString

.caughtat
	db "Met/@"

TN_PrintLocation:
	ld a, [wTempMonCaughtLocation]
	and a
	ret z
	ld de, .event
	cp $ff
	jr z, .print
	ld e, a
	farcall GetLandmarkName
	ld de, wStringBuffer1
.print
	hlcoord 3, 10
	rst PlaceString
	ret

.event
	db "Event #mon@"

TN_PrintLV:
	ld a, [wTempMonCaughtLevel]
; inherit coordinate from TN_PrintToD
	ld h, b
	ld l, c
	inc hl
;	hlcoord 11, 9
	and a
	jr z, .traded
	cp 1
	jr z, .hatched
	ld [wBuffer2], a
	ld de, .str_level
	rst PlaceString
	ld h, b
	ld l, c
;	hlcoord 15, 9
	ld de, wBuffer2
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
	jp PrintNum
.hatched
	ld de, .str_hatched
	rst PlaceString
	ret
.traded
	ld de, .str_traded
	rst PlaceString
	ret

.str_level
	db "at <LV>@"

.str_hatched
	db "from Egg@"

.str_traded
	db "by trade@"

TN_PrintCharacteristics:
	; b = value of best DV, c = index of best DV
	ld hl, wTempMonDVs
	; Atk
	ld c, 1
	ld a, [hl]
	and $f
	ld b, a
	; HP
	ld a, [hli]
	swap a
	and $f
	cp b
	jr z, .atk_beats_hp ; tie
	jr c, .atk_beats_hp
	ld c, 0
	ld b, a
.atk_beats_hp
	; Spd
	ld a, [hl]
	and $f
	cp b
	jr z, .last_beats_spd ; tie
	jr c, .last_beats_spd
	ld c, 5
	ld b, a
.last_beats_spd
	; Def
	ld a, [hli]
	swap a
	and $f
	cp b
	jr z, .last_beats_def ; tie
	jr c, .last_beats_def
	ld c, 2
	ld b, a
.last_beats_def
	; SDf
	ld a, [hl]
	and $f
	cp b
	jr z, .last_beats_sdf ; tie
	jr c, .last_beats_sdf
	ld c, 4
	ld b, a
.last_beats_sdf
	; SAt
	ld a, [hl]
	swap a
	and $f
	cp b
	jr z, .last_beats_sat ; tie
	jr c, .last_beats_sat
	ld c, 3
	ld b, a
.last_beats_sat

; DVs are 0-15, but Gen 3+ IVs are 0-31.
; Stats are calculated so that a DV of N acts like an IV of 2*N+1.
; To keep characteristics consistent with the apparent IV values,
; this conversion is actually done.
	ld a, b
	add b
	inc a
	ld b, a
	; a = 5 * c + b % 5
.mod_5
	cp 5
	jr c, .modded_5
	sub 5
	jr .mod_5
.modded_5
	ld b, a
	ld a, 5
	call SimpleMultiply
	add b

	ld l, a
	ld h, 0
	ld bc, Characteristics
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	hlcoord 0, 15
	rst PlaceString
	ret

INCLUDE "data/characteristics.asm"

StatsScreen_PlaceFrontpic:
	ld hl, wTempMonForm
	predef GetVariant
	call StatsScreen_GetAnimationParam
	jr c, .egg
	and a
	jr z, .no_cry
	jr .cry

.egg
	call .AnimateEgg
	jp SetPalettes

.no_cry
	call .AnimateMon
	jp SetPalettes

.cry
	call SetPalettes
	call .AnimateMon
	ld a, [wCurPartySpecies]
	jp PlayCry2

.AnimateMon:
	ld hl, wcf64
	set 5, [hl]
	hlcoord 0, 0
	ld a, [wCurPartySpecies]
	cp UNOWN
	jp z, PrepMonFrontpicFlipped
	jp PrepMonFrontpic

.AnimateEgg:
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr z, .unownegg
	ld a, TRUE
	ld [wBoxAlignment], a
	jr .get_animation

.unownegg
	xor a
	ld [wBoxAlignment], a
	; fallthrough

.get_animation
	ld a, [wCurPartySpecies]
	call IsAPokemon
	ret c
	call StatsScreen_LoadTextboxSpaceGFX
	ld de, vTiles2 tile $00
	predef FrontpicPredef
	hlcoord 0, 0
	lb de, $0, $2
	predef LoadMonAnimation
	ld hl, wcf64
	set 6, [hl]
	ret

StatsScreen_GetAnimationParam:
	ld a, [wMonType]
	call StackJumpTable

.Jumptable:
	dw .PartyMon
	dw .OTPartyMon
	dw .BoxMon
	dw .Tempmon
	dw .Wildmon

.PartyMon:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld b, h
	ld c, l
	jr .CheckEggFaintedFrzSlp

.OTPartyMon:
	xor a
	ret

.BoxMon:
	ld hl, sBoxMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld b, h
	ld c, l
	ld a, BANK(sBoxMons)
	call GetSRAMBank
	call .CheckEggFaintedFrzSlp
	push af
	call CloseSRAM
	pop af
	ret

.Tempmon:
	ld bc, wTempMon
.CheckEggFaintedFrzSlp:
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	jr nz, .egg
	call CheckFaintedFrzSlp
	jr c, .FaintedFrzSlp
.egg
	xor a
	scf
	ret

.Wildmon:
	ld a, $1
	and a
	ret

.FaintedFrzSlp:
	xor a
	ret

StatsScreen_LoadTextboxSpaceGFX:
	push hl
	push de
	push bc
	push af
	call DelayFrame
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	ld de, TextboxSpaceGFX
	lb bc, BANK(TextboxSpaceGFX), 1
	ld hl, vTiles2 tile $7f
	call Get1bpp
	pop af
	ldh [rVBK], a
	jp PopAFBCDEHL

EggStatsScreen:
	xor a
	ldh [hBGMapMode], a
	ld hl, wCurHPPal
	call SetHPPal
	ld a, CGB_STATS_SCREEN_HP_PALS
	call GetCGBLayout
	call StatsScreen_PlaceEggDivider
	ld de, EggString
	hlcoord 8, 1
	rst PlaceString
	ld a, [wTempMonHappiness] ; egg status
	ld de, EggSoonString
	cp $6
	jr c, .picked
	ld de, EggCloseString
	cp $b
	jr c, .picked
	ld de, EggMoreTimeString
	cp $29
	jr c, .picked
	ld de, EggALotMoreTimeString
.picked
	hlcoord 1, 9
	rst PlaceString
	ld hl, wcf64
	set 5, [hl]
	call SetPalettes ; pals
	call DelayFrame
	hlcoord 0, 0
	call PrepMonFrontpic
	farcall HDMATransferTileMapToWRAMBank3
	call StatsScreen_AnimateEgg

	ld a, [wTempMonHappiness]
	cp 6
	ret nc
	ld de, SFX_2_BOOPS
	jp PlaySFX

EggString:
	db   "Egg"
	next "OT/?????"
	next "<ID>№.?????@"

EggSoonString:
	db   "It's making sounds"
	next "inside. It's going"
	next "to hatch soon!@"

EggCloseString:
	db   "It moves around"
	next "inside sometimes."
	next "It must be close"
	next "to hatching.@"

EggMoreTimeString:
	db   "Wonder what's"
	next "inside? It needs"
	next "more time, though.@"

EggALotMoreTimeString:
	db   "This Egg needs a"
	next "lot more time to"
	next "hatch.@"

StatsScreen_AnimateEgg:
	call StatsScreen_GetAnimationParam
	ret nc
	ld a, [wTempMonHappiness]
	ld e, $7
	cp 6
	jr c, .animate
	ld e, $8
	cp 11
	jr c, .animate
	ret

.animate
	push de
	ld a, $1
	ld [wBoxAlignment], a
	call StatsScreen_LoadTextboxSpaceGFX
	ld de, vTiles2 tile $00
	predef FrontpicPredef
	pop de
	hlcoord 0, 0
	ld d, $0
	predef LoadMonAnimation
	ld hl, wcf64
	set 6, [hl]
	ret

StatsScreen_LoadPageIndicators:
	; Write the smaller squares for page display.
	hlcoord 11, 5
	ld a, $7f
	ld b, 8
.loop
	ld [hli], a
	dec b
	jr nz, .loop

	hlcoord 11, 6
	ld a, $38
	ld b, 4
.loop2
	ld [hli], a
	inc a
	ld [hli], a
	dec a
	dec b
	jr nz, .loop2

	; Write the bigger (selected) square for selected page.
	; c contains current page (0-3)
	sla c
	hlcoord 11, 5
	add hl, bc
	ld a, $3a
	ld [hli], a
	inc a
	ld [hld], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	ret

CopyNickname:
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	ld a, [wMonType]
	cp BOXMON
	jr nz, .partymon
	ld a, BANK(sBoxMonNicknames)
	call GetSRAMBank
	push de
	rst CopyBytes
	pop de
	jp CloseSRAM

.partymon
	push de
	rst CopyBytes
	pop de
	ret

GetNicknamePointer:
	ld a, [wMonType]
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMonType]
	cp TEMPMON
	ret z
	ld a, [wCurPartyMon]
	jp SkipNames

CheckFaintedFrzSlp:
	ld hl, MON_HP
	add hl, bc
	ld a, [hli]
	or [hl]
	jr z, .fainted_frz_slp
	ld hl, MON_STATUS
	add hl, bc
	ld a, [hl]
	and (1 << FRZ) | SLP
	jr nz, .fainted_frz_slp
	and a
	ret

.fainted_frz_slp
	scf
	ret
