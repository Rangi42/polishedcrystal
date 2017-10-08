TeamRocketBaseB3F_MapScriptHeader:

.MapTriggers: db 1
	dw TeamRocketBaseB3FTrigger0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, TeamRocketBaseB3FCheckGiovanniDoor

TeamRocketBaseB3F_MapEventHeader:

.Warps: db 4
	warp_def 2, 3, 2, TEAM_ROCKET_BASE_B2F
	warp_def 2, 27, 3, TEAM_ROCKET_BASE_B2F
	warp_def 6, 3, 4, TEAM_ROCKET_BASE_B2F
	warp_def 14, 27, 5, TEAM_ROCKET_BASE_B2F

.XYTriggers: db 3
	xy_trigger 2, 8, 10, UnknownScript_0x6e04b
	xy_trigger 2, 8, 11, UnknownScript_0x6e052
	xy_trigger 1, 10, 8, RocketBaseRival

.Signposts: db 10
	signpost 9, 10, SIGNPOST_IFNOTSET, BossDoor
	signpost 9, 11, SIGNPOST_IFNOTSET, BossDoor
	signpost 1, 10, SIGNPOST_JUMPSTD, teamrocketoath
	signpost 1, 11, SIGNPOST_JUMPSTD, teamrocketoath
	signpost 1, 12, SIGNPOST_JUMPSTD, teamrocketoath
	signpost 1, 13, SIGNPOST_JUMPSTD, teamrocketoath
	signpost 13, 4, SIGNPOST_JUMPSTD, teamrocketoath
	signpost 13, 5, SIGNPOST_JUMPSTD, teamrocketoath
	signpost 13, 6, SIGNPOST_JUMPSTD, teamrocketoath
	signpost 13, 7, SIGNPOST_JUMPSTD, teamrocketoath

.PersonEvents: db 14
	person_event SPRITE_LANCE, 14, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LanceGetPasswordScript, EVENT_TEAM_ROCKET_BASE_B3F_LANCE_PASSWORDS
	person_event SPRITE_PETREL, 3, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B3F_PETREL
	person_event SPRITE_MURKROW, 2, 7, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, RocketBaseMurkrow, EVENT_TEAM_ROCKET_BASE_POPULATION
	person_event SPRITE_SILVER, 5, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_TEAM_ROCKET_BASE
	person_event SPRITE_ROCKET_GIRL, 7, 21, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, SlowpokeTailGrunt, EVENT_TEAM_ROCKET_BASE_POPULATION
	person_event SPRITE_ROCKET, 14, 5, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, RaticateTailGrunt, EVENT_TEAM_ROCKET_BASE_POPULATION
	person_event SPRITE_SCIENTIST, 11, 23, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 0, TrainerRocketScientistRoss, EVENT_TEAM_ROCKET_BASE_POPULATION
	person_event SPRITE_SCIENTIST, 15, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerRocketScientistMitch, EVENT_TEAM_ROCKET_BASE_POPULATION
	person_event SPRITE_ROCKET, 14, 24, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x6e235, EVENT_TEAM_ROCKET_BASE_POPULATION
	itemball_event 12, 1, PROTEIN, 1, EVENT_TEAM_ROCKET_BASE_B3F_PROTEIN
	itemball_event 12, 3, X_SPCL_DEF, 1, EVENT_TEAM_ROCKET_BASE_B3F_X_SPCL_DEF
	itemball_event 9, 28, FULL_HEAL, 1, EVENT_TEAM_ROCKET_BASE_B3F_FULL_HEAL
	itemball_event 2, 17, ICE_HEAL, 1, EVENT_TEAM_ROCKET_BASE_B3F_ICE_HEAL
	itemball_event 10, 14, ULTRA_BALL, 1, EVENT_TEAM_ROCKET_BASE_B3F_ULTRA_BALL

const_value set 1
	const TEAMROCKETBASEB3F_LANCE
	const TEAMROCKETBASEB3F_PETREL
	const TEAMROCKETBASEB3F_MURKROW
	const TEAMROCKETBASEB3F_SILVER

TeamRocketBaseB3FTrigger0:
	priorityjump LanceGetPasswordScript
	end

TeamRocketBaseB3FCheckGiovanniDoor:
	checkevent EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	iftrue .OpenSesame
	return

.OpenSesame:
	changeblock 10, 8, $7
	return

LanceGetPasswordScript:
	spriteface PLAYER, LEFT
	pause 5
	spriteface TEAMROCKETBASEB3F_MURKROW, RIGHT
	pause 20
	applyonemovement TEAMROCKETBASEB3F_LANCE, step_right
	showtext LanceGetPasswordText
	applymovement TEAMROCKETBASEB3F_LANCE, MovementData_0x6e12c
	disappear TEAMROCKETBASEB3F_LANCE
	dotrigger $1
	end

