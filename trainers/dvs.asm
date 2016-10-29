GetTrainerDVsAndPersonality: ; 270c4
; Return the DVs and Personality of OtherTrainerClass in bc
	push hl

	call CheckUniqueDVOrPersonalityTrainerPokemon
	jr z, .done

	ld a, [OtherTrainerClass]
	dec a
	ld c, a
	ld b, 0

	ld hl, TrainerClassDVsAndPersonality
rept 5
	add hl, bc
endr

.done
	ld a, [hli]
	ld [DVAndPersonalityBuffer], a
	ld a, [hli]
	ld [DVAndPersonalityBuffer + 1], a
	ld a, [hli]
	ld [DVAndPersonalityBuffer + 2], a
	ld a, [hli]
	ld [DVAndPersonalityBuffer + 3], a
	ld a, [hli]
	ld [DVAndPersonalityBuffer + 4], a

	pop hl
	ret
; 270d6

TrainerClassDVsAndPersonality: ; 270d6
	;  HP   Def  SAt  Ability  Gender
	;  Atk  Spd  SDf  Nature   Form
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; kay
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; cal
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; falkner
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; bugsy
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE | 1 ; whitney
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; morty
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   | 1 ; chuck
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE | 1 ; jasmine
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; pryce
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; clair
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; will
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; koga
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; bruno
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; karen
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; champion
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; brock
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; misty
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; lt surge
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; erika
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; janine
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; sabrina
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; blaine
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; blue
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; red
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; leaf
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; rival1
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; rival2
	db $66, $66, $66, ABILITY_1 | QUIRKY, MALE   | 1 ; youngster
	db $66, $66, $66, ABILITY_1 | QUIRKY, MALE   | 1 ; bug catcher
	db $77, $77, $77, ABILITY_1 | QUIRKY, MALE   | 1 ; camper
	db $77, $77, $77, ABILITY_1 | QUIRKY, FEMALE | 1 ; picnicker
	db $88, $88, $88, ABILITY_1 | QUIRKY, FEMALE | 1 ; twins
	db $88, $88, $88, ABILITY_1 | QUIRKY, MALE   | 1 ; fisher
	db $88, $88, $88, ABILITY_1 | QUIRKY, MALE   | 1 ; bird keeper
	db $99, $99, $99, ABILITY_1 | QUIRKY, MALE   | 1 ; hiker
	db $AA, $AA, $AA, ABILITY_1 | QUIRKY, MALE   | 1 ; gruntm
	db $AA, $AA, $AA, ABILITY_1 | QUIRKY, FEMALE | 1 ; gruntf
	db $BB, $B8, $BB, ABILITY_1 | QUIRKY, MALE   | 1 ; jessie&james
	db $AA, $AA, $AA, ABILITY_1 | QUIRKY, MALE   | 1 ; pokefanm
	db $AA, $AA, $AA, ABILITY_1 | QUIRKY, FEMALE | 1 ; pokefanf
	db $DD, $BB, $DB, ABILITY_1 | QUIRKY, MALE   | 1 ; officerm
	db $7B, $DB, $FF, ABILITY_1 | QUIRKY, FEMALE | 1 ; officerf
	db $BB, $BB, $BB, ABILITY_1 | QUIRKY, MALE   | 1 ; pokemaniac
	db $BB, $BB, $BB, ABILITY_1 | QUIRKY, MALE   | 1 ; super nerd
	db $BB, $BB, $BB, ABILITY_1 | QUIRKY, FEMALE | 1 ; lass
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE | 1 ; beauty
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; firebreather
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; juggler
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; schoolboy
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE | 1 ; schoolgirl
	db $AA, $CC, $EE, ABILITY_1 | QUIRKY, MALE   | 1 ; psychic
	db $AA, $CC, $EE, ABILITY_1 | QUIRKY, FEMALE | 1 ; hex maniac
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; sage
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE | 1 ; medium
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE | 1 ; kimono girl
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; elder
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE | 1 ; sr&jr
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; couple
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; gentleman
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; rich boy
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE | 1 ; breeder
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE | 1 ; cowgirl
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; sailor
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; swimmerm
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE | 1 ; swimmerf
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; burglar
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; pi
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; scientist
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; boarder
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE | 1 ; skier
	db $FF, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; blackbelt
	db $FF, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE | 1 ; battle girl
	db $DF, $DF, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; dragon tamer
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE | 1 ; teacher
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; guitaristm
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE | 1 ; guitaristf
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; biker
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; roughneck
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   | 1 ; cooltrainerm
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE | 1 ; cooltrainerf
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   | 1 ; ace duo
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; veteranm
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; veteranf
	db $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   | 1 ; proton
	db $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   | 1 ; petrel
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; archer
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE | 1 ; ariana
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; pokemon prof
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; mysticalman
	db $BB, $BB, $BB, ABILITY_1 | QUIRKY, FEMALE | 1 ; lyra
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; lorelei
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; agatha
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE | 1 ; yellow
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   | 1 ; walker
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE | 1 ; cheryl
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   | 1 ; riley
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   | 1 ; buck
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE | 1 ; marley
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE | 1 ; mira
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; bill
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; lawrence
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; giovanni
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; steven
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; cynthia
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   | 1 ; towertycoon
	db PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE | 1 ; valerie
	db $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE | 1 ; rei
; 2715c

INCLUDE "trainers/unique_dvs.asm"
