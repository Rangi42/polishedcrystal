DEF __trainer_class__ = 0

MACRO trainerclass
	DEF \1 EQU __trainer_class__
	DEF __trainer_class__ += 1
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
	trainerclass TRAINER_NONE
	const PHONECONTACT_MOM
	const PHONECONTACT_BIKESHOP
	const PHONECONTACT_BILL
	const PHONECONTACT_ELM
	const PHONECONTACT_LYRA
	const PHONECONTACT_BUENA
DEF NUM_NONTRAINER_PHONECONTACTS EQU const_value - 1

DEF CHRIS EQU __trainer_class__
	trainerclass CAL

DEF KRIS EQU __trainer_class__
	trainerclass CARRIE

DEF CRYS EQU __trainer_class__
	trainerclass JACKY

DEF BETA EQU __trainer_class__
	trainerclass EUNA

	trainerclass FALKNER

	trainerclass BUGSY

	trainerclass WHITNEY

	trainerclass MORTY

	trainerclass CHUCK

	trainerclass JASMINE

	trainerclass PRYCE

	trainerclass CLAIR

	trainerclass WILL

	trainerclass KOGA

	trainerclass BRUNO

	trainerclass KAREN

	trainerclass CHAMPION
	const LANCE
	const LANCE2

	trainerclass BROCK

	trainerclass MISTY

	trainerclass LT_SURGE

	trainerclass ERIKA

	trainerclass JANINE

	trainerclass SABRINA

	trainerclass BLAINE

	trainerclass BLUE

	trainerclass RED

	trainerclass LEAF

	trainerclass RIVAL0

	trainerclass RIVAL1
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

	trainerclass RIVAL2

	trainerclass LYRA1
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

	trainerclass LYRA2

	trainerclass YOUNGSTER
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

	trainerclass BUG_CATCHER
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

	trainerclass CAMPER
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
	const GRANT ; custom pal
	const CRAIG
	const FELIX
	const TANNER
	const CLARK
	const PEDRO
	const AMOS

	trainerclass PICNICKER
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

	trainerclass TWINS
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

	trainerclass FISHER
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

	trainerclass BIRD_KEEPER
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
	const POWELL ; custom pal
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

	trainerclass HIKER
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

	trainerclass GRUNTM

	trainerclass GRUNTF

	trainerclass POKEFANM
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

	trainerclass POKEFANF
	const BEVERLY1
	const BEVERLY2
	const BEVERLY3
	const RUTH
	const GEORGIA
	const JAIME ; custom pal
	const BOONE
	const ELEANOR

	trainerclass OFFICERM
	const KEITH
	const DIRK

	trainerclass OFFICERF
	const JAMIE
	const MARA
	const JENNY

	trainerclass NURSE
	const BEATRICE
	const KEIKO
	const JOY
	const WINIFRED

	trainerclass POKEMANIAC
	const BRENT1
	const BRENT2
	const BRENT3
	const BRENT4
	const POKEMANIAC_LARRY
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

	trainerclass COSPLAYER
	const CLARA
	const CHLOE
	const BROOKE
	const KUROKO
	const LYRIC

	trainerclass SUPER_NERD
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

	trainerclass LASS
	const DANA1
	const DANA2
	const DANA3
	const DANA4
	const DANA5
	const CATHY ; custom pal
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

	trainerclass BEAUTY
	const VICTORIA
	const SAMANTHA
	const CASSIE
	const JULIA
	const VALENCIA
	const OLIVIA
	const CALLIE
	const CASSANDRA ; custom pal
	const CHARLOTTE
	const BRIDGET
	const VERONICA
	const BEAUTY_NICOLE
	const RACHAEL
	const IOANA

	trainerclass BUG_MANIAC
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

	trainerclass RUIN_MANIAC
	const JONES
	const LELAND
	const PETRY
	const GLYN
	const SMILTE

	trainerclass FIREBREATHER
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

	trainerclass JUGGLER
	const IRWIN1
