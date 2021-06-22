PokedexTypeSearchStrings:
; entries correspond with PokedexTypeSearchConversionTable (see data/types/search_types.asm)
	table_width POKEDEX_TYPE_STRING_LENGTH, PokedexTypeSearchStrings
	rawchar "  ----  @"
	rawchar " Normal @"
	rawchar "  Fire  @"
	rawchar " Water  @"
	rawchar " Grass  @"
	rawchar "Electric@"
	rawchar "  Ice   @"
	rawchar "Fighting@"
	rawchar " Poison @"
	rawchar " Ground @"
	rawchar " Flying @"
	rawchar "Psychic @"
	rawchar "  Bug   @"
	rawchar "  Rock  @"
	rawchar " Ghost  @"
	rawchar " Dragon @"
	rawchar "  Dark  @"
	rawchar " Steel  @"
	rawchar " Fairy  @"
	assert_table_length NUM_TYPES ; discount UNKNOWN_T, count ----
