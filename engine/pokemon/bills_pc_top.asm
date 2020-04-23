_BillsPC:
	call .CheckCanUsePC
	ret c
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, 91
	ldh [rLYC], a
	call UseBillsPC
	pop af
	ld [wOptions1], a
	jp .LogOut

.CheckCanUsePC:
	ld a, [wPartyCount]
	and a
	ret nz
	ld hl, .Text_GottaHavePokemon
	call MenuTextboxBackup
	scf
	ret

.Text_GottaHavePokemon:
	; You gotta have #MON to call!
	text_jump _PCGottaHavePokemonText
	text_end

.LogIn:
	call LoadStandardMenuHeader
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	call ClearPCItemScreen
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld hl, .Text_What
	call PrintText
	pop af
	ld [wOptions1], a
	jp LoadFontsBattleExtra

.Text_What:
	; What?
	text_jump _PCWhatText
	text_end

.LogOut:
	jp CloseSubmenu

.OldUseBillsPC:
	ld hl, .MenuDataHeader
	call LoadMenuHeader
	ld a, $1
.loop
	ld [wMenuCursorBuffer], a
	call SetPalettes
	xor a
	ld [wWhichIndexSet], a
	ldh [hBGMapMode], a
	call DoNthMenu
	jr c, .cancel
	ld a, [wMenuCursorBuffer]
	push af
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	call JumpTable
	pop bc
	ld a, b
	jr nc, .loop
.cancel
	jp CloseWindow

.MenuDataHeader:
	db $40 ; flags
	db 00, 00 ; start coords
	db 17, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 0 ; items
	dw .items
	dw PlaceMenuStrings
	dw .strings

.strings
	db "Withdraw <PK><MN>@"
	db "Deposit <PK><MN>@"
	db "Change Box@"
	db "Move <PK><MN> w/o Mail@"
	db "See ya!@"

.Jumptable:
	dw BillsPC_WithdrawMenu
	dw BillsPC_DepositMenu
	dw BillsPC_ChangeBoxMenu
	dw BillsPC_MovePKMNMenu
	dw BillsPC_SeeYa

.items
	db 5
	db 0 ; WITHDRAW
	db 1;  DEPOSIT
	db 2 ; CHANGE BOX
	db 3 ; MOVE PKMN
	db 4 ; SEE YA!
	db -1

UseBillsPC:
	call LoadStandardMenuHeader
	call ClearTileMap
	call ClearPalettes
	farcall WipeAttrMap

	ld b, BANK(.Tiles)
	ld de, .Tiles
	ld hl, vTiles2 tile $31
	ld c, 15
	call Get2bpp

	; Reserve 4 blank tiles for empty slots
	ld a, 1
	ldh [rVBK], a
	ld hl, vTiles3
	ld de, vTiles5 tile $7f
	push hl
	push hl
	ld c, 1
	call Get2bpp
	pop de
	pop hl
	ld bc, 1 tiles
	add hl, bc
	push hl
	push de
	ld c, 1
	call Get2bpp
	pop de
	pop hl
	ld bc, 1 tiles
	add hl, bc
	ld c, 2
	call Get2bpp
	xor a
	ld [rVBK], a

	ld a, 1
	ldh [rVBK], a
	call SetPartyIcons
	call SetBoxIcons
	xor a
	ldh [rVBK], a

	; Poképic
	hlcoord 0, 0
	farcall PlaceFrontpicAtHL

	; Storage box
	hlcoord 7, 4
	lb bc, 12, 11
	ld de, .BoxTiles
	call .Box

	; Seperator between box name and content
	hlcoord 7, 6
	lb bc, $3e, 11
	call .SpecialRow

	; Party box
	hlcoord 0, 9
	lb bc, 7, 5
	ld de, .PartyTiles
	call .Box

	; Party label borders
	hlcoord 0, 10
	lb bc, $36, 5
	call .SpecialRow

	; Party label text
	hlcoord 2, 9
	ld a, $38
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	hlcoord 2, 10
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a

	; Write icon tilemaps
	; Party
	hlcoord 1, 11
	lb bc, 3, 2
	lb de, $80, 2 | TILE_BANK
	call .WriteIconTilemap

	; Storage
	hlcoord 8, 7
	lb bc, 5, 4
	lb de, $98, 4 | TILE_BANK
	call .WriteIconTilemap

	ld a, CGB_BILLS_PC
	call GetCGBLayout
	call SetPalettes

	ld b, 2
	call SafeCopyTilemapAtOnce

	call ManageBoxes

	hlcoord 0, 8
	ld de, .TestStr
	call PlaceString

	ld hl, rIE
	res LCD_STAT, [hl]
	ld a, -1
	ldh [hMPState], a
	ld c, 240
	call DelayFrames
	ret
