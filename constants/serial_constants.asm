; wLinkMode
	const_def 2
	const LINK_TRADECENTER ; 2
	const LINK_COLOSSEUM   ; 3

SERIAL_TRADECENTER EQU $70
SERIAL_BATTLE      EQU $80

START_TRANSFER_EXTERNAL_CLOCK EQU $80 ; 1 << rSC_ON
START_TRANSFER_INTERNAL_CLOCK EQU $81 ; (1 << rSC_ON) | 1

; hSerialConnectionStatus
USING_EXTERNAL_CLOCK       EQU $01
USING_INTERNAL_CLOCK       EQU $02
CONNECTION_NOT_ESTABLISHED EQU $ff

; length of a patch list (less than any of the signal bytes)
SERIAL_PATCH_LIST_LENGTH          EQU $fc
; signals the start of an array of bytes transferred over the link cable
SERIAL_PREAMBLE_BYTE              EQU $fd
; this byte is used when there is no data to send
SERIAL_NO_DATA_BYTE               EQU $fe
; signals the end of one part of a patch list (there are two parts) for player/enemy party data
SERIAL_PATCH_LIST_PART_TERMINATOR EQU $ff

SERIAL_PREAMBLE_LENGTH EQU 6
SERIAL_RN_PREAMBLE_LENGTH EQU 7
SERIAL_RNS_LENGTH EQU 10

SERIAL_MAIL_PREAMBLE_BYTE EQU $20
SERIAL_MAIL_REPLACEMENT_BYTE EQU $21
SERIAL_MAIL_PREAMBLE_LENGTH EQU 5
