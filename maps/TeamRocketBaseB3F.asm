TeamRocketBaseB3F_MapScriptHeader:
	def_scene_scripts
	scene_script TeamRocketBaseB3FTrigger0

	def_callbacks
	callback MAPCALLBACK_TILES, TeamRocketBaseB3FCheckGiovanniDoor

	def_warp_events
	warp_event  3,  2, TEAM_ROCKET_BASE_B2F, 2
	warp_event 27,  2, TEAM_ROCKET_BASE_B2F, 3
	warp_event  3,  6, TEAM_ROCKET_BASE_B2F, 4
	warp_event 27, 14, TEAM_ROCKET_BASE_B2F, 5

	def_coord_events
	coord_event 10,  8, 2, RocketBaseBossLeft
	coord_event 11,  8, 2, RocketBaseBossRight
	coord_event  8, 10, 1, RocketBaseRival

	def_bg_events
	bg_event 10,  9, BGEVENT_IFNOTSET, BossDoor
	bg_event 11,  9, BGEVENT_IFNOTSET, BossDoor
	bg_event 10,  1, BGEVENT_JUMPSTD, teamrocketoath
	bg_event 11,  1, BGEVENT_JUMPSTD, teamrocketoath
	bg_event 12,  1, BGEVENT_JUMPSTD, teamrocketoath
	bg_event 13,  1, BGEVENT_JUMPSTD, teamrocketoath
	bg_event  4, 13, BGEVENT_JUMPSTD, teamrocketoath
	bg_event  5, 13, BGEVENT_JUMPSTD, teamrocketoath
	bg_event  6, 13, BGEVENT_JUMPSTD, teamrocketoath
	bg_event  7, 13, BGEVENT_JUMPSTD, teamrocketoath

	def_object_events
	object_event 25, 14, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LanceGetPasswordScript, EVENT_TEAM_ROCKET_BASE_B3F_LANCE_PASSWORDS
	object_event  8,  3, SPRITE_PETREL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B3F_PETREL
	object_event  7,  2, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, MURKROW, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RocketBaseMurkrow, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  4,  5, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_TEAM_ROCKET_BASE
	object_event 21,  7, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, SlowpokeTailGrunt, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  5, 14, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, RaticateTailGrunt, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 23, 11, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 0, GenericTrainerRocketScientistRoss, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 11, 15, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerRocketScientistMitch, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 24, 14, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, TeamRocketBaseB3FRocketText, EVENT_TEAM_ROCKET_BASE_POPULATION
	itemball_event  1, 12, PROTEIN, 1, EVENT_TEAM_ROCKET_BASE_B3F_PROTEIN
	itemball_event  3, 12, X_SPCL_DEF, 1, EVENT_TEAM_ROCKET_BASE_B3F_X_SPCL_DEF
	itemball_event 28,  9, FULL_HEAL, 1, EVENT_TEAM_ROCKET_BASE_B3F_FULL_HEAL
	itemball_event 17,  2, ICE_HEAL, 1, EVENT_TEAM_ROCKET_BASE_B3F_ICE_HEAL
	itemball_event 14, 10, ULTRA_BALL, 1, EVENT_TEAM_ROCKET_BASE_B3F_ULTRA_BALL

	object_const_def
	const TEAMROCKETBASEB3F_LANCE
	const TEAMROCKETBASEB3F_PETREL
	const TEAMROCKETBASEB3F_MURKROW
	const TEAMROCKETBASEB3F_SILVER

TeamRocketBaseB3FTrigger0:
	sdefer LanceGetPasswordScript
	end

TeamRocketBaseB3FCheckGiovanniDoor:
	checkevent EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	iftrue .OpenSesame
	endcallback

.OpenSesame:
	changeblock 10, 8, $7
	endcallback

LanceGetPasswordScript:
	turnobject PLAYER, LEFT
	pause 5
	turnobject TEAMROCKETBASEB3F_MURKROW, RIGHT
	pause 20
	applyonemovement TEAMROCKETBASEB3F_LANCE, step_right
	showtext LanceGetPasswordText
	applymovement TEAMROCKETBASEB3F_LANCE, RocketBaseLanceLeavesMovement
	disappear TEAMROCKETBASEB3F_LANCE
	setscene $1
	end

RocketBaseRival:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	appear TEAMROCKETBASEB3F_SILVER
	applymovement TEAMROCKETBASEB3F_SILVER, RocketBaseRivalEnterMovement
	turnobject PLAYER, LEFT
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext RocketBaseRivalText
	playsound SFX_TACKLE
	applymovement PLAYER, RocketBaseRivalShovesPlayerMovement
	applymovement TEAMROCKETBASEB3F_SILVER, RocketBaseRivalLeaveMovement
	disappear TEAMROCKETBASEB3F_SILVER
	setscene $2
	special RestartMapMusic
	end

