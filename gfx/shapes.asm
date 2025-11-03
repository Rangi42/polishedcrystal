Shapes:
; Entries correspond to SHAPE_* constants (see constants/pokemon_data_constants.asm)
	table_width TILE_1BPP_SIZE * 4
INCBIN "gfx/shapes/head.1bpp"
INCBIN "gfx/shapes/serpentine.1bpp"
INCBIN "gfx/shapes/fins.1bpp"
INCBIN "gfx/shapes/head_arms.1bpp"
INCBIN "gfx/shapes/head_base.1bpp"
INCBIN "gfx/shapes/bipedal_tail.1bpp"
INCBIN "gfx/shapes/head_legs.1bpp"
INCBIN "gfx/shapes/quadruped.1bpp"
INCBIN "gfx/shapes/wings.1bpp"
INCBIN "gfx/shapes/tentacles.1bpp"
INCBIN "gfx/shapes/multibody.1bpp"
INCBIN "gfx/shapes/bipedal.1bpp"
INCBIN "gfx/shapes/multiwings.1bpp"
INCBIN "gfx/shapes/insectoid.1bpp"
	assert_table_length NUM_SHAPES
