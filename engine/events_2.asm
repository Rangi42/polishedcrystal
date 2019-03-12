ReturnFromMapSetupScript:: ; b8000
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld [wCurrentLandmark], a
	call .CheckNationalParkGate
	jr z, .nationalparkgate

	call GetMapPermission
	cp GATE
	jr nz, .not_gate

.nationalparkgate
	ld a, -1
	ld [wCurrentLandmark], a

.not_gate
	ld hl, wEnteredMapFromContinue
	bit 1, [hl]
	res 1, [hl]
	jr nz, .dont_do_map_sign

	call .CheckMovingWithinLandmark
	jr z, .dont_do_map_sign
	ld a, [wCurrentLandmark]
	ld [wPreviousLandmark], a

	call .CheckSpecialMap
	jr z, .dont_do_map_sign

	ld a, [wCurrentLandmark]
	cp LUCKY_ISLAND
	jr nz, .not_lucky_island
	eventflagcheck EVENT_LUCKY_ISLAND_CIVILIANS
	jr nz, .dont_do_map_sign
.not_lucky_island

; Landmark sign timer:
; $80-$70: Sliding out (old sign)
; $6f-$6d: Loading new graphics
; $6c-$5d: Sliding in
; $5c-$10: Remains visible
; $0f-$00: Sliding out
	ld a, [wLandmarkSignTimer]
	sub $70
	jr nc, .sliding_out
	add $70
	cp $10
	jr c, .sliding_out
	sub $5d
	jr c, .visible
	cp $10
	jr c, .sliding_in

	; was loading new graphics -- just reload them again
	ld a, $70
	jr .value_ok
.sliding_in
	push bc
	ld b, a
	ld a, $80
	sub b
	pop bc
	jr .value_ok
.visible
	ld a, $80
	jr .value_ok
.sliding_out
	add $70
.value_ok
	ld [wLandmarkSignTimer], a
	ret

.dont_do_map_sign
	ld a, [wCurrentLandmark]
	ld [wPreviousLandmark], a
	ld a, $90
	ld [rWY], a
	ld [hWY], a
	xor a
	ld [hLCDCPointer], a
	ret
; b8064

.CheckMovingWithinLandmark: ; b8064
	ld a, [wCurrentLandmark]
	ld c, a
	ld a, [wPreviousLandmark]
	cp c
	ret z
	and a ; cp SPECIAL_MAP
	ret
; b8070

.CheckSpecialMap: ; b8070
	cp -1
	ret z
	and a ; cp SPECIAL_MAP
	ret z
	cp RADIO_TOWER
	ret z
	cp LAV_RADIO_TOWER
	ret z
	cp UNDERGROUND
	ret z
	cp POWER_PLANT
	ret z
	cp POKEMON_MANSION
	ret z
	cp CINNABAR_LAB
	ret z
	ld a, $1
	and a
	ret
; b8089

.CheckNationalParkGate: ; b8089
	ld a, [wMapGroup]
	cp GROUP_ROUTE_35_NATIONAL_PARK_GATE
	ret nz
	ld a, [wMapNumber]
	cp MAP_ROUTE_35_NATIONAL_PARK_GATE
	ret z
	cp MAP_ROUTE_36_NATIONAL_PARK_GATE
	ret
; b8098


PlaceMapNameSign:: ; b8098 (2e:4098)
	; Sign is slightly delayed to move it away from the map connection setup
	ld hl, wLandmarkSignTimer
	ld a, [hl]
	and a
	jr z, .sliding_out
	dec [hl]
	sub $70
	jr nc, .sliding_out
	add $70
	cp $6f
	ret nc
	sub $6d
	jr c, .graphics_ok
	jp nz, LoadMapNameSignGFX
	push hl
	call InitMapNameFrame
	farcall HDMATransfer_OnlyTopFourRows
	pop hl
