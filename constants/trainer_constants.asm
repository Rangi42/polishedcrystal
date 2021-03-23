__trainer_class__ = 0

trainerclass: MACRO
\1 EQU __trainer_class__
__trainer_class__ = __trainer_class__ + 1
	const_def 1
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
CHRIS EQU __trainer_class__
	trainerclass TRAINER_NONE ; 0
	const PHONECONTACT_MOM
	const PHONECONTACT_BIKESHOP
	const PHONECONTACT_BILL
	const PHONECONTACT_ELM
	const PHONECONTACT_LYRA
	const PHONECONTACT_BUENA

KRIS EQU __trainer_class__
	trainerclass CARRIE ; 1

	trainerclass CAL ; 2

	trainerclass FALKNER ; 3

	trainerclass BUGSY ; 4

	trainerclass WHITNEY ; 5

	trainerclass MORTY ; 6

	trainerclass CHUCK ; 7

	trainerclass JASMINE ; 8

	trainerclass PRYCE ; 9

	trainerclass CLAIR ; a

	trainerclass WILL ; b

	trainerclass KOGA ; c

	trainerclass BRUNO ; d

	trainerclass KAREN ; e

	trainerclass CHAMPION ; f
	const LANCE
	const LANCE2

	trainerclass BROCK ; 10

	trainerclass MISTY ; 11

	trainerclass LT_SURGE ; 12

	trainerclass ERIKA ; 13

	trainerclass JANINE ; 14

	trainerclass SABRINA ; 15

	trainerclass BLAINE ; 16

	trainerclass BLUE ; 17

	trainerclass RED ; 18

	trainerclass LEAF ; 19

	trainerclass RIVAL0 ; 1a

	trainerclass RIVAL1 ; 1b
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

	trainerclass RIVAL2 ; 1c

	trainerclass LYRA1 ; 1d
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

	trainerclass LYRA2 ; 1e

	trainerclass YOUNGSTER ; 1f
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

	trainerclass BUG_CATCHER ; 20
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
	const CALLUM
	const DAVID

	trainerclass CAMPER ; 21
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

	trainerclass PICNICKER ; 22
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

	trainerclass TWINS ; 23
	const AMYANDMAY1
	const AMYANDMAY2
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

	trainerclass FISHER ; 24
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
	const DUNDEE
	const HALL
	const DALLAS

	trainerclass BIRD_KEEPER ; 25
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

	trainerclass HIKER ; 26
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

	trainerclass GRUNTM ; 27

	trainerclass GRUNTF ; 28

	trainerclass POKEFANM ; 29
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

	trainerclass POKEFANF ; 2a
	const BEVERLY1
	const BEVERLY2
	const BEVERLY3
	const RUTH
	const GEORGIA
	const JAIME
	const BOONE
	const ELEANOR

	trainerclass OFFICERM ; 2b
	const KEITH
	const DIRK

	trainerclass OFFICERF ; 2c
	const JAMIE
	const MARA
	const JENNY

	trainerclass NURSE ; 2d
	const JOY

	trainerclass POKEMANIAC ; 2e
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
	const MILLER
	const AIDAN
	const CLIVE

	trainerclass COSPLAYER ; 2f
	const CLARA
	const CHLOE
	const BROOKE
	const KUROKO

	trainerclass SUPER_NERD ; 30
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
	const MAKO

	trainerclass LASS ; 31
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
	const LAYLA
	const ROSE
	const MEADOW
	const JENNIFER
	const GINA
	const ALICE
	const DUPLICA

	trainerclass BEAUTY ; 32
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

	trainerclass BUG_MANIAC ; 33
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

	trainerclass RUIN_MANIAC ; 34
	const JONES
	const LELAND
	const PETRY
	const GLYN
	const SMILTE

	trainerclass FIREBREATHER ; 35
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

	trainerclass JUGGLER ; 36
	const IRWIN1
