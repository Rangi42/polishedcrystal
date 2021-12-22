; Boolean checks
FALSE EQU 0
TRUE  EQU 1

; FlagAction arguments (see home/flag.asm)
	const_def
	const RESET_FLAG
	const SET_FLAG
	const CHECK_FLAG

; save file corruption check values
SAVE_CHECK_VALUE_1     EQU 97
SAVE_CHECK_VALUE_2     EQU 127
SAVE_CHECK_VALUE_1_OLD EQU 99 ; check digit before save version 7

; save file version
SAVE_VERSION EQU 7

; time of day boundaries
MORN_HOUR EQU  5 ; 5 AM - 9 AM (4 hours)
DAY_HOUR  EQU  9 ; 9 AM - 5 PM (8 hours)
EVE_HOUR  EQU 17 ; 5 PM - 9 PM (4 hours)
NITE_HOUR EQU 21 ; 9 PM - 5 AM (8 hours)
MAX_HOUR  EQU 24 ; 12 AM - 12 AM (24 hours)

if DEF(NO_RTC)
NO_RTC_SPEEDUP EQU 6
endc

; significant money values
START_MONEY EQU 3000
MOM_MONEY   EQU 2300
MAX_MONEY   EQU 9999999
MAX_COINS   EQU 99999

; link record
MAX_LINK_RECORD EQU 9999

; day-care
MAX_DAY_CARE_EXP EQU $500000

; hall of fame
HOF_MASTER_COUNT EQU 200

; Kirk ID
KIRK_SHUCKIE_ID EQU 00518

; crash error codes
	const_def
	const ERR_RST_0
	const ERR_DIV_ZERO
	const ERR_EGG_SPECIES
	const ERR_EXECUTING_RAM
	const ERR_STACK_OVERFLOW
	const ERR_STACK_UNDERFLOW
	const ERR_BT_STATE
	const ERR_VERSION_MISMATCH
	const ERR_OLDBOX
	const ERR_NEWBOX
	const ERR_WINSTACK_OVERFLOW
