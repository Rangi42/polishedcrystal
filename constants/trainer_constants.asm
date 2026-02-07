DEF __trainer_pal__ = 0

MACRO trainerpal
	DEF TRAINERPAL_\1 = __trainer_pal__
	DEF __trainer_pal__ += 1
ENDM

DEF __trainer_class__ = 0

MACRO trainerclass
	DEF \1 EQU __trainer_class__
	DEF __trainer_class__ += 1
	const_def 1
	trainerpal \1
ENDM

; trainer class ids
; `trainerclass` indexes are for:
; - TrainerClassNames (see data/trainers/class_names.asm)
; - TrainerClassAttributes (see data/trainers/attributes.asm)
; - TrainerClassDVsAndPersonality (see data/trainers/dvs.asm)
; - TrainerGroups (see data/trainers/party_pointers.asm)
; - TrainerEncounterMusic (see data/trainers/encounter_music.asm)
; - TrainerPicPointers (see data/trainers/pic_pointers.asm)
; - TrainerPalettes (see data/trainers/palettes.asm)
; - BTTrainerClassSprites (see data/trainers/sprites.asm)
; - BTTrainerClassGenders (see data/trainers/genders.asm)
; trainer constants are indexes for the sub-tables of TrainerGroups (see data/trainers/parties.asm)
	trainerclass TRAINER_NONE ; 0
	const PHONECONTACT_MOM
	const PHONECONTACT_BIKESHOP
	const PHONECONTACT_BILL
	const PHONECONTACT_ELM
	const PHONECONTACT_LYRA
	const PHONECONTACT_BUENA
DEF NUM_NONTRAINER_PHONECONTACTS EQU const_value - 1

DEF KRIS EQU __trainer_class__
	trainerclass CARRIE ; 1

DEF CHRIS EQU __trainer_class__
	trainerclass CAL ; 2

