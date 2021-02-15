Route19_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route19ClearSmashRocks
	callback MAPCALLBACK_TILES, Route19ClearRocks

	def_warp_events
	warp_event  7,  1, ROUTE_19_FUCHSIA_GATE, 3
	warp_event  5, 13, ROUTE_19_BEACH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 11, 15, BGEVENT_JUMPTEXT, Route19SignText
	bg_event 11, -1, BGEVENT_JUMPTEXT, CarefulSwimmingSignText
	bg_event  5,  3, BGEVENT_ITEM + REVIVE, EVENT_ROUTE_19_HIDDEN_REVIVE
	bg_event  3, 11, BGEVENT_ITEM + MAX_REVIVE, EVENT_ROUTE_19_HIDDEN_MAX_REVIVE
	bg_event  5, 15, BGEVENT_ITEM + PEARL, EVENT_ROUTE_19_HIDDEN_PEARL
	bg_event 13, 13, BGEVENT_ITEM + BIG_PEARL, EVENT_ROUTE_19_HIDDEN_BIG_PEARL

	def_object_events
	smashrock_event 11,  4, EVENT_ROUTE_19_ROCK
	smashrock_event  6, 3
	smashrock_event  4, 11
	smashrock_event 12, 13
	smashrock_event 13, 14
	object_event  8, 34, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfDawn, -1
	object_event  9, 34, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSwimmermTucker, -1
	object_event 11, 20, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermJerome, -1
	object_event 13, 43, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermHarold, -1
	object_event 13, 51, SPRITE_COSPLAYER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCosplayerBrooke, -1
	object_event  9,  3, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route19Fisher1Script, -1
	object_event 11,  3, SPRITE_ENGINEER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route19Fisher2Script, -1
	tmhmball_event 14, 52, TM_SCALD, EVENT_ROUTE_19_TM_SCALD

	object_const_def
	const ROUTE19_ROCK1

Route19ClearSmashRocks:
	disappear ROUTE19_ROCK1
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iffalse .Done
	appear ROUTE19_ROCK1
.Done:
	return

Route19ClearRocks:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .Done
	changeblock 6, 4, $7a
	changeblock 8, 4, $7a
	changeblock 10, 4, $7a
	changeblock 6, 6, $7a
	changeblock 12, 6, $7a
	changeblock 8, 8, $7a
.Done:
	return

GenericTrainerSwimmerfDawn:
	generictrainer SWIMMERF, DAWN, EVENT_BEAT_SWIMMERF_DAWN, SwimmerfDawnSeenText, SwimmerfDawnBeatenText

	text "It's a quick swim"
	line "between Fuchsia"

	para "and Seafoam Is-"
	line "lands…"

	para "Sheesh, some big"
	line "man my boyfriend"
	cont "is! What a wimp!"
	done

GenericTrainerSwimmermTucker:
	generictrainer SWIMMERM, TUCKER, EVENT_BEAT_SWIMMERM_TUCKER, SwimmermTuckerSeenText, SwimmermTuckerBeatenText

	text "I… asked my girl-"
	line "friend to swim to"
	cont "Fuchsia… Gasp…"
	done

GenericTrainerSwimmermJerome:
	generictrainer SWIMMERM, JEROME, EVENT_BEAT_SWIMMERM_JEROME, SwimmermJeromeSeenText, SwimmermJeromeBeatenText

	text "I might be bad at"
	line "swimming, but I"
	cont "love the sea."
	done

GenericTrainerSwimmermHarold:
	generictrainer SWIMMERM, HAROLD, EVENT_BEAT_SWIMMERM_HAROLD, SwimmermHaroldSeenText, SwimmermHaroldBeatenText

	text "At night, the sea"
	line "turns black. It"

	para "feels like it will"
	line "swallow you up."
	done

GenericTrainerCosplayerBrooke:
	generictrainer COSPLAYER, BROOKE, EVENT_BEAT_COSPLAYER_BROOKE, CosplayerBrookeSeenText, CosplayerBrookeBeatenText

	text "I made this outfit"
	line "for a fancy dress"
	cont "party, but I love"

	para "it so much that I"
	line "wear it elsewhere"
	cont "too."
	done

Route19Fisher1Script:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iffalse_jumptextfaceplayer Route19Fisher1Text
	jumptextfaceplayer Route19Fisher1Text_RocksCleared

Route19Fisher2Script:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iffalse_jumptextfaceplayer Route19EngineerText1
	jumptextfaceplayer Route19EngineerText2

SwimmerfDawnSeenText:
	text "I'm disgusted by"
	line "wimpy people!"
	done

SwimmerfDawnBeatenText:
	text "I could beat you"
	line "at swimming…"
	done

SwimmermTuckerSeenText:
	text "Pant, pant…"
	line "Just… a little…"

	para "farther… to…"
	line "Fuchsia…"
	done

SwimmermTuckerBeatenText:
	text "I'm drowning!"
	done

SwimmermJeromeSeenText:
	text "Swimming?"
	line "I'm lousy at it."

	para "I'm just splashing"
	line "around in these"
	cont "shallow waters."
	done

SwimmermJeromeBeatenText:
	text "I thought I could"
	line "win."
	done

SwimmermHaroldSeenText:
	text "Have you ever gone"
	line "swimming in the"
	cont "sea at night?"
	done

SwimmermHaroldBeatenText:
	text "Glub…"
	done

CosplayerBrookeSeenText:
	text "Dressing up is"
	line "such fun!"
	done

CosplayerBrookeBeatenText:
	text "You'd better not"
	line "have damaged my"
	cont "costume!"
	done

Route19Fisher1Text:
	text "Sorry. This road"
	line "is closed for"
	cont "construction."

	para "If you want to get"
	line "to Cinnabar, you'd"

	para "better go south"
	line "from Pallet Town."
	done

Route19Fisher1Text_RocksCleared:
	text "I'm all sweaty."
	line "Time for a swim!"
	done

Route19EngineerText1:
	text "Who knows how long"
	line "it would take to"
	cont "move this boulder…"
	done

Route19EngineerText2:
	text "The roadwork is"
	line "finally finished."

	para "Now I can go"
	line "fishing again."
	done

Route19SignText:
	text "Route 19"

	para "Fuchsia City -"
	line "Seafoam Islands"
	done

CarefulSwimmingSignText:
	text "Please be careful"
	line "if you are swim-"
	cont "ming to Seafoam"
	cont "Islands."

	para "Fuchsia Police"
	done