.TestStr
	db "100@"

.Box:
; draws a box with tiles and attributes
	push bc
	push hl
	call CreateBoxBorders
	pop hl
	ld bc, wAttrMap - wTileMap
	add hl, bc
	pop bc
	ld de, .BoxAttr
	jp CreateBoxBorders

.BoxTiles:
	db $33, $32, $33 ; top
	db $31, $7f, $31 ; middle
	db $33, $32, $33 ; bottom
.PartyTiles:
	db $35, $34, $35 ; top
	db $31, $7f, $31 ; middle
	db $33, $32, $33 ; bottom
.BoxAttr:
	db 1, 1, 1 | X_FLIP ; top
	db 1, 2 | TILE_BANK, 1 | X_FLIP ; middle
	db 1 | Y_FLIP, 1 | Y_FLIP, 1 | X_FLIP | Y_FLIP ; bottom

.SpecialRow:
; draws a nonstandard box outline
	ld a, b
	ld [hli], a
	inc a
	ld b, 0
	push bc
	push hl
	rst ByteFill
	dec a
	ld [hl], a
	pop hl
	ld bc, wAttrMap - wTileMap
	add hl, bc
	pop bc
	ld a, 1
	rst ByteFill
	ret

.WriteIconTilemap:
; writes icon tile+attr data for b rows, c cols starting from hlcoord, tile a
	ld a, d
.tile_row
	push bc
	push de
	push hl
.tile_col
	call .icon
	dec c
	jr nz, .tile_col
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop de
	pop bc
	dec b
	jr nz, .tile_row
	ret

.icon
	push bc
	ld [hli], a
	inc a
	ld [hld], a
	inc a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	inc a
	ld [hld], a
	inc a
	ld bc, -SCREEN_WIDTH + (wAttrMap - wTileMap)
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], e
	ld bc, SCREEN_WIDTH - 1
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], e
	inc e
	ld bc, -SCREEN_WIDTH + 2 + (wTileMap - wAttrMap)
	add hl, bc
	pop bc
	ret

.Tiles
BillsPC_Tiles:
	dw `01223333
	dw `01223333
	dw `01223333
	dw `01223333
	dw `01223333
	dw `01223333
	dw `01223333
	dw `01223333

	dw `00000000
	dw `11111111
	dw `22222222
	dw `22222222
	dw `33333333
	dw `33333333
	dw `33333333
	dw `33333333

	dw `00000000
	dw `00011111
	dw `00122222
	dw `01222222
	dw `01222333
	dw `01223333
	dw `01223333
	dw `01223333

	dw `00000000
	dw `11111111
	dw `22222222
	dw `22222222
	dw `22222222
	dw `22222222
	dw `22222222
	dw `22222222

	dw `00000000
	dw `00011111
	dw `00122222
	dw `01222222
	dw `01222222
	dw `01222222
	dw `01222222
	dw `01222222

	dw `01222222
	dw `01222222
	dw `01222222
	dw `01222222
	dw `01222333
	dw `01223333
	dw `01223333
	dw `01223333

	dw `22222222
	dw `22222222
	dw `22222222
	dw `22222222
	dw `33333333
	dw `33333333
	dw `33333333
	dw `33333333

	dw `00000000
	dw `11111111
	dw `22222222
	dw `22222222
	dw `23332222
	dw `23223222
	dw `23223223
	dw `23332232

	dw `00000000
	dw `11111111
	dw `22222222
	dw `22222222
	dw `22222222
	dw `22222222
	dw `33232323
	dw `23233222

	dw `00000000
	dw `11111111
	dw `22222222
	dw `22222222
	dw `22222222
	dw `32222222
	dw `33232232
	dw `32232232

	dw `23222232
	dw `23222223
	dw `22222222
	dw `22222222
	dw `33333333
	dw `33333333
	dw `33333333
	dw `33333333

	dw `33232222
	dw `23232222
	dw `22222222
	dw `22222222
	dw `33333333
	dw `33333333
	dw `33333333
	dw `33333333

	dw `32223332
	dw `33222232
	dw `22233322
	dw `22222222
	dw `33333333
	dw `33333333
	dw `33333333
	dw `33333333

	dw `01223333
	dw `01222333
	dw `01222222
	dw `01222222
	dw `01111111
	dw `01222222
	dw `01222222
	dw `01222333

	dw `33333333
	dw `33333333
	dw `22222222
	dw `22222222
	dw `11111111
	dw `22222222
	dw `22222222
	dw `33333333