.graphics_ok
	ld a, [hl]
	cp $5d
	jr nc, .sliding_in
	cp $10
	jr c, .sliding_out
	ld a, $70
	jr .got_value
.sliding_in
	sub $5d
	add a
	add $70
	jr .got_value
.sliding_out
	push bc
	ld b, a
	ld a, $90
	sub b
	sub b
	pop bc
.got_value
	ld [rWY], a
	ld [hWY], a
	sub $90
	ret nz
	ld [hLCDCPointer], a
	ret

LoadMapNameSignGFX: ; b80c6
	; load opaque space
	ld hl, VTiles0 tile POPUP_MAP_FRAME_SPACE
	call GetOpaque1bppSpaceTile
	; load sign frame
	ld hl, VTiles0 tile POPUP_MAP_FRAME_START
	ld de, MapEntryFrameGFX
	lb bc, BANK(MapEntryFrameGFX), POPUP_MAP_FRAME_SIZE
	call Get2bpp
	; clear landmark name area
	ld hl, VTiles0 tile POPUP_MAP_NAME_START
	ld e, POPUP_MAP_NAME_SIZE
.clear_loop
	push hl
	push de
	call GetOpaque1bppSpaceTile
	pop de
	pop hl
	ld bc, LEN_2BPP_TILE
	add hl, bc
	dec e
	jr nz, .clear_loop
	; wStringBuffer1 = current landmark name
	ld a, [wCurrentLandmark]
	ld e, a
	farcall GetLandmarkName
	; c = length of landmark name
	ld c, 0
	push hl
	ld hl, wStringBuffer1
.length_loop
	ld a, [hli]
	cp "@"
	jr z, .got_length
	inc c
	jr .length_loop
.got_length
	pop hl
	; bc = byte offset to center landmark name
	ld a, SCREEN_WIDTH - 2
	sub c
	srl a
	ld h, 0
	ld l, a
rept 4
	add hl, hl
endr
	ld b, h
	ld c, l
	ld hl, VTiles3 tile POPUP_MAP_NAME_START
	add hl, bc
	; de = start of vram buffer
	ld d, h
	ld e, l
	; hl = start of landmark name
	ld hl, wStringBuffer1
.loop
	; a = tile offset into font graphic
	ld a, [hli]
	cp "@"
	ret z
	; save position in landmark name
	push hl
	; spaces are unique
	cp "¯"
	jr z, .space
	cp " "
	jr nz, .not_space
.space
	ld hl, TextBoxSpaceGFX
	jr .got_tile
.not_space
	sub $80
	; bc = byte offset into font graphic (a * 8)
	push hl
	ld h, 0
	ld l, a
	add hl, hl
	add hl, hl
	add hl, hl
	ld b, h
	ld c, l
	pop hl
	; hl = start of font tile graphic
	push de
	farcall LoadStandardFontPointer
	pop de
	add hl, bc
.got_tile
	; save position in vram
	push de
	; swap hl and de, so de = font tile graphic, and hl = vram
	push hl
	ld h, d
	ld l, e
	pop de
	; get font tile into vram
	call GetOpaque1bppFontTile
	; restore hl = position in vram
	pop hl
	; increment position in vram
	ld bc, LEN_2BPP_TILE
	add hl, bc
	; de = position in vram
	ld d, h
	ld e, l
	; restore hl = position in landmark name
	pop hl
	jr .loop
; b80d3

InitMapNameFrame: ; b80d3
; InitMapSignAttrMap
	hlcoord 0, 0
	ld de, wAttrMap - wTileMap
	add hl, de
	; top row
	ld a, BEHIND_BG | PAL_BG_TEXT
	ld bc, SCREEN_WIDTH - 1
	call ByteFill
	or X_FLIP
	ld [hli], a
	; middle rows
rept 2
	and $ff - X_FLIP
	ld [hli], a
	ld bc, SCREEN_WIDTH - 2
	call ByteFill
	or X_FLIP
	ld [hli], a
