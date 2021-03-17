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

SwapStorageBoxSlots:
; Swaps slots from de to bc. Preserves de, while bc is changed to a proper slot
; if c is 0, otherwise preserved. Equivalent to bc->de except c may be 0 to mean
; "put anywhere in the party/box". Returns the following in a:
; 0: Successful swap
; 1: Save is required to perform the swap
; 2: The party is full
; 3: The box is full
; 4: Doing this would remove the last healthy mon in party
; 5: Can't move partymon to Box, because they're holding Mail.
	; Compare source->dest to see if we're "moving" something with itself.
	ld h, -1
	ld a, b
	cp d
	ld a, c
	jr nz, .not_equal
	ld h, e
	cp e
	jr nz, .not_equal
.done
	xor a
	ret
.not_equal
	; Convert destination slot 0 to a real destination, if we can.
	push de
	and a ; a is c from beforehand.
	jr nz, .got_dest

	ld e, PARTY_LENGTH
	ld a, b
	and a
	jr z, .dest_loop
	ld e, MONS_PER_BOX
.dest_loop
	inc c
	call GetStorageBoxMon
	jr z, .got_dest
	ld a, c
	cp h
	jr nz, .dest_next

	; We encountered our current entry while seeking for blank entries. This
	; basically makes this a no-op (since there's no earlier blank entry), so
	; return early.
	pop de
	jr .done

.dest_next
	cp e
	jr nz, .dest_loop

	; Party (or Box) is full
	pop de
	cp MONS_PER_BOX
	ld a, 2
	ret c
	inc a
	ret

.got_dest
	pop de

	; Now that we have proper slots, preserve bcde from this point.
	push de
	push bc
	call .do_it
	pop bc
	pop de
	ret

.do_it
	; If d<b, swap bc and de. The reason for this is that we want to handle
	; party->box movement the same way as box->party.
	ld a, d
	cp b
	jr nc, .dont_swap
	push bc
	ld b, d
	ld c, e
	pop de
.dont_swap
	; At this point, b<=d. So if d is party, we're swapping party members, and
	; if b is nonparty (i.e. >0), we're swapping between box slots.
	; Otherwise, we're swapping a party slot bc to box slot de.
	ld a, d
	and a
	jr z, .party_swap
	ld a, b
	and a
	jr nz, .box_swap

	; We're swapping a party and box slot. First, verify that we're not losing
	; our last healthy mon and that the partymon isn't holding Mail.
	push de
	push bc
	ld a, c

	; This is required for CheckCurPartyMonFainted
	dec a
	ld [wCurPartyMon], a

	; Is the party slot occupied? Also writes the partymon to wTempMon.
	call GetStorageBoxMon
	jr z, .not_last_healthy

	; Check if the partymon is holding Mail. We can't store Mail in a Box.
	ld a, [wTempMonItem]
	call ItemIsMail_a
	ld a, 5
	jr c, .pop_bcde_and_return

	; Otherwise, check if it is our last healthy mon.
	call CheckCurPartyMonFainted
	jr nc, .not_last_healthy

	; Doing this would lose us our last healthy mon, so abort.
	ld a, 4
.pop_bcde_and_return
	pop bc
	pop de
	ret

.not_last_healthy
	pop bc

	; Try to allocate a new pokedb pointer, unless the party slot was empty.
	ld de, 0 ; in case we're blanking the box slot
	ld a, [wTempMonSlot]
	and a
	call nz, NewStoragePointer
	jr nc, .found_new_pokedb

	; The pokedb is full, we need to save first.
	pop de
	ld a, 1
	ret

.found_new_pokedb
	call AddStorageMon

	; Get the current pokedb pointer in the box slot for writing to party.
	pop hl ; Box slot
	push bc ; Party slot
	ld b, h
	ld c, l
	push de ; New pokedb pointer
	call GetStorageBoxPointer
	ld h, d
	ld l, e
	pop de
	push hl ; Previous pokedb pointer
	call SetStorageBoxPointer

	; Now, write previous pointer to party, then we're done.
	pop de
	pop bc
	call SetStorageBoxPointer
	xor a
	ret

.party_swap
	; Check if we're placing a mon in a blank party slot. This means we're
	; shifting every other party member upwards, placing the held mon last.
	ld a, [wPartyCount]
	cp c
	jr c, .shift
	call SwapPartyMons
	xor a
	ret

.shift
	; Shift the held mon until it's last in the party.
	ld c, e
	call ShiftPartySlotToEnd
	xor a
	ret

.box_swap
	; Swaps 2 box pointers between box slot A in bc and slot B in de

	push de ; Slot B
	call GetStorageBoxPointer ; de = A's pointer
	pop hl ; hl = Slot B

	push bc ; Slot A
	ld b, h
	ld c, l ; bc = Slot B
	push de ; A's pointer
	call GetStorageBoxPointer ; de = B's pointer
	ld h, d
	ld l, e ; hl = B's pointer
	pop de ; de = A's pointer
	push hl
	call SetStorageBoxPointer ; Set Slot B (bc) to have A's pointer (de)
	pop de ; de = B's pointer
	pop bc ; bc = Slot A
	call SetStorageBoxPointer ; Set Slot A (bc) to have B's pointer (de)

	; We're done
	xor a
	ret

SwapPartyMonMail:
	push hl
	push de
	push bc
	dec c
	dec e
	ld d, c
	jr DoMailSwap

SwapPartyMons:
; Swap 1-indexed partymon c and e. Preserves bc, de, hl.
; TODO: this is more efficient than SwitchPartyMons, maybe make it use this.
	push hl
	push de
	push bc
	dec c
	dec e
	ld d, c

	; Swap species in the species array
	ld hl, wPartySpecies
	ld bc, 1
	call DoPartySwap

	; Swap partymon struct
	ld hl, wPartyMon1
	ld c, PARTYMON_STRUCT_LENGTH
	call DoPartySwap

	; Swap nickname
	ld hl, wPartyMonNicknames
	ld c, MON_NAME_LENGTH
	call DoPartySwap

	; Swap OT name
	ld hl, wPartyMonOT
	ld c, NAME_LENGTH
	call DoPartySwap

	; fallthrough
DoMailSwap:
	; Swap Mail
	ld a, BANK(sPartyMon1Mail)
	call GetSRAMBank
	ld hl, sPartyMon1Mail
	ld bc, MAIL_STRUCT_LENGTH
	call DoPartySwap
	call CloseSRAM
	jp PopBCDEHL
DoPartySwap:
; Swaps bc bytes between hl+d*bc and hl+e*bc
	; Get pointers to swap
	push de
	push hl
	ld a, d
	rst AddNTimes
	ld a, e
	ld d, h
	ld e, l
	pop hl
	rst AddNTimes
	; Now hl and de points to which bytes to swap

	push de
	ld de, wSwitchMonBuffer
	push bc
	push hl
	rst CopyBytes
	pop de
	pop bc
	pop hl
	push hl
	push bc
	rst CopyBytes
	pop bc
	pop de
	ld hl, wSwitchMonBuffer
	rst CopyBytes
	pop de
	ret

NewStorageBoxPointer:
; Sets bcde to an unused box storage location. Preserves wTempMon. Returns:
; nc|z: Active box has free space
; nc|nz: Active box full, space found elsewhere
; c|z: Storage System filled completely.
; c|nz: Storage System has space, but the database is full. Save to free space.
	; Figure out if we have space in the storage system. Check active box first,
	; then other boxes in sequence until we loop back to the active box. We loop
	; upwards, despite downwards generally being more efficient for UI benefit,
	; since we want to place mons starting at the beginning of a box, rather
	; than the end).
	ld a, [wCurBox]
	inc a
	ld b, a
	ld d, NUM_BOXES
