SelectMonFromParty:
	call DisableSpriteUpdates
	xor a
	ld [wPartyMenuActionText], a
	call ClearBGPalettes
	call InitPartyMenuLayout
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	call PartyMenuSelect
	jp ReturnToMapWithSpeechTextbox

SelectTradeOrDaycareMon:
	ld a, b
	ld [wPartyMenuActionText], a
	call DisableSpriteUpdates
	call ClearBGPalettes
	call InitPartyMenuLayout
	call ApplyTilemapInVBlank
	ld a, CGB_PARTY_MENU
	call GetCGBLayout
	call SetPalettes
	call DelayFrame
	call PartyMenuSelect
	jp ReturnToMapWithSpeechTextbox

InitPartyMenuLayout:
	call LoadPartyMenuGFX
	call InitPartyMenuWithCancel
	call InitPartyMenuGFX
	call WritePartyMenuTilemap
	jp PrintPartyMenuText

LoadPartyMenuGFX:
	call LoadFontsBattleExtra
	farcall InitPartyMenuPalettes ; engine/color.asm
	jp ClearSpriteAnims2

WritePartyMenuTilemap:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl] ; Disable text delay
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	rst ByteFill ; blank the tilemap
	call GetPartyMenuTilemapPointers ; This reads from a pointer table???
.loop
	ld a, [hli]
	cp $ff
	jr z, .end ; 0x5007a $8
	push hl
	ld hl, .Jumptable
	call JumpTable
	pop hl
	jr .loop ; 0x50082 $f3
.end
	pop af
	ld [wOptions1], a
	ret

.Jumptable:
	dw PlacePartyNicknames
	dw PlacePartyHPBar
	dw PlacePartyMenuHPDigits
	dw PlacePartyMonLevel
	dw PlacePartyMonStatus
	dw PlacePartyMonTMHMCompatibility
	dw PlacePartyMonEvoStoneCompatibility
	dw PlacePartyMonGender
	dw PlacePartyMonRemindable

PlacePartyNicknames:
	hlcoord 3, 1
	ld a, [wPartyCount]
	and a
	jr z, .end
	ld c, a
	ld b, $0
.loop
	push bc
	push hl
	push hl
	ld hl, wPartyMonNicknames
	ld a, b
	call GetNick
	pop hl
	rst PlaceString
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop

.end
	dec hl
	dec hl
	ld de, .CANCEL
	rst PlaceString
	ret

.CANCEL:
	db "Cancel@"

PlacePartyHPBar:
	xor a
	ld [wHPPalIndex], a
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, $0
	hlcoord 11, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .skip
	push hl
	call PlacePartymonHPBar
	pop hl
	ld d, $6
	call DrawBattleHPBar
	ld hl, wHPPals
	ld a, [wHPPalIndex]
	ld c, a
	ld b, $0
	add hl, bc
	call SetHPPal
	ld a, CGB_PARTY_MENU_HP_PALS
	call GetCGBLayout
.skip
	ld hl, wHPPalIndex
	inc [hl]
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartymonHPBar:
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1HP
	rst AddNTimes
	ld a, [hli]
	or [hl]
	jr nz, .not_fainted
	xor a
	ld e, a
	ld c, a
	ret

.not_fainted
	dec hl
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	predef_jump ComputeHPBarPixels

PlacePartyMenuHPDigits:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, $0
	hlcoord 13, 1
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1HP
	rst AddNTimes
	ld e, l
	ld d, h
	pop hl
	push de
	lb bc, 2, 3
	call PrintNum
	pop de
	ld a, "/"
	ld [hli], a
	inc de
	inc de
	lb bc, 2, 3
	call PrintNum

.next
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartyMonLevel:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 7, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Level
	rst AddNTimes
	ld e, l
	ld d, h
	pop hl
	ld a, [de]
	cp 100 ; This is distinct from MAX_LEVEL.
	jr nc, .ThreeDigits
	ld a, "<LV>"
	ld [hli], a
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	; jr .okay
.ThreeDigits:
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
; .okay
	call PrintNum

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartyMonStatus:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 4, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Status
	rst AddNTimes
	ld e, l
	ld d, h
	pop hl
	call PlaceStatusString

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartyMonTMHMCompatibility:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 12, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld hl, wPartySpecies
	ld e, b
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld a, b
	ld hl, wPartyMon1Form
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	and FORM_MASK
	ld [wCurForm], a
	predef CanLearnTMHMMove
	pop hl
	call .PlaceAbleNotAble
	rst PlaceString

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

.PlaceAbleNotAble:
	ld a, c
	and a
	jr nz, .able
	ld de, .string_not_able
	ret

