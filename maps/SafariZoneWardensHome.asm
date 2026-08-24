SafariZoneWardensHome_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  7, FUCHSIA_CITY, 5
	warp_event  5,  7, FUCHSIA_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_JUMPSTD, picturebookshelf
	bg_event  5,  0, BGEVENT_JUMPTEXT, WardenPhotoText
	bg_event  7,  0, BGEVENT_JUMPTEXT, SafariZonePhotoText
	bg_event  8,  1, BGEVENT_JUMPTEXT, WardensHouseCuriosText
	bg_event  9,  1, BGEVENT_JUMPTEXT, WardensHouseCuriosText

	def_object_events
	object_event  2,  4, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, WardensGranddaughter, -1

WardensGranddaughter:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_WARDENS_GRANDDAUGHTER
	iftruefwd .AlreadyMet
	writetext WardensGranddaughterText1
	yesorno
	iffalse_jumpopenedtext WardensGranddaughterText2
	writetext WardensGranddaughterText3
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_WARDENS_GRANDDAUGHTER
	end
.AlreadyMet:
	jumpthisopenedtext

	text "Many people were"
	line "disappointed that"

	para "the Safari Game"
	line "closed down,"

	para "but I don't really"
	line "miss it."

	para "I just miss my"
	line "grandpa…"
	done

WardensGranddaughterText1:
	text "My grandpa is the"
	line "Warden for the"
	cont "Safari Zone."

	para "At least he was…"

	para "If I tell you"
	line "the story, do you"

	para "promise not to"
	line "gossip about it?"
	done

WardensGranddaughterText2:
	text "…I see…"
	done

WardensGranddaughterText3:
	text "Three years ago,"
	line "it turned out he"

	para "had allowed Team"
	line "Rocket to poach"

	para "#mon from the"
	line "Safari Zone to be"

	para "sold at the Rocket"
	line "Game Corner."

	para "He took off over-"
	line "seas to avoid"
	cont "being arrested."

	para "…It's not fair."

	para "I hear Silph's"
	line "chief was just as"

	para "involved with Team"
	line "Rocket, but he"

	para "paid for charity"
	line "work doing #mon"

	para "conservation, and"
	line "still has his job."
	done

WardenPhotoText:
	text "It's a photo of a"
	line "grinning old man"

	para "who's surrounded"
	line "by #mon."
	done

SafariZonePhotoText:
	text "It's a photo of a"
	line "huge grassy plain"

	para "with rare #mon"
	line "frolicking in it."
	done

WardensHouseCuriosText:
	text "It's a curio"
	line "cabinet full of"

	para "fossils and old"
	line "#mon merchan-"
	cont "dise."
	done
