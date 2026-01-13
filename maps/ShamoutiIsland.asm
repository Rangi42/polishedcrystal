ShamoutiIsland_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, ShamoutiIslandFlyPoint

	def_warp_events
	warp_event 21, 13, SHAMOUTI_POKECENTER_1F, 1
	warp_event 33,  5, SHAMOUTI_HOTEL_1F, 1
	warp_event 16,  7, SHAMOUTI_TUNNEL, 1
	warp_event 27,  5, SHAMOUTI_TOURIST_CENTER, 1
	warp_event 31, 12, SHAMOUTI_HOUSE, 1
	warp_event  9, 13, SHAMOUTI_MERCHANT, 1

	def_coord_events

	def_bg_events
	bg_event 16, 16, BGEVENT_JUMPTEXT, ShamoutiIslandSignText
	bg_event 26,  6, BGEVENT_JUMPTEXT, ShamoutiTouristCenterSignText
	bg_event 32,  6, BGEVENT_JUMPTEXT, ShamoutiHotelSignText

	def_object_events
	object_event 16,  8, SPRITE_ALOLAN_EXEGGUTOR, SPRITEMOVEDATA_ALOLAN_EXEGGUTOR, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ShamoutiIslandAlolanExeggutorScript, EVENT_SHAMOUTI_ISLAND_ALOLAN_EXEGGUTOR
	object_event 16,  7, SPRITE_RATTATA_BACK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_SHAMOUTI_ISLAND_ALOLAN_EXEGGUTOR
	fruittree_event 34, 13, FRUITTREE_SHAMOUTI_ISLAND, FIGY_BERRY, PAL_NPC_BROWN
	object_event 24, 14, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ShamoutiIslandWilhomenaScript, EVENT_SHAMOUTI_ISLAND_WILHOMENA
	pokemon_event 25, 14, MARILL, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BLUE, ShamoutiIslandPikabluText, EVENT_SHAMOUTI_ISLAND_WILHOMENA
	object_event 20,  2, SPRITE_FAT_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, (1 << DAY), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiIslandFisherText, -1
	object_event 23,  2, SPRITE_FAT_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, (1 << DAY), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiIslandFisherText, -1
	object_event 12, 15, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ShamoutiIslandGrampsScript, -1
	object_event  9, 16, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_BAZAAR, MART_SHAMOUTI_2, -1

	object_const_def
	const SHAMOUTIISLAND_ALOLAN_EXEGGUTOR
	const SHAMOUTIISLAND_ALOLAN_EXEGGUTOR_HEAD

ShamoutiIslandFlyPoint:
	setflag ENGINE_FLYPOINT_SHAMOUTI
	endcallback

ShamoutiIslandAlolanExeggutorScript:
	special SpecialSnorlaxAwake
	iftruefwd .Awake
	applyonemovement SHAMOUTIISLAND_ALOLAN_EXEGGUTOR, exeggutor_shake
	showemote EMOTE_SLEEP, SHAMOUTIISLAND_ALOLAN_EXEGGUTOR_HEAD, 15
	jumpthistext

	text "The weird tree is…"
	line "fast asleep?"

	para "Is it a #mon?"
	done

.Awake:
	showtext .PokeFluteText
	applyonemovement SHAMOUTIISLAND_ALOLAN_EXEGGUTOR, exeggutor_shake
	opentext
	writetext .WokeUpText
	cry EXEGGUTOR, ALOLAN_FORM
	pause 15
	closetext
	loadvar VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon EXEGGUTOR, ALOLAN_FORM, 60
	startbattle
	disappear SHAMOUTIISLAND_ALOLAN_EXEGGUTOR
	disappear SHAMOUTIISLAND_ALOLAN_EXEGGUTOR_HEAD
	reloadmapafterbattle
	end

.PokeFluteText:
	text "The #gear was"
	line "placed near the"
	cont "weird tree…"
	done

.WokeUpText:
	text "The #mon"
	line "woke up!"
	done

ShamoutiIslandGrampsScript:
	checkevent EVENT_GOT_ODD_SOUVENIR_FROM_WILHOMENA
	iftruefwd .souvenir
	pokemart MARTTYPE_BAZAAR, MART_SHAMOUTI_1

.souvenir
	pokemart MARTTYPE_BAZAAR, MART_SHAMOUTI_1_SOUVENIR

ShamoutiIslandWilhomenaScript:
	checkevent EVENT_GOT_ODD_SOUVENIR_FROM_WILHOMENA
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem ODD_SOUVENIR
	iffalse_endtext
	setevent EVENT_GOT_ODD_SOUVENIR_FROM_WILHOMENA
	jumpthisopenedtext

.Text2:
	text "A shiny Pikachu"
	line "would be a real"
	cont "Pikablu."

	para "I've never found"
	line "one, but I'm happy"
	cont "with my Marill."
	done

.Text1:
	text "Hello again! Let"
	line "me give you that"
	cont "souvenir."
	done

ShamoutiIslandPikabluText:
	text "Pikablu: Rill!"
	done

ShamoutiIslandFisherText:
	text "Today we're dancing"
	line "for no reason. ♪"

	para "Someday we'll"
	line "disappear for no"
	cont "reason."

	para "…You thought we'd"
	line "block the road?"

	para "That would be"
	line "rude!"
	done

ShamoutiIslandSignText:
	text "Shamouti Island"
	done

ShamoutiHotelSignText:
	text "Shamouti Hotel"
	done

ShamoutiTouristCenterSignText:
	text "Shamouti Tourist"
	line "Center"
	done
