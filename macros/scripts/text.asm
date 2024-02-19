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

MACRO text_ram
	db "<RAM>"
	dw \1
ENDM

MACRO text_promptbutton
	db "<WAIT>"
ENDM

MACRO text_asm
	db "<ASM>"
ENDM

MACRO text_decimal
	db "<NUM>"
	dw \1 ; address
	dn \2, \3 ; bytes, digits
ENDM

MACRO text_pause
	db "<PAUSE>"
ENDM

MACRO text_sound
	db "<SOUND>"
	db \1 ; sfx
ENDM

MACRO text_today
	db "<DAY>"
ENDM

MACRO text_far
	db "<FAR>"
	dw \1
	db BANK(\1)
ENDM

MACRO text_end
	db "@"
ENDM
