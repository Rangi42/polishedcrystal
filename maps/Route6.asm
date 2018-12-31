Route6_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route6_MapEventHeader:

.Warps: db 2
	warp_def 9, 21, 1, ROUTE_6_UNDERGROUND_ENTRANCE
	warp_def 1, 10, 3, ROUTE_6_SAFFRON_GATE

.XYTriggers: db 0

.Signposts: db 1
	signpost 11, 23, SIGNPOST_JUMPTEXT, Route6UndergroundPathSignText

.PersonEvents: db 8
	person_event SPRITE_POKEFAN_M, 10, 21, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1ad957, EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH
	person_event SPRITE_POKEFAN_M, 24, 13, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerPokefanmRex, -1
	person_event SPRITE_POKEFAN_M, 24, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerPokefanmAllan, -1
	person_event SPRITE_TWIN, 17, 16, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsDayanddani1, -1
	person_event SPRITE_TWIN, 17, 17, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerTwinsDayanddani2, -1
	person_event SPRITE_YOUNGSTER, 27, 20, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterChaz, -1
	person_event SPRITE_COOLTRAINER_F, 13, 12, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerGuitaristfWanda, -1
	person_event SPRITE_OFFICER_F, 19, 21, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 1, OfficerfJennyScript, -1

TrainerPokefanmRex:
	trainer EVENT_BEAT_POKEFANM_REX, POKEFANM, REX, PokefanmRexSeenText, PokefanmRexBeatenText, 0, PokefanmRexScript

PokefanmRexScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ad9ff

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

TrainerPokefanmAllan:
	trainer EVENT_BEAT_POKEFANM_ALLAN, POKEFANM, ALLAN, PokefanmAllanSeenText, PokefanmAllanBeatenText, 0, PokefanmAllanScript

PokefanmAllanScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ada88

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

TrainerTwinsDayanddani1:
	trainer EVENT_BEAT_TWINS_DAY_AND_DANI, TWINS, DAYANDDANI1, TwinsDayanddani1SeenText, TwinsDayanddani1BeatenText, 0, TrainerTwinsDayanddani1Script

TrainerTwinsDayanddani1Script:
	end_if_just_battled
	jumptextfaceplayer TwinsDayanddani1AfterText

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

TrainerTwinsDayanddani2:
	trainer EVENT_BEAT_TWINS_DAY_AND_DANI, TWINS, DAYANDDANI2, TwinsDayanddani2SeenText, TwinsDayanddani2BeatenText, 0, TrainerTwinsDayanddani2Script

TrainerTwinsDayanddani2Script:
	end_if_just_battled
	jumptextfaceplayer TwinsDayanddani2AfterText

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

TrainerYoungsterChaz:
	trainer EVENT_BEAT_YOUNGSTER_CHAZ, YOUNGSTER, CHAZ, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Do I see a strong"
	line "trainer?"

	para "Nope, there's only"
	line "trash here!"
	done

.BeatenText:
	text "The trash was me…"
	done

.AfterText:
	text "Me and my big"
	line "mouth…"
	done

TrainerGuitaristfWanda:
	trainer EVENT_BEAT_GUITARISTF_WANDA, GUITARISTF, WANDA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "You'd better"
	line "scatter and run!"
	done

.BeatenText:
	text "The battle's lost"
	line "and not won…"
	done

.AfterText:
	text "Just move along…"
	done

OfficerfJennyScript:
	checknite
	iffalse_jumptextfaceplayer .DaytimeText
	checkevent EVENT_BEAT_OFFICERF_JENNY
	iftrue .AfterScript
	faceplayer
	opentext
	special SaveMusic
	playmusic MUSIC_OFFICER_ENCOUNTER
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer OFFICERF, JENNY
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_OFFICERF_JENNY
	endtext

.AfterScript:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue_jumptextfaceplayer .AfterTextFemale
	jumptextfaceplayer .AfterTextMale

.DaytimeText:
	text "Us Officers are"
	line "here to keep the"
	cont "peace."
	done

.SeenText:
	text "You don't look"
	line "familiar."

	para "Squirtle Squad,"
	line "attack!"
	done

.BeatenText:
	text "Squirtle Squad,"
	line "retreat…"
	done

.AfterTextMale:
	text "Sorry to bother"
	line "you, sir."

	para "I get jumpy at"
	line "night."
	done

.AfterTextFemale:
	text "Sorry to bother"
	line "you, miss."

	para "I get jumpy at"
	line "night."
	done

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
