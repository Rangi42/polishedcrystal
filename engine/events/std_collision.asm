CheckFacingTileForStdScript::
; Checks to see if the tile you're facing has a std script associated with it.  If so, executes the script and returns carry.
	ld a, c
	ld de, 3
	ld hl, TileCollisionStdScripts
	call IsInArray
	jr nc, .notintable

	ld a, jumpstd_command
	ld [wJumpStdScriptBuffer], a
	inc hl
	ld a, [hli]
	ld [wJumpStdScriptBuffer + 1], a
	ld a, [hli]
	ld [wJumpStdScriptBuffer + 2], a
	ld a, BANK(.JumpStdFromRAMScript)
	ld hl, .JumpStdFromRAMScript
	call CallScript
	scf
	ret

.notintable
	xor a
	ret

.JumpStdFromRAMScript:
	jump wJumpStdScriptBuffer

INCLUDE "data/events/collision_std_scripts.asm"
