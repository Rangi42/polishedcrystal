CheckForHiddenItems:
; Checks to see if there are unfound hidden items on the screen.
; Returns nc if no item was found. Otherwise, return c.
; a has the following information if an item is found:
; bit 7: Item is on the same column (straight up or down)
; bit 6: Item is on the same row (straight left or right)
; bit 4-5: Direction (00=down 01=up 10=left 11=right)
; bit 0-3: Distance to item (taxicab)
	ld a, [wMapScriptsBank]
	ld [wBuffer1], a
	; Reset wBuffer4. This is used to figure out the closest item to the player.
	ld a, -1
	ld [wBuffer4], a
; Get the pointer for the first signpost header in the map...
	ld hl, wCurMapBGEventsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
; ... before even checking to see if there are any signposts on this map.
	ld a, [wCurMapBGEventCount]
	and a
	jr z, .nosignpostitems

; For i = 1:wCurMapBGEventCount...
.loop
; Store the counter in wBuffer2, and store the signpost header pointer in the stack.
	ld [wBuffer2], a
	push hl
; Get the Y coordinate of the signpost.
	call ItemFinder_GetFarByte
	ld e, a
; Is the Y coordinate of the signpost on the screen?  If not, go to the next signpost.
	ld a, [wYCoord]
	add SCREEN_HEIGHT / 4
	sub e
	jr c, .next_y
	cp SCREEN_HEIGHT / 2
	jr nc, .next_y
	ld [wBuffer3], a
; Is the X coordinate of the signpost on the screen?  If not, go to the next signpost.
	call ItemFinder_GetFarByte
	ld d, a
	ld a, [wXCoord]
	add SCREEN_WIDTH / 4
	sub d
	jr c, .next_x
	cp SCREEN_WIDTH / 2
	jr nc, .next_x
	swap a
	ld d, a
	ld a, [wBuffer3]
	or d
	ld [wBuffer3], a
; Is this signpost a hidden item?  If not, go to the next signpost.
	call IsHiddenItem
	jr nz, .next

	; If old buffer is -1, it's unused, so just write to it directly.
	; Otherwise, compare and figure out which one is closest.
	ld a, [wBuffer4]
	cp -2
	jr nc, .current_is_closer
	call CalculateItemDistance
	and $f
	ld c, a
	ld a, [wBuffer3]
	call CalculateItemDistance
	and $f
	cp c
	jr nc, .next
.current_is_closer
	ld a, [wBuffer3]
	ld [wBuffer4], a
	jr .next

.next_y
	call ItemFinder_GetFarByte
.next_x
	call IsHiddenItem
	jr nz, .next
	ld a, [wBuffer4]
	cp -2
	jr c, .next
	ld a, -2
	ld [wBuffer4], a

.next
; Restore the signpost header pointer and increment it by the length of a signpost header.
	pop hl
	ld bc, 5
	add hl, bc
; Restore the signpost counter and decrement it.  If it hits zero, there are no hidden items in range.
	ld a, [wBuffer2]
	dec a
	jr nz, .loop

	; Check if we found anything. Return carry if we did.
.nosignpostitems
	ld a, [wBuffer4]
	cp -2
	ret nc
	call CalculateItemDistance
	scf
	ret

IsHiddenItem:
; Returns nz if current object is not a hidden item we haven't found yet
	call ItemFinder_GetFarByte
	cp BGEVENT_GROTTOITEM
	jr z, .grotto
	cp BGEVENT_ITEM
	ret c
	call ItemFinder_GetFarByte
	ld e, a
	call ItemFinder_GetFarByte
	ld d, a
	jr .checkitem
.grotto
	call ItemFinder_GetFarByte
	call ItemFinder_GetFarByte
	ld de, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
.checkitem
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	ret

ItemFinder_GetFarByte:
	ld a, [wBuffer1]
	call GetFarByte
	inc hl
	ret

CalculateItemDistance:
; Calculate how close a is to the player.
; a: $xy (literally) where 0 is topleft and height (or width)/2 bottom right
	push hl
	push de
	push bc
	ld b, a
	and $f
	ld e, a
	ld a, b
	and $f0
	swap a
	ld d, a
	lb bc, SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4

	; bc: wh of player, de: wh of item

	; Compare them. h is set as follows:
	; Bit 7: Same column
	; Bit 6: Same row
	; Bit 3: Right
	; Bit 2: Left
	; Bit 1: Up
	; Bit 0: Down
	; Note that directions are the same as facing index order.
	ld h, %11000000
	ld a, c
	sub e
	jr z, .got_height
	res 6, h
	jr c, .negative_height

	set 0, h
	jr .got_height
.negative_height
	dec a
	cpl
	set 1, h
.got_height
	ld c, a
	ld a, b
	sub d
	jr nc, .positive_width

	set 2, h
	dec a
	cpl
.positive_width
	jr z, .got_width
	res 7, h
	set 3, h

.got_width
	; The direction we want to return is the one with the
	; biggest directional distance.
	ld b, a
	cp c
	jr nc, .left_right
	res 2, h
	res 3, h
	jr .got_direction
.left_right
	res 0, h
	res 1, h
.got_direction

	ld a, $f
	and h
	jr z, .skip
	; Store direction in bit 5-6
	ld a, h
	sub %10000
.loop
	add %10000
	srl h
	jr nc, .loop
.skip
	and $f0
	or b
	add c
	jmp PopBCDEHL