.outer_loop
	ld c, 1
.inner_loop
	push de
	call GetStorageBoxPointer
	ld a, e
	pop de
	and a
	jr z, .found_free_space
	ld a, c
	inc c
	cp MONS_PER_BOX
	jr nz, .inner_loop
	ld a, b
	inc b
	cp NUM_BOXES
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
	; Always return nc.
	ld a, [wCurBox]
	inc a
	cp b
	ret z
	or 1
	ret

NewStoragePointer:
; Sets de to an unused pokedb entry. Returns c if none was found.
; Preserves wTempMon.
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
	call IsStorageUsed
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
; Frees up orphaned pokedb entries and reallocates used entries. Beware of soft-
; resets and make sure this process completes before loading up a game.
	push hl
	push de
	push bc

	; Clear used pokedb entries.
	ld a, BANK(sBoxMons1)
	call .ClearEntries
	ld a, BANK(sBoxMons2)
	call .ClearEntries

	; Now, set flags as per box usage.
	ld b, 1
.outer_loop
	ld c, 1
.inner_loop
	call GetStorageBoxPointer
	call _AllocateStorageFlag
	ld a, c
	inc c
	cp MONS_PER_BOX
	jr nz, .inner_loop
	ld a, b
	inc b
	cp NUM_BOXES * 2 ; current + backup
	jr nz, .outer_loop
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

