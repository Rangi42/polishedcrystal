ReturnFromMapSetupScript::
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

.CheckMovingWithinLandmark:
	ld a, [wCurrentLandmark]
	ld c, a
	ld a, [wPreviousLandmark]
	cp c
	ret z
	and a ; cp SPECIAL_MAP
	ret

.CheckSpecialMap:
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

.CheckNationalParkGate:
	ld a, [wMapGroup]
	cp GROUP_ROUTE_35_NATIONAL_PARK_GATE
	ret nz
	ld a, [wMapNumber]
	cp MAP_ROUTE_35_NATIONAL_PARK_GATE
	ret z
	cp MAP_ROUTE_36_NATIONAL_PARK_GATE
	ret

PlaceMapNameSign::
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

LoadMapNameSignGFX:
	; load opaque space
	ld hl, vTiles0 tile POPUP_MAP_FRAME_SPACE
	call GetOpaque1bppSpaceTile
	; load sign frame
	ld hl, vTiles0 tile POPUP_MAP_FRAME_START
	ld de, MapEntryFrameGFX
	lb bc, BANK(MapEntryFrameGFX), POPUP_MAP_FRAME_SIZE
	call Get2bpp
	; clear landmark name area
	ld hl, vTiles0 tile POPUP_MAP_NAME_START
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
	ld hl, vTiles3 tile POPUP_MAP_NAME_START
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

InitMapNameFrame:
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

.FillUpperMiddle:
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

.FillTopBottom:
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