;	const IRWIN2
;	const IRWIN3
;	const IRWIN4
	const FRITZ
	const HORTON

	trainerclass SCHOOLBOY ; 37
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

	trainerclass SCHOOLGIRL ; 38
	const MOLLY
	const ELIZA
	const FAITH
	const SARAH
	const ISABEL
	const IMOGEN

	trainerclass PSYCHIC_T ; 39
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

	trainerclass HEX_MANIAC ; 3a
	const TAMARA
	const ASHLEY
	const AMY
	const LUNA
	const NATALIE
	const VIVIAN
	const ESTHER
	const MATILDA
	const BETHANY

	trainerclass SAGE ; 3b
	const CHOW
	const NICO
	const JIN
	const TROY
	const JEFFREY
	const PING
	const EDMOND
	const NEAL

	trainerclass MEDIUM ; 3c
	const MARTHA
	const GRACE
	const REBECCA
	const DORIS

	trainerclass KIMONO_GIRL_1 ; 3d
	const NAOKO

	trainerclass KIMONO_GIRL_2 ; 3e
	const SAYO

	trainerclass KIMONO_GIRL_3 ; 3f
	const ZUKI

	trainerclass KIMONO_GIRL_4 ; 40
	const KUNI

	trainerclass KIMONO_GIRL_5 ; 41
	const MIKI

	trainerclass ELDER ; 42
	const LI
	const GAKU
	const MASA
	const KOJI

	trainerclass SR_AND_JR ; 43
	const JOANDCATH1
	const JOANDCATH2
	const IVYANDAMY1
	const IVYANDAMY2
	const BEAANDMAY1
	const BEAANDMAY2

	trainerclass COUPLE ; 44
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

	trainerclass GENTLEMAN ; 45
	const PRESTON
	const EDWARD
	const GREGORY
	const ALFRED
	const MILTON
	const CAMUS
	const GEOFFREY

	trainerclass RICH_BOY ; 46
	const WINSTON
	const GERALD
	const IRVING

	trainerclass LADY ; 47
	const JESSICA

	trainerclass BREEDER ; 48
	const JULIE
	const THERESA
	const JODY
	const CARLENE
	const SOPHIE
	const BRENDA

	trainerclass BAKER ; 49
	const CHELSIE
	const SHARYN
	const MARGARET
	const OLGA

	trainerclass COWGIRL ; 4a
	const ANNIE
	const APRIL
	const DANIELA

	trainerclass SAILOR ; 4b
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

	trainerclass SWIMMERM ; 4c
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

	trainerclass SWIMMERF ; 4d
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
	const MINA
	const LEONA
	const CHELAN
	const KENDRA
	const WODA
	const RACHEL
	const MARINA

	trainerclass BURGLAR ; 4e
	const DUNCAN
	const ORSON
	const COREY
	const PETE
	const LOUIS

	trainerclass PI ; 4f
	const LOOKER

	trainerclass SCIENTIST ; 50
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

	trainerclass ROCKET_SCIENTIST ; 51
	const ROSS
	const MITCH
	const JED
	const MARC
	const RICH

	trainerclass BOARDER ; 52
	const RONALD
	const BRAD
	const DOUGLAS
	const SHAUN
	const BRYCE
	const STEFAN
	const MAX

	trainerclass SKIER ; 53
	const ROXANNE
	const CLARISSA
	const CADY
	const MARIA
	const BECKY

	trainerclass BLACKBELT_T ; 54
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

	trainerclass BATTLE_GIRL ; 55
	const SUBARU
	const DIANE
	const KAGAMI
	const NOZOMI
	const RONDA
	const PADMA
	const EMY

	trainerclass DRAGON_TAMER ; 56
	const PAUL
	const DARIN
	const ADAM
	const ERICK
	const KAZU
	const AEGON

	trainerclass ENGINEER ; 57
	const SMITH
	const BERNIE
	const CAMDEN
	const LANG
	const HUGO
	const HOWARD

	trainerclass TEACHER ; 58
	const COLETTE
	const HILLARY
	const SHIRLEY
	const KATHRYN
	const CLARICE

	trainerclass GUITARISTM ; 59
	const CLYDE
	const VINCENT
	const ROGER
	const EZEKIEL
	const BIFF
	const GEDDY

	trainerclass GUITARISTF ; 5a
	const JANET
	const MORGAN
	const RITSUKO
	const WANDA
	const JACLYN

	trainerclass BIKER ; 5b
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

	trainerclass ROUGHNECK ; 5c
	const BRIAN
	const THERON
	const MARKEY

	trainerclass TAMER ; 5d
	const BRETT
	const VINCE
	const OSWALD
	const JORDAN

	trainerclass ARTIST ; 5e
	const REINA
	const ALINA
	const MARLENE
	const RIN

	trainerclass AROMA_LADY ; 5f
	const DAHLIA
	const BRYONY
	const HEATHER
	const HOLLY
	const PEONY

	trainerclass WAITER ; 60

	trainerclass WAITRESS ; 61

	trainerclass SIGHTSEERM ; 62
	const JASKA
	const BLAISE
	const GARETH
	const CHESTER
	const HARI

	trainerclass SIGHTSEERF ; 63
	const ROSIE
	const KAMILA
	const NOELLE
	const PILAR
	const LENIE

	trainerclass SIGHTSEERS ; 64
	const LIANDSU1
	const LIANDSU2
	const CYANDVI1
	const CYANDVI2

	trainerclass COOLTRAINERM ; 65
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

	trainerclass COOLTRAINERF ; 66
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

	trainerclass ACE_DUO ; 67
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

	trainerclass VETERANM ; 68
	const MATT
	const REMY
	const BARKHORN

	trainerclass VETERANF ; 69
	const JOANNE
	const SYLVIE
	const LITVYAK

	trainerclass PROTON ; 6a
	const PROTON1
	const PROTON2

	trainerclass PETREL ; 6b
	const PETREL1
	const PETREL2

	trainerclass ARCHER ; 6c
	const ARCHER1
	const ARCHER2

	trainerclass ARIANA ; 6d
	const ARIANA1
	const ARIANA2

	trainerclass GIOVANNI ; 6e
	const GIOVANNI1
	const GIOVANNI2

	trainerclass PROF_OAK ; 6f

	trainerclass PROF_ELM ; 70

	trainerclass PROF_IVY ; 71

	trainerclass MYSTICALMAN ; 72
	const EUSINE

	trainerclass KARATE_KING ; 73
	const KIYO

	trainerclass TOWERTYCOON ; 74

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

	trainerclass SKYLA ; 88

	trainerclass VALERIE ; 89

	trainerclass KUKUI ; 8a

	trainerclass VICTOR  ; 8b

	trainerclass BILL_T ; 8c

	trainerclass YELLOW ; 8d

	trainerclass WALKER ; 8e

	trainerclass IMAKUNI ; 8f

	trainerclass LAWRENCE ; 90

	trainerclass REI ; 91

NUM_TRAINER_CLASSES EQU __trainer_class__ - 1

	trainerclass OMASTAR_FOSSIL ; 92

	trainerclass KABUTOPS_FOSSIL ; 93

	trainerclass AERODACTYL_FOSSIL ; 94

	trainerclass CUBONE_ARMOR ; 95

	trainerclass METEORITE ; 96

	trainerclass SILHOUETTE ; 97

NUM_TRAINER_CLASS_PICS EQU __trainer_class__ - 1
