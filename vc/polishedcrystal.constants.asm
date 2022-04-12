INCLUDE "constants.asm"

; These are all the asm constants needed to make the crystal11_vc patch.

vc_const: MACRO
x = \1
	println "00:{04x:x} \1" ; same format as rgblink's .sym file
ENDM

; [fight begin]
	vc_const SCREEN_HEIGHT_PX