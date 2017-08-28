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
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; carrie
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; cal
	db 252, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; falkner
	db 252, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; bugsy
	db 252, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; whitney
	db 252, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; morty
	db 252, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; chuck
	db 252, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; jasmine
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; pryce
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; clair
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; will
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; koga
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; bruno
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; karen
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; champion
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; brock
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; misty
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; lt surge
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; erika
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; janine
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; sabrina
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; blaine
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; blue
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; red
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; leaf
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; rival0
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; rival1
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; rival2
	db   0, $BB, $BB, $BB, ABILITY_1 | QUIRKY, FEMALE ; lyra1
	db 252, $BB, $BB, $BB, ABILITY_1 | QUIRKY, FEMALE ; lyra2
	db   0, $66, $66, $66, ABILITY_1 | QUIRKY, MALE   ; youngster
	db   0, $66, $66, $66, ABILITY_1 | QUIRKY, MALE   ; bug catcher
	db   8, $77, $77, $77, ABILITY_1 | QUIRKY, MALE   ; camper
	db   8, $77, $77, $77, ABILITY_1 | QUIRKY, FEMALE ; picnicker
	db  16, $88, $88, $88, ABILITY_1 | QUIRKY, FEMALE ; twins
	db  16, $88, $88, $88, ABILITY_1 | QUIRKY, MALE   ; fisher
	db  16, $88, $88, $88, ABILITY_1 | QUIRKY, MALE   ; bird keeper
	db  24, $99, $99, $99, ABILITY_1 | QUIRKY, MALE   ; hiker
	db  32, $AA, $AA, $AA, ABILITY_1 | QUIRKY, MALE   ; gruntm
	db  32, $AA, $AA, $AA, ABILITY_1 | QUIRKY, FEMALE ; gruntf
	db  32, $AA, $AA, $AA, ABILITY_1 | QUIRKY, MALE   ; pokefanm
	db  32, $AA, $AA, $AA, ABILITY_1 | QUIRKY, FEMALE ; pokefanf
	db  48, $DD, $BB, $DB, ABILITY_1 | QUIRKY, MALE   ; officerm
	db  48, $7B, $DB, $FF, ABILITY_1 | QUIRKY, FEMALE ; officerf
	db  48, $E5, $FA, $D6, ABILITY_1 | QUIRKY, FEMALE ; nurse
	db  40, $BB, $BB, $BB, ABILITY_1 | QUIRKY, MALE   ; pokemaniac
	db  40, $BB, $BB, $BB, ABILITY_1 | QUIRKY, FEMALE ; cosplayer
	db  40, $BB, $BB, $BB, ABILITY_1 | QUIRKY, MALE   ; super nerd
	db  40, $BB, $BB, $BB, ABILITY_1 | QUIRKY, FEMALE ; lass
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; beauty
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; bug maniac
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; ruin maniac
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; firebreather
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; juggler
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; schoolboy
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; schoolgirl
	db  48, $AA, $CC, $EE, ABILITY_1 | QUIRKY, MALE   ; psychic
	db  48, $AA, $CC, $EE, ABILITY_1 | QUIRKY, FEMALE ; hex maniac
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; sage
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; medium
	db  56, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; kimono girl
	db  56, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; elder
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; sr&jr
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; couple
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; gentleman
	db 100, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; rich boy (high EVs from vitamins)
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; lady
	db  56, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; breeder (low EVs due to breeding)
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; baker
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; cowgirl
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; sailor
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; swimmerm
	db  48, $CC, $CC, $CC, ABILITY_1 | QUIRKY, FEMALE ; swimmerf
	db  56, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; burglar
	db  56, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; pi
	db  56, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; scientist
	db  56, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; rocket scientist
	db  56, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; boarder
	db  56, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; skier
	db  64, $FF, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; blackbelt
	db  64, $FF, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; battle girl
	db  72, $DF, $DF, $DD, ABILITY_1 | QUIRKY, MALE   ; dragon tamer
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; engineer
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; teacher
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; guitaristm
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; guitaristf
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; biker
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; roughneck
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; tamer
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; artist
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; aroma lady
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; waitress
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; sightseerm
	db  72, $DD, $DD, $DD, ABILITY_1 | QUIRKY, FEMALE ; sightseerf
	db  72, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; sightseers
	db  64, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; cooltrainerm
	db  64, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; cooltrainerf
	db  72, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; ace duo
	db 128, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; veteranm
	db 128, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; veteranf
	db  80, $CC, $CC, $CC, ABILITY_1 | QUIRKY, MALE   ; proton
	db  96, $DD, $DD, $DD, ABILITY_1 | QUIRKY, MALE   ; petrel
	db 128, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; archer
	db 112, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; ariana
	db 160, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; giovanni
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; prof oak
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; prof elm
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; prof ivy
	db  88, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; mysticalman
	db  88, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; karate king
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; towertycoon
	db  88, $BB, $B8, $BB, ABILITY_1 | QUIRKY, MALE   ; jessie&james
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; lorelei
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; agatha
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; steven
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; cynthia
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; inver
	db 192, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; cheryl
	db 192, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; riley
	db 192, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; buck
	db 192, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; marley
	db 192, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; mira
	db 192, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; anabel
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; darach
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; caitlin
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; candela
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; blanche
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; spark
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; flannery
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; maylene
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; skyla
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, FEMALE ; valerie
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; kukui
	db 192, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; victor
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; bill
	db 252, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; yellow
	db 252, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; walker
	db 192, $EE, $EE, $EE, ABILITY_1 | QUIRKY, MALE   ; imakuni
	db 252, PERFECT_DVS,   ABILITY_1 | QUIRKY, MALE   ; lawrence
	db 252, $EE, $EE, $EE, ABILITY_1 | QUIRKY, FEMALE ; rei
; 2715c
