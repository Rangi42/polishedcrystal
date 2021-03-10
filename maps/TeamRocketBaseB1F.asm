TeamRocketBaseB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, TeamRocketBaseB1FCallback1

	def_warp_events
	warp_event 27,  2, MAHOGANY_MART_1F, 3
	warp_event  3, 14, TEAM_ROCKET_BASE_B2F, 1
	warp_event  5, 15, TEAM_ROCKET_BASE_B1F, 4
	warp_event 25,  2, TEAM_ROCKET_BASE_B1F, 3

	def_coord_events
	; There are five security cameras in the base.
	; Walking in front of one triggers two Rocket Grunts.
	coord_event 24,  2, 0, SecurityCamera1a
	coord_event 24,  3, 0, SecurityCamera1b
	coord_event  6,  2, 0, SecurityCamera2a
	coord_event  6,  3, 0, SecurityCamera2b
	coord_event 24,  6, 0, SecurityCamera3a
	coord_event 24,  7, 0, SecurityCamera3b
	coord_event 22, 16, 0, SecurityCamera4
	coord_event  8, 16, 0, SecurityCamera5
	; There are spots on the floor that trigger a Pokémon battle.
	; Each Pokémon (Voltorb, Koffing, Geodude) knows Explosion as a unique wild move.
	coord_event  2,  7, 0, ExplodingTrap1
	coord_event  3,  7, 0, ExplodingTrap2
	coord_event  4,  7, 0, ExplodingTrap3
	coord_event  1,  8, 0, ExplodingTrap4
	coord_event  3,  8, 0, ExplodingTrap5
	coord_event  5,  8, 0, ExplodingTrap6
	coord_event  3,  9, 0, ExplodingTrap7
	coord_event  4,  9, 0, ExplodingTrap8
	coord_event  1, 10, 0, ExplodingTrap9
	coord_event  2, 10, 0, ExplodingTrap10
	coord_event  3, 10, 0, ExplodingTrap11
	coord_event  5, 10, 0, ExplodingTrap12
	coord_event  2, 11, 0, ExplodingTrap13
	coord_event  4, 11, 0, ExplodingTrap14
	coord_event  1, 12, 0, ExplodingTrap15
	coord_event  2, 12, 0, ExplodingTrap16
	coord_event  4, 12, 0, ExplodingTrap17
	coord_event  5, 12, 0, ExplodingTrap18
	coord_event  1, 13, 0, ExplodingTrap19
	coord_event  3, 13, 0, ExplodingTrap20
	coord_event  4, 13, 0, ExplodingTrap21
	coord_event  5, 13, 0, ExplodingTrap22

	def_bg_events
	bg_event 19, 11, BGEVENT_READ, MapTeamRocketBaseB1FSignpost0Script
	bg_event 24,  1, BGEVENT_UP, MapTeamRocketBaseB1FSignpost5Script
	bg_event  6,  1, BGEVENT_UP, MapTeamRocketBaseB1FSignpost5Script
	bg_event  8, 15, BGEVENT_UP, MapTeamRocketBaseB1FSignpost5Script
	bg_event 22, 15, BGEVENT_UP, MapTeamRocketBaseB1FSignpost5Script
	bg_event 24,  5, BGEVENT_UP, MapTeamRocketBaseB1FSignpost5Script
	bg_event 20, 11, BGEVENT_JUMPSTD, teamrocketoath
	bg_event 21, 11, BGEVENT_JUMPSTD, teamrocketoath
	bg_event  3, 11, BGEVENT_ITEM + REVIVE, EVENT_TEAM_ROCKET_BASE_B1F_HIDDEN_REVIVE

	def_object_events
	object_event  0,  0, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_SECURITY_GRUNTS
	object_event  2,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM16, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 18, 12, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerRocketScientistJed, EVENT_TEAM_ROCKET_BASE_POPULATION
	itemball_event 27,  6, HYPER_POTION, 1, EVENT_TEAM_ROCKET_BASE_B1F_HYPER_POTION
	itemball_event 14, 15, NUGGET, 1, EVENT_TEAM_ROCKET_BASE_B1F_NUGGET
	itemball_event 21, 12, GUARD_SPEC, 1, EVENT_TEAM_ROCKET_BASE_B1F_GUARD_SPEC

	object_const_def
	const TEAMROCKETBASEB1F_ROCKET1

TeamRocketBaseB1FCallback1:
	disappear TEAMROCKETBASEB1F_ROCKET1
	return

SecurityCamera1a:
	checkevent EVENT_SECURITY_CAMERA_1
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 2
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 2
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt2
	ifequal $1, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_1
	end

SecurityCamera1b:
	checkevent EVENT_SECURITY_CAMERA_1
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 3
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 3
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt2
	ifequal $1, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_1
	end

SecurityCamera2a:
	checkevent EVENT_SECURITY_CAMERA_2
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 4, 7
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement2
	scall TrainerCameraGrunt1
	ifequal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 12, 5
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement3
	scall TrainerCameraGrunt2
	ifequal $1, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_2
	end