.able
	ld de, .string_able
	ret

.string_able
	db "Able@"

.string_not_able
	db "Not able@"

PlacePartyMonEvoStoneCompatibility:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 12, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	; d = party index
	ld d, b
	; e = species
	ld a, d
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld e, [hl]
	; b = form
	ld a, d
	ld hl, wPartyMon1Form
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	and FORM_MASK
	ld b, a
	; c = species
	ld c, e
	; bc = index
	call GetSpeciesAndFormIndex
	dec bc
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	call .DetermineCompatibility
	pop hl
	rst PlaceString

.next
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

.DetermineCompatibility:
	ld de, wStringBuffer1
	ld a, BANK(EvosAttacksPointers)
	ld bc, 2
	call FarCopyBytes
	ld hl, wStringBuffer1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
; Reads up to six evolution entries
	ld a, BANK(EvosAttacks)
	ld bc, wStringBuffer2 - wStringBuffer1
	call FarCopyBytes
	ld hl, wStringBuffer1
.loop2
	ld a, [hli]
	and a
	jr z, .nope
	inc hl
	inc hl
	cp EVOLVE_ITEM
	jr nz, .loop2
	dec hl
	dec hl
	ld a, [wCurItem]
	cp [hl]
	inc hl
	inc hl
	jr nz, .loop2
	ld de, .string_able
	ret

.nope
	ld de, .string_not_able
	ret

.string_able
	db "Able@"
.string_not_able
	db "Not able@"

PlacePartyMonGender:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 10, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld hl, wPartySpecies
	ld e, b
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	pop hl
	ld a, [wCurPartyMon]
	push af
	ld a, b
	ld [wCurPartyMon], a
	push hl
	xor a
	ld [wMonType], a
	call GetGender
	ld a, " "
	jr c, .got_gender
	ld a, "<MALE>"
	jr nz, .got_gender
	inc a ; "<FEMALE>"

.got_gender
	pop hl
	ld [hli], a
	pop af
	ld [wCurPartyMon], a

.next
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop

	ld a, CGB_PARTY_MENU
	jp GetCGBLayout

PlacePartyMonRemindable:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 12, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld hl, wPartySpecies
	ld e, b
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	farcall GetForgottenMoves
	pop hl
	call .PlaceAbleNotAble
	rst PlaceString

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

.PlaceAbleNotAble:
	ld a, c
	and a
	jr nz, .able
	ld de, .string_not_able
	ret

.able
	ld de, .string_able
	ret

.string_able
	db "Able@"

.string_not_able
	db "Not able@"

PartyMenuCheckEgg:
	push hl
	ld a, b
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	pop hl
	ret

GetPartyMenuTilemapPointers:
	ld a, [wPartyMenuActionText]
	and $f0
	jr nz, .skip
	ld a, [wPartyMenuActionText]
	and $f
	ld e, a
	ld d, 0
	ld hl, PartyMenuQualityPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.skip
	ld hl, PartyMenuQualityPointers.Default
	ret

INCLUDE "data/party_menu_qualities.asm"

InitPartyMenuGFX:
	ld hl, wPartyCount
	ld a, [hli]
	and a
	ret z
	ld c, a
	xor a
	ldh [hObjectStructIndexBuffer], a
.loop
	push bc
	push hl
	farcall LoadPartyMenuMonIcon
	ldh a, [hObjectStructIndexBuffer]
	inc a
	ldh [hObjectStructIndexBuffer], a
	pop hl
	pop bc
	dec c
	jr nz, .loop
	farjp PlaySpriteAnimations

InitPartyMenuWithCancel:
; with cancel
	xor a
	ld [wSwitchMon], a
	ld de, PartyMenuAttributes
	call SetMenuAttributes
	ld a, [wPartyCount]
	inc a
	ld [w2DMenuNumRows], a ; list length
	dec a
	ld b, a
	ld a, [wPartyMenuCursor]
	and a
	jr z, .skip
	inc b
	cp b
	jr c, .done

.skip
	ld a, 1

.done
	ld [wMenuCursorY], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ret

InitPartyMenuNoCancel:
; no cancel
	ld de, PartyMenuAttributes
	call SetMenuAttributes
	ld a, [wPartyCount]
	ld [w2DMenuNumRows], a ; list length
	ld b, a
	ld a, [wPartyMenuCursor]
	and a
	jr z, .skip
	inc b
	cp b
	jr c, .done
.skip
	ld a, 1
.done
	ld [wMenuCursorY], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ret

PartyMenuAttributes:
; cursor y
; cursor x
; num rows
; num cols
; bit 6: animate sprites  bit 5: wrap around
; ?
; distance between items (hi: y, lo: x)
; allowed buttons (mask)
	db 1, 0
	db 0, 1
	db $60, $00
	dn 2, 0
	db 0

