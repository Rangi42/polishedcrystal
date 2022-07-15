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
	bg_event 34,  9, BGEVENT_UP, MagnetTunnelInsideMachine4
	bg_event 35,  9, BGEVENT_UP, MagnetTunnelInsideMachine4
	bg_event 38, 30, BGEVENT_ITEM + METAL_POWDER, EVENT_MAGNET_TUNNEL_HIDDEN_METAL_POWDER

	def_object_events
	object_event  3, 10, SPRITE_N64, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_COMMAND, jumptext, MagnetTunnelInsideLodestoneText, EVENT_MAGNET_TUNNEL_LODESTONE_1
	object_event 20, 23, SPRITE_N64, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_COMMAND, jumptext, MagnetTunnelInsideLodestoneText, EVENT_MAGNET_TUNNEL_LODESTONE_2
	object_event 20,  5, SPRITE_N64, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_COMMAND, jumptext, MagnetTunnelInsideLodestoneText, EVENT_MAGNET_TUNNEL_LODESTONE_3
	object_event 31,  8, SPRITE_N64, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_COMMAND, jumptext, MagnetTunnelInsideLodestoneText, EVENT_MAGNET_TUNNEL_LODESTONE_4
	object_event  8, 13, SPRITE_ENGINEER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MagnetTunnelInsideEngineerText1, -1
	object_event 32, 21, SPRITE_ENGINEER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MagnetTunnelInsideEngineerText2, -1
	object_event 22,  8, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerEngineerGraden, -1
	object_event 31, 12, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerEngineerKevin, -1
	object_event 24, 23, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerEngineerCameron, -1
	tmhmball_event 19, 21, TM_GYRO_BALL, EVENT_MAGNET_TUNNEL_TM_GYRO_BALL

	object_const_def
	const MAGNETTUNNELINSIDE_STONE_1
	const MAGNETTUNNELINSIDE_STONE_2
	const MAGNETTUNNELINSIDE_STONE_3
	const MAGNETTUNNELINSIDE_STONE_4

MagnetTunnelInsideTileCallback:
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_1
	iffalse .NoMachine1
	changeblock 6, 10, $6b
	changeblock 6, 8, $6d
.NoMachine1
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_2
	iffalse .NoMachine2
	changeblock 22, 20, $66
.NoMachine2
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_3
	iffalse .NoMachine3
	changeblock 20, 8, $6b
	changeblock 20, 6, $6f
.NoMachine3
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_IN_PIT
	iffalse .NoPit
	changeblock 34, 4, $68
	endcallback
.NoPit
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_4
	iffalse .NoMachine4
	changeblock 34, 8, $66
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
	reloadmappart
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
	reloadmappart
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
	reloadmappart
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
	reloadmappart
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
	reloadmappart
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
	reloadmappart
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
	iftrue .MachineOn
	opentext
	writetext MagnetTunnelInsideMachineText1
	yesorno
	iffalse_endtext
	playsound SFX_GLASS_TING
	changeblock 34, 8, $67
	reloadmappart
	writetext MagnetTunnelInsideMachineText2
	waitbutton
	closetext
	playsound SFX_THUNDERSHOCK
	earthquake 15
	applymovement MAGNETTUNNELINSIDE_STONE_4, .StoneMovement1
	playsound SFX_THUNDERSHOCK
	earthquake 15
	playsound SFX_STRENGTH
	changeblock 34, 8, $66
	reloadmappart
	disappear MAGNETTUNNELINSIDE_STONE_4
	end

.StoneMovement1:
	fix_facing
	slow_slide_step_right
	slow_slide_step_right
	slow_slide_step_right
	remove_fixed_facing
	step_end

.MachineOn:
	checkevent EVENT_MAGNET_TUNNEL_LODESTONE_IN_PIT
	iftrue_jumptext MagnetTunnelInsideMachineText6
	scall MagnetTunnelAlarmSounds
	opentext
	writetext MagnetTunnelInsideMachineText4
	yesorno
	iffalse_endtext
	playsound SFX_GLASS_TING
	changeblock 34, 8, $65
	reloadmappart
	moveobject MAGNETTUNNELINSIDE_STONE_4, 34, 8
	appear MAGNETTUNNELINSIDE_STONE_4
	writetext MagnetTunnelInsideMachineText5
	waitbutton
	closetext
	playsound SFX_EMBER
	earthquake 15
	applymovement MAGNETTUNNELINSIDE_STONE_4, .StoneMovement2
	playsound SFX_STRENGTH
	earthquake 15
	changeblock 34, 4, $68
	reloadmappart
	disappear MAGNETTUNNELINSIDE_STONE_4
	setevent EVENT_MAGNET_TUNNEL_LODESTONE_IN_PIT
	end

