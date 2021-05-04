InitDecorations:
	ld a, DECO_FEATHERY_BED
	ld [wDecoBed], a
	ld a, DECO_TOWN_MAP
	ld [wDecoPoster], a
	ret

_PlayerDecorationMenu:
	ld a, [wWhichIndexSet]
	push af
	ld hl, .MenuHeader
	call LoadMenuHeader
	xor a
	ld [wBuffer5], a
	ld a, $1
	ld [wBuffer6], a
.top_loop
	ld a, [wBuffer6]
	ld [wMenuCursorBuffer], a
	call .FindCategoriesWithOwnedDecos
	call DoNthMenu
	ld a, [wMenuCursorY]
	ld [wBuffer6], a
	jr c, .exit_menu
	ld a, [wMenuSelection]
	ld hl, .category_pointers
	call MenuJumptable
	jr nc, .top_loop

.exit_menu
	call ExitMenu
	pop af
	ld [wWhichIndexSet], a
	ld a, [wBuffer5]
	ld c, a
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 5, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 0 ; items
	dw wNumOwnedDecoCategories
	dw PlaceNthMenuStrings
	dw .category_pointers

.category_pointers:
	table_width 2 + 2, _PlayerDecorationMenu.category_pointers
	dw DecoBedMenu,      .bed
	dw DecoCarpetMenu,   .carpet
	dw DecoPlantMenu,    .plant
	dw DecoPosterMenu,   .poster
	dw DecoConsoleMenu,  .game
	dw DecoOrnamentMenu, .ornament
	dw DecoBigDollMenu,  .big_doll
	dw DecoExitMenu,     .exit
	assert_table_length NUM_DECO_CATEGORIES + 1

.bed:      db "Bed@"
.carpet:   db "Carpet@"
.plant:    db "Plant@"
.poster:   db "Poster@"
.game:     db "Game Console@"
.ornament: db "Ornament@"
.big_doll: db "Big Doll@"
.exit:     db "Exit@"

.FindCategoriesWithOwnedDecos:
	xor a
	ld [wWhichIndexSet], a
	call .ClearStringBuffer2
	call .FindOwndDecos
	ld a, 7
	call .AppendToStringBuffer2
	ld hl, wStringBuffer2
	ld de, wDecoNameBuffer
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes
	ret

.ClearStringBuffer2:
	ld hl, wStringBuffer2
	xor a
	ld [hli], a
	ld bc, ITEM_NAME_LENGTH - 1
	ld a, -1
	rst ByteFill
	ret

.AppendToStringBuffer2:
	ld hl, wStringBuffer2
	inc [hl]
	ld e, [hl]
	ld d, 0
	add hl, de
	ld [hl], a
	ret

.FindOwndDecos:
	ld hl, .owned_pointers
.loop
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	ret z

	push hl
	call _de_
	pop hl
	jr nc, .next
	ld a, [hl]
	push hl
	call .AppendToStringBuffer2
	pop hl
.next
	inc hl
	jr .loop

.owned_pointers:
	table_width 3, _PlayerDecorationMenu.owned_pointers
	dwb FindOwnedBeds,      0 ; bed
	dwb FindOwnedCarpets,   1 ; carpet
	dwb FindOwnedPlants,    2 ; plant
	dwb FindOwnedPosters,   3 ; poster
	dwb FindOwnedConsoles,  4 ; game console
	dwb FindOwnedOrnaments, 5 ; ornament
	dwb FindOwnedBigDolls,  6 ; big doll
	assert_table_length NUM_DECO_CATEGORIES
	dw 0 ; end

Deco_FillTempWithMinusOne:
	xor a
	ld hl, wNumOwnedDecoCategories
	ld [hli], a
	ld a, -1
	ld bc, $10
	rst ByteFill
	ret

CheckAllDecorationFlags:
.loop
	ld a, [hli]
	cp -1
	ret z

	push hl
	push af
	ld b, CHECK_FLAG
	call DecorationFlagAction
	ld a, c
	and a
	pop bc
	ld a, b
	call nz, AppendDecoIndex
	pop hl
	jr .loop

AppendDecoIndex:
	ld hl, wNumOwnedDecoCategories
	inc [hl]
	ld e, [hl]
	ld d, $0
	add hl, de
	ld [hl], a
	ret

