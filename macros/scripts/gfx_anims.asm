; pic + oam animations

frame: MACRO
	db \1
	def x = \2
	for i, 3, _NARG + 1
		redef x |= 1 << (\<i> + 1)
	endr
	db x
ENDM

	const_def $fc

	const delanim_command ; $fc
delanim: MACRO ; used for oam
	db delanim_command
ENDM

	const dorepeat_command ; $fd
dorepeat: MACRO
	db dorepeat_command
	db \1 ; #
ENDM

	const setrepeat_command ; $fe
setrepeat: MACRO
	db setrepeat_command
	db \1 ; #
ENDM

	const endanim_command ; $ff
endanim: MACRO
	db endanim_command
ENDM

const_value = $fe

	const dorestart_command ; $fe
dorestart: MACRO ; used for oam
	db dorestart_command
ENDM
