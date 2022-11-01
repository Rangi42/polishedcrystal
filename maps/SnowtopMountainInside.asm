SnowtopMountainInside_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, SnowtopMountainInsideFixFacing

	def_warp_events
	warp_event  9, 29, RUGGED_ROAD_NORTH, 1
	warp_event 27, 29, SNOWTOP_MOUNTAIN_OUTSIDE, 1
	warp_event 26,  4, HIDDEN_CAVE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event 26,  3, BGEVENT_JUMPSTD, cavegrotto, HIDDENGROTTO_SNOWTOP_MOUNTAIN_INSIDE

	def_object_events


SnowtopMountainInsideFixFacing:
	callasm .FixFacing
	endcallback

.FixFacing:
	ld hl, wPrevWarp
	ld a, [hli]
	cp 1
	ret nz
	assert wPrevWarp + 1 == wPrevMapGroup
	ld a, [hli]
	cp GROUP_SNOWTOP_MOUNTAIN_OUTSIDE
	ret nz
	assert wPrevMapGroup + 1 == wPrevMapNumber
	ld a, [hl]
	cp MAP_SNOWTOP_MOUNTAIN_OUTSIDE
	ret nz
	ld a, [wPlayerSpriteSetupFlags]
	or (1 << 5) | UP
	ld [wPlayerSpriteSetupFlags], a
	ret