GetStorageBoxPointer:
; Returns the pokedb bank+entry in de for box b, slot c.
	; Ensure that we're dealing with an actual box and not a partymon.
	ld a, b
	and a
	ld a, ERR_NEWBOX
	jp z, Crash

	ld a, BANK(sNewBox1)
	call GetSRAMBank

	push hl
	push bc
	ld a, b
	ld hl, sNewBox1Entries
	ld bc, sNewBox2 - sNewBox1
	dec a
	rst AddNTimes
	pop bc
	push bc
	dec c
	ld b, 0
	push hl
	add hl, bc
	ld e, [hl]
	pop hl
	ld c, sNewBox1Banks - sNewBox1Entries
	add hl, bc
	pop bc
	push bc
	dec c
	ld d, 1 ; will cause a useless bankswitch in flag checking, but that's OK
	ld b, CHECK_FLAG
	predef FlagPredef
	pop bc
	jr z, .got_bank
	inc d
.got_bank
	pop hl
	jp CloseSRAM

UpdateStorageBoxMonFromTemp:
; Updates storage pointed to by wTempMonBox+wTempMonSlot with content in
; wTempMon. If this is part of a Box, this allocates a new entry.
; Returns z if successful.
	; Just run a simple copy if we're updating the party.
	ld a, [wTempMonSlot]
	ld c, a
	ld a, [wTempMonBox]
	ld b, a
	and a
	jp z, CopyBetweenPartyAndTemp

	; Otherwise, we need to allocate a new box entry.
	; Erase the current entry before trying to find a new one.
	; This code exists to gurantee that should the storage commit work once,
	; it will always continue to work for the same tempmon session without an
	; enforced save inbetween. Without it, the code could write a new 314th
	; entry the first write, then fail to reuse the same entry later.
	call GetStorageBoxPointer
	push de
	ld e, 0
	call SetStorageBoxPointer
	push bc
	call NewStoragePointer
	pop bc
	jr nc, .found_entry
	pop de
	call SetStorageBoxPointer
	or 1
	ret

.found_entry
	call AddStorageMon
	call SetStorageBoxPointer
	pop de
	xor a
	ret

RemoveStorageBoxMon:
; Erases box b slot c. Done by simply just setting it to a null entry.
	ld e, 0
	; fallthrough
SetStorageBoxPointer:
; Sets box b slot c to have storage pointer de. If bc is a party slot, will
; fill it with the pokedb entry in de, or empty the slot (potentially shifting
; later party members upwards) if de is a null slot.
	push hl
	push de
	push bc

	; Are we dealing with a party slot?
	ld a, b
	and a
	jr z, .party

	; We're dealing with a box, so set box pointer appropriately.
	ld a, BANK(sNewBox1)
	call GetSRAMBank

	; Get the correct box.
	ld a, b
	ld hl, sNewBox1Entries
	ld bc, sNewBox2 - sNewBox1
	dec a
	rst AddNTimes
	pop bc
	push bc

	; Get the corret slot and write the db entry to it.
	dec c
	ld b, 0
	push hl
	add hl, bc
	ld [hl], e
	pop hl

	; Write the db bank.
	ld a, c
	ld c, sNewBox1Banks - sNewBox1Entries
	add hl, bc
	ld c, a
	ld b, RESET_FLAG
	dec d
	jr z, .got_flag_action
	ld b, SET_FLAG
.got_flag_action
	predef FlagPredef
	jr .done

.party
	; Get the mon from the pokedb for party writing.
	call GetStorageMon
	jr nz, .not_empty

	; First, shift this partymon to the end, effectively shifting everything
	; past it upwards.
	call ShiftPartySlotToEnd

	; Then delete the partymon.
	ld hl, wPartyCount
	dec [hl]
	ld c, [hl]
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld [hl], -1
	jr .done

