TeamRocketBaseB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, TeamRocketBaseB1FCallback1

TeamRocketBaseB1F_MapEventHeader:

.Warps: db 4
	warp_def 2, 27, 3, MAHOGANY_MART_1F
	warp_def 14, 3, 1, TEAM_ROCKET_BASE_B2F
	warp_def 15, 5, 4, TEAM_ROCKET_BASE_B1F
	warp_def 2, 25, 3, TEAM_ROCKET_BASE_B1F

.XYTriggers: db 30
	; There are five security cameras in the base.
	; Walking in front of one triggers two Rocket Grunts.
	xy_trigger 0, 2, 24, SecurityCamera1a
	xy_trigger 0, 3, 24, SecurityCamera1b
	xy_trigger 0, 2, 6, SecurityCamera2a
	xy_trigger 0, 3, 6, SecurityCamera2b
	xy_trigger 0, 6, 24, SecurityCamera3a
	xy_trigger 0, 7, 24, SecurityCamera3b
	xy_trigger 0, 16, 22, SecurityCamera4
	xy_trigger 0, 16, 8, SecurityCamera5
	; There are spots on the floor that trigger a Pokémon battle.
	; Each Pokémon (Voltorb, Koffing, Geodude) knows Selfdestruct.
	xy_trigger 0, 7, 2, ExplodingTrap1
	xy_trigger 0, 7, 3, ExplodingTrap2
	xy_trigger 0, 7, 4, ExplodingTrap3
	xy_trigger 0, 8, 1, ExplodingTrap4
	xy_trigger 0, 8, 3, ExplodingTrap5
	xy_trigger 0, 8, 5, ExplodingTrap6
	xy_trigger 0, 9, 3, ExplodingTrap7
	xy_trigger 0, 9, 4, ExplodingTrap8
	xy_trigger 0, 10, 1, ExplodingTrap9
	xy_trigger 0, 10, 2, ExplodingTrap10
	xy_trigger 0, 10, 3, ExplodingTrap11
	xy_trigger 0, 10, 5, ExplodingTrap12
	xy_trigger 0, 11, 2, ExplodingTrap13
	xy_trigger 0, 11, 4, ExplodingTrap14
	xy_trigger 0, 12, 1, ExplodingTrap15
	xy_trigger 0, 12, 2, ExplodingTrap16
	xy_trigger 0, 12, 4, ExplodingTrap17
	xy_trigger 0, 12, 5, ExplodingTrap18
	xy_trigger 0, 13, 1, ExplodingTrap19
	xy_trigger 0, 13, 3, ExplodingTrap20
	xy_trigger 0, 13, 4, ExplodingTrap21
	xy_trigger 0, 13, 5, ExplodingTrap22

.Signposts: db 9
	signpost 11, 19, SIGNPOST_READ, MapTeamRocketBaseB1FSignpost0Script
	signpost 1, 24, SIGNPOST_UP, MapTeamRocketBaseB1FSignpost5Script
	signpost 1, 6, SIGNPOST_UP, MapTeamRocketBaseB1FSignpost5Script
	signpost 15, 8, SIGNPOST_UP, MapTeamRocketBaseB1FSignpost5Script
	signpost 15, 22, SIGNPOST_UP, MapTeamRocketBaseB1FSignpost5Script
	signpost 5, 24, SIGNPOST_UP, MapTeamRocketBaseB1FSignpost5Script
	signpost 11, 20, SIGNPOST_JUMPSTD, teamrocketoath
	signpost 11, 21, SIGNPOST_JUMPSTD, teamrocketoath
	signpost 11, 3, SIGNPOST_ITEM + REVIVE, EVENT_TEAM_ROCKET_BASE_B1F_HIDDEN_REVIVE

.PersonEvents: db 6
	person_event SPRITE_ROCKET, 0, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_SECURITY_GRUNTS
	person_event SPRITE_ROCKET, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM16, EVENT_TEAM_ROCKET_BASE_POPULATION
	person_event SPRITE_SCIENTIST, 12, 18, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerRocketScientistJed, EVENT_TEAM_ROCKET_BASE_POPULATION
	itemball_event 6, 27, HYPER_POTION, 1, EVENT_TEAM_ROCKET_BASE_B1F_HYPER_POTION
	itemball_event 15, 14, NUGGET, 1, EVENT_TEAM_ROCKET_BASE_B1F_NUGGET
	itemball_event 12, 21, GUARD_SPEC, 1, EVENT_TEAM_ROCKET_BASE_B1F_GUARD_SPEC

