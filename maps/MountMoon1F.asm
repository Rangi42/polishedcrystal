MountMoon1F_MapScriptHeader:
	def_scene_scripts
	scene_script MountMoon1FRivalBattleScene, SCENE_MOUNTMOON1F_RIVAL_BATTLE
	scene_const SCENE_MOUNTMOON1F_NOOP

	def_callbacks

	def_warp_events
	warp_event 11, 23, ROUTE_3, 1
	warp_event 22, 12, MOUNT_MOON_B1F, 1
	warp_event 11,  9, MOUNT_MOON_B1F, 2
	warp_event  4,  4, MOUNT_MOON_B1F, 3

	def_coord_events

	def_bg_events
	bg_event  2, 17, BGEVENT_ITEM + RARE_CANDY, EVENT_MOUNT_MOON_1F_HIDDEN_RARE_CANDY
	bg_event 12, 16, BGEVENT_ITEM + FULL_RESTORE, EVENT_MOUNT_MOON_1F_HIDDEN_FULL_RESTORE

	def_object_events
	object_event 10, 19, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_RIVAL
	object_event  4, 18, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBugManiacKenta, -1
	object_event 11, 14, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerLassMiriam, -1
	object_event 20, 21, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSuperNerdJovan, -1
	object_event 27, 14, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBugManiacRobby, -1
	object_event 20,  2, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerLassIris, -1
	object_event  5,  5, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHikerMarcos, -1
	itemball_event  3,  2, REVIVE, 1, EVENT_MOUNT_MOON_1F_REVIVE
	itemball_event  2, 20, X_ACCURACY, 1, EVENT_MOUNT_MOON_1F_X_ACCURACY
	itemball_event 16, 22, CALCIUM, 1, EVENT_MOUNT_MOON_1F_CALCIUM

	object_const_def
	const MOUNTMOON1F_RIVAL

MountMoon1FRivalBattleScene:
	sdefer .RivalBattle
	end

.RivalBattle:
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	applymovement MOUNTMOON1F_RIVAL, MountMoon1FRivalMovementBefore
	turnobject PLAYER, LEFT
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext MountMoonRivalTextBefore
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftruefwd .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftruefwd .Chikorita
	winlosstext MountMoonRivalTextWin, MountMoonRivalTextLoss
	setlasttalked MOUNTMOON1F_RIVAL
	loadtrainer RIVAL2, 3
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjumpfwd .FinishBattle

.Totodile:
	winlosstext MountMoonRivalTextWin, MountMoonRivalTextLoss
	setlasttalked MOUNTMOON1F_RIVAL
	loadtrainer RIVAL2, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjumpfwd .FinishBattle

.Chikorita:
	winlosstext MountMoonRivalTextWin, MountMoonRivalTextLoss
	setlasttalked MOUNTMOON1F_RIVAL
	loadtrainer RIVAL2, 2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	; fallthrough

.FinishBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext MountMoonRivalTextAfter
	applymovement PLAYER, MountMoon1FPlayerMovement
	applymovement MOUNTMOON1F_RIVAL, MountMoon1FRivalMovementAfter
	disappear MOUNTMOON1F_RIVAL
	playsound SFX_EXIT_BUILDING
	waitsfx
	setscene SCENE_MOUNTMOON1F_NOOP
	setevent EVENT_BEAT_RIVAL_IN_MT_MOON
	playmapmusic
	end

GenericTrainerBugManiacKenta:
	generictrainer BUG_MANIAC, KENTA, EVENT_BEAT_BUG_MANIAC_KENTA, BugManiacKentaSeenText, BugManiacKentaBeatenText

	text "Team Rocket used"
	line "to lurk around"
	cont "here."

	para "I wonder if the"
	line "red-haired boy has"
	cont "any connection to"
	cont "them?"
	done

GenericTrainerLassMiriam:
	generictrainer LASS, MIRIAM, EVENT_BEAT_LASS_MIRIAM, LassMiriamSeenText, LassMiriamBeatenText

	text "Mt.Moon is big,"
	line "but you'll get"
	cont "used to it soon."
	done

