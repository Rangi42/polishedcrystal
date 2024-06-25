ClearSprites::
; Erase OAM data
	ld hl, wShadowOAM
	ld bc, wShadowOAMEnd - wShadowOAM
	xor a
	rst ByteFill
	ret

ClearNormalSprites::
	ldh a, [hUsedOAMIndex]
	ld c, a
	; a = (NUM_SPRITE_OAM_STRUCTS * SPRITEOAMSTRUCT_LENGTH) - a
	cpl
	add NUM_SPRITE_OAM_STRUCTS * SPRITEOAMSTRUCT_LENGTH + 1
	ld h, HIGH(wShadowOAM)
	ld l, a
	xor a
	ld b, a
	rst ByteFill
	ret

HideSprites::
; Set all OAM y-positions to 160 to hide them offscreen
	ld hl, wShadowOAM
	ld b, NUM_SPRITE_OAM_STRUCTS
HideSpritesInRange::
	ld de, SPRITEOAMSTRUCT_LENGTH
	ld a, OAM_YCOORD_HIDDEN
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	ret

HidePlayerSprite::
; Set player sprite to 160 to hide it offscreen
	ld h, HIGH(wShadowOAM)
	ld a, [wPlayerCurrentOAMSlot]
	ld l, a
	ld de, SPRITEOAMSTRUCT_LENGTH
	ld b, 4
	ld a, OAM_YCOORD_HIDDEN
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	ret


FadeToMenu_BackupSprites::
	call FadeToMenu
BackupSprites::
; Copy wShadowOAM to wShadowOAMBackup
	ldh a, [rSVBK]
	push af
	ld a, BANK(wShadowOAMBackup)
	ldh [rSVBK], a
	ld hl, wShadowOAM
	ld de, wShadowOAMBackup
	ld bc, wShadowOAMEnd - wShadowOAM
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	ret

RestoreSprites::
	; Copy wShadowOAMBackup to wShadowOAM
	ldh a, [rSVBK]
	push af
	ld a, BANK(wShadowOAMBackup)
	ldh [rSVBK], a
	ld hl, wShadowOAMBackup
	ld de, wShadowOAM
	ld bc, wShadowOAMEnd - wShadowOAM
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	ret
