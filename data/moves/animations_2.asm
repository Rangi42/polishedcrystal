BattleAnim_StoneEdge:
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_ROCKS
	anim_sound 0, 0, SFX_SPARK
	anim_obj ANIM_OBJ_STONE_EDGE_STILL, 156, 64, $8
	anim_wait 1
	anim_obj ANIM_OBJ_STONE_EDGE_STILL, 152, 64, $8
	anim_wait 1
	anim_sound 0, 0, SFX_SPARK
	anim_obj ANIM_OBJ_STONE_EDGE_STILL, 128, 64, $8
	anim_wait 1
	anim_obj ANIM_OBJ_STONE_EDGE_STILL, 108, 64, $8
	anim_wait 1
	anim_sound 0, 0, SFX_SPARK
	anim_obj ANIM_OBJ_STONE_EDGE_STILL, 112, 64, $8
	anim_wait 1
	anim_obj ANIM_OBJ_STONE_EDGE_STILL, 148, 64, $8
	anim_wait 1
	anim_sound 0, 0, SFX_SPARK
	anim_obj ANIM_OBJ_STONE_EDGE_STILL, 118, 64, $8
	anim_wait 1
	anim_obj ANIM_OBJ_STONE_EDGE_STILL, 136, 64, $8
	anim_wait 1
	anim_sound 0, 0, SFX_SPARK
	anim_obj ANIM_OBJ_STONE_EDGE_STILL, 116, 64, $8
	anim_wait 1
	anim_obj ANIM_OBJ_STONE_EDGE_STILL, 144, 64, $8
	anim_wait 32
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_STONE_EDGE, 156, 64, $8
	anim_wait 2
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $55, $1, $0
	anim_obj ANIM_OBJ_STONE_EDGE, 152, 64, $8
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_STONE_EDGE, 128, 64, $8
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 120, 40, $0
	anim_wait 2
	anim_obj ANIM_OBJ_STONE_EDGE, 108, 64, $8
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_STONE_EDGE, 112, 64, $8
	anim_wait 2
	anim_obj ANIM_OBJ_STONE_EDGE, 148, 64, $8
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 152, 48, $0
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_STONE_EDGE, 118, 64, $8
	anim_wait 2
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_obj ANIM_OBJ_STONE_EDGE, 136, 64, $8
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_STONE_EDGE, 116, 64, $8
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 136, 56, $0
	anim_wait 2
	anim_obj ANIM_OBJ_STONE_EDGE, 144, 64, $8
	anim_wait 32
	anim_ret


BattleAnim_Trick:
	anim_1gfx ANIM_GFX_STATUS
	anim_clearopponenthud
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_sound 0, 1, SFX_GET_COIN_FROM_SLOTS
	anim_obj ANIM_OBJ_TRICK, 90, 68, $18
	anim_obj ANIM_OBJ_TRICK, 90, 68, $38
	anim_wait 16
.loop
	anim_sound 0, 1, SFX_STOP_SLOT
	anim_wait 32
	anim_loop 4, .loop
	anim_wait 7
	anim_sound 0, 1, SFX_SLOT_MACHINE_START
	anim_incobj 1
	anim_incobj 2
	anim_wait 6
	anim_clearobjs
	anim_wait 6
	anim_ret

BattleAnim_RollingKick:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_KICK,  14, 0,   7, 0, $0
	anim_setobj $1, $3
	anim_wait 12
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   6, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_HornDrill:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_2gfx ANIM_GFX_HORN, ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $40
	anim_obj ANIM_OBJ_HORN, 72, 80, $3
	anim_wait 8
.loop
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 132, 40, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 140, 48, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 132, 56, $0
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 124, 48, $0
	anim_wait 8
	anim_loop 3, .loop
	anim_ret


BattleAnim_TailWhip:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_2Row_2
	anim_sound 0, 0, SFX_TAIL_WHIP
	anim_bgeffect ANIM_BG_WOBBLE_MON, $0, $1, $0
	anim_wait 32
	anim_incbgeffect ANIM_BG_WOBBLE_MON
	anim_call BattleAnim_ShowMon_0_2
	anim_ret

BattleAnim_Twineedle:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_2gfx ANIM_GFX_HORN, ANIM_GFX_HIT
	anim_sound 0, 1, SFX_POISON_STING
	anim_obj ANIM_OBJ_NEEDLE,   8, 0,  11, 4, $14
	anim_obj ANIM_OBJ_NEEDLE,   7, 0,  10, 4, $14
	anim_wait 16
	anim_sound 0, 1, SFX_POISON_STING
	anim_obj ANIM_OBJ_HIT_SMALL, -15, 0,   7, 0, $0
	anim_obj ANIM_OBJ_HIT_SMALL,  16, 0,   6, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_Fissure:
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $40
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $4, $0
.loop
	anim_sound 0, 1, SFX_EMBER
	anim_wait 24
	anim_loop 4, .loop
	anim_ret

BattleAnim_Meditate:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row_2
	anim_sound 0, 0, SFX_PSYBEAM
	anim_bgeffect ANIM_BG_WAVE_DEFORM_MON, $0, $1, $0
	anim_wait 48
	anim_incbgeffect ANIM_BG_WAVE_DEFORM_MON
	anim_wait 48
	anim_call BattleAnim_ShowMon_0_2
	anim_ret

BattleAnim_Withdraw:
	anim_1gfx ANIM_GFX_REFLECT
	anim_call BattleAnim_TargetObj_2Row_2
	anim_bgeffect ANIM_BG_WITHDRAW, $0, $1, $50
	anim_wait 48
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_WITHDRAW,   6, 0,  11, 0, $0
	anim_wait 64
	anim_incobj 2
	anim_wait 1
	anim_incbgeffect ANIM_BG_WITHDRAW
	anim_call BattleAnim_ShowMon_0_2
	anim_ret

BattleAnim_Harden:
	anim_1gfx ANIM_GFX_REFLECT
	anim_obp0 $0
	anim_call BattleAnim_TargetObj_1Row_2
	anim_call BattleAnimSub_Metallic_2
	anim_call BattleAnim_ShowMon_0_2
	anim_ret

BattleAnim_Selfdestruct:
	anim_1gfx ANIM_GFX_EXPLOSION
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $24
	anim_jumpif $1, .loop
	anim_call BattleAnimSub_Explosion2_2
	anim_wait 16
	anim_bgp $e4
	anim_ret

.loop
	anim_call BattleAnimSub_Explosion1_2
	anim_wait 5
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_loop 2, .loop
	anim_wait 16
	anim_bgp $e4
	anim_ret

BattleAnim_EggBomb:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_2gfx ANIM_GFX_EGG, ANIM_GFX_EXPLOSION
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj ANIM_OBJ_EGG_BOMB, 48, 80, $28
	anim_wait 32
	anim_clearobjs
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $3
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION2, 128, 64, $0
	anim_wait 8
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION2, 144, 68, $0
	anim_wait 8
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION2, 136, 72, $0
	anim_wait 24
	anim_ret

BattleAnim_Clamp:
	anim_2gfx ANIM_GFX_CUT, ANIM_GFX_HIT
	anim_obj ANIM_OBJ_CLAMP, 136, 56, $a0
	anim_obj ANIM_OBJ_CLAMP, 136, 56, $20
	anim_wait 16
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_YFIX, 144, 48, $18
	anim_wait 32
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_YFIX, 128, 64, $18
	anim_wait 16
	anim_ret

BattleAnim_SkullBash:
	anim_1gfx ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_wait 32
	anim_call BattleAnim_TargetObj_1Row_2
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $3
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 4
.loop
	anim_sound 0, 1, SFX_HEADBUTT
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 8
	anim_loop 3, .loop
	anim_call BattleAnim_ShowMon_0_2
	anim_ret

BattleAnim_SpikeCannon:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_2gfx ANIM_GFX_HORN, ANIM_GFX_HIT
	anim_sound 0, 1, SFX_MEGA_PUNCH