endr
	; bottom row
	and $ff - X_FLIP
	ld bc, SCREEN_WIDTH - 1
	call ByteFill
	or X_FLIP
	ld [hl], a
; PlaceMapNameFrame
	hlcoord 0, 0
	; top left
	ld a, POPUP_MAP_FRAME_START ; $f8
	ld [hli], a
	; top row
	inc a ; $f9
	call .FillTopBottom
	; top right
	dec a ; $f8
	ld [hli], a
	; left, first line
	ld a, POPUP_MAP_FRAME_START + 3 ; $fb
	ld [hli], a
	; first line
	call .FillUpperMiddle
	; right, first line
	ld [hli], a
	; left, second line
	inc a ; $fc
	ld [hli], a
	; second line
	call .FillLowerMiddle
	; right, second line
	ld [hli], a
	; bottom left
	inc a ; $fd
	ld [hli], a
	; bottom
	inc a ; $fe
	call .FillTopBottom
	; bottom right
	dec a ; $fd
	ld [hl], a
	ret
; b815b

.FillUpperMiddle: ; b815b
	push af
	ld a, POPUP_MAP_FRAME_SPACE
	ld c, SCREEN_WIDTH - 2
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	pop af
	ret

.FillLowerMiddle:
	push af
	ld a, POPUP_MAP_NAME_START
	ld c, SCREEN_WIDTH - 2
.loop2
	ld [hli], a
	inc a
	dec c
	jr nz, .loop2
	pop af
	ret
; b8164

.FillTopBottom: ; b8164
	ld c, 5
	jr .enterloop

.continueloop
	ld [hli], a
	ld [hli], a

.enterloop
	inc a
	ld [hli], a
	ld [hli], a
	dec a
	dec c
	jr nz, .continueloop
	ret
; b8172


CheckForHiddenItems: ; b8172
; Checks to see if there are hidden items on the screen that have not yet been found.  If it finds one, returns carry.
	ld a, [wMapScriptHeaderBank]
	ld [wBuffer1], a
; Get the coordinate of the bottom right corner of the screen.
	ld a, [wXCoord]
	add SCREEN_WIDTH / 4
	ld [wBuffer4], a
	ld a, [wYCoord]
	add SCREEN_HEIGHT / 4
	ld [wBuffer3], a
; Get the pointer for the first signpost header in the map...
	ld hl, wCurrentMapSignpostHeaderPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
; ... before even checking to see if there are any signposts on this map.
	ld a, [wCurrentMapSignpostCount]
	and a
	jr z, .nosignpostitems
; For i = 1:wCurrentMapSignpostCount...
.loop
; Store the counter in wBuffer2, and store the signpost header pointer in the stack.
	ld [wBuffer2], a
	push hl
; Get the Y coordinate of the signpost.
	call .GetFarByte
	ld e, a
; Is the Y coordinate of the signpost on the screen?  If not, go to the next signpost.
	ld a, [wBuffer3]
	sub e
	jr c, .next
	cp SCREEN_HEIGHT / 2
	jr nc, .next
; Is the X coordinate of the signpost on the screen?  If not, go to the next signpost.
	call .GetFarByte
	ld d, a
	ld a, [wBuffer4]
	sub d
	jr c, .next
	cp SCREEN_WIDTH / 2
	jr nc, .next
; Is this signpost a hidden item?  If not, go to the next signpost.
	call .GetFarByte
	cp SIGNPOST_GROTTOITEM
	jr z, .grottoitem
	cp SIGNPOST_ITEM
	jr c, .next
; Has this item already been found?  If not, set off the Itemfinder.
	call .GetFarByte
	ld e, a
	call .GetFarByte
	ld d, a
	jr .checkitem
.grottoitem
	call .GetFarByte
	call .GetFarByte
	ld de, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
.checkitem
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jr z, .itemnearby

