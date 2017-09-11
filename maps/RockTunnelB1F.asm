RockTunnelB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

RockTunnelB1F_MapEventHeader:

.Warps: db 5
	warp_def 3, 3, 3, ROCK_TUNNEL_1F
	warp_def 9, 17, 4, ROCK_TUNNEL_1F
	warp_def 3, 23, 5, ROCK_TUNNEL_1F
	warp_def 19, 27, 6, ROCK_TUNNEL_1F
	warp_def 13, 3, 7, ROCK_TUNNEL_1F

.XYTriggers: db 0

.Signposts: db 1
	signpost 18, 3, SIGNPOST_ITEM + MAX_POTION, EVENT_ROCK_TUNNEL_B1F_HIDDEN_MAX_POTION

.PersonEvents: db 6
	person_event SPRITE_FISHER, 14, 27, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerFirebreatherDick, -1
	person_event SPRITE_HEX_MANIAC, 24, 24, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerHexManiacVivian, -1
	itemball_event 17, 7, IRON, 1, EVENT_ROCK_TUNNEL_B1F_IRON
	itemball_event 4, 8, PP_UP, 1, EVENT_ROCK_TUNNEL_B1F_PP_UP
	itemball_event 2, 15, REVIVE, 1, EVENT_ROCK_TUNNEL_B1F_REVIVE
	strengthboulder_event 25, 10

TrainerFirebreatherDick:
	trainer EVENT_BEAT_FIREBREATHER_DICK, FIREBREATHER, DICK, FirebreatherDickSeenText, FirebreatherDickBeatenText, 0, FirebreatherDickScript

FirebreatherDickScript:
	end_if_just_battled
	jumptextfaceplayer FirebreatherDickAfterText

TrainerHexManiacVivian:
	trainer EVENT_BEAT_HEX_MANIAC_VIVIAN, HEX_MANIAC, VIVIAN, HexManiacVivianSeenText, HexManiacVivianBeatenText, 0, HexManiacVivianScript

HexManiacVivianScript:
	end_if_just_battled
	jumptextfaceplayer HexManiacVivianAfterText

FirebreatherDickSeenText:
	text "I'm using fire to"
	line "to see my way out!"
	done

FirebreatherDickBeatenText:
	text "Help! The fire"
	line "went out!"
	done

FirebreatherDickAfterText:
	text "A #mon that"
	line "knows Flash is"

	para "helpful in dark"
	line "caves like this."
	done

HexManiacVivianSeenText:
	text "Do you hear the"
	line "voices calling?"
	done

HexManiacVivianBeatenText:
	text "It was only an"
	line "echo?!"
	done

HexManiacVivianAfterText:
	text "This spooky hex"
	line "maniac persona"

	para "actually takes"
	line "effort."
	done
