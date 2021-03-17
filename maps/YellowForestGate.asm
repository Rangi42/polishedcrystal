YellowForestGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  0, YELLOW_FOREST, 1
	warp_event  5,  0, YELLOW_FOREST, 2
	warp_event  4,  7, ROUTE_48, 1
	warp_event  5,  7, ROUTE_48, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, YellowForestGateOfficerText, -1
	object_event  9,  3, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_LEFT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, YellowForestGateNurseScript, -1
	pokemon_event  9,  4, CHANSEY, -1, -1, PAL_NPC_RED, YellowForestGateChanseyText, -1
	object_event  6,  4, SPRITE_CLERK, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_INFORMAL, MART_YELLOW_FOREST, -1

YellowForestGateNurseScript:
	showtextfaceplayer YellowForestGateNurseText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	jumptext YellowForestGateNurseHealedText

YellowForestGateOfficerText:
	text "There are rare"
	line "#mon in"
	cont "Yellow Forest!"

	para "Don't forget to"
	line "bring # Balls!"

	para "That guy is sell-"
	line "ing some spares."
	done

YellowForestGateNurseText:
	text "Your #mon look"
	line "worn out."

	para "Let me heal them"
	line "for you."
	done

YellowForestGateNurseHealedText:
	text "All done!"

	para "Your #mon"
	line "are fully healed."
	done

YellowForestGateChanseyText:
	text "Chansey: Sii!"
	done