.next
; Restore the signpost header pointer and increment it by the length of a signpost header.
	pop hl
	ld bc, 5
	add hl, bc
; Restore the signpost counter and decrement it.  If it hits zero, there are no hidden items in range.
	ld a, [wBuffer2]
	dec a
	jr nz, .loop

.nosignpostitems
	xor a
	ret

.itemnearby
	pop hl
	scf
	ret
; b81e2

.GetFarByte: ; b81e2
	ld a, [wBuffer1]
	call GetFarByte
	inc hl
	ret
; b81ea

TreeItemEncounter:
	call Random
	cp 15 percent
	jr c, .silver_leaf
	cp 30 percent
	jr c, .gold_leaf
	ld a, NO_ITEM
	jr .item
.silver_leaf
	ld a, SILVER_LEAF
	jr .item
.gold_leaf
	ld a, GOLD_LEAF
.item
	ld [wScriptVar], a
	ret

RockItemEncounter:
	ld hl, .RockItems
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	jr .loop
.ok
	ld a, [hli]
	cp -1
	ld a, NO_ITEM
	jr z, .done
	ld a, [hl]
.done
	ld [wScriptVar], a
	ret

.RockItems:
	db 1, HELIX_FOSSIL
	db 1, DOME_FOSSIL
	db 1, OLD_AMBER
	db 1, BIG_NUGGET
	db 2, RARE_BONE
	db 4, NUGGET
	db 6, STAR_PIECE
	db 12, BIG_PEARL
	db 18, STARDUST
	db 24, HARD_STONE
	db 24, SOFT_SAND
	db 48, PEARL
	db 64, BRICK_PIECE
	db 48, NO_ITEM
	db -1

TreeMonEncounter: ; b81ea
	xor a
	ld [wTempWildMonSpecies], a
	ld [wCurPartyLevel], a

	ld hl, TreeMonMaps
	call GetTreeMonSet
	jr nc, .no_battle

	call GetTreeMons
	jr nc, .no_battle

	call GetTreeMon
	jr nc, .no_battle

	ld a, BATTLETYPE_TREE
	ld [wBattleType], a
	ld a, 1
	ld [wScriptVar], a
	ret

.no_battle
	xor a
	ld [wScriptVar], a
	ret
; b8219

RockMonEncounter: ; b8219

	xor a
	ld [wTempWildMonSpecies], a
	ld [wCurPartyLevel], a

	ld hl, RockMonMaps
	call GetTreeMonSet
	jr nc, .no_battle

	call GetTreeMons
	jr nc, .no_battle

	ld a, 10
	call RandomRange
	cp 4
	jr nc, .no_battle

	call SelectTreeMon
	jr nc, .no_battle

	ret

.no_battle
	xor a
	ret
; b823e

	db $05 ; ????

GetTreeMonSet: ; b823f
; Return carry and treemon set in a
; if the current map is in table hl.
	ld a, [wMapNumber]
	ld e, a
	ld a, [wMapGroup]
	ld d, a
.loop
	ld a, [hli]
	cp -1
	jr z, .not_in_table

	cp d
	jr nz, .skip2

	ld a, [hli]
	cp e
	jr nz, .skip1

	jr .in_table

.skip2
	inc hl
.skip1
	inc hl
	jr .loop

.not_in_table
	xor a
	ret

.in_table
	ld a, [hl]
	scf
	ret
; b825e

INCLUDE "data/wild/treemon_maps.asm"

GetTreeMons: ; b82d2
; Return the address of TreeMon table a in hl.
; Return nc if table a doesn't exist.

	cp 8
	jr nc, .quit

	and a
	jr z, .quit

	ld e, a
	ld d, 0
	ld hl, TreeMons
	add hl, de
	add hl, de

	ld a, [hli]
	ld h, [hl]
	ld l, a

	scf
	ret

.quit
	xor a
	ret
; b82e8

