Route39Barn_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, ROUTE_39, 1
	warp_event  4,  7, ROUTE_39, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, MILTANK, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MooMoo, -1
	object_event  2,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route39BarnTwin1Script, -1
	object_event  4,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route39BarnTwin2Script, -1

Route39BarnTwin1Script:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Text_MoomooIsSick
	waitbutton
	closetext
	turnobject LAST_TALKED, RIGHT
	end

.FeedingMooMoo:
	writetext Text_WereFeedingMoomoo
	waitbutton
	closetext
	turnobject LAST_TALKED, RIGHT
	end

Route39BarnTwin2Script:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Text_MoomooIsSick
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

.FeedingMooMoo:
	writetext Text_WereFeedingMoomoo
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

MooMoo:
	checkevent EVENT_HEALED_MOOMOO
	iftrue .HappyCow
	opentext
	writetext Text_WeakMoo
	setval MILTANK
	special PlaySlowCry
	promptbutton
	writetext Text_ItsCryIsWeak
	checkevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	iftrue .GiveBerry
	waitendtext

.GiveBerry:
	promptbutton
	writetext Text_AskGiveBerry
	yesorno
	iffalse_jumpopenedtext Text_RefusedToGiveBerry
	checkitem ORAN_BERRY
	iffalse .MaybeSitrusBerry
	takeitem ORAN_BERRY
	readmem wMooMooBerries
	addval 1
	writemem wMooMooBerries
	ifequal 3, .ThreeOranBerries
	ifequal 5, .FiveOranBerries
	ifequal 7, .SevenOranBerries
	jumpopenedtext Text_GaveOranBerry

.MaybeSitrusBerry:
	checkitem SITRUS_BERRY
	iffalse_jumpopenedtext Text_NoBerries
	takeitem SITRUS_BERRY
	readmem wMooMooBerries
	addval 2
	writemem wMooMooBerries
	ifgreater 6, .SevenSitrusBerries
	ifgreater 4, .FiveSitrusBerries
	ifgreater 2, .ThreeSitrusBerries
	jumpopenedtext Text_GaveSitrusBerry

.ThreeOranBerries:
	writetext Text_GaveOranBerry
	promptbutton
	jumpopenedtext Text_LittleHealthier

.FiveOranBerries:
	writetext Text_GaveOranBerry
	promptbutton
	jumpopenedtext Text_QuiteHealthy

.SevenOranBerries:
	playmusic MUSIC_HEAL
	writetext Text_GaveOranBerry
	pause 60
	promptbutton
	special RestartMapMusic
	setevent EVENT_HEALED_MOOMOO
	jumpopenedtext Text_TotallyHealthy

.ThreeSitrusBerries:
	writetext Text_GaveSitrusBerry
	promptbutton
	jumpopenedtext Text_LittleHealthier

.FiveSitrusBerries:
	writetext Text_GaveSitrusBerry
	promptbutton
	jumpopenedtext Text_QuiteHealthy

.SevenSitrusBerries:
	playmusic MUSIC_HEAL
	writetext Text_GaveSitrusBerry
	pause 60
	promptbutton
	special RestartMapMusic
	setevent EVENT_HEALED_MOOMOO
	jumpopenedtext Text_TotallyHealthy

.HappyCow:
	showcrytext MoomooHappyMooText, MILTANK
	end

Text_MoomooIsSick:
	text "Moomoo is sick…"

	para "She needs lots of"
	line "healthy Berries."
	done

Text_WereFeedingMoomoo:
	text "We're feeding"
	line "Moomoo!"
	done

Text_WeakMoo:
	text "Miltank: …Moo…"
	done

Text_ItsCryIsWeak:
	text "Its cry is weak…"
	done

MoomooHappyMooText:
	text "Miltank: Mooo!"
	done

Text_AskGiveBerry:
	text "Give an Oran or"
	line "Sitrus Berry to"
	cont "Miltank?"
	done

Text_GaveOranBerry:
	text "<PLAYER> gave an"
	line "Oran Berry to"
	cont "Miltank."
	done

Text_GaveSitrusBerry:
	text "<PLAYER> gave a"
	line "Sitrus Berry to"
	cont "Miltank."
	done

Text_LittleHealthier:
	text "Miltank became a"
	line "little healthier!"
	done

Text_QuiteHealthy:
	text "Miltank became"
	line "quite healthy!"
	done

Text_TotallyHealthy:
	text "Miltank became"
	line "totally healthy!"
	done

Text_NoBerries:
	text "<PLAYER> has no"
	line "Oran or Sitrus"
	cont "Berries…"
	done

Text_RefusedToGiveBerry:
	text "<PLAYER> wouldn't"
	line "give a Berry."

	para "Miltank looks sad."
	done
