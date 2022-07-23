; wLinkMode
	const_def 2
	const LINK_TRADECENTER ; 2
	const LINK_COLOSSEUM   ; 3

; hSerialReceive high nybbles
DEF SERIAL_TRADECENTER EQU $70
DEF SERIAL_BATTLE      EQU $80

DEF ESTABLISH_CONNECTION_WITH_INTERNAL_CLOCK EQU $01
DEF ESTABLISH_CONNECTION_WITH_EXTERNAL_CLOCK EQU $02

DEF START_TRANSFER_EXTERNAL_CLOCK EQU $80 ; 1 << rSC_ON
DEF START_TRANSFER_INTERNAL_CLOCK EQU $81 ; (1 << rSC_ON) | 1

; hSerialConnectionStatus
DEF USING_EXTERNAL_CLOCK       EQU $01
DEF USING_INTERNAL_CLOCK       EQU $02
DEF CONNECTION_NOT_ESTABLISHED EQU $ff

; Similar to SERIAL_PREAMBLE_BYTE, signals the start of link polished link data.
DEF SERIAL_POLISHED_PREAMBLE_BYTE     EQU $fb
; length of a patch list (less than any of the signal bytes)
DEF SERIAL_PATCH_LIST_LENGTH          EQU $fc
; signals the start of an array of bytes transferred over the link cable
DEF SERIAL_PREAMBLE_BYTE              EQU $fd
; this byte is used when there is no data to send
DEF SERIAL_NO_DATA_BYTE               EQU $fe
; signals the end of one part of a patch list (there are two parts) for player/enemy party data
DEF SERIAL_PATCH_LIST_PART_TERMINATOR EQU $ff
; used to replace SERIAL_NO_DATA_BYTE
DEF SERIAL_PATCH_REPLACEMENT_BYTE     EQU $ff

; This is equal to (1 to 3 SERIAL_PREAMBLE_BYTE's) + 1 SERIAL_POLISHED_PREAMBLE_BYTE
DEF SERIAL_POLISHED_MAX_PREAMBLE_LENGTH EQU 4

DEF SERIAL_PREAMBLE_LENGTH    EQU 6
DEF SERIAL_RN_PREAMBLE_LENGTH EQU 7
DEF SERIAL_RNS_LENGTH         EQU 10

DEF SERIAL_MAIL_PREAMBLE_BYTE    EQU $20
DEF SERIAL_MAIL_REPLACEMENT_BYTE EQU $21
DEF SERIAL_MAIL_PREAMBLE_LENGTH  EQU 5

; timeout duration after exchanging a byte
DEF SERIAL_LINK_BYTE_TIMEOUT EQU $5000

if DEF(FAITHFUL)
	DEF LINK_GAME_ID EQU 1
else
	DEF LINK_GAME_ID EQU 2
endc

; Polished Crystal's Link Version
DEF LINK_VERSION EQU 1
; This is the minimum Link Version allowed for Trading
DEF LINK_MIN_TRADE_VERSION EQU 1