FindOwnedDecosInCategory:
	push bc
	push hl
	call Deco_FillTempWithMinusOne
	pop hl
	call CheckAllDecorationFlags
	pop bc
	ld a, [wNumOwnedDecoCategories]
	and a
	ret z

	ld a, c
	call AppendDecoIndex
	xor a
	call AppendDecoIndex
	scf
	ret

DecoBedMenu:
	call FindOwnedBeds
	call PopulateDecoCategoryMenu
	xor a
	ret

FindOwnedBeds:
	ld hl, .beds
	ld c, BEDS
	jr FindOwnedDecosInCategory

.beds:
	db DECO_FEATHERY_BED ; 2
	db DECO_PINK_BED ; 3
	db DECO_POLKADOT_BED ; 4
	db DECO_PIKACHU_BED ; 5
	db -1

DecoCarpetMenu:
	call FindOwnedCarpets
	call PopulateDecoCategoryMenu
	xor a
	ret

FindOwnedCarpets:
	ld hl, .carpets
	ld c, CARPETS
	jr FindOwnedDecosInCategory

.carpets:
	db DECO_RED_CARPET ; 7
	db DECO_BLUE_CARPET ; 8
	db DECO_YELLOW_CARPET ; 9
	db DECO_GREEN_CARPET ; a
	db -1

DecoPlantMenu:
	call FindOwnedPlants
	call PopulateDecoCategoryMenu
	xor a
	ret

FindOwnedPlants:
	ld hl, .plants
	ld c, PLANTS
	jr FindOwnedDecosInCategory

.plants:
	db DECO_MAGNAPLANT ; c
	db DECO_TROPICPLANT ; d
	db DECO_JUMBOPLANT ; e
	db -1

DecoPosterMenu:
	call FindOwnedPosters
	call PopulateDecoCategoryMenu
	xor a
	ret

FindOwnedPosters:
	ld hl, .posters
	ld c, POSTERS
	jr FindOwnedDecosInCategory

.posters:
	db DECO_TOWN_MAP ; 10
	db DECO_DIPLOMA ; 11
	db DECO_PIKACHU_POSTER ; 12
	db DECO_CLEFAIRY_POSTER ; 13
	db DECO_MARILL_POSTER ; 14
	db -1

DecoConsoleMenu:
	call FindOwnedConsoles
	call PopulateDecoCategoryMenu
	xor a
	ret

FindOwnedConsoles:
	ld hl, .consoles
	ld c, CONSOLES
	jr FindOwnedDecosInCategory

.consoles:
	db DECO_SNES ; 15
	db DECO_N64 ; 16
	db DECO_GAMECUBE ; 17
	db DECO_WII ; 18
	db -1

DecoOrnamentMenu:
	call FindOwnedOrnaments
	call PopulateDecoCategoryMenu
	xor a
	ret

FindOwnedOrnaments:
	ld hl, .ornaments
	ld c, DOLLS
	jmp FindOwnedDecosInCategory

.ornaments:
	db DECO_PIKACHU_DOLL ; 1e
	db DECO_RAICHU_DOLL ; 1f
	db DECO_SURF_PIKACHU_DOLL ; 20
	db DECO_CLEFAIRY_DOLL ; 21
	db DECO_JIGGLYPUFF_DOLL ; 22
	db DECO_BULBASAUR_DOLL ; 23
	db DECO_CHARMANDER_DOLL ; 24
	db DECO_SQUIRTLE_DOLL ; 25
	db DECO_CHIKORITA_DOLL ; 26
	db DECO_CYNDAQUIL_DOLL ; 27
	db DECO_TOTODILE_DOLL ; 28
	db DECO_POLIWAG_DOLL ; 29
	db DECO_MAREEP_DOLL ; 2a
	db DECO_TOGEPI_DOLL ; 2b
	db DECO_MAGIKARP_DOLL ; 2c
	db DECO_ODDISH_DOLL ; 2d
	db DECO_GENGAR_DOLL ; 2e
	db DECO_OCTILLERY_DOLL ; 2f
	db DECO_DITTO_DOLL ; 30
	db DECO_VOLTORB_DOLL ; 31
	db DECO_ABRA_DOLL ; 32
	db DECO_UNOWN_DOLL ; 33
	db DECO_GEODUDE_DOLL ; 34
	db DECO_PINECO_DOLL ; 35
	db DECO_MARILL_DOLL ; 36
	db DECO_TEDDIURSA_DOLL ; 37
	db DECO_MEOWTH_DOLL ; 38
	db DECO_VULPIX_DOLL ; 39
	db DECO_GROWLITHE_DOLL ; 3a
	db DECO_EEVEE_DOLL ; 3b
	db DECO_GOLD_TROPHY_DOLL ; 3c
	db DECO_SILVER_TROPHY_DOLL ; 3d
	db -1

