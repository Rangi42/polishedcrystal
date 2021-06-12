BurnedTower1F_MapScriptHeader:
	def_scene_scripts
	scene_script BurnedTower1FTrigger0

	def_callbacks
	callback MAPCALLBACK_TILES, BurnedTower1FHoleAndLadder

	def_warp_events
	warp_event  7, 15, ECRUTEAK_CITY, 13
	warp_event  8, 15, ECRUTEAK_CITY, 13
	warp_event  8,  9, BURNED_TOWER_B1F, 1
	warp_event  5, 15, BURNED_TOWER_B1F, 2

	def_coord_events
	coord_event  9,  9, 1, BurnedTowerRivalBattleScript

	def_bg_events
	bg_event  6,  7, BGEVENT_ITEM + ETHER, EVENT_BURNED_TOWER_1F_HIDDEN_ETHER
	bg_event 11, 11, BGEVENT_ITEM + ULTRA_BALL, EVENT_BURNED_TOWER_1F_HIDDEN_ULTRA_BALL

	def_object_events
	object_event 10, 12, SPRITE_EUSINE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BurnedTower1FEusineText, EVENT_BURNED_TOWER_1F_EUSINE
	object_event  6,  9, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_BURNED_TOWER
	smashrock_event 13, 4
	object_event 12, 14, SPRITE_MORTY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BurnedTower1FMortyText, EVENT_BURNED_TOWER_MORTY
	itemball_event 13,  1, HP_UP, 1, EVENT_BURNED_TOWER_1F_HP_UP
	object_event  1,  1, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerHexManiacTamara, -1
	object_event 11,  3, SPRITE_FIREBREATHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerFirebreatherNed, -1

	object_const_def
	const BURNEDTOWER1F_EUSINE
	const BURNEDTOWER1F_SILVER

BurnedTower1FTrigger0:
	sdefer BurnedTower1FEusineTriggerScript
	end

BurnedTower1FHoleAndLadder:
	checkevent EVENT_HOLE_IN_BURNED_TOWER
	iftrue .Next
	changeblock 8, 8, $32 ; hole
.Next:
	checkevent EVENT_RELEASED_THE_BEASTS
	iftrue .Done
	changeblock 4, 14, $9 ; ladder
.Done:
	endcallback

BurnedTower1FEusineTriggerScript:
	turnobject BURNEDTOWER1F_EUSINE, DOWN
	showemote EMOTE_SHOCK, BURNEDTOWER1F_EUSINE, 15
	applymovement BURNEDTOWER1F_EUSINE, BurnedTower1FEusineMovement
	showtext BurnedTower1FEusineIntroText
	moveobject BURNEDTOWER1F_EUSINE, 7, 14
	setscene $1
	end

BurnedTowerRivalBattleScript:
	showemote EMOTE_SHOCK, BURNEDTOWER1F_SILVER, 15
	special Special_FadeOutMusic
	pause 15
	turnobject BURNEDTOWER1F_SILVER, RIGHT
	pause 15
	applyonemovement PLAYER, step_left
	applyonemovement BURNEDTOWER1F_SILVER, step_right
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext BurnedTowerSilver_BeforeText
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .chikorita
	winlosstext BurnedTowerSilver_WinText, BurnedTowerSilver_LossText
	setlasttalked BURNEDTOWER1F_SILVER
	loadtrainer RIVAL1, RIVAL1_9
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.totodile
	winlosstext BurnedTowerSilver_WinText, BurnedTowerSilver_LossText
	setlasttalked BURNEDTOWER1F_SILVER
	loadtrainer RIVAL1, RIVAL1_7
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.chikorita
	winlosstext BurnedTowerSilver_WinText, BurnedTowerSilver_LossText
	setlasttalked BURNEDTOWER1F_SILVER
	loadtrainer RIVAL1, RIVAL1_8
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.returnfrombattle
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext BurnedTowerSilver_AfterText1
	setscene $2
	setevent EVENT_RIVAL_BURNED_TOWER
	special Special_FadeOutMusic
	pause 15
	earthquake 50
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_ENTER_DOOR
	waitsfx
	changeblock 8, 8, $25
	reloadmappart
	pause 15
	applyonemovement PLAYER, skyfall_top
	playsound SFX_KINESIS
	showemote EMOTE_SHOCK, BURNEDTOWER1F_SILVER, 20
	showtext BurnedTowerSilver_AfterText2
	setevent EVENT_HOLE_IN_BURNED_TOWER
	pause 15
	warpcheck
	end