DEF CRYS EQU __trainer_class__
	trainerclass JACKY ; 3

	trainerclass FALKNER ; 4

	trainerclass BUGSY ; 5

	trainerclass WHITNEY ; 6

	trainerclass MORTY ; 7

	trainerclass CHUCK ; 8

	trainerclass JASMINE ; 9

	trainerclass PRYCE ; a

	trainerclass CLAIR ; b

	trainerclass WILL ; c

	trainerclass KOGA ; d

	trainerclass BRUNO ; e

	trainerclass KAREN ; f

	trainerclass CHAMPION ; 10
	const LANCE
	const LANCE2

	trainerclass BROCK ; 11

	trainerclass MISTY ; 12

	trainerclass LT_SURGE ; 13

	trainerclass ERIKA ; 14

	trainerclass JANINE ; 15

	trainerclass SABRINA ; 16

	trainerclass BLAINE ; 17

	trainerclass BLUE ; 18

	trainerclass RED ; 19

	trainerclass LEAF ; 1a

	trainerclass RIVAL0 ; 1b

	trainerclass RIVAL1 ; 1c
	const RIVAL1_4
	const RIVAL1_5
	const RIVAL1_6
	const RIVAL1_7
	const RIVAL1_8
	const RIVAL1_9
	const RIVAL1_10
	const RIVAL1_11
	const RIVAL1_12
	const RIVAL1_13
	const RIVAL1_14
	const RIVAL1_15

	trainerclass RIVAL2 ; 1d

	trainerclass LYRA1 ; 1e
	const LYRA1_1
	const LYRA1_2
	const LYRA1_3
	const LYRA1_4
	const LYRA1_5
	const LYRA1_6
	const LYRA1_7
	const LYRA1_8
	const LYRA1_9
	const LYRA1_10
	const LYRA1_11
	const LYRA1_12

	trainerclass LYRA2 ; 1f

	trainerclass YOUNGSTER ; 20
	const JOEY1
	const JOEY2
	const JOEY3
	const JOEY4
	const JOEY5
	const MIKEY
	const ALBERT
	const GORDON
	const WARREN
	const JIMMY
	const OWEN
	const JASON
	const YOUNGSTER_JOSH
	const REGIS
	const ALFIE
	const OLIVER
	const CHAZ
	const TYLER
	const ARDEN

	trainerclass BUG_CATCHER ; 21
	const WADE1
	const WADE2
	const WADE3
	const WADE4
	const WADE5
	const ARNIE1
	const ARNIE2
	const ARNIE3
	const ARNIE4
	const ARNIE5
	const DON
	const BENNY
	const AL
	const JOSH
	const KEN
	const WAYNE
	const OSCAR

	trainerclass CAMPER ; 22
	const TODD1
	const TODD2
	const TODD3
	const TODD4
	const TODD5
	const ROLAND
	const IVAN
	const BARRY
	const LLOYD
	const DEAN
	const SID
	const TED
	const JOHN
	const JERRY
	const SPENCER
	const QUENTIN
	const GRANT
	const CRAIG
	const FELIX
	const TANNER
	const CLARK
	const PEDRO
	const AMOS

	trainerclass PICNICKER ; 23
	const LIZ1
	const LIZ2
	const LIZ3
	const LIZ4
	const LIZ5
	const GINA1
	const GINA2
	const GINA3
	const GINA4
	const GINA5
	const ERIN1
	const ERIN2
	const ERIN3
	const TIFFANY1
	const TIFFANY2
	const TIFFANY3
	const TIFFANY4
	const KIM
	const CINDY
	const HOPE
	const SHARON
	const DEBRA
	const HEIDI
	const EDNA
	const TANYA
	const LILY
	const PIPER
	const GINGER
	const CHEYENNE
	const ADRIAN
	const ZANE

	trainerclass TWINS ; 24
	const AMYANDMIMI1
	const AMYANDMIMI2
	const ANNANDANNE1
	const ANNANDANNE2
	const JOANDZOE1
	const JOANDZOE2
	const MEGANDPEG1
	const MEGANDPEG2
	const LEAANDPIA1
	const LEAANDPIA2
	const DAYANDDANI1
	const DAYANDDANI2
	const KAYANDTIA1
	const KAYANDTIA2

	trainerclass FISHER ; 25
	const RALPH1
	const RALPH2
	const RALPH3
	const RALPH4
	const RALPH5
	const TULLY1
	const TULLY2
	const TULLY3
	const TULLY4
	const WILTON1
	const WILTON2
	const WILTON3
	const JUSTIN
	const ARNOLD
	const KYLE
	const HENRY
	const MARVIN
	const ANDRE
	const RAYMOND
	const EDGAR
	const JONAH
	const MARTIN
	const STEPHEN
	const BARNEY
	const SCOTT
	const PATON
	const KILEY
	const FRANCIS
	const LEROY
	const KYLER
	const MURPHY
	const LIAM
	const GIDEON
	const HALL
	const DALLAS

	trainerclass BIRD_KEEPER ; 26
	const VANCE1
	const VANCE2
	const VANCE3
	const JOSE1
	const JOSE2
	const JOSE3
	const ROD
	const ABE
	const THEO
	const TOBY
	const DENIS
	const HANK
	const ROY
	const BORIS
	const BOB
	const PETER
	const PERRY
	const BRET
	const MICK
	const POWELL
	const BIRD_KEEPER_TONY
	const JULIAN
	const BIRD_KEEPER_JUSTIN
	const GAIL
	const BIRD_KEEPER_JOSH
	const BERT
	const ERNIE
	const KINSLEY
	const EASTON
	const BRYAN
	const TRENT

	trainerclass HIKER ; 27
	const ANTHONY1
	const ANTHONY2
	const ANTHONY3
	const ANTHONY4
	const ANTHONY5
	const PARRY1
	const PARRY2
	const PARRY3
	const RUSSELL
	const PHILLIP
	const LEONARD
	const BENJAMIN
	const ERIK
	const MICHAEL
	const TIMOTHY
	const BAILEY
	const TIM
	const NOLAND
	const SIDNEY
	const KENNY
	const JIM
	const DANIEL
	const EDWIN
	const DEVIN
	const SEAMUS
	const TONY
	const MARCOS
	const GERARD
	const DENT
	const BRUCE
	const DWIGHT
	const LESTER
	const GRADY
	const STEVE
	const DERRICK
	const FLOYD

	trainerclass GRUNTM ; 28

	trainerclass GRUNTF ; 29

	trainerclass POKEFANM ; 2a
	const DEREK1
	const DEREK2
	const DEREK3
	const WILLIAM
	const ROBERT
	const JOSHUA
	const CARTER
	const TREVOR
	const BRANDON
	const JEREMY
	const COLIN
	const ALEX
	const REX
	const ALLAN

	trainerclass POKEFANF ; 2b
	const BEVERLY1
	const BEVERLY2
	const BEVERLY3
	const RUTH
	const GEORGIA
	const JAIME
	const BOONE
	const ELEANOR

	trainerclass OFFICERM ; 2c
	const KEITH
	const DIRK

	trainerclass OFFICERF ; 2d
	const JAMIE
	const MARA
	const JENNY

	trainerclass NURSE ; 2e
	const BEATRICE
	const KEIKO
	const JOY
	const WINIFRED

	trainerclass POKEMANIAC ; 2f
	const BRENT1
	const BRENT2
	const BRENT3
	const BRENT4
	const LARRY
	const ANDREW
	const CALVIN
	const SHANE
	const BEN
	const RON
	const ETHAN
	const ISSAC
	const DONALD
	const ZACH
	const ENZO
	const MILLER
	const AIDAN

	trainerclass COSPLAYER ; 30
	const CLARA
	const CHLOE
	const BROOKE
	const KUROKO
	const LYRIC

	trainerclass SUPER_NERD ; 31
	const STAN
	const ERIC
	const SAM
	const TOM
	const PAT
	const SHAWN
	const TERU
	const HUGH
	const MARKUS
	const CARY
	const WALDO
	const MERLE
	const LUIS
	const JOVAN
	const MIGUEL
	const RORY
	const GREGG
	const FOOTE
	const DAVE
	const KOUTA

	trainerclass LASS ; 32
	const DANA1
	const DANA2
	const DANA3
	const DANA4
	const DANA5
	const CATHY
	const AMANDA
	const KRISE
	const CONNIE
	const LINDA
	const LAURA
	const SHANNON
	const MICHELLE
	const ELLEN
	const IRIS
	const MIRIAM
	const ABIGAIL
	const LAYLA
	const ROSE
	const MEADOW
	const JENNIFER
	const GINA
	const ALICE
	const DUPLICA
	const MAVIS

	trainerclass BEAUTY ; 33
	const VICTORIA
	const SAMANTHA
	const CASSIE
	const JULIA
	const VALENCIA
	const OLIVIA
	const CALLIE
	const CASSANDRA
	const CHARLOTTE
	const BRIDGET
	const VERONICA
	const BEAUTY_NICOLE
	const RACHAEL
	const IOANA

	trainerclass BUG_MANIAC ; 34
	const LOU
	const ROB
	const ED
	const DOUG
	const DANE
	const DION
	const STACEY
	const ELLIS
	const ABNER
	const KENTA
	const ROBBY
	const PIERRE
	const DYLAN
	const KAI

	trainerclass RUIN_MANIAC ; 35
	const JONES
	const LELAND
	const PETRY
	const GLYN
	const SMILTE

	trainerclass FIREBREATHER ; 36
	const OTIS
	const DICK
	const NED
	const BURT
	const BILL
	const WALT
	const RAY
	const LYLE
	const JAY
	const OLEG
	const TALA

	trainerclass JUGGLER ; 37
	const IRWIN1
