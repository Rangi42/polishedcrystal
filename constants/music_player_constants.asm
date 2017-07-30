PIANO_ROLL_HEIGHT EQU 13
PIANO_ROLL_HEIGHT_PX EQU PIANO_ROLL_HEIGHT * 8

MP_HUD_HEIGHT EQU 5
MP_HUD_TOP EQU 14

MAX_PITCH_TRANSPOSITION EQU 12

	const_def
	const MP_EDIT_CH1   ; 0
	const MP_EDIT_CH2   ; 1
	const MP_EDIT_WAVE  ; 2
	const MP_EDIT_NOISE ; 3
	const MP_EDIT_PITCH ; 4
NUM_MP_EDIT_FIELDS EQU const_value

	const_def
	const ORIGIN_RB    ; 0
	const ORIGIN_Y     ; 1
	const ORIGIN_GS    ; 2
	const ORIGIN_C     ; 3
	const ORIGIN_RSE   ; 4
	const ORIGIN_FRLG  ; 5
	const ORIGIN_DPPT  ; 6
	const ORIGIN_HGSS  ; 7
	const ORIGIN_BW    ; 8
	const ORIGIN_B2W2  ; 9
	const ORIGIN_XY    ; a
	const ORIGIN_ORAS  ; b
	const ORIGIN_SM    ; c
	const ORIGIN_M02   ; d

	const_def
	const COMPOSER_NONE                       ; 0
	const COMPOSER_JUNICHI_MASUDA             ; 1
	const COMPOSER_GO_ICHINOSE                ; 2
	const COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE ; 3
	const COMPOSER_MORIKAZU_AOKI              ; 4
	const COMPOSER_ICHIRO_SHIMAKURA           ; 5
	const COMPOSER_SHOTA_KAGEYAMA             ; 6
	const COMPOSER_FROGGESTSPIRIT             ; 7
	const COMPOSER_MMMMMM                     ; 8
	const COMPOSER_PUM                        ; 9
	const COMPOSER_SHANTYTOWN                 ; a
	const COMPOSER_PIGU                       ; b
	const COMPOSER_PIGU_PIKALAXALT            ; c
	const COMPOSER_GACT_PIGU                  ; d
