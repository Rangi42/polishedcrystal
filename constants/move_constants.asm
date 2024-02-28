; move ids
; indexes for:
; - Moves (see data/moves/moves.asm)
; - MoveNames (see data/moves/names.asm)
; - MoveDescriptions (see data/moves/descriptions.asm)
; - BattleAnimations (see data/moves/animation_pointers.asm)
	const_def
	const NO_MOVE       ; $00
	const KARATE_CHOP   ; $01
	const DOUBLE_SLAP   ; $02
	const PAY_DAY       ; $03
	const FIRE_PUNCH    ; $04
	const ICE_PUNCH     ; $05
	const THUNDERPUNCH  ; $06
	const SCRATCH       ; $07
	const SWORDS_DANCE  ; $08
	const CUT           ; $09
	const GUST          ; $0a
	const WING_ATTACK   ; $0b
	const FLY           ; $0c
	const VINE_WHIP     ; $0d
	const STOMP         ; $0e
	const DOUBLE_KICK   ; $0f
	const HEADBUTT      ; $10
	const HORN_ATTACK   ; $11
	const TACKLE        ; $12
	const BODY_SLAM     ; $13
	const WRAP          ; $14
	const TAKE_DOWN     ; $15
	const THRASH        ; $16
	const DOUBLE_EDGE   ; $17
	const POISON_STING  ; $18
	const PIN_MISSILE   ; $19
	const LEER          ; $1a
	const BITE          ; $1b
	const GROWL         ; $1c
	const ROAR          ; $1d
	const SING          ; $1e
	const SUPERSONIC    ; $1f
	const SONIC_BOOM    ; $20
	const DISABLE       ; $21
	const ACID          ; $22
	const EMBER         ; $23
	const FLAMETHROWER  ; $24
	const WATER_GUN     ; $25
	const HYDRO_PUMP    ; $26
	const SURF          ; $27
	const ICE_BEAM      ; $28
	const BLIZZARD      ; $29
	const PSYBEAM       ; $2a
	const BUBBLE_BEAM   ; $2b
	const AURORA_BEAM   ; $2c
	const HYPER_BEAM    ; $2d
	const PECK          ; $2e
	const DRILL_PECK    ; $2f
	const LOW_KICK      ; $30
	const COUNTER       ; $31
	const SEISMIC_TOSS  ; $32
	const STRENGTH      ; $33
	const ABSORB        ; $34
	const MEGA_DRAIN    ; $35
	const LEECH_SEED    ; $36
	const GROWTH        ; $37
	const RAZOR_LEAF    ; $38
	const SOLAR_BEAM    ; $39
	const POISONPOWDER  ; $3a
	const STUN_SPORE    ; $3b
	const SLEEP_POWDER  ; $3c
	const PETAL_DANCE   ; $3d
	const STRING_SHOT   ; $3e
	const DRAGON_RAGE   ; $3f
	const FIRE_SPIN     ; $40
	const THUNDERSHOCK  ; $41
	const THUNDERBOLT   ; $42
	const THUNDER_WAVE  ; $43
	const THUNDER       ; $44
	const ROCK_THROW    ; $45
	const EARTHQUAKE    ; $46
	const DIG           ; $47
	const TOXIC         ; $48
	const CONFUSION     ; $49
	const PSYCHIC_M     ; $4a
	const HYPNOSIS      ; $4b
	const AGILITY       ; $4c
	const QUICK_ATTACK  ; $4d
	const RAGE          ; $4e
	const TELEPORT      ; $4f
	const NIGHT_SHADE   ; $50
	const SCREECH       ; $51
	const DOUBLE_TEAM   ; $52
	const RECOVER       ; $53
	const MINIMIZE      ; $54
	const SMOKESCREEN   ; $55
	const CONFUSE_RAY   ; $56
	const DEFENSE_CURL  ; $57
	const BARRIER       ; $58
	const LIGHT_SCREEN  ; $59
	const HAZE          ; $5a
	const REFLECT       ; $5b
	const FOCUS_ENERGY  ; $5c
	const METRONOME     ; $5d
	const LICK          ; $5e
	const FIRE_BLAST    ; $5f
	const WATERFALL     ; $60
	const SWIFT         ; $61
	const AMNESIA       ; $62
	const FRESH_SNACK   ; $63
	const HI_JUMP_KICK  ; $64
	const GLARE         ; $65
	const DREAM_EATER   ; $66
	const LEECH_LIFE    ; $67
	const TRANSFORM     ; $68
	const DIZZY_PUNCH   ; $69
	const SPORE         ; $6a
	const FLASH         ; $6b
	const SPLASH        ; $6c
	const CRABHAMMER    ; $6d
	const EXPLOSION     ; $6e
	const FURY_STRIKES  ; $6f
	const BONEMERANG    ; $70
	const REST          ; $71
	const ROCK_SLIDE    ; $72
	const HYPER_FANG    ; $73
	const CONVERSION    ; $74
	const TRI_ATTACK    ; $75
	const SUPER_FANG    ; $76
	const SLASH         ; $77
	const SUBSTITUTE    ; $78
	const SKETCH        ; $79
	const THIEF         ; $7a
	const CURSE         ; $7b
	const AEROBLAST     ; $7c
	const REVERSAL      ; $7d
	const PROTECT       ; $7e
	const MACH_PUNCH    ; $7f
	const SCARY_FACE    ; $80
	const FEINT_ATTACK  ; $81
	const SWEET_KISS    ; $82
	const BELLY_DRUM    ; $83
	const SLUDGE_BOMB   ; $84
	const MUD_SLAP      ; $85
	const OCTAZOOKA     ; $86
	const SPIKES        ; $87
	const ZAP_CANNON    ; $88
	const FORESIGHT     ; $89
	const DESTINY_BOND  ; $8a
	const PERISH_SONG   ; $8b
	const ICY_WIND      ; $8c
	const OUTRAGE       ; $8d
	const SANDSTORM     ; $8e
	const GIGA_DRAIN    ; $8f
	const ENDURE        ; $90
	const CHARM         ; $91
	const ROLLOUT       ; $92
	const FALSE_SWIPE   ; $93
	const SWAGGER       ; $94
	const SPARK         ; $95
	const STEEL_WING    ; $96
	const MEAN_LOOK     ; $97
	const ATTRACT       ; $98
	const SLEEP_TALK    ; $99
	const HEAL_BELL     ; $9a
	const RETURN        ; $9b
	const SAFEGUARD     ; $9c
	const PAIN_SPLIT    ; $9d
	const SACRED_FIRE   ; $9e
	const MAGNITUDE     ; $9f
	const DYNAMICPUNCH  ; $a0
	const MEGAHORN      ; $a1
	const DRAGONBREATH  ; $a2
	const BATON_PASS    ; $a3
	const ENCORE        ; $a4
	const PURSUIT       ; $a5
	const RAPID_SPIN    ; $a6
	const IRON_TAIL     ; $a7
	const METAL_CLAW    ; $a8
	const HEALINGLIGHT  ; $a9
	const HIDDEN_POWER  ; $aa
	const CROSS_CHOP    ; $ab
	const RAIN_DANCE    ; $ac
	const SUNNY_DAY     ; $ad
	const CRUNCH        ; $ae
	const MIRROR_COAT   ; $af
	const EXTREMESPEED  ; $b0
	const ANCIENTPOWER  ; $b1
	const SHADOW_BALL   ; $b2
	const FUTURE_SIGHT  ; $b3
	const ROCK_SMASH    ; $b4
