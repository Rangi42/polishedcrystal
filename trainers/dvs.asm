GetTrainerDVs: ; 270c4
; Return the DVs of OtherTrainerClass in bc
	push hl

	call CheckUniqueDVTrainerPokemon
	jr z, .done

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

.done
	pop hl
	ret
; 270d6

TrainerClassDVs: ; 270d6
	;  Atk  Spd
	;  Def  Spc
	db $FF, $FF ; kay
	db $FF, $FF ; cal
	db $CC, $CC ; falkner
	db $CC, $CC ; bugsy
	db $7D, $DD ; whitney
	db $DD, $DD ; morty
	db $EE, $EE ; chuck
	db $7E, $EE ; jasmine
	db $FF, $FF ; pryce
	db $7F, $FF ; clair
	db $FF, $FF ; will
	db $FF, $FF ; koga
	db $FF, $FF ; bruno
	db $7F, $FF ; karen
	db $FF, $FF ; champion
	db $FF, $FF ; brock
	db $7F, $FF ; misty
	db $FF, $FF ; lt surge
	db $7F, $FF ; erika
	db $7F, $FF ; janine
	db $7F, $FF ; sabrina
	db $FF, $FF ; blaine
	db $FF, $FF ; blue
	db $FF, $FF ; red
	db $FF, $FF ; leaf
	db $FF, $FF ; rival1
	db $FF, $FF ; rival2
	db $87, $77 ; youngster
	db $88, $F8 ; bug catcher
	db $99, $99 ; camper
	db $59, $99 ; picnicker
	db $59, $99 ; twins
	db $99, $99 ; fisher
	db $99, $F9 ; bird keeper
	db $AF, $7A ; hiker
	db $DA, $AA ; gruntm
	db $7A, $AA ; gruntf
	db $AA, $AA ; jessie&james
	db $AA, $AA ; pokefanm
	db $5A, $AA ; pokefanf
	db $DB, $DB ; officer
	db $FB, $BF ; pokemaniac
	db $FB, $BB ; super nerd
	db $5B, $BB ; lass
	db $5C, $CC ; beauty
	db $CA, $CF ; firebreather
	db $AC, $FC ; juggler
	db $CC, $CC ; schoolboy
	db $7C, $CC ; schoolgirl
	db $BB, $CF ; psychic
	db $7B, $CF ; hex maniac
	db $CC, $CC ; sage
	db $7C, $CC ; medium
	db $6E, $EE ; kimono girl
	db $DD, $DD ; elder
	db $CC, $CC ; gentleman
	db $CC, $CC ; rich boy
	db $7C, $CC ; cowgirl
	db $CC, $CC ; sailor
	db $CC, $CC ; swimmerm
	db $7C, $CC ; swimmerf
	db $FA, $CA ; burglar
	db $CC, $CF ; scientist
	db $DD, $DD ; boarder
	db $7D, $DD ; skier
	db $FD, $DD ; blackbelt
	db $7D, $DD ; battle girl
	db $DD, $DD ; teacher
	db $DD, $DD ; guitaristm
	db $7D, $DD ; guitaristf
	db $DD, $DD ; biker
	db $EE, $EE ; cooltrainerm
	db $7E, $EE ; cooltrainerf
	db $DF, $FF ; executivem
	db $7F, $FF ; executivef
	db $FF, $FF ; pokemon prof
	db $FF, $FF ; game freak
	db $FF, $FF ; mysticalman
	db $7F, $FF ; lyra
	db $7F, $FF ; lorelei
	db $7F, $FF ; agatha
	db $7F, $FF ; yellow
	db $FF, $FF ; bill
	db $FF, $FF ; lawrence
	db $FF, $FF ; giovanni
	db $FF, $FF ; towertycoon
	db $7F, $FF ; valerie
	db $00, $00 ; omastar fossil
	db $00, $00 ; kabutops fossil
	db $00, $00 ; aerodactyl fossil
; 2715c

INCLUDE "trainers/unique_dvs.asm"
