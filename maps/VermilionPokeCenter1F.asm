VermilionPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, VERMILION_CITY, 2
	warp_event  6,  7, VERMILION_CITY, 2
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalLtSurgeScript

	def_object_events
	pc_nurse_event  5, 1
	object_event  8,  2, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPokeCenter1FSightseerMScript, -1
	object_event  2,  5, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionPokeCenter1FSailorText, -1
	object_event  9,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionPokeCenter1FBugCatcherText, -1

PokemonJournalLtSurgeScript:
	setflag ENGINE_READ_LT_SURGE_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Lt.Surge!"

	para "Lt.Surge is rumor-"
	line "ed to have been a"

	para "pilot while home"
	line "in America."

	para "He used the elec-"
	line "tricity generated"

	para "by #mon to pow-"
	line "er his plane."
	done

VermilionPokeCenter1FSightseerMScript:
	checkevent EVENT_VERMILION_CITY_SNORLAX
	iftrue_jumptextfaceplayer .SnorlaxText
	jumpthistextfaceplayer

	text "A sleeping #mon"
	line "is lying in front"
	cont "of Diglett's Cave."

	para "It's a fantastic"
	line "opportunity to get"

	para "it, but how do you"
	line "wake it up?"
	done

.SnorlaxText:
	text "There used to be a"
	line "sleeping #mon"

	para "lying in front of"
	line "Diglett's Cave."

	para "But it seems to"
	line "have disappeared."
	done

VermilionPokeCenter1FSailorText:
	text "The Fast Ship is a"
	line "great place to"

	para "meet and battle"
	line "trainers."
	done

VermilionPokeCenter1FBugCatcherText:
	text "Oh? You have some"
	line "Badges I've never"
	cont "seen before."

	para "Oh, I get it. You"
	line "got them in Johto."
	done
