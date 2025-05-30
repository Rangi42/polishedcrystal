; move ids
; indexes for:
; - Moves (see data/moves/moves.asm)
; - MoveNames (see data/moves/names.asm)
; - MoveDescriptions (see data/moves/descriptions.asm)
; - BattleAnimations (see data/moves/animation_pointers.asm)
	const_def
	const NO_MOVE       ; $00
	const ACROBATICS    ; $01
	const KARATE_CHOP   ; $02
	const DOUBLE_SLAP   ; $03
	const AERIAL_ACE    ; $04
	const DRAGON_CLAW   ; $05
	const PAY_DAY       ; $06
	const FIRE_PUNCH    ; $07
	const ICE_PUNCH     ; $08
	const THUNDERPUNCH  ; $09
	const SCRATCH       ; $0a
	const X_SCISSOR     ; $0b
	const NIGHT_SLASH   ; $0c
	const AIR_SLASH     ; $0d
	const SWORDS_DANCE  ; $0e
	const CUT           ; $0f
	const GUST          ; $10
	const WING_ATTACK   ; $11
	const SUCKER_PUNCH  ; $12
	const FLY           ; $13
	const DAZZLINGLEAM  ; $14
	const VOLT_SWITCH   ; $15
	const VINE_WHIP     ; $16
	const STOMP         ; $17
	const DOUBLE_KICK   ; $18
	const FLARE_BLITZ   ; $19
	const STONE_EDGE    ; $1a
	const FOCUS_BLAST   ; $1b
	const TOXIC_SPIKES  ; $1c
	const HEADBUTT      ; $1d
	const HORN_ATTACK   ; $1e
	const TRICK         ; $1f
	const HEX           ; $20
	const TACKLE        ; $21
	const BODY_SLAM     ; $22
	const WRAP          ; $23
	const TAKE_DOWN     ; $24
	const THRASH        ; $25
	const DOUBLE_EDGE   ; $26
	const HAIL          ; $27
	const POISON_STING  ; $28
	const U_TURN        ; $29
	const PIN_MISSILE   ; $2a
	const LEER          ; $2b
	const BITE          ; $2c
	const GROWL         ; $2d
	const ROAR          ; $2e
	const SING          ; $2f
	const SUPERSONIC    ; $30
	const SONIC_BOOM    ; $31
	const DISABLE       ; $32
	const ACID          ; $33
	const EMBER         ; $34
	const FLAMETHROWER  ; $35
	const CALM_MIND     ; $36
	const WATER_GUN     ; $37
	const HYDRO_PUMP    ; $38
	const SURF          ; $39
	const ICE_BEAM      ; $3a
	const BLIZZARD      ; $3b
	const PSYBEAM       ; $3c
	const BUBBLE_BEAM   ; $3d
	const AURORA_BEAM   ; $3e
	const HYPER_BEAM    ; $3f
	const PECK          ; $40
	const DRILL_PECK    ; $41
	const CLOSE_COMBAT  ; $42
	const LOW_KICK      ; $43
	const COUNTER       ; $44
	const SEISMIC_TOSS  ; $45
	const STRENGTH      ; $46
	const ABSORB        ; $47
	const MEGA_DRAIN    ; $48
	const LEECH_SEED    ; $49
	const GROWTH        ; $4a
	const RAZOR_LEAF    ; $4b
	const SOLAR_BEAM    ; $4c
	const POISONPOWDER  ; $4d
	const STUN_SPORE    ; $4e
	const SLEEP_POWDER  ; $4f
	const PETAL_DANCE   ; $50
	const STRING_SHOT   ; $51
	const DRAGON_RAGE   ; $52
	const FIRE_SPIN     ; $53
	const THUNDERSHOCK  ; $54
	const THUNDERBOLT   ; $55
	const THUNDER_WAVE  ; $56
	const THUNDER       ; $57
	const ROCK_THROW    ; $58
	const EARTHQUAKE    ; $59
	const AVALANCHE     ; $5a
	const DIG           ; $5b
	const TOXIC         ; $5c
	const CONFUSION     ; $5d
	const PSYCHIC_M     ; $5e
	const HYPNOSIS      ; $5f
	const HONE_CLAWS    ; $60
	const AGILITY       ; $61
	const QUICK_ATTACK  ; $62
	const RAGE          ; $63
	const TELEPORT      ; $64
	const NIGHT_SHADE   ; $65
	const DRAGON_PULSE  ; $66
	const SCREECH       ; $67
	const DOUBLE_TEAM   ; $68
	const RECOVER       ; $69
	const ROCK_BLAST    ; $6a
	const MINIMIZE      ; $6b
	const SMOKESCREEN   ; $6c
	const CONFUSE_RAY   ; $6d
	const AQUA_TAIL     ; $6e
	const DEFENSE_CURL  ; $6f
	const BARRIER       ; $70
	const LIGHT_SCREEN  ; $71
	const HAZE          ; $72
	const REFLECT       ; $73
	const FOCUS_ENERGY  ; $74
	const FLASH_CANNON  ; $75
	const METRONOME     ; $76
	const SCALD         ; $77
	const TRICK_ROOM    ; $78
	const SKILL_SWAP    ; $79
	const LICK          ; $7a
	const GUNK_SHOT     ; $7b
	const VENOSHOCK     ; $7c
	const EARTH_POWER   ; $7d
	const FIRE_BLAST    ; $7e
	const WATERFALL     ; $7f
	const ICICLE_CRASH  ; $80
	const SWIFT         ; $81
	const IRON_HEAD     ; $82
	const ICICLE_SPEAR  ; $83
	const BULLDOZE      ; $84
	const AMNESIA       ; $85
	const ROOST         ; $86
	const FRESH_SNACK   ; $87
	const HI_JUMP_KICK  ; $88
	const GLARE         ; $89
	const DREAM_EATER   ; $8a
	const POISON_JAB    ; $8b
	const BULLET_PUNCH  ; $8c
	const LEECH_LIFE    ; $8d
	const DRAINING_KISS ; $8e
	const BRAVE_BIRD    ; $8f
	const TRANSFORM     ; $90
	const WATER_PULSE   ; $91
	const DIZZY_PUNCH   ; $92
	const SPORE         ; $93
	const FLASH         ; $94
	const EXTRASENSORY  ; $95
	const SPLASH        ; $96
	const DRAGON_DANCE  ; $97
	const CRABHAMMER    ; $98
	const EXPLOSION     ; $99
	const FURY_STRIKES  ; $9a
	const BONEMERANG    ; $9b
	const REST          ; $9c
	const ROCK_SLIDE    ; $9d
	const HYPER_FANG    ; $9e
	const BULK_UP       ; $9f
	const CONVERSION    ; $a0
	const TRI_ATTACK    ; $a1
	const SUPER_FANG    ; $a2
	const SLASH         ; $a3
	const SUBSTITUTE    ; $a4
	const GIGA_IMPACT   ; $a5
	const SKETCH        ; $a6
	const DRAIN_PUNCH   ; $a7
	const THIEF         ; $a8
	const WILL_O_WISP   ; $a9
	const ZEN_HEADBUTT  ; $aa
	const FACADE        ; $ab
	const FLAME_CHARGE  ; $ac
	const HYPER_VOICE   ; $ad
	const CURSE         ; $ae
	const GYRO_BALL     ; $af
	const ENERGY_BALL   ; $b0
	const AEROBLAST     ; $b1
	const SEED_BOMB     ; $b2
	const REVERSAL      ; $b3
	const ASTONISH      ; $b4
	const ICE_SHARD     ; $b5
	const PROTECT       ; $b6
	const MACH_PUNCH    ; $b7
	const SCARY_FACE    ; $b8
	const FEINT_ATTACK  ; $b9
	const SWEET_KISS    ; $ba
	const BELLY_DRUM    ; $bb
	const SLUDGE_BOMB   ; $bc
	const MUD_SLAP      ; $bd
	const OCTAZOOKA     ; $be
	const SPIKES        ; $bf
	const ZAP_CANNON    ; $c0
	const FORESIGHT     ; $c1
	const DESTINY_BOND  ; $c2
	const PERISH_SONG   ; $c3
	const ICY_WIND      ; $c4
	const POWER_GEM     ; $c5
	const WILD_CHARGE   ; $c6
	const POWER_WHIP    ; $c7
	const OUTRAGE       ; $c8
	const SANDSTORM     ; $c9
	const GIGA_DRAIN    ; $ca
	const ENDURE        ; $cb
	const CHARM         ; $cc
	const ROLLOUT       ; $cd
	const FALSE_SWIPE   ; $ce
	const SWAGGER       ; $cf
	const SHELL_SMASH   ; $d0
	const SPARK         ; $d1
	const BUG_BITE      ; $d2
	const STEEL_WING    ; $d3
	const MEAN_LOOK     ; $d4
	const ATTRACT       ; $d5
	const SLEEP_TALK    ; $d6
	const HEAL_BELL     ; $d7
	const RETURN        ; $d8
	const PSYSTRIKE     ; $d9
	const BUG_BUZZ      ; $da
	const SAFEGUARD     ; $db
	const PAIN_SPLIT    ; $dc
	const SACRED_FIRE   ; $dd
	const MAGNITUDE     ; $de
	const DYNAMICPUNCH  ; $df
	const MEGAHORN      ; $e0
	const DRAGONBREATH  ; $e1
	const BATON_PASS    ; $e2
	const ENCORE        ; $e3
	const PURSUIT       ; $e4
	const RAPID_SPIN    ; $e5
	const SHADOW_CLAW   ; $e6
	const IRON_TAIL     ; $e7
	const METAL_CLAW    ; $e8
	const AURA_SPHERE   ; $e9
	const HEALINGLIGHT  ; $ea
	const HURRICANE     ; $eb
	const KNOCK_OFF     ; $ec
	const HIDDEN_POWER  ; $ed
	const CROSS_CHOP    ; $ee
	const AQUA_JET      ; $ef
	const RAIN_DANCE    ; $f0
	const SUNNY_DAY     ; $f1
	const CRUNCH        ; $f2
	const MIRROR_COAT   ; $f3
	const NASTY_PLOT    ; $f4
	const EXTREMESPEED  ; $f5
	const ANCIENTPOWER  ; $f6
	const SHADOW_BALL   ; $f7
	const FUTURE_SIGHT  ; $f8
	const ROCK_SMASH    ; $f9
