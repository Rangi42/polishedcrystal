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
	bg_event 25,  8, BGEVENT_ITEM + RARE_BONE, EVENT_RUGGED_ROAD_NORTH_HIDDEN_RARE_BONE

	def_object_events
	object_event  6, 11, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBattleGirlMei, -1
	object_event 23, 9, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, (1 << DAY) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, RuggedRoadNorthHikerScript, -1
	object_event 22, 10, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, (1 << MORN) | (1 << EVE), 0, OBJECTTYPE_SCRIPT, 0, RuggedRoadNorthHikerScript, -1
	object_event 25, 10, SPRITE_FIREBREATHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RuggedRoadNorthFirebreatherText, -1
	object_event 23, 10, SPRITE_CAMPFIRE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RuggedRoadNorthCampfireText, -1
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

GenericTrainerBattleGirlMei:
	generictrainer BATTLE_GIRL, MEI, EVENT_BEAT_BATTLE_GIRL_MEI, .SeenText, .BeatenText

	text "Pushing yourself"
	line "a little further"
	cont "every day."

	para "That's my training"
	line "style."
	done

.SeenText:
	text "Training in harsh"
	line "environments like"

	para "this is essential"
	line "if you want to be"
	cont "your best."
	done

.BeatenText:
	text "I see you've done"
	line "your training."
	done

RuggedRoadNorthHikerScript:
	checkevent EVENT_GOT_OVAL_STONE_FROM_RUGGED_ROAD
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem OVAL_STONE
	iffalse_endtext
	setevent EVENT_GOT_OVAL_STONE_FROM_RUGGED_ROAD
	jumpthisopenedtext

.Text2:
	text "When you reach the"
	line "top, don't forget"

	para "to thank your"
	line "lucky stone!"
	done

.Text1:
	text "It's not just your"
	line "skills that get"

	para "you to the top of"
	line "a tough mountain."

	para "Luck must be on"
	line "your side to reach"
	cont "the top!"

	para "This Oval Stone I"
	line "found feels lucky."

	para "Here, take it!"
	done

RuggedRoadNorthFirebreatherText:
	text "Huff… puff…"

	para "Keeping this fire"
	line "lit is hard work,"

	para "but without it,"
	line "I'd turn into a"
	cont "NeverMeltIce."
	done

RuggedRoadNorthCampfireText:
	text "The campfire"
	line "burns steadily."
	done