DecoBigDollMenu:
	call FindOwnedBigDolls
	call PopulateDecoCategoryMenu
	xor a
	ret

FindOwnedBigDolls:
	ld hl, .big_dolls
	ld c, BIG_DOLLS
	jmp FindOwnedDecosInCategory

.big_dolls:
	db DECO_BIG_SNORLAX_DOLL ; 1a
	db DECO_BIG_ONIX_DOLL ; 1b
	db DECO_BIG_LAPRAS_DOLL ; 1c
	db -1

DecoExitMenu:
	scf
	ret

PopulateDecoCategoryMenu:
	ld a, [wNumOwnedDecoCategories]
	and a
	jr z, .empty
	cp 8
	jr nc, .beyond_eight
	xor a
	ld [wWhichIndexSet], a
	ld hl, .NonscrollingMenuHeader
	call LoadMenuHeader
	call DoNthMenu
	call nc, DoDecorationAction2
	jmp ExitMenu

.beyond_eight
	ld hl, wNumOwnedDecoCategories
	ld e, [hl]
	dec [hl]
	ld d, 0
	add hl, de
	ld [hl], -1
	call LoadStandardMenuHeader
	ld hl, .ScrollingMenuHeader
	call CopyMenuHeader
	xor a
	ldh [hBGMapMode], a
	call InitScrollingMenu
	xor a
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp 2
	call nz, DoDecorationAction2
	jmp ExitMenu

.empty
	ld hl, .NothingToChooseText
	jmp MenuTextboxBackup

.NothingToChooseText:
	; There's nothing to choose.
	text_far _NothingToChooseText
	text_end

.NonscrollingMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .NonscrollingMenuData
	db 1 ; default option

.NonscrollingMenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP
	db 0 ; items
	dw wDecoNameBuffer
	dw DecorationMenuFunction
	dw DecorationAttributes

.ScrollingMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 1, SCREEN_WIDTH - 2, SCREEN_HEIGHT - 2
	dw .ScrollingMenuData
	db 1 ; default option

.ScrollingMenuData:
	db SCROLLINGMENU_DISPLAY_ARROWS ; flags
	db 8, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; horizontal spacing
	dbw 0, wDecoNameBuffer ; text pointer
	dba DecorationMenuFunction
	dbw 0, 0
	dbw 0, 0

GetDecorationData:
	ld hl, DecorationAttributes
	ld bc, 6
	rst AddNTimes
	ret

GetDecorationName:
	push hl
	call GetDecorationData
	call GetDecoName
	pop hl
	jmp CopyName2

DecorationMenuFunction:
	ld a, [wMenuSelection]
	push de
	call GetDecorationData
	call GetDecoName
	pop hl
	rst PlaceString
	ret

DoDecorationAction2:
	ld a, [wMenuSelection]
	call GetDecorationData
	ld de, 2 ; function 2
	add hl, de
	ld a, [hl]
	call StackJumpTable

.DecoActions:
	table_width 2, DoDecorationAction2.DecoActions
	dw DecoAction_nothing
	dw DecoAction_setupbed
	dw DecoAction_putawaybed
	dw DecoAction_setupcarpet
	dw DecoAction_putawaycarpet
	dw DecoAction_setupplant
	dw DecoAction_putawayplant
	dw DecoAction_setupposter
	dw DecoAction_putawayposter
	dw DecoAction_setupconsole
	dw DecoAction_putawayconsole
	dw DecoAction_setupbigdoll
	dw DecoAction_putawaybigdoll
	dw DecoAction_setupornament
	dw DecoAction_putawayornament
	assert_table_length NUM_DECO_ACTIONS + 1