;	const IRWIN2
;	const IRWIN3
;	const IRWIN4
	const FRITZ
	const HORTON

	trainerclass SCHOOLBOY ; 38
	const JACK1
	const JACK2
	const JACK3
	const JACK4
	const JACK5
	const ALAN1
	const ALAN2
	const ALAN3
	const ALAN4
	const ALAN5
	const CHAD1
	const CHAD2
	const CHAD3
	const CHAD4
	const CHAD5
	const KIPP
	const JOHNNY
	const DANNY
	const TOMMY
	const DUDLEY
	const JOE
	const BILLY
	const NATE
	const RICKY
	const SHERMAN
	const SCHOOLBOY_CONNOR
	const TORIN
	const TRAVIS

	trainerclass SCHOOLGIRL ; 39
	const MOLLY
	const ELIZA
	const FAITH
	const SARAH
	const ISABEL
	const IMOGEN

	trainerclass PSYCHIC_T ; 3a
	const NATHAN
	const FRANKLIN
	const HERMAN
	const FIDEL
	const GREG
	const NORMAN
	const MARK
	const PHIL
	const RICHARD
	const GILBERT
	const JARED
	const RODNEY
	const LEON
	const URI
	const VIRGIL

	trainerclass HEX_MANIAC ; 3b
	const TAMARA
	const ASHLEY
	const AMY
	const LUNA
	const NATALIE
	const VIVIAN
	const ESTHER
	const MATILDA
	const BETHANY
	const CORYN

	trainerclass SAGE ; 3c
	const CHOW
	const NICO
	const JIN
	const TROY
	const JEFFREY
	const PING
	const EDMOND
	const NEAL

	trainerclass MEDIUM ; 3d
	const MARTHA
	const GRACE
	const REBECCA
	const DORIS

	trainerclass KIMONO_GIRL ; 3e
	const NAOKO
	const SAYO
	const ZUKI
	const KUNI
	const MIKI
	const MAKO
	const AMI
	const MINA

	trainerclass ELDER ; 3f
	const LI
	const GAKU
	const MASA
	const KOJI

	trainerclass SR_AND_JR ; 40
	const JOANDCATH1
	const JOANDCATH2
	const IVYANDAMY1
	const IVYANDAMY2
	const BEAANDMAY1
	const BEAANDMAY2

	trainerclass COUPLE ; 41
	const GAILANDELI1
	const GAILANDELI2
	const DUFFANDEDA1
	const DUFFANDEDA2
	const FOXANDRAE1
	const FOXANDRAE2
	const MOEANDLULU1
	const MOEANDLULU2
	const VICANDTARA1
	const VICANDTARA2
	const TIMANDSUE1
	const TIMANDSUE2
	const JOEANDJO1
	const JOEANDJO2

	trainerclass GENTLEMAN ; 42
	const PRESTON
	const EDWARD
	const GREGORY
	const ALFRED
	const MILTON
	const CAMUS
	const GEOFFREY

	trainerclass RICH_BOY ; 43
	const WINSTON
	const GERALD
	const IRVING
	const TOBIN

	trainerclass LADY ; 44
	const JESSICA

	trainerclass BREEDER ; 45
	const JULIE
	const THERESA
	const JODY
	const CARLENE
	const SOPHIE
	const BRENDA

	trainerclass BAKER ; 46
	const CHELSIE
	const SHARYN
	const MARGARET
	const OLGA

	trainerclass COWGIRL ; 47
	const ANNIE
	const APRIL
	const DANIELA

	trainerclass SAILOR ; 48
	const HUEY1
	const HUEY2
	const HUEY3
	const HUEY4
	const EUGENE
	const TERRELL
	const KENT
	const ERNEST
	const JEFF
	const GARRETT
	const KENNETH
	const STANLY
	const HARRY
	const PARKER
	const EDDIE
	const HARVEY

	trainerclass SWIMMERM ; 49
	const HAROLD
	const SIMON
	const RANDALL
	const CHARLIE
	const GEORGE
	const BERKE
	const KIRK
	const MATHEW
	const HAL
	const JEROME
	const TUCKER
	const RICK
	const CAMERON
	const SETH
	const JAMES
	const WALTER
	const LEWIS
	const MICHEL
	const LUCAS
	const FRANK
	const NADAR
	const CONRAD
	const ROMEO
	const MALCOLM
	const ARMAND
	const THOMAS
	const SWIMMERM_LUIS
	const ELMO
	const DUANE
	const ESTEBAN
	const EZRA
	const ASHE

	trainerclass SWIMMERF ; 4a
	const ELAINE
	const PAULA
	const KAYLEE
	const SUSIE
	const DENISE
	const KARA
	const WENDY
	const MARY
	const DAWN
	const NICOLE
	const LORI
	const NIKKI
	const DIANA
	const BRIANA
	const VIOLA
	const KATIE
	const JILL
	const LISA
	const ALISON
	const STEPHANIE
	const CAROLINE
	const NATALIA
	const BARBARA
	const SALLY
	const TARA
	const MAYU
	const LEONA
	const CHELAN
	const KENDRA
	const WODA
	const RACHEL
	const MARINA

	trainerclass BURGLAR ; 4b
	const DUNCAN
	const ORSON
	const COREY
	const PETE
	const LOUIS

	trainerclass PI ; 4c
	const LOOKER

	trainerclass SCIENTIST ; 4d
	const LOWELL
	const DENNETT
	const LINDEN
	const OSKAR
	const BRAYDON
	const CARL
	const DEXTER
	const JOSEPH
	const NIGEL
	const PIOTR
	const SANDERS

	trainerclass ROCKET_SCIENTIST ; 4e
	const ROSS
	const MITCH
	const JED
	const MARC
	const RICH

	trainerclass BOARDER ; 4f
	const RONALD
	const BRAD
	const DOUGLAS
	const SHAUN
	const BRYCE
	const STEFAN
	const MAX

	trainerclass SKIER ; 50
	const ROXANNE
	const CLARISSA
	const CADY
	const MARIA
	const BECKY

	trainerclass BLACKBELT_T ; 51
	const KENJI1
