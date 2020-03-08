DisableSpriteUpdates::
	xor a
	ld [hMapAnims], a
	ld [wSpriteUpdatesEnabled], a
	ld a, [wVramState]
	res 0, a
	ld [wVramState], a
	ret

EnableSpriteUpdates::
	ld a, $1
	ld [wSpriteUpdatesEnabled], a
	ld [hMapAnims], a
	ld a, [wVramState]
	set 0, a
	ld [wVramState], a
	ret
