MagnetTunnelInside_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, MagnetTunnelInsideTileCallback

	def_warp_events
	warp_event  5, 19, MAGNET_TUNNEL_WEST, 1
	warp_event 43,  3, MAGNET_TUNNEL_EAST, 1
	warp_event 27,  3, MAGNET_TUNNEL_INSIDE, 4
	warp_event 27, 31, MAGNET_TUNNEL_INSIDE, 3
	warp_event 34,  5, MAGNET_TUNNEL_INSIDE, 6
	warp_event 34, 33, MAGNET_TUNNEL_INSIDE, 5

	def_coord_events

	def_bg_events
	bg_event  6, 10, BGEVENT_UP, MagnetTunnelInsideMachine1
	bg_event  7, 10, BGEVENT_UP, MagnetTunnelInsideMachine1
	bg_event 22, 21, BGEVENT_UP, MagnetTunnelInsideMachine2
	bg_event 23, 21, BGEVENT_UP, MagnetTunnelInsideMachine2
	bg_event 20,  8, BGEVENT_UP, MagnetTunnelInsideMachine3
	bg_event 21,  8, BGEVENT_UP, MagnetTunnelInsideMachine3
	bg_event 34,  8, BGEVENT_UP, MagnetTunnelInsideMachine4
	bg_event 35,  8, BGEVENT_UP, MagnetTunnelInsideMachine4
	bg_event 38, 30, BGEVENT_ITEM + METAL_POWDER, EVENT_MAGNET_TUNNEL_HIDDEN_METAL_POWDER

	def_object_events
	object_event  3, 10, SPRITE_N64, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_GRAY, OBJECTTYPE_COMMAND, jumptext, MagnetTunnelInsideLodestoneText, EVENT_MAGNET_TUNNEL_LODESTONE_1
	object_event 20, 23, SPRITE_N64, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_GRAY, OBJECTTYPE_COMMAND, jumptext, MagnetTunnelInsideLodestoneText, EVENT_MAGNET_TUNNEL_LODESTONE_2
	object_event 20,  5, SPRITE_N64, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_GRAY, OBJECTTYPE_COMMAND, jumptext, MagnetTunnelInsideLodestoneText, EVENT_MAGNET_TUNNEL_LODESTONE_3
	object_event 35,  5, SPRITE_N64, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_GRAY, OBJECTTYPE_COMMAND, jumptext, MagnetTunnelInsideLodestoneText, EVENT_MAGNET_TUNNEL_LODESTONE_4
	object_event 11, 20, SPRITE_ENGINEER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MagnetTunnelInsideEngineerText1, -1
	object_event  8, 13, SPRITE_ENGINEER, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MagnetTunnelInsideEngineerText2, -1
	object_event 32, 21, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MagnetTunnelInsideScientistText, -1
	object_event 22,  8, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerEngineerGraden, -1
	object_event 31, 12, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerEngineerGustav, -1
	object_event 24, 23, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerEngineerNicolas, -1
	tmhmball_event 19, 21, TM_GYRO_BALL, EVENT_MAGNET_TUNNEL_TM_GYRO_BALL

	object_const_def
	const MAGNETTUNNELINSIDE_STONE_1
	const MAGNETTUNNELINSIDE_STONE_2
	const MAGNETTUNNELINSIDE_STONE_3
	const MAGNETTUNNELINSIDE_STONE_4

MagnetTunnelInsideTileCallback:
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_1
	iffalsefwd .NoMachine1
	changeblock 6, 10, $6b
	changeblock 6, 8, $6d
.NoMachine1
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_2
	iffalsefwd .NoMachine2
	changeblock 22, 20, $66
.NoMachine2
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_3
	iffalsefwd .NoMachine3
	changeblock 20, 8, $6b
	changeblock 20, 6, $6f
.NoMachine3
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_IN_PIT
	iffalsefwd .NoPit
	changeblock 34, 8, $70
	changeblock 34, 4, $68
	endcallback
.NoPit
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_4
	iffalsefwd .NoMachine4
	changeblock 34, 8, $36
	changeblock 34, 6, $35
.NoMachine4
	endcallback

MagnetTunnelInsideMachine1:
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_1
	iftrue_jumptextfaceplayer MagnetTunnelInsideMachineText3
	opentext
	writetext MagnetTunnelInsideMachineText1
	yesorno
	iffalse_endtext
	playsound SFX_GLASS_TING
	changeblock 6, 10, $6b
	refreshmap
	writetext MagnetTunnelInsideMachineText2
	waitbutton
	closetext
	playsound SFX_THUNDERSHOCK
	earthquake 15
	applymovement MAGNETTUNNELINSIDE_STONE_1, .StoneMovement
	playsound SFX_THUNDERSHOCK
	earthquake 15
	playsound SFX_STRENGTH
	changeblock 6, 8, $6d
	refreshmap
	disappear MAGNETTUNNELINSIDE_STONE_1
	end