BillsPC_SeeYa:
	scf
	ret

BillsPC_BlankTiles:
	ld de, vTiles3 tile $00
	ld bc, 4 tiles
.loop
	push hl
	push de
	push bc
	push af
	ld c, 4
	call Get2bpp
	pop af
	pop bc
	pop de
	pop hl
	add hl, bc
	dec a
	jr nz, .loop
	ret

SetPartyIcons:
; Writes party list
	; Blank current list
	xor a
	ld hl, wBillsPC_PartyList
	ld bc, PARTY_LENGTH * 2
	rst ByteFill

	ld hl, vTiles4 tile $00
	ld a, PARTY_LENGTH
	call BillsPC_BlankTiles

	; Write party members
	ld a, [wPartyCount]
	ld b, a
	ld de, wPartyMons - (wPartyMon2 - wPartyMon1Form)
	ld hl, wBillsPC_PartyList
	ld c, $80
.loop
	ld a, wPartyMon2 - wPartyMon1Form
	call .insert
	ld [wCurIcon], a
	ld a, wPartyMon1Form - wPartyMon1
	call .insert
	ld [wCurIconForm], a
	ld a, c
	push hl
	push de
	push bc
	farcall GetStorageIcon_a
	pop bc
	pop de
	pop hl
	ld a, c
	add 4
	ld c, a
	dec b
	jr nz, .loop
	ret

.insert
	; de = de + a
	add e
	ld e, a
	adc d
	sub e
	ld d, a

	ld a, [de]
	ld [hli], a
	ret

SetBoxIcons:
	; Blank current list
	xor a
	ld hl, wBillsPC_BoxList
	ld bc, MONS_PER_BOX * 2
	rst ByteFill

	ld hl, vTiles4 tile $18
	ld a, MONS_PER_BOX
	call BillsPC_BlankTiles

	; Write box members
	ld a, [wCurBox]
	inc a
	ld b, a
	ld c, 1
	ld hl, wBillsPC_BoxList
	ld d, 20
	ld e, $98
.loop
	call GetStorageBoxMon
	jr z, .empty
	ld a, [wBufferMon]
	ld [wCurIcon], a
	ld [hli], a
	ld a, [wBufferMonForm]
	ld [wCurIconForm], a
	ld a, e
	push hl
	push de
	push bc
	farcall GetStorageIcon_a
	pop bc
	pop de
	pop hl
	jr .next
.empty
.next
	ld a, e
	add 4
	ld e, a
	inc c
	dec d
	jr nz, .loop
	ret

ManageBoxes:
; Main box management function
	; Load active box
	call DisplayBox

DisplayBox:
	ret

BillsPC_MovePKMNMenu:
	call LoadStandardMenuHeader
	farcall IsAnyMonHoldingMail
	jr nc, .no_mail
	ld hl, .Text_MonHoldingMail
	call PrintText
	jr .quit

.no_mail
	farcall StartMovePkmnWOMail_SaveGame
	jr c, .quit
	farcall _MovePKMNWithoutMail
	call ReturnToMapFromSubmenu
	call ClearPCItemScreen

.quit
	call CloseWindow
	and a
	ret

.Text_MonHoldingMail:
	; There is a #MON holding MAIL. Please remove the MAIL.
	text_jump _PCMonHoldingMailText
	text_end

BillsPC_DepositMenu:
	call LoadStandardMenuHeader
	farcall _DepositPKMN
	call ReturnToMapFromSubmenu
	call ClearPCItemScreen
	call CloseWindow
	and a
	ret

CheckCurPartyMonFainted:
	ld hl, wPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH
	ld b, $0
.loop
	ld a, [wCurPartyMon]
	cp b
	jr z, .skip
	ld a, [hli]
	or [hl]
	jr nz, .notfainted
	dec hl

.skip
	inc b
	ld a, [wPartyCount]
	cp b
	jr z, .done
	add hl, de
	jr .loop

.done
	scf
	ret

.notfainted
	and a
	ret

BillsPC_WithdrawMenu:
	call LoadStandardMenuHeader
	farcall _WithdrawPKMN
	call ReturnToMapFromSubmenu
	call ClearPCItemScreen
	call CloseWindow
	and a
	ret