;	const KENJI2
;	const KENJI3
	const YOSHI
	const LAO
	const NOB
	const LUNG
	const WAI
	const INIGO
	const MANFORD
	const ANDER
	const TAKEO
	const RYLAN

	trainerclass BATTLE_GIRL ; 52
	const SUBARU
	const DIANE
	const KAGAMI
	const NOZOMI
	const RONDA
	const PADMA
	const EMY
	const SASHA

	trainerclass DRAGON_TAMER ; 53
	const PAUL
	const DARIN
	const ADAM
	const ERICK
	const KAZU
	const AEGON

	trainerclass ENGINEER ; 54
	const SMITH
	const BERNIE
	const CAMDEN
	const LANG
	const HUGO
	const HOWARD
	const GRADEN
	const GUSTAV
	const NICOLAS

	trainerclass TEACHER_F ; 55
	const COLETTE
	const HILLARY
	const SHIRLEY
	const KATHRYN
	const CLARICE
	const SERENA

	trainerclass TEACHER_M ; 56
	const NOLAN

	trainerclass GUITARISTM ; 57
	const CLYDE
	const VINCENT
	const ROGER
	const EZEKIEL
	const BIFF
	const GEDDY

	trainerclass GUITARISTF ; 58
	const JANET
	const MORGAN
	const RITSUKO
	const WANDA
	const JACLYN

	trainerclass BIKER ; 59
	const DWAYNE
	const HARRIS
	const ZEKE
	const CHARLES
	const REILLY
	const JOEL
	const GLENN
	const DALE
	const JACOB
	const AIDEN
	const DAN
	const TEDDY
	const TYRONE

	trainerclass ROUGHNECK ; 5a
	const BRIAN
	const THERON
	const MARKEY

	trainerclass TAMER ; 5b
	const BRETT
	const VINCE
	const OSWALD
	const JORDAN

	trainerclass ARTIST ; 5c
	const REINA
	const ALINA
	const MARLENE
	const RIN

	trainerclass AROMA_LADY ; 5d
	const DAHLIA
	const BRYONY
	const HEATHER
	const HOLLY
	const PEONY

	trainerclass SOLDIER ; 5e

	trainerclass WAITER ; 5f
	const DAVID

	trainerclass WAITRESS ; 60

	trainerclass SIGHTSEERM ; 61
	const JASKA
	const BLAISE
	const GARETH
	const CHESTER
	const HARI

	trainerclass SIGHTSEERF ; 62
	const ROSIE
	const KAMILA
	const NOELLE
	const PILAR
	const LENIE

	trainerclass SIGHTSEERS ; 63
	const LIANDSU1
	const LIANDSU2
	const CYANDVI1
	const CYANDVI2

	trainerclass COOLTRAINERM ; 64
	const GAVEN1
	const GAVEN2
	const GAVEN3
	const NICK
	const AARON
	const CODY
	const MIKE
	const RYAN
	const BLAKE
	const ANDY
	const SEAN
	const KEVIN
	const ALLEN
	const FRENCH
	const HENRI
	const CONNOR
	const KIERAN
	const FINCH
	const PETRIE
	const COOLTRAINERM_COREY
	const COOLTRAINERM_RAYMOND
	const FERGUS
	const DARIC

	trainerclass COOLTRAINERF ; 65
	const BETH1
	const BETH2
	const BETH3
	const REENA1
	const REENA2
	const REENA3
	const GWEN
	const LOIS
	const FRAN
	const LOLA
	const KATE
	const IRENE
	const KELLY
	const JOYCE
	const MEGAN
	const CAROL
	const QUINN
	const EMMA
	const CYBIL
	const JENN
	const SALMA
	const BONITA
	const SERA
	const NEESHA
	const CHIARA

	trainerclass ACE_DUO ; 66
	const ELANANDIDA1
	const ELANANDIDA2
	const ARAANDBELA1
	const ARAANDBELA2
	const THOMANDKAE1
	const THOMANDKAE2
	const ZACANDJEN1
	const ZACANDJEN2
	const JAKEANDBRI1
	const JAKEANDBRI2
	const DANANDCARA1
	const DANANDCARA2

	trainerclass VETERANM ; 67
	const MATT
	const REMY
	const BARKHORN
	const EN

	trainerclass VETERANF ; 68
	const JOANNE
	const JONET
	const LITVYAK
	const MADOKA

	trainerclass PROTON ; 69
	const PROTON1
	const PROTON2

	trainerclass PETREL ; 6a
	const PETREL1
	const PETREL2

	trainerclass ARCHER ; 6b
	const ARCHER1
	const ARCHER2

	trainerclass ARIANA ; 6c
	const ARIANA1
	const ARIANA2

	trainerclass GIOVANNI ; 6d
	const GIOVANNI1
	const GIOVANNI2

	trainerclass PROF_OAK ; 6e

	trainerclass PROF_ELM ; 6f

	trainerclass PROF_IVY ; 70

	trainerclass MYSTICALMAN ; 71
	const EUSINE

	trainerclass KARATE_KING ; 72
	const KIYO

	trainerclass TOWERTYCOON ; 73

	trainerclass FACTORYHEAD ; 74

	trainerclass JESSIE_JAMES ; 75

	trainerclass LORELEI ; 76

	trainerclass AGATHA ; 77

	trainerclass STEVEN ; 78

	trainerclass CYNTHIA ; 79

	trainerclass INVER ; 7a

	trainerclass CHERYL ; 7b

	trainerclass RILEY ; 7c

	trainerclass BUCK ; 7d

	trainerclass MARLEY ; 7e

	trainerclass MIRA ; 7f

	trainerclass ANABEL ; 80

	trainerclass DARACH ; 81

	trainerclass CAITLIN ; 82

	trainerclass CANDELA ; 83

	trainerclass BLANCHE ; 84

	trainerclass SPARK_T ; 85

	trainerclass FLANNERY ; 86

	trainerclass MAYLENE ; 87

	trainerclass MARLON ; 88

	trainerclass VALERIE ; 89

	trainerclass KUKUI ; 8a

	trainerclass PIERS ; 8b

	trainerclass KATY ; 8c

	trainerclass VICTOR  ; 8d

	trainerclass BILL_T ; 8e

	trainerclass YELLOW ; 8f

	trainerclass WALKER ; 90

	trainerclass IMAKUNI ; 91

	trainerclass LAWRENCE ; 92

	trainerclass REI ; 93

DEF NUM_TRAINER_CLASSES EQU __trainer_class__ - 1

	trainerclass OMASTAR_FOSSIL ; 94

	trainerclass KABUTOPS_FOSSIL ; 95

	trainerclass AERODACTYL_FOSSIL ; 96

	trainerclass CUBONE_ARMOR ; 97

	trainerclass METEORITE ; 98

	trainerclass SILHOUETTE ; 99

DEF NUM_TRAINER_CLASS_PICS EQU __trainer_class__ - 1
	trainerpal SAYO ; 9a
	trainerpal ZUKI ; 9b
	trainerpal KUNI ; 9c
	trainerpal MIKI ; 9d
	trainerpal MAKO ; 9e
	trainerpal AMI  ; 9f
	trainerpal MINA ; a0
DEF NUM_TRAINER_PALS EQU __trainer_pal__ - 1