GenericTrainerHexManiacTamara:
	generictrainer HEX_MANIAC, TAMARA, EVENT_BEAT_HEX_MANIAC_TAMARA, HexManiacTamaraSeenText, HexManiacTamaraBeatenText

	text "There are powers"
	line "beyond our under-"

	para "standing in the"
	line "world…"
	done

GenericTrainerFirebreatherNed:
	generictrainer FIREBREATHER, NED, EVENT_BEAT_FIREBREATHER_NED, FirebreatherNedSeenText, FirebreatherNedBeatenText

	text "We Firebreathers"
	line "know the true"

	para "power of fire"
	line "better than"
	cont "anyone!"
	done

BurnedTower1FEusineMovement:
	step_down
	step_left
	step_left
	step_left
	step_down
	step_end

BurnedTowerSilver_BeforeText:
	text "…… …… ……"

	para "…Oh, it's you."

	para "I came looking for"
	line "some legendary"

	para "#mon that they"
	line "say roosts here."

	para "But there's"
	line "nothing here!"

	para "Nothing after all"
	line "the trouble of"

	para "coming to this"
	line "dump? No way!"

	para "It's all your"
	line "fault!"
	done

BurnedTowerSilver_WinText:
	text "…Humph!"

	para "This is why I hate"
	line "battling wimps."

	para "There's no"
	line "challenge in it."
	done

BurnedTowerSilver_AfterText1:
	text "…Aw, whatever."

	para "You would never be"
	line "able to catch a"

	para "legendary #mon"
	line "anyway."
	done

BurnedTowerSilver_LossText:
	text "…Humph!"

	para "This is why I hate"
	line "battling wimps."

	para "It's just a waste"
	line "of my time."
	done

BurnedTowerSilver_AfterText2:
	text "Humph!"

	para "What are you doing"
	line "falling into a"

	para "hole? Some genius"
	line "you are!"

	para "Serves you right!"
	done

BurnedTower1FEusineIntroText:
	text "Eusine: My name's"
	line "Eusine."

	para "I'm on the trail"
	line "of a #mon named"
	cont "Suicune."

	para "And you are…?"

	para "<PLAYER>? Glad to"
	line "meet you!"

	para "I heard rumors"
	line "that Suicune is in"

	para "this Burned Tower,"
	line "so I came to look."

	para "But where exactly"
	line "could it be?"
	done

BurnedTower1FEusineText:
	text "Eusine: I heard"
	line "that Suicune is in"

	para "this Burned Tower,"
	line "so I came to look."

	para "But where exactly"
	line "could it be?"
	done

BurnedTower1FMortyText:
	text "Morty: Ecruteak's"
	line "Gym Leader has to"

	para "study what are"
	line "said to be the"

	para "legendary #mon"
	line "--Suicune, Entei"
	cont "and Raikou."

	para "Eusine is here, so"
	line "I've decided to"

	para "investigate the"
	line "Tower with him."
	done

HexManiacTamaraSeenText:
	text "A strange power is"
	line "present here…"
	done

HexManiacTamaraBeatenText:
	text "I have lost…"
	done

FirebreatherNedSeenText:
	text "My soul is on"
	line "fire. I'll show"

	para "you how hot it"
	line "burns!"
	done

FirebreatherNedBeatenText:
	text "Still not hot"
	line "enough…"
	done

