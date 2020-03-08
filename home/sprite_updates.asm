DisableSpriteUpdates::
	xor a
	ldh [hMapAnims], a
	ld [wSpriteUpdatesEnabled], a
	ld a, [wVramState]
	res 0, a
	ld [wVramState], a
	ret

EnableSpriteUpdates::
	ld a, $1
	ld [wSpriteUpdatesEnabled], a
	ldh [hMapAnims], a
	ld a, [wVramState]
	set 0, a
	ld [wVramState], a
	ret
