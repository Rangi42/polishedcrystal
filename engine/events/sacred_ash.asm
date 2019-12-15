_SacredAsh: ; 507e6
	xor a
	ld [wItemEffectSucceeded], a
	call CheckAnyFaintedMon
	ret nc

	ld hl, SacredAshScript
	call QueueScript
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret
; 507fb

CheckAnyFaintedMon: ; 507fb
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
; 50821

SacredAshScript: ; 0x50821
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
	writetext UnknownText_0x50845
	playsound SFX_CAUGHT_MON
	waitsfx
	waitendtext
; 0x50845

UnknownText_0x50845: ; 0x50845
	; 's #MON were all healed!
	text_jump UnknownText_0x1c0b65
	db "@"
; 0x5084a
