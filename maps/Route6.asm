const_value set 2
	const ROUTE6_POKEFAN_M1
	const ROUTE6_POKEFAN_M2
	const ROUTE6_POKEFAN_M3
	const ROUTE6_TWIN1
	const ROUTE6_TWIN2

Route6_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerPokefanmRex:
	trainer EVENT_BEAT_POKEFANM_REX, POKEFANM, REX, PokefanmRexSeenText, PokefanmRexBeatenText, 0, PokefanmRexScript

PokefanmRexScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad9ff
	waitbutton
	closetext
	end

TrainerPokefanmAllan:
	trainer EVENT_BEAT_POKEFANM_ALLAN, POKEFANM, ALLAN, PokefanmAllanSeenText, PokefanmAllanBeatenText, 0, PokefanmAllanScript

PokefanmAllanScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ada88
	waitbutton
	closetext
	end

TrainerTwinsDayanddani1:
	trainer EVENT_BEAT_TWINS_DAY_AND_DANI, TWINS, DAYANDDANI1, TwinsDayanddani1SeenText, TwinsDayanddani1BeatenText, 0, TrainerTwinsDayanddani1Script

TrainerTwinsDayanddani1Script:
	end_if_just_battled
	opentext
	writetext TwinsDayanddani1AfterText
	waitbutton
	closetext
	end

TrainerTwinsDayanddani2:
	trainer EVENT_BEAT_TWINS_DAY_AND_DANI, TWINS, DAYANDDANI2, TwinsDayanddani2SeenText, TwinsDayanddani2BeatenText, 0, TrainerTwinsDayanddani2Script

TrainerTwinsDayanddani2Script:
	end_if_just_battled
	opentext
	writetext TwinsDayanddani2AfterText
	waitbutton
	closetext
	end

PokefanMScript_0x1ad951:
	jumptextfaceplayer UnknownText_0x1ad957

Route6UndergroundPathSign:
	jumptext Route6UndergroundPathSignText

UnknownText_0x1ad957:
	text "The road is closed"
	line "until the problem"

	para "at the Power Plant"
	line "is solved."
	done

Route6UndergroundPathSignText:
	text "Underground Path"

	para "Cerulean City -"
	line "Vermilion City"
	done

PokefanmRexSeenText:
	text "My Phanpy is the"
	line "cutest in the"
	cont "world."
	done

PokefanmRexBeatenText:
	text "My Phanpy!"
	done

UnknownText_0x1ad9ff:
	text "Look how adorable"
	line "my Phanpy acts!"

	para "Isn't it cute"
	line "enough to make"
	cont "your heart melt?"
	done

PokefanmAllanSeenText:
	text "My Teddiursa is"
	line "the cutest in the"
	cont "world."
	done

PokefanmAllanBeatenText:
	text "My Teddiursa!"
	done

UnknownText_0x1ada88:
	text "Look how adorable"
	line "my Teddiursa acts!"

	para "Isn't it cute"
	line "enough to make"
	cont "your heart melt?"
	done

TwinsDayanddani1SeenText:
	text "Day: Are you going"
	line "to beat us?"
	done

TwinsDayanddani1BeatenText:
	text "Day: Waah!"
	done

TwinsDayanddani1AfterText:
	text "Day: You beat us…"
	done

TwinsDayanddani2SeenText:
	text "Dani: We'll knock"
	line "you flat!"
	done

TwinsDayanddani2BeatenText:
	text "Dani: Eeeeh!"
	done

TwinsDayanddani2AfterText:
	text "Dani: Looks like"
	line "we got bounced."
	done

Route6_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $9, $11, 1, ROUTE_6_UNDERGROUND_ENTRANCE
	warp_def $1, $6, 3, ROUTE_6_SAFFRON_GATE

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 11, 19, SIGNPOST_READ, Route6UndergroundPathSign

.PersonEvents:
	db 5
	person_event SPRITE_POKEFAN_M, 10, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 2, PokefanMScript_0x1ad951, EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH
	person_event SPRITE_POKEFAN_M, 24, 9, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerPokefanmRex, -1
	person_event SPRITE_POKEFAN_M, 24, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerPokefanmAllan, -1
	person_event SPRITE_TWIN, 17, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsDayanddani1, -1
	person_event SPRITE_TWIN, 17, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsDayanddani2, -1