.loop
	anim_obj ANIM_OBJ_MEDIUM_HORN, 52, 88, $18
	anim_wait 12
	anim_obj ANIM_OBJ_MEDIUM_HORN, 64, 92, $18
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_HIT, 130, 50, $0
	anim_wait 12
	anim_obj ANIM_OBJ_MEDIUM_HORN, 56, 84, $18
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_HIT, 136, 56, $0
	anim_wait 12
	anim_obj ANIM_OBJ_MEDIUM_HORN, 60, 96, $18
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_HIT, 128, 48, $0
	anim_wait 12
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_HIT, 137, 57, $0
	anim_wait 16
	anim_ret

BattleAnim_Constrict:
	anim_1gfx ANIM_GFX_ROPE
	anim_sound 0, 1, SFX_BIND
	anim_obj ANIM_OBJ_BIND2, -16, 4,   8, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_BIND1, -16, 4,   6, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_BIND2, -16, 4,   5, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_BIND1, -16, 4,   7, 0, $0
	anim_wait 64
	anim_ret

BattleAnim_PoisonGas:
	anim_1gfx ANIM_GFX_HAZE
	anim_sound 16, 2, SFX_BUBBLE_BEAM
.loop
	anim_obj ANIM_OBJ_POISON_GAS,   5, 4,  10, 0, $2
	anim_wait 8
	anim_loop 10, .loop
	anim_wait 128
	anim_ret

BattleAnim_Barrage:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_2gfx ANIM_GFX_EGG, ANIM_GFX_EXPLOSION
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj ANIM_OBJ_SLUDGE_BOMB,   8, 0,  11, 4, $10
	anim_wait 36
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION2, -15, 0,   7, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_Sludge:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_1gfx ANIM_GFX_POISON
	anim_jump BattleAnimSub_Sludge_2

BattleAnim_LovelyKiss:
	anim_2gfx ANIM_GFX_OBJECTS, ANIM_GFX_ANGELS
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj ANIM_OBJ_LOVELY_KISS, -13, 0,   5, 0, $0
	anim_wait 32
	anim_sound 0, 1, SFX_LICK
	anim_obj ANIM_OBJ_HEART,  16, 0,   5, 0, $0
	anim_wait 40
	anim_ret

BattleAnim_SkyAttack:
	anim_jumpif $1, BattleAnim_FocusEnergy_2
	anim_1gfx ANIM_GFX_SKY_ATTACK
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_bgeffect ANIM_BG_REMOVE_MON, $0, $1, $0
	anim_wait 8
	anim_sound 0, 0, SFX_HYPER_BEAM
	anim_obj ANIM_OBJ_SKY_ATTACK, 48, 88, $40
	anim_wait 64
	anim_incobj 1
	anim_wait 21
	anim_sound 0, 1, SFX_HYPER_BEAM
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_wait 64
	anim_incobj 1
	anim_wait 32
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 16
	anim_ret

BattleAnim_AcidArmor:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_2Row_2
	anim_bgeffect ANIM_BG_ACID_ARMOR, $0, $1, $8
	anim_sound 0, 0, SFX_MEGA_PUNCH
	anim_wait 64
	anim_incbgeffect ANIM_BG_ACID_ARMOR
	anim_jump BattleAnim_ShowMon_0_2

BattleAnim_Bubble:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BUBBLE
	anim_1gfx ANIM_GFX_BUBBLE
	anim_sound 32, 2, SFX_WATER_GUN
	anim_obj ANIM_OBJ_BUBBLE, 64, 92, $b1
	anim_wait 6
	anim_sound 32, 2, SFX_WATER_GUN
	anim_obj ANIM_OBJ_BUBBLE, 64, 92, $91
	anim_wait 6
	anim_sound 32, 2, SFX_WATER_GUN
	anim_obj ANIM_OBJ_BUBBLE, 64, 92, $c1
	anim_wait 6
	anim_sound 32, 2, SFX_WATER_GUN
	anim_obj ANIM_OBJ_BUBBLE, 64, 92, $81
	anim_wait 6
	anim_sound 32, 2, SFX_WATER_GUN
	anim_obj ANIM_OBJ_BUBBLE, 64, 92, $a1
	anim_wait 106
	anim_ret

BattleAnim_SpiderWeb:
	anim_1gfx ANIM_GFX_WEB
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj ANIM_OBJ_SPIDER_WEB, -16, 4,   6, 0, $0
	anim_sound 6, 2, SFX_SPIDER_WEB
	anim_obj ANIM_OBJ_STRING_SHOT,   8, 0,  10, 0, $0
	anim_wait 4
	anim_obj ANIM_OBJ_STRING_SHOT,   8, 0,  11, 0, $0
	anim_wait 4
	anim_obj ANIM_OBJ_STRING_SHOT,   8, 0,  10, 4, $0
	anim_wait 64
	anim_ret

BattleAnim_FlameWheel:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_FIRE
	anim_1gfx ANIM_GFX_FIRE
.loop
	anim_sound 0, 0, SFX_EMBER
	anim_obj ANIM_OBJ_FLAME_WHEEL, 48, 96, $0
	anim_wait 6
	anim_loop 8, .loop
	anim_wait 96
	anim_call BattleAnim_TargetObj_1Row_2
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 4
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $3
.hit
	anim_sound 0, 1, SFX_EMBER
	anim_obj ANIM_OBJ_FIRE_BLAST, 136, 48, $1
	anim_obj ANIM_OBJ_FIRE_BLAST, 136, 48, $4
	anim_obj ANIM_OBJ_FIRE_BLAST, 136, 48, $5
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 4
	anim_incobj 9
	anim_wait 8
	anim_ret

BattleAnim_Flail:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row_2
	anim_sound 0, 0, SFX_SUBMISSION
	anim_bgeffect ANIM_BG_FLAIL, $0, $1, $0
	anim_wait 8
	anim_obj ANIM_OBJ_HIT_YFIX, 120, 48, $0
	anim_wait 8
	anim_obj ANIM_OBJ_HIT_YFIX, 152, 48, $0
	anim_wait 8
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 8
	anim_incbgeffect ANIM_BG_FLAIL
	anim_call BattleAnim_ShowMon_0_2
	anim_ret

BattleAnim_PowderSnow:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_SNOW
	anim_1gfx ANIM_GFX_ICE
.loop
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_POWDER_SNOW, 64, 88, $23
	anim_wait 2
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_POWDER_SNOW, 64, 80, $24
	anim_wait 2
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_POWDER_SNOW, 64, 96, $23
	anim_wait 2
	anim_loop 2, .loop
	anim_bgeffect ANIM_BG_WHITE_HUES, $0, $8, $0
	anim_wait 40
	anim_call BattleAnimSub_Ice_2
	anim_wait 32
	anim_ret

BattleAnim_Detect:
	anim_1gfx ANIM_GFX_SHINE
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 0, SFX_FORESIGHT
	anim_obj ANIM_OBJ_FORESIGHT,   8, 0,  11, 0, $0
	anim_wait 24
	anim_ret

BattleAnim_Frustration:
	anim_1gfx ANIM_GFX_MISC
	anim_sound 0, 0, SFX_KINESIS_2
	anim_obj ANIM_OBJ_ANGER, 72, 80, $0
	anim_wait 40
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row_2
	anim_bgeffect ANIM_BG_WOBBLE_MON, $0, $1, $0
	anim_wait 8
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, 120, 48, $0
	anim_wait 8
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, 152, 48, $0
	anim_wait 8
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 8
	anim_incbgeffect ANIM_BG_WOBBLE_MON
	anim_wait 1
	anim_jump BattleAnim_ShowMon_0_2

BattleAnim_SweetScent:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_PINK
	anim_2gfx ANIM_GFX_FLOWER, ANIM_GFX_MISC
	anim_sound 0, 0, SFX_SWEET_SCENT
	anim_obj ANIM_OBJ_FLOWER, 64, 96, $2
	anim_wait 2
	anim_obj ANIM_OBJ_FLOWER, 64, 80, $2
	anim_wait 96
	anim_obp0 $54
	anim_sound 0, 1, SFX_SWEET_SCENT_2
	anim_obj ANIM_OBJ_COTTON, 136, 40, $15
	anim_obj ANIM_OBJ_COTTON, 136, 40, $2a
	anim_obj ANIM_OBJ_COTTON, 136, 40, $3f
	anim_wait 128
	anim_ret

