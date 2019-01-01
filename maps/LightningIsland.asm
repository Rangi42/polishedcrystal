LightningIsland_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 6 ; warp events
	warp_event  5, 29, SHAMOUTI_COAST, 3
	warp_event 19, 29, LIGHTNING_ISLAND_ROOF, 1
	warp_event  6,  3, LIGHTNING_ISLAND, 4
	warp_event 19,  3, LIGHTNING_ISLAND, 3
	warp_event 19, 26, LIGHTNING_ISLAND, 6
	warp_event  5, 27, LIGHTNING_ISLAND, 5 ; hole

	db 0 ; coord events

	db 0 ; bg events

	db 14 ; object events
	itemball_event 22, 15, DAMP_ROCK, 1, EVENT_LIGHTNING_ISLAND_DAMP_ROCK
	object_event  1,  5, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event  1, 13, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event  1, 25, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 15,  6, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 15, 11, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 15, 27, SPRITE_SNES, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 10,  6, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 10, 18, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 10, 22, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 24,  4, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 24,  8, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 24, 17, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1
	object_event 24, 25, SPRITE_SNES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_SCRIPT, 0, LightningIslandCrystalScript, -1

LightningIslandCrystalScript:
	end
