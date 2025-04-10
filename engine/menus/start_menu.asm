; StartMenu.Items indexes
	const_def
	const STARTMENUITEM_POKEDEX  ; 0
	const STARTMENUITEM_POKEMON  ; 1
	const STARTMENUITEM_PACK     ; 2
	const STARTMENUITEM_STATUS   ; 3
	const STARTMENUITEM_SAVE     ; 4
	const STARTMENUITEM_OPTION   ; 5
	const STARTMENUITEM_EXIT     ; 6
	const STARTMENUITEM_POKEGEAR ; 7
	const STARTMENUITEM_QUIT     ; 8

StartMenu::

	call ClearWindowData
	call BackupSprites
	call ClearSpritesUnderStartMenu

	ld de, SFX_MENU
	call PlaySFX

	farcall ReanchorBGMap_NoOAMUpdate

	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ld hl, .MenuDataHeader
	jr z, .GotMenuData
	ld hl, .ContestMenuDataHeader
.GotMenuData:

	call LoadMenuHeader
	call .SetUpMenuItems
	ld a, [wBattleMenuCursorBuffer]
	ld [wMenuCursorBuffer], a
	call DrawVariableLengthMenuBox
	call .DrawBugContestStatusBox
	call SafeUpdateSprites
	call BGMapAnchorTopLeft
	farcall LoadFonts_NoOAMUpdate
	call .DrawBugContestStatus
	call UpdateTimePals
	jr .Select

.Reopen:
	call RestoreSprites
	farcall LoadWeatherPal
	call ClearSpritesUnderStartMenu
	call UpdateSprites
	call UpdateTimePals
	call .SetUpMenuItems
	ld a, [wBattleMenuCursorBuffer]
	ld [wMenuCursorBuffer], a

.Select:
	call .GetInput
	jr c, .Exit
	ld a, [wMenuCursorBuffer]
	ld [wBattleMenuCursorBuffer], a
	call PlayClickSFX
	call PlaceHollowCursor
	call .OpenMenu

; Menu items have different return functions.
; For example, saving exits the menu.
	call StackJumpTable

.MenuReturns:
	dw .Reopen
	dw .Exit
	dw .ExitMenuCallFuncCloseText
	dw .ExitMenuRunScriptCloseText
	dw .ExitMenuRunScript
	dw .ReturnEnd
	dw .ReturnRedraw

.Exit:
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call LoadFrame
	call RestoreSprites
	pop af
	ldh [hOAMUpdate], a
.ReturnEnd:
	call ExitMenu
.ReturnEnd2:
	call CloseText
	jmp UpdateTimePals

.GetInput:
; Return carry on exit, and no-carry on selection.
	xor a
	ldh [hBGMapMode], a
	call SetUpMenu
	ld a, $ff
	ld [wMenuSelection], a
.loop
	call ReadMenuJoypad
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b
	cp A_BUTTON
	jr nz, .loop
.a
	call PlayClickSFX
	and a
	ret
.b
	scf
	ret

.ExitMenuRunScript:
	call ExitMenu
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	ret

.ExitMenuRunScriptCloseText:
	call ExitMenu
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	jr .ReturnEnd2

.ExitMenuCallFuncCloseText:
	call ExitMenu
	ld hl, wQueuedScriptBank
	call FarPointerCall
	jr .ReturnEnd2

.ReturnRedraw:
	farcall ClearSavedObjPals
	farcall DisableDynPalUpdates
	call ClearBGPalettes
	call ExitMenu
	call ReloadTilesetAndPalettes
	call DrawVariableLengthMenuBox
	call .DrawBugContestStatus
	call UpdateSprites
	call FinishExitMenu
	jmp .Reopen

.MenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 10, 0, 19, 17
	dw .MenuData
	db 1 ; default selection

.ContestMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 10, 2, 19, 17
	dw .MenuData
	db 1 ; default selection

.MenuData:
	db %10101000 ; x padding, wrap around, start can close
	dn 0, 0 ; rows, columns
	dw wMenuItemsList
	dw .MenuString
	dw .Items

.Items:
	dw StartMenu_Pokedex,  .PokedexString
	dw StartMenu_Pokemon,  .PartyString
	dw StartMenu_Pack,     .PackString
	dw StartMenu_Status,   .StatusString
	dw StartMenu_Save,     .SaveString
	dw StartMenu_Option,   .OptionString
	dw StartMenu_Exit,     .ExitString
	dw StartMenu_Pokegear, .PokegearString
	dw StartMenu_Quit,     .QuitString

.PokedexString:  db "#dex@"
.PartyString:    db "#mon@"
.PackString:     db "Bag@"
.StatusString:   db "<PLAYER>@"
.SaveString:     db "Save@"
.OptionString:   db "Options@"
.ExitString:     db "Exit@"
.PokegearString: db "<PO><KE>gear@"
.QuitString:     db "Quit@"

.OpenMenu:
	ld a, [wMenuSelection]
	call .GetMenuItemPointer
	jmp IndirectHL

.MenuString:
	push de
	ld a, [wMenuSelection]
	call .GetMenuItemPointer
	inc hl
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	rst PlaceString
	ret

.GetMenuItemPointer:
	ld e, a
	ld d, 0
	ld hl, wMenuDataPointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
rept 4
	add hl, de
endr
	ret

.SetUpMenuItems:
	xor a
	ld [wWhichIndexSet], a
	call .FillMenuList

	ld hl, wStatusFlags
	bit 0, [hl]
	jr z, .no_pokedex
	xor a ; STARTMENUITEM_POKEDEX
	call .AppendMenuList
