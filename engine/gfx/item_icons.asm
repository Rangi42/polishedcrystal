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
	jmp SetDefaultBGPAndOBP

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
	jmp SetDefaultBGPAndOBP

UpdateExpCandyIconAndDescriptionAndBagQuantity::
	farcall UpdateExpCandyDescriptionAndBagQuantity
	ld hl, ExpCandyIconPointers
	ld a, [wCurItem]
	cp NUM_CANDIES + 1
	jr c, .has_icon
	xor a
.has_icon
	call _LoadItemOrKeyItemIcon
	farcall LoadExpCandyIconPalette
	jmp SetDefaultBGPAndOBP
	ret

UpdateKeyItemIconAndDescription::
	farcall UpdateKeyItemDescription
_UpdateKeyItemIcon:
	ld hl, KeyItemIconPointers
	ld a, [wCurItem]
	call _LoadItemOrKeyItemIcon
	farcall LoadKeyItemIconPalette
	jmp SetDefaultBGPAndOBP

LoadApricornIconForOverworld:
	ld hl, ApricornIcon
	lb bc, BANK(ApricornIcon), 9
	ld de, vTiles0 tile "▲"
	jmp DecompressRequest2bpp

LoadItemIconForOverworld::
	ld hl, ItemIconPointers
_LoadItemOrKeyItemIconForOverworld:
	call _SetupLoadItemOrKeyItemIcon
DecompressItemIconForOverworld::
	push bc
	call FarDecompressWRA6InB
	call WhiteOutDecompressedItemIconCorners
	pop bc
	ld hl, vTiles0 tile "▲"
	ld de, wDecompressScratch
	jmp Request2bppInWRA6

LoadItemIconForSummaryScreen::
	ld hl, ItemIconPointers
	call _SetupLoadItemOrKeyItemIcon
	push bc
	call FarDecompressWRA6InB
	call WhiteOutDecompressedItemIconCorners
	pop bc
	ld hl, vTiles2 tile SUMMARY_TILE_ITEM
	ld de, wDecompressScratch
	jmp Request2bppInWRA6

LoadTMHMIcon::
	ld hl, TMHMIcon
	lb bc, BANK(TMHMIcon), 9
	jr _LoadItemIcon

ClearTMHMIcon::
	ld hl, NoItemIcon
	lb bc, BANK(NoItemIcon), 9
	jr _LoadItemIcon

_LoadItemOrKeyItemIcon:
	call _SetupLoadItemOrKeyItemIcon
_LoadItemIcon:
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

ShowSpecialItemIcon::
	ld a, [wCurSpecialItem]
	ld hl, SpecialItemIconPointers
	call _LoadItemOrKeyItemIconForOverworld
	farcall LoadSpecialItemIconPalette
	jr PrintOverworldItemIcon

ShowParkBallIcon::
	ld hl, ParkBallIcon
	lb bc, BANK(ParkBallIcon), 9
	call DecompressItemIconForOverworld
	ld hl, ParkBallIconPalette
	farcall LoadIconPaletteFromHL
	jr PrintOverworldItemIcon

ShowItemIcon::
	ld a, [wCurItem]
	call LoadItemIconForOverworld
	farcall LoadItemIconPalette
	jr PrintOverworldItemIcon

ShowKeyItemIcon::
	ld a, [wCurKeyItem]
	ld hl, KeyItemIconPointers
	call _LoadItemOrKeyItemIconForOverworld
	farcall LoadKeyItemIconPalette
	jr PrintOverworldItemIcon

ShowTMHMIcon::
	ld a, [wCurTMHM]
	ld hl, TMHMIcon
	lb bc, BANK(TMHMIcon), 9
	call DecompressItemIconForOverworld
	farcall LoadTMHMIconPalette
	; fallthrough
PrintOverworldItemIcon:
	call SetDefaultBGPAndOBP
	ld a, "▲"
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
