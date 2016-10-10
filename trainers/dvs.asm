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
	;   HP  Def  SAt
	;  Atk  Spd  SDf
	db $FF, $FF, $FF ; kay
	db $FF, $FF, $FF ; cal
	db $CC, $CC, $CC ; falkner
	db $CC, $CC, $CC ; bugsy
	db $DD, $DD, $DD ; whitney
	db $DD, $DD, $DD ; morty
	db $EE, $EE, $EE ; chuck
	db $EE, $EE, $EE ; jasmine
	db $FF, $FF, $FF ; pryce
	db $FF, $FF, $FF ; clair
	db $FF, $FF, $FF ; will
	db $FF, $FF, $FF ; koga
	db $FF, $FF, $FF ; bruno
	db $FF, $FF, $FF ; karen
	db $FF, $FF, $FF ; champion
	db $FF, $FF, $FF ; brock
	db $FF, $FF, $FF ; misty
	db $FF, $FF, $FF ; lt surge
	db $FF, $FF, $FF ; erika
	db $FF, $FF, $FF ; janine
	db $FF, $FF, $FF ; sabrina
	db $FF, $FF, $FF ; blaine
	db $FF, $FF, $FF ; blue
	db $FF, $FF, $FF ; red
	db $FF, $FF, $FF ; leaf
	db $FF, $FF, $FF ; rival1
	db $FF, $FF, $FF ; rival2
	db $66, $66, $66 ; youngster
	db $66, $66, $66 ; bug catcher
	db $77, $77, $77 ; camper
	db $77, $77, $77 ; picnicker
	db $88, $88, $88 ; twins
	db $88, $88, $88 ; fisher
	db $88, $88, $88 ; bird keeper
	db $99, $99, $99 ; hiker
	db $AA, $AA, $AA ; gruntm
	db $AA, $AA, $AA ; gruntf
	db $BB, $B8, $BB ; jessie&james
	db $AA, $AA, $AA ; pokefanm
	db $AA, $AA, $AA ; pokefanf
	db $DD, $BB, $DB ; officerm
	db $7B, $DB, $FF ; officerf
	db $BB, $BB, $BB ; pokemaniac
	db $BB, $BB, $BB ; super nerd
	db $BB, $BB, $BB ; lass
	db $CC, $CC, $CC ; beauty
	db $CC, $CC, $CC ; firebreather
	db $CC, $CC, $CC ; juggler
	db $CC, $CC, $CC ; schoolboy
	db $CC, $CC, $CC ; schoolgirl
	db $AA, $CC, $EE ; psychic
	db $AA, $CC, $EE ; hex maniac
	db $CC, $CC, $CC ; sage
	db $CC, $CC, $CC ; medium
	db $DD, $DD, $DD ; kimono girl
	db $DD, $DD, $DD ; elder
	db $CC, $CC, $CC ; sr&jr
	db $CC, $CC, $CC ; couple
	db $CC, $CC, $CC ; gentleman
	db $CC, $CC, $CC ; rich boy
	db $DD, $DD, $DD ; breeder
	db $CC, $CC, $CC ; cowgirl
	db $CC, $CC, $CC ; sailor
	db $CC, $CC, $CC ; swimmerm
	db $CC, $CC, $CC ; swimmerf
	db $DD, $DD, $DD ; burglar
	db $DD, $DD, $DD ; pi
	db $DD, $DD, $DD ; scientist
	db $DD, $DD, $DD ; boarder
	db $DD, $DD, $DD ; skier
	db $FF, $DD, $DD ; blackbelt
	db $FF, $DD, $DD ; battle girl
	db $DF, $DF, $DD ; dragon tamer
	db $DD, $DD, $DD ; teacher
	db $DD, $DD, $DD ; guitaristm
	db $DD, $DD, $DD ; guitaristf
	db $DD, $DD, $DD ; biker
	db $DD, $DD, $DD ; roughneck
	db $EE, $EE, $EE ; cooltrainerm
	db $EE, $EE, $EE ; cooltrainerf
	db $EE, $EE, $EE ; ace duo
	db $FF, $FF, $FF ; veteranm
	db $FF, $FF, $FF ; veteranf
	db $CC, $CC, $CC ; proton
	db $DD, $DD, $DD ; petrel
	db $FF, $FF, $FF ; archer
	db $EE, $EE, $EE ; ariana
	db $FF, $FF, $FF ; pokemon prof
	db $FF, $FF, $FF ; mysticalman
	db $BB, $BB, $BB ; lyra
	db $FF, $FF, $FF ; lorelei
	db $FF, $FF, $FF ; agatha
	db $EE, $EE, $EE ; yellow
	db $EE, $EE, $EE ; walker
	db $FF, $FF, $FF ; bill
	db $FF, $FF, $FF ; lawrence
	db $FF, $FF, $FF ; giovanni
	db $FF, $FF, $FF ; steven
	db $FF, $FF, $FF ; cynthia
	db $FF, $FF, $FF ; towertycoon
	db $FF, $FF, $FF ; valerie
	db $EE, $EE, $EE ; rei
	db $00, $00, $00 ; omastar fossil
	db $00, $00, $00 ; kabutops fossil
	db $00, $00, $00 ; aerodactyl fossil
	db $00, $00, $00 ; meteorite
; 2715c

INCLUDE "trainers/unique_dvs.asm"
