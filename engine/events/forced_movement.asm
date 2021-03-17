Script_ForcedMovement::
	readvar VAR_FACING
	ifequal DOWN, .down
	ifequal UP, .up
	ifequal LEFT, .left
	ifequal RIGHT, .right
	end

.up
	applymovement PLAYER, .MovementData_up
	end

.down
	applymovement PLAYER, .MovementData_down
	end

.right
	applymovement PLAYER, .MovementData_right
	end

.left
	applymovement PLAYER, .MovementData_left
	end

.MovementData_up:
	step_dig 16
	turn_in_down
	step_dig 16
	turn_head_down
	step_end

.MovementData_down:
	step_dig 16
	turn_in_up
	step_dig 16
	turn_head_up
	step_end

.MovementData_right:
	step_dig 16
	turn_in_left
	step_dig 16
	turn_head_left
	step_end

.MovementData_left:
	step_dig 16
	turn_in_right
	step_dig 16
	turn_head_right
	step_end