.StoneMovement:
	fix_facing
	slow_slide_step_up
	slow_slide_step_right
	slow_slide_step_right
	slow_slide_step_right
	remove_fixed_facing
	step_end

MagnetTunnelInsideMachine2:
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_2
	iftrue_jumptextfaceplayer MagnetTunnelInsideMachineText3
	opentext
	writetext MagnetTunnelInsideMachineText1
	yesorno
	iffalse_endtext
	playsound SFX_GLASS_TING
	changeblock 22, 20, $67
	refreshmap
	writetext MagnetTunnelInsideMachineText2
	waitbutton
	closetext
	playsound SFX_THUNDERSHOCK
	earthquake 15
	applymovement MAGNETTUNNELINSIDE_STONE_2, .StoneMovement
	playsound SFX_THUNDERSHOCK
	earthquake 15
	playsound SFX_STRENGTH
	changeblock 22, 20, $66
	refreshmap
	disappear MAGNETTUNNELINSIDE_STONE_2
	end

.StoneMovement:
	fix_facing
	slow_slide_step_up
	slow_slide_step_up
	slow_slide_step_up
	slow_slide_step_right
	slow_slide_step_right
	remove_fixed_facing
	step_end

MagnetTunnelInsideMachine3:
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_3
	iftrue_jumptextfaceplayer MagnetTunnelInsideMachineText3
	opentext
	writetext MagnetTunnelInsideMachineText1
	yesorno
	iffalse_endtext
	playsound SFX_GLASS_TING
	changeblock 20, 8, $6b
	refreshmap
	writetext MagnetTunnelInsideMachineText2
	waitbutton
	closetext
	playsound SFX_THUNDERSHOCK
	earthquake 15
	applymovement MAGNETTUNNELINSIDE_STONE_3, .StoneMovement
	playsound SFX_THUNDERSHOCK
	earthquake 15
	playsound SFX_STRENGTH
	changeblock 20, 6, $6f
	refreshmap
	disappear MAGNETTUNNELINSIDE_STONE_3
	end

.StoneMovement:
	fix_facing
	slow_slide_step_down
	slow_slide_step_down
	remove_fixed_facing
	step_end

MagnetTunnelInsideMachine4:
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_4
	iftruefwd .MachineOn
	opentext
	writetext MagnetTunnelInsideMachineText1
	yesorno
	iffalse_endtext
	playsound SFX_GLASS_TING
	changeblock 34, 8, $36
	refreshmap
	writetext MagnetTunnelInsideMachineText2
	waitbutton
	closetext
	playsound SFX_THUNDERSHOCK
	earthquake 15
	applymovement MAGNETTUNNELINSIDE_STONE_4, .StoneMovement1
	playsound SFX_THUNDERSHOCK
	earthquake 15
	playsound SFX_STRENGTH
	changeblock 34, 6, $35
	refreshmap
	disappear MAGNETTUNNELINSIDE_STONE_4
	scall MagnetTunnelAlarmSounds
	showemote EMOTE_QUESTION, PLAYER, 15
	opentext
	writetext MagnetTunnelInsideMachineText4
	waitbutton
	closetext
	end

.StoneMovement1:
	fix_facing
	slow_slide_step_down
	slow_slide_step_down
	slow_slide_step_left
	remove_fixed_facing
	step_end

.MachineOn:
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_IN_PIT
	iftrue_jumptext MagnetTunnelInsideMachineText7
	scall MagnetTunnelAlarmSounds
	opentext
	writetext MagnetTunnelInsideMachineText5
	yesorno
	iffalse_endtext
	playsound SFX_GLASS_TING
	writetext MagnetTunnelInsideMachineText6
	waitbutton
	closetext
	changeblock 34, 8, $70
	changeblock 34, 6, $34
	refreshmap
	moveobject MAGNETTUNNELINSIDE_STONE_4, 34, 7
	appear MAGNETTUNNELINSIDE_STONE_4
	playsound SFX_EMBER
	earthquake 15
	applymovement MAGNETTUNNELINSIDE_STONE_4, .StoneMovement2
	playsound SFX_STRENGTH
	earthquake 15
	changeblock 34, 4, $68
	refreshmap
	disappear MAGNETTUNNELINSIDE_STONE_4
	setevent EVENT_MAGNET_TUNNEL_LODESTONE_IN_PIT
	end

