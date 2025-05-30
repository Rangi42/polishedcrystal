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