BillsPC_ChangeBoxMenu:
	farcall _ChangeBox
	and a
	ret

ClearPCItemScreen:
	call DisableSpriteUpdates
	xor a
	ldh [hBGMapMode], a
	call ClearBGPalettes
	call ClearSprites
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	ld a, " "
	rst ByteFill
	hlcoord 0, 0
	lb bc, 10, 18
	call Textbox
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	call ApplyAttrAndTilemapInVBlank
	jp SetPalettes ; load regular palettes?

CopyBoxmonToTempMon:
	ld a, [wCurPartyMon]
	ld hl, sBoxMon1Species
	ld bc, BOXMON_STRUCT_LENGTH
	rst AddNTimes
	ld de, wTempMonSpecies
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, BANK(sBoxMon1Species)
	call GetSRAMBank
	rst CopyBytes
	jp CloseSRAM

InitializeBoxes:
; Initializes the Storage System boxes as empty with default names.
	ld a, BANK(sNewBox1)
	call GetSRAMBank
	ld b, NUM_NEWBOXES
	ld hl, sNewBox1
.loop
	push bc
	ld bc, sNewBox1Name - sNewBox1
	xor a
	rst ByteFill
	push hl
	ld de, .Box
	call CopyName2
	dec hl
	ld a, b
	sub 10
	add "0" + 10
	ld [hl], a
	jr c, .next
	sub 10
	ld [hld], a
	ld [hl], "1"
.next
	pop hl
	ld c, sNewBox2 - sNewBox1Name
	add hl, bc
	pop bc
	dec b
	jr nz, .loop
	jp CloseSRAM

.Box:
	rawchar "Box   @"

SetBoxPointer:
; Set box b slot c to point to pokémon storage bank d, entry e.
	push hl
	push de
	push bc
	ld a, BANK(sNewBox1)
	call GetSRAMBank

	; Locate the correct Box
	ld hl, sNewBox1
	ld a, b
	dec a
	push bc
	ld bc, sNewBox2 - sNewBox1
	rst AddNTimes
	pop bc

	; Write entry
	push hl
	ld b, 0
	dec c
	add hl, bc
	ld [hl], e
	pop hl

	; Write 1 to bank flag array if entry is in storage bank 2, 0 otherwise
	ld a, c
	ld bc, sNewBox1Banks - sNewBox1
	add hl, bc
	ld c, a
	ld b, RESET_FLAG
	dec d
	jr z, .got_flag_setup
	ld b, SET_FLAG
.got_flag_setup
	predef FlagPredef
	jp PopBCDEHL

GetStorageBoxMon:
; Reads storage bank+entry from box b slot c and put it in wBufferMon.
; If there is a checksum error, put Bad Egg data in wBufferMon instead.
; Returns c in case of a Bad Egg, z if the requested mon doesn't exist,
; nz|nc otherwise.
	; TODO: DON'T READ LEGACY SAVE DATA
	push hl
	push de
	push bc
	dec b
	dec c
	ld a, b
	sub 7
	ld d, BANK(sBox1)
	jr c, .got_save_bank
	ld b, a
	ld d, BANK(sBox8)
.got_save_bank
	ld a, d
	call GetSRAMBank
	ld d, b
	ld e, c
	ld bc, sBox2 - sBox1
	ld a, d
	ld hl, sBox1
	rst AddNTimes
	ld a, e
	cp [hl]
	jr c, .not_empty
	xor a
	jr .done
.not_empty
	ld bc, sBox1Mons - sBox1
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld de, wBufferMon
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes
	or 1
.done
	pop bc
	pop de
	pop hl
	jp CloseSRAM

GetStorageMon:
; Reads storage bank d, entry e and put it in wBufferMon.
; If there is a checksum error, put Bad Egg data in wBufferMon instead.
; Returns c in case of a Bad Egg, z if the requested mon doesn't exist,
; nz|nc otherwise.
	ld a, d
	dec a
	ld a, BANK(sBoxMons1)
	jr z, .got_bank
	ld a, BANK(sBoxMons2)
