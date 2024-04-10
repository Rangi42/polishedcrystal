ClearSprites::
; Erase OAM data
	ld hl, wShadowOAM
	ld bc, wShadowOAMEnd - wShadowOAM
	xor a
	rst ByteFill
	ret

HideSprites::
; Set all OAM y-positions to 160 to hide them offscreen
	ld hl, wShadowOAM
	ld de, 4 ; length of an OAM struct
	ld b, (wShadowOAMEnd - wShadowOAM) / 4 ; number of OAM structs
	ld a, OAM_YCOORD_HIDDEN
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	ret

HideNormalSprites::
; Set all normal sprites (non-weather) to 160 to hide them offscreen
	ldh a, [hUsedOAMIndex]
	cpl
	add (NUM_SPRITE_OAM_STRUCTS * SPRITEOAMSTRUCT_LENGTH) + 1
	ld h, HIGH(wShadowOAM)
	ld l, a
	ld de, SPRITEOAMSTRUCT_LENGTH
	rra
	rra ; / 4
	ld b, a
	ld a, NUM_SPRITE_OAM_STRUCTS
	sub b
	ld b, a
.loop
	ld [hl], SCREEN_HEIGHT_PX + (2 * TILE_WIDTH)
	add hl, de
	dec b
	jr nz, .loop
	ret

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