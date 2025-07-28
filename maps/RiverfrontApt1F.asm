RiverfrontApt1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  4, OLSTEETON, 9
	warp_event  0,  5, OLSTEETON, 10
	warp_event  9,  4, OLSTEETON, 11
	warp_event  9,  5, OLSTEETON, 12
	warp_event  9,  2, RIVERFRONT_APT_2F, 1
	warp_event  5,  0, RIVERFRONT_APT_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event  6,  0, BGEVENT_JUMPTEXT, RiverfrontApt1FDirectoryText

	def_object_events
	object_event  0,  2, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, RiverfrontApt1FPokefanFText, -1
	object_event  1,  1, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, RiverfrontApt1FBugCatcherText, -1
	object_event  5,  7, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RiverfrontApt1FGentlemanText, -1


RiverfrontApt1FGentlemanText:
	text "There will be"
	line "no running in"
	cont "my lobby!"
	done

RiverfrontApt1FPokefanFText:
	text "I really love "
	line "my child..."

	para "But today,"
	line "he is testin'"
	cont "my last nerve."
	done

RiverfrontApt1FBugCatcherText:
	text "Mom..."
	line "Momma...Mom"

	para "Mommy...Mama"
	line "when can I get"
	cont "a #mon??"
	done

RiverfrontApt1FDirectoryText:
	text "1F Lobby"

	para "2F Jacob, Zach"
	line "Isabelle"

	para "3F James, Alex"
	line "VACANT"

	para "4F Rebecca,"
	line "PRIVATE, Amanda"

	para "5F Penthouse"

	para "Rooftop Garden"
	done
