BurnedTower1F_MapScriptHeader:

.MapTriggers: db 1
	dw BurnedTower1FTrigger0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, BurnedTower1FHoleAndLadder

BurnedTower1F_MapEventHeader:

.Warps: db 14
	warp_def $f, $7, 13, ECRUTEAK_CITY
	warp_def $f, $8, 13, ECRUTEAK_CITY
	warp_def $9, $8,  1, BURNED_TOWER_B1F
	warp_def $5, $3,  1, BURNED_TOWER_B1F
	warp_def $6, $3,  1, BURNED_TOWER_B1F
	warp_def $6, $2,  1, BURNED_TOWER_B1F
	warp_def $4, $d,  2, BURNED_TOWER_B1F
	warp_def $5, $d,  2, BURNED_TOWER_B1F
	warp_def $7, $8,  3, BURNED_TOWER_B1F
	warp_def $e, $3,  4, BURNED_TOWER_B1F
	warp_def $e, $2,  4, BURNED_TOWER_B1F
	warp_def $e, $c,  5, BURNED_TOWER_B1F
	warp_def $e, $d,  5, BURNED_TOWER_B1F
	warp_def $f, $5,  6, BURNED_TOWER_B1F

.XYTriggers: db 1
	xy_trigger 1, $9, $9, BurnedTowerRivalBattleScript

.Signposts: db 2
	signpost  7,  6, SIGNPOST_ITEM, BurnedTower1FHiddenEther
	signpost 11, 11, SIGNPOST_ITEM, BurnedTower1FHiddenUltraBall

.PersonEvents: db 7
	person_event SPRITE_SUPER_NERD, 12, 10, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, BurnedTower1FEusineText, EVENT_BURNED_TOWER_1F_EUSINE
	person_event SPRITE_SILVER, 9, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, ObjectEvent, EVENT_RIVAL_BURNED_TOWER
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 4, 13, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, smashrock, 0, -1
	person_event SPRITE_MORTY, 14, 12, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, BurnedTower1FMortyText, EVENT_BURNED_TOWER_MORTY
	person_event SPRITE_BALL_CUT_FRUIT, 1, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, HP_UP, 1, EVENT_BURNED_TOWER_1F_HP_UP
	person_event SPRITE_HEX_MANIAC, 1, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerHexManiacTamara, -1
	person_event SPRITE_FISHER, 3, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerFirebreatherNed, -1

const_value set 2
	const BURNEDTOWER1F_EUSINE
	const BURNEDTOWER1F_SILVER

BurnedTower1FTrigger0:
	priorityjump BurnedTower1FEusineTriggerScript
	end

BurnedTower1FHoleAndLadder:
	checkevent EVENT_HOLE_IN_BURNED_TOWER
	iftrue .Next
	changeblock $8, $8, $32 ; hole
.Next:
	checkevent EVENT_RELEASED_THE_BEASTS
	iftrue .Done
	changeblock $4, $e, $9 ; ladder
.Done:
	return

BurnedTower1FEusineTriggerScript:
	spriteface BURNEDTOWER1F_EUSINE, DOWN
	showemote EMOTE_SHOCK, BURNEDTOWER1F_EUSINE, 15
	applymovement BURNEDTOWER1F_EUSINE, BurnedTower1FEusineMovement
	showtext BurnedTower1FEusineIntroText
	moveperson BURNEDTOWER1F_EUSINE, $7, $e
	dotrigger $1
	end

BurnedTowerRivalBattleScript:
	showemote EMOTE_SHOCK, BURNEDTOWER1F_SILVER, 15
	special Special_FadeOutMusic
	pause 15
	spriteface BURNEDTOWER1F_SILVER, RIGHT
	pause 15
	applymovement PLAYER, BurnedTowerMovement_PlayerWalksToSilver
	applymovement BURNEDTOWER1F_SILVER, BurnedTowerMovement_SilverWalksToPlayer
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
	jump .returnfrombattle

.totodile
	winlosstext BurnedTowerSilver_WinText, BurnedTowerSilver_LossText
	setlasttalked BURNEDTOWER1F_SILVER
	loadtrainer RIVAL1, RIVAL1_7
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .returnfrombattle

.chikorita
	winlosstext BurnedTowerSilver_WinText, BurnedTowerSilver_LossText
	setlasttalked BURNEDTOWER1F_SILVER
	loadtrainer RIVAL1, RIVAL1_8
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .returnfrombattle

.returnfrombattle
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext BurnedTowerSilver_AfterText1
	dotrigger $2
	setevent EVENT_RIVAL_BURNED_TOWER
	special Special_FadeOutMusic
	pause 15
	earthquake 50
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_ENTER_DOOR
	waitsfx
	changeblock $8, $8, $25
	reloadmappart
	pause 15
	applymovement PLAYER, BurnedTower1FMovement_PlayerStartsToFall
	playsound SFX_KINESIS
	showemote EMOTE_SHOCK, BURNEDTOWER1F_SILVER, 20
	showtext BurnedTowerSilver_AfterText2
	setevent EVENT_HOLE_IN_BURNED_TOWER
	pause 15
	warpcheck
	end

TrainerHexManiacTamara:
	trainer EVENT_BEAT_HEX_MANIAC_TAMARA, HEX_MANIAC, TAMARA, HexManiacTamaraSeenText, HexManiacTamaraBeatenText, 0, HexManiacTamaraScript

HexManiacTamaraScript:
	end_if_just_battled
	jumptextfaceplayer HexManiacTamaraAfterText

TrainerFirebreatherNed:
	trainer EVENT_BEAT_FIREBREATHER_NED, FIREBREATHER, NED, FirebreatherNedSeenText, FirebreatherNedBeatenText, 0, FirebreatherNedScript

FirebreatherNedScript:
	end_if_just_battled
	jumptextfaceplayer FirebreatherNedAfterText

BurnedTower1FHiddenEther:
	dwb EVENT_BURNED_TOWER_1F_HIDDEN_ETHER, ETHER

BurnedTower1FHiddenUltraBall:
	dwb EVENT_BURNED_TOWER_1F_HIDDEN_ULTRA_BALL, ULTRA_BALL

BurnedTowerMovement_PlayerWalksToSilver:
	step_left
	step_end

BurnedTowerMovement_SilverWalksToPlayer:
	step_right
	step_end

BurnedTower1FMovement_PlayerStartsToFall:
	skyfall_top
	step_end

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

HexManiacTamaraAfterText:
	text "There are powers"
	line "beyond our under-"

	para "standing in the"
	line "world…"
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

FirebreatherNedAfterText:
	text "We Firebreathers"
	line "know the true"

	para "power of fire"
	line "better than"
	cont "anyone!"
	done
