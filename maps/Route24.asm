Route24_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_ROUTE24_BRIDGE_UNDERFOOT
	scene_const SCENE_ROUTE24_BRIDGE_OVERHEAD

	def_callbacks
	callback MAPCALLBACK_TILES, Route24TileScript
	callback MAPCALLBACK_CMDQUEUE, Route24SetUpPaletteSwap

	def_warp_events

	def_coord_events
	coord_event 19, 13, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 20, 12, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 21, 12, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 22, 13, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 20, 13, SCENE_ROUTE24_BRIDGE_UNDERFOOT, Route24BridgeUnderfootTrigger
	coord_event 21, 13, SCENE_ROUTE24_BRIDGE_UNDERFOOT, Route24BridgeUnderfootTrigger
	coord_event 16, 37, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 17, 37, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 20, 37, SCENE_ROUTE24_BRIDGE_UNDERFOOT, Route24BridgeUnderfootTrigger
	coord_event 21, 37, SCENE_ROUTE24_BRIDGE_UNDERFOOT, Route24BridgeUnderfootTrigger
	coord_event 25, 11, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 25, 13, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 25, 14, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 25, 15, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 25, 16, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 25, 17, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 25, 18, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 25, 19, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 25, 20, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger
	coord_event 25, 21, SCENE_ROUTE24_BRIDGE_OVERHEAD, Route24BridgeOverheadTrigger

	def_bg_events
	bg_event 15, 17, BGEVENT_ITEM + MAX_POTION, EVENT_ROUTE_24_HIDDEN_MAX_POTION
	bg_event 23,  9, BGEVENT_JUMPTEXT, Route24AdvancedTipsSignText

	def_object_events
	object_event 21, 23, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_TRAINER, 1, TrainerGruntM31, EVENT_ROUTE_24_ROCKET
	fruittree_event 16,  3, FRUITTREE_ROUTE_24, LANSAT_BERRY, PAL_NPC_PINK

	object_const_def
	const ROUTE24_ROCKET

Route24TileScript:
	checkscene
	iftruefwd .underfoot
	callasm Route24_OverheadBridgeAsm
	endcallback

.underfoot:
	callasm Route24_UnderfootBridgeAsm
	endcallback

Route24_OverheadBridgeAsm:
	changebridgeblock 20, 14, $39, ROUTE_24
	changebridgeblock 20, 16, $38, ROUTE_24
	changebridgeblock 20, 18, $38, ROUTE_24
	changebridgeblock 20, 20, $38, ROUTE_24
	changebridgeblock 20, 22, $38, ROUTE_24
	changebridgeblock 20, 24, $38, ROUTE_24
	changebridgeblock 20, 26, $38, ROUTE_24
	changebridgeblock 20, 28, $38, ROUTE_24
	changebridgeblock 20, 30, $38, ROUTE_24
	changebridgeblock 20, 32, $38, ROUTE_24
	changebridgeblock 20, 34, $38, ROUTE_24
	changebridgeblock 20, 36, $49, ROUTE_24
	jmp BufferScreen

Route24_UnderfootBridgeAsm:
	changebridgeblock 20, 14, $34, ROUTE_24
	changebridgeblock 20, 16, $34, ROUTE_24
	changebridgeblock 20, 18, $34, ROUTE_24
	changebridgeblock 20, 20, $34, ROUTE_24
	changebridgeblock 20, 22, $34, ROUTE_24
	changebridgeblock 20, 24, $34, ROUTE_24
	changebridgeblock 20, 26, $34, ROUTE_24
	changebridgeblock 20, 28, $34, ROUTE_24
	changebridgeblock 20, 30, $34, ROUTE_24
	changebridgeblock 20, 32, $34, ROUTE_24
	changebridgeblock 20, 34, $34, ROUTE_24
	changebridgeblock 20, 36, $4a, ROUTE_24
	jmp BufferScreen

Route24BridgeOverheadTrigger:
	callasm Route24_OverheadBridgeAsm
	callthisasm
	xor a
	jr Route24_FinishBridge

Route24BridgeUnderfootTrigger:
	callasm Route24_UnderfootBridgeAsm
	callthisasm
	ld a, $1
Route24_FinishBridge:
	ld [wWalkingOnBridge], a
	ld [wRoute24SceneID], a ; setscene a
	jmp GenericFinishBridge

Route24SetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 0, 255, 0, 255, PAL_BG_YELLOW, OverworldYellowPalettes, NuggetBridgePalettes
	db -1 ; end

TrainerGruntM31:
	trainer GRUNTM, 31, EVENT_BEAT_ROCKET_GRUNTM_31, Route24RocketSeenText, Route24RocketBeatenText, 0, Route24RocketScript

Route24RocketScript:
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext Route24RocketAfterBattleText
	promptbutton
	special Special_FadeOutMusic
	writetext Route24RocketDisappearsText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE24_ROCKET
	setevent EVENT_LEARNED_ABOUT_MACHINE_PART
	clearevent EVENT_CERULEAN_CAPE_BOYFRIEND
	setmapscene CERULEAN_CAPE, SCENE_CERULEANCAPE_MISTYS_DATE
	pause 25
	special Special_FadeInQuickly
	playmusic MUSIC_NUGGET_BRIDGE_HGSS
	end

Route24RocketSeenText:
	text "Hey, kid! Me am a"
	line "Team Rocket member"
	cont "kind of guy!"

	para "Come from another"
	line "country, a trainer"
	cont "number one, me!"

	para "Think I did, if"
	line "stop the energy,"

	para "be big panic for"
	line "here people!"

	para "Secret it is my"
	line "mission, so tell"
	cont "you I not!"

	para "But! If win you do"
	line "versus me, a man I"

	para "be and mine secret"
	line "to you I tell."

	para "Hey, kid! Battle"
	line "begin we do!"
	done

Route24RocketBeatenText:
	text "Ayieeeh! No, no,"
	line "no, believe it I"
	cont "can't!"

	para "Strong very much"
	line "be you! Match I am"
	cont "not to you!"
	done

Route24RocketAfterBattleText:
	text "OK. Tell you mine"
	line "secret will I."

	para "Machine Part steal"
	line "by me, hide it I"

	para "did in Gym of the"
	line "Cerulean."

	para "Inside water put"
	line "it I did. Look for"

	para "in water center of"
	line "Gym at."

	para "But you forget me"
	line "not!"

	para "Beat you for sure"
	line "will Team Rocket."

	para "Come from Johto"
	line "will they, mine"

	para "friends, yes. Will"
	line "revenge they are."
	done

Route24RocketDisappearsText:
	text "…"

	para "You say what? Team"
	line "Rocket bye-bye a"

	para "go-go? Broken it"
	line "is says you?"

	para "Oh, no! Should I"
	line "do what now on"
	cont "from, me?"
	done

Route24AdvancedTipsSignText:
	text "Advanced Tips!"

	para "The Sheer Force"
	line "Ability negates"

	para "side effects of"
	line "moves, but it"

	para "also negates some"
	line "other effects!"

	para "In particular,"
	line "the damage done"

	para "by a held Life Orb"
	line "is ignored!"
	done
