RuggedRoadNorth_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, RuggedRoadNorthFixBridgeCallback

	def_warp_events
	warp_event 10,  5, SNOWTOP_MOUNTAIN_INSIDE, 1
	warp_event 18, 16, HIDDEN_CAVE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event 18, 15, BGEVENT_JUMPSTD, cavegrotto, HIDDENGROTTO_RUGGED_ROAD_NORTH
	bg_event 23,  9, BGEVENT_ITEM + RARE_BONE, EVENT_RUGGED_ROAD_NORTH_HIDDEN_RARE_BONE

	def_object_events
	itemball_event  4,  4, X_ATTACK, 1, EVENT_RUGGED_ROAD_NORTH_X_ATTACK
	itemball_event 26,  4, HYPER_POTION, 1, EVENT_RUGGED_ROAD_NORTH_HYPER_POTION
	smashrock_event  5,  8

RuggedRoadNorthFixBridgeCallback:
	callasm .RuggedRoadSouthFixBridge
	endcallback

.RuggedRoadSouthFixBridge:
	ld hl, wPrevWarp
	ld a, [hli]
	dec a ; warp 1?
	jr nz, .not_coming_from_hidden_grotto
	assert wPrevWarp + 1 == wPrevMapGroup
	ld a, [hli]
	cp GROUP_HIDDEN_CAVE_GROTTO
	jr nz, .not_coming_from_hidden_grotto
	assert wPrevMapGroup + 1 == wPrevMapNumber
	ld a, [hl]
	cp MAP_HIDDEN_CAVE_GROTTO
	jr nz, .not_coming_from_hidden_grotto
	xor a ; overhead
	jr .got_scene

.not_coming_from_hidden_grotto
	ld hl, wPrevWarp
	ld a, [hli]
	dec a ; warp 1?
	ret nz
	assert wPrevWarp + 1 == wPrevMapGroup
	ld a, [hli]
	cp GROUP_SNOWTOP_MOUNTAIN_INSIDE
	ret nz
	assert wPrevMapGroup + 1 == wPrevMapNumber
	ld a, [hl]
	cp MAP_SNOWTOP_MOUNTAIN_INSIDE
	ret nz
	ld a, $1 ; underfoot
.got_scene
	ld [wWalkingOnBridge], a
	ld [wRuggedRoadSouthSceneID], a ; setscene a
	ret