.got_bank
	call GetSRAMBank

	; Check if entry is allocated.
	push hl
	push de
	push bc
	ld b, CHECK_FLAG
	ld c, e
	dec c
	ld hl, sBoxMons1UsedEntries
	ld d, 0
	predef FlagPredef
	jr z, .done ; entry not found

	; Get the correct pointer
	ld hl, sBoxMons1Mons
	ld bc, SAVEMON_STRUCT_LENGTH
	ld a, e
	dec a
	rst AddNTimes

	; Write to wBufferMon
	ld de, wBufferMon
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes
	ld de, wBufferMonNick
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	ld de, wBufferMonOT
	ld bc, NAME_LENGTH - 1
	rst CopyBytes

	; Decode the resulting wBufferMon. This also returns a
	; Bad Egg failsafe on a checksum error.
	call DecodeBufferMon
.done
	jp PopBCDEHL

NewStorageMon:
; Writes Pokémon from wBufferMon to free space in storage, if there
; is space. Returns z on success with storage bank d, entry e.
; Returns z if the storage is full, otherwise nz with de pointing to
; bank and entry.
	push bc
	push hl
	ld a, BANK(sBoxMons1)
	ld de, 0
	call .check_entries
	ld a, BANK(sBoxMons2)
	call z, .check_entries
	ld d, e
	ld e, c
	pop hl
	pop bc
	jp z, CloseSRAM
	inc e
	jr _NewStorageMon

.check_entries
	inc e
	call GetSRAMBank
	lb bc, CHECK_FLAG, 0
	ld hl, sBoxMons1UsedEntries
.loop
	push bc
	predef FlagPredef
	pop bc
	ret nz

	; This isn't an off-by-1 error. We have 157 entries, but flags are 0-156.
	inc c
	ld a, c
	cp MONDB_ENTRIES
	ret z
	jr .loop

_NewStorageMon:
; Writes Pokémon from wBufferMon to storage bank d, entry e. Does not
; verify that the space is empty -- if you want that, you probably want
; NewStorageMon (without underline) which finds an unused de to run this.
; Returns nz (denoting successful write into the storage list).
	push hl
	push bc
	push de
	call EncodeBufferMon
	pop de

	; Check which SRAM bank to use
	ld a, d
	dec a
	ld a, BANK(sBoxMons1)
	jr z, .got_bank
	ld a, BANK(sBoxMons2)
.got_bank
	call GetSRAMBank

	; Get Pokémon location
	ld hl, sBoxMons1
	ld b, 0
	ld c, e
	dec c
	ld a, SAVEMON_STRUCT_LENGTH
	rst AddNTimes

	; Write to location
	push de
	ld d, h
	ld e, l
	ld hl, wBufferMon
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes
	ld hl, wBufferMonNick
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	ld hl, wBufferMonOT
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	pop de
	push de

	; Mark location as used
	ld hl, sBoxMons1UsedEntries
	ld c, e
	dec c
	ld b, SET_FLAG
	predef FlagPredef
	pop de
	pop bc
	pop hl
	or 1
	jp CloseSRAM

DecodeBufferMon:
; Decodes BufferMon. Returns nz. Sets carry in case of invalid checksum.
	; First, run a checksum check. Don't use the result until we've done
	; character replacements back to their original state
	call ChecksumBufferMon
	push af

	; Convert 7bit nicknames back to their origianl state.
	ld hl, wBufferMonNick
	ld b, MON_NAME_LENGTH - 1
	call .Prepare
	ld hl, wBufferMonOT
	ld b, PLAYER_NAME_LENGTH - 1
	call .Prepare

	; Shift unused OT bytes
	ld hl, wBufferMonOT + NAME_LENGTH
	ld d, h
	ld e, l
	dec de
	ld a, [de]
	ld [hld], a
	dec de
	ld a, [de]
	ld [hld], a
	dec de
	ld a, [de]
	ld [hld], a

	; Add nickname terminators
	ld [hl], "@" ; OTname terminator
	ld hl, wBufferMonNick + MON_NAME_LENGTH - 1
	ld [hl], "@"

	; Now we have a complete decoded boxmon struct with names.
	; If checksum was incorrect, replace data with one for Bad Egg.
	pop af
	jr z, .set_partymon_data

	call SetBadEgg
	call .set_partymon_data
	scf
	ret

.set_partymon_data
	; Calculate stats
	ld hl, wBufferMonOT + PLAYER_NAME_LENGTH
	ld a, [hl]
	and HYPER_TRAINING_MASK
	inc a
	ld b, a
	ld hl, wBufferMonEVs - 1
	ld de, wBufferMonMaxHP
	predef CalcPkmnStats

	; Set HP to full
	ld hl, wBufferMonMaxHP
	ld de, wBufferMonHP
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a

	; Eggs have 0 current HP
	ld hl, wBufferMonIsEgg
	bit MON_IS_EGG_F, [hl]
	jr z, .not_egg
	xor a
	ld [de], a
	dec de
	ld [de], a