.not_empty
	; If this slot was previously empty, we'll append it to the party end.
	ld a, [wPartyCount]
	cp c
	jr nc, .partyslot_not_empty
	inc a
	ld c, a
	ld [wPartyCount], a

.partyslot_not_empty
	; b is 0 from earlier, from referencing the party.
	call CopyBetweenPartyAndTemp
.done
	call CloseSRAM
	jp PopBCDEHL

ShiftPartySlotToEnd:
; Shift party slot c until the end.
	ld a, [wPartyCount]
	cp c
	ret z
	ld e, c
	inc c
	call SwapPartyMons
	jr ShiftPartySlotToEnd

CopyBetweenPartyAndTemp:
; Copies between partymon c (1-indexed) and temp. Doesn't preserve registers.
; Note that this will not update the party count if adding a new mon.
; If bit 7 of b is set, copies between wOTPartyMons instead of wPartyMons.
; If bit 0 of b is set, copies from party to temp, otherwise the reverse.
	dec c
	ld hl, wPartySpecies
	ld de, wTempMonSpecies
	ld a, 1
	call .Copy

	ld hl, wPartyMon1
	ld de, wTempMon
	ld a, PARTYMON_STRUCT_LENGTH
	call .Copy

	ld hl, wPartyMonNicknames
	ld de, wTempMonNickname
	ld a, MON_NAME_LENGTH
	call .Copy

	ld hl, wPartyMonOT
	ld de, wTempMonOT
	ld a, NAME_LENGTH
	call .Copy

.Copy:
; Copies c bytes from hl+c*a to de if b is 1, otherwise the reverse.
	push bc
	bit 7, b
	jr z, .got_party

	; Copies from OT party instead.
	push bc
	ld bc, wOTPartyMons - wPartyMons
	add hl, bc
	pop bc
.got_party
	ld b, 0
	push af
	rst AddNTimes
	pop af
	pop bc
	push bc
	ld c, a
	bit 0, b
	call z, SwapHLDE
	ld b, 0
	rst CopyBytes
	pop bc
	ret

AddStorageMon:
; Adds wTempMon to storage pointed to with de. Does nothing if e is 0, meaning
; a null entry. Returns a fatal error (crash) if the entry is occupied.
	; Do nothing if we're pointing towards null storage.
	ld a, e
	and a
	ret z

	; Allocate the entry. Return a fatal error if the entry was already set.
	call AllocateStorageFlag
	ld a, ERR_NEWBOX
	jp nz, Crash
	push hl
	push de
	push bc

	; Encode the tempmon for adding, but decode it afterwards to leave it in
	; the same state.
	push de
	call EncodeTempMon
	pop de
	call OpenStorageDB

	ld hl, sBoxMons1Mons
	ld bc, SAVEMON_STRUCT_LENGTH
	ld a, e
	dec a
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, wEncodedTempMon
	ld bc, SAVEMON_STRUCT_LENGTH
	rst CopyBytes

	call DecodeTempMon
	call CloseSRAM
	jp PopBCDEHL

OpenStorageDB:
; Opens pokedb bank given by d (1 or 2). Leaves SRAM open, obviously.
	ld a, d
	dec a
	ld a, BANK(sBoxMons1)
	jr z, .got_bank
	ld a, BANK(sBoxMons2)
.got_bank
	jp GetSRAMBank

EncodeTempMon:
; Encodes wTempMon to prepare for storage. This assumes ordering and sizes of
; party struct, nickname and OT(+extra) in wTempMon doesn't change.
	; Shift things around to the encoded format, before doing actual encoding.
	; Box struct is merely just a shorter party struct, so we don't need to
	; touch it.
	ld hl, wTempMonOT + PLAYER_NAME_LENGTH
	ld de, wEncodedTempMonExtra
	ld bc, 3
	rst CopyBytes
	ld hl, wTempMonNickname
	ld de, wEncodedTempMonNick
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ld hl, wTempMonOT
	ld de, wEncodedTempMonOT
	ld bc, PLAYER_NAME_LENGTH - 1
	rst CopyBytes

	; Convert nickname/OT characters into reversible 7bit.
	ld hl, wEncodedTempMonNick
	ld b, wEncodedTempMonEncodeEnd - wEncodedTempMonNick
.charmap_loop
	ld a, [hl]
	ld c, $fa
	cp " "
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
	jr nz, .charmap_loop
	; fallthrough
