Route24_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, Route24TileScript

	db 0 ; warp events

	db 10 ; coord events
	coord_event 19, 15, 1, Route24BridgeOverheadTrigger
	coord_event 20, 14, 1, Route24BridgeOverheadTrigger
	coord_event 21, 14, 1, Route24BridgeOverheadTrigger
	coord_event 22, 15, 1, Route24BridgeOverheadTrigger
	coord_event 20, 39, 1, Route24BridgeOverheadTrigger
	coord_event 21, 39, 1, Route24BridgeOverheadTrigger
	coord_event 20, 15, 0, Route24BridgeUnderfootTrigger
	coord_event 21, 15, 0, Route24BridgeUnderfootTrigger
	coord_event 20, 38, 0, Route24BridgeUnderfootTrigger
	coord_event 21, 38, 0, Route24BridgeUnderfootTrigger

	db 1 ; bg events
	bg_event 16,  5, SIGNPOST_ITEM + POTION, EVENT_ROUTE_24_HIDDEN_POTION

	db 1 ; object events
	object_event 21, 25, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 1, TrainerGruntM31, EVENT_ROUTE_24_ROCKET

	const_def 1 ; object constants
	const ROUTE24_ROCKET

Route24TileScript:
	checkscene
	iftrue .underfoot
	callasm Route24_OverheadBridgeAsm
	return

.underfoot:
	callasm Route24_UnderfootBridgeAsm
	return

Route24_OverheadBridgeAsm:
	changebridgeblock 20, 16, $ee, ROUTE_24
	changebridgeblock 20, 18, $ec, ROUTE_24
	changebridgeblock 20, 20, $ec, ROUTE_24
	changebridgeblock 20, 22, $ec, ROUTE_24
	changebridgeblock 20, 24, $ec, ROUTE_24
	changebridgeblock 20, 26, $ec, ROUTE_24
	changebridgeblock 20, 28, $ec, ROUTE_24
	changebridgeblock 20, 30, $ec, ROUTE_24
	changebridgeblock 20, 32, $ec, ROUTE_24
	changebridgeblock 20, 34, $ec, ROUTE_24
	changebridgeblock 20, 36, $ec, ROUTE_24
	changebridgeblock 20, 38, $ed, ROUTE_24
	jp BufferScreen

Route24_UnderfootBridgeAsm:
	changebridgeblock 20, 16, $d2, ROUTE_24
	changebridgeblock 20, 18, $d2, ROUTE_24
	changebridgeblock 20, 20, $d2, ROUTE_24
	changebridgeblock 20, 22, $d2, ROUTE_24
	changebridgeblock 20, 24, $d2, ROUTE_24
	changebridgeblock 20, 26, $d2, ROUTE_24
	changebridgeblock 20, 28, $d2, ROUTE_24
	changebridgeblock 20, 30, $d2, ROUTE_24
	changebridgeblock 20, 32, $d2, ROUTE_24
	changebridgeblock 20, 34, $d2, ROUTE_24
	changebridgeblock 20, 36, $d2, ROUTE_24
	changebridgeblock 20, 38, $b1, ROUTE_24
	jp BufferScreen

Route24BridgeOverheadTrigger:
	callasm Route24_OverheadBridgeAsm
	thisasm
	xor a
	jr Route24_FinishBridge

Route24BridgeUnderfootTrigger:
	callasm Route24_UnderfootBridgeAsm
	thisasm
	ld a, $1
Route24_FinishBridge:
	ld [wWalkingOnBridge], a
	ld [wRoute24Trigger], a ; setscene a
	jp RefreshScreen_BridgeUpdate ; refreshscreen (optimized)

TrainerGruntM31:
	trainer GRUNTM, 31, EVENT_BEAT_ROCKET_GRUNTM_31, UnknownText_0x1adc2e, UnknownText_0x1add67, 0, RocketScript_0x1adbfa

RocketScript_0x1adbfa:
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext UnknownText_0x1addc0
	buttonsound
	special Special_FadeOutMusic
	writetext UnknownText_0x1adee1
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE24_ROCKET
	setevent EVENT_LEARNED_ABOUT_MACHINE_PART
	clearevent EVENT_CERULEAN_CAPE_BOYFRIEND
	setmapscene CERULEAN_CAPE, $1
	pause 25
	special Special_FadeInQuickly
	playmusic MUSIC_NUGGET_BRIDGE_HGSS
	end

UnknownText_0x1adc2e:
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

UnknownText_0x1add67:
	text "Ayieeeh! No, no,"
	line "no, believe it I"
	cont "can't!"

	para "Strong very much"
	line "be you! Match I am"
	cont "not to you!"
	done

UnknownText_0x1addc0:
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

UnknownText_0x1adee1:
	text "…"

	para "You say what? Team"
	line "Rocket bye-bye a"

	para "go-go? Broken it"
	line "is says you?"

	para "Oh, no! Should I"
	line "do what now on"
	cont "from, me?"
	done
