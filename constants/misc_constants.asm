; Boolean checks
DEF FALSE EQU 0
DEF TRUE  EQU 1

; FlagAction arguments (see home/flag.asm)
	const_def
	const RESET_FLAG
	const SET_FLAG
	const CHECK_FLAG

; input
DEF NO_INPUT EQU %00000000

; save file corruption check values
DEF SAVE_CHECK_VALUE_1     EQU 97
DEF SAVE_CHECK_VALUE_2     EQU 127
DEF SAVE_CHECK_VALUE_1_OLD EQU 99 ; check digit before save version 7

; save file version
DEF SAVE_VERSION EQU 10

; time of day boundaries
DEF MORN_HOUR EQU  5 ; 5 AM - 9 AM (4 hours)
DEF DAY_HOUR  EQU  9 ; 9 AM - 5 PM (8 hours)
DEF EVE_HOUR  EQU 17 ; 5 PM - 9 PM (4 hours)
DEF NITE_HOUR EQU 21 ; 9 PM - 5 AM (8 hours)
DEF MAX_HOUR  EQU 24 ; 12 AM - 12 AM (24 hours)

DEF NO_RTC_SPEEDUP EQU 6

; significant money values
DEF START_MONEY EQU 3000
DEF MOM_MONEY   EQU 2300
DEF MAX_MONEY   EQU 9999999
DEF MAX_COINS   EQU 50000

; link record
DEF MAX_LINK_RECORD EQU 9999

; day-care
DEF MAX_DAY_CARE_EXP EQU $500000

; hall of fame
DEF HOF_MASTER_COUNT EQU 200

; Kirk ID
DEF KIRK_SHUCKIE_ID EQU 00518

; initial best Magikarp length (in mm)
DEF BEST_MAGIKARP_LENGTH EQU 1066

; SGB command MLT_REQ can be used to detect SGB hardware
DEF JOYP_SGB_MLT_REQ EQU %00000011

; crash error codes
	const_def
	const ERR_RST_0
	const ERR_DIV_ZERO
	const ERR_EGG_SPECIES
	const ERR_EXECUTING_RAM
	const ERR_STACK_OVERFLOW
	const ERR_STACK_UNDERFLOW
	const ERR_BT_STATE
	const ERR_CHECKSUM_MISMATCH
	const ERR_OLDBOX
	const ERR_NEWBOX
	const ERR_WINSTACK_OVERFLOW
	const ERR_CORRUPTED_SAVESTATE
DEF NUM_ERR_CODES EQU const_value