if !DEF(FAITHFUL)
DEF BRICK_BREAK EQU ROCK_SMASH
endc
	const WHIRLPOOL     ; $b5

;- gen3 moves
	const HAIL          ; $b6
	const WILL_O_WISP   ; $b7
	const FACADE        ; $b8
	const TRICK         ; $b9
	const KNOCK_OFF     ; $ba
	const SKILL_SWAP    ; $bb
	const HYPER_VOICE   ; $bc
	const ASTONISH      ; $bd
	const EXTRASENSORY  ; $be
	const AERIAL_ACE    ; $bf
	const ICICLE_SPEAR  ; $c0
	const DRAGON_CLAW   ; $c1
	const BULK_UP       ; $c2
	const CALM_MIND     ; $c3
	const DRAGON_DANCE  ; $c4
	const ROCK_BLAST    ; $c5
	const WATER_PULSE   ; $c6

;- gen4 moves
	const ROOST         ; $c7
	const GYRO_BALL     ; $c8
	const U_TURN        ; $c9
	const CLOSE_COMBAT  ; $ca
	const SUCKER_PUNCH  ; $cb
	const TOXIC_SPIKES  ; $cc
	const FLARE_BLITZ   ; $cd
	const AURA_SPHERE   ; $ce
	const POISON_JAB    ; $cf
	const DARK_PULSE    ; $d0
	const NIGHT_SLASH   ; $d1
	const AQUA_TAIL     ; $d2
	const SEED_BOMB     ; $d3
	const AIR_SLASH     ; $d4
	const X_SCISSOR     ; $d5
	const BUG_BUZZ      ; $d6
	const DRAGON_PULSE  ; $d7
	const POWER_GEM     ; $d8
	const DRAIN_PUNCH   ; $d9
	const FOCUS_BLAST   ; $da
	const ENERGY_BALL   ; $db
	const BRAVE_BIRD    ; $dc
	const EARTH_POWER   ; $dd
	const GIGA_IMPACT   ; $de
	const NASTY_PLOT    ; $df
	const BULLET_PUNCH  ; $e0
	const AVALANCHE     ; $e1
	const ICE_SHARD     ; $e2
	const SHADOW_CLAW   ; $e3
	const ZEN_HEADBUTT  ; $e4
	const FLASH_CANNON  ; $e5
	const TRICK_ROOM    ; $e6
	const POWER_WHIP    ; $e7
	const GUNK_SHOT     ; $e8
	const IRON_HEAD     ; $e9
	const STONE_EDGE    ; $ea
	const BUG_BITE      ; $eb
	const AQUA_JET      ; $ec