INCLUDE "data/wild/treemons.asm"

GetTreeMon: ; b83e5
	push hl
	call GetTreeScore
	pop hl
	and a
	jr z, .bad
	cp 1
	jr z, .good
	cp 2
	jr z, .rare
	ret

.bad
	ld a, 10
	call RandomRange
	and a
	jr nz, NoTreeMon
	jr SelectTreeMon

.good
	ld a, 10
	call RandomRange
	cp 5
	jr nc, NoTreeMon
	jr SelectTreeMon

.rare
	ld a, 10
	call RandomRange
	cp 8
	jr nc, NoTreeMon
.skip
	ld a, [hli]
	cp -1
	jr nz, .skip
	; fallthrough

SelectTreeMon: ; b841f
; Read a TreeMons table and pick one monster at random.
	ld a, 100
	call RandomRange
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	inc hl
	jr .loop

.ok
	ld a, [hli]
	cp -1
	jr z, NoTreeMon

	ld a, [hli]
	ld [wTempWildMonSpecies], a
	ld a, [hl]
	ld [wCurPartyLevel], a
	scf
	ret

NoTreeMon: ; b843b
	xor a
	ld [wTempWildMonSpecies], a
	ld [wCurPartyLevel], a
	ret
; b8443

GetTreeScore: ; b8443
	call .CoordScore
	ld [wBuffer1], a
	call .OTIDScore
	ld [wBuffer2], a
	ld c, a
	ld a, [wBuffer1]
	sub c
	jr z, .rare
	jr nc, .ok
	add 10
.ok
	cp 5
	jr c, .good

.bad
	xor a
	ret

.good
	ld a, 1
	ret

.rare
	ld a, 2
	ret
; b8466

.CoordScore: ; b8466
	call GetFacingTileCoord
	ld hl, 0
	ld c, e
	ld b, 0
	ld a, d

	and a
	jr z, .next
.loop
	add hl, bc
	dec a
	jr nz, .loop
.next

	add hl, bc
	ld c, d
	add hl, bc

	ld a, h
	ld [hDividend], a
	ld a, l
	ld [hDividend + 1], a
	ld a, 5
	ld [hDivisor], a
	ld b, 2
	call Divide

	ld a, [hQuotient + 1]
	ld [hDividend], a
	ld a, [hQuotient + 2]
	ld [hDividend + 1], a
	ld a, 10
	ld [hDivisor], a
	ld b, 2
	call Divide

	ld a, [hQuotient + 3]
	ret
; b849d

.OTIDScore: ; b849d
	ld a, [wPlayerID]
	ld [hDividend], a
	ld a, [wPlayerID + 1]
	ld [hDividend + 1], a
	ld a, 10
	ld [hDivisor], a
	ld b, 2
	call Divide
	ld a, [hQuotient + 3]
	ret
; b84b3

LoadFishingGFX: ; b84b3
	ld a, [rVBK]
	push af
	xor a
	ld [rVBK], a

	ld de, FishingGFX
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .got_gender
	ld de, KrisFishingGFX
.got_gender

	ld hl, VTiles0 tile $02
	call .LoadGFX
	ld hl, VTiles0 tile $06
	call .LoadGFX
	ld hl, VTiles0 tile $0a
	call .LoadGFX
	ld hl, VTiles0 tile $7c
	call .LoadGFX

	pop af
	ld [rVBK], a
	ret
; b84e3

.LoadGFX: ; b84e3
	lb bc, BANK(FishingGFX), 2
	push de
	call Get2bpp
	pop de
	ld hl, 2 tiles
	add hl, de
	ld d, h
	ld e, l
	ret
; b84f2

FishingGFX: ; b84f2
INCBIN "gfx/overworld/chris_fish.2bpp"
; b8582

KrisFishingGFX: ; b8582
INCBIN "gfx/overworld/kris_fish.2bpp"
; b8612