.not_egg
	ld hl, wBufferMonMoves
	ld de, wBufferMonPP
	predef FillPP
	or 1
	ret

.Prepare:
	ld a, [hl]
	or $80
	ld c, $7f
	cp $fa
	jr z, .replace
	ld c, "@"
	cp $fb
	jr z, .replace
	ld c, 0
	cp $fc
	jr nz, .setchar
.replace
	ld a, c
.setchar
	ld [hli], a
	dec b
	jr nz, .Prepare
	ret

SetBadEgg:
	; Load failsafe data into the BufferMon pokémon struct
	ld hl, wBufferMon
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, 1
	rst ByteFill

	; Set data that can't be 1 to other things
	xor a
	ld hl, wBufferMonItem
	ld [hl], a
	ld hl, wBufferMonMoves + 1
	ld bc, NUM_MOVES - 1
	rst ByteFill
	ld hl, wBufferMonPersonality
	ld [hl], ABILITY_1 | QUIRKY
	inc hl
	ld [hl], MALE | IS_EGG_MASK | 1
	ld hl, wBufferMonHappiness ; egg cycles
	ld [hl], 255
	ld hl, wBufferMonExp
	ld c, 3
	rst ByteFill

	; Set nickname fields
	ld hl, wBufferMonNick
	ld de, .BadEgg
	call CopyName2
	ld hl, wBufferMonOT
	ld [hl], "?"
	inc hl
	ld [hl], "@"
	ret

.BadEgg:
	rawchar "Bad Egg@"

EncodeBufferMon:
; Encodes BufferMon to prepare for storage
	; Shift unused OT bytes
	ld hl, wBufferMonOT + PLAYER_NAME_LENGTH
	ld d, h
	ld e, l
	dec de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a

	; Convert nicknames to 7bit
	ld hl, wBufferMonNick
	ld b, MON_NAME_LENGTH - 1
	call .Prepare
	ld hl, wBufferMonOT
	ld b, PLAYER_NAME_LENGTH - 1
	call .Prepare

	jr ChecksumBufferMon

.Prepare:
	ld a, [hl]
	ld c, $fa
	cp $7f
	jr z, .replace
	inc c
	cp "@"
	jr z, .replace
	inc c
	and a
	jr nz, .removebit
.replace
	ld a, c
.removebit
	and $7f
	ld [hli], a
	dec b
	jr nz, .Prepare
	ret

ChecksumBufferMon:
; Calculate and write a checksum and to BufferMon. Use a nonzero baseline to
; avoid a complete null content from having 0 as a checksum.
; Returns z if an existing checksum is identical to the written checksum.
	; boxmon struct
	ld bc, wBufferMon
	ld hl, 127
	lb de, BOXMON_STRUCT_LENGTH, 0
	call .DoChecksum

	; extra bytes in otname
	ld bc, wBufferMonOT + PLAYER_NAME_LENGTH - 1
	ld d, 3
	call .DoChecksum

	; nickname (7bit only)
	ld bc, wBufferMonNick
	ld d, $80 | MON_NAME_LENGTH - 1
	call .DoChecksum

	; otname (7bit only)
	ld bc, wBufferMonOT
	ld d, $80 | MON_NAME_LENGTH - 1
	call .DoChecksum

	; Compare and write the result
	ld d, h
	ld e, l

	; Checksum is 16bit, further ones are padded with zeroes.
	; The padding being nonzero is also counted as invalid.
	ld b, 0 ; used for checksum error detection
	ld hl, wBufferMonNick
	ld c, MON_NAME_LENGTH - 1
	call .WriteChecksum
	ld hl, wBufferMonOT
	ld c, PLAYER_NAME_LENGTH - 1
.WriteChecksum:
	ld a, [hl]
	and $7f
	sla e
	rl d
	jr nc, .not_set
	or $80
.not_set
	cp [hl]
	ld [hli], a
	jr z, .checksum_valid
	inc b
.checksum_valid
	dec c
	jr nz, .WriteChecksum
	ld a, b
	and a
	ret

.DoChecksum:
	inc e
	dec d
	bit 6, d
	ret nz
	ld a, [bc]
	inc bc
	bit 7, d
	jr z, .not_7bit
	and $7f
.not_7bit
	push bc
	ld b, 0
	ld c, a
	ld a, e
	rst AddNTimes
	pop bc
	jr .DoChecksum