;- gen5 moves
	const HONE_CLAWS    ; $ed
	const VENOSHOCK     ; $ee
	const FLAME_CHARGE  ; $ef
	const SCALD         ; $f0
	const SHELL_SMASH   ; $f1
	const HEX           ; $f2
	const ACROBATICS    ; $f3
	const VOLT_SWITCH   ; $f4
	const BULLDOZE      ; $f5
	const WILD_CHARGE   ; $f6
	const PSYSTRIKE     ; $f7
	const HURRICANE     ; $f8
	const ICICLE_CRASH  ; $f9

;- gen5 moves
	const DISARM_VOICE  ; $fa
	const DRAINING_KISS ; $fb
	const PLAY_ROUGH    ; $fc
	const MOONBLAST     ; $fd
	const DAZZLINGLEAM  ; $fe

;- end
	const STRUGGLE      ; $ff
DEF NUM_ATTACKS EQU const_value - 1
; Battle animations use the same constants as the moves up to this point
	; These animations don't play if battle anims are disabled.
	const_next $100
	; Pseudo-moves (replaces default move anim for certain species)
	const ANIM_FURY_ATTACK        ; $100
	const ANIM_MILK_DRINK         ; $101
	const ANIM_WITHDRAW           ; $102
	const ANIM_HARDEN             ; $103

	const ANIM_SLP                ; $104
	const ANIM_BRN                ; $105
	const ANIM_PSN                ; $106
	const ANIM_SAP                ; $107
	const ANIM_FRZ                ; $108
	const ANIM_PAR                ; $109
	const ANIM_IN_LOVE            ; $10a
	const ANIM_IN_SANDSTORM       ; $10b
	const ANIM_IN_HAIL            ; $10c
	const ANIM_UNDER_CURSE        ; $10d
	const ANIM_CONFUSED           ; $10e
	const ANIM_STAT_UP            ; $10f
	const ANIM_STAT_DOWN          ; $110
	const ANIM_SHARPEN            ; $111

	; These animations play no matter the battle animation settings
	const ANIM_THROW_POKE_BALL    ; $112
	const ANIM_SEND_OUT_MON       ; $113
	const ANIM_RETURN_MON         ; $114

	; Generic "hit" animations
	const ANIM_MISS               ; $115
	const ANIM_ENEMY_DAMAGE       ; $116
	const ANIM_PLAYER_DAMAGE      ; $117
	const ANIM_HIT_CONFUSION      ; $118
	const ANIM_HELD_ITEM_TRIGGER  ; $119

DEF ANIM_AFFECTION EQU ANIM_IN_LOVE ; just an alias for now
DEF NUM_BATTLE_ANIMS EQU const_value - 1
DEF FIRST_UNCONDITIONAL_ANIM EQU ANIM_THROW_POKE_BALL

; wNumHits uses offsets from ANIM_MISS
	const_def
	const BATTLEANIM_NONE
	const BATTLEANIM_ENEMY_DAMAGE
	const BATTLEANIM_PLAYER_DAMAGE
	const BATTLEANIM_HIT_CONFUSION
