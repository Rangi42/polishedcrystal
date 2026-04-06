GoldenrodPokecomCenterOffice_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  8, GOLDENROD_POKECOM_CENTER_1F, 3
	warp_event  1,  8, GOLDENROD_POKECOM_CENTER_1F, 3

	def_coord_events

	def_bg_events
	bg_event  3,  2, BGEVENT_UP, RangiComputerScript
	bg_event  6,  2, BGEVENT_UP, LunaComputerScript
	bg_event  9,  2, BGEVENT_UP, FredrikComputerScript
	bg_event 12,  2, BGEVENT_UP, EmiComputerScript
	bg_event  6,  5, BGEVENT_UP, AizawaComputerScript
	bg_event  9,  5, BGEVENT_UP, VulcanComputerScript
	bg_event 12,  5, BGEVENT_UP, SourComputerScript

	def_object_events
	object_event  4,  4, SPRITE_SCIENTIST_F, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_RANGI, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminRangiText, -1
	object_event  7,  3, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminLunaText, -1
	object_event 10,  3, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminFredrikText, -1
	object_event 13,  3, SPRITE_DAISY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_EMI, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminEmiText, -1
	object_event  7,  6, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminAizawaText, -1
	object_event 10,  6, SPRITE_PI, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_AZURE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminVulcanText, -1
	object_event 13,  6, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AdminSourText, -1
	object_event  4,  1, SPRITE_MON_ICON, SPRITEMOVEDATA_ADMIN_MEOWTH, 0, MEOWTH, -1, PAL_MON_BROWN, OBJECTTYPE_SCRIPT, NO_FORM, AdminEldredScript, -1

AdminRangiText:
	text "Rangi: I hope"
	line "you're enjoying"

	para "your journey"
	line "through this game!"

	para "We had trouble"
	line "fitting all the"
	cont "data in for it."

	para "There was barely"
	line "even enough room"
	cont "for my sprite!"
	done

RangiComputerScript:
	jumpthistext

	text "“Optimizing…” is"
	line "blinking on the"
	cont "screen."

	para "It seems to be"
	line "taking a while."
	done

AdminLunaText:
	text "Luna: When you"
	line "Wonder Traded"

	para "with someone in"
	line "another region"

	para "for the first"
	line "time, weren't you"
	cont "impressed?"

	para "I built the orig-"
	line "inal system right"
	cont "here in Goldenrod!"
	done

LunaComputerScript:
	jumpthistext

	text "Network traffic"
	line "from Wonder Trades"

	para "is streaming by"
	line "on the screen."
	done

AdminFredrikText:
	text "Fredrik: Bill's PC"
	line "Storage System"
	cont "is open-source,"

	para "so I was able to"
	line "completely re-"

	para "write and upgrade"
	line "his database!"
	done

FredrikComputerScript:
	jumpthistext

	text "A dozen windows"
	line "are open at once,"

	para "each related to"
	line "its own feature."
	done

AdminEmiText:
	text "Emi: Have you"
	line "seen the Summary"
	cont "of your #mon?"

	para "I'm visiting from"
	line "the Beria region"

	para "to bring UI like"
	line "that to Johto!"

	para "Come say hello if"
	line "you're ever in"
	cont "Amethyst Town!"
	done

EmiComputerScript:
	jumpthistext

	text "Lots of code is"
	line "covered up by a"
	cont "game of Solitaire."
	done

AdminAizawaText:
	text "Aizawa: Dialog,"
	line "map designs,"
	cont "character sprites,"
	cont "trainer parties…"

	para "Game Freak over"
	line "in Kanto is lucky"

	para "to have a whole"
	line "company for this!"
	done

AizawaComputerScript:
	jumpthistext

	text "A program called"
	line "Polished Map++ is"
	cont "displaying a"

	para "half-drawn trop-"
	line "ical island."
	done

AdminVulcanText:
	text "Vulcan: How's the"
	line "weather?"

	para "That's no small"
	line "talk… I actually"
	cont "implemented it!"

	para "We thought it"
	line "couldn't be done…"

	para "I proved myself"
	line "wrong!"
	done

VulcanComputerScript:
	jumpthistext

	text "A weather map"
	line "is displayed on"
	cont "the screen."

	para "It's showing"
	line "rain in Johto."
	done

AdminSourText:
	text "Sour: How do you"
	line "like the move"

	para "animations in"
	line "battles?"

	para "I really like to"
	line "make every move"
	cont "a joy to use!"
	done

SourComputerScript:
	jumpthistext

	text "There's a goofy"
	line "image of an egg-"
	cont "shaped man with"
	cont "a moustache."
	done

AdminEldredScript:
	opentext
	writetext AdminMeowthText
	cry MEOWTH
	promptbutton
	jumpthisopenedtext

	text "A mischievous"
	line "Meowth is pawing"
	cont "at the keyboard."
	done

AdminMeowthText:
	text "Eldred: Miaou!"
	done