BattleAnim_VitalThrow:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row_2
	anim_bgeffect ANIM_BG_VITAL_THROW, $0, $1, $0
	anim_wait 16
	anim_sound 0, 0, SFX_MENU
	anim_obj ANIM_OBJ_HIT, 64, 96, $0
	anim_wait 8
	anim_sound 0, 0, SFX_MENU
	anim_obj ANIM_OBJ_HIT, 56, 88, $0
	anim_wait 8
	anim_sound 0, 0, SFX_MENU
	anim_obj ANIM_OBJ_HIT, 68, 104, $0
	anim_wait 8
	anim_incbgeffect ANIM_BG_VITAL_THROW
	anim_wait 16
	anim_call BattleAnim_ShowMon_0_2
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT_BIG, 132, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_Twister:
	anim_2gfx ANIM_GFX_WIND, ANIM_GFX_HIT
.loop1
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_GUST, 64, 112, $0
	anim_wait 6
	anim_loop 9, .loop1
.loop2
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_wait 8
	anim_loop 8, .loop2
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_incobj 4
	anim_incobj 5
	anim_incobj 6
	anim_incobj 7
	anim_incobj 8
	anim_incobj 9
	anim_wait 64
	anim_obj ANIM_OBJ_HIT_YFIX, 144, 64, $18
.loop3
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_wait 8
	anim_loop 4, .loop3
	anim_obj ANIM_OBJ_HIT_YFIX, 128, 32, $18
.loop4
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_wait 8
	anim_loop 4, .loop4
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_incobj 4
	anim_incobj 5
	anim_incobj 6
	anim_incobj 7
	anim_incobj 8
	anim_incobj 9
	anim_wait 32
	anim_ret

BattleAnim_FakeOut:
	anim_1gfx ANIM_GFX_OBJECTS
	anim_obj ANIM_OBJ_FAKE_OUT_L, 112, 48, $0
	anim_obj ANIM_OBJ_FAKE_OUT_R, 158, 48, $20
	anim_wait 32
	anim_sound 0, 0, SFX_DOUBLE_SLAP
	anim_incobj 1
	anim_incobj 2
	anim_wait 4
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $2
	anim_clearobjs
	anim_wait 1
	anim_sound 0, 0, SFX_RAGE
	anim_obj ANIM_OBJ_FAKE_OUT_L, 112, 48, $0
	anim_obj ANIM_OBJ_FAKE_OUT_R, 158, 48, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_wait 32
	anim_ret

BattleAnim_Superpower:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_FIRE
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_2Row_2
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
.loop
	anim_sound 0, 0, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_FOCUS, 44, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 36, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 52, 108, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 28, 108, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 60, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 20, 108, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 68, 108, $8
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 8
	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_incbgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $40
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_sound 0, 0, SFX_SPARK
	anim_wait 16
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 4
	anim_clearobjs
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 1
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $4, $10
.loop2
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_wait 20
	anim_loop 3, .loop2
	anim_wait 16
	anim_ret

BattleAnim_MagicCoat:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_YELLOW
	anim_2gfx ANIM_GFX_SPEED, ANIM_GFX_REFLECT
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, 72, 80, $30
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, 72, 80, $31
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, 72, 80, $32
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, 72, 80, $33
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, 72, 80, $34
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, 72, 80, $35
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, 72, 80, $36
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, 72, 80, $37
	anim_obj ANIM_OBJ_SCREEN, 72, 80, $0
	anim_wait 24
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SCREEN, 72, 80, $0
	anim_wait 24
	anim_clearobjs
	anim_wait 40
	anim_ret

BattleAnim_Recycle:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_RECYCLE
	anim_1gfx ANIM_GFX_RECYCLE
	anim_sound 0, 0, SFX_SHARPEN
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_obj ANIM_OBJ_RECYCLE, 48, 88, $0
	anim_wait 104
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_ret

BattleAnim_Revenge:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_2Row_2
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
.loop
	anim_sound 0, 0, SFX_SWORDS_DANCE
	anim_wait 14
	anim_loop 3, .loop
	anim_wait 32
	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_bgeffect ANIM_BG_BODY_SLAM, $0, $1, $0
	anim_wait 8
	anim_call BattleAnim_ShowMon_0_2
	anim_clearobjs
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, 120, 64, $0
	anim_wait 2
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, 126, 56, $0
	anim_wait 2
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, 130, 48, $0
	anim_wait 2
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, 133, 40, $0
	anim_wait 1
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $3
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 32, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_wait 32
	anim_ret

BattleAnim_Endeavor:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_MISC_2
	anim_call BattleAnim_TargetObj_2Row_2
	anim_bgeffect ANIM_BG_BOUNCE_DOWN, $0, $1, $0
	anim_sound 0, 0, SFX_RETURN
	anim_obj ANIM_OBJ_DROPLET_R, 64, 102, $3b
	anim_obj ANIM_OBJ_DROPLET_L, 44, 102, $24
	anim_wait 21
	anim_sound 0, 0, SFX_RETURN
	anim_obj ANIM_OBJ_DROPLET_R, 64, 82, $3b
	anim_obj ANIM_OBJ_DROPLET_L, 44, 82, $24
	anim_wait 21
	anim_sound 0, 0, SFX_RETURN
	anim_obj ANIM_OBJ_DROPLET_R, 64, 102, $3b
	anim_obj ANIM_OBJ_DROPLET_L, 44, 102, $24
	anim_wait 21
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_incbgeffect ANIM_BG_BOUNCE_DOWN
	anim_call BattleAnim_ShowMon_0_2
	anim_clearobjs
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_Eruption:
	anim_setobjpal PAL_BATTLE_OB_BROWN, PAL_BTLCUSTOM_LAVA_ROCKS
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_2gfx ANIM_GFX_LAVA_ROCKS, ANIM_GFX_FIRE
	anim_call BattleAnim_TargetObj_2Row_2
	anim_bgeffect ANIM_BG_WITHDRAW, $0, $1, $50
	anim_wait 8
	anim_sound 0, 1, SFX_OUTRAGE
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_wait 64
	anim_incbgeffect ANIM_BG_WITHDRAW
	anim_call BattleAnim_Eruption_branch
	anim_bgeffect ANIM_BG_WITHDRAW, $0, $1, $50
	anim_wait 24
	anim_incbgeffect ANIM_BG_WITHDRAW
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_call BattleAnim_Eruption_branch
	anim_wait 16
	anim_call BattleAnim_ShowMon_0_2
	anim_clearobjs
	anim_obj ANIM_OBJ_ROCK_TOMB, 128, 70, $30
	anim_wait 12
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $4, $4, $0
	anim_obj ANIM_OBJ_ROCK_TOMB, 152, 70, $30
	anim_wait 12
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $4, $4, $0
	anim_obj ANIM_OBJ_ROCK_TOMB, 112, 70, $30
	anim_wait 12
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $4, $4, $0
	anim_obj ANIM_OBJ_ROCK_TOMB, 120, 68, $30
	anim_wait 12
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $4, $4, $0
	anim_obj ANIM_OBJ_ROCK_TOMB, 144, 68, $30
	anim_wait 12
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $4, $4, $0
	anim_wait 32
	anim_ret

BattleAnim_Dive:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_MISC_2
	anim_jumpif $0, .hit
	anim_jumpif $2, .fail
	anim_call BattleAnim_TargetObj_2Row_2
	anim_bgeffect ANIM_BG_BOUNCE_DOWN, $0, $1, $0
	anim_sound 0, 0, SFX_WATER_GUN
	anim_wait 16
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_wait 8
	anim_incbgeffect ANIM_BG_BOUNCE_DOWN
	anim_obj ANIM_OBJ_DROPLET_R, 64, 92, $3b
	anim_obj ANIM_OBJ_DROPLET_L, 44, 92, $24
	anim_call BattleAnim_ShowMon_0_2
	anim_wait 40
	anim_ret
