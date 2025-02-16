MACRO mon_menu_option
	db \1, \2
	dw \3
ENDM

MonMenuOptions:
; category, item, value; actions are in PokemonActionSubmenu (see engine/pokemon/mon_menu.asm)
	table_width 4
; moves
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_CUT,        CUT
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_FLY,        FLY
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_SURF,       SURF
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_STRENGTH,   STRENGTH
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_FLASH,      FLASH
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_WATERFALL,  WATERFALL
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_WHIRLPOOL,  WHIRLPOOL
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_DIG,        DIG
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_TELEPORT,   TELEPORT
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_FRESHSNACK, FRESH_SNACK
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_HEADBUTT,   HEADBUTT
	mon_menu_option MONMENU_FIELD_MOVE, MONMENUITEM_ROCKSMASH,  ROCK_SMASH
; options
	mon_menu_option MONMENU_MENUOPTION, MONMENUITEM_STATS,      .stats
	mon_menu_option MONMENU_MENUOPTION, MONMENUITEM_SWITCH,     .switch
	mon_menu_option MONMENU_MENUOPTION, MONMENUITEM_ITEM,       .item
	mon_menu_option MONMENU_MENUOPTION, MONMENUITEM_CANCEL,     .cancel
	mon_menu_option MONMENU_MENUOPTION, MONMENUITEM_MOVE,       .move
	mon_menu_option MONMENU_MENUOPTION, MONMENUITEM_MAIL,       .mail
	mon_menu_option MONMENU_MENUOPTION, MONMENUITEM_ERROR,      .error
	assert_table_length NUM_MONMENUITEMS
	db -1 ; end

.stats:  db "STATS@"
.switch: db "SWITCH@"
.item:   db "ITEM@"
.cancel: db "CANCEL@"
.move:   db "MOVE@"
.mail:   db "MAIL@"
.error:  db "ERROR!@"