if !DEF(FAITHFUL)
DEF BRICK_BREAK EQU ROCK_SMASH
endc
	const WHIRLPOOL     ; $fa
	const DARK_PULSE    ; $fb
	const MOONBLAST     ; $fc
	const PLAY_ROUGH    ; $fd
	const DISARM_VOICE  ; $fe
	const STRUGGLE      ; $ff

	const WEATHER_BALL  ; $100
	const MOONLIGHT     ; $101
	const MORNING_SUN   ; $102
	const MILK_DRINK    ; $103
	const FURY_SWIPES   ; $104
	const MYSTICAL_FIRE ; $105
	const FIRE_FANG     ; $106
	const ICE_FANG      ; $107
	const THUNDER_FANG  ; $108
	const POISON_FANG   ; $109
	const PSYCHIC_FANGS ; $10A

	const INFERNO       ; $10B
	const OVERHEAT      ; $10C
	const BLAZE_KICK    ; $10D
	const BUBBLE        ; $10E
	const MUDDY_WATER   ; $10F
	const CLAMP         ; $110
	const FLIP_TURN     ; $111
	const RAZOR_SHELL   ; $112
	const DIVE          ; $113
	const WITHDRAW      ; $114
	const LEAF_STORM    ; $115
	const COTTON_SPORE  ; $116
	const SHOCK_WAVE    ; $117
	const PSYSHOCK      ; $118
	const PSYCHO_CUT    ; $119
	const MEDITATE      ; $11A
	const ICE_BALL      ; $11B
	const DUAL_CHOP     ; $11C
	const BREAK_SWIPE   ; $11D
	const DRACO_METEOR  ; $11E
	const IRON_DEFENSE  ; $11F
	const METAL_SOUND   ; $120
	const MIRROR_SHOT   ; $121
	const MAGNET_BOMB   ; $122
	const METAL_BURST   ; $123
	const INFESTATION   ; $124
	const STRUGGLE_BUG  ; $125
	const QUIVER_DANCE  ; $126
	const ROCK_TOMB     ; $127
	const ROCK_POLISH   ; $128
	const DRILL_RUN     ; $129
	const MUD_SHOT      ; $12A
	const SAND_ATTACK   ; $12B
	const CROSS_POISON  ; $12C
	const POISON_GAS    ; $12D
	const ACID_ARMOR    ; $12E
	const BOUNCE        ; $12F
	const AIR_CUTTER    ; $130
	const POWERUPPUNCH  ; $131
	const ROLLING_KICK  ; $132
	const VITAL_THROW   ; $133
	const JUMP_KICK     ; $134
	const SUPERPOWER    ; $135
	const DETECT        ; $136

	const CONSTRICT     ; $137
	const BIND          ; $138
	const BARRAGE       ; $139
	const COMET_PUNCH   ; $13A
	const SPIKE_CANNON  ; $13B
	const POUND         ; $13C
	const FAKE_OUT      ; $13D
	const EGG_BOMB      ; $13E
	const FRUSTRATION   ; $13F
	const SELFDESTRUCT  ; $140
	const FLAIL         ; $141
	const HARDEN        ; $142
	const LOVELY_KISS   ; $143
	const TAIL_WHIP     ; $144
	const WHIRLWIND     ; $145
	const SWEET_SCENT   ; $146
	const BLOCK         ; $147
	const REVENGE       ; $148
	const VACUUM_WAVE   ; $149
	const CLEAR_SMOG    ; $14A
	const SLUDGE        ; $14B
	const SAND_TOMB     ; $14C
	const MUD_BOMB      ; $14D
	const HEAD_SMASH    ; $14E
	const TWINEEDLE     ; $150
	const FIRSTIMPRESS  ; $151
	const SILVER_WIND   ; $152
	const SIGNAL_BEAM   ; $153
	const SPIDER_WEB    ; $154
	const SHADOW_SNEAK  ; $155
	const SHADOW_PUNCH  ; $156
	const OMINOUS_WIND  ; $157
	const FLAME_WHEEL   ; $158
	const MAGICAL_LEAF  ; $159
	const BULLET_SEED   ; $15A
	const HORN_LEECH    ; $15B
	const LEAF_BLADE    ; $15C
	const WOOD_HAMMER   ; $15D
	const SOLAR_BLADE   ; $15E
	const ELECTROWEB    ; $15F
	const POWDER_SNOW   ; $160
	const TWISTER       ; $161
	const SNARL         ; $162
	const FAIRY_WIND    ; $163

	const MIST          ; $164
	const LUCKY_CHANT   ; $165
	const BRINE         ; $166
	const GASTRO_ACID   ; $167
	const SIMPLE_BEAM   ; $168
	const WORRY_SEED    ; $169
	const RECYCLE       ; $16A
	const FISSURE       ; $16B
	const GUILLOTINE    ; $16C
	const HORN_DRILL    ; $16D
	const SHEER_COLD    ; $16E
	const MAGIC_COAT    ; $16F
	const ERUPTION      ; $170
	const WATER_SPOUT   ; $171
	const NUZZLE        ; $172
	const SKULL_BASH    ; $173
	const SKY_ATTACK    ; $174
	const RAZOR_WIND    ; $175
	const ENDEAVOR      ; $176
	const LOCK_ON       ; $177
	const MIND_READER   ; $178
	const SOAK          ; $179
	const BURN_UP       ; $17A
	const GRAVITY       ; $17B
	const GRASS_KNOT    ; $17C
	const MIRROR_MOVE   ; $17D
	const INCINERATE    ; $17E
	const PLUCK         ; $17F