const_value set 1
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
	moveperson TEAMROCKETBASEB1F_ROCKET1, 19, 2
	appear TEAMROCKETBASEB1F_ROCKET1
	spriteface PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	if_equal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveperson TEAMROCKETBASEB1F_ROCKET1, 19, 2
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt2
	if_equal $1, NoSecurityCamera
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
	moveperson TEAMROCKETBASEB1F_ROCKET1, 19, 3
	appear TEAMROCKETBASEB1F_ROCKET1
	spriteface PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	if_equal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	moveperson TEAMROCKETBASEB1F_ROCKET1, 19, 3
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt2
	if_equal $1, NoSecurityCamera
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
	moveperson TEAMROCKETBASEB1F_ROCKET1, 4, 7
	appear TEAMROCKETBASEB1F_ROCKET1
	spriteface PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement2
	scall TrainerCameraGrunt1
	if_equal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	spriteface PLAYER, RIGHT
	moveperson TEAMROCKETBASEB1F_ROCKET1, 12, 5
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement3
	scall TrainerCameraGrunt2
	if_equal $1, NoSecurityCamera
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
	moveperson TEAMROCKETBASEB1F_ROCKET1, 4, 8
	appear TEAMROCKETBASEB1F_ROCKET1
	spriteface PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement4
	scall TrainerCameraGrunt1
	if_equal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	spriteface PLAYER, RIGHT
	moveperson TEAMROCKETBASEB1F_ROCKET1, 12, 5
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement5
	scall TrainerCameraGrunt2
	if_equal $1, NoSecurityCamera
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
	moveperson TEAMROCKETBASEB1F_ROCKET1, 19, 6
	appear TEAMROCKETBASEB1F_ROCKET1
	spriteface PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	if_equal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	spriteface PLAYER, RIGHT
	moveperson TEAMROCKETBASEB1F_ROCKET1, 25, 11
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement6
	scall TrainerCameraGrunt2
	if_equal $1, NoSecurityCamera
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
	moveperson TEAMROCKETBASEB1F_ROCKET1, 19, 7
	appear TEAMROCKETBASEB1F_ROCKET1
	spriteface PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	if_equal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	spriteface PLAYER, RIGHT
	moveperson TEAMROCKETBASEB1F_ROCKET1, 25, 12
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement7
	scall TrainerCameraGrunt2
	if_equal $1, NoSecurityCamera
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
	moveperson TEAMROCKETBASEB1F_ROCKET1, 17, 16
	appear TEAMROCKETBASEB1F_ROCKET1
	spriteface PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	if_equal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	spriteface PLAYER, RIGHT
	moveperson TEAMROCKETBASEB1F_ROCKET1, 25, 11
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement8
	scall TrainerCameraGrunt2
	if_equal $1, NoSecurityCamera
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
	moveperson TEAMROCKETBASEB1F_ROCKET1, 3, 16
	appear TEAMROCKETBASEB1F_ROCKET1
	spriteface PLAYER, LEFT
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement1
	scall TrainerCameraGrunt1
	if_equal $1, NoSecurityCamera
	scall PlaySecurityCameraSounds
	showemote EMOTE_SHOCK, PLAYER, 15
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	spriteface PLAYER, RIGHT
	moveperson TEAMROCKETBASEB1F_ROCKET1, 14, 16
	appear TEAMROCKETBASEB1F_ROCKET1
	applymovement TEAMROCKETBASEB1F_ROCKET1, SecurityCameraMovement9
	scall TrainerCameraGrunt2
	if_equal $1, NoSecurityCamera
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
	cry VOLTORB
	special FadeInPalettes
	setlasttalked -1
	writecode VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon VOLTORB, 30
	startbattle
	end

GeodudeExplodingTrap:
	special FadeOutPalettes
	cry GEODUDE
	special FadeInPalettes
	setlasttalked -1
	writecode VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon GEODUDE, 28
	startbattle
	end

KoffingExplodingTrap:
	special FadeOutPalettes
	cry KOFFING
	special FadeInPalettes
	setlasttalked -1
	writecode VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon KOFFING, 28
	startbattle
	end

NoExplodingTrap:
	end

TrainerRocketScientistJed:
	trainer EVENT_BEAT_ROCKET_SCIENTIST_JED, ROCKET_SCIENTIST, JED, RocketScientistJedSeenText, RocketScientistJedBeatenText, 0, RocketScientistJedScript

RocketScientistJedScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6cc16

TrainerGruntM16:
	trainer EVENT_BEAT_ROCKET_GRUNTM_16, GRUNTM, 16, GruntM16SeenText, GruntM16BeatenText, 0, GruntM16Script

GruntM16Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6cd1b

MapTeamRocketBaseB1FSignpost5Script:
	jumptext SecurityCameraText

MapTeamRocketBaseB1FSignpost0Script:
	opentext
	checkevent EVENT_TURNED_OFF_SECURITY_CAMERAS
	iftrue UnknownScript_0x6cabe
	writetext UnknownText_0x6cdad
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
	jumpopenedtext UnknownText_0x6cdd0

SecurityCameraMovement1:
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	step_end

SecurityCameraMovement2:
	big_step_up
	big_step_right
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	turn_head_right
	step_end

SecurityCameraMovement3:
	big_step_left
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	big_step_up
	big_step_left
	big_step_left
	step_end

SecurityCameraMovement4:
; he jumps over a trap
	jump_step_up
	big_step_right
	big_step_up
	big_step_up
	big_step_up
	turn_head_right
	step_end

SecurityCameraMovement5:
	big_step_left
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	big_step_left
	big_step_left
	step_end

SecurityCameraMovement6:
	big_step_up
	big_step_up
	big_step_right
	big_step_up
	big_step_up
	big_step_up
	big_step_left
	step_end

SecurityCameraMovement7:
	big_step_up
	big_step_up
	big_step_up
	big_step_right
	big_step_up
	big_step_up
	big_step_left
	step_end

SecurityCameraMovement8:
	big_step_down
	big_step_down
	big_step_right
	big_step_down
	big_step_down
	big_step_down
	big_step_left
	big_step_left
	big_step_left
	step_end

SecurityCameraMovement9:
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_left
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

UnknownText_0x6cc16:
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

UnknownText_0x6cd1b:
	text "I don't even know"
	line "where the traps"
	cont "are planted."

	para "You'll just have"
	line "to collect your"
	cont "courage and walk."
	done

SecurityCameraText:
	text "It's a Persian"
	line "statue…"

	para "Its eyes are oddly"
	line "shiny."
	done

UnknownText_0x6cdad:
	text "A secret switch!"
	line "Better press it."
	done

UnknownText_0x6cdd0:
	text "The switch is"
	line "turned off."
	done
