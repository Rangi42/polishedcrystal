; wLinkMode
DEF LINK_NULL EQU 0
	const_def 2
	const LINK_TRADECENTER ; 2
	const LINK_COLOSSEUM   ; 3
	const LINK_ROOM_DUMMY  ; 4 (prevents linking with Polished Crystal before commit 35d5fafd, PR #708)

; wChosenCableClubRoom (room requests are one less than wLinkMode)
	const_def
	const CABLECLUBROOM_NULL        ; 0
	const CABLECLUBROOM_TRADECENTER ; 1
	const CABLECLUBROOM_COLOSSEUM   ; 2

; Low-nybble handshake actions; other values represent room requests/party slots.
DEF LINK_ACTION_READY         EQU $5
DEF LINK_ACTION_READY_CONFIRM EQU $6
DEF LINK_ACTION_FAILED        EQU $e
DEF LINK_ACTION_CANCEL        EQU $f

; LinkTransfer packets contain a room high nybble and an action low nybble.
DEF SERIAL_MODE_MASK   EQU $f0
DEF SERIAL_ACTION_MASK EQU $0f
; Link_EnsureSync uses this high nybble in place of a room.
DEF SERIAL_SYNC_PREAMBLE_BYTE EQU $d0

; hSerialReceive high nybbles
DEF SERIAL_TRADECENTER EQU $70
DEF SERIAL_BATTLE      EQU $80

DEF ESTABLISH_CONNECTION_WITH_INTERNAL_CLOCK EQU $01
DEF ESTABLISH_CONNECTION_WITH_EXTERNAL_CLOCK EQU $02

; hSerialConnectionStatus
DEF USING_EXTERNAL_CLOCK       EQU $01
DEF USING_INTERNAL_CLOCK       EQU $02
DEF CONNECTION_NOT_ESTABLISHED EQU $ff

; Similar to SERIAL_PREAMBLE_BYTE, signals the start of Polished-only link data.
DEF SERIAL_POLISHED_PREAMBLE_BYTE     EQU $fb
; capacity of a patch-list buffer
DEF SERIAL_PATCH_LIST_LENGTH          EQU 200
; size of each patch area (offsets must not have special values)
DEF SERIAL_PATCH_DATA_SIZE            EQU $fc
; signals the start of an array of bytes transferred over the link cable
DEF SERIAL_PREAMBLE_BYTE              EQU $fd
; this byte is used when there is no data to send
DEF SERIAL_NO_DATA_BYTE               EQU $fe
; signals the end of one part of a patch list (there are two parts) for player/enemy party data
DEF SERIAL_PATCH_LIST_PART_TERMINATOR EQU $ff
; used to replace SERIAL_NO_DATA_BYTE
DEF SERIAL_PATCH_REPLACEMENT_BYTE     EQU $ff

; This is equal to (1 to 3 SERIAL_PREAMBLE_BYTEs) + 1 SERIAL_POLISHED_PREAMBLE_BYTE
DEF SERIAL_POLISHED_MAX_PREAMBLE_LENGTH EQU 4

DEF SERIAL_PREAMBLE_LENGTH       EQU 6
DEF SERIAL_RN_PREAMBLE_LENGTH    EQU 7 ; preamble allowance in the exchange window
DEF SERIAL_RN_SEND_PREAMBLE_LENGTH EQU 4 ; Polished's actual prepared RNG preamble
DEF SERIAL_PATCH_PREAMBLE_LENGTH EQU 3
DEF SERIAL_RNS_LENGTH            EQU 10

; Polished Crystal sends one unused byte after the party payload.
DEF SERIAL_PADDING_LENGTH EQU 1

DEF SERIAL_MAIL_PREAMBLE_BYTE    EQU $20
DEF SERIAL_MAIL_REPLACEMENT_BYTE EQU $21
DEF SERIAL_MAIL_PREAMBLE_LENGTH  EQU 5

; timeout duration after exchanging a byte
DEF SERIAL_LINK_BYTE_TIMEOUT EQU $5000

; all unique game IDs for the Polished Crystal engine
	const_def 1
	const LINK_GAME_ID_PC_FAITHFUL     ; 1
	const LINK_GAME_ID_PC_NON_FAITHFUL ; 2

; this game's ID, and the other ID that it can still trade with
if DEF(FAITHFUL)
	DEF LINK_GAME_ID EQU LINK_GAME_ID_PC_FAITHFUL
	DEF OTHER_GAME_ID EQU LINK_GAME_ID_PC_NON_FAITHFUL
else
	DEF LINK_GAME_ID EQU LINK_GAME_ID_PC_NON_FAITHFUL
	DEF OTHER_GAME_ID EQU LINK_GAME_ID_PC_FAITHFUL
endc

; this game's link version
DEF LINK_VERSION EQU 5
; This is the minimum link version allowed for trading
; Older versions use a different party patch-list origin.
DEF LINK_MIN_TRADE_VERSION EQU 5

; CheckCorrectLinkVersion return values
	const_def
	const LINK_VERSION_INCOMPATIBLE ; 0
	const LINK_VERSION_COMPATIBLE   ; 1
	const LINK_VERSION_PEER_TOO_OLD ; 2
	const LINK_VERSION_SELF_TOO_OLD ; 3

; PerformLinkChecks error codes
	const_def
	const LINK_ERR_OLD_PC_DETECT         ; 0
	const LINK_ERR_SUCCESS               ; 1
	const LINK_ERR_MISMATCH_GAME_ID      ; 2
	const LINK_ERR_MISMATCH_VERSION      ; 3
	const LINK_ERR_VERSION_TOO_LOW       ; 4
	const LINK_ERR_OTHER_VERSION_TOO_LOW ; 5
	const LINK_ERR_MISMATCH_GAME_OPTIONS ; 6
	const LINK_ERR_INCOMPATIBLE_ROOMS    ; 7
