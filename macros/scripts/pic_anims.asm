DEF pending_anim_byte = 0
DEF pic_anim_len = 0

MACRO frame
	DEF pic_anim_len += 1
	DEF x = \1 ; index
	DEF y = \2 ; duration
	assert x <= PIC_ANIM_PARAM_MASK, "frame index is too large: {d:x}"
	assert y <= LOW(~PIC_ANIM_END_MASK), "frame duration is too large: {d:y}"
	if pending_anim_byte
		db pending_anim_byte
	endc
	if y == IMPLICIT_FRAME_DURATION
		DEF pending_anim_byte = PIC_ANIM_IMPLICITFRAME_CMD | y
	else
		db PIC_ANIM_FRAME_CMD | x
		DEF pending_anim_byte = y
	endc
ENDM

	const_def -1, -1

	const endanim_command ; $ff
MACRO endanim
	DEF pic_anim_len += 1
	assert pic_anim_len <= MAX_PIC_ANIM_LENGTH, "pic anim is too long: {d:pic_anim_len}"
	db PIC_ANIM_END_MASK | pending_anim_byte
	DEF pending_anim_byte = 0
	DEF pic_anim_len = 0
ENDM

	const setrepeat_command ; $fe
MACRO setrepeat
	DEF pic_anim_len += 1
	DEF x = \1 ; amount of times to repeat
	assert x <= PIC_ANIM_PARAM_MASK, "setrepeat amount is too large: {d:x}"
	if pending_anim_byte
		db pending_anim_byte
	endc
	DEF pending_anim_byte = PIC_ANIM_SETREPEAT_CMD | x
ENDM

	const dorepeat_command ; $fd
MACRO dorepeat
	DEF pic_anim_len += 1
	DEF x = \1 ; command offset to jump to
	assert x <= PIC_ANIM_PARAM_MASK, "dorepeat offset is too large: {d:x}"
	if pending_anim_byte
		db pending_anim_byte
	endc
	DEF pending_anim_byte = PIC_ANIM_DOREPEAT_CMD | x
ENDM
