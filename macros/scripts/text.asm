___compressing_text = 0
___ct_bits = 0
___ct_length = 0

text_start EQUS "\n___compressing_text = 0\n db \"<START>\"" ; Enter text writing mode.
text   EQUS "\n___compressing_text = 0\n db " ; Start writing text.
next1  EQUS "dtxt \"<LNBRK>\"," ; Move one screen row down.
next   EQUS "dtxt \"<NEXT>\","  ; Move one line down (two rows).
line   EQUS "dtxt \"<LINE>\","  ; Start writing at the bottom line.
cont   EQUS "dtxt \"<CONT>\","  ; Scroll to the next line.
para   EQUS "dtxt \"<PARA>\","  ; Start a new paragraph.
done   EQUS "dtxt \"<DONE>\""   ; End a text box.
prompt EQUS "dtxt \"<PROMPT>\"" ; Prompt the player to end a text box (initiating some other event).
page   EQUS "dtxt \"@\","       ; Start a new Pokedex page.

dtxt: MACRO
	if !___compressing_text
		db \#
	else
		rept _NARG
			if (\1) > 0 && (\1) < $100
				___dchr \1
			else
				for x, 1, CHARLEN(\1) + 1
					___dchr CHARSUB(\1, x)
				endr
			endc
			shift
		endr
		if !___compressing_text && ___ct_length > 0
			db ___ct_bits << (8 - ___ct_length)
		endc
	endc
ENDM

___dchr: MACRO
	DEF ___chr = \1
	if ___chr < LEAST_CHAR
		fail "encountered {#02X:___chr} byte while processing"
	endc
	DEF ___ct_bits = (___ct_bits << ___huffman_length_{02X:___chr}) | ___huffman_data_{02X:___chr}
	DEF ___ct_length = ___ct_length + ___huffman_length_{02X:___chr}
	rept 3
		if ___ct_length >= 8
			db ___ct_bits >> (___ct_length - 8)
			DEF ___ct_length = ___ct_length - 8
			DEF ___ct_bits = ___ct_bits & ((1 << ___ct_length) - 1)
		endc
	endr
	if ___chr == "@" || ___chr == "<DONE>" || ___chr == "<PROMPT>"
		DEF ___compressing_text = 0
	endc
ENDM

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

ctxt: MACRO
	db "<CTXT>"
___compressing_text = 1
___ct_bits = 0
___ct_length = 0
	dtxt \#
ENDM

text_end: MACRO
	db "@"
ENDM
