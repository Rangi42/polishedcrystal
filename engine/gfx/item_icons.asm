UpdateItemIconAndDescription::
	farcall UpdateItemDescription
	jr UpdateItemIcon

UpdateTMHMIconAndDescriptionAndOwnership::
	farcall UpdateTMHMDescriptionAndOwnership
	ld a, [wMenuSelection]
	cp -1
	jr z, .cancel
	call LoadTMHMIcon
	jr .ok
.cancel
	call ClearTMHMIcon
.ok
	farcall LoadTMHMIconPalette
	jp SetPalettes

UpdateItemIconAndDescriptionAndBagQuantity::
	farcall UpdateItemDescriptionAndBagQuantity
UpdateItemIcon::
	ld hl, ItemIconPointers
	ld a, [wCurItem]
	cp NUM_ITEMS + 1
	jr c, .has_icon
	xor a
.has_icon
	call LoadItemOrKeyItemIcon
	farcall LoadItemIconPalette
	jp SetPalettes

UpdateKeyItemIconAndDescription::
	farcall UpdateKeyItemDescription
UpdateKeyItemIcon::
	ld hl, KeyItemIconPointers
	ld a, [wCurKeyItem]
	dec a
	call LoadItemOrKeyItemIcon
	farcall LoadKeyItemIconPalette
	jp SetPalettes

LoadItemOrKeyItemIcon:
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, vTiles2 tile $1e
	ld c, 9
	jp DecompressRequest2bpp

LoadTMHMIcon::
	ld hl, TMHMIcon
	ld de, vTiles2 tile $1e
	lb bc, BANK(TMHMIcon), 9
	jp DecompressRequest2bpp

ClearKeyItemIcon::
ClearTMHMIcon::
	ld hl, NoItemIcon
	ld de, vTiles2 tile $1e
	lb bc, BANK(NoItemIcon), 9
	jp DecompressRequest2bpp

INCLUDE "data/items/icon_pointers.asm"
