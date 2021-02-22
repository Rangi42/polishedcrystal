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

NewStorageBoxPointer:
; Sets bc to an unused box storage location. Clobbers wTempMon. Returns:
; nc|z: Active box has free space
; nc|nz: Active box full, space found elsewhere
; c|z: Storage System filled completely.
; c|nz: Storage System has space, but the database is full. Save to free space.
	; First, figure out if we have space in the storage system.

	; Check active box.
	ld a, [wCurBox]
	inc a
	ld b, a
	ld d, NUM_NEWBOXES
.outer_loop
	ld c, 1
.inner_loop
	call GetStorageBoxMon
	jr z, .found_free_space
	inc c
	ld a, c
	cp MONS_PER_BOX + 1
	jr nz, .inner_loop
	inc b
	ld a, b
	cp NUM_NEWBOXES + 1
	jr nz, .dont_wrap_box
	ld b, 1
.dont_wrap_box
	dec d
	jr nz, .outer_loop

	; Storage system completely filled.
	scf
	ret

.found_free_space
	; Check if there's a free database entry.
	call NewStoragePointer
	jr nc, .storage_ok

	; If we still have no space left, we need to save.
	or 1
	scf
	ret

.storage_ok
	; Returns z if the new storage was found in our active box, nz otherwise.
	ld a, [wCurBox]
	inc a
	cp b
	ret

NewStoragePointer:
; Sets de to an unused pokedb entry. Clobbers wTempMon. Returns c if none
; was found.
	; Try twice, flushing the database if the first one failed.
	call .GetStorage
	ret nc
	call FlushStorageSystem
	; fallthrough
.GetStorage:
	ld d, 1
.outer_loop
	ld e, 1
.inner_loop
	call GetStorageMon
	jr z, .found_free_space
	inc e
	ld a, e
	cp MONDB_ENTRIES + 1
	jr nz, .inner_loop
	inc d
	ld a, d
	cp 3
	ccf
	jr nc, .outer_loop
	ret
.found_free_space
	xor a
	ret

FlushStorageSystem:
; Frees up orphaned pokedb entries.
	push hl
	push de
	push bc

	; Clear used pokedb entries.
	ld a, BANK(sBoxMons1)
	call .ClearEntries
	ld a, BANK(sBoxMons2)
	call .ClearEntries

	; Now, set flags as per box usage.
	ld hl, sNewBox1Entries
.loop
	ld d, NUM_NEWBOXES * 2 ; current + backup
	push hl
	push de
	call .SetUsedEntries
	pop de
	pop hl
	ld bc, sNewBox2 - sNewBox1
	add hl, bc
	dec d
	jr nz, .loop
	call CloseSRAM
	jp PopBCDEHL

.ClearEntries:
; Clears current pokedb allocations for storage bank a
	call GetSRAMBank
	xor a
	ld hl, sBoxMons1UsedEntries
	ld bc, sBoxMons1End - sBoxMons1UsedEntries
	rst ByteFill
	ret

.SetUsedEntries:
; Allocates all entries used by current box in hl.
	ld bc, sNewBox1Banks - sNewBox1Entries
	ld d, h
	ld e, l
	add hl, bc
	lb bc, MONS_PER_BOX, 0
	ld a, BANK(sNewBox1)
	call GetSRAMBank
.set_loop
	push de
	push bc
	ld a, [de]
	ld e, a
	ld d, 0
	and a
	jr z, .set_next

	; Check which pokedbbank the entry resides in.
	ld b, CHECK_FLAG
	predef FlagPredef
	ld a, BANK(sBoxMons1)
	jr z, .got_pokedb_bank
	ld a, BANK(sBoxMons2)
.got_pokedb_bank
	call GetSRAMBank

	; Mark the pokedb entry as used.
	push hl
	ld hl, sBoxMons1UsedEntries
	ld c, e
	dec c ; flags are 0-indexed
	ld b, SET_FLAG
	predef FlagPredef
	pop hl

	; Switch SRAM bank back to the newbox pointer table.
	ld a, BANK(sNewBox1)
	call GetSRAMBank
