const_value set 2
	const ROUTE39BARN_TWIN1
	const ROUTE39BARN_TWIN2
	const ROUTE39BARN_MOOMOO

Route39Barn_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TwinScript_0x9cc76:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Text_MoomooIsSick
	waitbutton
	closetext
	spriteface ROUTE39BARN_TWIN1, RIGHT
	end

.FeedingMooMoo:
	writetext Text_WereFeedingMoomoo
	waitbutton
	closetext
	spriteface ROUTE39BARN_TWIN1, RIGHT
	end

TwinScript_0x9cc90:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Text_MoomooIsSick
	waitbutton
	closetext
	spriteface ROUTE39BARN_TWIN2, LEFT
	end

.FeedingMooMoo:
	writetext Text_WereFeedingMoomoo
	waitbutton
	closetext
	spriteface ROUTE39BARN_TWIN2, LEFT
	end

MooMoo:
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .HappyCow
	writetext Text_WeakMoo
	writebyte MILTANK
	special PlaySlowCry
	buttonsound
	writetext Text_ItsCryIsWeak
	checkevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	iftrue .GiveBerry
	waitbutton
	closetext
	end

.GiveBerry:
	buttonsound
	writetext Text_AskGiveBerry
	yesorno
	iffalse .Refused
	checkitem BERRY
	iffalse .NoBerriesInBag
	takeitem BERRY
	copybytetovar MooMooBerries
	addvar 1
	copyvartobyte MooMooBerries
	if_equal 3, .ThreeBerries
	if_equal 5, .FiveBerries
	if_equal 7, .SevenBerries
	writetext Text_GaveBerry
	waitbutton
	closetext
	end

.ThreeBerries:
	writetext Text_GaveBerry
	buttonsound
	writetext Text_LittleHealthier
	waitbutton
	closetext
	end

.FiveBerries:
	writetext Text_GaveBerry
	buttonsound
	writetext Text_QuiteHealthy
	waitbutton
	closetext
	end

.SevenBerries:
	playmusic MUSIC_HEAL
	writetext Text_GaveBerry
	pause 60
	buttonsound
	special RestartMapMusic
	writetext Text_TotallyHealthy
	waitbutton
	closetext
	setevent EVENT_HEALED_MOOMOO
	end

.NoBerriesInBag:
	writetext Text_NoBerries
	waitbutton
	closetext
	end

.Refused:
	writetext Text_RefusedToGiveBerry
	waitbutton
	closetext
	end

.HappyCow:
	writetext UnknownText_0x9cd92
	cry MILTANK
	waitbutton
	closetext
	end

Text_MoomooIsSick:
	text "Moomoo is sick…"

	para "She needs lots of"
	line "Oran Berries."
	done

Text_WereFeedingMoomoo:
	text "We're feeding"
	line "Moomoo!"
	done

Text_WeakMoo:
	text "Miltank: …Moo…"
	done

Text_ItsCryIsWeak:
	text "Its cry is weak…"
	done

UnknownText_0x9cd92:
	text "Miltank: Mooo!"
	done

Text_AskGiveBerry:
	text "Give an Oran Berry"
	line "to Miltank?"
	done

Text_GaveBerry:
	text "<PLAYER> gave an"
	line "Oran Berry to"
	cont "Miltank."
	done

Text_LittleHealthier:
	text "Miltank became a"
	line "little healthier!"
	done

Text_QuiteHealthy:
	text "Miltank became"
	line "quite healthy!"
	done

Text_TotallyHealthy:
	text "Miltank became"
	line "totally healthy!"
	done

Text_NoBerries:
	text "<PLAYER> has no"
	line "Oran Berries…"
	done

Text_RefusedToGiveBerry:
	text "<PLAYER> wouldn't"
	line "give an Oran"
	cont "Berry."

	para "Miltank looks sad."
	done

Route39Barn_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $3, 1, ROUTE_39
	warp_def $7, $4, 1, ROUTE_39

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_TWIN, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, TwinScript_0x9cc76, -1
	person_event SPRITE_TWIN, 3, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, TwinScript_0x9cc90, -1
	person_event SPRITE_MILTANK, 3, 3, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MooMoo, -1
