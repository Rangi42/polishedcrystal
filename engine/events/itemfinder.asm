ItemFinder: ; 12580
	farcall CheckForHiddenItems
	jr c, .found_something
	ld hl, .Script_FoundNothingNearby
	jr z, .resume
	ld hl, .Script_FoundNothingAtAll
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
	and $f ; taxicab distance, 0-15
	inc a ; 1-16
	cp 9
	jr c, .dist_ok
	ld a, 9 ; cap, 1-9
.dist_ok
	srl a ; 0-4
	ld c, a
	ld a, 5
	sub c ; 5-1
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
	and $f
	ld [hScriptVar], a
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
	iffalse_jumpopenedtext .UnderfootText
	thisopenedtext

	text "Yes! Itemfinder"
	line "is responding!"
	done

.UnderfootText:
	text "Oh! Itemfinder is"
	line "shaking wildly!"
	done
; 0x125ba

.Script_FoundNothingNearby:
	reloadmappart
	special UpdateTimePals
	thisopenedtext

	text "…Nope! Itemfinder"
	line "isn't responding."
	done

.Script_FoundNothingAtAll:
	reloadmappart
	special UpdateTimePals
	thisopenedtext

	text "Nope! There's no-"
	line "thing hidden here."
	done
