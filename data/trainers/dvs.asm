TrainerClassDVsAndPersonality:
; entries correspond to trainer classes (see constants/trainer_constants.asm)
	table_width 5
	;  EVs  HP   Def  SAt
	;  *    Atk  Spe  SDf  Gender
	db 252, PERFECT_DVS,   FEMALE ; carrie
	db 252, PERFECT_DVS,   MALE   ; cal
	db 252, PERFECT_DVS,   MALE   ; jacky
	db 252, $BB, $BB, $BB, MALE   ; falkner
	db 252, $BB, $BB, $BB, MALE   ; bugsy
	db 252, $CC, $CC, $CC, FEMALE ; whitney
	db 252, $CC, $CC, $CC, MALE   ; morty
	db 252, $DD, $DD, $DD, MALE   ; chuck
	db 252, $DD, $DD, $DD, FEMALE ; jasmine
	db 252, $EE, $EE, $EE, MALE   ; pryce
	db 252, $EE, $EE, $EE, FEMALE ; clair
	db 252, PERFECT_DVS,   MALE   ; will
	db 252, PERFECT_DVS,   MALE   ; koga
	db 252, PERFECT_DVS,   MALE   ; bruno
	db 252, PERFECT_DVS,   FEMALE ; karen
	db 252, PERFECT_DVS,   MALE   ; champion
	db 252, PERFECT_DVS,   MALE   ; brock
	db 252, PERFECT_DVS,   FEMALE ; misty
	db 252, PERFECT_DVS,   MALE   ; lt surge
	db 252, PERFECT_DVS,   FEMALE ; erika
	db 252, PERFECT_DVS,   FEMALE ; janine
	db 252, PERFECT_DVS,   FEMALE ; sabrina
	db 252, PERFECT_DVS,   MALE   ; blaine
	db 252, PERFECT_DVS,   MALE   ; blue
	db 252, PERFECT_DVS,   MALE   ; red
	db 252, PERFECT_DVS,   FEMALE ; leaf
	db   0, PERFECT_DVS,   MALE   ; rival0
	db 144, PERFECT_DVS,   MALE   ; rival1
	db 252, PERFECT_DVS,   MALE   ; rival2
	db   0, $BB, $BB, $BB, FEMALE ; lyra1
	db 252, $BB, $BB, $BB, FEMALE ; lyra2
	db   0, $66, $66, $66, MALE   ; youngster
	db   0, $66, $66, $66, MALE   ; bug catcher
	db   8, $77, $77, $77, MALE   ; camper
	db   8, $77, $77, $77, FEMALE ; picnicker
	db  16, $88, $88, $88, FEMALE ; twins
	db  16, $88, $88, $88, MALE   ; fisher
	db  16, $88, $88, $88, MALE   ; bird keeper
	db  24, $99, $99, $99, MALE   ; hiker
	db  32, $AA, $AA, $AA, MALE   ; gruntm
	db  32, $AA, $AA, $AA, FEMALE ; gruntf
	db  32, $AA, $AA, $AA, MALE   ; pokefanm
	db  32, $AA, $AA, $AA, FEMALE ; pokefanf
	db  48, $DD, $BB, $DB, MALE   ; officerm
	db  48, $7B, $DB, $FF, FEMALE ; officerf
	db  48, $E5, $FA, $D6, FEMALE ; nurse
	db  40, $BB, $BB, $BB, MALE   ; pokemaniac
	db  40, $BB, $BB, $BB, FEMALE ; cosplayer
	db  40, $BB, $BB, $BB, MALE   ; super nerd
	db  40, $BB, $BB, $BB, FEMALE ; lass
	db  48, $CC, $CC, $CC, FEMALE ; beauty
	db  48, $CC, $CC, $CC, MALE   ; bug maniac
	db  48, $CC, $CC, $CC, MALE   ; ruin maniac
	db  48, $CC, $CC, $CC, MALE   ; firebreather
	db  48, $CC, $CC, $CC, MALE   ; juggler
	db  48, $CC, $CC, $CC, MALE   ; schoolboy
	db  48, $CC, $CC, $CC, FEMALE ; schoolgirl
	db  48, $AA, $CC, $EE, MALE   ; psychic
	db  48, $AA, $CC, $EE, FEMALE ; hex maniac
	db  48, $CC, $CC, $CC, MALE   ; sage
	db  48, $CC, $CC, $CC, FEMALE ; medium
	db  56, $DD, $DD, $DD, FEMALE ; kimono girl
	db  56, $DD, $DD, $DD, MALE   ; elder
	db  48, $CC, $CC, $CC, FEMALE ; sr&jr
	db  48, $CC, $CC, $CC, MALE   ; couple
	db  48, $CC, $CC, $CC, MALE   ; gentleman
	db 100, $CC, $CC, $CC, MALE   ; rich boy (high EVs from vitamins)
	db  48, $CC, $CC, $CC, FEMALE ; lady
	db  56, $DD, $DD, $DD, FEMALE ; breeder (low EVs due to breeding)
	db  48, $CC, $CC, $CC, FEMALE ; baker
	db  48, $CC, $CC, $CC, FEMALE ; cowgirl
	db  48, $CC, $CC, $CC, MALE   ; sailor
	db  48, $CC, $CC, $CC, MALE   ; swimmerm
	db  48, $CC, $CC, $CC, FEMALE ; swimmerf
	db  56, $DD, $DD, $DD, MALE   ; burglar
	db  56, $DD, $DD, $DD, MALE   ; pi
	db  56, $DD, $DD, $DD, MALE   ; scientist
	db  56, $DD, $DD, $DD, MALE   ; rocket scientist
	db  56, $DD, $DD, $DD, MALE   ; boarder
	db  56, $DD, $DD, $DD, FEMALE ; skier
	db  64, $FF, $DD, $DD, MALE   ; blackbelt
	db  64, $FF, $DD, $DD, FEMALE ; battle girl
	db  72, $DF, $DF, $DD, MALE   ; dragon tamer
	db  72, $DD, $DD, $DD, MALE   ; engineer
	db  72, $DD, $DD, $DD, FEMALE ; teacher_f
	db  72, $DD, $DD, $DD, MALE   ; teacher_m
	db  72, $DD, $DD, $DD, MALE   ; guitaristm
	db  72, $DD, $DD, $DD, FEMALE ; guitaristf
	db  72, $DD, $DD, $DD, MALE   ; biker
	db  72, $DD, $DD, $DD, MALE   ; roughneck
	db  72, $DD, $DD, $DD, MALE   ; tamer
	db  72, $DD, $DD, $DD, FEMALE ; artist
	db  72, $DD, $DD, $DD, FEMALE ; aroma lady
	db  72, $DD, $DD, $DD, MALE   ; soldier
	db  72, $DD, $DD, $DD, MALE   ; waiter
	db  72, $DD, $DD, $DD, FEMALE ; waitress
	db  72, $DD, $DD, $DD, MALE   ; sightseerm
	db  72, $DD, $DD, $DD, FEMALE ; sightseerf
	db  72, $EE, $EE, $EE, MALE   ; sightseers
	db  64, $EE, $EE, $EE, MALE   ; cooltrainerm
	db  64, $EE, $EE, $EE, FEMALE ; cooltrainerf
	db  72, $EE, $EE, $EE, MALE   ; ace duo
	db 128, PERFECT_DVS,   MALE   ; veteranm
	db 128, PERFECT_DVS,   FEMALE ; veteranf
	db  80, $BB, $BB, $BB, MALE   ; proton
	db  96, $CC, $CC, $CC, MALE   ; petrel
	db 128, $EE, $EE, $EE, MALE   ; archer
	db 112, $DD, $DD, $DD, FEMALE ; ariana
	db 160, PERFECT_DVS,   MALE   ; giovanni
	db 252, PERFECT_DVS,   MALE   ; prof oak
	db  32, $BB, $BB, $BB, MALE   ; prof elm
	db 252, PERFECT_DVS,   FEMALE ; prof ivy
	db  88, $DD, $DD, $DD, MALE   ; mysticalman
	db  88, PERFECT_DVS,   MALE   ; karate king
	db 252, PERFECT_DVS,   MALE   ; towertycoon
	db 252, PERFECT_DVS,   MALE   ; factoryhead
	db  88, $BB, $B8, $BB, MALE   ; jessie&james
	db 252, PERFECT_DVS,   FEMALE ; lorelei
	db 252, PERFECT_DVS,   FEMALE ; agatha
	db 252, PERFECT_DVS,   MALE   ; steven
	db 252, PERFECT_DVS,   FEMALE ; cynthia
	db 252, PERFECT_DVS,   MALE   ; inver
	db 192, $EE, $EE, $EE, FEMALE ; cheryl
	db 192, $EE, $EE, $EE, MALE   ; riley
	db 192, $EE, $EE, $EE, MALE   ; buck
	db 192, $EE, $EE, $EE, FEMALE ; marley
	db 192, $EE, $EE, $EE, FEMALE ; mira
	db 192, $EE, $EE, $EE, FEMALE ; anabel
	db 252, PERFECT_DVS,   MALE   ; darach
	db 252, PERFECT_DVS,   FEMALE ; caitlin
	db 252, PERFECT_DVS,   FEMALE ; candela
	db 252, PERFECT_DVS,   FEMALE ; blanche
	db 252, PERFECT_DVS,   MALE   ; spark
	db 252, PERFECT_DVS,   FEMALE ; flannery
	db 252, PERFECT_DVS,   FEMALE ; maylene
	db 252, PERFECT_DVS,   MALE   ; marlon
	db 252, PERFECT_DVS,   FEMALE ; valerie
	db 252, PERFECT_DVS,   MALE   ; kukui
	db 252, $DD, $DD, $DD, MALE   ; piers
	db 252, $DD, $DD, $DD, FEMALE ; katy
	db 192, $EE, $EE, $EE, MALE   ; victor
	db 252, PERFECT_DVS,   MALE   ; bill
	db 252, $EE, $EE, $EE, FEMALE ; yellow
	db 252, $EE, $EE, $EE, MALE   ; walker
	db 192, $EE, $EE, $EE, MALE   ; imakuni
	db 252, PERFECT_DVS,   MALE   ; lawrence
	db 252, $EE, $EE, $EE, FEMALE ; rei
	assert_table_length NUM_TRAINER_CLASSES
