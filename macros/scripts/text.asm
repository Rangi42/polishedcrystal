text   EQUS "db \"<START>\"," ; Start writing text.
next   EQUS "db \"<NL>\","    ; Move a line down.
next1  EQUS "db \"<LNBRK>\"," ; Move a line down (without line spacing)
line   EQUS "db \"<LINE>\","  ; Start writing at the bottom line.
page   EQUS "db \"@\","       ; Start a new Pokedex page.
para   EQUS "db \"<PARA>\","  ; Start a new paragraph.
cont   EQUS "db \"<CONT>\","  ; Scroll to the next line.
done   EQUS "db \"<DONE>\""   ; End a text box.
prompt EQUS "db \"<PROMPT>\"" ; Prompt the player to end a text box (initiating some other event).

text_from_ram: MACRO
	db "<RAM>"
	dw \1
ENDM

text_waitbutton: MACRO
	db "<WAIT>"
ENDM

start_asm: MACRO
	db "<ASM>"
ENDM

deciram: MACRO
	db "<NUM>"
	dw \1 ; address
	dn \2, \3 ; bytes, digits
ENDM

interpret_data: MACRO
	db "<EXIT>"
ENDM

sound_item: MACRO
	db "<ITEM>"
ENDM

sound_caught_mon: MACRO
	db "<CAUGHT>"
ENDM

sound_slot_machine_start: MACRO
	db "<SLOTS>"
ENDM

sound_dex_fanfare_50_79: MACRO
	db "<DEX2>"
ENDM

sound_dex_fanfare_80_109: MACRO
	db "<DEX3>"
ENDM

current_day: MACRO
	db "<DAY>"
ENDM

text_jump: MACRO
	db "<FAR>"
	dw \1
	db BANK(\1)
ENDM

text_end: MACRO
	db "@"
ENDM