ChecksumTempMon:
; Calculate and write a checksum and to TempMon. Use a nonzero baseline to
; avoid a complete null content from having 0 as a checksum.
; Returns z if an existing checksum is identical to the written checksum.
	; boxmon struct + 3 extra bytes (normally placed after OT)
	ld bc, wEncodedTempMon
	ld hl, 127
	lb de, BOXMON_STRUCT_LENGTH + 3, 0
	call .DoChecksum

	; nickname + OT. This skips e=36 (boxstruct+4) due to a double-increase.
	; Counterintuitive but harmless.
	ld bc, wEncodedTempMonNick
	ld d, $80 | (wEncodedTempMonEncodeEnd - wEncodedTempMonNick)
	call .DoChecksum

	; Compare and write the result
	ld d, h
	ld e, l

	; Checksum is 16bit, further ones are padded with zeroes.
	; The padding being nonzero is also counted as invalid.
	ld b, 0 ; used for checksum error detection
	ld hl, wEncodedTempMonNick
	ld c, wEncodedTempMonEncodeEnd - wEncodedTempMonNick
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

DecodeTempMon:
; Decodes TempMon. Returns nz. Sets carry in case of invalid checksum.
	; First, run a checksum check. Don't use the result until we've done
	; character replacements back to their original state
	call ChecksumTempMon
	push af

	; Move extra data back
	ld hl, wEncodedTempMonExtra
	ld de, wTempMonOT + PLAYER_NAME_LENGTH
	ld bc, 3
	rst CopyBytes

	; Reverse the 7bit character encoding back to its original state.
	ld hl, wEncodedTempMonNick
	ld b, wEncodedTempMonEncodeEnd - wEncodedTempMonNick
.charmap_loop
	ld a, [hl]
	or $80
	sub $fa
	ld c, " "
	jr z, .replace
	dec a
	ld c, "@"
	jr z, .replace
	dec a
	ld c, 0
	jr z, .replace

	; Reverse the previous decrements
	add $fc
	ld c, a
.replace
	ld [hl], c
	inc hl
	dec b
	jr nz, .charmap_loop

	; Copy nick and OT back to its original place. We need to do this backwards
	; due to overlap between wEncodedTempMon(Nick|OT) and wTempMon(Nick|OT).
	ld hl, wEncodedTempMonOT + PLAYER_NAME_LENGTH - 2
	ld de, wTempMonOT + PLAYER_NAME_LENGTH - 1
	lb bc, 2, PLAYER_NAME_LENGTH - 1

.outer_loop
	ld a, "@"
	ld [de], a
	dec de
.inner_loop
	ld a, [hld]
	ld [de], a
	dec de
	dec c
	jr nz, .inner_loop

	; If this is the first time we leave the loop, do mon nickname now.
	dec b
	ld de, wTempMonNickname + MON_NAME_LENGTH - 1
	ld c, MON_NAME_LENGTH - 1
	jr nz, .outer_loop

	pop af
	jr z, .set_partymon_data

	call SetBadEgg
	call .set_partymon_data
	scf
	ret

.set_partymon_data
	; Calculate stats
	ld a, [wTempMonSpecies]
	ld [wCurSpecies], a
	ld a, [wTempMonForm]
	ld [wCurForm], a
	call GetBaseData
	ld hl, wTempMonOT + PLAYER_NAME_LENGTH
	ld a, [hl]
	and HYPER_TRAINING_MASK
	inc a
	ld b, a
	ld hl, wTempMonEVs - 1
	ld de, wTempMonMaxHP
	ld a, [wTempMonLevel]
	ld [wCurPartyLevel], a
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

SetBadEgg:
	; Load failsafe data into the TempMon pokémon struct
	ld hl, wTempMon
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, 1
	rst ByteFill

	; Set data that can't be 1 to other things

	; No held item.
	xor a
	ld hl, wTempMonItem
	ld [hl], a

	; No duplicate moves.
	ld hl, wTempMonMoves + 1
	ld bc, NUM_MOVES - 1
	rst ByteFill

	; More sensible personality data.
	ld hl, wTempMonPersonality
	ld [hl], ABILITY_1 | QUIRKY ; no-optimize *hl++|*hl-- = N
	inc hl
	ld [hl], MALE | IS_EGG_MASK | 1
	ld hl, wTempMonHappiness ; egg cycles
	ld [hl], 255

	; 0 EXP.
	ld hl, wTempMonExp
	ld c, 3
	rst ByteFill

	; Set nickname fields
	ld hl, wTempMonNickname
	ld de, .BadEgg
	call CopyName2

	; Dummy OT name.
	ld hl, wTempMonOT
	ld a, "?"
	ld [hli], a
	ld [hl], "@"
	ret

