LavenderTown_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

LavenderTown_MapEventHeader:

.Warps: db 7
	warp_def 7, 5, 1, LAVENDER_POKECENTER_1F
	warp_def 11, 5, 1, MR_FUJIS_HOUSE
	warp_def 15, 3, 1, LAVENDER_TOWN_SPEECH_HOUSE
	warp_def 15, 7, 1, LAVENDER_NAME_RATER
	warp_def 7, 1, 2, LAVENDER_MART
	warp_def 13, 13, 1, SOUL_HOUSE
	warp_def 7, 14, 1, LAV_RADIO_TOWER_1F

.XYTriggers: db 3
	xy_trigger 0, 5, 8, LavenderTownExpositionTrigger1
	xy_trigger 0, 5, 9, LavenderTownExpositionTrigger2
	xy_trigger 0, 5, 10, LavenderTownExpositionTrigger3

.Signposts: db 4
	signpost 5, 11, SIGNPOST_JUMPTEXT, LavenderTownSignText
	signpost 9, 15, SIGNPOST_JUMPTEXT, KantoRadioStationSignText
	signpost 11, 3, SIGNPOST_JUMPTEXT, VolunteerPokemonHouseSignText
	signpost 15, 15, SIGNPOST_JUMPTEXT, SoulHouseSignText

.PersonEvents: db 8
	person_event SPRITE_YOUNGSTER, 7, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAVENDER_TOWN_FLEEING_YOUNGSTER
	person_event SPRITE_POKEFAN_M, 9, 12, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, LavenderTownPokefanMText, -1
	person_event SPRITE_TEACHER, 17, 2, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, LavenderTownTeacherText, -1
	person_event SPRITE_GRAMPS, 14, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, LavenderTownGrampsText, -1
	person_event SPRITE_YOUNGSTER, 13, 6, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, LavenderTownYoungsterText, -1
	person_event SPRITE_SUPER_NERD, 18, 8, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, LavenderTownSuperNerdText, EVENT_EXORCISED_LAV_RADIO_TOWER
	person_event SPRITE_COOLTRAINER_F, 19, 9, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, LavenderTownCooltrainerFText, EVENT_EXORCISED_LAV_RADIO_TOWER
	person_event SPRITE_ROCKER, 17, 11, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, LavenderTownRockerText, EVENT_EXORCISED_LAV_RADIO_TOWER

const_value set 1
	const LAVENDERTOWN_YOUNGSTER1

LavenderTownExpositionTrigger1:
	moveperson LAVENDERTOWN_YOUNGSTER1, 14, 8
	showemote EMOTE_SHOCK, PLAYER, 15
	appear LAVENDERTOWN_YOUNGSTER1
	applymovement LAVENDERTOWN_YOUNGSTER1, .ApproachPlayerMovement
	scall LavenderTownSharedExpositionScript
	applymovement LAVENDERTOWN_YOUNGSTER1, .GoAroundPlayerMovement
	jump LavenderTownFinishExpositionScript

.ApproachPlayerMovement:
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	step_end

.GoAroundPlayerMovement:
	step_right
	big_step_up
	step_end

LavenderTownExpositionTrigger2:
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_ENTER_DOOR
	appear LAVENDERTOWN_YOUNGSTER1
	waitsfx
	applymovement LAVENDERTOWN_YOUNGSTER1, .ApproachPlayerMovement
	scall LavenderTownSharedExpositionScript
	applymovement LAVENDERTOWN_YOUNGSTER1, .GoAroundPlayerMovement
	jump LavenderTownFinishExpositionScript

.ApproachPlayerMovement:
	step_down
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	step_end

.GoAroundPlayerMovement:
	step_right
	big_step_up
	step_end

LavenderTownExpositionTrigger3:
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_ENTER_DOOR
	appear LAVENDERTOWN_YOUNGSTER1
	waitsfx
	applymovement LAVENDERTOWN_YOUNGSTER1, .ApproachPlayerMovement
	scall LavenderTownSharedExpositionScript
	applymovement LAVENDERTOWN_YOUNGSTER1, .GoAroundPlayerMovement
	jump LavenderTownFinishExpositionScript

.ApproachPlayerMovement:
	step_down
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	big_step_up
	big_step_up
	step_end

.GoAroundPlayerMovement:
	step_left
	big_step_up
	step_end

LavenderTownSharedExpositionScript:
	playsound SFX_TACKLE
	applymovement LAVENDERTOWN_YOUNGSTER1, .BumpMovement
	thistext

	text "Aah! G-g-ghost!"

	para "The Radio Tower"
	line "is teeming with"
	cont "monsters!"

	para "Run for the"
	line "hills!"
	done

.BumpMovement:
	fix_facing
	set_sliding
	jump_step_down
	remove_sliding
	remove_fixed_facing
	step_sleep_8
	step_sleep_8
	step_up
	step_up
	step_end

LavenderTownFinishExpositionScript:
	spriteface PLAYER, UP
	applymovement LAVENDERTOWN_YOUNGSTER1, .LeaveMovement
	disappear LAVENDERTOWN_YOUNGSTER1
	setevent EVENT_ROUTE_8_PROTESTORS
	clearevent EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	setflag ENGINE_FLYPOINT_LAVENDER
	dotrigger $1
	end

.LeaveMovement:
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	step_end

LavenderTownSignText:
	text "Lavender Town"

	para "The Noble Purple"
	line "Town"
	done

KantoRadioStationSignText:
	text "Kanto Radio"
	line "Station"

	para "Your Favorite"
	line "Programs On-Air"
	cont "Around the Clock!"
	done

VolunteerPokemonHouseSignText:
	text "Lavender Volunteer"
	line "#mon House"
	done

SoulHouseSignText:
	text "House of Memories"

	para "May the Souls of"
	line "#mon Rest Easy"
	done

LavenderTownPokefanMText:
	text "That's quite some"
	line "building, eh?"

	para "It's Kanto's Radio"
	line "Tower."
	done

LavenderTownTeacherText:
	text "Kanto has many"
	line "good radio shows."
	done

LavenderTownGrampsText:
	text "People come from"
	line "all over to pay"

	para "their respects to"
	line "the departed souls"
	cont "of #mon."
	done

LavenderTownYoungsterText:
	text "You need a #"
	line "Flute to wake"
	cont "sleeping #mon."

	para "Every trainer has"
	line "to know that!"
	done

LavenderTownSuperNerdText:
	text "Go back inside the"
	line "Radio Tower?"

	para "You must be"
	line "crazy!"
	done

LavenderTownCooltrainerFText:
	text "The Tower's"
	line "haunted, I just"
	cont "know it!"

	para "I'm so freaked"
	line "out!"
	done

LavenderTownRockerText:
	text "I thought a job at"
	line "the Radio Tower"

	para "would be my big"
	line "break, but I'm not"

	para "going back there"
	line "until it's safe."
	done
