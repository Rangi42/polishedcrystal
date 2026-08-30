PaletteGlowAdjustments:
	table_width 3
	db 2, 5, 9 ; OBJ_GLOW_AQUARIUM
	db 4, 3, 2 ; OBJ_GLOW_LANTERN
	assert_table_length NUM_OBJ_GLOW_TYPES - 2 ; discount OBJ_GLOW_NONE and OBJ_GLOW_CAMPFIRE