.hit
	anim_3gfx ANIM_GFX_HIT, ANIM_GFX_BUBBLE, ANIM_GFX_MISC_2
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_WATER
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BUBBLE
	anim_sound 0, 1, SFX_BUBBLE_BEAM
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 56, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 56, $50
	anim_wait 3
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 48, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 48, $50
	anim_wait 3
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 40, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 40, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 40, $50
	anim_wait 3
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 32, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 32, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 32, $50
	anim_wait 3
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 24, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 24, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 24, $50
	anim_wait 8
.fail
	anim_bgeffect ANIM_BG_ENTER_MON, $0, $1, $0
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_obj ANIM_OBJ_DROPLET_R, 64, 92, $3b
	anim_obj ANIM_OBJ_DROPLET_L, 44, 92, $24
	anim_wait 16
	anim_ret

BattleAnim_BlazeKick:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_FIRE
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $20, $2, $0
	anim_wait 32
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $3
	anim_sound 0, 1, SFX_EMBER
	anim_obj ANIM_OBJ_KICK, 136, 56, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 6
	anim_obj ANIM_OBJ_KICK, 136, 56, $0
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $0
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $28
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $30
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $38
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $20
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $8
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $18
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $4
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $2b
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $14
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $3b
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $24
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $b
	anim_wait 32
	anim_ret

BattleAnim_IceBall:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_2gfx ANIM_GFX_ICE, ANIM_GFX_HIT
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj ANIM_OBJ_ICE_BALL, 64, 92, $10
	anim_wait 36
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 8
	anim_call BattleAnim_IceBall_branch
	anim_wait 32
	anim_ret

BattleAnim_WeatherBall:
	anim_2gfx ANIM_GFX_WEATHER_BALL, ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_ATTRACT
	anim_obj ANIM_OBJ_WEATHER_BALL_RISE, 48, 88, $32
	anim_wait 64
	anim_clearobjs

	; default to NORMAL
	anim_jumpif $1, .water
	anim_jumpif $2, .fire
	anim_jumpif $3, .rock
	anim_jumpif $4, .ice

	; NORMAL
	anim_sound 0, 0, SFX_METRONOME
	anim_obj ANIM_OBJ_WEATHER_BALL_FALL, 112, 188, $0e
	anim_wait 80
	anim_sound 0, 1, SFX_HEADBUTT
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_wait 16
	anim_ret

.water
	anim_3gfx ANIM_GFX_WEATHER_BALL, ANIM_GFX_HIT, ANIM_GFX_BUBBLE
	anim_bgeffect ANIM_BG_FLASH_WHITE, $0, $4, $2
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_WATER
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BUBBLE
	anim_sound 0, 0, SFX_SWEET_KISS
	anim_obj ANIM_OBJ_WEATHER_BALL_FALL, 112, 188, $0e
	anim_wait 16
	anim_sound 0, 0, SFX_METRONOME
	anim_wait 64
	anim_sound 0, 0, SFX_TOXIC
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 136, 56, $28
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 136, 56, $5c
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 136, 56, $10
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 136, 56, $e8
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 136, 56, $9c
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 136, 56, $d0
	anim_wait 6
	anim_sound 0, 0, SFX_TOXIC
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 136, 56, $1c
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 136, 56, $50
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 136, 56, $dc
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 136, 56, $90
	anim_wait 16
	anim_ret

.fire
	anim_3gfx ANIM_GFX_WEATHER_BALL, ANIM_GFX_HIT, ANIM_GFX_FIRE
	anim_bgeffect ANIM_BG_FLASH_WHITE, $0, $4, $2
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_sound 0, 0, SFX_SWEET_KISS
	anim_obj ANIM_OBJ_WEATHER_BALL_FALL, 112, 188, $0e
	anim_wait 16
	anim_sound 0, 0, SFX_METRONOME
	anim_wait 64
	anim_sound 0, 0, SFX_BURN
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $6
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $16
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $26
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $36
	anim_wait 6
	anim_sound 0, 0, SFX_BURN
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $e
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $1e
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $2e
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $3e
	anim_wait 16
	anim_ret

.rock
	anim_3gfx ANIM_GFX_WEATHER_BALL, ANIM_GFX_HIT, ANIM_GFX_ROCKS
	anim_bgeffect ANIM_BG_FLASH_WHITE, $0, $4, $2
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BROWN
	anim_sound 0, 0, SFX_SWEET_KISS
	anim_obj ANIM_OBJ_WEATHER_BALL_FALL, 112, 188, $0e
	anim_wait 16
	anim_sound 0, 0, SFX_METRONOME
	anim_wait 64
	anim_sound 6, 2, SFX_SPARK
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $28
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $5c
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $10
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $e8
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $9c
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $d0
	anim_wait 6
	anim_sound 6, 2, SFX_SPARK
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $1c
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $50
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $dc
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $90
	anim_wait 16
	anim_ret

.ice
	anim_3gfx ANIM_GFX_WEATHER_BALL, ANIM_GFX_HIT, ANIM_GFX_ICE
	anim_bgeffect ANIM_BG_FLASH_WHITE, $0, $4, $2
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_ICE
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_sound 0, 0, SFX_SWEET_KISS
	anim_obj ANIM_OBJ_WEATHER_BALL_FALL, 112, 188, $0e
	anim_wait 16
	anim_sound 0, 0, SFX_METRONOME
	anim_wait 64
	anim_call BattleAnim_IceBall_branch
	anim_wait 16
	anim_ret

BattleAnim_AirCutter:
	anim_2gfx ANIM_GFX_WHIP, ANIM_GFX_HIT
	anim_call BattleAnim_UserObj_2Row_2
	anim_bgeffect ANIM_BG_WOBBLE_MON, $0, $0, $0
.loop
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_AIR_CUTTER, 64, 80, $18
	anim_wait 4
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_AIR_CUTTER, 64, 96, $18
	anim_wait 4
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_AIR_CUTTER, 64, 88, $18
	anim_wait 4
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_AIR_CUTTER, 64, 104, $18
	anim_wait 4
	anim_loop 3, .loop
	anim_wait 32
	anim_incbgeffect ANIM_BG_WOBBLE_MON
	anim_jump BattleAnim_ShowMon_1_2

BattleAnim_Overheat:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_2gfx ANIM_GFX_FIRE, ANIM_GFX_SMOKE_PUFF
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_sound 0, 0, SFX_OUTRAGE
	anim_wait 72
	anim_setobjpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_FIRE
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $44, $2, $0
	anim_sound 0, 0, SFX_EMBER
.loop
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $0
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $28
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $30
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $38
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $20
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $8
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $18
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $4
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $2b
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $14
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $3b
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $24
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 88, $b
	anim_wait 12
	anim_clearobjs
	anim_loop 5, .loop
	anim_sound 0, 0, SFX_BURN
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $6
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $2c
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $10
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $1d
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 56, $39
	anim_wait 16
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_obp0 $fc
	anim_setobjpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_CHARRED
	anim_setobjpal PAL_BATTLE_BG_TARGET, PAL_BTLCUSTOM_CHARRED
	anim_sound 0, 0, SFX_BALL_POOF
.loop2
	anim_obj ANIM_OBJ_OVERHEAT_SMOKE, 36, 84, $30
	anim_obj ANIM_OBJ_OVERHEAT_SMOKE, 120, 46, $30
	anim_wait 1
	anim_obj ANIM_OBJ_OVERHEAT_SMOKE, 60, 96, $30
	anim_obj ANIM_OBJ_OVERHEAT_SMOKE, 144, 34, $30
	anim_wait 8
	anim_loop 6, .loop2
	anim_wait 32
	anim_ret

BattleAnim_RockTomb:
	anim_2gfx ANIM_GFX_ROCKS, ANIM_GFX_OBJECTS
	anim_obj ANIM_OBJ_ROCK_TOMB, 128, 70, $30
	anim_wait 18
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $4, $2, $0
	anim_obj ANIM_OBJ_ROCK_TOMB, 152, 68, $30
	anim_wait 18
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $4, $2, $0
	anim_obj ANIM_OBJ_ROCK_TOMB, 112, 68, $30
	anim_wait 18
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $4, $2, $0
	anim_obj ANIM_OBJ_ROCK_TOMB, 136, 66, $30
	anim_wait 18
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $20, $2, $0
	anim_wait 40
	anim_clearobjs
	anim_sound 6, 3, SFX_PLACE_PUZZLE_PIECE_DOWN
	anim_obj ANIM_OBJ_RED_X, 132, 44, $2e
	anim_wait 32
	anim_ret

