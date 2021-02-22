StartMenu::

	call ClearWindowData

	ld de, SFX_MENU
	call PlaySFX

	farcall ReanchorBGMap_NoOAMUpdate

	ld hl, wStatusFlags2
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
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
	call LoadFontsExtra
	pop af
	ldh [hOAMUpdate], a
.ReturnEnd:
	call ExitMenu
.ReturnEnd2:
	call CloseText
	jp UpdateTimePals

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
	call ClearBGPalettes
	call ExitMenu
	call ReloadTilesetAndPalettes
	call DrawVariableLengthMenuBox
	call .DrawBugContestStatus
	call UpdateSprites
	call FinishExitMenu
	jp .Reopen

.MenuDataHeader:
	db $40 ; tile backup
	db 0, 10 ; start coords
	db 17, 19 ; end coords
	dw .MenuData
	db 1 ; default selection

.ContestMenuDataHeader:
	db $40 ; tile backup
	db 2, 10 ; start coords
	db 17, 19 ; end coords
	dw .MenuData
	db 1 ; default selection

.MenuData:
	db %10101000 ; x padding, wrap around, start can close
	dn 0, 0 ; rows, columns
	dw wMenuItemsList
	dw .MenuString
	dw .Items

; TODO: remove vestigial menu account EmptyString descriptions
.Items:
	dw StartMenu_Pokedex,  .PokedexString,  EmptyString
	dw StartMenu_Pokemon,  .PartyString,    EmptyString
	dw StartMenu_Pack,     .PackString,     EmptyString
	dw StartMenu_Status,   .StatusString,   EmptyString
	dw StartMenu_Save,     .SaveString,     EmptyString
	dw StartMenu_Option,   .OptionString,   EmptyString
	dw StartMenu_Exit,     .ExitString,     EmptyString
	dw StartMenu_Pokegear, .PokegearString, EmptyString
	dw StartMenu_Quit,     .QuitString,     EmptyString

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
	call .GetMenuAccountTextPointer
	jp IndirectHL

.MenuString:
	push de
	ld a, [wMenuSelection]
	call .GetMenuAccountTextPointer
	inc hl
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	rst PlaceString
	ret

.GetMenuAccountTextPointer:
	ld e, a
	ld d, 0
	ld hl, wMenuDataPointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
rept 6
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
	xor a ; pokedex
	call .AppendMenuList
.no_pokedex

	ld a, [wPartyCount]
	and a
	jr z, .no_pokemon
	ld a, 1 ; pokemon
	call .AppendMenuList
.no_pokemon

	ld a, [wLinkMode]
	and a
	jr nz, .no_pack
	ld hl, wStatusFlags2
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	jr nz, .no_pack
	ld a, 2 ; pack
	call .AppendMenuList
.no_pack

	ld hl, wPokegearFlags
	bit 7, [hl]
	jr z, .no_pokegear
	ld a, 7 ; pokegear
	call .AppendMenuList
.no_pokegear

	ld a, 3 ; status
	call .AppendMenuList

	ld a, [wLinkMode]
	and a
	jr nz, .no_save
	ld hl, wStatusFlags2
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	ld a, 8 ; quit
	jr nz, .write
	ld a, 4 ; save
.write
	call .AppendMenuList
.no_save

	ld a, 5 ; option
	call .AppendMenuList
	ld a, 6 ; exit
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
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	ret z
	farjp StartMenu_DrawBugContestStatusBox

.DrawBugContestStatus:
	ld hl, wStatusFlags2
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	jr nz, .contest
	ret
.contest
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
	text_jump _StartMenuContestEndText
	text_end

StartMenu_Save:
	call BufferScreen
	farcall SaveMenu
	jr nc, .asm_12919
	xor a
	ret

.asm_12919
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
	jr z, .asm_12949
	call FadeToMenu
	farcall Pokedex
	call CloseSubmenu
.asm_12949
	xor a
	ret

StartMenu_Pokegear:
	call FadeToMenu
	farcall InitPokegearPalettes
	farcall PokeGear
	call CloseSubmenu
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	xor a
	ret

StartMenu_Pack:
	call FadeToMenu
	call Pack
	ld a, [wPackUsedItem]
	and a
	jr nz, .used_item
	call CloseSubmenu
	xor a
	ret

.used_item
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
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call ApplyTilemapInVBlank
	call SetPalettes ; load regular palettes?
	call DelayFrame
	farcall PartyMenuSelect
	jr c, .return ; if cancelled or pressed B
	call PokemonActionSubmenu
	push af
	call SFXDelay2
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