.set_next
	; Advance to next box entry.
	pop bc
	pop de
	inc de
	inc c
	dec b
	jr nz, .set_loop
	ret

CheckFreeDatabaseEntries:
; Returns amount of unused database entries left, or 255 if 255+. We don't
; really care if we have 255 or 314 entries left, only if we're running low.
	; Flush the storage system of duplicate entries.
	call FlushStorageSystem

	; Now, count used entries.
	ld a, BANK(sBoxMons1)
	call .CountEntries
	push bc
	ld a, BANK(sBoxMons2)
	call .CountEntries
	call CloseSRAM
	pop bc
	add c
	ret nc
	ld a, 255
	ret

.CountEntries:
	call GetSRAMBank
	ld hl, sBoxMons1UsedEntries
	ld b, (MONDB_ENTRIES + 7) / 8
	jp CountSetBits

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

AddStorageMon:
; Adds wTempMon to the storage system if possible.
; Returns z if the active box is full. Otherwise, returns nz with bcde
; pointing towards storage box, storage slot, mondb bank, mondb entry.
	; First check if the active box is full.
	ld a, [wCurBox]
	ld b, a
	inc b
	ld c, 1
.loop
	call GetStorageBoxMon
	jr z, .location_available
	ld a, c
	cp MONS_PER_BOX
	ret z
	inc c
	jr .loop

.location_available
	; Check if we can add a new entry
	call NewStorageMon
	ret z
	; Success! Fallthrough to set box pointer
SetBoxPointer:
; Set box b slot c to point to pokémon storage bank d, entry e.
; Returns nz (to denote success).
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
	or 1
	jp PopBCDEHL

GetStorageBoxMon:
; Reads storage bank+entry from box b slot c and put it in wTempMon.
; If there is a checksum error, put Bad Egg data in wTempMon instead.
; Returns c in case of a Bad Egg, z if the requested mon doesn't exist,
; nz|nc otherwise. If b==0, read from party list.
	; TODO: DON'T READ LEGACY SAVE DATA
	ld a, b
	and a
	jr z, .read_party
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
	push hl
	push de
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld de, wTempMon
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes
	pop de
	pop hl
	push hl
	push de
	ld bc, sBox1MonNicknames - sBox1Mons
	add hl, bc
	ld a, e
	call SkipNames
	ld de, wTempMonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	pop de
	pop hl
	ld bc, sBox1MonOT - sBox1Mons
	add hl, bc
	ld a, e
	call SkipNames
	ld de, wTempMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes
	or 1
.done
	pop bc
	pop de
	pop hl
	jp CloseSRAM
.read_party
	ld a, [wPartyCount]
	cp c
	jr nc, .party_not_empty
	xor a
	ret
.party_not_empty
	push hl
	push de
	push bc
	dec c
	ld d, b
	ld e, c
	ld hl, wPartyMons
	ld a, c
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	push de
	ld de, wTempMon
	ld c, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	pop de
	push de
	ld hl, wPartyMonNicknames
	ld a, e
	call SkipNames
	ld de, wTempMonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	pop de
	ld hl, wPartyMonOT
	ld a, e
	call SkipNames
	ld de, wTempMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes
	or 1
	jp PopBCDEHL

GetStorageMon:
; Reads storage bank d, entry e and put it in wTempMon.
; If there is a checksum error, put Bad Egg data in wTempMon instead.
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

	; Write to wTempMon
	ld de, wTempMon
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes
	ld de, wTempMonNickname
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	ld de, wTempMonOT
	ld bc, NAME_LENGTH - 1
	rst CopyBytes

	; Decode the resulting wTempMon. This also returns a
	; Bad Egg failsafe on a checksum error.
	call DecodeTempMon
.done
	jp PopBCDEHL

NewStorageMon:
; Writes Pokémon from wTempMon to free space in storage, if there
; is space. Returns nz on success with storage bank d, entry e.
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
; Writes Pokémon from wTempMon to storage bank d, entry e. Does not
; verify that the space is empty -- if you want that, you probably want
; NewStorageMon (without underline) which finds an unused de to run this.
; Returns nz (denoting successful write into the storage list).
	push hl
	push bc
	push de
	call EncodeTempMon
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
	ld hl, wTempMon
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes
	ld hl, wTempMonNickname
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	ld hl, wTempMonOT
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

