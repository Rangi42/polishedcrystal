MountMoon1F_MapScriptHeader:

.MapTriggers: db 1
	dw MountMoon1FTrigger0

.MapCallbacks: db 0

MountMoon1F_MapEventHeader:

.Warps: db 4
	warp_def 23, 11, 1, ROUTE_3
	warp_def 12, 22, 1, MOUNT_MOON_B1F
	warp_def 9, 11, 2, MOUNT_MOON_B1F
	warp_def 4, 4, 3, MOUNT_MOON_B1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 17, 2, SIGNPOST_ITEM + RARE_CANDY, EVENT_MOUNT_MOON_1F_HIDDEN_RARE_CANDY
	signpost 16, 12, SIGNPOST_ITEM + FULL_RESTORE, EVENT_MOUNT_MOON_1F_HIDDEN_FULL_RESTORE

.PersonEvents: db 10
	person_event SPRITE_SILVER, 19, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_RIVAL
	person_event SPRITE_BUG_MANIAC, 18, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerBugManiacKenta, -1
	person_event SPRITE_LASS, 14, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerLassMiriam, -1
	person_event SPRITE_SUPER_NERD, 21, 20, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerSuperNerdJovan, -1
	person_event SPRITE_BUG_MANIAC, 14, 27, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerBugManiacRobby, -1
	person_event SPRITE_LASS, 2, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerLassIris, -1
	person_event SPRITE_POKEFAN_M, 5, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerMarcos, -1
	itemball_event 2, 3, REVIVE, 1, EVENT_MOUNT_MOON_1F_REVIVE
	itemball_event 20, 2, X_ACCURACY, 1, EVENT_MOUNT_MOON_1F_X_ACCURACY
	itemball_event 22, 16, CALCIUM, 1, EVENT_MOUNT_MOON_1F_CALCIUM

const_value set 1
	const MOUNTMOON1F_SILVER

MountMoon1FTrigger0:
	priorityjump .RivalBattle
	end

.RivalBattle:
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	applymovement MOUNTMOON1F_SILVER, MountMoon1FSilverMovementBefore
	spriteface PLAYER, LEFT
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext MountMoonSilverTextBefore
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext MountMoonSilverTextWin, MountMoonSilverTextLoss
	setlasttalked MOUNTMOON1F_SILVER
	loadtrainer RIVAL2, 3
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .FinishBattle

.Totodile:
	winlosstext MountMoonSilverTextWin, MountMoonSilverTextLoss
	setlasttalked MOUNTMOON1F_SILVER
	loadtrainer RIVAL2, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .FinishBattle

.Chikorita:
	winlosstext MountMoonSilverTextWin, MountMoonSilverTextLoss
	setlasttalked MOUNTMOON1F_SILVER
	loadtrainer RIVAL2, 2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .FinishBattle

.FinishBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext MountMoonSilverTextAfter
	applymovement PLAYER, MountMoon1FPlayerMovement
	applymovement MOUNTMOON1F_SILVER, MountMoon1FSilverMovementAfter
	disappear MOUNTMOON1F_SILVER
	playsound SFX_EXIT_BUILDING
	waitsfx
	dotrigger $1
	setevent EVENT_BEAT_RIVAL_IN_MT_MOON
	playmapmusic
	end

TrainerBugManiacKenta:
	trainer EVENT_BEAT_BUG_MANIAC_KENTA, BUG_MANIAC, KENTA, BugManiacKentaSeenText, BugManiacKentaBeatenText, 0, BugManiacKentaScript

BugManiacKentaScript:
	end_if_just_battled
	jumptextfaceplayer BugManiacKentaAfterText

TrainerLassMiriam:
	trainer EVENT_BEAT_LASS_MIRIAM, LASS, MIRIAM, LassMiriamSeenText, LassMiriamBeatenText, 0, LassMiriamScript

LassMiriamScript:
	end_if_just_battled
	jumptextfaceplayer LassMiriamAfterText

TrainerSuperNerdJovan:
	trainer EVENT_BEAT_SUPER_NERD_JOVAN, SUPER_NERD, JOVAN, SuperNerdJovanSeenText, SuperNerdJovanBeatenText, 0, SuperNerdJovanScript

SuperNerdJovanScript:
	end_if_just_battled
	jumptextfaceplayer SuperNerdJovanAfterText

TrainerBugManiacRobby:
	trainer EVENT_BEAT_BUG_MANIAC_ROBBY, BUG_MANIAC, ROBBY, BugManiacRobbySeenText, BugManiacRobbyBeatenText, 0, BugManiacRobbyScript

BugManiacRobbyScript:
	end_if_just_battled
	jumptextfaceplayer BugManiacRobbyAfterText

TrainerLassIris:
	trainer EVENT_BEAT_LASS_IRIS, LASS, IRIS, LassIrisSeenText, LassIrisBeatenText, 0, LassIrisScript

LassIrisScript:
	end_if_just_battled
	jumptextfaceplayer LassIrisAfterText

TrainerHikerMarcos:
	trainer EVENT_BEAT_HIKER_MARCOS, HIKER, MARCOS, HikerMarcosSeenText, HikerMarcosBeatenText, 0, HikerMarcosScript

HikerMarcosScript:
	end_if_just_battled
	jumptextfaceplayer HikerMarcosAfterText

MountMoon1FSilverMovementBefore:
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

MountMoon1FSilverMovementAfter:
	step_right
	turn_head_down
	step_end

MountMoonSilverTextBefore:
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

MountMoonSilverTextWin:
	text "…… …… ……"

	para "I thought I raised"
	line "my #mon to be"

	para "the best they"
	line "could be…"

	para "…But it still"
	line "wasn't enough…"
	done

MountMoonSilverTextAfter:
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

MountMoonSilverTextLoss:
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

BugManiacKentaAfterText:
	text "Team Rocket used"
	line "to lurk around"
	cont "here."

	para "I wonder if the"
	line "red-haired boy has"
	cont "any connection to"
	cont "them?"
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

LassMiriamAfterText:
	text "Mt.Moon is big,"
	line "but you'll get"
	cont "used to it soon."
	done

SuperNerdJovanSeenText:
	text "What! Don't sneak"
	line "up on me!"
	done

SuperNerdJovanBeatenText:
	text "My #mon"
	line "won't do!"
	done

SuperNerdJovanAfterText:
	text "I have yet to find"
	line "stronger #mon."

	para "Where might they"
	line "be?"
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

BugManiacRobbyAfterText:
	text "I used to only"
	line "catch bug #mon"
	cont "as a hobby,"

	para "but now it's my"
	line "pride and joy."
	done

LassIrisSeenText:
	text "Have you seen a"
	line "Clefairy?"

	para "They're so cute!"
	done

LassIrisBeatenText:
	text "That was so fast…"
	done

LassIrisAfterText:
	text "I come here every"
	line "day just to catch"
	cont "a Clefairy, but"

	para "I haven't seen a"
	line "single one…"
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

HikerMarcosAfterText:
	text "A long time ago,"
	line "I was beaten by a"
	cont "kid just like you."
	done