GetDecorationFlag:
	call GetDecorationData
	ld de, 3 ; event flag
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ret

DecorationFlagAction:
	push bc
	call GetDecorationFlag
	pop bc
	jmp EventFlagAction

GetDecorationSprite:
	ld a, c
	call GetDecorationData
	ld de, 5 ; sprite
	add hl, de
	ld a, [hl]
	ld c, a
	ret

GetDecorationSpecies::
	call GetDecorationData
	inc hl
	ld a, [hl]
	ret

_GetDecorationSprite:
	ld c, a
	push de
	push hl
	call GetDecorationSprite
	pop hl
	pop de
	ld a, c
	ret

INCLUDE "data/decorations/attributes.asm"

INCLUDE "data/decorations/names.asm"

GetDecoName:
	ld a, [hli]
	ld e, [hl]
	ld bc, wStringBuffer2
	push bc
	ld hl, .NameFunctions
	call JumpTable
	pop de
	ret

.NameFunctions:
	table_width 2, GetDecoName.NameFunctions
	dw DoNothing
	dw .plant
	dw .bed
	dw .carpet
	dw .poster
	dw .doll
	dw .bigdoll
	assert_table_length NUM_DECO_TYPES + 1

.plant:
	ld a, e
	jr .getdeconame

.bed:
	call .plant
	ld a, _BED
	jr .getdeconame

.carpet:
	call .plant
	ld a, _CARPET
	jr .getdeconame

.poster:
	ld a, e
	call .getpokename
	ld a, _POSTER
	jr .getdeconame

.doll:
	ld a, e
	call .getpokename
	ld a, _DOLL
	jr .getdeconame

.bigdoll:
	push de
	ld a, BIG_
	call .getdeconame
	pop de
	ld a, e
	; fallthrough
.getpokename:
	push bc
	ld [wNamedObjectIndex], a
	call GetPokemonName
	pop bc
	jr .copy

.getdeconame:
	call ._getdeconame
	jr .copy

._getdeconame:
	push bc
	ld hl, DecorationNames
	call GetNthString
	ld d, h
	ld e, l
	pop bc
	ret

.copy:
	ld h, b
	ld l, c
	call CopyName2
	dec hl
	ld b, h
	ld c, l
	ret

DecoAction_nothing:
	scf
	ret

DecoAction_setupbed:
	ld hl, wDecoBed
	jr DecoAction_TrySetItUp

DecoAction_putawaybed:
	ld hl, wDecoBed
	jmp DecoAction_TryPutItAway

DecoAction_setupcarpet:
	ld hl, wDecoCarpet
	jr DecoAction_TrySetItUp

DecoAction_putawaycarpet:
	ld hl, wDecoCarpet
	jmp DecoAction_TryPutItAway

DecoAction_setupplant:
	ld hl, wDecoPlant
	jr DecoAction_TrySetItUp

DecoAction_putawayplant:
	ld hl, wDecoPlant
	jr DecoAction_TryPutItAway

DecoAction_setupposter:
	ld hl, wDecoPoster
	jr DecoAction_TrySetItUp

DecoAction_putawayposter:
	ld hl, wDecoPoster
	jr DecoAction_TryPutItAway

DecoAction_setupconsole:
	ld hl, wDecoConsole
	jr DecoAction_TrySetItUp

DecoAction_putawayconsole:
	ld hl, wDecoConsole
	jr DecoAction_TryPutItAway

DecoAction_setupbigdoll:
	ld hl, wDecoBigDoll
	jr DecoAction_TrySetItUp

DecoAction_putawaybigdoll:
	ld hl, wDecoBigDoll
	jr DecoAction_TryPutItAway

DecoAction_TrySetItUp:
	ld a, [hl]
	ld [wBuffer1], a
	push hl
	call DecoAction_SetItUp
	jr c, .failed
	ld a, 1
	ld [wBuffer5], a
	pop hl
	ld a, [wMenuSelection]
	ld [hl], a
	xor a
	ret

.failed
	pop hl
	xor a
	ret