RocketBaseBossLeft:
	applymovement PLAYER, RocketBasePlayerApproachesBossLeftMovement
	sjump RocketBaseBoss

RocketBaseBossRight:
	applymovement PLAYER, RocketBasePlayerApproachesBossRightMovement
RocketBaseBoss:
	pause 30
	showemote EMOTE_SHOCK, TEAMROCKETBASEB3F_PETREL, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject TEAMROCKETBASEB3F_PETREL, DOWN
	showtext ExecutiveM4BeforeText
	applyonemovement TEAMROCKETBASEB3F_PETREL, step_down
	winlosstext ExecutiveM4BeatenText, 0
	setlasttalked TEAMROCKETBASEB3F_PETREL
	loadtrainer PETREL, PETREL2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_PETREL_2
	showtext ExecutiveM4AfterText
	applymovement TEAMROCKETBASEB3F_PETREL, RocketBaseBossHitsTableMovement
	playsound SFX_TACKLE
	applymovement TEAMROCKETBASEB3F_PETREL, RocketBaseBossLeavesMovement
	disappear TEAMROCKETBASEB3F_PETREL
	setscene $3
	end

RocketBaseMurkrow:
	showtext RocketBaseMurkrowText
	setevent EVENT_LEARNED_HAIL_GIOVANNI
	end

SlowpokeTailGrunt:
	trainer GRUNTF, 5, EVENT_BEAT_ROCKET_GRUNTF_5, GruntF5SeenText, GruntF5BeatenText, 0, GruntF5Script

GruntF5Script:
	endifjustbattled
	showtext GruntF5AfterBattleText
	setevent EVENT_LEARNED_SLOWPOKETAIL
	end

RaticateTailGrunt:
	trainer GRUNTM, 28, EVENT_BEAT_ROCKET_GRUNTM_28, GruntM28SeenText, GruntM28BeatenText, 0, GruntM28Script

GruntM28Script:
	endifjustbattled
	showtext GruntM28AfterBattleText
	setevent EVENT_LEARNED_RATICATE_TAIL
	end

GenericTrainerRocketScientistRoss:
	generictrainer ROCKET_SCIENTIST, ROSS, EVENT_BEAT_ROCKET_SCIENTIST_ROSS, RocketScientistRossSeenText, RocketScientistRossBeatenText

	text "A radio signal"
	line "that drives #-"
	cont "mon mad…"

	para "My experiment is a"
	line "complete success."

	para "My promotion is"
	line "assured. This loss"

	para "means absolutely"
	line "nothing."
	done

GenericTrainerRocketScientistMitch:
	generictrainer ROCKET_SCIENTIST, MITCH, EVENT_BEAT_ROCKET_SCIENTIST_MITCH, RocketScientistMitchSeenText, RocketScientistMitchBeatenText

	text "If we turn up the"
	line "power of our radio"

	para "signal for broad-"
	line "cast nationwide…"

	para "The very thought"
	line "excites me!"
	done

BossDoor:
	dw EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	opentext
	checkevent EVENT_LEARNED_SLOWPOKETAIL
	iffalse .NeedsPassword
	checkevent EVENT_LEARNED_RATICATE_TAIL
	iffalse .NeedsPassword
	sjump .OpenSesame

.NeedsPassword:
	jumpopenedtext TeamRocketBaseB3FLockedDoorNeedsPasswordText

.OpenSesame:
	writetext TeamRocketBaseB3FLockedDoorOpenSesameText
	waitbutton
	playsound SFX_ENTER_DOOR
	changeblock 10, 8, $7
	reloadmappart
	closetext
	setevent EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	waitsfx
	end

RocketBaseLanceLeavesMovement:
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

RocketBasePlayerApproachesBossLeftMovement:
	step_up
	step_up
	step_up
	step_left
	step_left
	turn_head_up
	step_end

RocketBasePlayerApproachesBossRightMovement:
	step_up
	step_up
	step_left
	step_up
	step_left
	step_left
	turn_head_up
	step_end

RocketBaseBossHitsTableMovement:
	run_step_right
	run_step_right
	step_end

RocketBaseBossLeavesMovement:
	fix_facing
	fast_jump_step_left
	remove_fixed_facing
	step_sleep_8
	step_sleep_8
	slow_step_right
	run_step_down
	run_step_down
	run_step_down
	run_step_right
	run_step_down
	run_step_down
	run_step_down
	run_step_left
	run_step_left
	run_step_left
	run_step_left
	run_step_left
	run_step_up
	run_step_up
	run_step_up
	run_step_up
	run_step_up
	run_step_up
	run_step_up
	run_step_up
	run_step_left
	run_step_left
	step_end

RocketBaseRivalEnterMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_right
	step_right
	step_right
	step_end

RocketBaseRivalLeaveMovement:
	step_left
	step_left
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

RocketBaseRivalShovesPlayerMovement:
	fix_facing
	run_step_right
	remove_fixed_facing
	step_end

LanceGetPasswordText:
	text "Lance: It takes"
	line "two passwords to"

	para "get into the"
	line "boss's quarters."

	para "Those passwords"
	line "are known only to"
	cont "a few Rockets."

	para "That Rocket there"
	line "very graciously"
	cont "told me so."

	para "<PLAYER>, let's go"
	line "get the passwords."
	done

TeamRocketBaseB3FRocketText:
	text "Urrggh… The guy"
	line "in the cape is"
	cont "incredibly tough…"
	done

RocketBaseRivalText:
	text "…"

	para "Didn't I tell you"
	line "that I was going"

	para "to destroy Team"
	line "Rocket?"

	para "…Tell me, who was"
	line "the guy in the"

	para "cape who used"
	line "dragon #mon?"

	para "My #mon were no"
	line "match at all."

	para "I don't care that"
	line "I lost. I can beat"

	para "him by getting"
	line "stronger #mon."

	para "It's what he said"
	line "that bothers me…"

	para "He told me that"
	line "I don't love and"

	para "trust my #mon"
	line "enough."

	para "I'm furious that I"
	line "lost to a bleeding"
	cont "heart like him."

	para "…Humph! I don't"
	line "have the time for"
	cont "the likes of you!"
	done

ExecutiveM4BeforeText:
	text "What? Who are you?"
	line "This is the office"

	para "of our leader,"
	line "Giovanni."

	para "Since disbanding"
	line "Team Rocket three"

	para "years ago, he has"
	line "been in training."

	para "But we're certain"
	line "he will be back"

	para "some day to assume"
	line "command again."

	para "That's why we're"
	line "standing guard."

	para "I won't let any-"
	line "one disturb this"
	cont "place!"
	done

ExecutiveM4BeatenText:
	text "I… I couldn't do a"
	line "thing…"

	para "Giovanni, please"
	line "forgive me…"
	done

ExecutiveM4AfterText:
	text "No, I can't let"
	line "this affect me."

	para "I have to inform"
	line "the others…"
	done

RocketBaseMurkrowText:
	text "Murkrow: The"
	line "password is…"

	para "Hail Giovanni."
	done

GruntF5SeenText:
	text "Do I know the"
	line "password?"

	para "Maybe."

	para "But no weakling's"
	line "going to get it!"
	done

GruntF5BeatenText:
	text "All right. Stop."
	line "I'll tell you."
	done

GruntF5AfterBattleText:
	text "The password to"
	line "the boss's room is"

	para "SlowpokeTail."

	para "But it's useless"
	line "unless you have"
	cont "two passwords."
	done

GruntM28SeenText:
	text "Hyuck-hyuck-hyuck!"

	para "You're challenging"
	line "me to a battle?"

	para "Hah! You're nuts,"
	line "but you have guts!"

	para "I like that!"

	para "If you can beat"
	line "me, I'll tell you"

	para "a password to the"
	line "boss's room!"
	done

GruntM28BeatenText:
	text "Hyuck-hyuck-hyuck!"
	line "You're good!"
	done

GruntM28AfterBattleText:
	text "Hyuck-hyuck-hyuck!"

	para "The password to"
	line "the boss's room…"

	para "Uh…, I think it is"
	line "Raticate Tail."
	done

RocketScientistRossSeenText:
	text "I used to work for"
	line "Silph, but now I"

	para "run research for"
	line "Team Rocket."

	para "A meddlesome child"
	line "like you needs to"
	cont "be punished."
	done

RocketScientistRossBeatenText:
	text "A mere tactical"
	line "error cost me…"
	done

RocketScientistMitchSeenText:
	text "I don't care that"
	line "#mon are hurt"
	cont "by our experiment."
	done

RocketScientistMitchBeatenText:
	text "Thinking is my"
	line "strong suit, not"
	cont "battling."
	done

TeamRocketBaseB3FLockedDoorNeedsPasswordText:
	text "The door's closed…"

	para "It needs two"
	line "passwords to open."
	done

TeamRocketBaseB3FLockedDoorOpenSesameText:
	text "The door's closed…"

	para "<PLAYER> entered"
	line "the two passwords."

	para "The door opened!"
	done