GenericTrainerSuperNerdJovan:
	generictrainer SUPER_NERD, JOVAN, EVENT_BEAT_SUPER_NERD_JOVAN, SuperNerdJovanSeenText, SuperNerdJovanBeatenText

	text "I have yet to find"
	line "stronger #mon."

	para "Where might they"
	line "be?"
	done

GenericTrainerBugManiacRobby:
	generictrainer BUG_MANIAC, ROBBY, EVENT_BEAT_BUG_MANIAC_ROBBY, BugManiacRobbySeenText, BugManiacRobbyBeatenText

	text "I used to only"
	line "catch bug #mon"
	cont "as a hobby,"

	para "but now it's my"
	line "pride and joy."
	done

GenericTrainerLassIris:
	generictrainer LASS, IRIS, EVENT_BEAT_LASS_IRIS, LassIrisSeenText, LassIrisBeatenText

	text "I come here every"
	line "day just to catch"
	cont "a Clefairy, but"

	para "I haven't seen a"
	line "single one…"
	done

GenericTrainerHikerMarcos:
	generictrainer HIKER, MARCOS, EVENT_BEAT_HIKER_MARCOS, HikerMarcosSeenText, HikerMarcosBeatenText

	text "A long time ago,"
	line "I was beaten by a"
	cont "kid just like you."
	done

MountMoon1FRivalMovementBefore:
	step_down
	step_down
	step_down
	step_down
	turn_head_right
	step_end

MountMoon1FPlayerMovement:
	slow_step_up
	turn_head_down
	step_end

MountMoon1FRivalMovementAfter:
	step_right
	turn_head_down
	step_end

MountMoonRivalTextBefore:
	text "…… …… ……"

	para "It's been a while,"
	line "<PLAYER>."

	para "…Since I lost to"
	line "you, I thought"

	para "about what I was"
	line "lacking with my"
	cont "#mon…"

	para "And we came up"
	line "with an answer."

	para "<PLAYER>, now we'll"
	line "show you!"
	done

MountMoonRivalTextWin:
	text "…… …… ……"

	para "I thought I raised"
	line "my #mon to be"

	para "the best they"
	line "could be…"

	para "…But it still"
	line "wasn't enough…"
	done

MountMoonRivalTextAfter:
	text "…… …… ……"

	para "…You won, fair"
	line "and square."

	para "I admit it. But"
	line "this isn't the"
	cont "end."

	para "After some more"
	line "training in"
	cont "Dragon's Den…"

	para "I'm going to be"
	line "the greatest #-"
	cont "mon trainer ever."

	para "Because these guys"
	line "are behind me."

	para "…Listen, <PLAYER>."

	para "One of these days"
	line "I'm going to prove"

	para "how good I am by"
	line "beating you."
	done

MountMoonRivalTextLoss:
	text "…… …… ……"

	para "I've repaid my"
	line "debt to you."

	para "With my #mon,"
	line "I'm going to beat"

	para "the Champion and"
	line "become the world's"
	cont "greatest trainer."
	done

BugManiacKentaSeenText:
	text "I saw a red-haired"
	line "boy training here."

	para "Have you battled"
	line "him?"
	done

BugManiacKentaBeatenText:
	text "You got me!"
	done

LassMiriamSeenText:
	text "When I was young-"
	line "er, I always used"

	para "to get lost in"
	line "this place."
	done

LassMiriamBeatenText:
	text "Oh! I lost it!"
	done

SuperNerdJovanSeenText:
	text "What! Don't sneak"
	line "up on me!"
	done

SuperNerdJovanBeatenText:
	text "My #mon"
	line "won't do!"
	done

BugManiacRobbySeenText:
	text "You need to go"
	line "through this cave"

	para "to get to Cerulean"
	line "City."
	done

BugManiacRobbyBeatenText:
	text "I lost…"
	done

LassIrisSeenText:
	text "Have you seen a"
	line "Clefairy?"

	para "They're so cute!"
	done

LassIrisBeatenText:
	text "That was so fast…"
	done

HikerMarcosSeenText:
	text "Kids like you"
	line "shouldn't be"

	para "wandering around"
	line "here in the dark."
	done

HikerMarcosBeatenText:
	text "Woah!"
	line "You're strong!"
	done