RocketBaseRival:
	spriteface PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	appear TEAMROCKETBASEB3F_SILVER
	applymovement TEAMROCKETBASEB3F_SILVER, RocketBaseRivalEnterMovement
	spriteface PLAYER, LEFT
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext RocketBaseRivalText
	playsound SFX_TACKLE
	applymovement PLAYER, RocketBaseRivalShovesPlayerMovement
	applymovement TEAMROCKETBASEB3F_SILVER, RocketBaseRivalLeaveMovement
	disappear TEAMROCKETBASEB3F_SILVER
	dotrigger $2
	special RestartMapMusic
	end

UnknownScript_0x6e04b:
	applymovement PLAYER, MovementData_0x6e133
	jump UnknownScript_0x6e056

UnknownScript_0x6e052:
	applymovement PLAYER, MovementData_0x6e13a
UnknownScript_0x6e056:
	pause 30
	showemote EMOTE_SHOCK, TEAMROCKETBASEB3F_PETREL, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	spriteface TEAMROCKETBASEB3F_PETREL, DOWN
	showtext UnknownText_0x6e400
	applyonemovement TEAMROCKETBASEB3F_PETREL, step_down
	winlosstext UnknownText_0x6e511, 0
	setlasttalked TEAMROCKETBASEB3F_PETREL
	loadtrainer PETREL, PETREL2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_PETREL_2
	showtext UnknownText_0x6e548
	applymovement TEAMROCKETBASEB3F_PETREL, MovementData_0x6e144
	playsound SFX_TACKLE
	applymovement TEAMROCKETBASEB3F_PETREL, MovementData_0x6e147
	disappear TEAMROCKETBASEB3F_PETREL
	dotrigger $3
	end

RocketBaseMurkrow:
	showtext RocketBaseMurkrowText
	setevent EVENT_LEARNED_HAIL_GIOVANNI
	end

SlowpokeTailGrunt:
	trainer EVENT_BEAT_ROCKET_GRUNTF_5, GRUNTF, 5, GruntF5SeenText, GruntF5BeatenText, 0, GruntF5Script

GruntF5Script:
	end_if_just_battled
	showtext UnknownText_0x6e611
	setevent EVENT_LEARNED_SLOWPOKETAIL
	end

RaticateTailGrunt:
	trainer EVENT_BEAT_ROCKET_GRUNTM_28, GRUNTM, 28, GruntM28SeenText, GruntM28BeatenText, 0, GruntM28Script

GruntM28Script:
	end_if_just_battled
	showtext UnknownText_0x6e737
	setevent EVENT_LEARNED_RATICATE_TAIL
	end

TrainerRocketScientistRoss:
	trainer EVENT_BEAT_ROCKET_SCIENTIST_ROSS, ROCKET_SCIENTIST, ROSS, RocketScientistRossSeenText, RocketScientistRossBeatenText, 0, RocketScientistRossScript

RocketScientistRossScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6e822

TrainerRocketScientistMitch:
	trainer EVENT_BEAT_ROCKET_SCIENTIST_MITCH, ROCKET_SCIENTIST, MITCH, RocketScientistMitchSeenText, RocketScientistMitchBeatenText, 0, RocketScientistMitchScript

RocketScientistMitchScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6e90a

BossDoor:
	dw EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	opentext
	checkevent EVENT_LEARNED_SLOWPOKETAIL
	iffalse .NeedsPassword
	checkevent EVENT_LEARNED_RATICATE_TAIL
	iffalse .NeedsPassword
	jump .OpenSesame

.NeedsPassword:
	jumpopenedtext UnknownText_0x6e970

.OpenSesame:
	writetext UnknownText_0x6e9a3
	waitbutton
	playsound SFX_ENTER_DOOR
	changeblock 10, 8, $7
	reloadmappart
	closetext
	setevent EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	waitsfx
	end

MovementData_0x6e12c:
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

MovementData_0x6e133:
	step_up
	step_up
	step_up
	step_left
	step_left
	turn_head_up
	step_end

MovementData_0x6e13a:
	step_up
	step_up
	step_left
	step_up
	step_left
	step_left
	turn_head_up
	step_end

MovementData_0x6e144:
	big_step_right
	big_step_right
	step_end

MovementData_0x6e147:
	fix_facing
	fast_jump_step_left
	remove_fixed_facing
	step_sleep_8
	step_sleep_8
	slow_step_right
	big_step_down
	big_step_down
	big_step_down
	big_step_right
	big_step_down
	big_step_down
	big_step_down
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_left
	big_step_left
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
	big_step_right
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

UnknownText_0x6e235:
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

UnknownText_0x6e400:
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

UnknownText_0x6e511:
	text "I… I couldn't do a"
	line "thing…"

	para "Giovanni, please"
	line "forgive me…"
	done

UnknownText_0x6e548:
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

UnknownText_0x6e611:
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

UnknownText_0x6e737:
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

UnknownText_0x6e822:
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

UnknownText_0x6e90a:
	text "If we turn up the"
	line "power of our radio"

	para "signal for broad-"
	line "cast nationwide…"

	para "The very thought"
	line "excites me!"
	done

UnknownText_0x6e970:
	text "The door's closed…"

	para "It needs two"
	line "passwords to open."
	done

UnknownText_0x6e9a3:
	text "The door's closed…"

	para "<PLAYER> entered"
	line "the two passwords."

	para "The door opened!"
	done