BattleAnim_SilverWind:
	anim_2gfx ANIM_GFX_HAZE, ANIM_GFX_SPEED
	anim_sound 0, 1, SFX_GAME_FREAK_LOGO_GS
	anim_bgp $90
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_GRAY
	anim_obj ANIM_OBJ_MIST_BALL_BG, 8, 24, $10
	anim_obj ANIM_OBJ_MIST_BALL_BG, 8, 48, $2
	anim_obj ANIM_OBJ_MIST_BALL_BG, 8, 88, $8
	anim_wait 4
	anim_obj ANIM_OBJ_MIST_BALL_BG, 8, 56, $c
	anim_obj ANIM_OBJ_MIST_BALL_BG, 8, 80, $4
	anim_wait 16
	anim_obj ANIM_OBJ_WIND_SPARKLE, 96, 80, $1
	anim_wait 16
	anim_obj ANIM_OBJ_WIND_SPARKLE, 80, 56, $1
	anim_wait 16
	anim_obj ANIM_OBJ_WIND_SPARKLE, 48, 64, $1
	anim_wait 16
	anim_obj ANIM_OBJ_WIND_SPARKLE, 64, 32, $1
	anim_wait 16
	anim_obj ANIM_OBJ_WIND_SPARKLE, 32, 72, $1
	anim_wait 32
	anim_ret

BattleAnim_MetalSound:
	anim_1gfx ANIM_GFX_PSYCHIC
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $16, $1, $20
	anim_sound 6, 2, SFX_UNKNOWN_5F
.loop
	anim_obj ANIM_OBJ_WAVE, 64, 88, $2
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 62
	anim_ret

BattleAnim_WaterSpout:
	anim_2gfx ANIM_GFX_WATER, ANIM_GFX_HIT
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_WATER
.loop
	anim_sound 0, 0, SFX_WATER_GUN
	anim_obj ANIM_OBJ_WATER_SPOUT_RISING, 48, 80, $30
	anim_wait 2
	anim_obj ANIM_OBJ_WATER_SPOUT_RISING, 52, 80, $30
	anim_wait 2
	anim_sound 0, 0, SFX_WATER_GUN
	anim_obj ANIM_OBJ_WATER_SPOUT_RISING, 48, 80, $30
	anim_wait 2
	anim_obj ANIM_OBJ_WATER_SPOUT_RISING, 46, 80, $30
	anim_wait 2
	anim_sound 0, 0, SFX_WATER_GUN
	anim_obj ANIM_OBJ_WATER_SPOUT_RISING, 48, 80, $30
	anim_wait 2
	anim_obj ANIM_OBJ_WATER_SPOUT_RISING, 54, 80, $30
	anim_wait 2
	anim_sound 0, 0, SFX_WATER_GUN
	anim_obj ANIM_OBJ_WATER_SPOUT_RISING, 48, 80, $30
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 32
	anim_sound 0, 0, SFX_BUBBLE_BEAM
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 108, 1, $10
	anim_wait 2
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 156, 1, $10
	anim_wait 2
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 116, 1, $10
	anim_wait 2
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $55, $1, $0
.loop2
	anim_obj ANIM_OBJ_HIT_YFIX, 108, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 150, 1, $10
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 156, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 124, 1, $10
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 116, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 140, 1, $10
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 150, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 132, 1, $10
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 124, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 108, 1, $10
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 140, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 156, 1, $10
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 132, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 116, 1, $10
	anim_wait 2
	anim_loop 2, .loop2
	anim_obj ANIM_OBJ_HIT_YFIX, 108, 68, $0
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 156, 68, $0
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 116, 68, $0
	anim_wait 2
	anim_wait 32
	anim_ret

BattleAnim_SignalBeam:
	anim_1gfx ANIM_GFX_GLOW
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_SIGNAL_BEAM_RED
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_SIGNAL_BEAM_BLUE
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
.loop
	anim_sound 0, 0, SFX_SPITE
	anim_obj ANIM_OBJ_SIGNAL_BEAM_R, 64, 92, $0
	anim_wait 4
	anim_sound 0, 0, SFX_SPITE
	anim_obj ANIM_OBJ_SIGNAL_BEAM_B, 64, 92, $0
	anim_wait 4
	anim_sound 0, 0, SFX_SPITE
	anim_obj ANIM_OBJ_SIGNAL_BEAM_R, 64, 92, $0
	anim_wait 4
	anim_sound 0, 0, SFX_SPITE
	anim_obj ANIM_OBJ_SIGNAL_BEAM_B, 64, 92, $0
	anim_wait 4
	anim_loop 4, .loop
	anim_wait 64
	anim_ret

BattleAnim_ShadowPunch:
	anim_1gfx ANIM_GFX_HIT
	anim_battlergfx_2row
	anim_bgp $1b
	anim_sound 6, 2, SFX_CURSE
	anim_wait 32
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $0, $0
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 4
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_SIDE_PUNCH, 88, 56, $0
	anim_wait 8
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 32
	anim_jump BattleAnim_ShowMon_0_2

BattleAnim_SandTomb:
	anim_1gfx ANIM_GFX_POWDER
	anim_bgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING, $0, $0, $40
.loop
	anim_sound 0, 0, SFX_MENU
	anim_obj ANIM_OBJ_SAND_TOMB, 136, 70, $0
	anim_wait 4
	anim_sound 0, 0, SFX_MENU
	anim_obj ANIM_OBJ_SAND_TOMB, 136, 62, $0
	anim_wait 4
	anim_loop 7, .loop
	anim_wait 40
	anim_incbgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING
	anim_jump BattleAnim_ShowMon_1_2

BattleAnim_SheerCold:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_1gfx ANIM_GFX_ICE
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 16, 36, $0
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 40, 96, $0
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 64, 26, $0
	anim_wait 4
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 80, 64, $0
	anim_wait 4
	anim_obj ANIM_OBJ_ICE_BUILDUP, 136, 74, $10
	anim_bgp $90
	anim_setbgpal PAL_BATTLE_BG_TARGET, PAL_BTLCUSTOM_ICE
.loop
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 108, 88, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 112, 31, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 138, 68, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 144, 110, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 154, 40, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 16, 36, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 40, 96, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 64, 26, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, 80, 64, $0
	anim_wait 2
	anim_loop 4, .loop
	anim_sound 0, 1, SFX_CUT
	anim_bgp $0b
	anim_wait 80
	anim_ret

BattleAnim_BulletSeed:
	anim_2gfx ANIM_GFX_PLANT, ANIM_GFX_HIT    
	anim_sound 0, 1, SFX_BONE_CLUB
.loop
	anim_obj ANIM_OBJ_BULLET_SEED, 64, 90, $6
	anim_wait 7
	anim_obj ANIM_OBJ_BULLET_SEED, 64, 90, $6
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 7
	anim_obj ANIM_OBJ_BULLET_SEED, 64, 90, $6
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 7
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_loop 3, .loop
	anim_wait 16
	anim_ret

BattleAnim_IronDefense:
	anim_1gfx ANIM_GFX_REFLECT
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_METALLIC
	anim_obp0 $0
	anim_call BattleAnim_TargetObj_1Row_2
.loop
	anim_bgp $90
	anim_sound 0, 0, SFX_FORESIGHT
	anim_obj ANIM_OBJ_HARDEN, 48, 84, $0
	anim_wait 6
	anim_bgp $f8
	anim_wait 6
	anim_loop 5, .loop
	anim_wait 6
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_DEFAULT
	anim_jump BattleAnim_ShowMon_0_2

BattleAnim_Block:
	anim_1gfx ANIM_GFX_OBJECTS
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_BLOCK, 132, 48, $20
	anim_wait 48
	anim_sound 0, 1, SFX_WRONG
	anim_wait 20
	anim_ret