.StoneMovement2:
	fix_facing
	slide_step_up
	slide_step_up
	slide_step_up
	remove_fixed_facing
	step_end

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
	text "The machine is"
	line "running quite"
	cont "erratically."

	para "Multiple WARNING!"
	line "messages continue"
	
	para "to rapidly flash"
	line "across the screen."

	para "Hit the emergency"
	line "shutdown button?"
	done

MagnetTunnelInsideMachineText5:
	text "Ding! The machine"
	line "powered off."
	done

MagnetTunnelInsideMachineText6:
	text "The machine is"
	line "surrounded by the"
	
	para "faint stench of"
	line "melted plastic."

	para "Better be safe and"
	line "not try to turn it"
	cont "back on."
	done

MagnetTunnelAlarmSounds:
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	pause 10
	playsound SFX_LICK
	end

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
	line "heavy pressure from"

	para "the general public"
	line "to deliver on time."
	done

MagnetTunnelInsideEngineerText2:
	text "Ever since we"
	line "began construction"

	para "on this tunnel,"
	line "the number of wild"

	para "Electric-type"
	line "#mon has more"

	para "than doubled with"
	line "the passing of"
	cont "each day."

	para "The foreman thinks"
	line "they must all be"

	para "attracted to the"
	line "lodestone's unique"
	cont "energy field."
	done

GenericTrainerEngineerGraden:
	generictrainer ENGINEER, ENGINEER_GRADEN, EVENT_BEAT_ENGINEER_GRADEN, .SeenText, .BeatenText

	text "I'm the foreman"
	line "on this jobsite."

	para "We dug out this"
	line "tunnel to make a"
	
	para "path for the new"
	line "Magnet Train"
	cont "railway."

	para "Haha! Little did I"
	line "know all of the"

	para "lodestone would"
	line "cause us so much"
	cont "headache!"

	para "Everyday, more and"
	line "more Electric-type"

	para "#mon show up"
	line "and cause delays."

	para "We thought this"
	line "tunnel was for the"
	
	para "Magnet Train, but"
	line "it turned out to"
	
	para "be more like a"
	line "home for magnet"
	cont "#mon! Hahaha!"
	done

.SeenText:
	text "Admiring all of"
	line "our handiwork?"

	para "Haha!"
	line "Admire this!"
	done

.BeatenText:
	text "Haha! You've got"
	line "guts kid."
	done

GenericTrainerEngineerKevin:
	generictrainer ENGINEER, ENGINEER_KEVIN, EVENT_BEAT_ENGINEER_KEVIN, .SeenText, .BeatenText

	para "This machine has"
	line "been acting up as"
	cont "of late."

	para "I've tried to fix"
	line "it, but its been"
	cont "no use…"

	para "I'm worried if I"
	line "turn it on again"

	para "it will short"
	line "circuit and be"
	cont "kaput…"

	para "Don't tell the"
	line "foreman, okay?"

	para "And don't mess with"
	line "it either! Deal?"
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

GenericTrainerEngineerCameron:
	generictrainer ENGINEER, ENGINEER_CAMERON, EVENT_BEAT_ENGINEER_CAMERON, .SeenText, .BeatenText

	text "These things can"
	line "generate some"
	cont "serious power."

	para "When powered on,"
	line "they generate a"

	para "pretty strong"
	line "magnetic field."

	para "That sure comes in"
	line "handy when moving"

	para "large, heavy, and"
	line "magnetic rocks"
	cont "like lodestone."

	para "But they can be"
	line "real dangerous to"
	cont "operate."

	para "So be careful in"
	line "here, alright?"
	done

.SeenText:
	text "Hey! Be careful"
	line "around the"
	cont "machinery kid!"
	done

.BeatenText:
	text "Shutdown!"
	done
