const_value set 2
	const VICTORYROAD3F_VETERAN_M
	const VICTORYROAD3F_LAWRENCE
	const VICTORYROAD3F_POKE_BALL

VictoryRoad3F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

VictoryRoad3FLawrenceScript:
	special Special_FadeOutMusic
	pause 15
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	faceplayer
	opentext
	writetext LawrenceSeenText
	waitbutton
	closetext
	winlosstext LawrenceBeatenText, 0
	setlasttalked VICTORYROAD3F_LAWRENCE
	loadtrainer LAWRENCE, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special DeleteSavedMusic
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	opentext
	writetext LawrenceAfterText
	buttonsound
	verbosegiveitem SILVER_WING
	writetext LawrenceSilverWingText
	waitbutton
	closetext
	checkcode VAR_FACING
	if_equal UP, .up
	if_equal DOWN, .down
	if_equal LEFT, .left
.right
	spriteface VICTORYROAD3F_LAWRENCE, RIGHT
	jump .continue
.up
	spriteface VICTORYROAD3F_LAWRENCE, UP
	jump .continue
.down
	spriteface VICTORYROAD3F_LAWRENCE, DOWN
	jump .continue
.left
	spriteface VICTORYROAD3F_LAWRENCE, LEFT
.continue
	pause 40
	faceplayer
	opentext
	writetext LawrenceGoodbyeText
	waitbutton
	closetext
	spriteface VICTORYROAD3F_LAWRENCE, UP
	opentext
	writetext VictoryRoadLawrenceEscapeRopeText
	pause 15
	closetext
	playsound SFX_WARP_TO
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear VICTORYROAD3F_LAWRENCE
	waitsfx
	special Special_FadeInQuickly
	setevent EVENT_BEAT_LAWRENCE
	playmapmusic
	end

TrainerVeteranmRemy:
	trainer EVENT_BEAT_VETERANM_REMY, VETERANM, REMY, VeteranmRemySeenText, VeteranmRemyBeatenText, 0, VeteranmRemyScript

VeteranmRemyScript:
	end_if_just_battled
	opentext
	writetext VeteranmRemyAfterText
	waitbutton
	closetext
	end

VictoryRoad3FRazorFang:
	itemball RAZOR_FANG

LawrenceSeenText:
	text "Lawrence: I sought"
	line "across many"

	para "regions to catch"
	line "Articuno, Zapdos,"
	cont "and Moltres."

	para "Without the"
	line "complete set, I"

	para "cannot awaken the"
	line "guardian of the"
	cont "sea…"

	para "You're going to"
	line "help me complete"
	cont "my collection!"
	done

LawrenceBeatenText:
	text "Unbelievable."
	line "You beat my legen-"
	cont "dary collection…"
	done

LawrenceAfterText:
	text "Lawrence: Your"
	line "#mon aren't"

	para "just a collection"
	line "to you, are they?"

	para "You treat them"
	line "almost like"
	cont "friends."

	para "Could that be how"
	line "you defeated my"
	cont "legendary #mon?"

	para "Well, I think you"
	line "earned this."
	done

LawrenceSilverWingText:
	text "That Silver Wing"
	line "feather comes from"

	para "the guardian of"
	line "the sea."

	para "The scent should"
	line "attract it, but"

	para "only if you've"
	line "mastered the three"

	para "winged mirages--"
	line "the birds of fire,"

	para "ice, and light-"
	line "ning."

	para "Or so the legends"
	line "say."
	done

LawrenceGoodbyeText:
	text "My dream was to"
	line "own that Pokemon,"

	para "but you've proven"
	line "yourself worthy."
	cont "Take it."

	para "I'll begin my"
	line "collection anew."

	para "Farewell."
	done

VictoryRoadLawrenceEscapeRopeText:
	text "Lawrence used an"
	line "Escape Rope!"
	done

VeteranmRemySeenText:
	text "If you can get"
	line "through here, you"

	para "can challenge the"
	line "Elite Four!"
	done

VeteranmRemyBeatenText:
	text "No!"
	line "Inconceivable!"
	done

VeteranmRemyAfterText:
	text "I can beat you"
	line "when it comes to"

	para "knowledge about"
	line "#mon!"
	done

VictoryRoad3F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $5, $2, 3, VICTORY_ROAD_2F
	warp_def $b, $f, 4, VICTORY_ROAD_2F
	warp_def $d, $13, 5, VICTORY_ROAD_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_VETERAN_M, 8, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerVeteranmRemy, -1
	person_event SPRITE_LAWRENCE, 9, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, VictoryRoad3FLawrenceScript, EVENT_LAWRENCE_VICTORY_ROAD
	person_event SPRITE_BALL_CUT_FRUIT, 13, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, VictoryRoad3FRazorFang, EVENT_VICTORY_ROAD_3F_RAZOR_FANG