BattleAnim_Bounce:
	anim_jumpif $1, BattleAnim_Bounce_branch_1
	anim_jumpif $2, BattleAnim_Bounce_branch_2
	anim_2gfx ANIM_GFX_HIT_2, ANIM_GFX_BLUR
	anim_sound 0, 0, SFX_KINESIS
	anim_obj ANIM_OBJ_BLUR_VERTICAL_DOWN, 136, 230, $10
	anim_wait 16
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $10, $4, $0
	anim_sound 0, 1, SFX_STOMP
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 16
BattleAnim_Bounce_branch_2:
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 16
	anim_ret

BattleAnim_Bounce_branch_1:
	anim_1gfx ANIM_GFX_BLUR
	anim_sound 0, 0, SFX_POTION
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_obj ANIM_OBJ_BLUR_VERTICAL_UP, 48, 88, $30
	anim_wait 32
	anim_clearobjs
	anim_ret

BattleAnim_MudShot:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BROWN
	anim_1gfx ANIM_GFX_POISON
.loop
	anim_sound 6, 2, SFX_BUBBLE_BEAM
	anim_obj ANIM_OBJ_MUD_SHOT, 64, 92, $4
	anim_wait 4
	anim_obj ANIM_OBJ_MUD_SHOT, 64, 92, $4
	anim_wait 4
	anim_sound 6, 2, SFX_BUBBLE_BEAM
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $5c
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $e8
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $d0
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $50
	anim_obj ANIM_OBJ_MUD_SHOT, 64, 92, $4
	anim_wait 4
	anim_obj ANIM_OBJ_MUD_SHOT, 64, 92, $4
	anim_wait 4
	anim_loop 4, .loop
	anim_wait 4
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $5c
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $e8
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $d0
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $50
	anim_wait 16
	anim_ret

BattleAnim_MagicalLeaf:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_AURORA
	anim_1gfx ANIM_GFX_PLANT
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW_FULL_SHIFT, $0, $2, $0
	anim_sound 0, 0, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_RAZOR_LEAF, 48, 80, $28
	anim_obj ANIM_OBJ_RAZOR_LEAF, 48, 80, $5c
	anim_obj ANIM_OBJ_RAZOR_LEAF, 48, 80, $10
	anim_obj ANIM_OBJ_RAZOR_LEAF, 48, 80, $e8
	anim_obj ANIM_OBJ_RAZOR_LEAF, 48, 80, $9c
	anim_obj ANIM_OBJ_RAZOR_LEAF, 48, 80, $d0
	anim_wait 6
	anim_obj ANIM_OBJ_RAZOR_LEAF, 48, 80, $1c
	anim_obj ANIM_OBJ_RAZOR_LEAF, 48, 80, $50
	anim_obj ANIM_OBJ_RAZOR_LEAF, 48, 80, $dc
	anim_obj ANIM_OBJ_RAZOR_LEAF, 48, 80, $90
	anim_wait 80
	anim_sound 16, 2, SFX_SWEET_SCENT
	anim_incobj 3
	anim_wait 2
	anim_sound 16, 2, SFX_SWEET_SCENT
	anim_incobj 5
	anim_wait 2
	anim_sound 16, 2, SFX_SWEET_SCENT
	anim_incobj 7
	anim_wait 2
	anim_sound 16, 2, SFX_SWEET_SCENT
	anim_incobj 9
	anim_wait 2
	anim_sound 16, 2, SFX_SWEET_SCENT
	anim_incobj 1
	anim_wait 2
	anim_sound 16, 2, SFX_SWEET_SCENT
	anim_incobj 2
	anim_wait 2
	anim_sound 16, 2, SFX_SWEET_SCENT
	anim_incobj 4
	anim_wait 2
	anim_sound 16, 2, SFX_SWEET_SCENT
	anim_incobj 6
	anim_wait 2
	anim_sound 16, 2, SFX_SWEET_SCENT
	anim_incobj 8
	anim_wait 2
	anim_sound 16, 2, SFX_SWEET_SCENT
	anim_incobj 10
	anim_wait 64
	anim_ret

BattleAnim_LeafBlade:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_GREEN
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GREEN
	anim_2gfx ANIM_GFX_CUT, ANIM_GFX_PLANT
	anim_sound 0, 1, SFX_CUT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $08, $2, $0
	anim_obj ANIM_OBJ_CUT_LONG_DOWN_LEFT, 150, 40, $0
	anim_obj ANIM_OBJ_RAZOR_LEAF, 136, 40, $28
	anim_obj ANIM_OBJ_RAZOR_LEAF, 136, 40, $d0
	anim_wait 32
	anim_sound 0, 1, SFX_CUT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $08, $2, $0
	anim_obj ANIM_OBJ_CUT_LONG_DOWN_RIGHT, 118, 40, $0
	anim_obj ANIM_OBJ_RAZOR_LEAF, 136, 40, $10
	anim_obj ANIM_OBJ_RAZOR_LEAF, 136, 40, $dc
	anim_wait 32
	anim_sound 0, 1, SFX_CUT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $08, $2, $0
	anim_obj ANIM_OBJ_CUT_LONG_UP_RIGHT, 120, 68, $0
	anim_obj ANIM_OBJ_RAZOR_LEAF, 136, 40, $5c
	anim_obj ANIM_OBJ_RAZOR_LEAF, 136, 40, $90
	anim_wait 32
	anim_ret

BattleAnim_ShockWave:
	anim_2gfx ANIM_GFX_LIGHTNING, ANIM_GFX_CHARGE
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $3, $0
	anim_sound 0, 0, SFX_WARP_TO
	anim_obj ANIM_OBJ_ENERGY_ORB, 48, 88, $38
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 48, 88, $20
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 48, 88, $8
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 48, 88, $10
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 48, 88, $28
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 48, 88, $0
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 48, 88, $18
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 48, 88, $30
	anim_wait 4
.loop
	anim_sound 0, 0, SFX_ZAP_CANNON
	anim_obj ANIM_OBJ_SHOCK_WAVE_UP, 48, 88, $30
	anim_wait 2
	anim_loop 5, .loop
	anim_wait 2
.loop2
	anim_obj ANIM_OBJ_SHOCK_WAVE_DOWN, 64, 0, $10
	anim_wait 2
	anim_loop 5, .loop2
	anim_wait 2
.loop3
	anim_sound 0, 0, SFX_ZAP_CANNON
	anim_obj ANIM_OBJ_SHOCK_WAVE_UP, 80, 72, $30
	anim_wait 2
	anim_loop 5, .loop3
	anim_wait 2
.loop4
	anim_obj ANIM_OBJ_SHOCK_WAVE_DOWN, 96, 0, $10
	anim_wait 2
	anim_loop 5, .loop4
	anim_wait 2
.loop5
	anim_sound 0, 0, SFX_ZAP_CANNON
	anim_obj ANIM_OBJ_SHOCK_WAVE_UP, 112, 72, $30
	anim_wait 2
	anim_loop 5, .loop5
	anim_wait 8
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_THUNDER
	anim_obj ANIM_OBJ_SHOCK_WAVE_STRIKE, 136, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_THUNDER_CENTER, 136, 68, $0
	anim_wait 48
	anim_ret

BattleAnim_Gravity:
	anim_clearopponenthud
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAVITY
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAVITY
	anim_2gfx ANIM_GFX_VORTEX, ANIM_GFX_WIND_BG
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_sound 0, 1, SFX_WARP_TO
	anim_obj ANIM_OBJ_VORTEX, 44, 96, $0
	anim_wait 32
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_Y, $80, $1, $20
	anim_sound 0, 1, SFX_GRAVITY
	anim_obj ANIM_OBJ_SKY_UPPERCUT,  12, 36, $10
	anim_obj ANIM_OBJ_SKY_UPPERCUT,  40, 133, $10
	anim_obj ANIM_OBJ_SKY_UPPERCUT,  68, 67, $10
	anim_obj ANIM_OBJ_SKY_UPPERCUT,  96, 11, $10
	anim_obj ANIM_OBJ_SKY_UPPERCUT, 122, 109, $10
	anim_obj ANIM_OBJ_SKY_UPPERCUT, 140, 162, $10
	anim_wait 32
	anim_bgeffect ANIM_BG_BLACK_HUES, $0, $8, $0
	anim_wait 24
	anim_incobj 1
	anim_sound 0, 1, SFX_SHUT_DOWN_PC
	anim_bgeffect ANIM_BG_WITHDRAW_ALL, $0, $1, $50
	anim_wait 96
	anim_incbgeffect ANIM_BG_WITHDRAW_ALL
	anim_ret