SecurityCamera2b:
	checkevent EVENT_SECURITY_CAMERA_2
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 4, 8
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement4
	scall TrainerCameraGrunt1
	ifequal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 12, 5
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement5
	scall TrainerCameraGrunt2
	ifequal $1, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_2
	end

SecurityCamera3a:
	checkevent EVENT_SECURITY_CAMERA_3
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 6
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 25, 11
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement6
	scall TrainerCameraGrunt2
	ifequal $1, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_3
	end

SecurityCamera3b:
	checkevent EVENT_SECURITY_CAMERA_3
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 19, 7
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 25, 12
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement7
	scall TrainerCameraGrunt2
	ifequal $1, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_3
	end

SecurityCamera4:
	checkevent EVENT_SECURITY_CAMERA_4
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 17, 16
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 25, 11
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement8
	scall TrainerCameraGrunt2
	ifequal $1, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_4
	end

SecurityCamera5:
	checkevent EVENT_SECURITY_CAMERA_5
	iftrue NoSecurityCamera
	scall PlaySecurityCameraSounds
	checkevent EVENT_TEAM_ROCKET_BASE_POPULATION
	iftrue NoSecurityCamera
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveobject TEAMROCKETBASEB1F_ROCKET1, 3, 16
	appear TEAMROCKETBASEB1F_ROCKET1
	turnobject PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	ifequal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject PLAYER, RIGHT
	moveobject TEAMROCKETBASEB1F_ROCKET1, 14, 16
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement9
	scall TrainerCameraGrunt2
	ifequal $1, NoSecurityCamera
	setevent EVENT_SECURITY_CAMERA_5
	end

NoSecurityCamera:
	end

TrainerCameraGrunt1:
	showtext CameraGrunt1SeenText
	winlosstext CameraGrunt1BeatenText, 0
	setlasttalked TEAMROCKETBASEB1F_ROCKET1
	loadtrainer GRUNTM, 20
	startbattle
	disappear TEAMROCKETBASEB1F_ROCKET1
	reloadmapafterbattle
	end

TrainerCameraGrunt2:
	showtext CameraGrunt2SeenText
	winlosstext CameraGrunt2BeatenText, 0
	setlasttalked TEAMROCKETBASEB1F_ROCKET1
	loadtrainer GRUNTM, 21
	startbattle
	disappear TEAMROCKETBASEB1F_ROCKET1
	reloadmapafterbattle
	end

PlaySecurityCameraSounds:
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	end

ExplodingTrap1:
	checkevent EVENT_EXPLODING_TRAP_1
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_1
	end

ExplodingTrap2:
	checkevent EVENT_EXPLODING_TRAP_2
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_2
	end

ExplodingTrap3:
	checkevent EVENT_EXPLODING_TRAP_3
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_3
	end

ExplodingTrap4:
	checkevent EVENT_EXPLODING_TRAP_4
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_4
	end

ExplodingTrap5:
	checkevent EVENT_EXPLODING_TRAP_5
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_5
	end

ExplodingTrap6:
	checkevent EVENT_EXPLODING_TRAP_6
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_6
	end

ExplodingTrap7:
	checkevent EVENT_EXPLODING_TRAP_7
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_7
	end

ExplodingTrap8:
	checkevent EVENT_EXPLODING_TRAP_8
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_8
	end

ExplodingTrap9:
	checkevent EVENT_EXPLODING_TRAP_9
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_9
	end

ExplodingTrap10:
	checkevent EVENT_EXPLODING_TRAP_10
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_10
	end

ExplodingTrap11:
	checkevent EVENT_EXPLODING_TRAP_11
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_11
	end

ExplodingTrap12:
	checkevent EVENT_EXPLODING_TRAP_12
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_12
	end

ExplodingTrap13:
	checkevent EVENT_EXPLODING_TRAP_13
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_13
	end

ExplodingTrap14:
	checkevent EVENT_EXPLODING_TRAP_14
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_14
	end

ExplodingTrap15:
	checkevent EVENT_EXPLODING_TRAP_15
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_15
	end

ExplodingTrap16:
	checkevent EVENT_EXPLODING_TRAP_16
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_16
	end

ExplodingTrap17:
	checkevent EVENT_EXPLODING_TRAP_17
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_17
	end

ExplodingTrap18:
	checkevent EVENT_EXPLODING_TRAP_18
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_18
	end

ExplodingTrap19:
	checkevent EVENT_EXPLODING_TRAP_19
	iftrue NoExplodingTrap
	scall GeodudeExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_19
	end

ExplodingTrap20:
	checkevent EVENT_EXPLODING_TRAP_20
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_20
	end

ExplodingTrap21:
	checkevent EVENT_EXPLODING_TRAP_21
	iftrue NoExplodingTrap
	scall KoffingExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_21
	end

ExplodingTrap22:
	checkevent EVENT_EXPLODING_TRAP_22
	iftrue NoExplodingTrap
	scall VoltorbExplodingTrap
	reloadmapafterbattle
	setevent EVENT_EXPLODING_TRAP_22
	end

VoltorbExplodingTrap:
	special FadeOutPalettes
	special LoadMapPalettes
	cry VOLTORB
	special FadeInPalettes
	setlasttalked -1
	writecode VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon VOLTORB, 30
	startbattle
	end

