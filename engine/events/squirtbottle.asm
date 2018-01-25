_Squirtbottle: ; 50730
	ld hl, .SquirtbottleScript
	call QueueScript
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret
; 5073c

.SquirtbottleScript: ; 0x5073c
	reloadmappart
	special UpdateTimePals
	callasm .CheckCanUseSquirtbottle
	iffalse .NothingHappenedScript
	farjump WateredWeirdTreeScript
; 0x5074b

.NothingHappenedScript: ; 0x5074b
	jumptext .NothingHappenedText
; 0x5074e

.NothingHappenedText: ; 0x5074e
	; sprinkled water. But nothing happened…
	text_jump UnknownText_0x1c0b3b
	db "@"
; 0x50753

.CheckCanUseSquirtbottle: ; 50753
	ld a, [MapGroup]
	cp GROUP_ROUTE_36
	jr nz, .nope

	ld a, [MapNumber]
	cp MAP_ROUTE_36
	jr nz, .nope

	farcall GetFacingObject
	jr c, .nope

	ld a, d
	cp SPRITEMOVEDATA_SUDOWOODO
	jr nz, .nope

	ld a, $1
	ld [ScriptVar], a
	ret

.nope
	xor a
	ld [ScriptVar], a
	ret
; 50779