.BadEgg:
	rawchar "Bad Egg@"

EnsureStorageSpace:
; Returns z if we have at least a unallocated pokedb entries left. This exists
; because flushing incurs a significant performance penalty, so this function
; avoids it when checking storage if we can get away with it.
	ld b, a

	; First, check if we have enough entries without flushing.
	push bc
	call _CheckFreeDatabaseEntries
	pop bc
	cp b
	sbc a
	ret z

	; Try again, this time with flushing.
	push bc
	call CheckFreeDatabaseEntries
	pop bc
	cp b
	sbc a
	ret

CheckFreeDatabaseEntries:
; Returns amount of unused database entries left, or 255 if 255+. We don't
; really care if we have 255 or 314 entries left, only if we're running low.
	; Flush the storage system of duplicate entries.
	call FlushStorageSystem
	; fallthrough
_CheckFreeDatabaseEntries:
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
	call CountSetBits
	cpl
	add MONDB_ENTRIES + 1
	ld c, a
	ret

InitializeBoxes:
; Initializes the Storage System boxes as empty with default names and themes.
	ld a, BANK(sNewBox1)
	call GetSRAMBank
	ld b, NUM_BOXES
	ld hl, sNewBox1
.name_loop
	push bc
	ld d, b
	ld bc, sNewBox1Name - sNewBox1
	xor a
	rst ByteFill
	push hl
	push de
	ld de, .Box
	call CopyName2
	dec hl
	pop de
	ld a, NUM_BOXES + 1
	sub d
	sub 10
	add "0" + 10
	ld [hl], a
	jr c, .next
	ld [hl], "1" ; no-optimize *hl++|*hl-- = N
	inc hl
	sub 10
	ld [hl], a
.next
	inc hl
	ld [hl], "@"
	pop hl
	ld c, sNewBox2 - sNewBox1Name
	add hl, bc
	pop bc
	dec b
	jr nz, .name_loop
	call CloseSRAM

	ld hl, BillsPC_DefaultBoxThemes
	ld de, wBillsPC_BoxThemes
.theme_loop
	ld a, [hli]
	inc a
	jr z, .done
	dec a
	ld [de], a
	inc de
	jr .theme_loop

.done
	; In case we reset the game mid-flush and then chose to start a new game,
	; ensure that all entries are allocated properly.
	jp FlushStorageSystem

.Box:
	rawchar "Box @"

INCLUDE "data/default_box_themes.asm"

GetBoxName:
; Writes name of box b to string buffer 1.
	ld c, 0
	call CopyBoxName

	; Ensure that there's a terminator at the end. This isn't included as part
	; of saved box name.
	ld a, "@"
	ld [wStringBuffer1 + BOX_NAME_LENGTH], a
	ret

SetBoxName:
; Writes name from string buffer 1 to box b.
	ld c, 1
	; fallthrough
CopyBoxName:
; Copies between box b and string buffer 1 depending on value of c.
; c=0: Copy from box b to string buffer 1.
; c=1: Copy from string buffer 1 to box b.
	ld a, BANK(sNewBox1)
	call GetSRAMBank
	ld hl, sNewBox1Name
	ld a, b
	dec a
	push bc
	ld bc, sNewBox2 - sNewBox1
	rst AddNTimes
	pop bc
	ld de, wStringBuffer1
	dec c
	call z, SwapHLDE
	ld bc, BOX_NAME_LENGTH
	rst CopyBytes
	jp CloseSRAM

PrevStorageBoxMon:
; Reads wTempMonBox+wTempMonSlot and attempts to load a previous mon.
; Returns nz upon success, otherwise z. If there is no previous mon,
; wTempMonBox+wTempMonSlot is unchanged.
	push bc
	ld a, [wTempMonSlot]
	ld b, a
	ld c, a
.loop
	dec c
	jr z, .restore_slot
	push bc
	ld a, [wTempMonBox]
	ld b, a
	call GetStorageBoxMon
	pop bc
	jr nz, .done
	jr .loop