DEF NUM_ATTACKS EQU const_value - 1

; assert NUM_ATTACKS is less than 10-bits wide
assert NUM_ATTACKS < 1024, "NUM_ATTACKS is too large"

; Animations with negative IDs will play even when animations are disabled
	const_def -1, -1
	; These animations play no matter the battle animation settings
	; Generic "hit" animations
	const ANIM_HELD_ITEM_TRIGGER     ;  -1 (ffff)
	const ANIM_HIT_CONFUSION         ;  -2 (fffe)
	const ANIM_PLAYER_DAMAGE         ;  -3 (fffd)
	const ANIM_ENEMY_DAMAGE          ;  -4 (fffc)
	const ANIM_MISS                  ;  -5 (fffb)
	; These animations play no matter the battle animation settings
	const ANIM_GHOST_TRANSFORM       ;  -6 (fffa)
	const ANIM_RETURN_MON            ;  -7 (fff9)
	const ANIM_SEND_OUT_MON          ;  -8 (fff8)
	const ANIM_THROW_POKE_BALL       ;  -9 (fff7)

	; Pseudo-moves (replaces default move anim for certain species)
	const ANIM_SHARPEN               ; -10 (fff6)
	const ANIM_STAT_DOWN             ; -11 (fff5)
	const ANIM_STAT_UP               ; -12 (fff4)
	const ANIM_CONFUSED              ; -13 (fff3)
	const ANIM_UNDER_CURSE           ; -14 (fff2)
	const ANIM_IN_HAIL               ; -15 (fff1)
	const ANIM_IN_SANDSTORM          ; -16 (fff0)
	const ANIM_IN_LOVE               ; -17 (ffef)
	const ANIM_PAR                   ; -18 (ffee)
	const ANIM_FRZ                   ; -19 (ffed)
	const ANIM_SAP                   ; -20 (ffec)
	const ANIM_PSN                   ; -21 (ffeb)
	const ANIM_BRN                   ; -22 (ffea)
	const ANIM_SLP                   ; -23 (ffe9)
	const ANIM_HARDEN                ; -24 (ffe8)
	const ANIM_WITHDRAW              ; -25 (ffe7)
	const ANIM_MILK_DRINK            ; -26 (ffe6)
	const ANIM_FURY_ATTACK           ; -27 (ffe5)
DEF ANIM_AFFECTION EQU ANIM_IN_LOVE ; just an alias for now
DEF NUM_BATTLE_ANIMS EQU -const_value - 1
DEF FIRST_UNCONDITIONAL_ANIM EQU ANIM_THROW_POKE_BALL

; wNumHits uses offsets from ANIM_MISS
	const_def
	const BATTLEANIM_NONE
	const BATTLEANIM_ENEMY_DAMAGE
	const BATTLEANIM_PLAYER_DAMAGE
	const BATTLEANIM_HIT_CONFUSION
