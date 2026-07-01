; radio channel ids
; indexes for:
; - RadioChannelSongs (see data/radio/channel_music.asm)
; - PlayRadioShow.Jumptable (see engine/pokegear/radio.asm)
; - RadioChannels (see engine/pokegear/pokegear.asm)
	const_def
	const OAKS_POKEMON_TALK      ; 00
	const POKEMON_MUSIC          ; 01
	const LUCKY_CHANNEL          ; 02
	const BUENAS_PASSWORD        ; 03
	const PLACES_AND_PEOPLE      ; 04
	const LETS_ALL_SING          ; 05
	const ROCKET_RADIO           ; 06
	const POKE_FLUTE_RADIO       ; 07
	const UNOWN_RADIO            ; 08
	const EVOLUTION_RADIO        ; 09
DEF NUM_RADIO_CHANNELS EQU const_value
; internal indexes for channel segments
	const OAKS_POKEMON_TALK_2    ; 0a
	const OAKS_POKEMON_TALK_3    ; 0b
	const OAKS_POKEMON_TALK_4    ; 0c
	const OAKS_POKEMON_TALK_5    ; 0d
	const OAKS_POKEMON_TALK_6    ; 0e
	const OAKS_POKEMON_TALK_7    ; 0f
	const OAKS_POKEMON_TALK_8    ; 10
	const OAKS_POKEMON_TALK_9    ; 11
	const POKEMON_MUSIC_2        ; 12
	const POKEMON_MUSIC_3        ; 13
	const POKEMON_MUSIC_4        ; 14
	const POKEMON_MUSIC_5        ; 15
	const POKEMON_MUSIC_6        ; 16
	const POKEMON_MUSIC_7        ; 17
	const LETS_ALL_SING_2        ; 18
	const LUCKY_NUMBER_SHOW_2    ; 19
	const LUCKY_NUMBER_SHOW_3    ; 1a
	const LUCKY_NUMBER_SHOW_4    ; 1b
	const LUCKY_NUMBER_SHOW_5    ; 1c
	const LUCKY_NUMBER_SHOW_6    ; 1d
	const LUCKY_NUMBER_SHOW_7    ; 1e
	const LUCKY_NUMBER_SHOW_8    ; 1f
	const LUCKY_NUMBER_SHOW_9    ; 20
	const LUCKY_NUMBER_SHOW_10   ; 21
	const LUCKY_NUMBER_SHOW_11   ; 22
	const LUCKY_NUMBER_SHOW_12   ; 23
	const LUCKY_NUMBER_SHOW_13   ; 24
	const LUCKY_NUMBER_SHOW_14   ; 25
	const LUCKY_NUMBER_SHOW_15   ; 26
	const PLACES_AND_PEOPLE_2    ; 27
	const PLACES_AND_PEOPLE_3    ; 28
	const PLACES_AND_PEOPLE_4    ; 29
	const PLACES_AND_PEOPLE_5    ; 2a
	const PLACES_AND_PEOPLE_6    ; 2b
	const PLACES_AND_PEOPLE_7    ; 2c
	const ROCKET_RADIO_2         ; 2d
	const ROCKET_RADIO_3         ; 2e
	const ROCKET_RADIO_4         ; 2f
	const ROCKET_RADIO_5         ; 30
	const ROCKET_RADIO_6         ; 31
	const ROCKET_RADIO_7         ; 32
	const ROCKET_RADIO_8         ; 33
	const ROCKET_RADIO_9         ; 34
	const ROCKET_RADIO_10        ; 35
	const OAKS_POKEMON_TALK_10   ; 36
	const OAKS_POKEMON_TALK_11   ; 37
	const OAKS_POKEMON_TALK_12   ; 38
	const OAKS_POKEMON_TALK_13   ; 39
	const OAKS_POKEMON_TALK_14   ; 3a
	const BUENAS_PASSWORD_2      ; 3b
	const BUENAS_PASSWORD_3      ; 3c
	const BUENAS_PASSWORD_4      ; 3d
	const BUENAS_PASSWORD_5      ; 3e
	const BUENAS_PASSWORD_6      ; 3f
	const BUENAS_PASSWORD_7      ; 40
	const BUENAS_PASSWORD_8      ; 41
	const BUENAS_PASSWORD_9      ; 42
	const BUENAS_PASSWORD_10     ; 43
	const BUENAS_PASSWORD_11     ; 44
	const BUENAS_PASSWORD_12     ; 45
	const BUENAS_PASSWORD_13     ; 46
	const BUENAS_PASSWORD_14     ; 47
	const BUENAS_PASSWORD_15     ; 48
	const BUENAS_PASSWORD_16     ; 49
	const BUENAS_PASSWORD_17     ; 4a
	const BUENAS_PASSWORD_18     ; 4b
	const BUENAS_PASSWORD_19     ; 4c
	const BUENAS_PASSWORD_20     ; 4d
	const BUENAS_PASSWORD_21     ; 4e
	const RADIO_SCROLL           ; 4f
DEF NUM_RADIO_SEGMENTS EQU const_value

; PlayRadioStationPointers indexes (see engine/pokegear/pokegear.asm)
	const_def
	const MAPRADIO_POKEMON_CHANNEL
	const MAPRADIO_OAKS_POKEMON_TALK
	const MAPRADIO_POKEMON_MUSIC
	const MAPRADIO_LUCKY_CHANNEL
	const MAPRADIO_UNOWN
	const MAPRADIO_PLACES_PEOPLE
	const MAPRADIO_LETS_ALL_SING
	const MAPRADIO_ROCKET
DEF NUM_MAP_RADIO_STATIONS EQU const_value

; BuenasPasswordTable sizes (see data/radio/buenas_passwords.asm)
DEF NUM_PASSWORD_CATEGORIES EQU 11
DEF NUM_PASSWORDS_PER_CATEGORY EQU 3

; GetBuenasPassword.StringFunctionJumpTable indexes (see engine/pokegear/radio.asm)
	const_def
	const BUENA_MON
	const BUENA_ITEM
	const BUENA_MOVE
	const BUENA_STRING