DecodeTempMon:
; Decodes TempMon. Returns nz. Sets carry in case of invalid checksum.
	; First, run a checksum check. Don't use the result until we've done
	; character replacements back to their original state
	call ChecksumTempMon
	push af

	; Convert 7bit nicknames back to their origianl state.
	ld hl, wTempMonNickname
	ld b, MON_NAME_LENGTH - 1
	call .Prepare
	ld hl, wTempMonOT
	ld b, PLAYER_NAME_LENGTH - 1
	call .Prepare

	; Shift unused OT bytes
	ld hl, wTempMonOT + NAME_LENGTH
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
	ld hl, wTempMonNickname + MON_NAME_LENGTH - 1
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
	ld hl, wTempMonOT + PLAYER_NAME_LENGTH
	ld a, [hl]
	and HYPER_TRAINING_MASK
	inc a
	ld b, a
	ld hl, wTempMonEVs - 1
	ld de, wTempMonMaxHP
	predef CalcPkmnStats

	; Set HP to full
	ld hl, wTempMonMaxHP
	ld de, wTempMonHP
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a

	; Eggs have 0 current HP
	ld hl, wTempMonIsEgg
	bit MON_IS_EGG_F, [hl]
	jr z, .not_egg
	xor a
	ld [de], a
	dec de
	ld [de], a

.not_egg
	ld hl, wTempMonMoves
	ld de, wTempMonPP
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
	; Load failsafe data into the TempMon pokémon struct
	ld hl, wTempMon
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, 1
	rst ByteFill

	; Set data that can't be 1 to other things
	xor a
	ld hl, wTempMonItem
	ld [hl], a
	ld hl, wTempMonMoves + 1
	ld bc, NUM_MOVES - 1
	rst ByteFill
	ld hl, wTempMonPersonality
	ld [hl], ABILITY_1 | QUIRKY
	inc hl
	ld [hl], MALE | IS_EGG_MASK | 1
	ld hl, wTempMonHappiness ; egg cycles
	ld [hl], 255
	ld hl, wTempMonExp
	ld c, 3
	rst ByteFill

	; Set nickname fields
	ld hl, wTempMonNickname
	ld de, .BadEgg
	call CopyName2
	ld hl, wTempMonOT
	ld [hl], "?"
	inc hl
	ld [hl], "@"
	ret

.BadEgg:
	rawchar "Bad Egg@"

EncodeTempMon:
; Encodes TempMon to prepare for storage
	; Shift unused OT bytes
	ld hl, wTempMonOT + PLAYER_NAME_LENGTH
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
	ld hl, wTempMonNickname
	ld b, MON_NAME_LENGTH - 1
	call .Prepare
	ld hl, wTempMonOT
	ld b, PLAYER_NAME_LENGTH - 1
	call .Prepare

	jr ChecksumTempMon

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

ChecksumTempMon:
; Calculate and write a checksum and to TempMon. Use a nonzero baseline to
; avoid a complete null content from having 0 as a checksum.
; Returns z if an existing checksum is identical to the written checksum.
	; boxmon struct
	ld bc, wTempMon
	ld hl, 127
	lb de, BOXMON_STRUCT_LENGTH, 0
	call .DoChecksum

	; extra bytes in otname
	ld bc, wTempMonOT + PLAYER_NAME_LENGTH - 1
	ld d, 3
	call .DoChecksum

	; nickname (7bit only)
	ld bc, wTempMonNickname
	ld d, $80 | MON_NAME_LENGTH - 1
	call .DoChecksum

	; otname (7bit only)
	ld bc, wTempMonOT
	ld d, $80 | MON_NAME_LENGTH - 1
	call .DoChecksum

	; Compare and write the result
	ld d, h
	ld e, l

	; Checksum is 16bit, further ones are padded with zeroes.
	; The padding being nonzero is also counted as invalid.
	ld b, 0 ; used for checksum error detection
	ld hl, wTempMonNickname
	ld c, MON_NAME_LENGTH - 1
	call .WriteChecksum
	ld hl, wTempMonOT
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
