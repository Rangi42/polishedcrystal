; Battle and sprite OAM animations

MACRO battleoamframe
	dw \1 ; oam set
	DEF x = \2
	assert !(x & (1 << (B_OAM_XFLIP + 1) | 1 << (B_OAM_YFLIP + 1))), \
		"oamframe duration overflows into X/Y flip bits"
	if _NARG > 2
		rept _NARG - 2
			DEF x |= 1 << (\3 + 1)
			shift
		endr
	endc
	db x ; duration + flags
ENDM

; For simplicity we will only check
; the upper byte for the Battle oam commands.
DEF battleoamend_command EQU $ffff
MACRO battleoamend
	dw battleoamend_command
ENDM

DEF battleoamrestart_command EQU $feff
MACRO battleoamrestart
	dw battleoamrestart_command
ENDM

DEF battleoamwait_command EQU $fdff
MACRO battleoamwait
	dw battleoamwait_command
	db \1 ; frames
ENDM

DEF battleoamdelete_command  EQU $fcff
MACRO battleoamdelete
	dw battleoamdelete_command
ENDM

MACRO oamframe
	db \1 ; oam set
	DEF x = \2
	assert !(x & (1 << (B_OAM_XFLIP + 1) | 1 << (B_OAM_YFLIP + 1))), \
		"oamframe duration overflows into X/Y flip bits"
	if _NARG > 2
		rept _NARG - 2
			DEF x |= 1 << (\3 + 1)
			shift
		endr
	endc
	db x ; duration + flags
ENDM

	const_def -1, -1

	const oamend_command ; $ff
MACRO oamend
	db oamend_command
ENDM

	const oamrestart_command ; $fe
MACRO oamrestart
	db oamrestart_command
ENDM

	const oamwait_command ; $fd
MACRO oamwait
	db oamwait_command
	db \1 ; frames
ENDM

	const oamdelete_command ; $fc
MACRO oamdelete
	db oamdelete_command
ENDM