;	const IRWIN2
;	const IRWIN3
;	const IRWIN4
	const FRITZ
	const HORTON

	trainerclass SCHOOLBOY
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

	trainerclass SCHOOLGIRL
	const MOLLY
	const ELIZA
	const FAITH
	const SARAH
	const ISABEL
	const IMOGEN ; custom pal

	trainerclass PSYCHIC_T
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

	trainerclass HEX_MANIAC
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

	trainerclass SAGE
	const CHOW
	const NICO
	const JIN
	const TROY
	const JEFFREY
	const PING
	const EDMOND
	const NEAL

	trainerclass MEDIUM
	const MARTHA
	const GRACE
	const REBECCA
	const DORIS

	trainerclass KIMONO_GIRL
	const NAOKO
	const SAYO ; custom pal
	const ZUKI ; custom pal
	const KUNI ; custom pal
	const MIKI ; custom pal
	const MAKO ; custom pal
	const AMI ; custom pal
	const MINA ; custom pal

	trainerclass ELDER
	const LI
	const GAKU ; custom pal
	const MASA ; custom pal
	const KOJI ; custom pal

	trainerclass SR_AND_JR
	const JOANDCATH1
	const JOANDCATH2
	const IVYANDAMY1
	const IVYANDAMY2
	const BEAANDMAY1
	const BEAANDMAY2

	trainerclass COUPLE
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
	const JOEANDJO1 ; custom pal
	const JOEANDJO2 ; custom pal

	trainerclass GENTLEMAN
	const PRESTON
	const EDWARD
	const GREGORY
	const ALFRED
	const MILTON
	const CAMUS
	const GEOFFREY

	trainerclass RICH_BOY
	const WINSTON
	const GERALD
	const IRVING
	const TOBIN ; custom pal

	trainerclass LADY
	const JESSICA

	trainerclass BREEDER
	const JULIE
	const THERESA
	const JODY
	const CARLENE
	const SOPHIE
	const BRENDA

	trainerclass BAKER
	const CHELSIE
	const SHARYN
	const MARGARET
	const OLGA

	trainerclass COWGIRL
	const ANNIE
	const APRIL
	const DANIELA

	trainerclass SAILOR
	const HUEY1
	const HUEY2
	const HUEY3
	const HUEY4
	const EUGENE
	const TERRELL
	const KENT ; custom pal
	const ERNEST
	const JEFF
	const GARRETT ; custom pal
	const KENNETH
	const STANLY
	const HARRY ; custom pal
	const PARKER
	const EDDIE
	const HARVEY

	trainerclass SWIMMERM
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
	const LUCAS ; custom pal
	const FRANK
	const NADAR ; custom pal
	const CONRAD
	const ROMEO
	const MALCOLM ; custom pal
	const ARMAND
	const THOMAS
	const SWIMMERM_LUIS
	const ELMO
	const DUANE
	const ESTEBAN
	const EZRA
	const ASHE ; custom pal

	trainerclass SWIMMERF
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
	const KATIE ; custom pal
	const JILL
	const LISA
	const ALISON
	const STEPHANIE
	const CAROLINE
	const NATALIA
	const BARBARA
	const SALLY
	const TARA ; custom pal
	const MAYU
	const LEONA
	const CHELAN
	const KENDRA
	const WODA
	const RACHEL ; custom pal
	const MARINA ; custom pal

	trainerclass BURGLAR
	const DUNCAN
	const ORSON
	const COREY
	const PETE
	const LOUIS

	trainerclass PI
	const LOOKER

	trainerclass SCIENTIST
	const LOWELL
	const DENNETT
	const LINDEN ; custom pal
	const OSKAR
	const BRAYDON
	const CARL
	const DEXTER
	const JOSEPH
	const NIGEL
	const PIOTR
	const SANDERS

	trainerclass ROCKET_SCIENTIST
	const ROSS
	const MITCH
	const JED
	const MARC
	const RICH

	trainerclass BOARDER
	const RONALD
	const BRAD
	const DOUGLAS
	const SHAUN
	const BRYCE
	const STEFAN
	const MAX

	trainerclass SKIER
	const ROXANNE
	const CLARISSA
	const CADY
	const MARIA
	const BECKY

	trainerclass BLACKBELT_T
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

	trainerclass BATTLE_GIRL
	const SUBARU
	const DIANE
	const KAGAMI
	const NOZOMI
	const RONDA
	const PADMA
	const EMY
	const SASHA

	trainerclass DRAGON_TAMER
	const PAUL
	const DARIN
	const ADAM
	const ERICK
	const KAZU
	const AEGON

	trainerclass ENGINEER
	const SMITH
	const BERNIE
	const CAMDEN
	const LANG
	const HUGO
	const HOWARD
	const GRADEN
	const GUSTAV
	const NICOLAS

	trainerclass TEACHER_F
	const COLETTE
	const HILLARY ; custom pal
	const SHIRLEY
	const KATHRYN
	const CLARICE
	const SERENA

	trainerclass TEACHER_M
	const NOLAN

	trainerclass GUITARISTM
	const CLYDE
	const VINCENT
	const ROGER
	const EZEKIEL
	const BIFF ; custom pal
	const GEDDY

	trainerclass GUITARISTF
	const JANET
	const MORGAN
	const RITSUKO
	const WANDA
	const JACLYN

	trainerclass BIKER
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

	trainerclass ROUGHNECK
	const BRIAN
	const THERON
	const MARKEY

	trainerclass TAMER
	const BRETT
	const VINCE
	const OSWALD
	const JORDAN

	trainerclass ARTIST
	const REINA
	const ALINA
	const MARLENE
	const RIN

	trainerclass AROMA_LADY
	const DAHLIA
	const BRYONY
	const HEATHER
	const HOLLY
	const PEONY

	trainerclass SOLDIER

	trainerclass WAITER
	const DAVID

	trainerclass WAITRESS

	trainerclass SIGHTSEERM
	const JASKA
	const BLAISE
	const GARETH
	const CHESTER
	const HARI

	trainerclass SIGHTSEERF
	const ROSIE
	const KAMILA
	const NOELLE
	const PILAR
	const LENIE

	trainerclass SIGHTSEERS
	const LIANDSU1
	const LIANDSU2
	const CYANDVI1
	const CYANDVI2

	trainerclass COOLTRAINERM
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

	trainerclass COOLTRAINERF
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

	trainerclass ACE_DUO
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

	trainerclass VETERANM
	const MATT
	const REMY
	const BARKHORN
	const EN

	trainerclass VETERANF
	const JOANNE
	const JONET
	const LITVYAK
	const MADOKA

	trainerclass PROTON
	const PROTON1
	const PROTON2

	trainerclass PETREL
	const PETREL1
	const PETREL2

	trainerclass ARCHER
	const ARCHER1
	const ARCHER2

	trainerclass ARIANA
	const ARIANA1
	const ARIANA2

	trainerclass GIOVANNI
	const GIOVANNI1
	const GIOVANNI2

	trainerclass PROF_OAK

	trainerclass PROF_ELM

	trainerclass PROF_IVY

	trainerclass MYSTICALMAN
	const EUSINE

	trainerclass KARATE_KING
	const KIYO

	trainerclass TOWERTYCOON

	trainerclass FACTORYHEAD

	trainerclass JESSIE_JAMES

	trainerclass LORELEI

	trainerclass AGATHA

	trainerclass STEVEN

	trainerclass CYNTHIA

	trainerclass INVER

	trainerclass CHERYL

	trainerclass RILEY

	trainerclass BUCK

	trainerclass MARLEY

	trainerclass MIRA

	trainerclass ANABEL

	trainerclass DARACH

	trainerclass CAITLIN

	trainerclass CANDELA

	trainerclass BLANCHE

	trainerclass SPARK_T

	trainerclass FLANNERY

	trainerclass MAYLENE

	trainerclass MARLON

	trainerclass VALERIE

	trainerclass KUKUI

	trainerclass PIERS

	trainerclass LARRY

	trainerclass VICTOR  ; 8e

	trainerclass BILL_T

	trainerclass YELLOW

	trainerclass WALKER

	trainerclass IMAKUNI

	trainerclass LAWRENCE

	trainerclass REI

