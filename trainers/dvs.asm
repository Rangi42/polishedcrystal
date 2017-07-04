GetTrainerEVsDVsAndPersonality: ; 270c4
; Return the EVs, DVs and Personality of OtherTrainerClass in bc
	ld a, [OtherTrainerClass]
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerClassDVsAndPersonality
rept 6
	add hl, bc
endr

	ld a, [hli]
rept 6
	ld [de], a
	inc de
endr
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
	ret
; 270d6

TrainerClassDVsAndPersonality: ; 270d6
	;  EVs  HP   Def  SAt  Ability  Gender
	;  *    Atk  Spd  SDf  Nature   Form
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; kay
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; cal
	db $14, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; falkner
	db $28, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; bugsy
	db $3C, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; whitney
	db $50, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; morty
	db $64, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; chuck
	db $78, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; jasmine
	db $8C, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; pryce
	db $A0, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; clair
	db $B4, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; will
	db $C8, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; koga
	db $DC, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; bruno
	db $F0, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; karen
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; champion
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; brock
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; misty
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; lt surge
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; erika
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; janine
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; sabrina
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; blaine
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; blue
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; red
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; leaf
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; rival0
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; rival1
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; rival2
	db $00, $BB, $BB, $BB, ABILITY_1 | QUIRKY, FEMALE ; lyra1
	db $FF, $BB, $BB, $BB, ABILITY_1 | QUIRKY, FEMALE ; lyra2
	db $00, $66, $66, $66, ABILITY_1 | QUIRKY, MALE   ; youngster
	db $00, $66, $66, $66, ABILITY_1 | QUIRKY, MALE   ; bug catcher
	db $08, $77, $77, $77, ABILITY_1 | QUIRKY, MALE   ; camper
	db $08, $77, $77, $77, ABILITY_1 | QUIRKY, FEMALE ; picnicker
	db $10, $88, $88, $88, ABILITY_1 | QUIRKY, FEMALE ; twins
	db $10, $88, $88, $88, ABILITY_1 | QUIRKY, MALE   ; fisher
	db $10, $88, $88, $88, ABILITY_1 | QUIRKY, MALE   ; bird keeper
	db $18, $99, $99, $99, ABILITY_1 | QUIRKY, MALE   ; hiker
	db $20, $AA, $AA, $AA, ABILITY_1 | QUIRKY, MALE   ; gruntm
	db $20, $AA, $AA, $AA, ABILITY_1 | QUIRKY, FEMALE ; gruntf
	db $20, $AA, $AA, $AA, ABILITY_1 | QUIRKY, MALE   ; pokefanm
	db $20, $AA, $AA, $AA, ABILITY_1 | QUIRKY, FEMALE ; pokefanf
	db $28, $DD, $BB, $DB, ABILITY_1 | QUIRKY, MALE   ; officerm
	db $28, $7B, $DB, $FF, ABILITY_1 | QUIRKY, FEMALE ; officerf
	db $28, $BB, $BB, $BB, ABILITY_1 | QUIRKY, MALE   ; pokemaniac
	db $28, $BB, $BB, $BB, ABILITY_1 | QUIRKY, FEMALE ; cosplayer
	db $28, $BB, $BB, $BB, ABILITY_1 | QUIRKY, MALE   ; super nerd
	db $28, $BB, $BB, $BB, ABILITY_1 | QUIRKY, FEMALE ; lass
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; beauty
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; bug maniac
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; ruin maniac
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; firebreather
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; juggler
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; schoolboy
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; schoolgirl
	db $30, $AA, $CC, $EE, ABILITY_1 | QUIRKY, MALE   ; psychic
	db $30, $AA, $CC, $EE, ABILITY_1 | QUIRKY, FEMALE ; hex maniac
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; sage
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; medium
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; kimono girl
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; elder
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; sr&jr
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; couple
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; gentleman
	db $64, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; rich boy -- high EVs from vitamins
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; lady
	db $10, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; breeder -- low EVs due to breeding
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; baker
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; cowgirl
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; sailor
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; swimmerm
	db $30, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; swimmerf
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; burglar
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; pi
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; scientist
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; rocket scientist
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; boarder
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; skier
	db $40, $FF, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; blackbelt
	db $40, $FF, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; battle girl
	db $40, $DF, $DF, $DD, ABILITY_1 | QUIRKY, MALE   ; dragon tamer
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; engineer
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; teacher
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; guitaristm
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; guitaristf
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; biker
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; roughneck
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; tamer
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; artist
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; aroma lady
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; sightseerm
	db $38, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; sightseerf
	db $40, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; sightseers
	db $60, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; cooltrainerm
	db $60, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; cooltrainerf
	db $60, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; ace duo
	db $80, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; veteranm
	db $80, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; veteranf
	db $60, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; proton
	db $80, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; petrel
	db $C0, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; archer
	db $A0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; ariana
	db $A0, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; giovanni
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; prof oak
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; prof elm
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; prof ivy
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; mysticalman
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; karate king
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; towertycoon
	db $60, $BB, $B8, $BB, ABILITY_1 | QUIRKY, MALE   ; jessie&james
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; lorelei
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; agatha
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; steven
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; cynthia
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; inver
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; cheryl
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; riley
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; buck
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; marley
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; mira
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; anabel
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; darach
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; caitlin
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; candela
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; blanche
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; spark
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; flannery
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; maylene
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; skyla
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; valerie
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; victor
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; bill
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; yellow
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; walker
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; imakuni
	db $FF, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; lawrence
	db $C0, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; rei
; 2715c