DecoAction_SetItUp:
; See if there's anything of the same type already out
	ld a, [wBuffer1]
	and a
	jr z, .nothingthere
; See if that item is already out
	ld b, a
	ld a, [wMenuSelection]
	cp b
	jr z, .alreadythere
; Put away the item that's already out, and set up the new one
	ld a, [wMenuSelection]
	ld hl, wStringBuffer4
	call GetDecorationName
	ld a, [wBuffer1]
	ld hl, wStringBuffer3
	call GetDecorationName
	ld hl, DecoText_PutAwayAndSetUp
	call MenuTextboxBackup
	xor a
	ret

.nothingthere
	ld a, [wMenuSelection]
	ld hl, wStringBuffer3
	call GetDecorationName
	ld hl, DecoText_SetUpTheDeco
	call MenuTextboxBackup
	xor a
	ret

.alreadythere
	ld hl, DecoText_AlreadySetUp
	call MenuTextboxBackup
	scf
	ret

DecoAction_TryPutItAway:
; If there is no item of that type already set, there is nothing to put away.
	ld a, [hl]
	ld [wBuffer1], a
	xor a
	ld [hl], a
	ld a, [wBuffer1]
	and a
	jr z, .nothingthere
; Put it away.
	ld a, $1
	ld [wBuffer5], a
	ld a, [wBuffer1]
	ld [wMenuSelection], a
	ld hl, wStringBuffer3
	call GetDecorationName
	ld hl, DecoText_PutAwayTheDeco
	call MenuTextboxBackup
	xor a
	ret

.nothingthere
	ld hl, DecoText_NothingToPutAway
	call MenuTextboxBackup
	xor a
	ret

DecoAction_setupornament:
	ld hl, WhichSidePutOnText
	call DecoAction_AskWhichSide
	jr c, .cancel
	call DecoAction_SetItUp_Ornament
	jr c, .cancel
	ld a, $1
	ld [wBuffer5], a
	jr DecoAction_FinishUp_Ornament

.cancel
	xor a
	ret

DecoAction_putawayornament:
	ld hl, WhichSidePutAwayText
	call DecoAction_AskWhichSide
	jr nc, .incave
	xor a
	ret

.incave
	call DecoAction_PutItAway_Ornament
	; fallthrough

DecoAction_FinishUp_Ornament:
	call QueryWhichSide
	ld a, [wBuffer3]
	ld [hl], a
	ld a, [wBuffer4]
	ld [de], a
	xor a
	ret

DecoAction_SetItUp_Ornament:
	ld a, [wBuffer3]
	and a
	jr z, .nothingthere
	ld b, a
	ld a, [wMenuSelection]
	cp b
	jr z, .failed
	ld a, b
	ld hl, wStringBuffer3
	call GetDecorationName
	ld a, [wMenuSelection]
	ld hl, wStringBuffer4
	call GetDecorationName
	ld a, [wMenuSelection]
	ld [wBuffer3], a
	call .getwhichside
	ld hl, DecoText_PutAwayAndSetUp
	call MenuTextboxBackup
	xor a
	ret

.nothingthere
	ld a, [wMenuSelection]
	ld [wBuffer3], a
	call .getwhichside
	ld a, [wMenuSelection]
	ld hl, wStringBuffer3
	call GetDecorationName
	ld hl, DecoText_SetUpTheDeco
	call MenuTextboxBackup
	xor a
	ret

.failed
	ld hl, DecoText_AlreadySetUp
	call MenuTextboxBackup
	scf
	ret

.getwhichside
	ld a, [wMenuSelection]
	ld b, a
	ld a, [wBuffer4]
	cp b
	ret nz
	xor a
	ld [wBuffer4], a
	ret

WhichSidePutOnText:
	text_far _WhichSidePutOnText
	text_end

DecoAction_PutItAway_Ornament:
	ld a, [wBuffer3]
	and a
	jr z, .nothingthere
	ld hl, wStringBuffer3
	call GetDecorationName
	ld a, $1
	ld [wBuffer5], a
	xor a
	ld [wBuffer3], a
	ld hl, DecoText_PutAwayTheDeco
	call MenuTextboxBackup
	xor a
	ret

