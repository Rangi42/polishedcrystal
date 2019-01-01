SoulHouseB3F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  3,  4, SOUL_HOUSE_B2F, 3

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  4, 13, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, SoulHouseB3FMrFujiScript, EVENT_GOT_SILPHSCOPE2_FROM_MR_FUJI
	itemball_event  6,  9, ESCAPE_ROPE, 1, EVENT_SOUL_HOUSE_B3F_ESCAPE_ROPE

	const_def 1 ; object constants
	const SOULHOUSEB3F_MRFUJI

SoulHouseB3FMrFujiScript:
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem SILPHSCOPE2
	setflag ENGINE_HAVE_SILPHSCOPE2
	setevent EVENT_GOT_SILPHSCOPE2_FROM_MR_FUJI
	writetext .Text2
	waitbutton
	closetext
	checkcode VAR_FACING
	ifequal RIGHT, .GoAround
	applymovement SOULHOUSEB3F_MRFUJI, .LeaveMovement
	jump .Finish
.GoAround
	applymovement SOULHOUSEB3F_MRFUJI, .GoAroundMovement1
	turnobject PLAYER, UP
	applymovement SOULHOUSEB3F_MRFUJI, .GoAroundMovement2
.Finish
	disappear SOULHOUSEB3F_MRFUJI
	clearevent EVENT_SOUL_HOUSE_MR_FUJI
	end

.Text1:
	text "TODO"
	done

.Text2:
	text "TODO"
	done

.LeaveMovement:
	slow_step_left
	slow_step_left
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	slow_step_up
	step_end

.GoAroundMovement1:
	slow_step_right
	slow_step_right
	slow_step_up
	slow_step_up
	slow_step_left
	slow_step_left
	step_end

.GoAroundMovement2:
	slow_step_up
	slow_step_up
	slow_step_up
	step_end
