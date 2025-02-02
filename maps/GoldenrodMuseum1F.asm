GoldenrodMuseum1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  7, GOLDENROD_CITY, 18
	warp_event  7,  7, GOLDENROD_CITY, 18
	warp_event 13,  7, GOLDENROD_MUSEUM_2F, 1

	def_coord_events

	def_bg_events
	bg_event  4,  1, BGEVENT_READ, GoldenrodMuseum1FLodestoneSignpostScript
	bg_event  8,  1, BGEVENT_JUMPTEXT, GoldenrodMuseum1FRadioDishText
	bg_event  9,  1, BGEVENT_JUMPTEXT, GoldenrodMuseum1FRadioDishText
	bg_event 12,  1, BGEVENT_JUMPTEXT, GoldenrodMuseum1FHarborText
	bg_event 13,  1, BGEVENT_JUMPTEXT, GoldenrodMuseum1FHarborText
	bg_event  1,  4, BGEVENT_JUMPTEXT, GoldenrodMuseum1FDrillText
	bg_event  2,  4, BGEVENT_JUMPTEXT, GoldenrodMuseum1FDrillText

	def_object_events
	object_event  1,  2, SPRITE_SLOWPOKETAIL, SPRITEMOVEDATA_MUSEUM_DRILL_DOWN, 0, 0, -1, -1, PAL_NPC_DRILL, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  2,  2, SPRITE_SLOWPOKETAIL, SPRITEMOVEDATA_MUSEUM_DRILL_UP, 0, 0, -1, -1, PAL_NPC_DRILL, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  7,  4, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMuseumReceptionistText, -1
	object_event 13,  6, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMuseumOfficerText, -1
	object_event  1,  5, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMuseum1FHikerText, -1
	object_event 12,  3, SPRITE_BIG_LAPRAS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PEARL, OBJECTTYPE_COMMAND, jumptext, GoldenrodMuseum1FBigPearlText, -1
	object_event 13,  3, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMuseum1FRocketScoutScript, EVENT_GOLDENROD_CITY_ROCKET_SCOUT


GoldenrodMuseum1FLodestoneSignpostScript:
	reanchormap
	trainerpic METEORITE
	waitbutton
	closepokepic
	jumptext GoldenrodMuseum1FLodestoneSignpostText

GoldenrodMuseum1FRocketScoutScript:
	opentext
	writetext GoldenrodMuseum1FRocketScoutText1
	promptbutton
	faceplayer
	writetext GoldenrodMuseum1FRocketScoutText2
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

GoldenrodMuseumReceptionistText:
	text "Welcome to the"
	line "Goldenrod City"
	cont "Museum."

	para "In celebration of"
	line "our grand opening,"

	para "admission is free"
	line "of charge."

	para "Please, feel free"
	line "to look around,"

	para "and we hope you"
	line "enjoy your visit."
	done

GoldenrodMuseumOfficerText:
	text "I'm keeping my eye"
	line "on you kid!"

	para "Hahaha! I'm just"
	line "messing with ya!"

	para "I'm keeping an eye"
	line "on everyone…"
	done

GoldenrodMuseum1FLodestoneSignpostText:
	text "Lodestone from the"
	line "construction of"
	cont "Magnet Tunnel."
	done

GoldenrodMuseum1FDrillText:
	text "It's a large drill"
	line "used to tunnel"

	para "through super"
	line "dense rock."
	done

GoldenrodMuseum1FHikerText:
	text "I heard they had"
	line "to use equipment"

	para "like this drill"
	line "to excavate the"

	para "tunnel for the"
	line "Magnet Train."
	done

GoldenrodMuseum1FRadioDishText:
	text "A metallic dish"
	line "used for trans-"

	para "mitting radio"
	line "waves."
	done

GoldenrodMuseum1FHarborText:
	text "An aquarium filled"
	line "with Magikarp!"
	done

GoldenrodMuseum1FBigPearlText:
	text "It's a huge pearl"
	line "fished up from"
	cont "Goldenrod Harbor."
	done

GoldenrodMuseum1FRocketScoutText1:
	text "Hmm… This would"
	line "fetch quite a"
	cont "heavy price."

	para "Now… how do I get"
	line "it out of here"

	para "without getting"
	line "caught?"
	done

GoldenrodMuseum1FRocketScoutText2:
	text "Don't you know it's"
	line "rude to stare?"
	cont "Beat it kid!"
	done
