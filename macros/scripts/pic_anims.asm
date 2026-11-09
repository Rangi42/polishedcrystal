DEF pending_anim_byte = 0
DEF pic_anim_len = 0

MACRO frame
	DEF pic_anim_len += 1
	DEF idx = \1
	DEF duration = \2
	assert idx <= PIC_ANIM_PARAM_MASK, "frame index is too large: {d:idx}"
	assert duration <= LOW(~PIC_ANIM_END_MASK), "frame duration is too large: {d:duration}"
	if pending_anim_byte
		db pending_anim_byte
	endc
	if duration == IMPLICIT_FRAME_DURATION
		DEF pending_anim_byte = PIC_ANIM_IMPLICITFRAME_CMD | idx
	else
		db PIC_ANIM_FRAME_CMD | idx
		DEF pending_anim_byte = duration
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
	DEF n = \1 ; amount of times to repeat
	assert n <= PIC_ANIM_PARAM_MASK, "setrepeat amount is too large: {d:n}"
	if pending_anim_byte
		db pending_anim_byte
	endc
	DEF pending_anim_byte = PIC_ANIM_SETREPEAT_CMD | n
ENDM

	const dorepeat_command ; $fd
MACRO dorepeat
	DEF pic_anim_len += 1
	DEF n = \1 ; command offset to jump to
	assert n <= PIC_ANIM_PARAM_MASK, "dorepeat offset is too large: {d:n}"
	if pending_anim_byte
		db pending_anim_byte
	endc
	DEF pending_anim_byte = PIC_ANIM_DOREPEAT_CMD | n
ENDM
