SilphCo1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .SilphCo1FMoveOfficerCallback

	def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 7
	warp_event  3,  7, SAFFRON_CITY, 7
	warp_event 13,  0, SILPH_CO_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 13,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SilphCoOfficerScript, -1
	object_event  4,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCoReceptionistText, -1
	object_event 11,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo1FGentlemanText, -1
	object_event  8,  2, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo1FCooltrainerfText, -1

	object_const_def
	const SILPHCO1F_OFFICER

.SilphCo1FMoveOfficerCallback:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse .Nothing
	moveobject SILPHCO1F_OFFICER, 14, 1
.Nothing
	endcallback

SilphCoOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .OfficerScriptAfterPowerRestored
	jumpopenedtext SilphCoOfficerText

.OfficerScriptAfterPowerRestored
	jumpopenedtext SilphCoOfficerText_GotUpGrade

SilphCoReceptionistText:
	text "Welcome. This is"
	line "Silph Co.'s Head"
	cont "Office Building."
	done

SilphCoOfficerText:
	text "Only employees are"
	line "permitted to go"
	cont "upstairs."

	para "The main power"
	line "isn't working,"

	para "and the CEO wants"
	line "high security in"

	para "case of an"
	line "emergency."

	para "We learned our"
	line "lesson about that"
	cont "three years ago."
	done

SilphCoOfficerText_GotUpGrade:
	text "You're responsible"
	line "for restoring the"
	cont "power supply?"

	para "Thank you! Now"
	line "R&D can continue."

	para "Feel free to take"
	line "a tour upstairs."
	done

SilphCo1FGentlemanText:
	text "I have an appoint-"
	line "ment with the"

	para "chief engineer"
	line "here at Silph Co."
	done

SilphCo1FCooltrainerfText:
	text "I'm trying to"
	line "pluck up the"
	cont "courage to ask"

	para "the receptionist"
	line "out on a date."

	para "Just as soon as"
	line "she's done on the"
	cont "phone…"
	done
