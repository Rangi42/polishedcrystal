text_start EQUS "db \"<START>\"" ; Enter text writing mode.
text   EQUS "db "             ; Start writing text.
next1  EQUS "db \"<LNBRK>\"," ; Move one screen row down.
next   EQUS "db \"<NEXT>\","  ; Move one line down (two rows).
line   EQUS "db \"<LINE>\","  ; Start writing at the bottom line.
cont   EQUS "db \"<CONT>\","  ; Scroll to the next line.
para   EQUS "db \"<PARA>\","  ; Start a new paragraph.
done   EQUS "db \"<DONE>\""   ; End a text box.
prompt EQUS "db \"<PROMPT>\"" ; Prompt the player to end a text box (initiating some other event).
page   EQUS "db \"@\","       ; Start a new Pokedex page.

text_ram: MACRO
	db "<RAM>"
	dw \1
ENDM

text_promptbutton: MACRO
	db "<WAIT>"
ENDM

text_asm: MACRO
	db "<ASM>"
ENDM

text_decimal: MACRO
	db "<NUM>"
	dw \1 ; address
	dn \2, \3 ; bytes, digits
ENDM

text_pause: MACRO
	db "<PAUSE>"
ENDM

text_sound: MACRO
	db "<SOUND>"
	db \1 ; sfx
ENDM

text_today: MACRO
	db "<DAY>"
ENDM

text_far: MACRO
	db "<FAR>"
	dw \1
	db BANK(\1)
ENDM

text_end: MACRO
	db "@"
ENDM
