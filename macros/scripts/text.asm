text   EQUS "db \"<START>\"," ; Start writing text.
next   EQUS "db \"<NL>\","    ; Move a line down.
line   EQUS "db \"<LINE>\","  ; Start writing at the bottom line.
page   EQUS "db \"@\","       ; Start a new Pokedex page.
para   EQUS "db \"<PARA>\","  ; Start a new paragraph.
cont   EQUS "db \"<CONT>\","  ; Scroll to the next line.
done   EQUS "db \"<DONE>\""   ; End a text box.
prompt EQUS "db \"<PROMPT>\"" ; Prompt the player to end a text box (initiating some other event).

text_from_ram: macro
	db "<RAM>"
	dw \1
endm

text_bcd: macro
	db "<BCD>"
	dw \1
	db \2
endm

text_move: macro
	db "<MOVE>"
	dw \1
endm

text_box: macro
	db "<BOX>"
	dw \1
	db \2, \3
ENDM

text_low: macro
	db "<LOW>"
endm

text_waitbutton: macro
	db "<WAIT>"
endm

text_scroll: macro
	db "<SCROLL>"
endm

start_asm: macro
	db "<ASM>"
endm

deciram: macro
	db "<NUM>"
	dw \1 ; address
	dn \2, \3 ; bytes, digits
endm

interpret_data: macro
	db "<EXIT>"
endm

sound_dex_fanfare_50_79: macro
	db "<DEX2>"
endm

limited_interpret_data: macro
	db "<DOTS>"
	db \1
endm

link_wait_button: macro
	db "<LINK>"
endm

sound_dex_fanfare_20_49: macro
	db "<DEX1>"
endm

sound_item: macro
	db "<ITEM>"
endm

sound_caught_mon: macro
	db "<CAUGHT>"
endm

sound_dex_fanfare_80_109: macro
	db "<DEX3>"
endm

sound_fanfare: macro
	db "<BEEP>"
endm

sound_slot_machine_start: macro
	db "<SLOTS>"
endm

text_buffer: macro
	db "<BUFFER>"
	db \1
endm

current_day: macro
	db "<DAY>"
endm

text_jump: MACRO
	db "<FAR>"
	dw \1
	db BANK(\1)
ENDM