PartyMenuSelect:
; sets carry if exitted menu.
	call DoMenuJoypadLoop
	call PlaceHollowCursor
	ld a, [wPartyCount]
	inc a
	ld b, a
	ld a, [wMenuCursorY] ; menu selection?
	cp b
	jr z, .exitmenu ; CANCEL
	ld [wPartyMenuCursor], a
	ldh a, [hJoyLast]
	ld b, a
	bit B_BUTTON_F, b
	jr nz, .exitmenu ; B button
	ld a, [wMenuCursorY]
	dec a
	ld [wCurPartyMon], a
	ld c, a
	ld b, $0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a

	ld de, SFX_READ_TEXT_2
	call PlaySFX
	push bc
	call SFXDelay2
	pop bc
	and a
	ret

.exitmenu
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	push bc
	call SFXDelay2
	pop bc
	scf
	ret

PrintPartyMenuText:
	hlcoord 0, 14
	lb bc, 2, 18
	call TextBox
	ld a, [wPartyCount]
	and a
	jr nz, .haspokemon
	ld de, YouHaveNoPKMNString
	jr .gotstring
.haspokemon
	ld a, [wPartyMenuActionText]
	and $f ; drop high nibble
	ld hl, PartyMenuStrings
	ld e, a
	ld d, $0
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
.gotstring
	ld a, [wOptions1]
	push af
	set NO_TEXT_SCROLL, a ; disable text delay
	ld [wOptions1], a
	hlcoord 1, 16 ; Coord
	rst PlaceString
	pop af
	ld [wOptions1], a
	ret

PartyMenuStrings:
; needs to match PartyMenuQualityPointers
	dw ChooseAMonString
	dw UseOnWhichPKMNString
	dw WhichPKMNString
	dw TeachWhichPKMNString
	dw MoveToWhereString
	dw UseOnWhichPKMNString
	dw ChooseAMonString ; Probably used to be ChooseAFemalePKMNString
	dw ChooseAMonString ; Probably used to be ChooseAMalePKMNString
	dw ToWhichPKMNString
	dw TutorWhichPKMNString

ChooseAMonString:
	db "Choose a #mon.@"
UseOnWhichPKMNString:
	db "Use on which <PK><MN>?@"
WhichPKMNString:
	db "Which <PK><MN>?@"
TeachWhichPKMNString:
	db "Teach which <PK><MN>?@"
TutorWhichPKMNString:
	db "Tutor which <PK><MN>?@"
MoveToWhereString:
	db "Move to where?@"
ToWhichPKMNString:
	db "To which <PK><MN>?@"

YouHaveNoPKMNString:
	db "You have no <PK><MN>!@"

PrintPartyMenuActionText:
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld a, [wPartyMenuActionText]
	and $f
	ld hl, .MenuActionTexts
	jp .PrintText

.MenuActionTexts:
	dw .Text_CuredOfPoison
	dw .Text_BurnWasHealed
	dw .Text_Defrosted
	dw .Text_WokeUp
	dw .Text_RidOfParalysis
	dw .Text_RecoveredSomeHP
	dw .Text_HealthReturned
	dw .Text_Revitalized
	dw .Text_GrewToLevel
	dw .Text_CameToItsSenses

.Text_RecoveredSomeHP:
	; recovered @ HP!
	text_jump UnknownText_0x1bc0a2
	text_end

.Text_CuredOfPoison:
	; 's cured of poison.
	text_jump UnknownText_0x1bc0bb
	text_end

.Text_RidOfParalysis:
	; 's rid of paralysis.
	text_jump UnknownText_0x1bc0d2
	text_end

.Text_BurnWasHealed:
	; 's burn was healed.
	text_jump UnknownText_0x1bc0ea
	text_end

.Text_Defrosted:
	; was defrosted.
	text_jump UnknownText_0x1bc101
	text_end

.Text_WokeUp:
	; woke up.
	text_jump UnknownText_0x1bc115
	text_end

.Text_HealthReturned:
	; 's health returned.
	text_jump UnknownText_0x1bc123
	text_end

.Text_Revitalized:
	; is revitalized.
	text_jump UnknownText_0x1bc13a
	text_end

.Text_GrewToLevel:
	; grew to level @ !@ @
	text_jump UnknownText_0x1bc14f
	text_end

.Text_CameToItsSenses:
	; came to its senses.
	text_jump UnknownText_0x1bc16e
	text_end

.PrintText:
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wOptions1]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions1], a
	call PrintText
	pop af
	ld [wOptions1], a
	ret