.StoneMovement2:
	fix_facing
	slide_step_up
	slide_step_up
	remove_fixed_facing
	step_end

MagnetTunnelAlarmSounds:
	waitsfx
	special SaveMusic
	playmusic MUSIC_NONE
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
	waitsfx
	special RestoreMusic
	end

MagnetTunnelInsideMachineText1:
	text "The machine is"
	line "powered off."

	para "Turn it on?"
	done

MagnetTunnelInsideMachineText2:
	text "Ping! The machine"
	line "powered on."
	done

MagnetTunnelInsideMachineText3:
	text "The machine is"
	line "running smoothly."
	done

MagnetTunnelInsideMachineText4:
	text "Huh?! Something's"
	line "wrong!"
	done

MagnetTunnelInsideMachineText5:
	text "This machine isn't"
	line "running properly!"

	para "Multiple WARNING"
	line "messages rapidly"

	para "flash across the"
	line "small screen and"

	para "a burning smell"
	line "fills the air."

	para "Hit the emergency"
	line "shutdown button?"
	done

MagnetTunnelInsideMachineText6:
	text "Ding! The machine"
	line "powered off."
	done

MagnetTunnelInsideMachineText7:
	text "The machine is"
	line "surrounded by the"

	para "faint stench of"
	line "melted plastic…"

	para "It appears to be"
	line "totally fried."
	done

MagnetTunnelInsideLodestoneText:
	text "The lodestone is"
	line "smooth and warm."

	para "It has a faint"
	line "aura of static."
	done

MagnetTunnelInsideEngineerText1:
	text "The lodestone here"
	line "gives off a strong"
	cont "magnetic field."

	para "We had to bring in"
	line "specialized equip-"

	para "ment to complete"
	line "this tunnel by the"
	cont "foreman's deadline."

	para "Our team was under"
	line "heavy pressure to"
	cont "deliver on time."
	done

MagnetTunnelInsideEngineerText2:
	text "Since the day we"
	line "began construction"

	para "on this tunnel,"
	line "the number of wild"

	para "Electric-type"
	line "#mon here has"
	cont "more than doubled."
	done

MagnetTunnelInsideScientistText:
	text "Every day, more"
	line "Magnemite arrive"
	cont "and cause issues."

	para "The foreman thinks"
	line "they must be drawn"

	para "to the lodestone's"
	line "unique magnetic"
	cont "properties."

	para "I wonder why?"
	done

GenericTrainerEngineerGraden:
	generictrainer ENGINEER, GRADEN, EVENT_BEAT_ENGINEER_GRADEN, .SeenText, .BeatenText

	text "I'm the foreman"
	line "on this jobsite."

	para "We dug out this"
	line "tunnel to make a"

	para "path for the new"
	line "Magnet Train"
	cont "railway, but…"

	para "Little did I know,"
	line "all of the lode-"

	para "stone would cause"
	line "so much headache!"
	done

.SeenText:
	text "Admiring all of"
	line "our handiwork?"

	para "Haha!"
	line "Admire this!"
	done

.BeatenText:
	text "Haha! You've got"
	line "guts. I like that!"
	done

GenericTrainerEngineerGustav:
	generictrainer ENGINEER, GUSTAV, EVENT_BEAT_ENGINEER_GUSTAV, .SeenText, .BeatenText

	text "I've tried to fix"
	line "it, but its been"
	cont "no use…"

	para "I can't seem to"
	line "figure out what's"
	cont "going on!"

	para "I'm worried if I"
	line "turn it on again,"

	para "the machine will"
	line "short-circuit and"
	cont "be kaput…"
	done

.SeenText:
	text "Stand back!"

	para "This machine has"
	line "been on the fritz!"
	done

.BeatenText:
	text "Blown out! Just"
	line "like a fuse…"
	done

GenericTrainerEngineerNicolas:
	generictrainer ENGINEER, NICOLAS, EVENT_BEAT_ENGINEER_NICOLAS, .SeenText, .BeatenText

	text "These things can"
	line "generate some"
	cont "serious voltage!"

	para "When powered on,"
	line "they create an"

	para "extremely strong"
	line "magnetic field."

	para "So be careful in"
	line "here, alright kid?"
	done

.SeenText:
	text "Hey! Be careful"
	line "around the equip-"
	cont "ment kid!"
	done

.BeatenText:
	text "Shutdown!"
	done
