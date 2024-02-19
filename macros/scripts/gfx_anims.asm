; pic + oam animations

MACRO frame
	db \1
	def x = \2
	for i, 3, _NARG + 1
		redef x |= 1 << (\<i> + 1)
	endr
	db x
ENDM

	const_def $fc

	const delanim_command ; $fc
MACRO delanim ; used for oam
	db delanim_command
ENDM

	const dorepeat_command ; $fd
MACRO dorepeat
	db dorepeat_command
	db \1 ; #
ENDM

	const setrepeat_command ; $fe
MACRO setrepeat
	db setrepeat_command
	db \1 ; #
ENDM

	const endanim_command ; $ff
MACRO endanim
	db endanim_command
ENDM

const_value = $fe

	const dorestart_command ; $fe
MACRO dorestart ; used for oam
	db dorestart_command
ENDM
