ReturnFromMapSetupScript:: ; b8000
	xor a
	ld [hBGMapMode], a

	ld a, [MapGroup]
	ld b, a
	ld a, [MapNumber]
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

; Display for 60 frames
	ld a, 60
	ld [wLandmarkSignTimer], a
	call LoadMapNameSignGFX
	call InitMapNameFrame
	farjp HDMATransfer_OnlyTopFourRows

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
	ld a, [MapGroup]
	cp GROUP_ROUTE_35_NATIONAL_PARK_GATE
	ret nz
	ld a, [MapNumber]
	cp MAP_ROUTE_35_NATIONAL_PARK_GATE
	ret z
	cp MAP_ROUTE_36_NATIONAL_PARK_GATE
	ret
; b8098


PlaceMapNameSign:: ; b8098 (2e:4098)
	ld hl, wLandmarkSignTimer
	ld a, [hl]
	and a
	jr z, .disappear
	dec [hl]
	cp 60
	ret z
	cp 59
	jr nz, .skip2
	call InitMapNameFrame
	call PlaceMapNameCenterAlign
	farcall HDMATransfer_OnlyTopFourRows
.skip2
	ld a, $70
	ld [rWY], a
	ld [hWY], a
	ret

.disappear
	ld a, $90
	ld [rWY], a
	ld [hWY], a
	xor a
	ld [hLCDCPointer], a
	ret

LoadMapNameSignGFX: ; b80c6
	ld a, $1
	ld [rVBK], a
	ld de, MapEntryFrameGFX
	ld hl, VTiles4 tile $78
	lb bc, BANK(MapEntryFrameGFX), 8
	call Get2bpp
	xor a
	ld [rVBK], a
	ret
; b80d3

InitMapNameFrame: ; b80d3
; InitMapSignAttrMap
	hlcoord 0, 0
	ld de, AttrMap - TileMap
	add hl, de
	; top row
	ld a, TILE_BANK | BEHIND_BG | PAL_BG_TEXT
	ld bc, SCREEN_WIDTH - 1
	call ByteFill
	or X_FLIP
	ld [hli], a
	; middle rows
rept 2
	and $ff - X_FLIP
	ld [hli], a
	and $ff - TILE_BANK
	ld bc, SCREEN_WIDTH - 2
	call ByteFill
	or X_FLIP | TILE_BANK
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
	ld a, $f8
	ld [hli], a
	; top row
	inc a ; $f9
	call .FillTopBottom
	; top right
	dec a ; $f8
	ld [hli], a
	; left, first line
	ld a, $fb
	ld [hli], a
	; first line
	call .FillMiddle
	; right, first line
	ld [hli], a
	; left, second line
	inc a ; $fc
	ld [hli], a
	; second line
	call .FillMiddle
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

.FillMiddle: ; b815b
	push af
	ld a, $7f
	ld c, SCREEN_WIDTH - 2
.loop
	ld [hli], a
	dec c
	jr nz, .loop
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

PlaceMapNameCenterAlign: ; b80e1 (2e:40e1)
	ld a, [wCurrentLandmark]
	ld e, a
	farcall GetLandmarkName
	call .GetNameLength
	ld a, SCREEN_WIDTH
	sub c
	srl a
	ld b, $0
	ld c, a
	hlcoord 0, 2
	add hl, bc
	ld de, StringBuffer1
	jp PlaceString

.GetNameLength: ; b8101 (2e:4101)
	ld c, 0
	push hl
	ld hl, StringBuffer1
.loop
	ld a, [hli]
	cp "@"
	jr z, .stop
	cp "<NEXT>"
	jr z, .loop
	inc c
	jr .loop
.stop
	pop hl
	ret


CheckForHiddenItems: ; b8172
; Checks to see if there are hidden items on the screen that have not yet been found.  If it finds one, returns carry.
	ld a, [MapScriptHeaderBank]
	ld [Buffer1], a
; Get the coordinate of the bottom right corner of the screen.
	ld a, [XCoord]
	add SCREEN_WIDTH / 4
	ld [Buffer4], a
	ld a, [YCoord]
	add SCREEN_HEIGHT / 4
	ld [Buffer3], a
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
; Store the counter in Buffer2, and store the signpost header pointer in the stack.
	ld [Buffer2], a
	push hl
; Get the Y coordinate of the signpost.
	call .GetFarByte
	ld e, a
; Is the Y coordinate of the signpost on the screen?  If not, go to the next signpost.
	ld a, [Buffer3]
	sub e
	jr c, .next
	cp SCREEN_HEIGHT / 2
	jr nc, .next
; Is the X coordinate of the signpost on the screen?  If not, go to the next signpost.
	call .GetFarByte
	ld d, a
	ld a, [Buffer4]
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
	ld a, [Buffer2]
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
	ld a, [Buffer1]
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
	ld [ScriptVar], a
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
	ld [ScriptVar], a
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
	ld [TempWildMonSpecies], a
	ld [CurPartyLevel], a

	ld hl, TreeMonMaps
	call GetTreeMonSet
	jr nc, .no_battle

	call GetTreeMons
	jr nc, .no_battle

	call GetTreeMon
	jr nc, .no_battle

	ld a, BATTLETYPE_TREE
	ld [BattleType], a
	ld a, 1
	ld [ScriptVar], a
	ret

.no_battle
	xor a
	ld [ScriptVar], a
	ret
; b8219

RockMonEncounter: ; b8219

	xor a
	ld [TempWildMonSpecies], a
	ld [CurPartyLevel], a

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
	ld a, [MapNumber]
	ld e, a
	ld a, [MapGroup]
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
	ld [TempWildMonSpecies], a
	ld a, [hl]
	ld [CurPartyLevel], a
	scf
	ret

NoTreeMon: ; b843b
	xor a
	ld [TempWildMonSpecies], a
	ld [CurPartyLevel], a
	ret
; b8443

GetTreeScore: ; b8443
	call .CoordScore
	ld [Buffer1], a
	call .OTIDScore
	ld [Buffer2], a
	ld c, a
	ld a, [Buffer1]
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
	ld a, [PlayerID]
	ld [hDividend], a
	ld a, [PlayerID + 1]
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
	ld a, $1
	ld [rVBK], a

	ld de, FishingGFX
	ld a, [PlayerGender]
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
