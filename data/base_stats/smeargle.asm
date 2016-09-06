	db SMEARGLE ; 235

if DEF(FAITHFUL)
	db  55,  20,  35,  75,  20,  45
	;   hp  atk  def  spd  sat  sdf
else
	db  65,  75,  65,  95,  75,  65
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, NORMAL
	db 45 ; catch rate
	db 106 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm
	; end
