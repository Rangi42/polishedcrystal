INCLUDE "constants.asm"

; These are all the asm constants needed to make the Virtual Console patches.

vc_const: MACRO
x = \1
	println "00:{04x:x} \1" ; same format as rgblink's .sym file
ENDM
