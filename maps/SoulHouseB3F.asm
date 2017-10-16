SoulHouseB3F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SoulHouseB3F_MapEventHeader:

.Warps: db 1
	warp_def 4, 3, 3, SOUL_HOUSE_B2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_GRAMPS, 13, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SoulHouseB3FMrFujiScript, EVENT_GOT_SILPHSCOPE2_FROM_MR_FUJI
	itemball_event 9, 6, ESCAPE_ROPE, 1, EVENT_SOUL_HOUSE_B3F_ESCAPE_ROPE

const_value set 1
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
	if_equal RIGHT, .GoAround
	applymovement SOULHOUSEB3F_MRFUJI, .LeaveMovement
	jump .Finish
.GoAround
	applymovement SOULHOUSEB3F_MRFUJI, .GoAroundMovement1
	spriteface PLAYER, UP
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
