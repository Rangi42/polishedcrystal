const_value set 2
	const NAVELROCKROOF_GREEN

NavelRockRoof_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_SPRITES, .DailyLeafRematchCallback

.DailyLeafRematchCallback:
	disappear NAVELROCKROOF_GREEN
	checkflag ENGINE_LEAF_IN_NAVEL_ROCK
	iftrue .Disappear
	appear NAVELROCKROOF_GREEN
.Disappear
	return

.Appear:
	appear NAVELROCKROOF_GREEN
	return

Leaf:
	special Special_FadeOutMusic
	faceplayer
	opentext
	writetext LeafText
	waitbutton
	closetext
	winlosstext LeafWinLossText, LeafWinLossText
	loadtrainer LEAF, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special Special_FadeOutMusic
	faceplayer
	opentext
	writetext LeafAfterText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear NAVELROCKROOF_GREEN
	pause 15
	special Special_FadeInQuickly
	pause 30
	special HealParty
	refreshscreen $0
	credits
	end

LeafText:
	text "<......><......>"
	line "<......><......>!"
	done

LeafWinLossText:
	text "…!"
	done

LeafAfterText:
	text "<......><......>"
	line "<......><......>"
	done

NavelRockRoof_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $9, 14, NAVEL_ROCK_INSIDE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_LEAF, 0, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Leaf, EVENT_LEAF_IN_NAVEL_ROCK
