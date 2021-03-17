momitem: MACRO
; money to trigger, cost, kind, item
	dt \1
	dt \2
	db \3, \4
ENDM

MomItems_1:
	momitem      0,   630, MOM_ITEM, SUPER_POTION
	momitem      0,    90, MOM_ITEM, ANTIDOTE
	momitem      0,   180, MOM_ITEM, POKE_BALL
	momitem      0,   450, MOM_ITEM, ESCAPE_ROPE
	momitem      0,   540, MOM_ITEM, GREAT_BALL
.End

MomItems_2:
	momitem    900,   630, MOM_ITEM, SUPER_POTION
	momitem   4000,   450, MOM_ITEM, SUPER_REPEL
	momitem   7000,  1080, MOM_ITEM, ETHER
	momitem  10000,  1800, MOM_DOLL, DECO_POLIWAG_DOLL
	momitem  15000,  1890, MOM_ITEM, MOON_STONE
	momitem  20000,  2700, MOM_ITEM, ELIXIR
	momitem  30000,  4800, MOM_DOLL, DECO_CLEFAIRY_DOLL
	momitem  40000,  3600, MOM_ITEM, CHOICE_SCARF
	momitem  50000,  8000, MOM_DOLL, DECO_PIKACHU_DOLL
	momitem  70000, 11200, MOM_DOLL, DECO_TOGEPI_DOLL
.End