DEF NUM_TRAINER_CLASSES EQU __trainer_class__ - 1

	trainerclass OMASTAR_FOSSIL

	trainerclass KABUTOPS_FOSSIL

	trainerclass AERODACTYL_FOSSIL

	trainerclass CUBONE_ARMOR

	trainerclass METEORITE

	trainerclass SILHOUETTE

DEF NUM_TRAINER_CLASS_PICS EQU __trainer_class__ - 1

DEF __trainer_pal__ = 0

MACRO trainerpal
	DEF TRAINERPAL_\1 = __trainer_pal__
	DEF __trainer_pal__ += 1
ENDM

	trainerpal NONE

; kimono girls
	trainerpal SAYO
	trainerpal ZUKI
	trainerpal KUNI
	trainerpal MIKI
	trainerpal MAKO
	trainerpal AMI  ; 06
	trainerpal MINA

; elders (wise trio)
	trainerpal GAKU
	trainerpal MASA
	trainerpal KOJI

; dark-skinned or tanned trainers
	trainerpal DARK_CAMPER
	trainerpal DARK_BIRD_KEEPER
	trainerpal DARK_POKEFANF
	trainerpal DARK_LASS
	trainerpal DARK_BEAUTY
	trainerpal DARK_SCHOOLGIRL
	trainerpal DARK_COUPLE
	trainerpal DARK_RICH_BOY
	trainerpal DARK_SAILOR
	trainerpal DARK_SWIMMERM
	trainerpal DARK_SWIMMERF
	trainerpal DARK_SCIENTIST
	trainerpal DARK_TEACHER_F
	trainerpal DARK_GUITARIST_M

DEF NUM_TRAINER_PALS EQU __trainer_pal__ - 1
