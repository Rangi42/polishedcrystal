phone: MACRO
	db  \1, \2 ; trainer
	map_id \3 ; map
	db  \4
	dba \5 ; script 1
	db  \6
	dba \7 ; script 2
ENDM

PhoneContacts:
; entries correspond to PHONE_* constants
	table_width PHONE_CONTACT_SIZE, PhoneContacts
	phone TRAINER_NONE, PHONE_00,              N_A,                       %0000, UnusedPhoneScript,   %0000, UnusedPhoneScript
	phone TRAINER_NONE, PHONECONTACT_MOM,      PLAYERS_HOUSE_1F,          %1111, MomPhoneScript,      %0000, UnusedPhoneScript
	phone TRAINER_NONE, PHONECONTACT_BIKESHOP, OAKS_LAB,                  %0000, UnusedPhoneScript,   %0000, UnusedPhoneScript
	phone TRAINER_NONE, PHONECONTACT_BILL,     N_A,                       %1111, BillPhoneScript1,    %0000, BillPhoneScript2
	phone TRAINER_NONE, PHONECONTACT_ELM,      ELMS_LAB,                  %1111, ElmPhoneScript1,     %0000, ElmPhoneScript2
	phone TRAINER_NONE, PHONECONTACT_LYRA,     LYRAS_HOUSE_1F,            %1111, LyraPhoneScript,     %0000, LyraPhoneScript2
	phone SCHOOLBOY,    JACK1,                 NATIONAL_PARK,             %1111, JackPhoneScript1,    %1111, JackPhoneScript2
	phone POKEFANF,     BEVERLY1,              NATIONAL_PARK,             %1111, BeverlyPhoneScript1, %1111, BeverlyPhoneScript2
	phone SAILOR,       HUEY1,                 OLIVINE_LIGHTHOUSE_2F,     %1111, HueyPhoneScript1,    %1111, HueyPhoneScript2
	phone TRAINER_NONE, PHONE_00,              N_A,                       %0000, UnusedPhoneScript,   %0000, UnusedPhoneScript
	phone TRAINER_NONE, PHONE_00,              N_A,                       %0000, UnusedPhoneScript,   %0000, UnusedPhoneScript
	phone COOLTRAINERM, GAVEN1,                ROUTE_26,                  %1111, GavenPhoneScript1,   %1111, GavenPhoneScript2
	phone COOLTRAINERF, BETH1,                 ROUTE_26,                  %1111, BethPhoneScript1,    %1111, BethPhoneScript2
	phone BIRD_KEEPER,  JOSE1,                 ROUTE_27,                  %1111, JosePhoneScript1,    %1111, JosePhoneScript2
	phone COOLTRAINERF, REENA1,                ROUTE_27,                  %1111, ReenaPhoneScript1,   %1111, ReenaPhoneScript2
	phone YOUNGSTER,    JOEY1,                 ROUTE_30,                  %1111, JoeyPhoneScript1,    %1111, JoeyPhoneScript2
	phone BUG_CATCHER,  WADE1,                 ROUTE_31,                  %1111, WadePhoneScript1,    %1111, WadePhoneScript2
	phone FISHER,       RALPH1,                ROUTE_32,                  %1111, RalphPhoneScript1,   %1111, RalphPhoneScript2
	phone PICNICKER,    LIZ1,                  ROUTE_32,                  %1111, LizPhoneScript1,     %1111, LizPhoneScript2
	phone HIKER,        ANTHONY1,              ROUTE_33,                  %1111, AnthonyPhoneScript1, %1111, AnthonyPhoneScript2
	phone CAMPER,       TODD1,                 ROUTE_34,                  %1111, ToddPhoneScript1,    %1111, ToddPhoneScript2
	phone PICNICKER,    GINA1,                 ROUTE_34,                  %1111, GinaPhoneScript1,    %1111, GinaPhoneScript2
	phone JUGGLER,      IRWIN1,                ROUTE_35,                  %1111, IrwinPhoneScript1,   %1111, IrwinPhoneScript2
	phone BUG_CATCHER,  ARNIE1,                ROUTE_35,                  %1111, ArniePhoneScript1,   %1111, ArniePhoneScript2
	phone SCHOOLBOY,    ALAN1,                 ROUTE_36,                  %1111, AlanPhoneScript1,    %1111, AlanPhoneScript2
	phone TRAINER_NONE, PHONE_00,              N_A,                       %0000, UnusedPhoneScript,   %0000, UnusedPhoneScript
	phone LASS,         DANA1,                 ROUTE_38,                  %1111, DanaPhoneScript1,    %1111, DanaPhoneScript2
	phone SCHOOLBOY,    CHAD1,                 ROUTE_38,                  %1111, ChadPhoneScript1,    %1111, ChadPhoneScript2
	phone POKEFANM,     DEREK1,                ROUTE_39,                  %1111, DerekPhoneScript1,   %1111, DerekPhoneScript2
	phone FISHER,       TULLY1,                ROUTE_42,                  %1111, TullyPhoneScript1,   %1111, TullyPhoneScript2
	phone POKEMANIAC,   BRENT1,                ROUTE_43,                  %1111, BrentPhoneScript1,   %1111, BrentPhoneScript2
	phone PICNICKER,    TIFFANY1,              ROUTE_43,                  %1111, TiffanyPhoneScript1, %1111, TiffanyPhoneScript2
	phone BIRD_KEEPER,  VANCE1,                ROUTE_44,                  %1111, VancePhoneScript1,   %1111, VancePhoneScript2
	phone FISHER,       WILTON1,               ROUTE_44,                  %1111, WiltonPhoneScript1,  %1111, WiltonPhoneScript2
	phone BLACKBELT_T,  KENJI1,                ROUTE_45,                  %1111, KenjiPhoneScript1,   %1111, KenjiPhoneScript2
	phone HIKER,        PARRY1,                ROUTE_45,                  %1111, ParryPhoneScript1,   %1111, ParryPhoneScript2
	phone PICNICKER,    ERIN1,                 ROUTE_46,                  %1111, ErinPhoneScript1,    %1111, ErinPhoneScript2
	phone TRAINER_NONE, PHONECONTACT_BUENA,    GOLDENROD_DEPT_STORE_ROOF, %1111, BuenaPhoneScript1,   %1111, BuenaPhoneScript2
	assert_table_length NUM_PHONE_CONTACTS + 1
