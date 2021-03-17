PIANO_ROLL_HEIGHT EQU 14
PIANO_ROLL_HEIGHT_PX EQU PIANO_ROLL_HEIGHT * 8

MP_HUD_TOP EQU PIANO_ROLL_HEIGHT + 1
MP_HUD_HEIGHT EQU SCREEN_HEIGHT - PIANO_ROLL_HEIGHT

MP_LIST_CURSOR_Y EQU 8 ; (SCREEN_HEIGHT - 1) / 2
MP_LIST_PAGE_SKIP EQU 10

NUM_WAVEFORMS EQU 12
NUM_NOISE_SETS EQU 6
MAX_PITCH_TRANSPOSITION EQU 12
MAX_TEMPO_ADJUSTMENT EQU 120

	const_def
	const MP_EDIT_CH1   ; 0
	const MP_EDIT_CH2   ; 1
	const MP_EDIT_WAVE  ; 2
	const MP_EDIT_NOISE ; 3
	const MP_EDIT_PITCH ; 4
	const MP_EDIT_TEMPO ; 5
NUM_MP_EDIT_FIELDS EQU const_value

; SongOrigins indexes (see data/music_player/song_origins.asm)
	const_def
	const ORIGIN_RB        ; 00
	const ORIGIN_Y         ; 01
	const ORIGIN_GS        ; 02
	const ORIGIN_C         ; 03
	const ORIGIN_RSE       ; 04
	const ORIGIN_FRLG      ; 05
	const ORIGIN_DPPT      ; 06
	const ORIGIN_HGSS      ; 07
	const ORIGIN_BW        ; 08
	const ORIGIN_B2W2      ; 09
	const ORIGIN_XY        ; 0a
	const ORIGIN_ORAS      ; 0b
	const ORIGIN_SM        ; 0c
	const ORIGIN_STADIUM   ; 0d
	const ORIGIN_GO        ; 0e
	const ORIGIN_M02       ; 0f
	const ORIGIN_PRISM     ; 10
	const ORIGIN_UNDERTALE ; 11
NUM_SONG_ORIGINS EQU const_value

; SongArtists indexes (see data/music_player/song_artists.asm)
	const_def
	const COMPOSER_NONE                          ; 00
	const COMPOSER_JUNICHI_MASUDA                ; 01
	const COMPOSER_GO_ICHINOSE                   ; 02
	const COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE    ; 03
	const COMPOSER_MORIKAZU_AOKI                 ; 04
	const COMPOSER_SHOTA_KAGEYAMA                ; 05
	const COMPOSER_JUNICHI_MASUDA_SHOTA_KAGEYAMA ; 06
	const COMPOSER_HITOMI_SATO                   ; 07
	const COMPOSER_MINAKO_ADACHI                 ; 08
	const COMPOSER_ICHIRO_SHIMAKURA              ; 09
	const COMPOSER_JOHN_LISSAUER_RALPH_SCHUCKETT ; 0a
	const COMPOSER_FROGGESTSPIRIT                ; 0b
	const COMPOSER_MMMMMM                        ; 0c
	const COMPOSER_PUM                           ; 0d
	const COMPOSER_SHANTYTOWN                    ; 0e
	const COMPOSER_PIGU                          ; 0f
	const COMPOSER_SHOCKSLAYER                   ; 10
	const COMPOSER_MONSTARULES                   ; 11
	const COMPOSER_TRITEHEXAGON                  ; 12
	const COMPOSER_PIGU_PIKALAXALT               ; 13
	const COMPOSER_GACT_PIGU                     ; 14
	const COMPOSER_LEVUSBEVUS                    ; 15
	const COMPOSER_GACT                          ; 16
	const COMPOSER_GRONNOC                       ; 17
	const COMPOSER_CAT333POKEMON                 ; 18
	const COMPOSER_NOTFROGGESTSPIRIT             ; 19
	const COMPOSER_TOBY_FOX                      ; 1a
	const COMPOSER_SHINKONETCAVY_SHOCKSLAYER     ; 1b
NUM_SONG_ARTISTS EQU const_value