.no_pokedex

	ld a, [wPartyCount]
	and a
	jr z, .no_pokemon
	ld a, STARTMENUITEM_POKEMON
	call .AppendMenuList
.no_pokemon

	ld a, [wLinkMode]
	and a
	jr nz, .no_pack
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .no_pack
	ld a, STARTMENUITEM_PACK
	call .AppendMenuList
.no_pack

	ld hl, wPokegearFlags
	bit POKEGEAR_OBTAINED_F, [hl]
	jr z, .no_pokegear
	ld a, STARTMENUITEM_POKEGEAR
	call .AppendMenuList
.no_pokegear

	ld a, STARTMENUITEM_STATUS
	call .AppendMenuList

	ld a, [wLinkMode]
	and a
	jr nz, .no_save
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ld a, STARTMENUITEM_QUIT
	jr nz, .write
	ld a, STARTMENUITEM_SAVE
.write
	call .AppendMenuList
.no_save

	ld a, STARTMENUITEM_OPTION
	call .AppendMenuList
	ld a, STARTMENUITEM_EXIT
	call .AppendMenuList
	ld a, c
	ld [wMenuItemsList], a
	ret

.FillMenuList:
	xor a
	ld hl, wMenuItemsList
	ld [hli], a
	ld a, -1
	ld bc, wMenuItemsListEnd - (wMenuItemsList + 1)
	rst ByteFill
	ld de, wMenuItemsList + 1
	ld c, 0
	ret

.AppendMenuList:
	ld [de], a
	inc de
	inc c
	ret

.DrawBugContestStatusBox:
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ret z
	farjp StartMenu_DrawBugContestStatusBox

.DrawBugContestStatus:
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	ret z
	farjp StartMenu_PrintBugContestStatus

StartMenu_Exit:
	ld a, 1
	ret

StartMenu_Quit:
	ld hl, .EndTheContestText
	call StartMenuYesNo
	jr c, .DontEndContest
	ld a, BANK(BugCatchingContestReturnToGateScript)
	ld hl, BugCatchingContestReturnToGateScript
	call FarQueueScript
	ld a, 4
	ret

.DontEndContest:
	xor a
	ret

.EndTheContestText:
	text_far _StartMenuContestEndText
	text_end

StartMenu_Save:
	call ClearSprites
	call BufferScreen
	farcall SaveMenu
	jr nc, .saved
	xor a
	ret

.saved
	ld a, 1
	ret

StartMenu_Option:
	call FadeToMenu
	farcall OptionsMenu
	ld a, 6
	ret

StartMenu_Status:
	call FadeToMenu
	farcall TrainerCard
	call CloseSubmenu
	xor a
	ret

StartMenu_Pokedex:
	ld a, [wPartyCount]
	and a
	jr z, .empty
	call FadeToMenu
	farcall Pokedex
	call CloseSubmenu
.empty
	xor a
	ret

StartMenu_Pokegear:
	call FadeToMenu
	farcall InitPokegearPalettes
	farcall PokeGear
	ld a, [wDefaultSpawnpoint]
	and a
	jr nz, _ExitStartMenuAndDoScript
	call CloseSubmenu
	call ApplyTilemapInVBlank
	call SetDefaultBGPAndOBP
	call DelayFrame
	xor a
	ret

StartMenu_Pack:
	call FadeToMenu
	call Pack
	ld a, [wPackUsedItem]
	and a
	jr nz, _ExitStartMenuAndDoScript
	call CloseSubmenu
	xor a
	ret

_ExitStartMenuAndDoScript:
	call ExitAllMenus
	ld a, 4
	ret

StartMenu_Pokemon:
	ld a, [wPartyCount]
	and a
	jr z, .return
	call FadeToMenu
.choosemenu
	xor a
	ld [wPartyMenuActionText], a ; Choose a POKéMON.
	call ClearBGPalettes
.menu
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
.menunoreload
	ld a, A_BUTTON | B_BUTTON | SELECT
	ld [wMenuJoypadFilter], a
	farcall WritePartyMenuTilemap
	farcall PlacePartyMenuText
	call ApplyTilemapInVBlank
	call SetDefaultBGPAndOBP ; load regular palettes?
	call DelayFrame
	farcall PartyMenuSelect
	jr c, .return ; if cancelled or pressed B
	ldh a, [hJoyLast]
	and SELECT
	jr z, .not_switch
	call SwitchPartyMons
	jr .after_action
.not_switch
	call PokemonActionSubmenu
.after_action
	push af
	call Delay2
	pop af
	and a ; 0?
	jr z, .choosemenu
	dec a ; 1?
	jr z, .menunoreload
	dec a ; 2?
	jr z, .quit
	dec a ; 3?
	jr z, .menu
.return
	call CloseSubmenu
	xor a
	ret

.quit
	ld a, b
	push af
	call ExitAllMenus
	pop af
	ret

ClearSpritesUnderStartMenu:
	ld de, wShadowOAMSprite00XCoord
	ld h, d
	ld l, e
	ld c, NUM_SPRITE_OAM_STRUCTS
.loop
	; Check if XCoord >= 10 * TILE_WIDTH,
	; which is the starting x-coord of the start menu.
	ld a, [hl]
	cp 10 * TILE_WIDTH
	jr nc, .clear_sprite
; fallthrough
.next
	ld hl, SPRITEOAMSTRUCT_LENGTH
	add hl, de
	ld e, l
	dec c
	jr nz, .loop
	ldh a, [hOAMUpdate]
	push af
	ld a, TRUE
	ldh [hOAMUpdate], a
	call DelayFrame
	pop af
	ldh [hOAMUpdate], a
	ret

.clear_sprite
	dec l
	ld [hl], OAM_YCOORD_HIDDEN
	inc l
	jr .next