.nothingthere
	ld hl, DecoText_NothingToPutAway
	call MenuTextboxBackup
	xor a
	ret

WhichSidePutAwayText:
	text_far _WhichSidePutAwayText
	text_end

DecoAction_AskWhichSide:
	call MenuTextbox
	ld hl, WhichSideMenuHeader
	call GetMenu2
	call ExitMenu
	call CopyMenuData2
	jr c, .nope
	ld a, [wMenuCursorY]
	cp 3
	jr z, .nope
	ld [wBuffer2], a
	call QueryWhichSide
	ld a, [hl]
	ld [wBuffer3], a
	ld a, [de]
	ld [wBuffer4], a
	xor a
	ret

.nope
	scf
	ret

QueryWhichSide:
	ld hl, wDecoRightOrnament
	ld de, wDecoLeftOrnament
	ld a, [wBuffer2]
	cp 1
	ret z
	jmp SwapHLDE

WhichSideMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 13, 7
	dw WhichSideMenuData
	db 1 ; default option

WhichSideMenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
	db "Right side@"
	db "Left side@"
	db "Cancel@"

DecoText_PutAwayTheDeco:
	; Put away the @ .
	text_far _PutAwayTheDecoText
	text_end

DecoText_NothingToPutAway:
	text_far _NothingToPutAwayText
	text_end

DecoText_SetUpTheDeco:
	text_far _SetUpTheDecoText
	text_end

DecoText_PutAwayAndSetUp:
	text_far _PutAwayAndSetUpText
	text_end

DecoText_AlreadySetUp:
	text_far _AlreadySetUpText
	text_end

GetDecorationName_c_de:
	ld a, c
	ld h, d
	ld l, e
	jmp GetDecorationName

DecorationFlagAction_c:
	ld a, c
	jmp DecorationFlagAction

GetDecorationName_c:
	ld a, c
	call GetDecorationID
	ld hl, wStringBuffer1
	push hl
	call GetDecorationName
	pop de
	ret

GetDecorationID:
	push hl
	push de
	ld e, a
	ld d, 0
	ld hl, DecorationIDs
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	ret

INCLUDE "data/decorations/decorations.asm"

DescribeDecoration::
	ld a, b
	call StackJumpTable

.JumpTable:
; entries correspond to DECODESC_* constants
	table_width 2, DescribeDecoration.JumpTable
	dw DecorationDesc_Poster
	dw DecorationDesc_LeftOrnament
	dw DecorationDesc_RightOrnament
	dw DecorationDesc_GiantOrnament
	dw DecorationDesc_Console
	assert_table_length NUM_DECODESCS

DecorationDesc_Poster:
	ld a, [wDecoPoster]
	ld hl, DecorationDesc_PosterPointers
	ld de, 3
	call IsInArray
	jr c, .nope
	ld de, DecorationDesc_NullPoster
	ld b, BANK(DecorationDesc_NullPoster)
	ret

.nope
	ld b, BANK(DecorationDesc_TownMapPoster)
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ret

DecorationDesc_PosterPointers:
	dbw DECO_TOWN_MAP, DecorationDesc_TownMapPoster
	dbw DECO_DIPLOMA, DecorationDesc_Diploma
	dbw DECO_PIKACHU_POSTER, DecorationDesc_PikachuPoster
	dbw DECO_CLEFAIRY_POSTER, DecorationDesc_ClefairyPoster
	dbw DECO_MARILL_POSTER, DecorationDesc_MarillPoster
	db -1

DecorationDesc_TownMapPoster:
	opentext
	farwritetext _LookTownMapText
	waitbutton
	special Special_TownMap
	closetext
	end

DecorationDesc_Diploma:
	opentext
	farwritetext DiplomaText
	waitbutton
	special Diploma
	endtext
	end

DecorationDesc_PikachuPoster:
	farjumptext _LookPikachuPosterText

DecorationDesc_ClefairyPoster:
	farjumptext _LookClefairyPosterText

DecorationDesc_MarillPoster:
	farjumptext _LookJigglypuffPosterText

DecorationDesc_NullPoster:
	end

DecorationDesc_LeftOrnament:
	ld a, [wDecoLeftOrnament]
	jr DecorationDesc_Ornament

