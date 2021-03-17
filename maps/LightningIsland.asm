LightningIsland_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5, 29, SHAMOUTI_COAST, 3
	warp_event 19, 29, LIGHTNING_ISLAND_ROOF, 1
	warp_event  6,  3, LIGHTNING_ISLAND, 4
	warp_event 19,  3, LIGHTNING_ISLAND, 3
	warp_event 19, 26, LIGHTNING_ISLAND, 6
	warp_event  5, 27, LIGHTNING_ISLAND, 5 ; hole
	warp_event  4, 11, LIGHTNING_ISLAND, 7 ; hole
	warp_event  6, 11, LIGHTNING_ISLAND, 8 ; hole
	warp_event 17,  9, LIGHTNING_ISLAND, 7
	warp_event 17, 10, LIGHTNING_ISLAND, 7
	warp_event 17, 11, LIGHTNING_ISLAND, 7
	warp_event 17, 12, LIGHTNING_ISLAND, 7
	warp_event 17, 13, LIGHTNING_ISLAND, 7
	warp_event 20,  9, LIGHTNING_ISLAND, 8
	warp_event 20, 10, LIGHTNING_ISLAND, 8
	warp_event 20, 11, LIGHTNING_ISLAND, 8
	warp_event 20, 12, LIGHTNING_ISLAND, 8
	warp_event 20, 13, LIGHTNING_ISLAND, 8
	warp_event  5, 22, LIGHTNING_ISLAND, 19 ; hole
	warp_event  7, 21, LIGHTNING_ISLAND, 20 ; hole
	warp_event 19, 19, LIGHTNING_ISLAND, 19
	warp_event 19, 20, LIGHTNING_ISLAND, 19
	warp_event 19, 21, LIGHTNING_ISLAND, 19
	warp_event 19, 22, LIGHTNING_ISLAND, 19
	warp_event 19, 23, LIGHTNING_ISLAND, 19
	warp_event 22, 19, LIGHTNING_ISLAND, 20
	warp_event 22, 20, LIGHTNING_ISLAND, 20
	warp_event 22, 21, LIGHTNING_ISLAND, 20
	warp_event 22, 22, LIGHTNING_ISLAND, 20
	warp_event 22, 23, LIGHTNING_ISLAND, 20

	def_coord_events

	def_bg_events

	def_object_events
	itemball_event 22, 15, DAMP_ROCK, 1, EVENT_LIGHTNING_ISLAND_DAMP_ROCK
	object_event  1,  5, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event  1, 13, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event  1, 25, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 15,  6, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 15, 11, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 15, 27, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 10,  6, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 10, 18, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 10, 22, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 24,  4, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 24,  8, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 24, 17, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 24, 25, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1

LightningIslandCrystalScript:
	end