.restore_slot
	ld a, b
	ld [wTempMonSlot], a
.done
	pop bc
	ret

NextStorageBoxMon:
; Reads wTempMonBox+wTempMonSlot and attempts to load the next mon.
; Returns nz upon success, otherwise z. If there is no next mon,
; wTempMonBox+wTempMonSlot is unchanged.
	push bc
	ld a, [wTempMonSlot]
	ld b, a
	ld c, a
.loop
	ld a, c
	inc c
	cp MONS_PER_BOX
	jr z, .restore_slot
.get_storage
	push bc
	ld a, [wTempMonBox]
	ld b, a
	call GetStorageBoxMon
	pop bc
	jr nz, .done

	; If we're dealing with a party, we ran past the amount of mons we have.
	ld a, [wTempMonBox]
	and $7f
	jr nz, .loop
	; fallthrough
.restore_slot
	ld a, b
	ld [wTempMonSlot], a
.done
	pop bc
	ret

GetStorageBoxMon:
; Reads storage bank+entry from box b slot c and put it in wTempMon.
; This function supports handling the OT party by setting b to $80.
; If there is a checksum error, put Bad Egg data in wTempMon instead.
; Returns c in case of a Bad Egg, z if the requested mon doesn't exist,
; nz|nc otherwise. If b==0, read from party list. c is 1-indexed.
	xor a
	ld [wTempMonSlot], a

	; Check if we're reading party or box data.
	ld a, b
	ld [wTempMonBox], a
	and $7f
	jr z, .read_party
	push de
	call GetStorageBoxPointer
	call GetStorageMon
	pop de
	ret z
	ld a, c
	ld [wTempMonSlot], a
	ret

.read_party
	and a
	ld a, [wPartyCount]
	jr z, .got_partycount
	ld a, [wOTPartyCount]
.got_partycount
	cp c
	jr nc, .party_not_empty
	xor a
	ret
.party_not_empty
	ld a, c
	ld [wTempMonSlot], a
	push hl
	push de
	push bc
	inc b
	call CopyBetweenPartyAndTemp

	; Calculate stats
	ld a, [wTempMonSpecies]
	ld [wCurSpecies], a
	ld a, [wTempMonForm]
	ld [wCurForm], a
	call GetBaseData
	or 1
	jp PopBCDEHL

GetStorageMon:
; Reads storage bank d, entry e and put it in wTempMon.
; If there is a checksum error, put Bad Egg data in wTempMon instead.
; Returns c in case of a Bad Egg, z if the requested mon doesn't exist,
; nz|nc otherwise.
	push hl
	push de
	push bc
	call IsStorageUsed
	jr z, .done ; entry not found

	call OpenStorageDB

	; Get the correct pointer
	ld hl, sBoxMons1Mons
	ld bc, SAVEMON_STRUCT_LENGTH
	ld a, e
	dec a
	rst AddNTimes

	; Write to wEncodedTempMon and then decode it.
	ld de, wEncodedTempMon
	ld bc, SAVEMON_STRUCT_LENGTH
	rst CopyBytes

	; Decode the result. This also returns a Bad Egg failsafe on a checksum
	; error.
	call DecodeTempMon
.done
	call CloseSRAM
	jp PopBCDEHL

AllocateStorageFlag:
; Allocates the given storage flag. Returns nz if storage is already in use.
	call IsStorageUsed
	ret nz
	call _AllocateStorageFlag
	xor a
	ret

IsStorageUsed:
; Returns z if the given storage slot is unused. Preserves wTempMon.
	ld a, CHECK_FLAG
	jr StorageFlagAction
_AllocateStorageFlag:
	ld a, SET_FLAG
	; fallthrough
StorageFlagAction:
; Performs flag action a on storage entry in de.
	; If we're dealing with a null entry (e=0), do nothing but pretend the
	; entry is unused if asked. Don't optimize away the xor a, since we
	; want to mimic the normal behaviour of the function.
	inc e
	dec e
	jr nz, .not_null
	xor a
	ret

.not_null
	push hl
	push de
	push bc
	ld b, a

	call OpenStorageDB

	ld c, e
	dec c
	ld hl, sBoxMons1UsedEntries
	ld d, 0
	predef FlagPredef
	call CloseSRAM
	jp PopBCDEHL