DecorationDesc_RightOrnament:
	ld a, [wDecoRightOrnament]
DecorationDesc_Ornament:
	ld c, a
	cp DECO_GOLD_TROPHY_DOLL
	jr z, DecorationDesc_Console.go
	cp DECO_SILVER_TROPHY_DOLL
	jr z, DecorationDesc_Console.go
	ld de, wStringBuffer3
	call GetDecorationName_c_de
	ld b, BANK(.OrnamentScript)
	ld de, .OrnamentScript
	ret

.OrnamentScript:
	farjumptext _LookAdorableDecoText

DecorationDesc_Console:
	ld a, [wDecoConsole]
	ld c, a
.go:
	ld de, wStringBuffer3
	call GetDecorationName_c_de
	ld b, BANK(.ConsoleScript)
	ld de, .ConsoleScript
	ret

.ConsoleScript:
	farjumptext DecoConsoleText

DecorationDesc_GiantOrnament:
	ld b, BANK(.BigDollScript)
	ld de, .BigDollScript
	ret

.BigDollScript:
	farjumptext _LookGiantDecoText

ToggleMaptileDecorations:
	lb de, 0, 4 ; bed coordinates
	ld a, [wDecoBed]
	call SetDecorationTile
	lb de, 7, 4 ; plant coordinates
	ld a, [wDecoPlant]
	call SetDecorationTile
	lb de, 6, 0 ; poster coordinates
	ld a, [wDecoPoster]
	call SetDecorationTile
	call SetPosterVisibility
	lb de, 0, 0 ; carpet top-left coordinates
	call PadCoords_de
	ld a, [wDecoCarpet]
	and a
	ret z
	call _GetDecorationSprite
	ld [hl], a
	push af
	lb de, 0, 2 ; carpet bottom-left coordinates
	call PadCoords_de
	pop af
	inc a
	ld [hli], a ; carpet bottom-left block
	inc a
	ld [hli], a ; carpet bottom-middle block
	dec a
	ld [hl], a ; carpet bottom-right block
	ret

SetPosterVisibility:
	ld b, SET_FLAG
	ld a, [wDecoPoster]
	and a
	jr nz, .ok
	ld b, RESET_FLAG

.ok
	ld de, EVENT_PLAYERS_ROOM_POSTER
	jmp EventFlagAction

SetDecorationTile:
	push af
	call PadCoords_de
	pop af
	and a
	ret z
	call _GetDecorationSprite
	ld [hl], a
	ret

ToggleDecorationsVisibility:
	ld de, EVENT_PLAYERS_HOUSE_2F_CONSOLE
	ld hl, wVariableSprites + SPRITE_CONSOLE - SPRITE_VARS
	ld a, [wDecoConsole]
	call .ToggleDecorationVisibility
	ld de, EVENT_PLAYERS_HOUSE_2F_BIG_DOLL
	ld hl, wVariableSprites + SPRITE_BIG_DOLL - SPRITE_VARS
	ld a, [wDecoBigDoll]
	call .ToggleDecorationVisibility
	ld de, EVENT_PLAYERS_HOUSE_2F_DOLL_1
	ld hl, wVariableSprites + SPRITE_DOLL_1 - SPRITE_VARS
	ld a, [wDecoLeftOrnament]
	call .ToggleDecorationVisibility
	ld de, EVENT_PLAYERS_HOUSE_2F_DOLL_2
	ld hl, wVariableSprites + SPRITE_DOLL_2 - SPRITE_VARS
	ld a, [wDecoRightOrnament]
	and a
	jr z, .hide
	call _GetDecorationSprite
	cp SPRITE_MON_DOLL_1
	jr nz, .ok
	inc a ; SPRITE_MON_DOLL_2
	jr .ok

.ToggleDecorationVisibility:
	and a
	jr z, .hide
	call _GetDecorationSprite
.ok
	ld [hl], a
	ld b, RESET_FLAG
	jmp EventFlagAction

.hide
	ld b, SET_FLAG
	jmp EventFlagAction

PadCoords_de:
	ld a, d
	add 4
	ld d, a
	ld a, e
	add 4
	ld e, a
	jmp GetBlockLocation
