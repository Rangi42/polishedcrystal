_SacredAsh:
	xor a
	ld [wItemEffectSucceeded], a
	call CheckAnyFaintedMon
	ret nc

	ld hl, SacredAshScript
	call QueueScript
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret

CheckAnyFaintedMon:
	ld de, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1HP
	ld a, [wPartyCount]
	and a
	ret z

.loop
	push af
	push hl
	ld bc, wPartyMon1IsEgg - wPartyMon1HP
	add hl, bc
	bit MON_IS_EGG_F, [hl]
	pop hl
	push hl
	jr nz, .next

	ld a, [hli]
	or [hl]
	jr z, .done

.next
	pop hl
	add hl, de
	pop af
	dec a
	jr nz, .loop
	xor a
	ret

.done
	pop hl
	pop af
	scf
	ret

SacredAshScript:
	special HealParty
	reloadmappart
	playsound SFX_WARP_TO
rept 3
	special FadeOutPalettes
	special LoadMapPalettes
	special FadeInPalettes
endr
	waitsfx
	opentext
	farwritetext _UseSacredAshText
	playsound SFX_CAUGHT_MON
	waitsfx
	waitendtext
