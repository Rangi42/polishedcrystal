; MenuHeader flags
	const_def
	shift_const MENU_RESTORE_TILES ; Will be set if MENU_BACKUP_TILES(_2) is set.
	shift_const MENU_UNUSED_1
	shift_const MENU_UNUSED_2
	shift_const MENU_NO_CLICK_SFX
	shift_const MENU_SPRITE_ANIMS
	shift_const MENU_UNUSED_3
	shift_const MENU_BACKUP_TILES
	shift_const MENU_BACKUP_TILES_2

; VerticalMenu/DoNthMenu/SetUpMenu/_2DMenu MenuData flags
; Per flag the comment specifies which menus actually implement it
	const_def
	shift_const STATICMENU_DISABLE_B ; VerticalMenu/_2DMenu
	shift_const STATICMENU_ENABLE_SELECT ; VerticalMenu/_2DMenu
	shift_const STATICMENU_ENABLE_LEFT_RIGHT ; DoNthMenu/SetUpMenu
	shift_const STATICMENU_ENABLE_START ; DoNthMenu/SetUpMenu
	shift_const STATICMENU_PLACE_TITLE ; VerticalMenu
	shift_const STATICMENU_WRAP ; All
	shift_const STATICMENU_NO_TOP_SPACING ; VerticalMenu/_2DMenu
	shift_const STATICMENU_CURSOR ; VerticalMenu/_2DMenu

; ScrollingMenu MenuData flags
	const_def
	shift_const SCROLLINGMENU_CALL_FUNCTION1_CANCEL
	shift_const SCROLLINGMENU_CALL_FUNCTION3_NO_SWITCH
	shift_const SCROLLINGMENU_ENABLE_LEFT
	shift_const SCROLLINGMENU_ENABLE_RIGHT
	shift_const SCROLLINGMENU_DISPLAY_ARROWS
	shift_const SCROLLINGMENU_ENABLE_FUNCTION3
	shift_const SCROLLINGMENU_ENABLE_START
	shift_const SCROLLINGMENU_ENABLE_SELECT

; ScrollingMenu items structure format
	const_def 1
	const SCROLLINGMENU_ITEMS_NORMAL
	const SCROLLINGMENU_ITEMS_QUANTITY

; MonMenuOptions indexes (see data/mon_menu.asm)
; used by PokemonActionSubmenu (see engine/pokemon/mon_menu.asm)
	const_def 1
	; moves
	const MONMENU_CUT        ; 1
	const MONMENU_FLY        ; 2
	const MONMENU_SURF       ; 3
	const MONMENU_STRENGTH   ; 4
	const MONMENU_WATERFALL  ; 5
	const MONMENU_FLASH      ; 6
	const MONMENU_WHIRLPOOL  ; 7
	const MONMENU_DIG        ; 8
	const MONMENU_TELEPORT   ; 9
	const MONMENU_FRESHSNACK ; 10
	const MONMENU_HEADBUTT   ; 11
	const MONMENU_ROCKSMASH  ; 12
	; options
	const MONMENU_STATS      ; 13
	const MONMENU_SWITCH     ; 14
	const MONMENU_ITEM       ; 15
	const MONMENU_CANCEL     ; 16
	const MONMENU_MOVE       ; 17
	const MONMENU_MAIL       ; 18
	const MONMENU_ERROR      ; 19

; MonMenuOptions categories
MONMENU_FIELD_MOVE EQU 0
MONMENU_MENUOPTION EQU 1

NUM_MON_SUBMENU_ITEMS EQU 8

SAVE_VERSION EQU 1

; PartyMenuQualityPointers indexes (see data/party_menu_qualities.asm)
	const_def
	const PARTYMENUACTION_CHOOSE_POKEMON
	const PARTYMENUACTION_HEALING_ITEM
	const PARTYMENUACTION_SWITCH
	const PARTYMENUACTION_TEACH_TM
	const PARTYMENUACTION_MOVE
	const PARTYMENUACTION_EVO_STONE
	const PARTYMENUACTION_GIVE_MON
	const PARTYMENUACTION_GIVE_MON_FEMALE ; unused?
	const PARTYMENUACTION_GIVE_ITEM
	const PARTYMENUACTION_MOVE_RELEARNER
	const PARTYMENUACTION_BATTLE_TOWER
; PrintPartyMenuActionText arguments (see engine/pokemon/party_menu.asm)
	const_def $f0
	const PARTYMENUTEXT_HEAL_PSN
	const PARTYMENUTEXT_HEAL_BRN
	const PARTYMENUTEXT_HEAL_FRZ
	const PARTYMENUTEXT_HEAL_SLP
	const PARTYMENUTEXT_HEAL_PAR
	const PARTYMENUTEXT_HEAL_HP
	const PARTYMENUTEXT_HEAL_ALL
	const PARTYMENUTEXT_REVIVE
	const PARTYMENUTEXT_LEVEL_UP
	const PARTYMENUTEXT_HEAL_CONFUSION
