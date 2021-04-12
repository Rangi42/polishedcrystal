UpdateItemIconAndDescription::
	farcall UpdateItemDescription
	jr _UpdateItemIcon

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
	jmp SetPalettes

UpdateItemIconAndDescriptionAndBagQuantity::
	farcall UpdateItemDescriptionAndBagQuantity
_UpdateItemIcon:
	ld hl, ItemIconPointers
	ld a, [wCurItem]
	cp NUM_ITEMS + 1
	jr c, .has_icon
	xor a
.has_icon
	call _LoadItemOrKeyItemIcon
	farcall LoadItemIconPalette
	jmp SetPalettes

UpdateKeyItemIconAndDescription::
	farcall UpdateKeyItemDescription
_UpdateKeyItemIcon:
	ld hl, KeyItemIconPointers
	ld a, [wCurKeyItem]
	dec a
	call _LoadItemOrKeyItemIcon
	farcall LoadKeyItemIconPalette
	jmp SetPalettes

LoadApricornIconForOverworld:
	ld hl, ApricornIcon
	lb bc, BANK(ApricornIcon), 9
	ld de, vTiles1 tile $6d
	jmp DecompressRequest2bpp

LoadKeyItemIconForOverworld::
	ld hl, KeyItemIconPointers
	jr _LoadItemOrKeyItemIconForOverworld

LoadTMHMIconForOverworld::
	ld hl, TMHMIcon
	lb bc, BANK(TMHMIcon), 9
	jr _DecompressItemIconForOverworld

LoadItemIconForOverworld::
	ld hl, ItemIconPointers
_LoadItemOrKeyItemIconForOverworld:
	call _SetupLoadItemOrKeyItemIcon
_DecompressItemIconForOverworld:
	push bc
	call FarDecompressWRA6InB
	call WhiteOutDecompressedItemIconCorners
	pop bc
	ld hl, vTiles1 tile $6d
	ld de, wDecompressScratch
	jmp Request2bppInWRA6

_LoadItemOrKeyItemIcon:
	call _SetupLoadItemOrKeyItemIcon
	ld de, vTiles2 tile $1e
	jmp DecompressRequest2bpp

_SetupLoadItemOrKeyItemIcon:
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld c, 9
	ret

LoadTMHMIcon::
	ld hl, TMHMIcon
	lb bc, BANK(TMHMIcon), 9
	ld de, vTiles2 tile $1e
	jmp DecompressRequest2bpp

ClearKeyItemIcon::
ClearTMHMIcon::
	ld hl, NoItemIcon
	lb bc, BANK(NoItemIcon), 9
	ld de, vTiles2 tile $1e
	jmp DecompressRequest2bpp

WhiteOutDecompressedItemIconCorners:
	call RunFunctionInWRA6
.Function:
	lb bc, %01111111, %11111110
	ld hl, wDecompressScratch tile 0
	ld a, [hl]
	and b
	ld [hli], a
	ld a, [hl]
	and b
	ld [hl], a
	ld hl, wDecompressScratch tile 2
	ld a, [hl]
	and c
	ld [hli], a
	ld a, [hl]
	and c
	ld [hl], a
	ld hl, wDecompressScratch tile 6 + 7 * 2
	ld a, [hl]
	and b
	ld [hli], a
	ld a, [hl]
	and b
	ld [hl], a
	ld hl, wDecompressScratch tile 8 + 7 * 2
	ld a, [hl]
	and c
	ld [hli], a
	ld a, [hl]
	and c
	ld [hl], a
	ret

PrintOverworldItemIcon:
	call SetPalettes
	ld a, $ed
	hlcoord 16, 13
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	hlcoord 16, 14
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	hlcoord 16, 15
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	ret

INCLUDE "data/items/icon_pointers.asm"
