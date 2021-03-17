_Squirtbottle:
	ld hl, .SquirtbottleScript
	call QueueScript
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret

.SquirtbottleScript:
	reloadmappart
	special UpdateTimePals
	callasm .CheckCanUseSquirtbottle
	iffalse .NothingHappenedScript
	farsjump WateredWeirdTreeScript

.NothingHappenedScript:
	farjumptext _SquirtbottleNothingText

.CheckCanUseSquirtbottle:
	ld a, [wMapGroup]
	cp GROUP_ROUTE_36
	jr nz, .nope

	ld a, [wMapNumber]
	cp MAP_ROUTE_36
	jr nz, .nope

	farcall GetFacingObject
	jr c, .nope

	ld a, d
	cp SPRITEMOVEDATA_SUDOWOODO
	jr nz, .nope

	ld a, $1
	ldh [hScriptVar], a
	ret

.nope
	xor a
	ldh [hScriptVar], a
	ret