BattleAnim_Brine:
	anim_2gfx ANIM_GFX_WATER, ANIM_GFX_HIT
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_WATER
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_sound 0, 0, SFX_SURF
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 128, 1, $11
	anim_wait 2
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 136, 1, $0f
	anim_wait 2
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $1, $0
.loop
	anim_obj ANIM_OBJ_HIT_YFIX, 124, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 124, 1, $11
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 140, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 140, 1, $0f
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 120, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 120, 1, $11
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 144, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 144, 1, $0f
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 116, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 116, 1, $11
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 148, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 148, 1, $0f
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 112, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 128, 1, $11
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 152, 68, $0
	anim_obj ANIM_OBJ_WATER_SPOUT_FALLING, 136, 1, $0f
	anim_wait 2
	anim_loop 4, .loop
	anim_obj ANIM_OBJ_HIT_YFIX, 124, 68, $0
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 140, 68, $0
	anim_wait 2
	anim_sound 0, 0, SFX_TOXIC
	anim_bgeffect ANIM_BG_START_WATER, $0, $0, $0
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $1, $0
	anim_wait 1
	anim_bgeffect ANIM_BG_WATER, $1c, $0, $0
	anim_wait 7
	anim_sound 0, 0, SFX_TOXIC
	anim_wait 8
	anim_sound 0, 0, SFX_TOXIC
	anim_wait 11
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_bgeffect ANIM_BG_END_WATER, $0, $0, $0
	anim_wait 8
	anim_ret

BattleAnim_MetalBurst:
	anim_2gfx ANIM_GFX_SHINE, ANIM_GFX_HIT
	anim_bgp $1b
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_MEGA_KICK
	anim_obj ANIM_OBJ_METAL_BURST, 44, 92, $0
	anim_wait 1
	anim_obj ANIM_OBJ_METAL_BURST, 28, 90, $0
	anim_wait 1
	anim_sound 0, 0, SFX_MEGA_KICK
	anim_obj ANIM_OBJ_METAL_BURST, 38, 82, $0
	anim_wait 1
	anim_obj ANIM_OBJ_METAL_BURST, 46, 104, $0
	anim_wait 1
	anim_sound 0, 0, SFX_MEGA_KICK
	anim_obj ANIM_OBJ_METAL_BURST, 32, 102, $0
	anim_wait 1
	anim_obj ANIM_OBJ_METAL_BURST, 58, 98, $0
	anim_wait 1
	anim_sound 0, 0, SFX_MEGA_KICK
	anim_obj ANIM_OBJ_METAL_BURST, 54, 78, $0
	anim_wait 1
	anim_obj ANIM_OBJ_METAL_BURST, 62, 88, $0
	anim_wait 50
	anim_sound 0, 0, SFX_RAGE
	anim_obj ANIM_OBJ_METAL_BURST_DEBRIS, 46, 96, $38
	anim_wait 2
	anim_sound 0, 0, SFX_RAGE
	anim_obj ANIM_OBJ_METAL_BURST_DEBRIS, 28, 90, $20
	anim_wait 2
	anim_sound 0, 0, SFX_RAGE
	anim_obj ANIM_OBJ_METAL_BURST_DEBRIS, 38, 82, $28
	anim_wait 2
	anim_sound 0, 0, SFX_RAGE
	anim_obj ANIM_OBJ_METAL_BURST_DEBRIS, 44, 92, $0
	anim_wait 2
	anim_sound 0, 0, SFX_RAGE
	anim_obj ANIM_OBJ_METAL_BURST_DEBRIS, 32, 100, $18
	anim_wait 2
	anim_sound 0, 0, SFX_RAGE
	anim_obj ANIM_OBJ_METAL_BURST_DEBRIS, 58, 104, $10
	anim_wait 2
	anim_sound 0, 0, SFX_RAGE
	anim_obj ANIM_OBJ_METAL_BURST_DEBRIS, 54, 78, $38
	anim_wait 2
	anim_sound 0, 0, SFX_RAGE
	anim_obj ANIM_OBJ_METAL_BURST_DEBRIS, 62, 92, $8
	anim_wait 36
	anim_sound 0, 0, SFX_HEADBUTT
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 140, 44, $0
	anim_wait 2
	anim_sound 0, 0, SFX_HEADBUTT
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 124, 60, $0
	anim_wait 2
	anim_sound 0, 0, SFX_HEADBUTT
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 140, 60, $0
	anim_wait 2
	anim_sound 0, 0, SFX_HEADBUTT
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 124, 44, $0
	anim_wait 2
	anim_sound 0, 0, SFX_HEADBUTT
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 132, 52, $0
	anim_wait 40
	anim_ret

BattleAnim_GastroAcid:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GASTRO_ACID
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GASTRO_ACID
	anim_1gfx ANIM_GFX_POISON
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $1, $0
	anim_sound 6, 2, SFX_AEROBLAST
	anim_obj ANIM_OBJ_ACID, 64, 92, $10
	anim_wait 36
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $5c
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $e8
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $d0
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $50
	anim_wait 8
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
	anim_bgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING, $0, $0, $40
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_POISON_DROPLET, 128, 32, $11
	anim_wait 2
	anim_obj ANIM_OBJ_POISON_DROPLET, 144, 32, $0f
	anim_wait 2
	anim_obj ANIM_OBJ_POISON_DROPLET, 124, 32, $11
	anim_wait 2
	anim_obj ANIM_OBJ_POISON_DROPLET, 148, 32, $0f
	anim_wait 2
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_POISON_DROPLET, 120, 32, $11
	anim_wait 2
	anim_obj ANIM_OBJ_POISON_DROPLET, 152, 32, $0f
	anim_wait 2
	anim_obj ANIM_OBJ_POISON_DROPLET, 132, 32, $11
	anim_wait 2
	anim_obj ANIM_OBJ_POISON_DROPLET, 140, 32, $0f
	anim_wait 22
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 8
	anim_incbgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING
	anim_wait 8
	anim_clearobjs
	anim_ret

BattleAnim_LuckyChant:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_PAYBACK
	anim_3gfx ANIM_GFX_BIG_GLOW_CLEAR, ANIM_GFX_STARS, ANIM_GFX_SPEED
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_METRONOME
	anim_obj ANIM_OBJ_LUCKY_CHANT, 44, 88, $0
	anim_obj ANIM_OBJ_LUCKY_CHANT, 44, 88, $8
	anim_obj ANIM_OBJ_LUCKY_CHANT, 44, 88, $10
	anim_obj ANIM_OBJ_LUCKY_CHANT, 44, 88, $18
	anim_obj ANIM_OBJ_LUCKY_CHANT, 44, 88, $20
	anim_obj ANIM_OBJ_LUCKY_CHANT, 44, 88, $28
	anim_obj ANIM_OBJ_LUCKY_CHANT, 44, 88, $30
	anim_obj ANIM_OBJ_LUCKY_CHANT, 44, 88, $38
	anim_wait 96
	anim_clearobjs
	anim_wait 1
	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_sound 0, 0, SFX_GAME_FREAK_PRESENTS
	anim_obj ANIM_OBJ_BIG_GLOW_CLEAR, 48, 96, $0
	anim_wait 6
	anim_clearobjs
	anim_obj ANIM_OBJ_RISING_SPARKLE, 44, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_RISING_SPARKLE, 36, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_RISING_SPARKLE, 52, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_RISING_SPARKLE, 28, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_RISING_SPARKLE, 60, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_RISING_SPARKLE, 20, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_RISING_SPARKLE, 68, 108, $6
	anim_wait 2
	anim_wait 48
	anim_ret

