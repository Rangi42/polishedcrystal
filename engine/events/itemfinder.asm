ItemFinder: ; 12580
	farcall CheckForHiddenItems
	jr c, .found_something
	jr z, .ExistsInArea
	ld hl, .Script_FoundNothingAtAll
	jr .resume

.ExistsInArea:
	ld hl, .Script_FoundNothingNearby
	jr .resume

.found_something
	ld [wBuffer1], a
	ld hl, .Script_FoundSomething

.resume
	call QueueScript
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret
; 12599

.ItemfinderEffect: ; 12599
	ld a, [wBuffer1]
	and $f
	jr z, .beneath_you
	cp 9
	jr c, .dist_ok
	ld a, 9
.dist_ok
	srl a
	and a
	jr z, .no_decrement
	dec a
.no_decrement
	cpl
.beneath_you
	add 5
	ld c, a
.sfx_loop
	push bc
	ld de, SFX_SECOND_PART_OF_ITEMFINDER
	call WaitPlaySFX
	ld de, SFX_TRANSACTION
	call WaitPlaySFX
	pop bc
	dec c
	jr nz, .sfx_loop
	ld d, PLAYER
	ld a, [wBuffer1]
	rrca
	rrca
	ld e, a
	farjp ApplyPersonFacing
; 125ad

.Script_FoundSomething: ; 0x125ad
	reloadmappart
	special UpdateTimePals
	callasm .ItemfinderEffect
	writetext .Text_FoundSomething
	closetext
	end
; 0x125ba

.Script_FoundNothingNearby:
	reloadmappart
	special UpdateTimePals
	writetext .Text_FoundNothingNearby
	closetext
	end

.Script_FoundNothingAtAll:
	reloadmappart
	special UpdateTimePals
	writetext .Text_FoundNothingAtAll
	closetext
	end

.Text_FoundNothingAtAll:
	text "No response. There"
	line "seems to be no"
	cont "items in the area."
	prompt

.Text_FoundSomething: ; 0x125c3
	; Yes! ITEMFINDER indicates there's an item nearby.
	text_jump UnknownText_0x1c0a77
	db "@"
; 0x125c8

.Text_FoundNothingNearby: ; 0x125c8
	; Nope! ITEMFINDER isn't responding.
	text_jump UnknownText_0x1c0aa9
	db "@"
; 0x125cd