GeodudeExplodingTrap:
	special FadeOutPalettes
	special LoadMapPalettes
	cry GEODUDE
	special FadeInPalettes
	setlasttalked -1
	writecode VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon GEODUDE, 28
	startbattle
	end

KoffingExplodingTrap:
	special FadeOutPalettes
	special LoadMapPalettes
	cry KOFFING
	special FadeInPalettes
	setlasttalked -1
	writecode VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon KOFFING, 28
	startbattle
	end

NoExplodingTrap:
	end

GenericTrainerRocketScientistJed:
	generictrainer ROCKET_SCIENTIST, JED, EVENT_BEAT_ROCKET_SCIENTIST_JED, RocketScientistJedSeenText, RocketScientistJedBeatenText

	text "All right. I'll"
	line "divulge a secret"
	cont "about our hideout."

	para "That thing on the"
	line "floor up ahead is"
	cont "a warp panel."

	para "If you step on it,"
	line "you'll be warped"

	para "back to the en-"
	line "trance."
	done

GenericTrainerGruntM16:
	generictrainer GRUNTM, 16, EVENT_BEAT_ROCKET_GRUNTM_16, GruntM16SeenText, GruntM16BeatenText

	text "I don't even know"
	line "where the traps"
	cont "are planted."

	para "You'll just have"
	line "to collect your"
	cont "courage and walk."
	done

MapTeamRocketBaseB1FSignpost5Script:
	jumptext SecurityCameraText

MapTeamRocketBaseB1FSignpost0Script:
	opentext
	checkevent EVENT_TURNED_OFF_SECURITY_CAMERAS
	iftrue UnknownScript_0x6cabe
	writetext TeamRocketBaseB1FSecretSwitchText
	playsound SFX_TALLY
	waitbutton
	closetext
	setevent EVENT_TURNED_OFF_SECURITY_CAMERAS
	setevent EVENT_SECURITY_CAMERA_1
	setevent EVENT_SECURITY_CAMERA_2
	setevent EVENT_SECURITY_CAMERA_3
	setevent EVENT_SECURITY_CAMERA_4
	setevent EVENT_SECURITY_CAMERA_5
	end

UnknownScript_0x6cabe:
	jumpopenedtext TeamRocketBaseB1FSwitchOffText

SecurityCameraMovement1:
	run_step_right
	run_step_right
	run_step_right
	run_step_right
	step_end

SecurityCameraMovement2:
	run_step_up
	run_step_right
	run_step_up
	run_step_up
	run_step_up
	run_step_up
	turn_head_right
	step_end

SecurityCameraMovement3:
	run_step_left
	run_step_left
	run_step_left
	run_step_up
	run_step_up
	run_step_up
	run_step_left
	run_step_left
	step_end

SecurityCameraMovement4:
; he jumps over a trap
	jump_step_up
	run_step_right
	run_step_up
	run_step_up
	run_step_up
	turn_head_right
	step_end

SecurityCameraMovement5:
	run_step_left
	run_step_left
	run_step_left
	run_step_up
	run_step_up
	run_step_left
	run_step_left
	step_end

SecurityCameraMovement6:
	run_step_up
	run_step_up
	run_step_right
	run_step_up
	run_step_up
	run_step_up
	run_step_left
	step_end

SecurityCameraMovement7:
	run_step_up
	run_step_up
	run_step_up
	run_step_right
	run_step_up
	run_step_up
	run_step_left
	step_end

SecurityCameraMovement8:
	run_step_down
	run_step_down
	run_step_right
	run_step_down
	run_step_down
	run_step_down
	run_step_left
	run_step_left
	run_step_left
	step_end

SecurityCameraMovement9:
	run_step_left
	run_step_left
	run_step_left
	run_step_left
	run_step_left
	step_end

CameraGrunt1SeenText:
	text "Hey!"
	line "Intruder alert!"
	done

CameraGrunt1BeatenText:
	text "Dang… I failed…"
	done

CameraGrunt2SeenText:
	text "It's my turn!"
	line "There's no escape!"
	done

CameraGrunt2BeatenText:
	text "Surveillance cams"
	line "are in the #mon"
	cont "statues."

	para "We'll keep appear-"
	line "ing until you trip"
	cont "a secret switch."
	done

RocketScientistJedSeenText:
	text "This was once a"
	line "ninja hideout."

	para "There are traps to"
	line "confound intruders"
	cont "like you."
	done

RocketScientistJedBeatenText:
	text "I get it…"
	done

GruntM16SeenText:
	text "Heheh. Feeling"
	line "lucky, punk?"

	para "Go ahead, take"
	line "another step."

	para "We've got traps"
	line "set in the floor!"
	done

GruntM16BeatenText:
	text "Kaboom!"
	done

SecurityCameraText:
	text "It's a Persian"
	line "statue…"

	para "Its eyes are oddly"
	line "shiny."
	done

TeamRocketBaseB1FSecretSwitchText:
	text "A secret switch!"
	line "Better press it."
	done

TeamRocketBaseB1FSwitchOffText:
	text "The switch is"
	line "turned off."
	done
