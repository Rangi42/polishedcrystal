GetTrainerDVs: ; 270c4
; Return the DVs of OtherTrainerClass in bc

	push hl
	ld a, [OtherTrainerClass]
	dec a
	ld c, a
	ld b, 0

	ld hl, TrainerClassDVs
rept 2
	add hl, bc
endr

	ld a, [hli]
	ld b, a
	ld c, [hl]

	pop hl
	ret
; 270d6

TrainerClassDVs: ; 270d6
	;  Atk  Spd
	;  Def  Spc
	db $FF, $FF ; falkner
	db $FF, $FF ; bugsy
	db $FF, $FF ; whitney
	db $FF, $FF ; morty
	db $FF, $FF ; pryce
	db $7F, $FF ; jasmine
	db $FF, $FF ; chuck
	db $7F, $FF ; clair
	db $FF, $FF ; rival1
	db $FF, $FF ; pokemon prof
	db $FE, $EE ; will (hidden power fighting)
	db $FF, $FF ; cal
	db $FF, $FF ; bruno
	db $7F, $FF ; karen
	db $FF, $FF ; koga
	db $FF, $FF ; champion
	db $FF, $FF ; brock
	db $7F, $FF ; misty
	db $FF, $FF ; lt surge
	db $98, $88 ; scientist
	db $7F, $FF ; erika
	db $98, $88 ; youngster
	db $98, $88 ; schoolboy
	db $98, $88 ; bird keeper
	db $58, $88 ; lass
	db $7F, $FF ; janine
	db $FF, $FF ; cooltrainerm
	db $7F, $FF ; cooltrainerf
	db $69, $C8 ; beauty
	db $9F, $FF ; pokemaniac
	db $D8, $A8 ; gruntm
	db $98, $88 ; gentleman
	db $98, $88 ; skier
	db $68, $88 ; teacher
	db $7F, $FF ; sabrina
	db $98, $88 ; bug catcher
	db $98, $88 ; fisher
	db $98, $88 ; swimmerm
	db $78, $88 ; swimmerf
	db $98, $88 ; sailor
	db $98, $88 ; super nerd
	db $FF, $FF ; rival2
	db $98, $88 ; guitarist
	db $A8, $88 ; hiker
	db $98, $88 ; biker
	db $FF, $FF ; blaine
	db $98, $88 ; burglar
	db $98, $88 ; firebreather
	db $98, $88 ; juggler
	db $98, $88 ; blackbelt
	db $DF, $FF ; executivem
	db $98, $88 ; psychic
	db $6A, $A8 ; picnicker
	db $98, $88 ; camper
	db $7F, $FF ; executivef
	db $98, $88 ; sage
	db $78, $88 ; medium
	db $98, $88 ; boarder
	db $98, $88 ; pokefanm
	db $6F, $FF ; kimono girl
	db $68, $A8 ; twins
	db $6D, $88 ; pokefanf
	db $FF, $FF ; red
	db $FF, $FF ; blue
	db $98, $88 ; officer
	db $7E, $A8 ; gruntf
	db $9F, $FF ; mysticalman
; 2715c
