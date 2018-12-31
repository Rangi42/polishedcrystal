ShamoutiIsland_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ShamoutiIsland_MapEventHeader:

.Warps: db 6
	warp_def 13, 21, 1, SHAMOUTI_POKECENTER_1F
	warp_def 5, 33, 1, SHAMOUTI_HOTEL_1F
	warp_def 7, 16, 1, SHAMOUTI_TUNNEL
	warp_def 5, 27, 1, SHAMOUTI_TOURIST_CENTER
	warp_def 12, 31, 1, SHAMOUTI_HOUSE
	warp_def 13, 9, 1, SHAMOUTI_MERCHANT

.XYTriggers: db 0

.Signposts: db 3
	signpost 16, 16, SIGNPOST_JUMPTEXT, ShamoutiIslandSignText
	signpost 6, 26, SIGNPOST_JUMPTEXT, ShamoutiTouristCenterSignText
	signpost 6, 32, SIGNPOST_JUMPTEXT, ShamoutiHotelSignText

.PersonEvents: db 8
	person_event SPRITE_VILEPLUME, 8, 16, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ShamoutiIslandVileplumeScript, EVENT_SHAMOUTI_ISLAND_VILEPLUME
	fruittree_event 13, 34, FRUITTREE_SHAMOUTI_ISLAND, FIGY_BERRY
	person_event SPRITE_YOUNGSTER, 14, 24, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ShamoutiIslandYoungsterScript, EVENT_SHAMOUTI_ISLAND_PIKABLU_GUY
	person_event SPRITE_MARILL, 14, 25, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_POKEMON, MARILL, ShamoutiIslandPikabluText, EVENT_SHAMOUTI_ISLAND_PIKABLU_GUY
	person_event SPRITE_FISHER, 2, 20, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, (1 << DAY), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, ShamoutiIslandFisherText, -1
	person_event SPRITE_FISHER, 2, 23, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, (1 << DAY), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, ShamoutiIslandFisherText, -1
	person_event SPRITE_GRAMPS, 15, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, pokemart, MARTTYPE_BAZAAR, MART_SHAMOUTI_1, -1
	person_event SPRITE_COOLTRAINER_M, 16, 9, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, pokemart, MARTTYPE_BAZAAR, MART_SHAMOUTI_2, -1

const_value set 1
	const SHAMOUTIISLAND_VILEPLUME

ShamoutiIslandVileplumeScript:
	special SpecialSnorlaxAwake
	iftrue .Awake
	showemote EMOTE_SLEEP, SHAMOUTIISLAND_VILEPLUME, 15
	thistext

.VileplumeText:
	text "Vileplume is fast"
	line "asleep…"
	done

.Awake:
	showtext .PokeFluteText
	applyonemovement SHAMOUTIISLAND_VILEPLUME, tree_shake
	opentext
	writetext .WokeUpText
	cry VILEPLUME
	pause 15
	closetext
	writecode VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon VILEPLUME, 60
	startbattle
	disappear SHAMOUTIISLAND_VILEPLUME
	reloadmapafterbattle
	end

.PokeFluteText:
	text "The #gear was"
	line "placed near the"

	para "sleeping Vile-"
	line "plume…"
	done

.WokeUpText:
	text "Vileplume woke up!"
	done

ShamoutiIslandYoungsterScript:
	checkevent EVENT_GOT_ODD_SOUVENIR_FROM_PIKABLU_GUY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem ODD_SOUVENIR
	iffalse_endtext
	setevent EVENT_GOT_ODD_SOUVENIR_FROM_PIKABLU_GUY
	thisopenedtext

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
