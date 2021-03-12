LavenderTown_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, LavenderTownFlyPoint

	def_warp_events
	warp_event  5,  7, LAVENDER_POKECENTER_1F, 1
	warp_event  5, 11, MR_FUJIS_HOUSE, 1
	warp_event  3, 15, LAVENDER_TOWN_SPEECH_HOUSE, 1
	warp_event  7, 15, LAVENDER_NAME_RATER, 1
	warp_event  1,  7, LAVENDER_MART, 2
	warp_event 13, 13, SOUL_HOUSE, 1
	warp_event 14,  7, LAV_RADIO_TOWER_1F, 1

	def_coord_events
; TODO:
;	coord_event  8,  5, 0, LavenderTownExpositionTrigger1
;	coord_event  9,  5, 0, LavenderTownExpositionTrigger2
;	coord_event 10,  5, 0, LavenderTownExpositionTrigger3

	def_bg_events
	bg_event 11,  5, BGEVENT_JUMPTEXT, LavenderTownSignText
	bg_event 15,  9, BGEVENT_JUMPTEXT, KantoRadioStationSignText
	bg_event  3, 11, BGEVENT_JUMPTEXT, VolunteerPokemonHouseSignText
	bg_event 15, 15, BGEVENT_JUMPTEXT, SoulHouseSignText

	def_object_events
	object_event 14,  7, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAVENDER_TOWN_FLEEING_YOUNGSTER
	object_event 12,  9, SPRITE_HIKER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavenderTownPokefanMText, -1
	object_event  2, 17, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavenderTownTeacherText, -1
	object_event 14, 14, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavenderTownGrampsText, -1
	object_event  6, 13, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavenderTownYoungsterText, -1
	object_event  8, 18, SPRITE_POKEMANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavenderTownSuperNerdText, EVENT_LAVENDER_TOWN_FLEEING_YOUNGSTER ; TODO: EVENT_EXORCISED_LAV_RADIO_TOWER
	object_event  9, 19, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavenderTownCooltrainerFText, EVENT_LAVENDER_TOWN_FLEEING_YOUNGSTER ; TODO: EVENT_EXORCISED_LAV_RADIO_TOWER
	object_event 11, 17, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavenderTownRockerText, EVENT_LAVENDER_TOWN_FLEEING_YOUNGSTER ; TODO: EVENT_EXORCISED_LAV_RADIO_TOWER

	object_const_def
	const LAVENDERTOWN_YOUNGSTER1

LavenderTownFlyPoint:
; TODO: don't set these once the coord_events are done
	setevent EVENT_ROUTE_8_PROTESTORS
	clearevent EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	setflag ENGINE_FLYPOINT_LAVENDER
	endcallback

LavenderTownExpositionTrigger1:
	moveobject LAVENDERTOWN_YOUNGSTER1, 14, 8
	showemote EMOTE_SHOCK, PLAYER, 15
	appear LAVENDERTOWN_YOUNGSTER1
	applymovement LAVENDERTOWN_YOUNGSTER1, .ApproachPlayerMovement
	scall LavenderTownSharedExpositionScript
	applymovement LAVENDERTOWN_YOUNGSTER1, .GoAroundPlayerMovement
	sjump LavenderTownFinishExpositionScript

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
	sjump LavenderTownFinishExpositionScript

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
	sjump LavenderTownFinishExpositionScript

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
	jumpthistext

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
	turnobject PLAYER, UP
	applymovement LAVENDERTOWN_YOUNGSTER1, .LeaveMovement
	disappear LAVENDERTOWN_YOUNGSTER1
	setevent EVENT_ROUTE_8_PROTESTORS
	clearevent EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	setflag ENGINE_FLYPOINT_LAVENDER
	setscene $1
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
	text "House of Souls"

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
