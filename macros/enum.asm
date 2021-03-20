; Enumerate variables

enum_start: MACRO
if _NARG >= 1
__enum__ = \1
else
__enum__ = 0
endc
if _NARG >= 2
__enumdir__ = \2
else
__enumdir__ = +1
endc
ENDM

enum: MACRO
\1 = __enum__
__enum__ = __enum__ + __enumdir__
ENDM

enum_set: MACRO
__enum__ = \1
ENDM


; Enumerate constants

const_def: MACRO
if _NARG >= 1
const_value = \1
else
const_value = 0
endc
ENDM

const: MACRO
\1 EQU const_value
const_value = const_value + 1
ENDM

shift_const: MACRO
\1 EQU 1 << const_value
	const \1_F
ENDM

const_skip: MACRO
if _NARG >= 1
const_value = const_value + \1
else
const_value = const_value + 1
endc
ENDM

const_next: MACRO
if (const_value > 0 && \1 < const_value) || (const_value < 0 && \1 > const_value)
fail "const_next cannot go backwards from {const_value} to \1"
else
const_value = \1
endc
ENDM

rb_skip: MACRO
if _NARG == 1
rsset _RS + \1
else
rsset _RS + 1
endc
ENDM