BattleAnim_WorrySeed:
	anim_3gfx ANIM_GFX_PLANT, ANIM_GFX_DEPRESSION, ANIM_GFX_SMOKE
	anim_sound 0, 0, SFX_BONE_CLUB
	anim_obj ANIM_OBJ_WORRY_SEED, 64, 92, $10
	anim_wait 40
	anim_sound 0, 1, SFX_JUMP_OVER_LEDGE
	anim_obj ANIM_OBJ_BALL_POOF_YFIX, 136, 56, $0
	anim_wait 16
	anim_setobjpal PAL_BATTLE_BG_TARGET, PAL_BTLCUSTOM_GRAY
	anim_sound 0, 1, SFX_SLUDGE_BOMB
	anim_obj ANIM_OBJ_DEPRESSION, 116, 32, $0
	anim_wait 64
	anim_ret

BattleAnim_RockPolish:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_GRAY
	anim_2gfx ANIM_GFX_ROCK_POLISH, ANIM_GFX_SPEED
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_FADE_MON_TO_BLACK, $0, $1, $40
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_85DEG_R_Y_FLIP, 52, 88, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_5DEG_L_Y_FLIP, 40, 100, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_45DEG_R, 48, 96, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_5DEG_L, 56, 96, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_85DEG_L_Y_FLIP, 36, 84, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_45DEG_R_Y_FLIP, 60, 96, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_5DEG_R, 52, 88, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_85DEG_R, 40, 100, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_45DEG_L, 48, 96, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_85DEG_L, 56, 96, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_5DEG_R_Y_FLIP, 36, 84, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ROCK_POLISH_45DEG_L_Y_FLIP, 60, 96, $0
	anim_wait 8
	anim_sound 0, 0, SFX_METRONOME
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 32, 72, $0
	anim_wait 5
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 64, 104, $0
	anim_wait 5
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 32, 104, $0
	anim_wait 5
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 64, 72, $0
	anim_wait 5
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 48, 88, $0
	anim_wait 5
	anim_wait 16
	anim_ret

BattleAnim_VacuumWave:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_VERY_BRIGHT
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_VERY_BRIGHT
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_BIG_GLOW_CLEAR
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_PUNCH, 136, 52, $0
	anim_wait 8
	anim_obj ANIM_OBJ_VACUUM_SHRINKING, 136, 52, $0
	anim_wait 8
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT, 136, 52, $0
	anim_wait 32
	anim_ret

BattleAnim_ThunderFang:
	anim_3gfx ANIM_GFX_CUT, ANIM_GFX_HIT, ANIM_GFX_LIGHTNING
	anim_obj ANIM_OBJ_BITE, 136, 56, $98
	anim_obj ANIM_OBJ_BITE, 136, 56, $18
	anim_wait 8
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_BIG, 136, 56, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_wait 8
	anim_clearobjs
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $2
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 1, SFX_THUNDER
	anim_obj ANIM_OBJ_THUNDER_RIGHT, 152, 68, $0
	anim_wait 32
	anim_ret

BattleAnim_IceFang:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_3gfx ANIM_GFX_CUT, ANIM_GFX_HIT, ANIM_GFX_ICE
	anim_obj ANIM_OBJ_BITE, 136, 56, $98
	anim_obj ANIM_OBJ_BITE, 136, 56, $18
	anim_wait 8
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_BIG, 136, 56, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_wait 8
	anim_clearobjs
	anim_call BattleAnim_IceBall_branch
	anim_wait 32
	anim_ret

BattleAnim_FireFang:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_3gfx ANIM_GFX_CUT, ANIM_GFX_HIT, ANIM_GFX_FIRE
	anim_obj ANIM_OBJ_BITE, 136, 56, $98
	anim_obj ANIM_OBJ_BITE, 136, 56, $18
	anim_wait 8
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_BIG, 136, 56, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_wait 8
	anim_clearobjs
	anim_wait 1
	anim_sound 0, 0, SFX_BURN
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $6
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $16
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $26
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $36
	anim_wait 6
	anim_sound 0, 0, SFX_BURN
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $e
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $1e
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $2e
	anim_obj ANIM_OBJ_RADIAL_FLAME_SLOW, 136, 48, $3e
	anim_wait 32
	anim_ret

BattleAnim_IceBall_branch:
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $28
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $5c
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $10
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $e8
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $9c
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $d0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $1c
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $50
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $dc
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $90
	anim_ret

BattleAnim_Eruption_branch:
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_ERUPTION_BIG_ROCK, 48, 88, $32
	anim_obj ANIM_OBJ_ERUPTION_SMALL_FLAME, 58, 88, $5c
	anim_obj ANIM_OBJ_ERUPTION_SMALL_FLAME, 38, 88, $e8
	anim_obj ANIM_OBJ_ERUPTION_SMALL_FLAME, 38, 88, $d0
	anim_obj ANIM_OBJ_ERUPTION_SMALL_FLAME, 58, 88, $50
	anim_wait 2
	anim_obj ANIM_OBJ_ERUPTION_SMALL_ROCK, 48, 88, $30
	anim_wait 2
	anim_obj ANIM_OBJ_ERUPTION_BIG_ROCK, 48, 88, $2e
	anim_wait 2
	anim_obj ANIM_OBJ_ERUPTION_BIG_ROCK, 48, 88, $31
	anim_wait 2
	anim_obj ANIM_OBJ_ERUPTION_SMALL_ROCK, 48, 88, $33
	anim_wait 2
	anim_obj ANIM_OBJ_ERUPTION_BIG_ROCK, 48, 88, $2f
	anim_wait 2
	anim_obj ANIM_OBJ_ERUPTION_SMALL_ROCK, 48, 88, $30
	anim_wait 16
	anim_ret

BattleAnimSub_Ice_2:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE,  16, 0,   5, 2, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, -14, 0,   8, 6, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE,  15, 0,   7, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, -13, 0,   7, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE, -14, 0,   5, 2, $0
	anim_wait 6
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_ICE,  16, 0,   8, 6, $0
	anim_ret

BattleAnim_FocusEnergy_2:
	anim_1gfx ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_1Row_2
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT, $0, $1, $40
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
.loop
	anim_call BattleAnimSub_Focus
	anim_loop 3, .loop
	anim_wait 8
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT
	anim_call BattleAnim_ShowMon_0_2
	anim_ret

BattleAnimSub_Sludge_2:
.loop
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_SLUDGE, -16, 4,   9, 0, $0
	anim_wait 8
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_SLUDGE,  14, 4,   9, 0, $0
	anim_wait 8
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_SLUDGE, -14, 4,   9, 0, $0
	anim_wait 8
	anim_loop 5, .loop
	anim_wait 48
	anim_ret

BattleAnimSub_Explosion1_2:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, 32, 64, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, 64, 104, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, 32, 104, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, 64, 64, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, 48, 84, $0
	anim_ret

BattleAnimSub_Explosion2_2:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, 148, 32, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, 116, 72, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, 148, 72, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, 116, 32, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, 132, 52, $0
	anim_ret

BattleAnimSub_Metallic_2:
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_METALLIC
	anim_sound 0, 0, SFX_SHINE
	anim_wait 8
	anim_obj ANIM_OBJ_HARDEN,   6, 0,  10, 4, $0
	anim_wait 32
	anim_obj ANIM_OBJ_HARDEN,   6, 0,  10, 4, $0
	anim_wait 64
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_DEFAULT
	anim_ret

BattleAnim_TargetObj_1Row_2:
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $0, $0
	anim_wait 6
	anim_ret

BattleAnim_TargetObj_2Row_2:
	anim_battlergfx_1row
	anim_bgeffect ANIM_BG_BATTLEROBJ_2ROW, $0, $0, $0
	anim_wait 6
	anim_ret

BattleAnim_ShowMon_0_2:
	anim_wait 1
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 5
	anim_incobj 1
	anim_wait 1
	anim_ret

BattleAnim_UserObj_1Row_2:
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $1, $0
	anim_wait 6
	anim_ret

BattleAnim_UserObj_2Row_2:
	anim_battlergfx_1row
	anim_bgeffect ANIM_BG_BATTLEROBJ_2ROW, $0, $1, $0
	anim_wait 4
	anim_ret

BattleAnim_ShowMon_1_2:
	anim_wait 1
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 4
	anim_incobj 1
	anim_wait 1
	anim_ret