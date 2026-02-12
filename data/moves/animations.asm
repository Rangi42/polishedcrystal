BattleAnim_Moonblast:
	anim_4gfx ANIM_GFX_MOON, ANIM_GFX_SPEED, ANIM_GFX_GLOW, ANIM_GFX_SHINE
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_MOON
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_MOON
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_MOONBLAST
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_bgeffect ANIM_BG_CYCLE_BGPALS_INVERTED, $0, $4, $0
	anim_clearopponenthud
	anim_bgp $1b
	anim_sound 0, 1, SFX_GAME_FREAK_LOGO_GS
	anim_obj ANIM_OBJ_RISING_MOON, 90, 84, $30
	anim_wait 40
.loop
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
	anim_loop 4, .loop
	anim_wait 8
	anim_sound 0, 1, SFX_GIGA_DRAIN
	anim_obj ANIM_OBJ_FLASH_CANNON, 48, 96, $4
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_MOONBLAST
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_sound 0, 0, SFX_METRONOME
	anim_obj ANIM_OBJ_GLIMMER_YFIX, 132, 28, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER_YFIX, 112, 60, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER_YFIX, 144, 68, $0
	anim_wait 5
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 148, 32, $0
	anim_wait 6
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 116, 64, $0
	anim_wait 6
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 148, 64, $0
	anim_wait 6
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 116, 32, $0
	anim_wait 6
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 132, 48, $0
	anim_wait 32
BattleAnim_0:
	anim_ret

BattleAnim_PlayRough:
	anim_1gfx ANIM_GFX_SPEED
	anim_sound 6, 2, SFX_THROW_BALL
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_call BattleAnimSub_QuickAttack
	anim_wait 12
	anim_3gfx ANIM_GFX_STARS, ANIM_GFX_HIT, ANIM_GFX_HEARTS
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $55, $2, $0
.loop
	anim_sound 0, 1, SFX_BONE_CLUB
	anim_obj ANIM_OBJ_STAR_BURST, 128, 48, $28
	anim_obj ANIM_OBJ_HIT_YFIX, 128, 48, $0
	anim_wait 3
	anim_obj ANIM_OBJ_HEART_BURST, 144, 64, $5c
	anim_wait 3
	anim_obj ANIM_OBJ_STAR_BURST, 144, 64, $10
	anim_obj ANIM_OBJ_HIT_YFIX, 144, 64, $0
	anim_wait 3
	anim_sound 0, 1, SFX_DOUBLE_SLAP
	anim_obj ANIM_OBJ_HEART_BURST, 120, 52, $e8
	anim_wait 3
	anim_obj ANIM_OBJ_STAR_BURST, 120, 52, $9c
	anim_obj ANIM_OBJ_HIT_YFIX, 120, 52, $0
	anim_wait 3
	anim_obj ANIM_OBJ_STAR_BURST, 152, 48, $d0
	anim_wait 3
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj ANIM_OBJ_HEART_BURST, 152, 48, $1c
	anim_obj ANIM_OBJ_HIT_YFIX, 152, 48, $0
	anim_wait 3
	anim_obj ANIM_OBJ_STAR_BURST, 136, 56, $50
	anim_wait 3
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HEART_BURST, 136, 56, $dc
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 3
	anim_obj ANIM_OBJ_STAR_BURST, 128, 48, $90
	anim_loop 2, .loop
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_DisarmVoice:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BRIGHT_PINK
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_RED
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_2gfx ANIM_GFX_HEARTS, ANIM_GFX_PSYCHIC
	anim_battlergfx_2row
.loop
	anim_sound 0, 0, SFX_ATTRACT
	anim_obj ANIM_OBJ_SHOOTING_HEART, 64, 88, $4
	anim_wait 6
	anim_obj ANIM_OBJ_SHOOTING_HEART, 64, 80, $4
	anim_obj ANIM_OBJ_WAVE, 64, 88, $2
	anim_wait 6
	anim_obj ANIM_OBJ_SHOOTING_HEART, 64, 96, $4
	anim_wait 6
	anim_loop 3, .loop
	anim_wait 16
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $1, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
	anim_wait 32
	anim_call BattleAnim_ShowMon_1
	anim_ret

BattleAnim_Scald:
	anim_3gfx ANIM_GFX_HIT_2, ANIM_GFX_MISC, ANIM_GFX_SMOKE_PUFF
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_WATER
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_VERY_BRIGHT
	anim_bgp $90
	anim_sound 0, 1, SFX_SURF
	anim_obj ANIM_OBJ_SCALD, 64, 88, $4
	anim_wait 4
	anim_obj ANIM_OBJ_SCALD, 64, 88, $4
	anim_wait 4
	anim_obj ANIM_OBJ_SCALD, 64, 88, $4
	anim_wait 4
.loop
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 52, $0
	anim_obj ANIM_OBJ_SCALD, 64, 88, $4
	anim_obj ANIM_OBJ_SCALD_STEAM, 120, 46, $30
	anim_wait 1
	anim_obj ANIM_OBJ_SCALD_STEAM, 144, 34, $30
	anim_wait 3
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 52, $0
	anim_obj ANIM_OBJ_SCALD, 64, 88, $4
	anim_wait 4
	anim_loop 7, .loop
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 52, $0
	anim_obj ANIM_OBJ_SCALD_STEAM, 120, 46, $30
	anim_wait 1
	anim_obj ANIM_OBJ_SCALD_STEAM, 144, 34, $30
	anim_wait 3
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 52, $0
	anim_wait 4
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 52, $0
	anim_wait 4
	anim_obj ANIM_OBJ_SCALD_STEAM, 120, 46, $30
	anim_wait 1
	anim_obj ANIM_OBJ_SCALD_STEAM, 144, 34, $30
	anim_wait 7
	anim_setobjpal PAL_BATTLE_BG_TARGET, PAL_BTLCUSTOM_FIRE
	anim_bgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING, $0, $0, $40
	anim_sound 0, 1, SFX_POISON_STING
.loop2
	anim_obj ANIM_OBJ_SCALD_STEAM, 120, 46, $30
	anim_wait 1
	anim_obj ANIM_OBJ_SCALD_STEAM, 144, 34, $30
	anim_wait 8
	anim_loop 6, .loop2
	anim_wait 8
	anim_incbgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING
	anim_ret

BattleAnim_ThrowPokeBall:
	anim_jumpif -1, .TheTrainerBlockedTheBall
	anim_jumpif MASTER_BALL, .MasterBall
	; any other ball
	anim_3gfx ANIM_GFX_POKE_BALL, ANIM_GFX_POKE_BALL_BG, ANIM_GFX_SMOKE
	anim_checkcriticalcapture
	anim_jumpvar $10, .CriticalSFX
	anim_sound 6, 2, SFX_THROW_BALL
	anim_jump .DoneSFX
.CriticalSFX:
	anim_sound 6, 1, SFX_CRITICAL_CAPTURE
.DoneSFX:
	anim_obj ANIM_OBJ_POKE_BALL,   8, 4,  11, 4, $40
	anim_obj ANIM_OBJ_POKE_BALL_BG,   8, 4,  11, 4, $40
	anim_wait 36
	anim_obj ANIM_OBJ_POKE_BALL, -15, 0,   8, 1, $0
	anim_setobj $3, $7
	anim_obj ANIM_OBJ_POKE_BALL_BG, -15, 0,   8, 1, $0
	anim_setobj $4, $7
	anim_wait 16
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj ANIM_OBJ_BALL_POOF, -15, 0,   8, 0, $10
	anim_wait 16
	anim_jump .Shake

.TheTrainerBlockedTheBall:
	anim_2gfx ANIM_GFX_POKE_BALL, ANIM_GFX_HIT
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj ANIM_OBJ_POKE_BALL_BLOCKED,   8, 0,  11, 4, $20
	anim_wait 20
	anim_obj ANIM_OBJ_HIT_YFIX,  14, 0,   5, 0, $0
	anim_wait 32
	anim_ret

.MasterBall:
	anim_4gfx ANIM_GFX_POKE_BALL, ANIM_GFX_POKE_BALL_BG, ANIM_GFX_SMOKE, ANIM_GFX_SPEED
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj ANIM_OBJ_POKE_BALL,   8, 0,  11, 4, $20
	anim_obj ANIM_OBJ_POKE_BALL_BG,   8, 0,  11, 4, $20
	anim_wait 36
	anim_obj ANIM_OBJ_POKE_BALL, -15, 0,   8, 1, $0
	anim_setobj $3, $7
	anim_obj ANIM_OBJ_POKE_BALL_BG, -15, 0,   8, 1, $0
	anim_setobj $4, $7
	anim_wait 16
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj ANIM_OBJ_BALL_POOF, -15, 0,   8, 0, $10
	anim_wait 24
	anim_sound 0, 1, SFX_MASTER_BALL
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, -15, 0,   7, 0, $31
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, -15, 0,   7, 0, $33
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, -15, 0,   7, 0, $35
	anim_obj ANIM_OBJ_MASTER_BALL_SPARKLE, -15, 0,   7, 0, $37
	anim_wait 64
.Shake:
	anim_bgeffect ANIM_BG_RETURN_MON, $0, $0, $0
	anim_wait 8
	anim_incobj 3
	anim_incobj 4
	anim_wait 16
	anim_sound 0, 1, SFX_CHANGE_DEX_MODE
	anim_incobj 1
	anim_incobj 2
	anim_wait 16
	anim_checkcriticalcapture
	anim_jumpvar 0, .not_critical
	anim_setobj 1, $c
	anim_setobj 2, $c
	anim_wait 12
	anim_incobj 1
	anim_incobj 2
	anim_wait 24
	anim_setobj 1, 4
	anim_setobj 2, 4
.not_critical
	anim_wait 16
	anim_sound 0, 1, SFX_BALL_BOUNCE
	anim_wait 32
	anim_wait 32
	anim_wait 32
	anim_wait 8
	anim_setvar $0
.Loop:
	anim_wait 48
	anim_checkpokeball
	anim_jumpvar $1, .Click
	anim_jumpvar $2, .BreakFree
	anim_incobj 1
	anim_incobj 2
	anim_sound 0, 1, SFX_BALL_WIGGLE
	anim_jump .Loop

.Click:
	anim_clearsprites
	anim_ret

.BreakFree:
	anim_setobj $1, $b
	anim_setobj $2, $b
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj ANIM_OBJ_BALL_POOF, -15, 0,   8, 0, $10
	anim_wait 2
	anim_bgeffect ANIM_BG_ENTER_MON, $0, $0, $0
	anim_wait 32
	anim_ret

BattleAnim_SendOutMon:
	anim_jumpif $1, .Shiny
	anim_1gfx ANIM_GFX_SMOKE
	anim_sound 0, 0, SFX_BALL_POOF
	anim_obj ANIM_OBJ_BALL_POOF,   5, 4,  12, 0, $0
	anim_wait 4
	anim_bgeffect ANIM_BG_ENTER_MON, $0, $1, $0
	anim_wait 32
	anim_ret

.Shiny:
	anim_1gfx ANIM_GFX_SPEED
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $3
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SHINY,   6, 0,  12, 0, $0
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SHINY,   6, 0,  12, 0, $8
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SHINY,   6, 0,  12, 0, $10
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SHINY,   6, 0,  12, 0, $18
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SHINY,   6, 0,  12, 0, $20
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SHINY,   6, 0,  12, 0, $28
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SHINY,   6, 0,  12, 0, $30
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SHINY,   6, 0,  12, 0, $38
	anim_wait 32
	anim_ret

BattleAnim_ReturnMon:
	anim_sound 0, 0, SFX_BALL_POOF
.anim
	anim_bgeffect ANIM_BG_RETURN_MON, $0, $1, $0
	anim_wait 32
	anim_ret

BattleAnim_Confused:
	anim_1gfx ANIM_GFX_STATUS
	anim_sound 0, 0, SFX_KINESIS
	anim_obj ANIM_OBJ_CHICK,   5, 4,   7, 0, $15
	anim_obj ANIM_OBJ_CHICK,   5, 4,   7, 0, $aa
	anim_obj ANIM_OBJ_CHICK,   5, 4,   7, 0, $bf
	anim_wait 96
	anim_ret

BattleAnim_Slp:
BattleAnim_Rest:
	anim_1gfx ANIM_GFX_STATUS
	anim_sound 0, 0, SFX_TAIL_WHIP
.loop
	anim_obj ANIM_OBJ_ASLEEP,   8, 0,  10, 0, $0
	anim_wait 40
	anim_loop 3, .loop
	anim_wait 32
	anim_ret

BattleAnim_Brn:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx ANIM_GFX_FIRE
.loop
	anim_sound 0, 0, SFX_BURN
	anim_obj ANIM_OBJ_BURNED,   7, 0,  11, 0, $10
	anim_wait 4
	anim_loop 3, .loop
	anim_wait 6
	anim_ret

BattleAnim_Psn:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_1gfx ANIM_GFX_POISON
	anim_sound 0, 0, SFX_POISON
	anim_obj ANIM_OBJ_SKULL,   8, 0,   7, 0, $0
	anim_wait 8
	anim_sound 0, 0, SFX_POISON
	anim_obj ANIM_OBJ_SKULL,   6, 0,   7, 0, $0
	anim_wait 8
	anim_ret

BattleAnim_Sap:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_ABSORB
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_1gfx ANIM_GFX_CHARGE
	anim_call BattleAnimSub_AbsorbHeal
	anim_wait 16
	anim_ret

BattleAnim_Frz:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_1gfx ANIM_GFX_ICE
	anim_obj ANIM_OBJ_FROZEN, 48, 112, $0
	anim_sound 0, 0, SFX_SHINE
	anim_wait 16
	anim_sound 0, 0, SFX_SHINE
	anim_wait 16
	anim_ret

BattleAnim_Par:
	anim_1gfx ANIM_GFX_STATUS
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_ZAP_CANNON
	anim_obj ANIM_OBJ_PARALYZED, 20, 90, $42
	anim_obj ANIM_OBJ_PARALYZED, 76, 90, $c2
	anim_wait 32
	anim_ret

BattleAnim_InLove:
	anim_1gfx ANIM_GFX_OBJECTS
	anim_sound 0, 0, SFX_LICK
	anim_obj ANIM_OBJ_HEART,   8, 0,   9, 4, $0
	anim_wait 32
	anim_sound 0, 0, SFX_LICK
	anim_obj ANIM_OBJ_HEART,   4, 4,   9, 0, $0
	anim_wait 32
	anim_ret

BattleAnim_InSandstorm:
	anim_call BattleAnimSub_Sandstorm
.loop
	anim_sound 0, 1, SFX_MENU
	anim_wait 8
	anim_loop 6, .loop
	anim_wait 8
	anim_ret

BattleAnim_InHail:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_ICE
	anim_1gfx ANIM_GFX_ICE
	anim_bgeffect ANIM_BG_WHITE_HUES, $0, $8, $0
.loop
	anim_call BattleAnimSub_Hail
	anim_loop 2, .loop
	anim_ret

BattleAnim_UnderCurse:
	anim_1gfx ANIM_GFX_ANGELS
	anim_sound 0, 0, SFX_BUBBLE_BEAM
	anim_obj ANIM_OBJ_IN_NIGHTMARE,   8, 4,  10, 0, $0
	anim_wait 40
	anim_ret

BattleAnim_HitConfusion:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 0, SFX_POUND
	anim_obj ANIM_OBJ_HIT,   5, 4,  12, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_Miss:
	anim_ret

BattleAnim_EnemyDamage:
.loop
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $0, $0
	anim_wait 5
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 5
	anim_loop 3, .loop
	anim_ret

BattleAnim_PlayerDamage:
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_Y, $20, $2, $20
	anim_wait 40
	anim_ret

BattleAnim_Acrobatics:
	anim_2gfx ANIM_GFX_SPEED, ANIM_GFX_HIT
	anim_battlergfx_1row
	anim_bgeffect ANIM_BG_BATTLEROBJ_2ROW, $0, $0, $0
	anim_wait 1
	anim_bgeffect ANIM_BG_SHAKE_MON_X, $0, $11, $4
.loop
	anim_sound 0, 0, SFX_SQUEAK
	anim_wait 8
	anim_loop 3, .loop
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_incbgeffect ANIM_BG_SHAKE_MON_X
	anim_call BattleAnimSub_QuickAttack
	anim_wait 12
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 12
	anim_clearobjs
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 140, 44, $0
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 124, 60, $0
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 140, 60, $0
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 124, 44, $0
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 132, 52, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $a, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 16
	anim_ret

BattleAnim_KarateChop:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_PALM, -15, 0,   5, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   5, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_PALM, -15, 0,   5, 4, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   5, 4, $0
	anim_wait 6
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_PALM, -15, 0,   6, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   6, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_DoubleSlap:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 1, SFX_DOUBLE_SLAP
	anim_jumpif $1, .alternate
	anim_obj ANIM_OBJ_PALM, -14, 0,   6, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   6, 0, $0
	anim_wait 8
	anim_ret

.alternate
	anim_obj ANIM_OBJ_PALM,  15, 0,   6, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX,  15, 0,   6, 0, $0
	anim_wait 8
	anim_ret

BattleAnim_Stomp:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 1, SFX_STOMP
	anim_obj ANIM_OBJ_KICK, -15, 0,   5, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   5, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_STOMP
	anim_obj ANIM_OBJ_KICK, -15, 0,   5, 4, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   5, 4, $0
	anim_wait 6
	anim_sound 0, 1, SFX_STOMP
	anim_obj ANIM_OBJ_KICK, -15, 0,   6, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   6, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_DoubleKick:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_jumpif $1, .alternate
	anim_obj ANIM_OBJ_KICK, -14, 0,   6, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   6, 0, $0
	anim_wait 8
	anim_ret

.alternate
	anim_obj ANIM_OBJ_KICK,  15, 0,   8, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX,  15, 0,   8, 0, $0
	anim_wait 8
	anim_ret

BattleAnim_HiJumpKick:
	anim_1gfx ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $40, $2, $0
	anim_jumpif $1, .alternate
	anim_wait 32
	anim_sound 0, 1, SFX_JUMP_KICK
	anim_obj ANIM_OBJ_KICK,  14, 0,   9, 0, $0
	anim_setobj $1, $2
	anim_wait 16
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_HIT, -15, 0,   6, 0, $0
	anim_wait 16
	anim_ret

.alternate
	anim_wait 16
	anim_sound 0, 0, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_HIT,   5, 4,  11, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_FocusBlast:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GLOW_YELLOW
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_RED
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_GLOW_YELLOW
	anim_3gfx ANIM_GFX_VORTEX, ANIM_GFX_WIND_BG, ANIM_GFX_SWIRL
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_call BattleAnimSub_AgilityMinor
	anim_sound 0, 1, SFX_OUTRAGE
.loop
	anim_obj ANIM_OBJ_SWIRL_SHORT, 44, 96, $0
	anim_wait 8
	anim_loop 4, .loop
	anim_obj ANIM_OBJ_VORTEX, 44, 96, $0
	anim_wait 64
	anim_clearobjs
	anim_wait 1
	anim_2gfx ANIM_GFX_BIG_GLOW_CLEAR, ANIM_GFX_FOCUS_BLAST
	anim_sound 0, 1, SFX_MEGA_PUNCH
.loop2
	anim_obj ANIM_OBJ_FOCUS_BLAST, 64, 88, $12
	anim_wait 32
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $10
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $2, $0
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_BIG_GLOW_CLEAR, 136, 48, $0
	anim_wait 40
	anim_ret

BattleAnim_HyperFang:
	anim_1gfx ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $20, $1, $0
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_FANG, -15, 0,   7, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_SuperFang:
	anim_1gfx ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $40, $2, $0
	anim_wait 48
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $3
.loop
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_FANG, -15, 0,   7, 0, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   7, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_FANG, -15, 0,   7, 0, $0
	anim_wait 6
	anim_loop 3, .loop
	anim_ret

BattleAnim_Ember:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx ANIM_GFX_FIRE
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_EMBER,   8, 0,  12, 0, $12
	anim_wait 4
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_EMBER,   8, 0,  12, 4, $14
	anim_wait 4
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_EMBER,   8, 0,  10, 4, $13
	anim_wait 16
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_sound 0, 1, SFX_EMBER
	anim_obj ANIM_OBJ_EMBER,  15, 0,   8, 4, $30
	anim_obj ANIM_OBJ_EMBER, -16, 4,   8, 4, $30
	anim_obj ANIM_OBJ_EMBER, -14, 0,   8, 4, $30
	anim_wait 32
	anim_ret

BattleAnim_WillOWisp:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_WILL_O_WISP
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_WILL_O_WISP
	anim_1gfx ANIM_GFX_FIRE
	anim_bgp $1b
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj ANIM_OBJ_DRAGON_RAGE, 64, 92, $0
	anim_wait 40
	anim_sound 0, 0, SFX_CURSE
.loop
	anim_obj ANIM_OBJ_SACRED_FIRE, 132, 68, $0
	anim_wait 8
	anim_loop 4, .loop
	anim_wait 48
	anim_ret

BattleAnim_FirePunch:
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_FIRE
	anim_call BattleAnimSub_PunchShake
	anim_call BattleAnimSub_Fire
	anim_wait 16
	anim_ret

BattleAnimSub_PunchShake:
	anim_obj ANIM_OBJ_PUNCH_SHAKE, -15, 0,   7, 0, $43
	anim_ret

BattleAnim_FireSpin:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx ANIM_GFX_FIRE
.loop
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_FIRE_SPIN,   8, 0,  11, 0, $4
	anim_wait 2
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_FIRE_SPIN,   8, 0,  12, 0, $3
	anim_wait 2
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_FIRE_SPIN,   8, 0,  11, 0, $3
	anim_wait 2
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_FIRE_SPIN,   8, 0,  12, 0, $4
	anim_wait 2
	anim_loop 2, .loop
	anim_wait 96
	anim_ret

BattleAnim_DragonRage:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_DRAGON_RAGE
	anim_1gfx ANIM_GFX_FIRE
.loop
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_DRAGON_RAGE, 64, 92, $0
	anim_wait 3
	anim_loop 16, .loop
	anim_wait 64
	anim_ret

BattleAnim_Flamethrower:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_1gfx ANIM_GFX_FIRE
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_FLAMETHROWER,   8, 0,  11, 4, $3
	anim_wait 2
	anim_obj ANIM_OBJ_FLAMETHROWER,   9, 3,  10, 6, $5
	anim_wait 2
	anim_obj ANIM_OBJ_FLAMETHROWER,  10, 5,  10, 1, $7
	anim_wait 2
	anim_obj ANIM_OBJ_FLAMETHROWER,  12, 0,   9, 4, $9
	anim_wait 2
	anim_obj ANIM_OBJ_FLAMETHROWER,  13, 2,   8, 7, $b
	anim_wait 2
	anim_obj ANIM_OBJ_FLAMETHROWER,  14, 4,   8, 2, $c
	anim_wait 2
	anim_obj ANIM_OBJ_FLAMETHROWER,  15, 6,   7, 5, $a
	anim_wait 2
	anim_obj ANIM_OBJ_FLAMETHROWER, -15, 0,   7, 0, $8
	anim_wait 16
.loop
	anim_sound 0, 1, SFX_EMBER
	anim_wait 16
	anim_loop 6, .loop
	anim_wait 16
	anim_ret

BattleAnim_FireBlast:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_FIRE
	anim_1gfx ANIM_GFX_FIRE
.loop1
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_FIRE_BLAST,   8, 0,  11, 4, $7
	anim_wait 6
	anim_loop 10, .loop1
.loop2
	anim_sound 0, 1, SFX_EMBER
	anim_wait 8
	anim_loop 10, .loop2
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_incobj 4
	anim_incobj 5
	anim_incobj 6
	anim_incobj 7
	anim_incobj 8
	anim_incobj 9
	anim_incobj 10
	anim_wait 2
.loop3
	anim_sound 0, 1, SFX_EMBER
	anim_obj ANIM_OBJ_FIRE_BLAST, -15, 0,   7, 0, $1
	anim_obj ANIM_OBJ_FIRE_BLAST, -15, 0,   7, 0, $2
	anim_obj ANIM_OBJ_FIRE_BLAST, -15, 0,   7, 0, $3
	anim_obj ANIM_OBJ_FIRE_BLAST, -15, 0,   7, 0, $4
	anim_obj ANIM_OBJ_FIRE_BLAST, -15, 0,   7, 0, $5
	anim_wait 16
	anim_loop 2, .loop3
	anim_wait 32
	anim_ret

BattleAnim_IcePunch:
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_ICE
	anim_call BattleAnimSub_PunchShake
	anim_call BattleAnimSub_Ice
	anim_wait 32
	anim_ret

BattleAnim_IceBeam:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_1gfx ANIM_GFX_ICE
.loop
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_ICE_BEAM, 64, 92, $4
	anim_wait 4
	anim_loop 5, .loop
	anim_obj ANIM_OBJ_ICE_BUILDUP, 132, 72, $10
.loop2
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_ICE_BEAM, 64, 92, $4
	anim_wait 4
	anim_loop 15, .loop2
	anim_wait 48
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_ret

BattleAnim_Blizzard:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_1gfx ANIM_GFX_ICE
.loop
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_BLIZZARD,   8, 0,  11, 0, $63
	anim_wait 2
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_BLIZZARD,   8, 0,  10, 0, $64
	anim_wait 2
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_BLIZZARD,   8, 0,  12, 0, $63
	anim_wait 2
	anim_loop 3, .loop
	anim_bgeffect ANIM_BG_WHITE_HUES, $0, $8, $0
	anim_wait 32
	anim_obj ANIM_OBJ_ICE_BUILDUP, -15, 0,   9, 2, $10
	anim_wait 128
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_wait 24
	anim_ret

BattleAnim_WaterPulse:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_WATER
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_2gfx ANIM_GFX_BUBBLE, ANIM_GFX_PSYCHIC
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_WHIRLPOOL, $0, $0, $0
	anim_sound 6, 2, SFX_BUBBLE_BEAM
	anim_wait 64
.loop
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_WAVE, 64, 88, $2
	anim_wait 6
	anim_loop 3, .loop
	anim_wait 6
	anim_incbgeffect ANIM_BG_WHIRLPOOL
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $1, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
.loop2
	anim_sound 0, 1, SFX_LICK
	anim_wait 3
	anim_loop 3, .loop2
	anim_wait 32
	anim_call BattleAnim_ShowMon_1
	anim_ret

BattleAnim_BubbleBeam:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BUBBLE
	anim_1gfx ANIM_GFX_BUBBLE
.loop
	anim_sound 16, 2, SFX_BUBBLE_BEAM
	anim_obj ANIM_OBJ_BUBBLE,   8, 0,  11, 4, $92
	anim_wait 6
	anim_sound 16, 2, SFX_BUBBLE_BEAM
	anim_obj ANIM_OBJ_BUBBLE,   8, 0,  11, 4, $b3
	anim_wait 6
	anim_sound 16, 2, SFX_BUBBLE_BEAM
	anim_obj ANIM_OBJ_BUBBLE,   8, 0,  11, 4, $f4
	anim_wait 8
	anim_loop 3, .loop
	anim_wait 64
	anim_clearobjs
	anim_bgeffect ANIM_BG_START_WATER, $0, $0, $0
	anim_wait 1
	anim_call BattleAnim_UserObj_2Row
	anim_bgeffect ANIM_BG_WATER, $1c, $0, $0
	anim_wait 19
	anim_call BattleAnim_ShowMon_1
	anim_bgeffect ANIM_BG_END_WATER, $0, $0, $0
	anim_wait 8
	anim_ret

BattleAnim_WaterGun:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_bgeffect ANIM_BG_START_WATER, $0, $0, $0
	anim_1gfx ANIM_GFX_WATER
	anim_call BattleAnim_UserObj_2Row
	anim_sound 16, 2, SFX_WATER_GUN
	anim_obj ANIM_OBJ_WATER_GUN, 64, 84, $0
	anim_wait 8                
	anim_obj ANIM_OBJ_WATER_GUN, 64, 72, $0
	anim_wait 8                
	anim_obj ANIM_OBJ_WATER_GUN, 64, 78, $0
	anim_wait 24
	anim_bgeffect ANIM_BG_WATER, $1c, $0, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_WATER, $8, $0, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_WATER, $30, $0, $0
	anim_wait 32
	anim_call BattleAnim_ShowMon_1
	anim_bgeffect ANIM_BG_END_WATER, $0, $0, $0
	anim_wait 16
	anim_ret

BattleAnim_HydroPump:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_2gfx ANIM_GFX_WATER, ANIM_GFX_WATER_BALL
	anim_battlergfx_1row
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $40, $2, $0
.loop
	anim_sound 0, 1, SFX_AEROBLAST
	anim_obj ANIM_OBJ_HYDRO_PUMP_SHOT, 64, 88, $6
	anim_wait 1
	anim_obj ANIM_OBJ_HYDRO_PUMP_SHOT, 64, 88, $6
	anim_wait 1
	anim_loop 14, .loop
	anim_wait 6
	anim_bgeffect ANIM_BG_BATTLEROBJ_2ROW, $0, BG_EFFECT_USER, $0
	anim_wait 2
	anim_bgeffect ANIM_BG_NIGHT_SHADE, $0, BG_EFFECT_TARGET, $8
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj ANIM_OBJ_HYDRO_PUMP, 132, 72, $3a
	anim_wait 8
	anim_obj ANIM_OBJ_HYDRO_PUMP, 124, 72, $3a
	anim_wait 8
	anim_obj ANIM_OBJ_HYDRO_PUMP, 140, 72, $3a
	anim_wait 8
	anim_obj ANIM_OBJ_HYDRO_PUMP, 116, 72, $3a
	anim_wait 8
	anim_obj ANIM_OBJ_HYDRO_PUMP, 148, 72, $3a
	anim_wait 8
	anim_obj ANIM_OBJ_HYDRO_PUMP, 108, 72, $3a
	anim_wait 8
	anim_obj ANIM_OBJ_HYDRO_PUMP, 156, 72, $3a
	anim_wait 32
	anim_incbgeffect ANIM_BG_NIGHT_SHADE
	anim_call BattleAnim_ShowMon_1
	anim_wait 16
	anim_ret

BattleAnim_Surf:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_1gfx ANIM_GFX_BUBBLE
	anim_bgeffect ANIM_BG_SURF, $0, $0, $0
	anim_obj ANIM_OBJ_SURF,  11, 0,  13, 0, $8
.loop
	anim_sound 0, 1, SFX_SURF
	anim_wait 112
	anim_loop 1, .loop
	anim_incobj 1
	anim_wait 56
	anim_ret

BattleAnim_VineWhip:
	anim_2gfx ANIM_GFX_WHIP, ANIM_GFX_HIT
	anim_sound 0, 1, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_VINE_WHIP2, 116, 48, $80
	anim_wait 4
	anim_sound 0, 1, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_VINE_WHIP1, 128, 54, $0
	anim_wait 8
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_incobj  1
	anim_wait 16
	anim_ret

BattleAnim_LeechSeed:
	anim_1gfx ANIM_GFX_PLANT
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_LEECH_SEED,   6, 0,  10, 0, $20
	anim_wait 8
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_LEECH_SEED,   6, 0,  10, 0, $30
	anim_wait 8
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_LEECH_SEED,   6, 0,  10, 0, $28
	anim_wait 32
	anim_sound 0, 1, SFX_CHARGE
	anim_wait 128
	anim_ret

BattleAnim_RazorLeaf:
	anim_1gfx ANIM_GFX_PLANT
	anim_sound 0, 0, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_RAZOR_LEAF,   6, 0,  10, 0, $28
	anim_obj ANIM_OBJ_RAZOR_LEAF,   6, 0,  10, 0, $5c
	anim_obj ANIM_OBJ_RAZOR_LEAF,   6, 0,  10, 0, $10
	anim_obj ANIM_OBJ_RAZOR_LEAF,   6, 0,  10, 0, $e8
	anim_obj ANIM_OBJ_RAZOR_LEAF,   6, 0,  10, 0, $9c
	anim_obj ANIM_OBJ_RAZOR_LEAF,   6, 0,  10, 0, $d0
	anim_wait 6
	anim_obj ANIM_OBJ_RAZOR_LEAF,   6, 0,  10, 0, $1c
	anim_obj ANIM_OBJ_RAZOR_LEAF,   6, 0,  10, 0, $50
	anim_obj ANIM_OBJ_RAZOR_LEAF,   6, 0,  10, 0, $dc
	anim_obj ANIM_OBJ_RAZOR_LEAF,   6, 0,  10, 0, $90
	anim_wait 80
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 3
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 5
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 7
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 9
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 1
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 2
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 4
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 6
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 8
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 10
	anim_wait 64
	anim_ret

BattleAnim_SolarBeam:
	anim_jumpif $0, .FireSolarBeam
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_1gfx ANIM_GFX_CHARGE
	anim_sound 0, 0, SFX_CHARGE
	anim_obj ANIM_OBJ_ABSORB_CENTER,   6, 0,  10, 4, $0
	anim_obj ANIM_OBJ_SOLAR_BEAM_CHARGE,   6, 0,  10, 4, $0
	anim_obj ANIM_OBJ_SOLAR_BEAM_CHARGE,   6, 0,  10, 4, $8
	anim_obj ANIM_OBJ_SOLAR_BEAM_CHARGE,   6, 0,  10, 4, $10
	anim_obj ANIM_OBJ_SOLAR_BEAM_CHARGE,   6, 0,  10, 4, $18
	anim_obj ANIM_OBJ_SOLAR_BEAM_CHARGE,   6, 0,  10, 4, $20
	anim_obj ANIM_OBJ_SOLAR_BEAM_CHARGE,   6, 0,  10, 4, $28
	anim_obj ANIM_OBJ_SOLAR_BEAM_CHARGE,   6, 0,  10, 4, $30
	anim_obj ANIM_OBJ_SOLAR_BEAM_CHARGE,   6, 0,  10, 4, $38
	anim_wait 104
	anim_bgeffect ANIM_BG_FLASH_WHITE, $0, $4, $2
	anim_wait 64
	anim_ret

.FireSolarBeam
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_ABSORB
	anim_1gfx ANIM_GFX_BEAM_SOLAR
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $1, $0
	anim_call BattleAnimSub_Beam
	anim_wait 48
	anim_ret

BattleAnim_Thunderpunch:
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_LIGHTNING
	anim_call BattleAnimSub_PunchShake
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $2
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 1, SFX_THUNDER
	anim_obj ANIM_OBJ_THUNDER3, -13, 0,   8, 4, $0
	anim_wait 64
	anim_ret

BattleAnim_Thundershock:
	anim_2gfx ANIM_GFX_LIGHTNING, ANIM_GFX_EXPLOSION
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj ANIM_OBJ_THUNDERSHOCK_BALL, -15, 0,   7, 0, $2
	anim_wait 16
	anim_sound 0, 1, SFX_THUNDERSHOCK
	anim_obj ANIM_OBJ_SPARKS_CIRCLE, -15, 0,   7, 0, $0
	anim_wait 96
	anim_ret

BattleAnim_Thunderbolt:
	anim_2gfx ANIM_GFX_LIGHTNING, ANIM_GFX_EXPLOSION
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj ANIM_OBJ_THUNDERBOLT_BALL, 132, 52, $2
	anim_wait 16
	anim_obj ANIM_OBJ_SPARKS_CIRCLE_BIG, 132, 52, $0
.loop
	anim_sound 0, 1, SFX_THUNDERBOLT
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $7, $6
	anim_wait 66
	anim_loop 2, .loop
	anim_ret

BattleAnim_ThunderWave:
	anim_1gfx ANIM_GFX_LIGHTNING
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $3
	anim_sound 0, 1, SFX_THUNDERSHOCK
	anim_obj ANIM_OBJ_THUNDER_WAVE, 136, 52, $0
	anim_wait 20
	anim_bgp $1b
	anim_incobj 1
	anim_wait 96
	anim_bgp $e4
	anim_ret

BattleAnim_Thunder:
	anim_1gfx ANIM_GFX_LIGHTNING
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $6, $20
	anim_sound 0, 1, SFX_THUNDER
	anim_obj ANIM_OBJ_THUNDER2,  15, 0,   8, 4, $0
	anim_wait 16
	anim_sound 0, 1, SFX_THUNDER
	anim_obj ANIM_OBJ_THUNDER3, -13, 0,   8, 4, $0
	anim_wait 16
	anim_sound 0, 1, SFX_THUNDER
	anim_obj ANIM_OBJ_THUNDER1, -15, 0,   8, 4, $0
	anim_wait 48
	anim_ret

BattleAnim_AirSlash:
	anim_2gfx ANIM_GFX_CUT, ANIM_GFX_WHIP
	anim_resetobp0
	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $0a, $2, $0
	anim_sound 0, 1, SFX_CUT
	anim_obj ANIM_OBJ_CUT_LONG_DOWN_LEFT, 152, 40, $0
	anim_obj ANIM_OBJ_AIR_SLASH, 144, 40, $28
	anim_obj ANIM_OBJ_AIR_SLASH, 152, 48, $8
	anim_wait 4
	anim_obj ANIM_OBJ_AIR_SLASH, 136, 48, $28
	anim_obj ANIM_OBJ_AIR_SLASH, 144, 56, $8
	anim_wait 4
	anim_obj ANIM_OBJ_AIR_SLASH, 128, 56, $28
	anim_obj ANIM_OBJ_AIR_SLASH, 136, 64, $8
	anim_wait 4
	anim_obj ANIM_OBJ_AIR_SLASH, 120, 64, $28
	anim_obj ANIM_OBJ_AIR_SLASH, 128, 72, $8
	anim_wait 32
	anim_ret

BattleAnim_Sonicboom:
	anim_2gfx ANIM_GFX_WHIP, ANIM_GFX_HIT
	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_SONICBOOM_JP, 64, 80, $3
	anim_wait 8
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_SONICBOOM_JP, 64, 88, $2
	anim_wait 8
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_SONICBOOM_JP, 64, 96, $4
	anim_wait 8
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_SONICBOOM_JP, 64, 80, $3
	anim_obj ANIM_OBJ_HIT_YFIX, 132, 56, $0
	anim_wait 8
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_SONICBOOM_JP, 64, 88, $2
	anim_obj ANIM_OBJ_HIT_YFIX, 132, 56, $0
	anim_wait 8
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_SONICBOOM_JP, 64, 80, $3
.loop
	anim_obj ANIM_OBJ_HIT_YFIX, 132, 56, $0
	anim_wait 8
	anim_loop 4, .loop
	anim_wait 8
	anim_ret

BattleAnim_Gust:
	anim_2gfx ANIM_GFX_WIND, ANIM_GFX_HIT
.loop
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_GUST, -15, 0,   9, 0, $0
	anim_wait 6
	anim_loop 9, .loop
	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   8, 0, $18
	anim_wait 8
	anim_obj ANIM_OBJ_HIT_YFIX,  16, 0,   4, 0, $18
	anim_wait 16
	anim_ret

BattleAnim_Explosion:
	anim_1gfx ANIM_GFX_EXPLOSION
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $4, $10
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $24
	anim_jumpif $1, .loop
	anim_call BattleAnimSub_Explosion2
	anim_wait 16
	anim_ret

.loop
	anim_call BattleAnimSub_Explosion1
	anim_wait 5
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_loop 2, .loop
	anim_wait 16
	anim_ret

BattleAnim_Acid:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_ACID
	anim_1gfx ANIM_GFX_POISON
	anim_call BattleAnimSub_Acid
	anim_obj ANIM_OBJ_POISON_DROPLET, 128, 36, $11
	anim_wait 4
	anim_obj ANIM_OBJ_POISON_DROPLET, 144, 36, $0f
	anim_wait 4
	anim_obj ANIM_OBJ_POISON_DROPLET, 124, 36, $11
	anim_wait 4
	anim_obj ANIM_OBJ_POISON_DROPLET, 148, 36, $0f
	anim_wait 4
	anim_obj ANIM_OBJ_POISON_DROPLET, 120, 36, $11
	anim_wait 48
	anim_ret

BattleAnim_RockThrow:
	anim_1gfx ANIM_GFX_ROCKS
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $1, $0
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_SMALL_ROCK,  16, 0,   8, 0, $40
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_BIG_ROCK,  15, 0,   8, 4, $30
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_SMALL_ROCK, -13, 0,   8, 4, $30
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_BIG_ROCK, -14, 0,   8, 0, $40
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_SMALL_ROCK, -15, 0,   8, 4, $30
	anim_wait 96
	anim_ret

BattleAnim_RockSlide:
	anim_1gfx ANIM_GFX_ROCKS
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $c0, $1, $0
.loop
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_SMALL_ROCK,  16, 0,   8, 0, $40
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_BIG_ROCK,  15, 0,   8, 4, $30
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_SMALL_ROCK, -13, 0,   8, 4, $30
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_BIG_ROCK, -14, 0,   8, 0, $40
	anim_wait 4
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_SMALL_ROCK, -15, 0,   8, 4, $30
	anim_wait 16
	anim_loop 4, .loop
	anim_wait 96
	anim_ret

BattleAnim_Avalanche:
	anim_setobjpal PAL_BATTLE_OB_BROWN, PAL_BTLCUSTOM_SNOW
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_SNOW
	anim_2gfx ANIM_GFX_ROCKS, ANIM_GFX_SMOKE_PUFF
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_Y, $c0, $1, $0
	anim_bgp $90
	anim_obj ANIM_OBJ_AVALANCHE_SMALL, 134, 250, $10
	anim_wait 2
	anim_obj ANIM_OBJ_SNOW_FALL, 110, 20, $12
	anim_wait 2
.loop
	anim_obj ANIM_OBJ_AVALANCHE_SMALL, 122, 250, $12
	anim_wait 2
	anim_obj ANIM_OBJ_SNOW_FALL, 142, 20, $0e
	anim_wait 2
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_AVALANCHE_BIG, 144, 250, $0e
	anim_wait 2
	anim_obj ANIM_OBJ_SNOW_FALL, 118, 20, $11
	anim_wait 2
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_AVALANCHE_SMALL, 154, 250, $0f
	anim_wait 2
	anim_obj ANIM_OBJ_SNOW_FALL, 130, 20, $10
	anim_wait 2
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_AVALANCHE_BIG, 118, 250, $11
	anim_wait 2
	anim_obj ANIM_OBJ_SNOW_FALL, 154, 20, $0f
	anim_wait 2
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_AVALANCHE_SMALL, 134, 250, $10
	anim_wait 2
	anim_obj ANIM_OBJ_SNOW_FALL, 110, 20, $12
	anim_wait 2
	anim_sound 0, 1, SFX_TACKLE
	anim_loop 4, .loop
	anim_wait 32
	anim_ret

BattleAnim_Sing:
	anim_1gfx ANIM_GFX_NOISE
	anim_sound 16, 2, SFX_SING
.loop
	anim_obj ANIM_OBJ_SING,   8, 0,  11, 4, $0
	anim_wait 8
	anim_obj ANIM_OBJ_SING,   8, 0,  11, 4, $1
	anim_wait 8
	anim_obj ANIM_OBJ_SING,   8, 0,  11, 4, $2
	anim_wait 8
	anim_obj ANIM_OBJ_SING,   8, 0,  11, 4, $0
	anim_wait 8
	anim_obj ANIM_OBJ_SING,   8, 0,  11, 4, $2
	anim_wait 8
	anim_loop 4, .loop
	anim_wait 64
	anim_ret

BattleAnim_Poisonpowder:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_jump BattleAnim_SubPowder
BattleAnim_StunSpore:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_YELLOW
	anim_jump BattleAnim_SubPowder
BattleAnim_SleepPowder:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GREEN
BattleAnim_SubPowder:
	anim_1gfx ANIM_GFX_POWDER
.loop
	anim_sound 0, 1, SFX_POWDER
	anim_obj ANIM_OBJ_POWDER,  13, 0,   2, 0, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj ANIM_OBJ_POWDER, -15, 0,   2, 0, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj ANIM_OBJ_POWDER,  14, 0,   2, 0, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj ANIM_OBJ_POWDER,  16, 0,   2, 0, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj ANIM_OBJ_POWDER,  15, 0,   2, 0, $0
	anim_wait 4
	anim_loop 2, .loop
	anim_wait 96
	anim_ret

BattleAnim_Spore:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_DRAGONBREATH
	anim_3gfx ANIM_GFX_MUSHROOM, ANIM_GFX_POWDER, ANIM_GFX_SMOKE
	anim_sound 0, 1, SFX_JUMP_OVER_LEDGE
	anim_obj ANIM_OBJ_BALL_POOF_YFIX, 48, 88, $0
	anim_wait 12
	anim_obj ANIM_OBJ_MUSHROOM, 48, 88, $0
	anim_wait 32
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_SPORE
	anim_sound 0, 1, SFX_SWEET_SCENT_2
	anim_obj ANIM_OBJ_POWDER_SHOOT, 48, 88, $35
	anim_obj ANIM_OBJ_POWDER_SHOOT, 48, 88, $2b
	anim_obj ANIM_OBJ_POWDER_SHOOT, 48, 88, $39
	anim_obj ANIM_OBJ_POWDER_SHOOT, 48, 88, $27
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_wait 16
	anim_jump BattleAnim_SubPowder.loop

BattleAnim_HyperBeam:
	anim_1gfx ANIM_GFX_BEAM
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $30, $4, $10
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $40
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_call BattleAnimSub_Beam
	anim_wait 48
	anim_ret

BattleAnim_AuroraBeam:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_AURORA
	anim_1gfx ANIM_GFX_BEAM_AURORA
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW_FULL_SHIFT, $0, $2, $0
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_wait 64
	anim_call BattleAnimSub_Beam
	anim_wait 48
	anim_incobj 5
	anim_wait 64
	anim_ret

BattleAnim_DragonPulse:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_DRAGON_PULSE
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_DRAGON_PULSE
	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
	anim_2gfx ANIM_GFX_GLOW, ANIM_GFX_CHARGE,
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $55, $1, $0
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_obj ANIM_OBJ_SMALL_GLOW, 48, 96, $0
.loop
	anim_sound 0, 0, SFX_AEROBLAST
	anim_obj ANIM_OBJ_DRAGON_PULSE, 64, 88, $4
	anim_wait 4
	anim_loop 16, .loop
	anim_incobj 1
	anim_wait 16
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 4
	anim_ret

BattleAnim_XScissor:
	anim_1gfx ANIM_GFX_CUT
	anim_sound 0, 1, SFX_CUT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $08, $2, $0
	anim_obj ANIM_OBJ_CUT_LONG_DOWN_LEFT, 150, 40, $0
	anim_obj ANIM_OBJ_CUT_LONG_DOWN_RIGHT, 118, 40, $0
	anim_wait 32
	anim_ret

BattleAnim_Scratch:
	anim_1gfx ANIM_GFX_CUT
.hit
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, -14, 0,   6, 0, $0
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, -15, 4,   5, 4, $0
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, -15, 0,   5, 0, $0
	anim_wait 32
	anim_ret

BattleAnim_FuryStrikes:
BattleAnim_FurySwipes: ; reassigned
	anim_1gfx ANIM_GFX_CUT
	anim_jumpif $1, .alternate
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, -14, 0,   6, 0, $0
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, -15, 4,   5, 4, $0
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, -15, 0,   5, 0, $0
	anim_sound 0, 1, SFX_SCRATCH
	anim_wait 32
	anim_ret

.alternate
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj ANIM_OBJ_CUT_DOWN_RIGHT,  15, 0,   6, 0, $0
	anim_obj ANIM_OBJ_CUT_DOWN_RIGHT,  15, 4,   5, 4, $0
	anim_obj ANIM_OBJ_CUT_DOWN_RIGHT,  16, 0,   5, 0, $0
	anim_sound 0, 1, SFX_SCRATCH
	anim_wait 32
	anim_ret

BattleAnim_FuryAttack: ; reassigned
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_2gfx ANIM_GFX_HORN, ANIM_GFX_HIT
	anim_obj ANIM_OBJ_HORN,   9, 0,   9, 0, $2
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT,  16, 0,   5, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_HORN,  10, 0,  11, 0, $2
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT, -15, 0,   7, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_HORN,   9, 4,  10, 0, $2
	anim_wait 8
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT, -16, 4,   6, 0, $0
	anim_wait 8
	anim_ret

BattleAnim_Cut:
	anim_1gfx ANIM_GFX_CUT
	anim_sound 0, 1, SFX_CUT
	anim_obj ANIM_OBJ_CUT_LONG_DOWN_LEFT, -13, 0,   5, 0, $0
	anim_wait 32
	anim_ret

BattleAnim_Slash:
	anim_1gfx ANIM_GFX_CUT
	anim_sound 0, 1, SFX_CUT
	anim_obj ANIM_OBJ_CUT_LONG_DOWN_LEFT, -13, 0,   5, 0, $0
	anim_obj ANIM_OBJ_CUT_LONG_DOWN_LEFT, -14, 4,   4, 4, $0
	anim_wait 32
	anim_ret

BattleAnim_Bite:
	anim_2gfx ANIM_GFX_CUT, ANIM_GFX_HIT
	anim_obj ANIM_OBJ_BITE, -15, 0,   7, 0, $98
	anim_obj ANIM_OBJ_BITE, -15, 0,   7, 0, $18
	anim_wait 8
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   6, 0, $18
	anim_wait 16
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_YFIX,  16, 0,   8, 0, $18
	anim_wait 8
	anim_ret

BattleAnim_Teleport:
	anim_1gfx ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_TELEPORT, $0, $1, $0
	anim_wait 32
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_wait 3
	anim_incbgeffect ANIM_BG_TELEPORT
	anim_call BattleAnim_ShowMon_0
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $1, $0
	anim_call BattleAnimSub_WarpAway
	anim_wait 64
	anim_ret

BattleAnim_Fly:
	anim_jumpif $1, .turn1
	anim_jumpif $2, .miss
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 32
.miss
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 32
	anim_ret

.turn1
	anim_1gfx ANIM_GFX_SPEED
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $1, $0
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_call BattleAnimSub_WarpAway
	anim_wait 64
	anim_ret

BattleAnim_DoubleTeam:
	anim_call BattleAnim_TargetObj_2Row
	anim_sound 0, 0, SFX_PSYBEAM
	anim_bgeffect ANIM_BG_DOUBLE_TEAM, $0, $1, $0
	anim_wait 96
	anim_incbgeffect ANIM_BG_DOUBLE_TEAM
	anim_wait 24
	anim_incbgeffect ANIM_BG_DOUBLE_TEAM
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_Recover:
	anim_2gfx ANIM_GFX_BUBBLE, ANIM_GFX_SHINE
	anim_sound 0, 0, SFX_SHARPEN
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_call BattleAnim_Recover_branch
	anim_wait 32
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_call BattleAnimSub_Glimmer
	anim_ret

BattleAnim_Recover_branch:
	anim_obj ANIM_OBJ_RECOVER, 44, 88, $30
	anim_obj ANIM_OBJ_RECOVER, 44, 88, $31
	anim_obj ANIM_OBJ_RECOVER, 44, 88, $32
	anim_obj ANIM_OBJ_RECOVER, 44, 88, $33
	anim_obj ANIM_OBJ_RECOVER, 44, 88, $34
	anim_obj ANIM_OBJ_RECOVER, 44, 88, $35
	anim_obj ANIM_OBJ_RECOVER, 44, 88, $36
	anim_obj ANIM_OBJ_RECOVER, 44, 88, $37
	anim_wait 64
	anim_ret

BattleAnim_HeldItemTrigger:
	anim_jumpif 1, .alternate
	anim_1gfx ANIM_GFX_BUBBLE
	anim_call BattleAnim_TargetObj_1Row
	anim_sound 0, 0, SFX_FULL_HEAL
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_call BattleAnim_Recover_branch
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_ret

.alternate
	anim_setobjpal PAL_BATTLE_OB_BROWN, PAL_BTLCUSTOM_BERRY
	anim_2gfx ANIM_GFX_BERRY, ANIM_GFX_BUBBLE
	anim_sound 0, 0, SFX_SWITCH_POKEMON
	anim_obj ANIM_OBJ_BERRY, 60, 104, $10
	anim_wait 48
	anim_sound 0, 0, SFX_BITE
	anim_wait 24
	anim_sound 0, 0, SFX_BITE
	anim_wait 24
	anim_sound 0, 0, SFX_BITE
	anim_wait 16
	anim_sound 0, 0, SFX_FULL_HEAL
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_call BattleAnim_Recover_branch
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_ret

BattleAnim_Roost:
	anim_2gfx ANIM_GFX_MISC, ANIM_GFX_SHINE
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_wait 16
	anim_sound 0, 0, SFX_MORNING_SUN
	anim_obj ANIM_OBJ_ROOST, 48, 80, $00
	anim_obj ANIM_OBJ_ROOST, 48, 80, $0d
	anim_obj ANIM_OBJ_ROOST, 48, 80, $1a
	anim_obj ANIM_OBJ_ROOST, 48, 80, $27
	anim_obj ANIM_OBJ_ROOST, 48, 80, $34
	anim_wait 130
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_jump BattleAnimSub_Glimmer

BattleAnim_Absorb:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_ABSORB
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_1gfx ANIM_GFX_CHARGE
	anim_obj ANIM_OBJ_ABSORB_CENTER,   5, 4,  11, 0, $0
.loop
	anim_call BattleAnimSub_AbsorbHeal
	anim_wait 6
	anim_loop 5, .loop
	anim_wait 32
	anim_ret

BattleAnim_MegaDrain:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_ABSORB
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_1gfx ANIM_GFX_CHARGE
	anim_bgeffect ANIM_BG_FADE_MONS_TO_BLACK_REPEATING, $0, $0, $10
	anim_setvar $0
.loop
	anim_call BattleAnimSub_AbsorbHeal
	anim_wait 6
	anim_incvar
	anim_jumpvar $7, .done
	anim_jumpvar $2, .spawn
	anim_jump .loop

.spawn
	anim_obj ANIM_OBJ_ABSORB_CENTER,   5, 4,  11, 0, $0
	anim_jump .loop

.done
	anim_wait 32
	anim_incbgeffect ANIM_BG_FADE_MONS_TO_BLACK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_Amnesia:
	anim_1gfx ANIM_GFX_STATUS
	anim_sound 0, 0, SFX_LICK
	anim_obj ANIM_OBJ_AMNESIA,   8, 0,  10, 0, $2
	anim_wait 16
	anim_obj ANIM_OBJ_AMNESIA,   8, 4,  10, 0, $1
	anim_wait 16
	anim_obj ANIM_OBJ_AMNESIA,   9, 0,  10, 0, $0
	anim_wait 64
	anim_ret

BattleAnim_FreshSnack:
	anim_jumpif $2, BattleAnim_MilkDrink
BattleAnim_Softboiled: ; reassigned
	anim_2gfx ANIM_GFX_EGG, ANIM_GFX_BUBBLE
	anim_call BattleAnim_TargetObj_1Row
	anim_sound 0, 0, SFX_SWITCH_POKEMON
	anim_obj ANIM_OBJ_EGG,   5, 4,  13, 0, $6
	anim_wait 128
	anim_incobj 2
	anim_obj ANIM_OBJ_EGG,   9, 4,  13, 0, $b
	anim_wait 16
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_sound 0, 0, SFX_METRONOME
;fallthrough
BattleAnimSub_SoftboiledHeal:
.loop
	anim_obj ANIM_OBJ_RECOVER,   5, 4,  11, 0, $20
	anim_wait 8
	anim_loop 8, .loop
	anim_wait 128
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_MilkDrink: ; reassigned
	anim_2gfx ANIM_GFX_MISC, ANIM_GFX_BUBBLE
	anim_call BattleAnim_TargetObj_1Row
	anim_obj ANIM_OBJ_MILK_DRINK,   9, 2,  13, 0, $0
	anim_wait 16
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_sound 0, 0, SFX_MILK_DRINK
	anim_jump BattleAnimSub_SoftboiledHeal

BattleAnim_FocusEnergy:
	anim_1gfx ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT, $0, $1, $40
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
.loop
	anim_call BattleAnimSub_Focus
	anim_loop 3, .loop
	anim_wait 8
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_BulletPunch:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_UserObj_1Row
	anim_resetobp0
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
	anim_obj ANIM_OBJ_BULLET_PUNCH, 140, 44, $0
	anim_sound 0, 1, SFX_TACKLE
	anim_wait 3
	anim_obj ANIM_OBJ_BULLET_PUNCH, 112, 46, $0
	anim_sound 0, 1, SFX_TACKLE
	anim_wait 3
	anim_obj ANIM_OBJ_BULLET_PUNCH, 150, 60, $0
	anim_sound 0, 1, SFX_TACKLE
	anim_wait 3
	anim_obj ANIM_OBJ_BULLET_PUNCH, 120, 30, $0
	anim_sound 0, 1, SFX_TACKLE
	anim_wait 3
	anim_obj ANIM_OBJ_BULLET_PUNCH, 116, 64, $0
	anim_sound 0, 1, SFX_TACKLE
	anim_wait 3
	anim_obj ANIM_OBJ_BULLET_PUNCH, 132, 68, $0
	anim_sound 0, 1, SFX_TACKLE
	anim_wait 32
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_Wrap:
	anim_1gfx ANIM_GFX_ROPE
	anim_sound 0, 1, SFX_BIND
	anim_obj ANIM_OBJ_BIND1, -16, 4,   8, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_BIND1, -16, 4,   7, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_BIND1, -16, 4,   6, 0, $0
	anim_wait 64
	anim_sound 0, 1, SFX_BIND
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_wait 96
	anim_ret

BattleAnim_Confusion:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_UserObj_2Row
	anim_sound 0, 1, SFX_PSYCHIC
	anim_bgeffect ANIM_BG_NIGHT_SHADE, $0, $0, $8
	anim_wait 128
	anim_incbgeffect ANIM_BG_NIGHT_SHADE
	anim_call BattleAnim_ShowMon_1
	anim_ret

BattleAnim_Earthquake:
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $4, $10
.loop
	anim_sound 0, 1, SFX_EMBER
	anim_wait 24
	anim_loop 4, .loop
	anim_ret

BattleAnim_Growl:
	anim_1gfx ANIM_GFX_NOISE
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_cry $0
.loop
	anim_call BattleAnimSub_Sound
	anim_wait 16
	anim_loop 3, .loop
	anim_ret

BattleAnim_Roar:
	anim_1gfx ANIM_GFX_NOISE
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_cry $1
.loop
	anim_call BattleAnimSub_Sound
	anim_wait 16
	anim_loop 3, .loop
	anim_wait 16
	anim_jumpif $0, .done
	anim_bgeffect ANIM_BG_REMOVE_MON, $0, $0, $0
	anim_wait 64
.done
	anim_ret

BattleAnim_Supersonic:
	anim_1gfx ANIM_GFX_PSYCHIC
.loop
	anim_sound 6, 2, SFX_SUPERSONIC
	anim_obj ANIM_OBJ_WAVE,   8, 0,  11, 0, $2
	anim_wait 4
	anim_loop 10, .loop
	anim_wait 64
	anim_ret

BattleAnim_Screech:
	anim_1gfx ANIM_GFX_PSYCHIC
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $8, $1, $20
	anim_sound 6, 2, SFX_SCREECH
.loop
	anim_obj ANIM_OBJ_WAVE,   8, 0,  11, 0, $2
	anim_wait 2
	anim_loop 2, .loop
	anim_wait 64
	anim_ret

BattleAnim_ConfuseRay:
	anim_1gfx ANIM_GFX_SPEED
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_CYCLE_BGPALS_INVERTED, $0, $4, $0
	anim_obj ANIM_OBJ_CONFUSE_RAY,   8, 0,  11, 0, $0
	anim_obj ANIM_OBJ_CONFUSE_RAY,   8, 0,  11, 0, $80
	anim_obj ANIM_OBJ_CONFUSE_RAY,   8, 0,  11, 0, $88
	anim_obj ANIM_OBJ_CONFUSE_RAY,   8, 0,  11, 0, $90
	anim_obj ANIM_OBJ_CONFUSE_RAY,   8, 0,  11, 0, $98
	anim_obj ANIM_OBJ_CONFUSE_RAY,   8, 0,  11, 0, $a0
	anim_obj ANIM_OBJ_CONFUSE_RAY,   8, 0,  11, 0, $a8
	anim_obj ANIM_OBJ_CONFUSE_RAY,   8, 0,  11, 0, $b0
	anim_obj ANIM_OBJ_CONFUSE_RAY,   8, 0,  11, 0, $b8
.loop
	anim_sound 6, 2, SFX_WHIRLWIND
	anim_wait 16
	anim_loop 8, .loop
	anim_wait 32
	anim_ret

BattleAnim_AquaTail:
	anim_setobjpal PAL_BATTLE_OB_BROWN, PAL_BTLCUSTOM_WATER
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BUBBLE
	anim_3gfx ANIM_GFX_HIT_2, ANIM_GFX_BUBBLE, ANIM_GFX_SAND
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_RISING_BUBBLE, 64, 104, $0
	anim_wait 16
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_RISING_BUBBLE, 32, 104, $0
	anim_wait 16
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_RISING_BUBBLE, 48, 104, $0
	anim_wait 32
	anim_clearobjs
	anim_wait 1
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_WOBBLE_MON, $0, $1, $0
	anim_wait 16
	anim_sound 0, 1, SFX_BUBBLE_BEAM
	anim_obj ANIM_OBJ_DIG_SAND, 104, 60, $0
	anim_wait 1
	anim_obj ANIM_OBJ_DIG_SAND, 112, 60, $0
	anim_wait 1
	anim_obj ANIM_OBJ_DIG_SAND, 120, 60, $0
	anim_wait 1
	anim_obj ANIM_OBJ_DIG_SAND, 128, 60, $0
	anim_wait 1
	anim_obj ANIM_OBJ_DIG_SAND, 136, 60, $0
	anim_wait 1
	anim_obj ANIM_OBJ_DIG_SAND, 144, 60, $0
	anim_wait 1
	anim_obj ANIM_OBJ_DIG_SAND, 152, 60, $0
	anim_wait 1
	anim_obj ANIM_OBJ_DIG_SAND, 160, 60, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_MEGA_KICK
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $5c
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $e8
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $d0
	anim_wait 8
	anim_incbgeffect ANIM_BG_WOBBLE_MON
	anim_wait 16
	anim_jump BattleAnim_ShowMon_0

BattleAnim_Leer:
	anim_1gfx ANIM_GFX_BEAM
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_call BattleAnimSub_ShakeEnemy
	anim_wait 16
	anim_ret

BattleAnim_Reflect:
	anim_2gfx ANIM_GFX_SPEED, ANIM_GFX_REFLECT
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_REFLECT
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SCREEN, 72, 80, $0
	anim_wait 4
	anim_obj ANIM_OBJ_DAZZLE, 72, 80, $0
	anim_obj ANIM_OBJ_DAZZLE, 72, 80, $8
	anim_obj ANIM_OBJ_DAZZLE, 72, 80, $10
	anim_obj ANIM_OBJ_DAZZLE, 72, 80, $18
	anim_obj ANIM_OBJ_DAZZLE, 72, 80, $20
	anim_obj ANIM_OBJ_DAZZLE, 72, 80, $28
	anim_obj ANIM_OBJ_DAZZLE, 72, 80, $30
	anim_obj ANIM_OBJ_DAZZLE, 72, 80, $38
	anim_wait 20
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SCREEN, 72, 80, $0
	anim_wait 64
	anim_ret

BattleAnim_LightScreen:
	anim_2gfx ANIM_GFX_SPEED, ANIM_GFX_REFLECT
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_LIGHT_SCREEN
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_FLASH
	anim_obj ANIM_OBJ_SCREEN, 72, 80, $0
	anim_wait 4
	anim_obj ANIM_OBJ_SHINY, 72, 80, $0
	anim_wait 4
	anim_obj ANIM_OBJ_SHINY, 72, 80, $8
	anim_wait 4
	anim_obj ANIM_OBJ_SHINY, 72, 80, $10
	anim_wait 4
	anim_obj ANIM_OBJ_SHINY, 72, 80, $18
	anim_wait 4
	anim_obj ANIM_OBJ_SCREEN, 72, 80, $0
	anim_obj ANIM_OBJ_SHINY, 72, 80, $20
	anim_wait 4
	anim_obj ANIM_OBJ_SHINY, 72, 80, $28
	anim_wait 4
	anim_obj ANIM_OBJ_SHINY, 72, 80, $30
	anim_wait 4
	anim_obj ANIM_OBJ_SHINY, 72, 80, $38
	anim_wait 64
	anim_ret

BattleAnim_CalmMind:
	anim_3gfx ANIM_GFX_BIG_RINGS, ANIM_GFX_RINGS, ANIM_GFX_GLOW
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_GLOW_LUSTER
	anim_bgp $1b
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_ATTRACT
	anim_obj ANIM_OBJ_SMALL_GLOW, 48, 96, $0
	anim_wait 32
	anim_clearobjs
	anim_sound 0, 1, SFX_GAME_FREAK_LOGO_GS
.loop
	anim_obj ANIM_OBJ_SHRINKING_RING_BIG, 48, 96, $0
	anim_wait 4
	anim_obj ANIM_OBJ_SHRINKING_RING_SMALL, 48, 96, $0
	anim_wait 16
	anim_loop 4, .loop
	anim_wait 16
	anim_ret

BattleAnim_DizzyPunch:
	anim_2gfx ANIM_GFX_STATUS, ANIM_GFX_HIT
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   5, 0, $0
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, -15, 0,   8, 0, $0
	anim_wait 16
	anim_sound 0, 1, SFX_KINESIS
	anim_obj ANIM_OBJ_CHICK, -15, 0,   3, 0, $15
	anim_obj ANIM_OBJ_CHICK, -15, 0,   3, 0, $aa
	anim_obj ANIM_OBJ_CHICK, -15, 0,   3, 0, $bf
	anim_wait 96
	anim_ret

BattleAnim_Facade:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_MISC_2
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_BOUNCE_DOWN, $0, $1, $0
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_RED
	anim_sound 0, 0, SFX_RETURN
	anim_obj ANIM_OBJ_DROPLET_R, 64, 102, $3b
	anim_obj ANIM_OBJ_DROPLET_L, 44, 102, $24
	anim_wait 24
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_WATER
	anim_sound 0, 0, SFX_RETURN
	anim_obj ANIM_OBJ_DROPLET_R, 64, 82, $3b
	anim_obj ANIM_OBJ_DROPLET_L, 44, 82, $24
	anim_wait 24
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_YELLOW
	anim_sound 0, 0, SFX_RETURN
	anim_obj ANIM_OBJ_DROPLET_R, 64, 102, $3b
	anim_obj ANIM_OBJ_DROPLET_L, 44, 102, $24
	anim_wait 24
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_DEFAULT
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_sound 0, 0, SFX_RETURN
	anim_obj ANIM_OBJ_DROPLET_R, 64, 82, $3b
	anim_obj ANIM_OBJ_DROPLET_L, 44, 82, $24
	anim_wait 24
	anim_incbgeffect ANIM_BG_BOUNCE_DOWN
	anim_call BattleAnim_ShowMon_0
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_Splash:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 0, SFX_VICEGRIP
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_BOUNCE_DOWN, $0, $1, $0
	anim_wait 96
	anim_incbgeffect ANIM_BG_BOUNCE_DOWN
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_Dig:
	anim_2gfx ANIM_GFX_SAND, ANIM_GFX_HIT
	anim_jumpif $0, .hit
	anim_jumpif $2, .fail
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_DIG, $0, $1, $1
	anim_obj ANIM_OBJ_DIG_PILE,   9, 0,  13, 0, $0
.loop
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_DIG_SAND,   7, 0,  13, 0, $0
	anim_wait 16
	anim_loop 6, .loop
	anim_wait 32
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_wait 8
	anim_incbgeffect ANIM_BG_DIG
	anim_call BattleAnim_ShowMon_0
	anim_ret

.hit
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 32
.fail
	anim_bgeffect ANIM_BG_ENTER_MON, $0, $1, $0
	anim_wait 32
	anim_ret

BattleAnim_StringShot:
	anim_1gfx ANIM_GFX_WEB
	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
	anim_sound 6, 2, SFX_MENU
	anim_obj ANIM_OBJ_STRING_SHOT,   8, 0,  10, 0, $0
	anim_wait 4
	anim_sound 0, 1, SFX_MENU
	anim_obj ANIM_OBJ_STRING_SHOT, -16, 4,   6, 0, $1
	anim_wait 4
	anim_sound 6, 2, SFX_MENU
	anim_obj ANIM_OBJ_STRING_SHOT,   8, 0,  11, 0, $0
	anim_wait 4
	anim_sound 0, 1, SFX_MENU
	anim_obj ANIM_OBJ_STRING_SHOT, -16, 4,   8, 0, $1
	anim_wait 4
	anim_sound 6, 2, SFX_MENU
	anim_obj ANIM_OBJ_STRING_SHOT,   8, 0,  10, 4, $0
	anim_wait 4
	anim_sound 0, 1, SFX_MENU
	anim_obj ANIM_OBJ_STRING_SHOT, -16, 4,   7, 0, $2
	anim_wait 64
	anim_ret

BattleAnim_Headbutt:
	anim_1gfx ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_wait 32
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 4
	anim_sound 0, 1, SFX_HEADBUTT
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 8
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_ZenHeadbutt:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_SIGNAL_BEAM_BLUE
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_SIGNAL_BEAM_BLUE
	anim_2gfx ANIM_GFX_GLOW, ANIM_GFX_SHINE
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_bgp $1b
	anim_sound 0, 0, SFX_PSYBEAM
	anim_obj ANIM_OBJ_ZEN_HEADBUTT, 44, 104, $30
	anim_wait 8
.loop
	anim_obj ANIM_OBJ_ZEN_HEADBUTT_PARTICLE,  44, 96, $5c
	anim_wait 8
	anim_obj ANIM_OBJ_ZEN_HEADBUTT_PARTICLE,  44, 96, $e8
	anim_wait 8
	anim_obj ANIM_OBJ_ZEN_HEADBUTT_PARTICLE,  44, 96, $d0
	anim_wait 8
	anim_obj ANIM_OBJ_ZEN_HEADBUTT_PARTICLE,  44, 96, $50
	anim_wait 8
	anim_loop 2, .loop
	anim_clearobjs
	anim_2gfx ANIM_GFX_HIT_2, ANIM_GFX_STARS
	anim_wait 1
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $0, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 12
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 1
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_clearobjs
	anim_wait 1
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_sound 0, 0, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
.loop2
	anim_obj ANIM_OBJ_STAR_BURST, 136, 56, $5c
	anim_wait 2
	anim_obj ANIM_OBJ_STAR_BURST, 136, 56, $e8
	anim_wait 2
	anim_obj ANIM_OBJ_STAR_BURST, 136, 56, $d0
	anim_wait 2
	anim_obj ANIM_OBJ_STAR_BURST, 136, 56, $50
	anim_wait 2
	anim_loop 2, .loop2
	anim_wait 32
	anim_ret

BattleAnim_Tackle:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 4
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   6, 0, $0
	anim_wait 8
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_BodySlam:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_BOUNCE_DOWN, $0, $1, $0
	anim_wait 32
	anim_incbgeffect ANIM_BG_BOUNCE_DOWN
	anim_wait 4
	anim_bgeffect ANIM_BG_BODY_SLAM, $0, $1, $0
	anim_wait 3
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   6, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   6, 0, $0
	anim_wait 3
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_TakeDown:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 3
	anim_sound 0, 1, SFX_TACKLE
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_obj ANIM_OBJ_HIT_YFIX,  16, 0,   7, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_TACKLE
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   6, 0, $0
	anim_wait 3
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_DoubleEdge:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $10
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 3
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_HIT_BIG_YFIX,  16, 0,   6, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -14, 0,   6, 0, $0
	anim_wait 3
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_CloseCombat:
	anim_2gfx ANIM_GFX_WIND_BG, ANIM_GFX_HIT
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_call BattleAnimSub_Agility
	anim_wait 12
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $2, $0
	anim_bgp $90
.loop
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_PUNCH, 148, 56, $0
	anim_wait 1
	anim_obj ANIM_OBJ_HIT_YFIX, 148, 56, $0
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_PUNCH, 122, 34, $0
	anim_wait 1
	anim_obj ANIM_OBJ_HIT_YFIX, 122, 34, $0
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_PUNCH, 132, 64, $0
	anim_wait 1
	anim_obj ANIM_OBJ_HIT_YFIX, 132, 64, $0
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_PUNCH, 140, 42, $0
	anim_wait 1
	anim_obj ANIM_OBJ_HIT_YFIX, 140, 42, $0
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_PUNCH, 114, 52, $0
	anim_wait 1
	anim_obj ANIM_OBJ_HIT_YFIX, 114, 52, $0
	anim_wait 2
	anim_loop 4, .loop
	anim_wait 16
	anim_ret

BattleAnim_Hurricane:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BRIGHT
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BUBBLE
	anim_2gfx ANIM_GFX_HURRICANE, ANIM_GFX_WIND_BG
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $90, $4, $10
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $4, $0
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_obj ANIM_OBJ_HURRICANE, 132, 56, $38
	anim_call BattleAnimSub_AgilityMinor
.loop
	anim_sound 0, 1, SFX_THUNDER
	anim_wait 4
	anim_loop 18, .loop
	anim_wait 24
	anim_ret

BattleAnim_KnockOff:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_PALM, 136, 08, $0
	anim_wait 1
	anim_obj ANIM_OBJ_PALM, 136, 16, $0
	anim_wait 1
	anim_obj ANIM_OBJ_PALM, 136, 24, $0
	anim_wait 1
	anim_obj ANIM_OBJ_PALM, 136, 32, $0
	anim_wait 1
	anim_obj ANIM_OBJ_PALM, 136, 40, $0
	anim_wait 1
	anim_obj ANIM_OBJ_PALM, 136, 48, $0
	anim_wait 1
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_Y, $10, $1, $20
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_obj ANIM_OBJ_PALM, 136, 56, $0
	anim_wait 1
	anim_obj ANIM_OBJ_PALM, 136, 64, $0
	anim_wait 1
	anim_obj ANIM_OBJ_PALM, 136, 72, $0
	anim_wait 8
	anim_ret

BattleAnim_Hypnosis:
	anim_1gfx ANIM_GFX_PSYCHIC
.loop
	anim_sound 6, 2, SFX_SUPERSONIC
	anim_obj ANIM_OBJ_WAVE,   8, 0,  11, 0, $2
	anim_obj ANIM_OBJ_WAVE,   7, 0,  10, 0, $2
	anim_wait 8
	anim_loop 3, .loop
	anim_wait 56
	anim_ret

BattleAnim_Haze:
	anim_1gfx ANIM_GFX_HAZE
	anim_sound 0, 1, SFX_SURF
.loop
	anim_obj ANIM_OBJ_HAZE,   6, 0,   7, 0, $0
	anim_obj ANIM_OBJ_HAZE, -16, 4,   2, 0, $0
	anim_wait 12
	anim_loop 5, .loop
	anim_wait 96
	anim_ret

BattleAnim_Mist:
	anim_obp0 $54
	anim_1gfx ANIM_GFX_HAZE
	anim_sound 0, 0, SFX_SURF
.loop
	anim_obj ANIM_OBJ_MIST,   6, 0,   7, 0, $0
	anim_wait 8
	anim_loop 10, .loop
	anim_wait 96
	anim_ret

BattleAnim_HornAttack:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_2gfx ANIM_GFX_HORN, ANIM_GFX_HIT
	anim_obj ANIM_OBJ_HORN,   9, 0,  10, 0, $1
	anim_wait 16
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_IcicleCrash:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_3gfx ANIM_GFX_HIT_2, ANIM_GFX_ICICLE_CRASH, ANIM_GFX_ICE
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_ICICLE_CRASH,  128, 250, $10
	anim_wait 6
	anim_obj ANIM_OBJ_ICICLE_CRASH,  120, 250, $10
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 128, 66, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $30, $2, $0
	anim_obj ANIM_OBJ_ICE_SPLASH, 128, 66, $28
	anim_obj ANIM_OBJ_ICE_SPLASH, 128, 66, $9c
	anim_wait 4
	anim_obj ANIM_OBJ_ICICLE_CRASH,  152, 250, $10
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 120, 66, $0
	anim_obj ANIM_OBJ_ICE_SPLASH, 120, 66, $28
	anim_obj ANIM_OBJ_ICE_SPLASH, 120, 66, $9c
	anim_wait 4
	anim_obj ANIM_OBJ_ICICLE_CRASH,  144, 250, $10
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 152, 66, $0
	anim_obj ANIM_OBJ_ICE_SPLASH, 152, 66, $28
	anim_obj ANIM_OBJ_ICE_SPLASH, 152, 66, $9c
	anim_wait 4
	anim_obj ANIM_OBJ_ICICLE_CRASH,  136, 250, $10
	anim_wait 2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 144, 66, $0
	anim_obj ANIM_OBJ_ICE_SPLASH, 144, 66, $28
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $9c
	anim_wait 6
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 66, $0
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 66, $28
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 66, $9c
	anim_wait 32
	anim_ret

BattleAnim_PoisonSting:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_PURPLE
	anim_2gfx ANIM_GFX_HORN, ANIM_GFX_HIT
	anim_obj ANIM_OBJ_NEEDLE,   8, 0,  11, 4, $14
	anim_wait 16
	anim_sound 0, 1, SFX_POISON_STING
	anim_obj ANIM_OBJ_HIT_SMALL, -15, 0,   7, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_PoisonJab:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_PURPLE
	anim_3gfx ANIM_GFX_OBJECTS_2, ANIM_GFX_HIT, ANIM_GFX_POISON
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $2, $0
.loop
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_POISON_JAB, 132, 56, $38
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 140, 44, $0
	anim_obj ANIM_OBJ_POISON_JAB, 132, 56, $20
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_POISON_JAB, 132, 56, $8
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 124, 60, $0
	anim_obj ANIM_OBJ_POISON_JAB, 132, 56, $10
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_POISON_JAB, 132, 56, $28
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 140, 60, $0
	anim_obj ANIM_OBJ_POISON_JAB, 132, 56, $0
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_POISON_JAB, 132, 56, $18
	anim_wait 4
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 124, 44, $0
	anim_obj ANIM_OBJ_POISON_JAB, 132, 56, $30
	anim_wait 4
.ok
	anim_loop 2, .loop
	anim_jump BattleAnimSub_SludgeShort

BattleAnim_PinMissile:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_2gfx ANIM_GFX_HORN, ANIM_GFX_HIT
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_MEDIUM_HORN, 64, 92, $28
	anim_wait 12
	anim_obj ANIM_OBJ_MEDIUM_HORN, 56, 84, $28
	anim_sound 0, 1, SFX_POISON_STING
	anim_obj ANIM_OBJ_HIT, 136, 56, $0
	anim_wait 12
	anim_obj ANIM_OBJ_MEDIUM_HORN, 52, 88, $28
	anim_sound 0, 1, SFX_POISON_STING
	anim_obj ANIM_OBJ_HIT, 128, 48, $0
	anim_wait 12
	anim_sound 0, 1, SFX_POISON_STING
	anim_obj ANIM_OBJ_HIT, 132, 52, $0
	anim_wait 16
	anim_ret

BattleAnim_IcicleSpear:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_3gfx ANIM_GFX_HORN, ANIM_GFX_ICE, ANIM_GFX_HIT
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_MEDIUM_HORN, 64, 92, $28
	anim_wait 12
	anim_obj ANIM_OBJ_MEDIUM_HORN, 56, 84, $28
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $28
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $10
	anim_obj ANIM_OBJ_ICE_SPLASH, 136, 56, $9c
	anim_wait 12
	anim_obj ANIM_OBJ_MEDIUM_HORN, 52, 88, $28
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, 128, 48, $0
	anim_obj ANIM_OBJ_ICE_SPLASH, 128, 48, $28
	anim_obj ANIM_OBJ_ICE_SPLASH, 128, 48, $10
	anim_obj ANIM_OBJ_ICE_SPLASH, 128, 48, $9c
	anim_wait 12
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, 132, 52, $0
	anim_obj ANIM_OBJ_ICE_SPLASH, 132, 52, $28
	anim_obj ANIM_OBJ_ICE_SPLASH, 132, 52, $10
	anim_obj ANIM_OBJ_ICE_SPLASH, 132, 52, $9c
	anim_wait 16
	anim_ret

BattleAnim_Transform:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_2Row
	anim_transform
	anim_sound 0, 0, SFX_PSYBEAM
	anim_bgeffect ANIM_BG_WAVE_DEFORM_MON, $0, $1, $0
	anim_wait 48
	anim_updateactorpic
	anim_incbgeffect ANIM_BG_WAVE_DEFORM_MON
	anim_wait 48
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_PetalDance:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_PINK
	anim_3gfx ANIM_GFX_PETALS, ANIM_GFX_FLOWER, ANIM_GFX_HIT
	anim_sound 0, 1, SFX_GAME_FREAK_LOGO_GS
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, BG_EFFECT_USER, $20
.loop
	anim_obj ANIM_OBJ_PETAL_DANCE, 48, 56, $1
	anim_wait 11
	anim_loop 8, .loop
	anim_wait 88
	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, BG_EFFECT_TARGET, $0
	anim_bgeffect ANIM_BG_TACKLE, $0, BG_EFFECT_USER, $0
	anim_call BattleAnim_Pursuit.hit
	anim_sound 0, 1, SFX_SWEET_SCENT
	anim_bgeffect ANIM_BG_SHOW_MON, $0, BG_EFFECT_TARGET, $0
	anim_clearobjs
	anim_bgeffect ANIM_BG_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_obj ANIM_OBJ_PETAL_DANCE_IMPACT, 136, 56, $28
	anim_obj ANIM_OBJ_PETAL_DANCE_IMPACT, 136, 56, $5c
	anim_obj ANIM_OBJ_PETAL_DANCE_IMPACT, 136, 56, $10
	anim_obj ANIM_OBJ_PETAL_DANCE_IMPACT, 136, 56, $e8
	anim_obj ANIM_OBJ_PETAL_DANCE_IMPACT, 136, 56, $9c
	anim_obj ANIM_OBJ_PETAL_DANCE_IMPACT, 136, 56, $d0
	anim_wait 6
	anim_obj ANIM_OBJ_PETAL_DANCE_IMPACT, 136, 56, $1c
	anim_obj ANIM_OBJ_PETAL_DANCE_IMPACT, 136, 56, $50
	anim_obj ANIM_OBJ_PETAL_DANCE_IMPACT, 136, 56, $dc
	anim_obj ANIM_OBJ_PETAL_DANCE_IMPACT, 136, 56, $90
	anim_wait 64
	anim_ret

BattleAnim_PayDay:
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_STATUS
	anim_sound 0, 1, SFX_POUND
	anim_obj ANIM_OBJ_HIT_YFIX,  16, 0,   7, 0, $0
	anim_wait 16
	anim_sound 0, 1, SFX_PAY_DAY
	anim_obj ANIM_OBJ_PAY_DAY,  15, 0,   9, 4, $1
	anim_wait 64
	anim_ret


BattleAnim_DrainKiss:
	anim_3gfx ANIM_GFX_OBJECTS, ANIM_GFX_CHARGE, ANIM_GFX_SHINE
	anim_setobjpal PAL_BATTLE_OB_GREEN, PAL_BTLCUSTOM_BRIGHT_PINK
	anim_sound 0, 1, SFX_SWEET_KISS
	anim_obj ANIM_OBJ_HEART, 120, 40, $0
	anim_wait 8
.loop
	anim_sound 0, 1, SFX_SWEET_KISS_2
	anim_obj ANIM_OBJ_ABSORB, 128, 48, $2
	anim_wait 5
	anim_sound 0, 1, SFX_SWEET_KISS_2
	anim_obj ANIM_OBJ_ABSORB, 136, 64, $3
	anim_wait 5
	anim_sound 0, 1, SFX_SWEET_KISS_2
	anim_obj ANIM_OBJ_ABSORB, 136, 32, $4
	anim_wait 5
	anim_loop 5, .loop
	anim_wait 32
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_jump BattleAnimSub_Glimmer

BattleAnim_Bonemerang:
	anim_2gfx ANIM_GFX_MISC, ANIM_GFX_HIT
	anim_sound 6, 2, SFX_HYDRO_PUMP
	anim_obj ANIM_OBJ_BONEMERANG,  11, 0,   7, 0, $1c
	anim_wait 24
	anim_sound 0, 1, SFX_MOVE_PUZZLE_PIECE
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 24
	anim_ret

BattleAnim_Swift:
	anim_1gfx ANIM_GFX_OBJECTS
	anim_sound 6, 2, SFX_METRONOME
	anim_obj ANIM_OBJ_SWIFT,   8, 0,  11, 0, $4
	anim_wait 4
	anim_obj ANIM_OBJ_SWIFT,   8, 0,   9, 0, $4
	anim_wait 4
	anim_obj ANIM_OBJ_SWIFT,   8, 0,   9, 4, $4
	anim_wait 64
	anim_ret

BattleAnim_Crabhammer:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_WATER
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BUBBLE
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_BUBBLE
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 08, $0
	anim_wait 1
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 16, $0
	anim_wait 1
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 24, $0
	anim_wait 1
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 32, $0
	anim_wait 1
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 40, $0
	anim_wait 1
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 1
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_Y, $40, $1, $20
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $3
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $5c
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $e8
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $50
.loop
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 12
	anim_loop 4, .loop
	anim_ret

BattleAnim_IronHead:
	anim_setobjpal PAL_BATTLE_OB_BROWN, PAL_BTLCUSTOM_BRIGHT
	anim_3gfx ANIM_GFX_ROCKS, ANIM_GFX_HIT, ANIM_GFX_REFLECT
	anim_obp0 $0
	anim_sound 0, 0, SFX_RAGE
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 6
	anim_sound 0, 1, SFX_HEADBUTT
	anim_wait 6
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 2
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_clearobjs
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 128, 56, $0
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 64, $28
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 64, $5c
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 64, $10
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 64, $e8
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 64, $9c
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 64, $d0
	anim_wait 6
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 64, $1c
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 64, $50
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 64, $dc
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 64, $90
	anim_wait 32
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_Peck:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 1, SFX_PECK
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX,  16, 0,   6, 0, $0
	anim_wait 8
	anim_sound 0, 1, SFX_PECK
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, -15, 0,   7, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_DrillPeck:
	anim_1gfx ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $64, $1, $0
.loop
	anim_sound 0, 1, SFX_PECK
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 132, 32, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 143, 37, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 148, 48, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 143, 59, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 132, 64, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 121, 59, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 116, 48, $0
	anim_wait 2
	anim_sound 0, 1, SFX_PECK
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 121, 37, $0
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 16
	anim_ret

BattleAnim_NightSlash:
	anim_2gfx ANIM_GFX_CUT, ANIM_GFX_WIND_BG
	anim_bgp $1b
	anim_obp0 $c0
	anim_obj ANIM_OBJ_AGILITY, 8, 24, $10
	anim_obj ANIM_OBJ_AGILITY, 8, 88, $8
	anim_wait 4
	anim_obj ANIM_OBJ_AGILITY, 8, 32, $6
	anim_obj ANIM_OBJ_AGILITY, 8, 80, $4
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $08, $2, $0
	anim_sound 0, 1, SFX_CUT
	anim_obj ANIM_OBJ_CUT_HORIZONTAL, 112, 48, $0
	anim_wait 40
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $08, $2, $0
	anim_sound 0, 1, SFX_CUT
	anim_obj ANIM_OBJ_CUT_HORIZONTAL, 152, 52, $20
	anim_wait 32
	anim_ret

BattleAnim_DazzlinGleam:
	anim_3gfx ANIM_GFX_HIT_2, ANIM_GFX_SHINE, ANIM_GFX_SPEED
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_TRI_COLOR
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_TRI_COLOR
	anim_sound 0, 1, SFX_MOONLIGHT
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_obj ANIM_OBJ_DAZZLE, 44, 88, $0
	anim_obj ANIM_OBJ_DAZZLE, 44, 88, $8
	anim_obj ANIM_OBJ_DAZZLE, 44, 88, $10
	anim_obj ANIM_OBJ_DAZZLE, 44, 88, $18
	anim_obj ANIM_OBJ_DAZZLE, 44, 88, $20
	anim_obj ANIM_OBJ_DAZZLE, 44, 88, $28
	anim_obj ANIM_OBJ_DAZZLE, 44, 88, $30
	anim_obj ANIM_OBJ_DAZZLE, 44, 88, $38
	anim_wait 48
	anim_setbgpal PAL_BATTLE_BG_PLAYER, PAL_BTLCUSTOM_VERY_BRIGHT_PINK
	anim_setbgpal PAL_BATTLE_BG_ENEMY, PAL_BTLCUSTOM_VERY_BRIGHT_PINK
	anim_setbgpal PAL_BATTLE_BG_ENEMY_HP, PAL_BTLCUSTOM_VERY_BRIGHT_PINK
	anim_setbgpal PAL_BATTLE_BG_PLAYER_HP, PAL_BTLCUSTOM_VERY_BRIGHT_PINK
	anim_setbgpal PAL_BATTLE_BG_EXP_GENDER, PAL_BTLCUSTOM_VERY_BRIGHT_PINK
	anim_setbgpal PAL_BATTLE_BG_STATUS, PAL_BTLCUSTOM_VERY_BRIGHT_PINK
	anim_setbgpal PAL_BATTLE_BG_TYPE_CAT, PAL_BTLCUSTOM_VERY_BRIGHT_PINK
	anim_setbgpal PAL_BATTLE_BG_TEXT, PAL_BTLCUSTOM_VERY_BRIGHT_PINK
	anim_incbgeffect ANIM_BG_ALTERNATE_HUES
	anim_sound 0, 1, SFX_FLASH
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $6, $20
	anim_wait 4
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_obj ANIM_OBJ_GLIMMER, 24, 64, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER, 56, 104, $0
	anim_wait 5
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_obj ANIM_OBJ_GLIMMER, 24, 104, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER, 56, 64, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER, 40, 84, $0
	anim_wait 5
	anim_wait 32
	anim_ret

BattleAnim_Flash:
	anim_1gfx ANIM_GFX_SPEED
	anim_sound 0, 1, SFX_FLASH
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $40
	anim_wait 4
	anim_obj ANIM_OBJ_FLASH, -15, 0,   7, 0, $0
	anim_wait 4
	anim_obj ANIM_OBJ_FLASH, -15, 0,   7, 0, $8
	anim_wait 4
	anim_obj ANIM_OBJ_FLASH, -15, 0,   7, 0, $10
	anim_wait 4
	anim_obj ANIM_OBJ_FLASH, -15, 0,   7, 0, $18
	anim_wait 4
	anim_obj ANIM_OBJ_FLASH, -15, 0,   7, 0, $20
	anim_wait 4
	anim_obj ANIM_OBJ_FLASH, -15, 0,   7, 0, $28
	anim_wait 4
	anim_obj ANIM_OBJ_FLASH, -15, 0,   7, 0, $30
	anim_wait 4
	anim_obj ANIM_OBJ_FLASH, -15, 0,   7, 0, $38
	anim_wait 32
	anim_bgp $e4
	anim_ret

BattleAnim_Astonish:
	anim_2gfx ANIM_GFX_SHINE, ANIM_GFX_MISC_2
	anim_battlergfx_2row
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_WATER
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $0, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_wait 12
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 1
	anim_clearobjs
	anim_wait 1
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $1, $0
	anim_wait 1
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
	anim_sound 0, 0, SFX_RAGE
	anim_obj ANIM_OBJ_FORESIGHT, 136, 48, $0
	anim_obj ANIM_OBJ_DROPLET_R, 146, 52, $38
	anim_obj ANIM_OBJ_DROPLET_L, 126, 52, $28
	anim_wait 32
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 4
	anim_ret

BattleAnim_Substitute:
	anim_sound 0, 0, SFX_SHARPEN
	anim_jumpif $3, .dropsub2
	anim_jumpif $2, .raisesub
	anim_jumpif $1, .dropsub
	anim_1gfx ANIM_GFX_SMOKE
	anim_bgeffect ANIM_BG_REMOVE_MON, $0, $1, $0
	anim_wait 32
	anim_raisesub
	anim_sound 0, 0, SFX_THROW_BALL
	anim_obj ANIM_OBJ_BALL_POOF,   6, 0,  12, 0, $0
	anim_bgeffect ANIM_BG_ENTER_MON, $0, $1, $0
	anim_wait 32
	anim_ret

.dropsub
	anim_bgeffect ANIM_BG_REMOVE_MON, $0, $1, $0
	anim_wait 32
	anim_dropsub
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_ret

.raisesub
	anim_bgeffect ANIM_BG_REMOVE_MON, $0, $1, $0
	anim_wait 32
	anim_raisesub
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_ret

.dropsub2
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_wait 32
	anim_dropsub
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_Minimize:
	anim_1gfx ANIM_GFX_MISC_2
.loop
	anim_sound 0, 1, SFX_SLUDGE_BOMB
	anim_bgeffect ANIM_BG_RETURN_MON, $0, $1, $0
	anim_wait 12
	anim_obj ANIM_OBJ_MINIMIZE, 48, 110, $0
	anim_wait 6
	anim_obj ANIM_OBJ_MINIMIZE, 48, 110, $0
	anim_wait 6
	anim_loop 2, .loop
	anim_sound 0, 1, SFX_SLUDGE_BOMB
	anim_bgeffect ANIM_BG_RETURN_MON, $0, $1, $0
	anim_wait 16
.mini
	anim_obj ANIM_OBJ_MINIMIZE, 48, 110, $0
	anim_wait 6
	anim_loop 8, .mini
	anim_sound 0, 1, SFX_LICK
	anim_bgeffect ANIM_BG_ENTER_MON, $0, $1, $0
	anim_wait 12
	anim_ret

BattleAnim_BraveBird:
	anim_1gfx ANIM_GFX_SKY_ATTACK
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_bgeffect ANIM_BG_REMOVE_MON, $0, $1, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_CYCLE_BGPALS_INVERTED, $0, $4, $0
	anim_obp0 $30
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_BRAVE_BIRD, 48, 88, $0
	anim_wait 16
	anim_clearobjs
	anim_sound 0, 0, SFX_HYPER_BEAM
	anim_obj ANIM_OBJ_BRAVE_BIRD, 48, 88, $18
	anim_wait 16
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_wait 64
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_NightShade:
	anim_1gfx ANIM_GFX_HIT
	anim_bgp $1b
	anim_obp1 $1b
	anim_wait 32
	anim_call BattleAnim_UserObj_2Row
	anim_bgeffect ANIM_BG_NIGHT_SHADE, $0, $0, $8
	anim_sound 0, 1, SFX_PSYCHIC
	anim_wait 96
	anim_incbgeffect ANIM_BG_NIGHT_SHADE
	anim_call BattleAnim_ShowMon_1
	anim_bgp $e4
	anim_ret

BattleAnim_TrickRoom:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PSYCHO_BOOST_2
	anim_1gfx ANIM_GFX_TRICK_ROOM
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_bgeffect ANIM_BG_PSYCHIC, $0, $0, $0
.loop
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_TRICK_ROOM, 80, 72, $0
	anim_wait 3
	anim_obj ANIM_OBJ_TRICK_ROOM, 156, 36, $0
	anim_wait 3
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_TRICK_ROOM, 40, 24, $0
	anim_wait 3
	anim_obj ANIM_OBJ_TRICK_ROOM, 140, 100, $0
	anim_wait 3
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_TRICK_ROOM, 164, 64, $0
	anim_wait 3
	anim_obj ANIM_OBJ_TRICK_ROOM, 48, 66, $0
	anim_wait 3
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_TRICK_ROOM, 96, 24, $0
	anim_wait 3
	anim_obj ANIM_OBJ_TRICK_ROOM, 60, 96, $0
	anim_wait 3
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_TRICK_ROOM, 102, 86, $0
	anim_wait 3
	anim_obj ANIM_OBJ_TRICK_ROOM, 150, 14, $0
	anim_wait 3
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_TRICK_ROOM, 26, 80, $0
	anim_wait 3
	anim_obj ANIM_OBJ_TRICK_ROOM, 12, 50, $0
	anim_wait 3
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_TRICK_ROOM, 72, 30, $0
	anim_wait 3
	anim_obj ANIM_OBJ_TRICK_ROOM, 110, 62, $0
	anim_wait 3
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_TRICK_ROOM, 170, 94, $0
	anim_wait 3
	anim_obj ANIM_OBJ_TRICK_ROOM, 80, 104, $0
	anim_wait 3
	anim_loop 2, .loop
	anim_wait 32
	anim_incbgeffect ANIM_BG_PSYCHIC
	anim_wait 4
	anim_ret

BattleAnim_Lick:
	anim_1gfx ANIM_GFX_WATER
	anim_sound 0, 1, SFX_LICK
	anim_obj ANIM_OBJ_LICK, -15, 0,   7, 0, $0
	anim_wait 64
	anim_ret

BattleAnim_TriAttack:
	anim_4gfx ANIM_GFX_FIRE, ANIM_GFX_ICE, ANIM_GFX_LIGHTNING, ANIM_GFX_TRIANGLE
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_sound 0, 1, SFX_THIEF_2
	anim_obj ANIM_OBJ_SPINNING_TRIANGLE, 48, 98, $0
	anim_wait 8
.loop
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_ICE
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_YELLOW
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_wait 8
	anim_loop 2, .loop
	anim_clearobjs
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj ANIM_OBJ_SHOOTING_TRIANGLE, 48, 98, $2
.loop2
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_ICE
	anim_wait 7
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_YELLOW
	anim_wait 7
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_wait 7
	anim_loop 2, .loop2
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $20, $0
	anim_call BattleAnimSub_Fire
	anim_wait 16
	anim_call BattleAnimSub_Ice
	anim_wait 16
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $4
	anim_sound 0, 1, SFX_THUNDER
	anim_obj ANIM_OBJ_THUNDER3, 152, 68, $0
	anim_wait 16
	anim_ret

BattleAnim_Psybeam:
	anim_1gfx ANIM_GFX_PSYCHIC
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_CYCLE_BGPALS_INVERTED, $0, $4, $0
.loop
	anim_sound 6, 2, SFX_PSYBEAM
	anim_obj ANIM_OBJ_WAVE,   8, 0,  11, 0, $4
	anim_wait 4
	anim_loop 10, .loop
	anim_wait 48
	anim_ret

BattleAnim_DarkPulse:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_DARK_PULSE
	anim_1gfx ANIM_GFX_OBJECTS_2
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_WHIRLPOOL, $0, $0, $0
	anim_bgp $1b
	anim_sound 0, 1, SFX_SPITE
	anim_obj ANIM_OBJ_DARK_PULSE_E,  52, 92, $0
	anim_obj ANIM_OBJ_DARK_PULSE_SE, 48, 96, $8
	anim_obj ANIM_OBJ_DARK_PULSE_S,  44, 96, $10
	anim_obj ANIM_OBJ_DARK_PULSE_SW, 40, 96, $18
	anim_obj ANIM_OBJ_DARK_PULSE_W,  36, 92, $20
	anim_obj ANIM_OBJ_DARK_PULSE_NW, 40, 88, $28
	anim_obj ANIM_OBJ_DARK_PULSE_N,  44, 88, $30
	anim_obj ANIM_OBJ_DARK_PULSE_NE, 48, 88, $38
	anim_wait 96
	anim_incbgeffect ANIM_BG_WHIRLPOOL
	anim_ret

BattleAnim_DreamEater:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_PINK
	anim_1gfx ANIM_GFX_CHARGE
	anim_bgp $1b
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
.loop
	anim_sound 6, 3, SFX_WARP_TO
	anim_obj ANIM_OBJ_ABSORB, 128, 48, $2
	anim_wait 5
	anim_sound 6, 3, SFX_WARP_TO
	anim_obj ANIM_OBJ_ABSORB, 136, 64, $3
	anim_wait 5
	anim_sound 6, 3, SFX_WARP_TO
	anim_obj ANIM_OBJ_ABSORB, 136, 32, $4
	anim_wait 5
	anim_loop 7, .loop
	anim_wait 32
	anim_ret

BattleAnim_LeechLife:
	anim_setobjpal PAL_BATTLE_OB_GREEN, PAL_BTLCUSTOM_PEACH
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_3gfx ANIM_GFX_HIT_2, ANIM_GFX_HORN, ANIM_GFX_CHARGE
	anim_obj ANIM_OBJ_NEEDLE, 64, 92, $14
	anim_wait 16
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $2
	anim_sound 0, 1, SFX_POISON_STING
	anim_obj ANIM_OBJ_HIT_SMALL, 136, 56, $0
	anim_wait 16
.loop
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj ANIM_OBJ_ABSORB, 128, 48, $2
	anim_wait 3
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj ANIM_OBJ_ABSORB, 136, 64, $3
	anim_wait 4
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj ANIM_OBJ_ABSORB, 136, 32, $4
	anim_wait 3
	anim_loop 6, .loop
	anim_wait 28
	anim_ret

BattleAnim_Extrasensory:
	anim_1gfx ANIM_GFX_SHINE
	anim_call BattleAnim_UserObj_2Row
	anim_sound 0, 1, SFX_CUT
	anim_bgp $1b
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
	anim_obj ANIM_OBJ_GLIMMER, 44, 96, $0
	anim_wait 40
	anim_sound 0, 1, SFX_CUT
	anim_bgeffect ANIM_BG_NIGHT_SHADE, $0, $0, $8
	anim_obj ANIM_OBJ_GLIMMER, 44, 96, $0
	anim_wait 32
	anim_incbgeffect ANIM_BG_NIGHT_SHADE
	anim_wait 8
	anim_sound 0, 1, SFX_CUT
	anim_bgeffect ANIM_BG_TELEPORT, $0, $0, $0
	anim_obj ANIM_OBJ_GLIMMER, 44, 96, $0
	anim_wait 4
	anim_sound 0, 1, SFX_PSYCHIC
	anim_wait 64
	anim_incbgeffect ANIM_BG_TELEPORT
	anim_call BattleAnim_ShowMon_1
	anim_ret

BattleAnim_Glare:
	anim_1gfx ANIM_GFX_BEAM
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $20
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_call BattleAnimSub_ShakeEnemy
	anim_wait 16
	anim_ret

BattleAnim_Thrash:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 1, SFX_POUND
	anim_obj ANIM_OBJ_PALM,  15, 0,   9, 0, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX,  15, 0,   9, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_MOVE_PUZZLE_PIECE
	anim_obj ANIM_OBJ_PUNCH, -15, 0,   7, 0, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   7, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_KICK, -13, 0,   5, 0, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -13, 0,   5, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_Growth:
	anim_bgeffect ANIM_BG_WHITE_HUES, $0, $8, $0
	anim_1gfx ANIM_GFX_CHARGE
	anim_sound 0, 0, SFX_SWORDS_DANCE
	anim_obj ANIM_OBJ_GROWTH,   6, 0,  13, 4, $0
	anim_obj ANIM_OBJ_GROWTH,   6, 0,  13, 4, $8
	anim_obj ANIM_OBJ_GROWTH,   6, 0,  13, 4, $10
	anim_obj ANIM_OBJ_GROWTH,   6, 0,  13, 4, $18
	anim_obj ANIM_OBJ_GROWTH,   6, 0,  13, 4, $20
	anim_obj ANIM_OBJ_GROWTH,   6, 0,  13, 4, $28
	anim_obj ANIM_OBJ_GROWTH,   6, 0,  13, 4, $30
	anim_obj ANIM_OBJ_GROWTH,   6, 0,  13, 4, $38
	anim_wait 64
	anim_ret

BattleAnim_Smokescreen:
	anim_3gfx ANIM_GFX_HAZE, ANIM_GFX_EGG, ANIM_GFX_SMOKE
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj ANIM_OBJ_SMOKESCREEN,   8, 0,  11, 4, $6c
	anim_wait 24
	anim_incobj 1
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj ANIM_OBJ_BALL_POOF,  13, 4,   8, 6, $10
	anim_wait 8
.loop
	anim_sound 0, 1, SFX_MENU
	anim_obj ANIM_OBJ_SMOKE, -16, 4,   7, 4, $20
	anim_wait 8
	anim_loop 5, .loop
	anim_wait 128
	anim_ret

BattleAnim_Strength:
	anim_2gfx ANIM_GFX_ROCKS, ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_Y, $10, $1, $20
	anim_sound 0, 0, SFX_STRENGTH
	anim_obj ANIM_OBJ_STRENGTH,   8, 0,  13, 0, $1
	anim_wait 128
	anim_incobj 1
	anim_wait 20
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -16, 4,   5, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_SwordsDance:
	anim_1gfx ANIM_GFX_WHIP
	anim_sound 0, 0, SFX_SWORDS_DANCE
	anim_obj ANIM_OBJ_SWORDS_DANCE,   6, 0,  13, 4, $0
	anim_obj ANIM_OBJ_SWORDS_DANCE,   6, 0,  13, 4, $d
	anim_obj ANIM_OBJ_SWORDS_DANCE,   6, 0,  13, 4, $1a
	anim_obj ANIM_OBJ_SWORDS_DANCE,   6, 0,  13, 4, $27
	anim_obj ANIM_OBJ_SWORDS_DANCE,   6, 0,  13, 4, $34
	anim_wait 56
	anim_ret

BattleAnim_DragonDance:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_DRAGONBREATH
	anim_1gfx ANIM_GFX_CHARGE
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
.loop
	anim_sound 0, 0, SFX_OUTRAGE
	anim_obj ANIM_OBJ_DRAGON_DANCE, 48, 104, $0
	anim_wait 8
	anim_loop 8, .loop
	anim_wait 48
	anim_ret

BattleAnim_HoneClaws:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_GRAY
	anim_2gfx ANIM_GFX_CUT, ANIM_GFX_SPEED
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj ANIM_OBJ_HONE_CLAWS_RIGHT, 24, 84, $0
	anim_wait 7
	anim_sound 0, 1, SFX_SHINE
	anim_wait 5
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj ANIM_OBJ_HONE_CLAWS_LEFT, 72, 84, $0
	anim_wait 7
	anim_sound 0, 1, SFX_SHINE
	anim_wait 5
.loop
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj ANIM_OBJ_HONE_CLAWS_RIGHT, 24, 84, $0
	anim_wait 2
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 20, 72, $0
	anim_wait 5
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 28, 104, $0
	anim_wait 5
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj ANIM_OBJ_HONE_CLAWS_LEFT, 72, 84, $0
	anim_wait 2
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 76, 72, $0
	anim_wait 5
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 68, 104, $0
	anim_wait 5
	anim_loop 3, .loop
	anim_ret

BattleAnim_QuickAttack:
	anim_2gfx ANIM_GFX_SPEED, ANIM_GFX_HIT
	anim_sound 0, 0, SFX_MENU
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_call BattleAnimSub_QuickAttack
	anim_wait 12
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 16
	anim_ret

BattleAnim_BulkUp:
	anim_2gfx ANIM_GFX_BULK_UP, ANIM_GFX_WIND
	anim_sound 0, 0, SFX_SQUEAK
	anim_obj ANIM_OBJ_BULK_UP, 48, 88, $0
	anim_wait 32
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $08, $2, $0
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BULK_UP
	anim_sound 0, 0, SFX_HORN_ATTACK
	anim_wait 16
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_wait 8
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $08, $2, $0
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BULK_UP
	anim_sound 0, 0, SFX_HORN_ATTACK
	anim_wait 24
	anim_clearobjs
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GRAY
	anim_sound 0, 0, SFX_MENU
	anim_obj ANIM_OBJ_SWAGGER, 72, 88, $44
	anim_wait 32
	anim_ret

BattleAnim_DefenseCurl:
	anim_1gfx ANIM_GFX_SHAPES
	anim_obp0 $e4
	anim_call BattleAnim_TargetObj_1Row
	anim_sound 0, 0, SFX_SHARPEN
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_obj ANIM_OBJ_DEFENSE_CURL,   6, 0,  11, 0, $0
	anim_wait 96
	anim_incobj 2
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_Withdraw: ; reassigned
	anim_1gfx ANIM_GFX_REFLECT
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_WITHDRAW, $0, $1, $50
	anim_wait 48
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_WITHDRAW,   6, 0,  11, 0, $0
	anim_wait 64
	anim_incobj 2
	anim_wait 1
	anim_incbgeffect ANIM_BG_WITHDRAW
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_Harden: ; reassigned
	anim_1gfx ANIM_GFX_REFLECT
	anim_obp0 $0
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_SeismicToss:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GLOBE
	anim_1gfx ANIM_GFX_SPEED
	anim_sound 0, 0, SFX_MENU
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_call BattleAnimSub_QuickAttack
	anim_wait 12
	anim_1gfx ANIM_GFX_U_TURN
	anim_obj ANIM_OBJ_BLUR_DIAGONAL, 64, 92, $18
	anim_wait 8
	anim_clearobjs
	anim_wait 1
	anim_1gfx ANIM_GFX_GLOBE
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $0, $0
	anim_sound 0, 1, SFX_BONE_CLUB
	anim_obj ANIM_OBJ_SEISMIC_TOSS, 132, 48, $0
	anim_wait 24
	anim_clearobjs
	anim_sound 0, 0, SFX_OUTRAGE
	anim_obj ANIM_OBJ_SEISMIC_TOSS_UP, 132, 48, $30
	anim_wait 64
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_SEISMIC_TOSS_DOWN, 132, 240, $10
	anim_wait 16
	anim_clearobjs
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $4, $10
	anim_wait 16
	anim_ret

BattleAnim_Rage:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_sound 0, 0, SFX_RAGE
	anim_wait 72
	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_sound 0, 1, SFX_MOVE_PUZZLE_PIECE
	anim_obj ANIM_OBJ_HIT_BIG_YFIX,  15, 0,   9, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   7, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -13, 0,   5, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_Agility:
	anim_1gfx ANIM_GFX_WIND_BG
	anim_obp0 $fc
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_call BattleAnimSub_Agility
.loop
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_wait 4
	anim_loop 18, .loop
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_EarthPower:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_2gfx ANIM_GFX_FIRE, ANIM_GFX_ROCKS
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_bgp $1b
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $28, $2, $0
	anim_obj ANIM_OBJ_ROCK_SMASH, 120, 68, $5c
	anim_obj ANIM_OBJ_ROCK_SMASH, 120, 68, $e8
	anim_obj ANIM_OBJ_ROCK_SMASH, 120, 68, $9c
	anim_obj ANIM_OBJ_ROCK_SMASH, 120, 68, $50
	anim_obj ANIM_OBJ_EMBER, 120, 68, $30
	anim_wait 40
	anim_clearobjs
	anim_wait 8
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $28, $2, $0
	anim_obj ANIM_OBJ_ROCK_SMASH, 144, 68, $5c
	anim_obj ANIM_OBJ_ROCK_SMASH, 144, 68, $e8
	anim_obj ANIM_OBJ_ROCK_SMASH, 144, 68, $d0
	anim_obj ANIM_OBJ_ROCK_SMASH, 144, 68, $10
	anim_obj ANIM_OBJ_EMBER, 144, 68, $30
	anim_wait 40
	anim_clearobjs
	anim_wait 8
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $28, $2, $0
	anim_obj ANIM_OBJ_ROCK_SMASH, 132, 68, $28
	anim_obj ANIM_OBJ_ROCK_SMASH, 132, 68, $e8
	anim_obj ANIM_OBJ_ROCK_SMASH, 132, 68, $d0
	anim_obj ANIM_OBJ_ROCK_SMASH, 132, 68, $50
	anim_obj ANIM_OBJ_EMBER, 132, 68, $30
	anim_wait 48
	anim_ret

BattleAnim_Barrier:
	anim_1gfx ANIM_GFX_REFLECT
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_wait 8
.loop
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SCREEN,   9, 0,  10, 0, $0
	anim_wait 32
	anim_loop 2, .loop
	anim_ret

BattleAnim_Waterfall:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_WATER
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BUBBLE
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_BUBBLE
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_RISING_BUBBLE, 64, 104, $0
	anim_wait 16
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_RISING_BUBBLE, 32, 104, $0
	anim_wait 16
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_RISING_BUBBLE, 48, 104, $0
	anim_wait 32
	anim_clearobjs
	anim_wait 1
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_BODY_SLAM, $0, BG_EFFECT_USER, $0
	anim_wait 16
	anim_bgeffect ANIM_BG_SHOW_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 4
	anim_clearobjs
	anim_bgeffect ANIM_BG_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_sound 0, 1, SFX_BUBBLE_BEAM
	anim_wait 8
	anim_obj ANIM_OBJ_HIT_YFIX, 134, 64, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 138, 64, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 130, 64, $10
	anim_wait 3                 
	anim_obj ANIM_OBJ_HIT_YFIX, 134, 56, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 138, 56, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 130, 56, $10
	anim_wait 3                 
	anim_obj ANIM_OBJ_HIT_YFIX, 134, 48, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 138, 48, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 130, 48, $10
	anim_wait 3                 
	anim_obj ANIM_OBJ_HIT_YFIX, 134, 40, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 138, 40, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 130, 40, $10
	anim_wait 3                 
	anim_obj ANIM_OBJ_HIT_YFIX, 134, 32, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 138, 32, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 130, 32, $10
	anim_wait 8
	anim_ret

BattleAnim_PsychicM:
	anim_1gfx ANIM_GFX_PSYCHIC
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_bgeffect ANIM_BG_PSYCHIC, $0, $0, $0
.loop
	anim_sound 6, 2, SFX_PSYCHIC
	anim_obj ANIM_OBJ_WAVE,   8, 0,  11, 0, $2
	anim_wait 8
	anim_loop 8, .loop
	anim_wait 96
	anim_incbgeffect ANIM_BG_PSYCHIC
	anim_wait 4
	anim_ret

BattleAnim_Toxic:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_1gfx ANIM_GFX_POISON
	anim_bgeffect ANIM_BG_BLACK_HUES, $0, $8, $0
	anim_call BattleAnimSub_Acid
	anim_wait 32
	anim_call BattleAnimSub_Sludge
	anim_wait 64
	anim_ret

BattleAnim_Metronome:
	anim_2gfx ANIM_GFX_MISC, ANIM_GFX_SPEED
	anim_sound 0, 0, SFX_METRONOME
	anim_obj ANIM_OBJ_METRONOME_HAND,   9, 0,  11, 0, $0
.loop
	anim_obj ANIM_OBJ_METRONOME_SPARKLE,   9, 0,  10, 0, $0
	anim_wait 8
	anim_loop 5, .loop
	anim_wait 48
	anim_ret

BattleAnim_Counter:
	anim_1gfx ANIM_GFX_HIT
.loop
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $6, $2
	anim_sound 0, 1, SFX_POUND
	anim_obj ANIM_OBJ_PALM,  15, 0,   9, 0, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX,  15, 0,   9, 0, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $6, $2
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_PUNCH, -15, 0,   5, 0, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   5, 0, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $6, $2
	anim_sound 0, 1, SFX_MEGA_KICK
	anim_obj ANIM_OBJ_KICK, -13, 0,   7, 0, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -13, 0,   7, 0, $0
	anim_wait 6
	anim_loop 3, .loop
	anim_wait 16
	anim_ret

BattleAnim_LowKick:
	anim_1gfx ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_KICK,  15, 4,   8, 0, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX,  15, 4,   8, 0, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_KICK, -16, 4,   8, 0, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -16, 4,   8, 0, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_KICK, -15, 4,   8, 0, $0
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 4,   8, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_WingAttack:
	anim_1gfx ANIM_GFX_HIT
BattleAnimSub_WingAttack:
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, -14, 4,   7, 0, $0
	anim_obj ANIM_OBJ_HIT_YFIX,  14, 4,   7, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   7, 0, $0
	anim_obj ANIM_OBJ_HIT_YFIX,  15, 0,   7, 0, $0
	anim_wait 6
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 4,   7, 0, $0
	anim_obj ANIM_OBJ_HIT_YFIX,  15, 4,   7, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_Disable:
	anim_2gfx ANIM_GFX_LIGHTNING, ANIM_GFX_STATUS
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj ANIM_OBJ_DISABLE, -16, 4,   7, 0, $0
	anim_wait 16
	anim_sound 0, 1, SFX_BIND
	anim_obj ANIM_OBJ_PARALYZED, 104, 52, $42
	anim_obj ANIM_OBJ_PARALYZED, 160, 52, $c2
	anim_wait 96
	anim_ret

BattleAnim_Struggle:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 1, SFX_POUND
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_Sketch:
	anim_1gfx ANIM_GFX_OBJECTS
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_sound 0, 0, SFX_SKETCH
	anim_obj ANIM_OBJ_SKETCH,   9, 0,  10, 0, $0
	anim_wait 80
	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_wait 1
	anim_ret

BattleAnim_DrainPunch:
	anim_setobjpal PAL_BATTLE_OB_GREEN, PAL_BTLCUSTOM_PEACH
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_CHARGE
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_LONG_PUNCH, 136, 52, $0
	anim_wait 16
.loop
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj ANIM_OBJ_ABSORB, 128, 48, $2
	anim_wait 3
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj ANIM_OBJ_ABSORB, 136, 64, $3
	anim_wait 4
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj ANIM_OBJ_ABSORB, 136, 32, $4
	anim_wait 3
	anim_loop 6, .loop
	anim_incobj  1
	anim_wait 32
	anim_ret

BattleAnim_Thief:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 16
	anim_sound 0, 1, SFX_THIEF
	anim_obj ANIM_OBJ_HIT_YFIX,  16, 0,   6, 0, $0
	anim_wait 16
	anim_call BattleAnim_ShowMon_0
	anim_wait 1
	anim_1gfx ANIM_GFX_STATUS
	anim_sound 0, 1, SFX_THIEF_2
	anim_obj ANIM_OBJ_THIEF,  15, 0,   9, 4, $1
	anim_wait 64
	anim_ret

BattleAnim_BugBuzz:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_PALE_LIME
	anim_2gfx ANIM_GFX_MID_GLOW_CLEAR, ANIM_GFX_BUG_BUZZ
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $4a, $1, $0
.loop
	anim_obj ANIM_OBJ_MID_GLOW_SHRINKING, 48, 96, $0
	anim_sound 6, 2, SFX_BIND
	anim_obj ANIM_OBJ_BUG_BUZZ, 32, 84, $28
	anim_obj ANIM_OBJ_BUG_BUZZ, 64, 84, $38
	anim_wait 2
	anim_sound 6, 2, SFX_BIND
	anim_wait 2
	anim_sound 6, 2, SFX_BIND
	anim_obj ANIM_OBJ_BUG_BUZZ, 32, 84, $28
	anim_obj ANIM_OBJ_BUG_BUZZ, 64, 84, $38
	anim_wait 2
	anim_sound 6, 2, SFX_BIND
	anim_wait 2
	anim_loop 6, .loop
	anim_wait 2
	anim_sound 6, 2, SFX_SUPERSONIC
	anim_wait 6
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $1, $0
	anim_wait 1
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
	anim_wait 64
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_FlameCharge: ; formerly Flame Wheel
	anim_1gfx ANIM_GFX_FIRE
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_FIRE
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
.loop
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_FLAME_CHARGE, 40, 86, $10
	anim_wait 6
	anim_sound 6, 2, SFX_EMBER
	anim_obj ANIM_OBJ_FLAME_CHARGE, 56, 86, $90
	anim_wait 6
	anim_loop 5, .loop
	anim_wait 80
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_wait 1
	anim_clearobjs
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 4
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $3
	anim_sound 0, 1, SFX_EMBER
	anim_obj ANIM_OBJ_FIRE_BLAST, 136, 48, $1
	anim_obj ANIM_OBJ_FIRE_BLAST, 136, 48, $4
	anim_obj ANIM_OBJ_FIRE_BLAST, 136, 48, $5
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 4
	anim_incobj 11
	anim_wait 8
	anim_ret

BattleAnim_HyperVoice:
	anim_2gfx ANIM_GFX_NOISE, ANIM_GFX_PSYCHIC
.loop
	anim_cry $0
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $30, $2, $0
	anim_obj ANIM_OBJ_SOUND, 64, 76, $0
	anim_obj ANIM_OBJ_SOUND, 64, 88, $1
	anim_obj ANIM_OBJ_SOUND, 64, 100, $2
	anim_obj ANIM_OBJ_HYPER_VOICE, 64, 88, $2
	anim_wait 2
	anim_obj ANIM_OBJ_HYPER_VOICE, 64, 88, $2
	anim_wait 28
	anim_obj ANIM_OBJ_SOUND, 64, 76, $0
	anim_obj ANIM_OBJ_SOUND, 64, 88, $1
	anim_obj ANIM_OBJ_SOUND, 64, 100, $2
	anim_wait 28
	anim_loop 2, .loop
	anim_wait 8
	anim_ret

BattleAnim_Curse:
	anim_jumpif $1, .Ghost
	anim_1gfx ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING, $0, $1, $40
	anim_sound 0, 0, SFX_SHARPEN
	anim_wait 64
	anim_incbgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING
	anim_wait 1
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT, $0, $1, $40
.loop
	anim_call BattleAnimSub_Focus
	anim_loop 3, .loop
	anim_wait 8
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT
	anim_call BattleAnim_ShowMon_0
	anim_ret

.Ghost:
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_OBJECTS
	anim_obj ANIM_OBJ_CURSE,   8, 4,   9, 0, $0
	anim_sound 0, 0, SFX_CURSE
	anim_wait 32
	anim_incobj 1
	anim_wait 12
	anim_sound 0, 0, SFX_POISON_STING
	anim_obj ANIM_OBJ_HIT,   5, 4,  12, 0, $0
	anim_wait 16
	anim_ret

BattleAnim_Conversion:
	anim_1gfx ANIM_GFX_EXPLOSION
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_sound 63, 3, SFX_SHARPEN
	anim_obj ANIM_OBJ_CONVERSION,   6, 0,  11, 0, $0
	anim_obj ANIM_OBJ_CONVERSION,   6, 0,  11, 0, $8
	anim_obj ANIM_OBJ_CONVERSION,   6, 0,  11, 0, $10
	anim_obj ANIM_OBJ_CONVERSION,   6, 0,  11, 0, $18
	anim_obj ANIM_OBJ_CONVERSION,   6, 0,  11, 0, $20
	anim_obj ANIM_OBJ_CONVERSION,   6, 0,  11, 0, $28
	anim_obj ANIM_OBJ_CONVERSION,   6, 0,  11, 0, $30
	anim_obj ANIM_OBJ_CONVERSION,   6, 0,  11, 0, $38
	anim_wait 128
	anim_ret

BattleAnim_Aeroblast:
	anim_2gfx ANIM_GFX_BEAM, ANIM_GFX_AEROBLAST
	anim_bgp $1b
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $50, $4, $10
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_AEROBLAST
	anim_obj ANIM_OBJ_AEROBLAST,   9, 0,  11, 0, $0
	anim_wait 32
	anim_sound 0, 0, SFX_HYPER_BEAM
	anim_obj ANIM_OBJ_BEAM,  10, 0,  10, 4, $0
	anim_wait 2
	anim_sound 0, 1, SFX_HYPER_BEAM
	anim_obj ANIM_OBJ_BEAM,  12, 0,   9, 4, $0
	anim_wait 2
	anim_sound 0, 1, SFX_HYPER_BEAM
	anim_obj ANIM_OBJ_BEAM,  14, 0,   8, 4, $0
	anim_obj ANIM_OBJ_BEAM_TIP,  15, 6,   7, 6, $0
	anim_wait 48
	anim_bgp $e4
	anim_ret

BattleAnim_SeedBomb:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_2gfx ANIM_GFX_PLANT, ANIM_GFX_EXPLOSION
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_SEED_BOMB, 56, 72, $20
	anim_wait 8
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_SEED_BOMB, 48, 72, $30
	anim_wait 8
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_SEED_BOMB, 64, 72, $28
	anim_wait 8
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_SEED_BOMB, 48, 72, $20
	anim_wait 8
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj ANIM_OBJ_SEED_BOMB, 56, 72, $30
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $3
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $40, $2, $0
	anim_obj ANIM_OBJ_EXPLOSION2, 136, 56, $0
	anim_wait 8
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION2, 130, 68, $0
	anim_wait 8
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION2, 134, 50, $0
	anim_wait 8
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION2, 132, 54, $0
	anim_wait 8
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION2, 136, 62, $0
	anim_wait 24
	anim_ret

BattleAnim_EnergyBall:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_GASTRO_ACID
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_GASTRO_ACID
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GASTRO_ACID
	anim_4gfx ANIM_GFX_ENERGY_BALL, ANIM_GFX_GLOW, ANIM_GFX_HIT, ANIM_GFX_BUBBLE
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_obj ANIM_OBJ_ABSORB_CENTER, 44, 88, $0
	anim_obj ANIM_OBJ_CHARGE, 44, 88, $30
	anim_obj ANIM_OBJ_CHARGE, 44, 88, $31
	anim_obj ANIM_OBJ_CHARGE, 44, 88, $32
	anim_obj ANIM_OBJ_CHARGE, 44, 88, $33
	anim_obj ANIM_OBJ_CHARGE, 44, 88, $34
	anim_obj ANIM_OBJ_CHARGE, 44, 88, $35
	anim_obj ANIM_OBJ_CHARGE, 44, 88, $36
	anim_obj ANIM_OBJ_CHARGE, 44, 88, $37
.loop
	anim_sound 0, 0, SFX_WARP_TO
	anim_wait 16
	anim_loop 4, .loop
	anim_wait 16
	anim_sound 0, 1, SFX_PRESENT
	anim_wait 48
	anim_clearobjs
	anim_sound 0, 1, SFX_SWEET_SCENT
	anim_obj ANIM_OBJ_SIGNAL_BEAM_R, 64, 92, $2
	anim_wait 32
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 4
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $6, $1, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $5c
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $e8
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 64, $50
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_HIT_YFIX, 144, 48, $0
	anim_wait 4
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_HIT_YFIX, 128, 40, $0
	anim_wait 16
	anim_ret

BattleAnim_Reversal:
	anim_2gfx ANIM_GFX_SHINE, ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT,  14, 0,   8, 0, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_FORESIGHT,  15, 0,   7, 0, $0
	anim_wait 2
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT,  16, 0,   7, 0, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_FORESIGHT, -15, 0,   6, 0, $0
	anim_wait 2
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT, -14, 0,   6, 0, $0
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_FORESIGHT, -13, 0,   5, 0, $0
	anim_wait 24
	anim_ret

BattleAnim_Hex:
	anim_2gfx ANIM_GFX_FIRE, ANIM_GFX_SPEED
	anim_battlergfx_2row
	anim_bgp $f8
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $1, $0
	anim_wait 8
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
	anim_wait 40
	anim_bgp $1b
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_PURPLE
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_WILL_O_WISP
	anim_sound 0, 0, SFX_SPITE
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_obj ANIM_OBJ_BURNED, 116, 52, $10
	anim_obj ANIM_OBJ_BURNED, 148, 52, $90
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $55, $1, $0
.loop
	anim_obj ANIM_OBJ_FOCUS, 136, 72, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 128, 72, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 144, 72, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 120, 72, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 152, 72, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 112, 72, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 160, 72, $8
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 8
	anim_wait 16
	anim_ret

BattleAnim_IceShard:
	anim_4gfx ANIM_GFX_ICE, ANIM_GFX_HAZE, ANIM_GFX_SPEED, ANIM_GFX_HIT
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_ICE
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_ICE
	anim_bgeffect ANIM_BG_WHITE_HUES, $0, $8, $0
	anim_sound 0, 0, SFX_SWORDS_DANCE
	anim_obp0 $54
.loop
	anim_obj ANIM_OBJ_ICE_SHARD_MIST, 48, 80, $0
	anim_wait 8
	anim_loop 4, .loop
	anim_obj ANIM_OBJ_ICE, 40, 78, $0
	anim_wait 6
	anim_obj ANIM_OBJ_ICE, 56, 106, $0
	anim_wait 6
	anim_obj ANIM_OBJ_ICE, 32, 92, $0
	anim_wait 6
	anim_obj ANIM_OBJ_ICE, 64, 92, $0
	anim_wait 6
	anim_obj ANIM_OBJ_ICE, 56, 78, $0
	anim_wait 6
	anim_obj ANIM_OBJ_ICE, 40, 106, $0
	anim_wait 6
	anim_resetobp0
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_ICE
	anim_sound 0, 0, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_ICE_SHARD, 48, 84, $18
	anim_wait 6
	anim_obj ANIM_OBJ_ICE_SHARD, 48, 116, $18
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, 140, 44, $0
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_ICE_SHARD, 48, 108, $18
	anim_wait 4
	anim_obj ANIM_OBJ_HIT_YFIX, 124, 60, $0
	anim_sound 6, 2, SFX_SHINE
	anim_wait 2
	anim_obj ANIM_OBJ_ICE_SHARD, 48, 92, $18
	anim_wait 2
	anim_obj ANIM_OBJ_HIT_YFIX, 140, 60, $0
	anim_sound 6, 2, SFX_SHINE
	anim_wait 4
	anim_obj ANIM_OBJ_HIT_YFIX, 124, 44, $0
	anim_sound 6, 2, SFX_SHINE
	anim_wait 4
	anim_obj ANIM_OBJ_HIT_YFIX, 132, 52, $0
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 148, 32, $0
	anim_wait 6
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 116, 64, $0
	anim_wait 6
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 148, 64, $0
	anim_wait 6
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 116, 32, $0
	anim_wait 6
	anim_obj ANIM_OBJ_PULSING_SPARKLE_YFIX, 132, 48, $0
	anim_wait 32
	anim_ret

BattleAnim_Protect:
	anim_1gfx ANIM_GFX_OBJECTS
	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
	anim_obj ANIM_OBJ_PROTECT,  10, 0,  10, 0, $0
	anim_obj ANIM_OBJ_PROTECT,  10, 0,  10, 0, $d
	anim_obj ANIM_OBJ_PROTECT,  10, 0,  10, 0, $1a
	anim_obj ANIM_OBJ_PROTECT,  10, 0,  10, 0, $27
	anim_obj ANIM_OBJ_PROTECT,  10, 0,  10, 0, $34
	anim_sound 0, 0, SFX_PROTECT
	anim_wait 96
	anim_ret

BattleAnim_MachPunch:
	anim_2gfx ANIM_GFX_SPEED, ANIM_GFX_HIT
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_sound 0, 0, SFX_MENU
	anim_call BattleAnimSub_QuickAttack
	anim_wait 12
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_PUNCH, -15, 0,   7, 0, $0
	anim_wait 6
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 16
	anim_ret

BattleAnim_ScaryFace:
	anim_1gfx ANIM_GFX_BEAM
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_call BattleAnimSub_ShakeEnemy
	anim_wait 64
	anim_ret

BattleAnim_FeintAttack:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 0, SFX_CURSE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_FADE_MON_TO_WHITE_WAIT_FADE_BACK, $0, $1, $80
	anim_wait 96
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT, 120, 40, $0
	anim_wait 8
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT, 152, 48, $0
	anim_wait 8
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT, 136, 56, $0
	anim_wait 32
	anim_incbgeffect ANIM_BG_FADE_MON_TO_WHITE_WAIT_FADE_BACK
	anim_call BattleAnim_ShowMon_0
	anim_wait 4
	anim_ret

BattleAnim_SweetKiss:
	anim_2gfx ANIM_GFX_OBJECTS, ANIM_GFX_ANGELS
	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
	anim_obj ANIM_OBJ_SWEET_KISS,  12, 0,   5, 0, $0
	anim_sound 0, 1, SFX_SWEET_KISS
	anim_wait 32
	anim_sound 0, 1, SFX_SWEET_KISS_2
	anim_obj ANIM_OBJ_HEART,  15, 0,   5, 0, $0
	anim_wait 40
	anim_ret

BattleAnim_BellyDrum:
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_NOISE
.loop1
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj ANIM_OBJ_BELLY_DRUM_HAND,   8, 0,  13, 0, $0
	anim_obj ANIM_OBJ_BELLY_DRUM_NOTE,   8, 0,  11, 4, $f8
	anim_wait 24
	anim_loop 2, .loop1
.loop2
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj ANIM_OBJ_BELLY_DRUM_HAND,   8, 0,  13, 0, $0
	anim_obj ANIM_OBJ_BELLY_DRUM_NOTE,   8, 0,  11, 4, $f8
	anim_wait 12
	anim_loop 2, .loop2
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj ANIM_OBJ_BELLY_DRUM_HAND,   8, 0,  13, 0, $0
	anim_obj ANIM_OBJ_BELLY_DRUM_NOTE,   8, 0,  11, 4, $f8
	anim_wait 24
.loop3
	anim_sound 0, 0, SFX_BELLY_DRUM
	anim_obj ANIM_OBJ_BELLY_DRUM_HAND,   8, 0,  13, 0, $0
	anim_obj ANIM_OBJ_BELLY_DRUM_NOTE,   8, 0,  11, 4, $f8
	anim_wait 12
	anim_loop 4, .loop3
	anim_ret

BattleAnim_GunkShot:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_PURPLE
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_setobjpal PAL_BATTLE_OB_BROWN, PAL_BTLCUSTOM_PURPLE
	anim_2gfx ANIM_GFX_WIND_BG, ANIM_GFX_POISON
	anim_bgeffect ANIM_BG_BLACK_HUES, $0, $8, $0
	anim_obj ANIM_OBJ_GUNK_SHOT, 48, 96, $0
	anim_call BattleAnimSub_AgilityMinor
.loop
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_GUNK_SHOT_BUBBLES, 48, 88, $5c
	anim_wait 2
	anim_obj ANIM_OBJ_GUNK_SHOT_BUBBLES, 48, 88, $e8
	anim_wait 2
	anim_obj ANIM_OBJ_GUNK_SHOT_BUBBLES, 48, 88, $d0
	anim_wait 2
	anim_obj ANIM_OBJ_GUNK_SHOT_BUBBLES, 48, 88, $50
	anim_wait 2
	anim_loop 6, .loop
	anim_wait 16
	anim_clearobjs
	anim_bgp $1b
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PSYCHO_BOOST_2
	anim_setobjpal PAL_BATTLE_OB_BROWN, PAL_BTLCUSTOM_PSYCHO_BOOST_2
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $4, $10
.loop2
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
	anim_loop 4, .loop2
	anim_wait 4
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $5c
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $e8
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $d0
	anim_obj ANIM_OBJ_INK_SPLASH, 136, 56, $50
	anim_wait 32
	anim_ret

BattleAnim_Venoshock:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_1gfx ANIM_GFX_POISON
	anim_call BattleAnim_UserObj_1Row
	anim_bgeffect ANIM_BG_BLACK_HUES, $0, $8, $0
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj ANIM_OBJ_ACID, 64, 92, $10
	anim_wait 36
	anim_sound 0, 1, SFX_THUNDER
	anim_wait 8
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PSYCHO_BOOST_2
	anim_bgp $1b
.loop
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_SLUDGE, 132, 72, $0
	anim_wait 8
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_SLUDGE, 116, 72, $0
	anim_wait 8
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_SLUDGE, 148, 72, $0
	anim_wait 8
	anim_loop 4, .loop
	anim_wait 24
	anim_call BattleAnim_ShowMon_1
	anim_ret

BattleAnim_SludgeBomb:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_2gfx ANIM_GFX_EGG, ANIM_GFX_POISON
	anim_bgeffect ANIM_BG_BLACK_HUES, $0, $8, $0
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj ANIM_OBJ_SLUDGE_BOMB,   8, 0,  11, 4, $10
	anim_wait 36
	anim_call BattleAnimSub_Sludge
	anim_wait 48
	anim_ret

BattleAnim_MudSlap:
	anim_1gfx ANIM_GFX_SAND
	anim_obp0 $fc
	anim_call BattleAnimSub_SandOrMud
	anim_ret

BattleAnim_Octazooka:
	anim_3gfx ANIM_GFX_EGG, ANIM_GFX_SMOKE_PUFF, ANIM_GFX_POISON
	anim_obp0 $f0
	anim_sound 6, 2, SFX_TACKLE
	anim_obj ANIM_OBJ_OCTAZOOKA, 64, 92, $4
	anim_wait 2
	anim_obj ANIM_OBJ_OCTAZOOKA_SMOKE, 64, 92, $0
	anim_wait 2
	anim_obj ANIM_OBJ_OCTAZOOKA_SMOKE, 80, 84, $0
	anim_wait 2
	anim_obj ANIM_OBJ_OCTAZOOKA_SMOKE, 96, 76, $0
	anim_wait 2
	anim_obj ANIM_OBJ_OCTAZOOKA_SMOKE, 112, 68, $0
	anim_wait 2
	anim_obj ANIM_OBJ_OCTAZOOKA_SMOKE, 126, 60, $0
	anim_wait 4
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_bgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING, $0, BG_EFFECT_TARGET, $40
	anim_sound 0, 0, SFX_AEROBLAST
	anim_obj ANIM_OBJ_INK_SPLASH, 140, 56, $5c
	anim_obj ANIM_OBJ_INK_SPLASH, 140, 56, $e8
	anim_obj ANIM_OBJ_INK_SPLASH, 140, 56, $d0
	anim_obj ANIM_OBJ_INK_SPLASH, 140, 56, $50
	anim_wait 40
	anim_ret

BattleAnim_Spikes:
	anim_1gfx ANIM_GFX_MISC
	anim_sound 6, 2, SFX_MENU
	anim_obj ANIM_OBJ_SPIKES,   6, 0,  11, 0, $20
	anim_wait 8
	anim_sound 6, 2, SFX_MENU
	anim_obj ANIM_OBJ_SPIKES,   6, 0,  11, 0, $30
	anim_wait 8
	anim_sound 6, 2, SFX_MENU
	anim_obj ANIM_OBJ_SPIKES,   6, 0,  11, 0, $28
	anim_wait 64
	anim_ret

BattleAnim_ToxicSpikes:
	anim_2gfx ANIM_GFX_MISC, ANIM_GFX_POISON
	anim_sound 6, 2, SFX_MENU
	anim_obj ANIM_OBJ_SPIKES, 48, 88, $20
	anim_wait 8
	anim_sound 6, 2, SFX_MENU
	anim_obj ANIM_OBJ_SPIKES, 48, 88, $30
	anim_wait 8
	anim_sound 6, 2, SFX_MENU
	anim_obj ANIM_OBJ_SPIKES, 48, 88, $28
	anim_wait 40
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_PURPLE
	anim_jump BattleAnimSub_SludgeShort

BattleAnim_ZapCannon:
	anim_2gfx ANIM_GFX_LIGHTNING, ANIM_GFX_EXPLOSION
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_LIGHT_SCREEN
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_ZAP_CANNON
	anim_bgp $1b
	anim_sound 6, 2, SFX_ZAP_CANNON
	anim_obj ANIM_OBJ_ZAP_CANNON,   8, 0,  11, 4, $2
	anim_wait 40
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $2, $0
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 1, SFX_THUNDERBOLT
	anim_obj ANIM_OBJ_THUNDERBOLT_BALL, 132, 52, $2
	anim_wait 16
	anim_obj ANIM_OBJ_SPARKS_CIRCLE_BIG, 132, 52, $0
	anim_wait 80
	anim_ret

BattleAnim_FlashCannon:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_BRIGHT
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BRIGHT
	anim_4gfx ANIM_GFX_BIG_GLOW_CLEAR, ANIM_GFX_GLOW, ANIM_GFX_CHARGE, ANIM_GFX_SPEED
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_BIG_GLOW_CLEAR, 48, 96, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_clearobjs
	anim_wait 1
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $3, $0
	anim_obj ANIM_OBJ_PULSING_SPARKLE, 64, 80, $0
	anim_obj ANIM_OBJ_FLASH_CANNON_CHARGE, 48, 96, $00
	anim_wait 6
	anim_obj ANIM_OBJ_FLASH_CANNON_CHARGE, 48, 96, $30
	anim_obj ANIM_OBJ_PULSING_SPARKLE, 32, 114, $0
	anim_wait 6
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_FLASH_CANNON_CHARGE, 48, 96, $0c
	anim_obj ANIM_OBJ_PULSING_SPARKLE, 64, 114, $0
	anim_wait 6
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_FLASH_CANNON_CHARGE, 48, 96, $24
	anim_obj ANIM_OBJ_PULSING_SPARKLE, 32, 80, $0
	anim_wait 6
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_FLASH_CANNON_CHARGE, 48, 96, $18
	anim_obj ANIM_OBJ_PULSING_SPARKLE, 48, 96, $0
	anim_wait 6
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_SLOW_GROWING_GLOW, 48, 96, $0
	anim_obj ANIM_OBJ_FLASH_CANNON_CHARGE, 48, 96, $00
	anim_wait 6
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_FLASH_CANNON_CHARGE, 48, 96, $30
	anim_wait 6
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_FLASH_CANNON_CHARGE, 48, 96, $0c
	anim_wait 6
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_FLASH_CANNON_CHARGE, 48, 96, $24
	anim_wait 6
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_FLASH_CANNON_CHARGE, 48, 96, $18
	anim_wait 6
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_wait 6
	anim_sound 0, 0, SFX_UNKNOWN_66
	anim_wait 32
	anim_clearobjs
	anim_wait 1
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_SIGNAL_BEAM_RED
	anim_sound 0, 0, SFX_GIGA_DRAIN
	anim_obj ANIM_OBJ_FLASH_CANNON, 48, 96, $4
	anim_wait 24
	anim_sound 0, 0, SFX_AEROBLAST
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_obj ANIM_OBJ_SHRINKING_GLOW, 140, 44, $0
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_WHITE, 136, 48, $0
	anim_wait 1
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_RED, 136, 48, $28
	anim_wait 1
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_WHITE, 136, 48, $30
	anim_wait 1
	anim_sound 0, 0, SFX_METRONOME
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_RED, 136, 48, $38
	anim_wait 1
	anim_obj ANIM_OBJ_SHRINKING_GLOW, 124, 60, $0
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_WHITE, 136, 48, $20
	anim_wait 1
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_RED, 136, 48, $8
	anim_wait 1
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_WHITE, 136, 48, $18
	anim_wait 1
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_RED, 136, 48, $4
	anim_wait 1
	anim_obj ANIM_OBJ_SHRINKING_GLOW, 140, 60, $0
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_WHITE, 136, 48, $2b
	anim_wait 1
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_RED, 136, 48, $14
	anim_wait 1
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_WHITE, 136, 48, $3b
	anim_wait 1
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_RED, 136, 48, $24
	anim_wait 1
	anim_obj ANIM_OBJ_SHRINKING_GLOW, 124, 44, $0
	anim_obj ANIM_OBJ_FLASH_CANNON_SPARKS_WHITE, 136, 48, $b
	anim_wait 4
	anim_obj ANIM_OBJ_SHRINKING_GLOW, 132, 52, $0
	anim_wait 32
	anim_ret

BattleAnim_AuraSphere:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_BUBBLE
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BUBBLE
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_BUBBLE
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_YELLOW
	anim_4gfx ANIM_GFX_VORTEX, ANIM_GFX_GLOW, ANIM_GFX_WIND_BG, ANIM_GFX_SWIRL
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_call BattleAnimSub_AgilityMinor
	anim_sound 0, 1, SFX_OUTRAGE
.loop
	anim_obj ANIM_OBJ_SWIRL_SHORT, 44, 96, $0
	anim_wait 8
	anim_loop 4, .loop
	anim_obj ANIM_OBJ_VORTEX, 44, 96, $0
	anim_wait 64
	anim_clearobjs
	anim_sound 0, 1, SFX_SLUDGE_BOMB
	anim_obj ANIM_OBJ_SHRINKING_GLOW, 44, 96, $4
	anim_wait 10
	anim_3gfx ANIM_GFX_BIG_GLOW_CLEAR, ANIM_GFX_AURA_SPHERE, ANIM_GFX_WIND_BG
	anim_sound 0, 1, SFX_MEGA_PUNCH
.loop2
	anim_obj ANIM_OBJ_AURA_SPHERE, 64, 88, $6
	anim_wait 12
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $08, $2, $0
	anim_sound 0, 1, SFX_AEROBLAST
	anim_obj ANIM_OBJ_BIG_GLOW_CLEAR, 136, 48, $0
	anim_wait 8
	anim_clearobjs
	anim_wait 32
	anim_ret

BattleAnim_Foresight:
	anim_1gfx ANIM_GFX_SHINE
	anim_call BattleAnim_UserObj_1Row
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 1, SFX_FORESIGHT
	anim_obj ANIM_OBJ_FORESIGHT, -16, 4,   5, 0, $0
	anim_wait 24
	anim_bgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING, $0, $0, $40
	anim_wait 64
	anim_incbgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING
	anim_call BattleAnim_ShowMon_1
	anim_wait 8
	anim_ret

BattleAnim_DestinyBond:
	anim_1gfx ANIM_GFX_ANGELS
	anim_bgp $1b
	anim_obp0 $0
	anim_jumpif $1, .fainted
	anim_sound 6, 2, SFX_WHIRLWIND
	anim_obj ANIM_OBJ_DESTINY_BOND,   5, 4,  15, 0, $2
	anim_wait 128
	anim_bgp $e4
	anim_ret

.fainted
	anim_obj ANIM_OBJ_DESTINY_BOND, -16, 4,   9, 4, $0
	anim_sound 0, 1, SFX_KINESIS
	anim_bgeffect ANIM_BG_RETURN_MON, $0, $0, $0
	anim_wait 32
	anim_bgp $e4
	anim_ret

BattleAnim_PerishSong:
	anim_1gfx ANIM_GFX_NOISE
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_sound 0, 2, SFX_PERISH_SONG
	anim_obj ANIM_OBJ_PERISH_SONG,  11, 0,   0, 0, $0
	anim_obj ANIM_OBJ_PERISH_SONG,  11, 0,   0, 0, $8
	anim_obj ANIM_OBJ_PERISH_SONG,  11, 0,   0, 0, $10
	anim_obj ANIM_OBJ_PERISH_SONG,  11, 0,   0, 0, $18
	anim_obj ANIM_OBJ_PERISH_SONG,  11, 0,   0, 0, $20
	anim_obj ANIM_OBJ_PERISH_SONG,  11, 0,   0, 0, $28
	anim_obj ANIM_OBJ_PERISH_SONG,  11, 0,   0, 0, $30
	anim_obj ANIM_OBJ_PERISH_SONG,  11, 0,   0, 0, $38
	anim_wait 112
	anim_ret

BattleAnim_IcyWind:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_ICE
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_ICE
	anim_2gfx ANIM_GFX_SPEED, ANIM_GFX_HAZE
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_battlergfx_1row
	anim_sound 0, 0, SFX_PSYCHIC
.loop
	anim_obj ANIM_OBJ_SHOOTING_MIST, 64, 80, $4
	anim_wait 4
	anim_obj ANIM_OBJ_SHOOTING_SPARKLE, 64, 88, $4
	anim_wait 4
	anim_obj ANIM_OBJ_SHOOTING_MIST, 64, 96, $4
	anim_wait 4
	anim_obj ANIM_OBJ_SHOOTING_SPARKLE, 64, 80, $4
	anim_wait 4
	anim_obj ANIM_OBJ_SHOOTING_MIST, 64, 88, $4
	anim_wait 4
	anim_obj ANIM_OBJ_SHOOTING_SPARKLE, 64, 96, $4
	anim_wait 4
	anim_loop 2, .loop
	anim_wait 16
	anim_bgeffect ANIM_BG_BATTLEROBJ_2ROW, $0, BG_EFFECT_USER, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_NIGHT_SHADE, $0, BG_EFFECT_TARGET, $8
	anim_wait 64
	anim_incbgeffect ANIM_BG_NIGHT_SHADE
	anim_bgeffect ANIM_BG_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_incobj 7
	anim_wait 1
	anim_ret

BattleAnim_PowerWhip:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_GREEN
	anim_2gfx ANIM_GFX_BIG_WHIP, ANIM_GFX_HIT
	anim_sound 0, 0, SFX_CUT
	anim_obj ANIM_OBJ_PUNISHMENT, 96, 245, $0c
	anim_wait 2
	anim_obj ANIM_OBJ_PUNISHMENT, 96, 245, $0c
	anim_wait 12
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $6, $08
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_Y, $28, $2, $0
	anim_sound 0, 1, SFX_THUNDER
	anim_obj ANIM_OBJ_HIT_BIG, 136, 48, $0
	anim_wait 32
	anim_ret

BattleAnim_Outrage:
	anim_3gfx ANIM_GFX_SWIRL, ANIM_GFX_VORTEX, ANIM_GFX_FIRE
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_OUTRAGE
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_OUTRAGE
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $8, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_Y, $88, $1, $8
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, BG_EFFECT_USER, $20
	anim_sound 0, 1, SFX_OUTRAGE
.loop
	anim_obj ANIM_OBJ_SWIRL_SHORT, 44, 96, $0
	anim_wait 8
	anim_loop 7, .loop
	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_obj ANIM_OBJ_VORTEX, 44, 96, $0
	anim_bgeffect ANIM_BG_CYCLE_BGPALS_INVERTED, $0, $4, $0
.loop2
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 96, $38
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 96, $10
	anim_wait 6
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 96, $2a
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 96, $4
	anim_wait 6
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 96, $18
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 96, $3b
	anim_wait 6
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 96, $1a
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 96, $0a
	anim_wait 6
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 96, $1e
	anim_obj ANIM_OBJ_RADIAL_FLAME, 44, 96, $30
	anim_wait 6
	anim_loop 2, .loop2
	anim_wait 16
	anim_ret

BattleAnim_Sandstorm:
	anim_call BattleAnimSub_Sandstorm
.loop
	anim_sound 0, 1, SFX_MENU
	anim_wait 8
	anim_loop 16, .loop
	anim_wait 8
	anim_ret

BattleAnim_Hail:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_ICE
	anim_1gfx ANIM_GFX_ICE
	anim_bgeffect ANIM_BG_WHITE_HUES, $0, $8, $0
.loop
	anim_call BattleAnimSub_Hail
	anim_loop 3, .loop
	anim_ret

BattleAnim_GigaDrain:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_ABSORB
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_2gfx ANIM_GFX_CHARGE, ANIM_GFX_SHINE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_FADE_MONS_TO_BLACK_REPEATING, $0, $0, $10
	anim_setvar $0
	anim_sound 6, 3, SFX_GIGA_DRAIN
.loop
	anim_obj ANIM_OBJ_ABSORB, 128, 48, $2
	anim_wait 3
	anim_obj ANIM_OBJ_ABSORB, 136, 64, $3
	anim_wait 4
	anim_obj ANIM_OBJ_ABSORB, 136, 32, $4
	anim_wait 3
	anim_incvar
	anim_jumpvar $d, .done
	anim_jumpvar $4, .spawn
	anim_jump .loop

.spawn
	anim_obj ANIM_OBJ_ABSORB_CENTER, 44, 88, $0
	anim_jump .loop

.done
	anim_wait 32
	anim_incbgeffect ANIM_BG_FADE_MONS_TO_BLACK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_wait 1
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
.loop2
	anim_sound 0, 0, SFX_METRONOME
	anim_obj ANIM_OBJ_GLIMMER, 24, 64, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER, 56, 104, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER, 24, 104, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER, 56, 64, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER, 40, 84, $0
	anim_wait 5
	anim_loop 2, .loop2
	anim_wait 32
	anim_ret

BattleAnim_Endure:
	anim_1gfx ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
.loop
	anim_call BattleAnimSub_Focus
	anim_loop 5, .loop
	anim_wait 8
	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_Charm:
	anim_1gfx ANIM_GFX_OBJECTS
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_WOBBLE_MON, $0, $1, $0
	anim_sound 0, 0, SFX_ATTRACT
	anim_obj ANIM_OBJ_HEART,   8, 0,  10, 0, $0
	anim_wait 32
	anim_incbgeffect ANIM_BG_WOBBLE_MON
	anim_call BattleAnim_ShowMon_0
	anim_wait 4
	anim_ret

BattleAnim_Bulldoze:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_SHAKE_MON_Y, $0, $11, $4
.loop
	anim_sound 0, 1, SFX_SPARK
	anim_wait 8
	anim_loop 6, .loop
	anim_incbgeffect ANIM_BG_SHAKE_MON_Y
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_clearobjs
	anim_wait 1
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_Y, $40, $3, $0
.loop2
	anim_sound 0, 1, SFX_SPARK
	anim_wait 4
	anim_loop 12, .loop2
	anim_incbgeffect ANIM_BG_SHAKE_SCREEN_Y
	anim_wait 16
	anim_ret

BattleAnim_Rollout:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 0, 0, SFX_SPARK
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_ROLLOUT, $60, $1, $1
	anim_bgeffect ANIM_BG_BODY_SLAM, $0, $1, $0
	anim_wait 4
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT_BIG, -15, 0,   5, 0, $0
	anim_wait 8
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_FalseSwipe:
	anim_2gfx ANIM_GFX_SHINE, ANIM_GFX_CUT
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 1, SFX_CUT
	anim_obj ANIM_OBJ_CUT_LONG_DOWN_LEFT, -13, 0,   5, 0, $0
	anim_wait 4
	anim_obj ANIM_OBJ_GLIMMER, -15, 0,   5, 0, $0
	anim_wait 32
	anim_ret

BattleAnim_Swagger:
	anim_2gfx ANIM_GFX_MISC, ANIM_GFX_WIND
.loop
	anim_sound 0, 0, SFX_MENU
	anim_obj ANIM_OBJ_SWAGGER,   9, 0,  11, 0, $44
	anim_wait 32
	anim_loop 2, .loop
	anim_wait 32
	anim_sound 0, 1, SFX_KINESIS_2
	anim_obj ANIM_OBJ_ANGER,  13, 0,   5, 0, $0
	anim_wait 40
	anim_ret

BattleAnim_ShellSmash:
	anim_3gfx ANIM_GFX_REFLECT, ANIM_GFX_HIT, ANIM_GFX_ROCKS
	anim_bgeffect ANIM_BG_RETURN_MON, $0, $1, $0
	anim_wait 6
	anim_sound 0, 0, SFX_SHINE
	anim_obj ANIM_OBJ_SHELL_SMASH_SHELL, 48, 106, $0
	anim_wait 16
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $58, $2, $0
	anim_sound 0, 0, SFX_OUTRAGE
	anim_wait 72
	anim_clearobjs
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_incbgeffect ANIM_BG_SHAKE_SCREEN_X
	anim_wait 1
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_bgeffect ANIM_BG_ENTER_MON, $0, $1, $0
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_SHELL_SMASH_HIT, 48, 106, $0
	anim_obj ANIM_OBJ_SHELL_SMASH_DEBRIS, 48, 106, $5c
	anim_obj ANIM_OBJ_SHELL_SMASH_DEBRIS, 48, 106, $e8
	anim_obj ANIM_OBJ_SHELL_SMASH_DEBRIS, 48, 106, $d0
	anim_obj ANIM_OBJ_SHELL_SMASH_DEBRIS, 48, 106, $50
	anim_wait 12
	anim_bgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING, $0, $1, $40
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_VoltSwitch:
	anim_3gfx ANIM_GFX_CHARGE, ANIM_GFX_VOLT_SWITCH, ANIM_GFX_LIGHTNING
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_YELLOW
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_battlergfx_2row
	anim_sound 0, 0, SFX_WARP_TO
	anim_call BattleAnimSub_EnergyOrb
	anim_wait 12
	anim_sound 0, 0, SFX_ZAP_CANNON
	anim_obj ANIM_OBJ_VOLT_SWITCH, 64, 92, $4
	anim_wait 2
	anim_obj ANIM_OBJ_VOLT_SWITCH_SPARKS, 64, 92, $5c
	anim_wait 2
	anim_obj ANIM_OBJ_VOLT_SWITCH_SPARKS, 76, 84, $d0
	anim_wait 2
	anim_obj ANIM_OBJ_VOLT_SWITCH_SPARKS, 108, 76, $e8
	anim_wait 2
	anim_obj ANIM_OBJ_VOLT_SWITCH_SPARKS, 112, 68, $50
	anim_wait 2
	anim_obj ANIM_OBJ_VOLT_SWITCH_SPARKS, 100, 60, $5c
	anim_wait 4
	anim_sound 0, 0, SFX_THUNDERSHOCK
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $10, $FF
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $1, $0
.loop
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
	anim_obj ANIM_OBJ_VOLT_SWITCH_SPARKS, 132, 56, $5c
	anim_wait 2
	anim_obj ANIM_OBJ_VOLT_SWITCH_SPARKS, 132, 56, $e8
	anim_wait 2
	anim_obj ANIM_OBJ_VOLT_SWITCH_SPARKS, 128, 56, $d0
	anim_wait 2
	anim_obj ANIM_OBJ_VOLT_SWITCH_SPARKS, 156, 56, $50
	anim_wait 2
	anim_loop 8, .loop
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 4
	anim_ret

BattleAnim_Spark:
	anim_2gfx ANIM_GFX_LIGHTNING, ANIM_GFX_EXPLOSION
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_ZAP_CANNON
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $3
	anim_obj ANIM_OBJ_THUNDER_WAVE, 48, 92, $0
	anim_wait 24
	anim_setobj $1, $3
	anim_wait 1
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_sound 0, 0, SFX_SPARK
	anim_wait 16
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 4
	anim_clearobjs
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 1
	anim_sound 0, 1, SFX_THUNDERSHOCK
	anim_obj ANIM_OBJ_THUNDERBOLT_BALL, -15, 0,   7, 0, $2
	anim_obj ANIM_OBJ_SPARKS_CIRCLE, -15, 0,   7, 0, $0
	anim_wait 32
	anim_ret

BattleAnim_WildCharge:
	anim_3gfx ANIM_GFX_CHARGE, ANIM_GFX_LIGHTNING, ANIM_GFX_EXPLOSION
	anim_battlergfx_1row
	anim_bgp $1b
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_SWORDS_DANCE
	anim_call BattleAnimSub_EnergyOrb
	anim_wait 12
	anim_sound 0, 0, SFX_ZAP_CANNON
	anim_obj ANIM_OBJ_THUNDER_WAVE, 48, 92, $0
	anim_wait 24
	anim_setobj $9, $3
	anim_wait 8
	anim_bgeffect ANIM_BG_BATTLEROBJ_2ROW, $0, $0, $0
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_sound 0, 0, SFX_SPARK
	anim_wait 6
	anim_sound 0, 0, SFX_SPARK
	anim_wait 6
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 4
	anim_clearobjs
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $6, $50
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 1
	anim_sound 0, 1, SFX_THUNDERSHOCK
	anim_obj ANIM_OBJ_THUNDERBOLT_BALL, 136, 56, $2
	anim_obj ANIM_OBJ_SPARKS_CIRCLE_BIG, 136, 56, $0
	anim_wait 32
	anim_ret

BattleAnim_BugBite:
	anim_2gfx ANIM_GFX_ROCKS, ANIM_GFX_HIT
	anim_call BattleAnim_UserObj_1Row
.loop
	anim_bgeffect ANIM_BG_VIBRATE_MON, $0, $0, $0
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 140, 44, $0
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $5c
	anim_wait 4
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 124, 60, $0
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $d0
	anim_wait 4
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 140, 60, $0
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $e8
	anim_wait 4
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_SMALL_YFIX, 124, 44, $0
	anim_obj ANIM_OBJ_ROCK_SMASH, 136, 56, $50
	anim_wait 4
	anim_loop 3, .loop
	anim_wait 32
	anim_call BattleAnim_ShowMon_1
	anim_ret

BattleAnim_SteelWing:
	anim_1gfx ANIM_GFX_REFLECT
	anim_obp0 $0
	anim_sound 0, 0, SFX_RAGE
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_call BattleAnim_ShowMon_0
	anim_1gfx ANIM_GFX_HIT
	anim_resetobp0
	anim_jump BattleAnimSub_WingAttack

BattleAnim_MeanLook:
	anim_1gfx ANIM_GFX_PSYCHIC
	anim_obp0 $e0
	anim_sound 0, 1, SFX_MEAN_LOOK
	anim_obj ANIM_OBJ_MEAN_LOOK, -14, 4,   4, 0, $0
	anim_wait 5
	anim_obj ANIM_OBJ_MEAN_LOOK,  14, 4,   8, 0, $0
	anim_wait 5
	anim_obj ANIM_OBJ_MEAN_LOOK, -14, 4,   8, 0, $0
	anim_wait 5
	anim_obj ANIM_OBJ_MEAN_LOOK,  14, 4,   4, 0, $0
	anim_wait 5
	anim_obj ANIM_OBJ_MEAN_LOOK, -16, 4,   6, 0, $0
	anim_wait 128
	anim_ret

BattleAnim_Attract:
	anim_1gfx ANIM_GFX_OBJECTS
.loop
	anim_sound 0, 0, SFX_ATTRACT
	anim_obj ANIM_OBJ_ATTRACT,   5, 4,  10, 0, $2
	anim_wait 8
	anim_loop 5, .loop
	anim_wait 128
	anim_wait 64
	anim_ret

BattleAnim_SleepTalk:
	anim_1gfx ANIM_GFX_STATUS
.loop
	anim_sound 0, 0, SFX_STRENGTH
	anim_obj ANIM_OBJ_ASLEEP,   8, 0,  10, 0, $0
	anim_wait 40
	anim_loop 2, .loop
	anim_wait 32
	anim_ret

BattleAnim_HealBell:
	anim_2gfx ANIM_GFX_MISC, ANIM_GFX_NOISE
	anim_obj ANIM_OBJ_HEAL_BELL,   9, 0,   7, 0, $0
	anim_wait 32
.loop
	anim_sound 0, 0, SFX_HEAL_BELL
	anim_obj ANIM_OBJ_HEAL_BELL_NOTE,   9, 0,   6, 4, $0
	anim_wait 8
	anim_sound 0, 0, SFX_HEAL_BELL
	anim_obj ANIM_OBJ_HEAL_BELL_NOTE,   9, 0,   6, 4, $1
	anim_wait 8
	anim_sound 0, 0, SFX_HEAL_BELL
	anim_obj ANIM_OBJ_HEAL_BELL_NOTE,   9, 0,   6, 4, $2
	anim_wait 8
	anim_sound 0, 0, SFX_HEAL_BELL
	anim_obj ANIM_OBJ_HEAL_BELL_NOTE,   9, 0,   6, 4, $0
	anim_wait 8
	anim_sound 0, 0, SFX_HEAL_BELL
	anim_obj ANIM_OBJ_HEAL_BELL_NOTE,   9, 0,   6, 4, $2
	anim_wait 8
	anim_loop 4, .loop
	anim_wait 64
	anim_ret

BattleAnim_Return:
	anim_1gfx ANIM_GFX_HIT
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_BOUNCE_DOWN, $0, $1, $0
	anim_sound 0, 0, SFX_RETURN
	anim_wait 64
	anim_incbgeffect ANIM_BG_BOUNCE_DOWN
	anim_wait 32
	anim_bgeffect ANIM_BG_BODY_SLAM, $0, $1, $0
	anim_wait 4
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_BIG, -15, 0,   5, 0, $0
	anim_wait 8
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_Psystrike:
	anim_4gfx ANIM_GFX_PSYSTRIKE, ANIM_GFX_CHARGE, ANIM_GFX_GLOW, ANIM_GFX_SPEED
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_TRI_COLOR
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $40, $1, $0
	anim_bgeffect ANIM_BG_CYCLE_BGPALS_INVERTED, $0, $6, $0
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_sound 0, 0, SFX_BIND
	anim_obj ANIM_OBJ_PSYSTRIKE_BALL, 64, 88, $12
	anim_wait 32
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $6, $1
	anim_sound 0, 1, SFX_PSYCHIC
	anim_bgeffect ANIM_BG_PSYCHIC, $0, $0, $0
.loop
	anim_obj ANIM_OBJ_ENERGY_ORB, 136, 48, $38
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 136, 48, $20
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 136, 48, $8
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 136, 48, $10
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 136, 48, $28
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 136, 48, $0
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 136, 48, $18
	anim_wait 4
	anim_obj ANIM_OBJ_ENERGY_ORB, 136, 48, $30
	anim_wait 4
	anim_loop 2, .loop
	anim_wait 1
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $6, $ff
	anim_sound 0, 1, SFX_GRAVITY
.loop2
	anim_obj ANIM_OBJ_SHRINKING_GLOW_YFIX, 148, 36, $0
	anim_obj ANIM_OBJ_FOCUS, 132, 68, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 124, 68, $6
	anim_wait 2
	anim_obj ANIM_OBJ_SHRINKING_GLOW_YFIX, 116, 48, $0
	anim_obj ANIM_OBJ_FOCUS, 140, 68, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 116, 68, $8
	anim_wait 2
	anim_obj ANIM_OBJ_SHRINKING_GLOW_YFIX, 132, 60, $0
	anim_obj ANIM_OBJ_FOCUS, 148, 68, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS, 108, 68, $8
	anim_wait 2
	anim_obj ANIM_OBJ_SHRINKING_GLOW_YFIX, 124, 24, $0
	anim_obj ANIM_OBJ_FOCUS, 156, 68, $8
	anim_wait 2
	anim_obj ANIM_OBJ_SHRINKING_GLOW_YFIX, 144, 52, $0
	anim_wait 2
	anim_loop 3, .loop2
	anim_incbgeffect ANIM_BG_PSYCHIC
	anim_wait 1
	anim_clearobjs
	anim_ret

BattleAnim_Safeguard:
	anim_1gfx ANIM_GFX_MISC
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_obj ANIM_OBJ_SAFEGUARD,  10, 0,  10, 0, $0
	anim_obj ANIM_OBJ_SAFEGUARD,  10, 0,  10, 0, $d
	anim_obj ANIM_OBJ_SAFEGUARD,  10, 0,  10, 0, $1a
	anim_obj ANIM_OBJ_SAFEGUARD,  10, 0,  10, 0, $27
	anim_obj ANIM_OBJ_SAFEGUARD,  10, 0,  10, 0, $34
	anim_sound 0, 0, SFX_PROTECT
	anim_wait 96
	anim_ret

BattleAnim_PainSplit:
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_OBJECTS
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_BODY_SLAM, $0, $1, $0
	anim_wait 4
	anim_sound 0, 1, SFX_TACKLE
	anim_obj ANIM_OBJ_HIT,  14, 0,   6, 0, $0
	anim_obj ANIM_OBJ_HIT,   9, 4,  12, 0, $0
	anim_wait 8
	anim_call BattleAnim_ShowMon_0
	anim_wait 1
	anim_ret

BattleAnim_SacredFire:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_FIRE
	anim_1gfx ANIM_GFX_FIRE
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
.loop
	anim_sound 0, 0, SFX_EMBER
	anim_obj ANIM_OBJ_SACRED_FIRE,   6, 0,  13, 0, $0
	anim_wait 8
	anim_loop 8, .loop
	anim_wait 96
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 4
	anim_sound 0, 1, SFX_EMBER
	anim_obj ANIM_OBJ_FIRE_BLAST, -15, 0,   6, 0, $1
	anim_obj ANIM_OBJ_FIRE_BLAST, -15, 0,   6, 0, $4
	anim_obj ANIM_OBJ_FIRE_BLAST, -15, 0,   6, 0, $5
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 4
	anim_incobj 9
	anim_wait 8
	anim_ret

BattleAnim_FlareBlitz:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_FIRE
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_FIRE
	anim_2gfx ANIM_GFX_FIRE, ANIM_GFX_HIT
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
.loop
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_FLARE_BLITZ, 44, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 36, 108, $6
	anim_wait 2
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_FLARE_BLITZ, 52, 108, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 28, 108, $8
	anim_wait 2
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_FLARE_BLITZ, 60, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 20, 108, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 68, 108, $8
	anim_wait 2
	anim_loop 3, .loop
	anim_wait 16
	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_wait 1
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $0, $0
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 1
	anim_clearobjs
	anim_bgeffect ANIM_BG_CYCLE_BGPALS_INVERTED, $0, $4, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $30, $2, $0
	anim_sound 0, 0, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 4
	anim_setobjpal PAL_BATTLE_BG_TARGET, PAL_BTLCUSTOM_FIRE
	anim_sound 0, 0, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $0
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $28
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $30
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $38
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $20
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $8
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $18
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $4
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $2b
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $14
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $3b
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $24
	anim_wait 1
	anim_obj ANIM_OBJ_RADIAL_FLAME, 136, 56, $b
	anim_sound 0, 0, SFX_KARATE_CHOP
	anim_wait 2
	anim_sound 0, 0, SFX_KARATE_CHOP
	anim_wait 32
	anim_wait 1
	anim_clearobjs
	anim_ret

BattleAnim_Magnitude:
	anim_1gfx ANIM_GFX_ROCKS
.loop
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $e, $4, $0
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj ANIM_OBJ_SMALL_ROCK,  16, 0,   8, 0, $40
	anim_wait 2
	anim_obj ANIM_OBJ_SMALL_ROCK,  15, 0,   8, 4, $30
	anim_wait 2
	anim_obj ANIM_OBJ_SMALL_ROCK, -13, 0,   8, 4, $30
	anim_wait 2
	anim_obj ANIM_OBJ_SMALL_ROCK, -14, 0,   8, 0, $40
	anim_wait 2
	anim_obj ANIM_OBJ_SMALL_ROCK, -15, 0,   8, 4, $30
	anim_wait 2
	anim_jumpuntil .loop
	anim_wait 96
	anim_ret

BattleAnim_Dynamicpunch:
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_EXPLOSION
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_call BattleAnimSub_PunchShake
	anim_wait 16
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $12
	anim_call BattleAnimSub_Explosion2
	anim_wait 16
	anim_bgp $e4
	anim_ret

BattleAnim_Megahorn:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_2gfx ANIM_GFX_HORN, ANIM_GFX_HIT
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $30, $2, $0
	anim_wait 48
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, BG_EFFECT_TARGET, $0
	anim_wait 1
	anim_bgeffect ANIM_BG_TACKLE, $0, BG_EFFECT_USER, $0
	anim_sound 0, 1, SFX_HORN_ATTACK
	anim_obj ANIM_OBJ_HORN, 72, 80, $1
	anim_wait 11
	anim_bgeffect ANIM_BG_SHOW_MON, $0, BG_EFFECT_TARGET, $0
	anim_incobj 1
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $10
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $30, $3, $0
.loop
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 16
	anim_loop 3, .loop
	anim_ret

BattleAnim_Dragonbreath:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_DRAGONBREATH
	anim_1gfx ANIM_GFX_FIRE
	anim_sound 6, 2, SFX_EMBER
.loop
	anim_obj ANIM_OBJ_DRAGONBREATH, 64, 92, $4
	anim_wait 4
	anim_loop 10, .loop
	anim_wait 64
	anim_ret

BattleAnim_BatonPass:
	anim_1gfx ANIM_GFX_MISC
	anim_obj ANIM_OBJ_BATON_PASS,   5, 4,  13, 0, $20
	anim_sound 0, 0, SFX_BATON_PASS
	anim_call BattleAnim_ReturnMon.anim
	anim_wait 64
	anim_ret

BattleAnim_Encore:
	anim_1gfx ANIM_GFX_OBJECTS
	anim_obj ANIM_OBJ_ENCORE_HAND,   8, 0,  10, 0, $90
	anim_obj ANIM_OBJ_ENCORE_HAND,   8, 0,  10, 0, $10
	anim_sound 0, 0, SFX_ENCORE
	anim_wait 16
	anim_obj ANIM_OBJ_ENCORE_STAR,   8, 0,   9, 0, $2c
	anim_wait 32
	anim_obj ANIM_OBJ_ENCORE_STAR,   8, 0,   9, 0, $34
	anim_wait 16
	anim_ret

BattleAnim_Pursuit:
	anim_1gfx ANIM_GFX_HIT
	anim_jumpif $1, .pursued
.hit
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
	anim_wait 16
	anim_ret

.pursued
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $0, $0
	anim_wait 4
	anim_call BattleAnim_UserObj_1Row
	anim_obj ANIM_OBJ_PURSUIT, -16, 4,   8, 0, $0
	anim_wait 64
	anim_obj ANIM_OBJ_PURSUIT, -16, 4,   8, 0, $1
	anim_sound 0, 1, SFX_BALL_POOF
	anim_bgeffect ANIM_BG_ENTER_MON, $0, $0, $0
	anim_wait 64
	anim_incobj 3
	anim_wait 16
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT_BIG_YFIX,  15, 0,   7, 0, $0
	anim_bgeffect ANIM_BG_PURSUIT, $0, $0, $0
	anim_wait 16
	anim_call BattleAnim_ShowMon_1
	anim_wait 1
	anim_ret

BattleAnim_RapidSpin:
	anim_2gfx ANIM_GFX_WIND, ANIM_GFX_HIT
	anim_obp0 $e4
.loop
	anim_sound 0, 0, SFX_MENU
	anim_obj ANIM_OBJ_RAPID_SPIN,   5, 4,  14, 0, $0
	anim_wait 2
	anim_loop 5, .loop
	anim_wait 24
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_BODY_SLAM, $0, $1, $0
	anim_wait 4
	anim_resetobp0
	anim_sound 0, 1, SFX_MEGA_KICK
	anim_obj ANIM_OBJ_HIT, -15, 0,   5, 0, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 4
	anim_incobj 6
	anim_wait 1
	anim_ret

BattleAnim_IronTail:
	anim_1gfx ANIM_GFX_REFLECT
	anim_obp0 $0
	anim_sound 0, 0, SFX_RAGE
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_wait 4
	anim_1gfx ANIM_GFX_HIT
	anim_resetobp0
	anim_bgeffect ANIM_BG_WOBBLE_MON, $0, $1, $0
	anim_wait 16
	anim_sound 0, 1, SFX_MEGA_KICK
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   6, 0, $0
	anim_wait 16
	anim_incbgeffect ANIM_BG_WOBBLE_MON
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_MetalClaw:
	anim_1gfx ANIM_GFX_REFLECT
	anim_obp0 $0
	anim_sound 0, 0, SFX_RAGE
	anim_call BattleAnim_TargetObj_1Row
	anim_call BattleAnimSub_Metallic
	anim_call BattleAnim_ShowMon_0
	anim_1gfx ANIM_GFX_CUT
	anim_resetobp0
	anim_jump BattleAnim_Scratch.hit

BattleAnim_DragonClaw:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_GRAY
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_DRAGONBREATH
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_DRAGONBREATH
	anim_3gfx ANIM_GFX_CUT, ANIM_GFX_FIRE, ANIM_GFX_TEAR
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT, $0, $1, $40
	anim_sound 0, 1, SFX_MEGA_PUNCH
.loop
	anim_obj ANIM_OBJ_FLARE_BLITZ, 44, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 36, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 52, 108, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 28, 108, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 60, 108, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 20, 108, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FLARE_BLITZ, 68, 108, $8
	anim_wait 2
	anim_loop 2, .loop
	anim_wait 16
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT
	anim_wait 1
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_CUT
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, 144, 48, $0
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, 140, 44, $0
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, 136, 40, $0
	anim_wait 8
	anim_obj ANIM_OBJ_CLAW_TEAR, 144, 48, $0
	anim_wait 32
	anim_ret

BattleAnim_ShadowClaw:
	anim_2gfx ANIM_GFX_CUT, ANIM_GFX_SPEED
	anim_obp0 $ef
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
	anim_bgeffect ANIM_BG_BLACK_HUES, $0, $8, $0
	anim_sound 0, 1, SFX_CUT
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, 144, 48, $0
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, 140, 44, $0
	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, 136, 40, $0
	anim_wait 4
	anim_obj ANIM_OBJ_RED_STAR, 136, 56, $5c
	anim_obj ANIM_OBJ_RED_STAR, 136, 56, $e8
	anim_obj ANIM_OBJ_RED_STAR, 136, 56, $d0
	anim_obj ANIM_OBJ_RED_STAR, 136, 56, $50
	anim_wait 32
	anim_ret

BattleAnim_HealingLight:
	anim_jumpif $1, BattleAnim_Moonlight
	anim_jumpif $2, BattleAnim_Synthesis
BattleAnim_MorningSun: ; reassigned
	anim_1gfx ANIM_GFX_SHINE
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 0, SFX_MORNING_SUN
.loop
	anim_obj ANIM_OBJ_MORNING_SUN,   2, 0,   6, 0, $88
	anim_wait 6
	anim_loop 5, .loop
	anim_wait 32
	anim_jumpif $0, .zero
	anim_call BattleAnimSub_Glimmer
	anim_ret

.zero
	anim_call BattleAnimSub_Glimmer2
	anim_ret

BattleAnim_Moonlight: ; reassigned
	anim_1gfx ANIM_GFX_SHINE
	anim_bgp $1b
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_obj ANIM_OBJ_MOONLIGHT,   0, 0,   5, 0, $0
	anim_obj ANIM_OBJ_MOONLIGHT,   2, 0,   7, 0, $0
	anim_obj ANIM_OBJ_MOONLIGHT,   4, 0,   9, 0, $0
	anim_obj ANIM_OBJ_MOONLIGHT,   6, 0,  11, 0, $0
	anim_obj ANIM_OBJ_MOONLIGHT,   8, 0,  13, 0, $0
	anim_wait 1
	anim_sound 0, 0, SFX_MOONLIGHT
	anim_wait 63
	anim_jumpif $3, .three
	anim_call BattleAnimSub_Glimmer
	anim_bgp $e4
	anim_ret

.three
	anim_call BattleAnimSub_Glimmer2
	anim_bgp $e4
	anim_ret

BattleAnim_Synthesis: ; reassigned
	anim_1gfx ANIM_GFX_SHINE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
	anim_sound 0, 0, SFX_OUTRAGE
	anim_wait 72
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_jumpif $1, .one
	anim_call BattleAnimSub_Glimmer
	anim_ret

.one
	anim_call BattleAnimSub_Glimmer2
	anim_ret

BattleAnimSub_Focus:
	anim_sound 0, 0, SFX_SWORDS_DANCE
	anim_obj ANIM_OBJ_FOCUS,   5, 4,  13, 4, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS,   4, 4,  13, 4, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS,   6, 4,  13, 4, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS,   3, 4,  13, 4, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS,   7, 4,  13, 4, $6
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS,   2, 4,  13, 4, $8
	anim_wait 2
	anim_obj ANIM_OBJ_FOCUS,   8, 4,  13, 4, $8
	anim_wait 2
	anim_ret

BattleAnimSub_QuickAttack:
	anim_obj ANIM_OBJ_SPEED_LINE, 24, 88, $2
	anim_obj ANIM_OBJ_SPEED_LINE, 32, 88, $1
	anim_obj ANIM_OBJ_SPEED_LINE, 40, 88, $0
	anim_obj ANIM_OBJ_SPEED_LINE, 48, 88, $80
	anim_obj ANIM_OBJ_SPEED_LINE, 56, 88, $81
	anim_obj ANIM_OBJ_SPEED_LINE, 64, 88, $82
	anim_ret

BattleAnimSub_Agility:
	anim_obj ANIM_OBJ_AGILITY, 8, 24, $10
	anim_obj ANIM_OBJ_AGILITY, 8, 48, $2
	anim_obj ANIM_OBJ_AGILITY, 8, 88, $8
	anim_wait 4
	anim_obj ANIM_OBJ_AGILITY, 8, 32, $6
	anim_obj ANIM_OBJ_AGILITY, 8, 56, $c
	anim_obj ANIM_OBJ_AGILITY, 8, 80, $4
	anim_obj ANIM_OBJ_AGILITY, 8, 104, $e
	anim_ret

BattleAnimSub_AgilityMinor:
	anim_obj ANIM_OBJ_AGILITY, 8, 24, $10
	anim_obj ANIM_OBJ_AGILITY, 8, 48, $2
	anim_wait 4
	anim_obj ANIM_OBJ_AGILITY, 8, 56, $c
	anim_obj ANIM_OBJ_AGILITY, 8, 80, $4
	anim_obj ANIM_OBJ_AGILITY, 8, 104, $e
	anim_ret

BattleAnimSub_EnergyOrb:
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
	anim_ret

BattleAnimSub_Glimmer:
	anim_sound 0, 0, SFX_METRONOME
	anim_obj ANIM_OBJ_GLIMMER,   5, 4,   8, 0, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER,   3, 0,  12, 0, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER,   7, 0,  13, 0, $0
	anim_wait 21
	anim_ret

BattleAnimSub_Glimmer2:
	anim_sound 0, 0, SFX_METRONOME
.loop
	anim_obj ANIM_OBJ_GLIMMER,   3, 0,   8, 0, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER,   7, 0,  13, 0, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER,   3, 0,  13, 0, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER,   7, 0,   8, 0, $0
	anim_wait 5
	anim_obj ANIM_OBJ_GLIMMER,   5, 0,  10, 4, $0
	anim_wait 5
	anim_loop 2, .loop
	anim_wait 16
	anim_ret

BattleAnim_Crunch:
	anim_2gfx ANIM_GFX_CUT, ANIM_GFX_HIT
	anim_bgp $1b
	anim_obp0 $c0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $20, $2, $0
	anim_obj ANIM_OBJ_BITE, -15, 0,   7, 0, $a8
	anim_obj ANIM_OBJ_BITE, -15, 0,   7, 0, $28
	anim_wait 8
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -14, 0,   6, 0, $18
	anim_wait 16
	anim_sound 0, 1, SFX_BITE
	anim_obj ANIM_OBJ_HIT_BIG_YFIX,  16, 0,   8, 0, $18
	anim_wait 8
	anim_bgp $e4
	anim_ret

BattleAnim_HiddenPower:
	anim_1gfx ANIM_GFX_CHARGE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
	anim_obj ANIM_OBJ_HIDDEN_POWER,   5, 4,  11, 0, $0
	anim_obj ANIM_OBJ_HIDDEN_POWER,   5, 4,  11, 0, $8
	anim_obj ANIM_OBJ_HIDDEN_POWER,   5, 4,  11, 0, $10
	anim_obj ANIM_OBJ_HIDDEN_POWER,   5, 4,  11, 0, $18
	anim_obj ANIM_OBJ_HIDDEN_POWER,   5, 4,  11, 0, $20
	anim_obj ANIM_OBJ_HIDDEN_POWER,   5, 4,  11, 0, $28
	anim_obj ANIM_OBJ_HIDDEN_POWER,   5, 4,  11, 0, $30
	anim_obj ANIM_OBJ_HIDDEN_POWER,   5, 4,  11, 0, $38
.loop
	anim_sound 0, 0, SFX_SWORDS_DANCE
	anim_wait 8
	anim_loop 12, .loop
	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_wait 1
	anim_incobj 2
	anim_incobj 3
	anim_incobj 4
	anim_incobj 5
	anim_incobj 6
	anim_incobj 7
	anim_incobj 8
	anim_incobj 9
	anim_wait 16
	anim_1gfx ANIM_GFX_HIT
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   7, 0, $0
	anim_wait 32
	anim_ret

BattleAnim_CrossChop:
	anim_1gfx ANIM_GFX_CUT
	anim_sound 0, 1, SFX_CUT
	anim_obj ANIM_OBJ_CROSS_CHOP1, -13, 0,   5, 0, $0
	anim_obj ANIM_OBJ_CROSS_CHOP2,  15, 0,   9, 0, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $58, $2, $0
	anim_wait 92
	anim_sound 0, 1, SFX_VICEGRIP
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $10
	anim_wait 16
	anim_ret

BattleAnim_AquaJet:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_BUBBLE
	anim_4gfx ANIM_GFX_HIT_2, ANIM_GFX_AQUA_JET, ANIM_GFX_BUBBLE, ANIM_GFX_SPEED
	anim_sound 0, 0, SFX_MENU
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_call BattleAnimSub_QuickAttack
	anim_wait 6
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BUBBLE
	anim_sound 0, 1, SFX_SURF
	anim_wait 1
	anim_obj ANIM_OBJ_AQUA_JET, 72, 89, $0
	anim_obj ANIM_OBJ_AQUA_JET_BUBBLE, 72, 89, $d0
	anim_obj ANIM_OBJ_AQUA_JET_BUBBLE, 72, 89, $50
	anim_wait 6
	anim_obj ANIM_OBJ_AQUA_JET, 92, 78, $0
	anim_obj ANIM_OBJ_AQUA_JET_BUBBLE, 92, 78, $d0
	anim_obj ANIM_OBJ_AQUA_JET_BUBBLE, 92, 78, $50
	anim_wait 6
	anim_obj ANIM_OBJ_AQUA_JET, 112, 67, $0
	anim_obj ANIM_OBJ_AQUA_JET_BUBBLE, 112, 67, $d0
	anim_obj ANIM_OBJ_AQUA_JET_BUBBLE, 112, 67, $50
	anim_wait 6
	anim_obj ANIM_OBJ_AQUA_JET, 132, 56, $0
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 56, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 56, $50
	anim_wait 3
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 3
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 40, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 40, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 40, $50
	anim_wait 3
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 32, $0
	anim_wait 3
	anim_sound 0, 1, SFX_WATER_GUN
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 24, $0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 24, $d0
	anim_obj ANIM_OBJ_BUBBLE_SPLASH, 140, 24, $50
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 16
	anim_ret

BattleAnim_RainDance:
	anim_1gfx ANIM_GFX_WATER
	anim_bgp $f8
	anim_obp0 $7c
	anim_sound 0, 1, SFX_RAIN_DANCE
	anim_obj ANIM_OBJ_RAIN,  11, 0,   0, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_RAIN,  11, 0,   0, 0, $1
	anim_wait 8
	anim_obj ANIM_OBJ_RAIN,  11, 0,   0, 0, $2
	anim_wait 128
	anim_ret

BattleAnim_SunnyDay:
	anim_1gfx ANIM_GFX_WATER
	anim_bgp $90
	anim_sound 0, 1, SFX_MORNING_SUN
	anim_obj ANIM_OBJ_RAIN,  11, 0,   0, 0, $2
	anim_wait 8
	anim_obj ANIM_OBJ_RAIN,  11, 0,   0, 0, $2
	anim_wait 8
	anim_obj ANIM_OBJ_RAIN,  11, 0,   0, 0, $2
	anim_wait 128
	anim_ret

BattleAnim_MirrorCoat:
	anim_2gfx ANIM_GFX_REFLECT, ANIM_GFX_SPEED
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_MIRROR_COAT
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_METRONOME
.loop
	anim_obj ANIM_OBJ_SCREEN, 72, 80, $0
	anim_obj ANIM_OBJ_SHOOTING_SPARKLE, 64, 72, $4
	anim_wait 8
	anim_obj ANIM_OBJ_SHOOTING_SPARKLE, 64, 88, $4
	anim_wait 8
	anim_obj ANIM_OBJ_SHOOTING_SPARKLE, 64, 80, $4
	anim_wait 8
	anim_obj ANIM_OBJ_SHOOTING_SPARKLE, 64, 96, $4
	anim_wait 8
	anim_loop 3, .loop
	anim_wait 32
	anim_ret

BattleAnim_NastyPlot:
	anim_1gfx ANIM_GFX_STATUS
	anim_sound 0, 0, SFX_LICK
	anim_obj ANIM_OBJ_NASTY_PLOT_1, 64, 88, $2
	anim_wait 16
	anim_sound 0, 0, SFX_LICK
	anim_obj ANIM_OBJ_NASTY_PLOT_1, 68, 88, $1
	anim_obj ANIM_OBJ_NASTY_PLOT_1, 28, 88, $2
	anim_wait 16
	anim_sound 0, 0, SFX_LICK
	anim_obj ANIM_OBJ_NASTY_PLOT_1, 72, 88, $0
	anim_obj ANIM_OBJ_NASTY_PLOT_1, 24, 88, $1
	anim_obj ANIM_OBJ_NASTY_PLOT_2, 46, 80, $2
	anim_wait 16
	anim_obj ANIM_OBJ_NASTY_PLOT_1, 20, 88, $0
	anim_obj ANIM_OBJ_NASTY_PLOT_2, 46, 80, $1
	anim_wait 16
	anim_obj ANIM_OBJ_NASTY_PLOT_2, 46, 80, $0
	anim_wait 32
	anim_clearobjs
	anim_wait 1
	anim_2gfx ANIM_GFX_OBJECTS, ANIM_GFX_MISC
	anim_obj ANIM_OBJ_NASTY_PLOT_HAND, 48, 72, $0
	anim_sound 0, 1, SFX_FORESIGHT
	anim_obj ANIM_OBJ_NASTY_PLOT_SURPRISED, 48, 72, $0
	anim_wait 24
	anim_ret

BattleAnim_AerialAce:
	anim_2gfx ANIM_GFX_SPEED, ANIM_GFX_CUT
	anim_sound 0, 0, SFX_MENU
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_call BattleAnimSub_QuickAttack
	anim_wait 12
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj ANIM_OBJ_CUT_LONG_DOWN_LEFT, 160, 40, $0
	anim_wait 24
	anim_sound 0, 1, SFX_CUT
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $2
	anim_obj ANIM_OBJ_CUT_UP_RIGHT, 120, 68, $0
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 24
	anim_ret

BattleAnim_Extremespeed:
	anim_1gfx ANIM_GFX_SPEED
	anim_bgeffect ANIM_BG_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_sound 0, 0, SFX_RAZOR_WIND
	anim_call BattleAnimSub_QuickAttack
	anim_wait 12
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_WIND_BG
	anim_call BattleAnimSub_Agility
	anim_wait 32
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $6, $0
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $0a, $2, $0
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT, 120, 52, $0
	anim_wait 5
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 44, $0
	anim_wait 5
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj ANIM_OBJ_HIT, 152, 48, $0
	anim_wait 24
	anim_clearobjs
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 16
	anim_ret

BattleAnim_Ancientpower:
	anim_2gfx ANIM_GFX_ROCKS, ANIM_GFX_HIT
	anim_sound 0, 0, SFX_SPARK
	anim_obj ANIM_OBJ_ANCIENTPOWER,   8, 0,  13, 4, $20
	anim_wait 8
	anim_sound 0, 0, SFX_SPARK
	anim_obj ANIM_OBJ_ANCIENTPOWER,   9, 3,  12, 6, $20
	anim_wait 8
	anim_sound 0, 0, SFX_SPARK
	anim_obj ANIM_OBJ_ANCIENTPOWER,  10, 5,  12, 1, $20
	anim_wait 8
	anim_sound 0, 0, SFX_SPARK
	anim_obj ANIM_OBJ_ANCIENTPOWER,  12, 0,  11, 4, $20
	anim_wait 8
	anim_sound 0, 1, SFX_SPARK
	anim_obj ANIM_OBJ_ANCIENTPOWER,  13, 2,  10, 7, $20
	anim_wait 8
	anim_sound 0, 1, SFX_SPARK
	anim_obj ANIM_OBJ_ANCIENTPOWER,  14, 4,  10, 2, $20
	anim_wait 8
	anim_sound 0, 1, SFX_SPARK
	anim_obj ANIM_OBJ_ANCIENTPOWER,  15, 6,   9, 5, $20
	anim_wait 8
	anim_sound 0, 1, SFX_SPARK
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   7, 0, $0
	anim_wait 6
	anim_ret

BattleAnim_PowerGem:
	anim_1gfx ANIM_GFX_SHINE
	anim_bgp $1b
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_sound 0, 0, SFX_METRONOME
	anim_obj ANIM_OBJ_POWER_GEM, 46, 88, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 24, 90, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 36, 72, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 44, 112, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 30, 106, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 64, 104, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 54, 68, $0
	anim_wait 1
	anim_obj ANIM_OBJ_POWER_GEM, 72, 82, $0
	anim_wait 80
	anim_sound 0, 1, SFX_SHINE
	anim_incobj  8
	anim_wait 2
	anim_incobj  7
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_incobj  6
	anim_wait 4
	anim_sound 0, 1, SFX_SHINE
	anim_incobj  4
	anim_wait 2
	anim_incobj  1
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_incobj  3
	anim_wait 2
	anim_incobj  5
	anim_wait 2
	anim_sound 0, 1, SFX_SHINE
	anim_incobj  2
	anim_wait 2
	anim_wait 32
	anim_ret

BattleAnim_ShadowBall:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_SHADOW_BALL
	anim_2gfx ANIM_GFX_GLOW_SHADOW, ANIM_GFX_SMOKE
	anim_bgp $1b
	anim_obj ANIM_OBJ_GROWING_BALL, 64, 92, $0
.loop
	anim_sound 6, 3, SFX_WARP_TO
	anim_wait 8
	anim_loop 6, .loop
	anim_sound 6, 2, SFX_SLUDGE_BOMB
	anim_obj ANIM_OBJ_SHADOW_BALL, 64, 92, $2
	anim_wait 32
	anim_obj ANIM_OBJ_BALL_POOF, 132, 56, $10
	anim_wait 24
	anim_ret

BattleAnim_FutureSight:
	anim_1gfx ANIM_GFX_WIND_BG
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
	anim_bgeffect ANIM_BG_PSYCHIC, $0, $0, $0
	anim_call BattleAnimSub_Agility
.loop
	anim_sound 0, 0, SFX_THROW_BALL
	anim_wait 16
	anim_loop 4, .loop
	anim_incbgeffect ANIM_BG_PSYCHIC
	anim_ret

BattleAnim_RockSmash:
	anim_2gfx ANIM_GFX_ROCKS, ANIM_GFX_HIT
	anim_sound 0, 1, SFX_SPARK
	anim_obj ANIM_OBJ_HIT_YFIX,  16, 0,   7, 0, $0
	anim_sound 0, 1, SFX_SPARK
	anim_obj ANIM_OBJ_ROCK_SMASH,  16, 0,   8, 0, $28
	anim_obj ANIM_OBJ_ROCK_SMASH,  16, 0,   8, 0, $5c
	anim_sound 0, 1, SFX_SPARK
	anim_obj ANIM_OBJ_ROCK_SMASH,  16, 0,   8, 0, $10
	anim_obj ANIM_OBJ_ROCK_SMASH,  16, 0,   8, 0, $e8
	anim_sound 0, 1, SFX_SPARK
	anim_obj ANIM_OBJ_ROCK_SMASH,  16, 0,   8, 0, $9c
	anim_obj ANIM_OBJ_ROCK_SMASH,  16, 0,   8, 0, $d0
	anim_wait 6
	anim_sound 0, 1, SFX_SPARK
	anim_obj ANIM_OBJ_ROCK_SMASH,  16, 0,   8, 0, $1c
	anim_obj ANIM_OBJ_ROCK_SMASH,  16, 0,   8, 0, $50
	anim_sound 0, 1, SFX_SPARK
	anim_obj ANIM_OBJ_ROCK_SMASH,  16, 0,   8, 0, $dc
	anim_obj ANIM_OBJ_ROCK_SMASH,  16, 0,   8, 0, $90
	anim_wait 32
	anim_ret

BattleAnim_BrickBreak:
	anim_1gfx ANIM_GFX_HIT
	anim_sound 6, 2, SFX_SHINE
	anim_obj ANIM_OBJ_VERTICAL_CHOP_STILL, 136, 24, $30
	anim_wait 16
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $55, $2, $0
	anim_wait 64
	anim_clearobjs
	anim_obj ANIM_OBJ_VERTICAL_CHOP, 136, 82, $30
	anim_wait 8
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $3
	anim_obj ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 34
	anim_ret

BattleAnim_Whirlpool:
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_WATER
	anim_1gfx ANIM_GFX_WIND
	anim_bgeffect ANIM_BG_WHIRLPOOL, $0, $0, $0
	anim_sound 0, 1, SFX_SURF
	anim_wait 16
.loop
	anim_obj ANIM_OBJ_GUST, -16, 4,   9, 0, $0
	anim_wait 6
	anim_loop 9, .loop
	anim_wait 64
	anim_incbgeffect ANIM_BG_WHIRLPOOL
	anim_wait 1
	anim_ret

BattleAnimSub_ShakeEnemy:
	anim_sound 6, 2, SFX_LEER
	anim_obj ANIM_OBJ_LEER,   9, 0,  10, 4, $0
	anim_obj ANIM_OBJ_LEER,   8, 0,  10, 0, $0
	anim_obj ANIM_OBJ_LEER,  11, 0,   9, 4, $0
	anim_obj ANIM_OBJ_LEER,  10, 0,   9, 0, $0
	anim_obj ANIM_OBJ_LEER,  13, 0,   8, 4, $0
	anim_obj ANIM_OBJ_LEER,  12, 0,   8, 0, $0
	anim_obj ANIM_OBJ_LEER,  15, 0,   7, 4, $0
	anim_obj ANIM_OBJ_LEER,  14, 0,   7, 0, $0
	anim_obj ANIM_OBJ_LEER_TIP, -16, 2,   6, 6, $0
	anim_obj ANIM_OBJ_LEER_TIP,  15, 2,   6, 2, $0
	anim_ret

BattleAnimSub_WarpAway:
	anim_sound 0, 0, SFX_WARP_TO
	anim_obj ANIM_OBJ_WARP,   5, 4,  13, 4, $0
	anim_obj ANIM_OBJ_WARP,   5, 4,  12, 4, $0
	anim_obj ANIM_OBJ_WARP,   5, 4,  11, 4, $0
	anim_obj ANIM_OBJ_WARP,   5, 4,  10, 4, $0
	anim_obj ANIM_OBJ_WARP,   5, 4,   9, 4, $0
	anim_obj ANIM_OBJ_WARP,   5, 4,   8, 4, $0
	anim_obj ANIM_OBJ_WARP,   5, 4,   7, 4, $0
	anim_ret

BattleAnimSub_Beam:
	anim_sound 0, 0, SFX_HYPER_BEAM
	anim_obj ANIM_OBJ_BEAM,   8, 0,  11, 4, $0
	anim_wait 4
	anim_sound 0, 0, SFX_HYPER_BEAM
	anim_obj ANIM_OBJ_BEAM,  10, 0,  10, 4, $0
	anim_wait 4
	anim_sound 0, 1, SFX_HYPER_BEAM
	anim_obj ANIM_OBJ_BEAM,  12, 0,   9, 4, $0
	anim_wait 4
	anim_sound 0, 1, SFX_HYPER_BEAM
	anim_obj ANIM_OBJ_BEAM,  14, 0,   8, 4, $0
	anim_obj ANIM_OBJ_BEAM_TIP,  15, 6,   7, 6, $0
	anim_ret

BattleAnimSub_AbsorbHeal:
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj ANIM_OBJ_ABSORB,  16, 0,   6, 0, $2
	anim_wait 6
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj ANIM_OBJ_ABSORB, -15, 0,   8, 0, $3
	anim_wait 6
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj ANIM_OBJ_ABSORB, -15, 0,   4, 0, $4
	anim_ret

BattleAnimSub_Explosion1:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1,   3, 0,   8, 0, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1,   7, 0,  13, 0, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1,   3, 0,  13, 0, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1,   7, 0,   8, 0, $0
	anim_wait 5
	anim_sound 0, 0, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1,   5, 0,  10, 4, $0
	anim_ret

BattleAnimSub_Explosion2:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, -14, 4,   4, 0, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1,  14, 4,   9, 0, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, -14, 4,   9, 0, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1,  14, 4,   4, 0, $0
	anim_wait 5
	anim_sound 0, 1, SFX_EGG_BOMB
	anim_obj ANIM_OBJ_EXPLOSION1, -16, 4,   6, 4, $0
	anim_ret

BattleAnimSub_Sound:
	anim_obj ANIM_OBJ_SOUND,   8, 0,   9, 4, $0
	anim_obj ANIM_OBJ_SOUND,   8, 0,  11, 0, $1
	anim_obj ANIM_OBJ_SOUND,   8, 0,  12, 4, $2
	anim_ret

BattleAnimSub_Fire:
	anim_setobjpal PAL_BATTLE_OB_RED, PAL_BTLCUSTOM_FIRE
	anim_sound 0, 1, SFX_EMBER
.loop
	anim_obj ANIM_OBJ_BURNED, 136, 56, $10
	anim_obj ANIM_OBJ_BURNED, 136, 56, $90
	anim_wait 4
	anim_loop 4, .loop
	anim_ret

BattleAnimSub_Ice:
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

BattleAnimSub_Sludge:
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
	anim_ret

BattleAnimSub_SludgeShort:
.loop
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_SLUDGE, 132, 72, $0
	anim_wait 8
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_SLUDGE, 116, 72, $0
	anim_wait 8
	anim_sound 0, 1, SFX_TOXIC
	anim_obj ANIM_OBJ_SLUDGE, 148, 72, $0
	anim_wait 8
	anim_loop 2, .loop
	anim_wait 48
	anim_ret

BattleAnimSub_Acid:
.loop
	anim_sound 6, 2, SFX_BUBBLE_BEAM
	anim_obj ANIM_OBJ_ACID,   8, 0,  11, 4, $10
	anim_wait 5
	anim_loop 8, .loop
	anim_ret

BattleAnimSub_Metallic:
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_METALLIC
	anim_sound 0, 0, SFX_SHINE
	anim_wait 8
	anim_obj ANIM_OBJ_HARDEN,   6, 0,  10, 4, $0
	anim_wait 32
	anim_obj ANIM_OBJ_HARDEN,   6, 0,  10, 4, $0
	anim_wait 64
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_DEFAULT
	anim_ret

BattleAnimSub_Hail:
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_HAIL, 88, 0, $0
	anim_obj ANIM_OBJ_HAIL, 68, 0, $1
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_HAIL, 188, 0, $2
	anim_obj ANIM_OBJ_HAIL, 168, 0, $0
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_HAIL, 28, 0, $1
	anim_obj ANIM_OBJ_HAIL, 8, 0, $2
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_HAIL, 238, 0, $0
	anim_obj ANIM_OBJ_HAIL, 218, 0, $1
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_obj ANIM_OBJ_HAIL, 138, 0, $2
	anim_obj ANIM_OBJ_HAIL, 118, 0, $1
	anim_wait 8
	anim_ret

BattleAnimSub_Sandstorm:
	anim_1gfx ANIM_GFX_POWDER
	anim_obj ANIM_OBJ_SANDSTORM,  11, 0,   0, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_SANDSTORM,   9, 0,   0, 0, $1
	anim_wait 8
	anim_obj ANIM_OBJ_SANDSTORM,   7, 0,   0, 0, $2
	anim_1gfx ANIM_GFX_POWDER
	anim_obj ANIM_OBJ_SANDSTORM,  11, 0,   0, 0, $0
	anim_wait 8
	anim_obj ANIM_OBJ_SANDSTORM,   9, 0,   0, 0, $1
	anim_wait 8
	anim_obj ANIM_OBJ_SANDSTORM,   7, 0,   0, 0, $2
	anim_ret

BattleAnimSub_SandOrMud:
.loop
	anim_sound 6, 2, SFX_MENU
	anim_obj ANIM_OBJ_SAND,   8, 0,  11, 4, $4
	anim_wait 4
	anim_loop 8, .loop
	anim_wait 32
	anim_ret

BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0:
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
	anim_ret

BattleAnim_TargetObj_1Row:
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $0, $0
	anim_wait 6
	anim_ret

BattleAnim_TargetObj_2Row:
	anim_battlergfx_1row
	anim_bgeffect ANIM_BG_BATTLEROBJ_2ROW, $0, $0, $0
	anim_wait 6
	anim_ret

BattleAnim_ShowMon_0:
	anim_wait 1
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 5
	anim_incobj 1
	anim_wait 1
	anim_ret

BattleAnim_UserObj_1Row:
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $1, $0
	anim_wait 6
	anim_ret

BattleAnim_UserObj_2Row:
	anim_battlergfx_1row
	anim_bgeffect ANIM_BG_BATTLEROBJ_2ROW, $0, $1, $0
	anim_wait 4
	anim_ret

BattleAnim_ShowMon_1:
	anim_wait 1
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 4
	anim_incobj 1
	anim_wait 1
	anim_ret

BattleAnim_Sharpen: ; used in BoostGiovannisArmoredMewtwo
	anim_1gfx ANIM_GFX_SHAPES
	anim_obp0 $e4
	anim_call BattleAnim_TargetObj_1Row
	anim_sound 0, 0, SFX_SHARPEN
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_obj ANIM_OBJ_SHARPEN,   6, 0,  11, 0, $0
	anim_wait 96
	anim_incobj 2
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_GyroBall:
	anim_1gfx ANIM_GFX_GYRO_BALL
	anim_battlergfx_2row
	anim_bgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING, $0, $1, $40
	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_GRAY
	anim_setobjpal PAL_BATTLE_OB_GRAY, PAL_BTLCUSTOM_BRIGHT
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_BRIGHT
	anim_sound 0, 0, SFX_OUTRAGE
	anim_obj ANIM_OBJ_GYRO_BALL, 44, 96, $0
	anim_wait 64
	anim_incbgeffect ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	anim_clearobjs
	anim_bgeffect ANIM_BG_BATTLEROBJ_1ROW, $0, $0, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_wait 12
	anim_wait 1
	anim_incobj 1
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 1
	anim_clearobjs
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_WIND
	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_sound 0, 0, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_wait 8
	anim_setbgpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_DEFAULT
	anim_sound 0, 0, SFX_GRAVITY
.loop
	anim_obj ANIM_OBJ_RAPID_SPIN, 136, 72, $0
	anim_wait 2
	anim_loop 5, .loop
	anim_wait 62
	anim_ret

BattleAnim_RockBlast:
	anim_2gfx ANIM_GFX_ROCKS, ANIM_GFX_HIT
	anim_sound 6, 2, SFX_SPARK
	anim_obj ANIM_OBJ_ROCK_BLAST, 64, 92, $4
	anim_wait 16
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_YFIX, 128, 56, $0
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 56, $5c
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 56, $e8
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 56, $d0
	anim_obj ANIM_OBJ_ROCK_SMASH, 128, 56, $50
	anim_wait 32
	anim_ret

BattleAnim_SkillSwap:
	anim_setobjpal PAL_BATTLE_OB_YELLOW, PAL_BTLCUSTOM_SKILL_SWAP
	anim_jump BattleAnim_Transfer_Orbs_branch

BattleAnim_Transfer_Orbs_branch:
	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $4, $0
	anim_1gfx ANIM_GFX_CHARGE
.loop
	anim_sound 6, 3, SFX_STOP_SLOT
	anim_obj ANIM_OBJ_SKILL_SWAP_1, 136, 64, $2
	anim_wait 6
	anim_sound 6, 3, SFX_STOP_SLOT
	anim_obj ANIM_OBJ_SKILL_SWAP_1, 136, 64, $2
	anim_wait 6
	anim_sound 6, 3, SFX_STOP_SLOT
	anim_obj ANIM_OBJ_SKILL_SWAP_1, 136, 64, $2
	anim_wait 6
	anim_sound 6, 3, SFX_STOP_SLOT
	anim_obj ANIM_OBJ_SKILL_SWAP_1, 136, 64, $2
	anim_wait 6
	anim_sound 6, 3, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_SKILL_SWAP_2, 52, 88, $8
	anim_wait 6
	anim_sound 6, 3, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_SKILL_SWAP_2, 52, 88, $8
	anim_wait 6
	anim_sound 6, 3, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_SKILL_SWAP_2, 52, 88, $8
	anim_wait 6
	anim_sound 6, 3, SFX_UNKNOWN_66
	anim_obj ANIM_OBJ_SKILL_SWAP_2, 52, 88, $8
	anim_wait 6
	anim_loop 2, .loop
	anim_wait 32
	anim_ret

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

BattleAnim_UTurn:
	anim_1gfx ANIM_GFX_SPEED
	anim_sound 6, 2, SFX_THROW_BALL
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_call BattleAnimSub_QuickAttack
	anim_wait 12
	anim_1gfx ANIM_GFX_U_TURN
	anim_obj ANIM_OBJ_BLUR_DIAGONAL, 64, 92, $18
	anim_wait 8
	anim_clearobjs
	anim_wait 1
	anim_1gfx ANIM_GFX_HIT
	anim_wait 1
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 132, 56, $0
	anim_wait 8
	anim_clearobjs
	anim_wait 1
	anim_1gfx ANIM_GFX_U_TURN
	anim_wait 1
	anim_sound 0, 0, SFX_RETURN
	anim_obj ANIM_OBJ_BLUR_VERTICAL_UP, 132, 30, $30
	anim_wait 32
	anim_clearobjs
	anim_obj ANIM_OBJ_BLUR_VERTICAL_DOWN, 48, 0, $10
	anim_wait 16
	anim_clearobjs
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_ret

BattleAnim_SuckerPunch:
	anim_setobjpal PAL_BATTLE_OB_BLUE, PAL_BTLCUSTOM_PAYBACK
	anim_3gfx ANIM_GFX_OBJECTS_2, ANIM_GFX_HIT, ANIM_GFX_SPEED
	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
	anim_sound 0, 0, SFX_MENU
	anim_obj ANIM_OBJ_SPEED_LINE, 24, 88, $2
	anim_obj ANIM_OBJ_SPEED_LINE, 32, 88, $1
	anim_obj ANIM_OBJ_SPEED_LINE, 40, 88, $0
	anim_obj ANIM_OBJ_SPEED_LINE, 48, 88, $80
	anim_obj ANIM_OBJ_SPEED_LINE, 56, 88, $81
	anim_obj ANIM_OBJ_SPEED_LINE, 64, 88, $82
	anim_wait 12
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_SUCKER_PUNCH_R, 182, 32, $20
	anim_wait 32
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj ANIM_OBJ_SUCKER_PUNCH_L, 94, 48, $0
	anim_wait 6
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $4, $2
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_wait 12
	anim_call BattleAnimSub_QuickAttack
	anim_wait 8
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
	anim_wait 4
	anim_ret

BattleAnim_GigaImpact:
	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_CHARGE
	anim_bgeffect ANIM_BG_WHITE_HUES, $0, $8, $0
	anim_sound 0, 0, SFX_OUTRAGE
.loop
	anim_obj ANIM_OBJ_GROWTH, 48, 108, $0
	anim_obj ANIM_OBJ_GROWTH, 48, 108, $20
	anim_wait 4
	anim_loop 4, .loop
	anim_wait 48
	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $40
	anim_call BattleAnim_TargetObj_2Row
	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
	anim_sound 0, 0, SFX_SPARK
	anim_wait 16
	anim_bgeffect ANIM_BG_SHOW_MON, $0, $0, $0
	anim_wait 4
	anim_clearobjs
	anim_sound 0, 1, SFX_THUNDER
	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $4, $10
.loop2
	anim_obj ANIM_OBJ_HIT_BIG_YFIX, 136, 48, $0
	anim_wait 20
	anim_loop 3, .loop2
	anim_wait 16
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

BattleAnim_StatUp:
	anim_call BattleAnimSub_StatChange
.loop
	anim_sound 0, 0, SFX_STAT_UP
	anim_obj ANIM_OBJ_STAT_UP, 44, 107, $30
	anim_wait 12
	anim_statloop .loop
	anim_wait 8
	anim_incbgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING
	anim_ret

BattleAnim_StatDown:
	anim_call BattleAnimSub_StatChange
.loop
	anim_sound 0, 0, SFX_STAT_DOWN
	anim_obj ANIM_OBJ_STAT_DOWN, 44, 56, $10
	anim_wait 12
	anim_statloop .loop
	anim_wait 8
	anim_incbgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING
	anim_ret

BattleAnimSub_StatChange:
	anim_1gfx ANIM_GFX_STATS
	anim_bgeffect ANIM_BG_FADE_MON_TO_BLACK_REPEATING, $0, $1, $40
	anim_jumpif DEFENSE, .defense
	anim_jumpif SP_ATTACK, .sp_atk
	anim_jumpif SP_DEFENSE, .sp_def
	anim_jumpif SPEED, .speed
	anim_jumpif ACCURACY, .accuracy
	anim_jumpif EVASION, .evasion
.attack
	anim_setobjpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_ATTACK
	anim_jump .continue
.defense
	anim_setobjpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_DEFENSE
	anim_jump .continue
.sp_atk
	anim_setobjpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_SP_ATTACK
	anim_jump .continue
.sp_def
	anim_setobjpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_SP_DEFENSE
	anim_jump .continue
.speed
	anim_setobjpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_SPEED
	anim_jump .continue
.accuracy
	anim_setobjpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_ACCURACY
	anim_jump .continue
.evasion
	anim_setobjpal PAL_BATTLE_BG_USER, PAL_BTLCUSTOM_EVASION
.continue
	anim_obp0 $30
	anim_ret

; ================================
; unused animations below here
; ================================

;BattleAnim_Twineedle: ; removed
;	anim_2gfx ANIM_GFX_HORN, ANIM_GFX_HIT
;	anim_sound 0, 1, SFX_POISON_STING
;	anim_obj ANIM_OBJ_NEEDLE,   8, 0,  11, 4, $14
;	anim_obj ANIM_OBJ_NEEDLE,   7, 0,  10, 4, $14
;	anim_wait 16
;	anim_sound 0, 1, SFX_POISON_STING
;	anim_obj ANIM_OBJ_HIT_SMALL, -15, 0,   7, 0, $0
;	anim_obj ANIM_OBJ_HIT_SMALL,  16, 0,   6, 0, $0
;	anim_wait 16
;	anim_ret

;BattleAnim_BeatUp: ; removed
;	anim_jumpif $0, .current_mon
;	anim_sound 0, 0, SFX_BALL_POOF
;	anim_bgeffect ANIM_BG_RETURN_MON, $0, $1, $0
;	anim_wait 16
;	anim_beatup
;	anim_sound 0, 0, SFX_BALL_POOF
;	anim_bgeffect ANIM_BG_ENTER_MON, $0, $1, $0
;	anim_wait 16
;.current_mon
;	anim_1gfx ANIM_GFX_HIT
;	anim_call BattleAnim_TargetObj_1Row
;	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
;	anim_wait 4
;	anim_sound 0, 1, SFX_BEAT_UP
;	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   6, 0, $0
;	anim_wait 8
;	anim_call BattleAnim_ShowMon_0
;	anim_ret

;BattleAnim_Bind: ; removed
;	anim_1gfx ANIM_GFX_ROPE
;	anim_sound 0, 1, SFX_BIND
;	anim_obj ANIM_OBJ_BIND1, -16, 4,   8, 0, $0
;	anim_wait 8
;	anim_obj ANIM_OBJ_BIND2, -16, 4,   7, 0, $0
;	anim_wait 8
;	anim_obj ANIM_OBJ_BIND1, -16, 4,   6, 0, $0
;	anim_wait 64
;	anim_sound 0, 1, SFX_BIND
;	anim_incobj 1
;	anim_incobj 2
;	anim_incobj 3
;	anim_wait 96
;	anim_ret

;BattleAnim_SweetScent: ; removed
;	anim_2gfx ANIM_GFX_FLOWER, ANIM_GFX_MISC
;	anim_sound 0, 0, SFX_SWEET_SCENT
;	anim_obj ANIM_OBJ_FLOWER,   8, 0,  12, 0, $2
;	anim_wait 2
;	anim_obj ANIM_OBJ_FLOWER,   8, 0,  10, 0, $2
;	anim_wait 96
;	anim_obp0 $54
;	anim_sound 0, 1, SFX_SWEET_SCENT_2
;	anim_obj ANIM_OBJ_COTTON, -15, 0,   5, 0, $15
;	anim_obj ANIM_OBJ_COTTON, -15, 0,   5, 0, $2a
;	anim_obj ANIM_OBJ_COTTON, -15, 0,   5, 0, $3f
;	anim_wait 128
;	anim_ret

;BattleAnim_AcidArmor: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_call BattleAnim_TargetObj_2Row
;	anim_bgeffect ANIM_BG_ACID_ARMOR, $0, $1, $8
;	anim_sound 0, 0, SFX_MEGA_PUNCH
;	anim_wait 64
;	anim_incbgeffect ANIM_BG_ACID_ARMOR
;	anim_call BattleAnim_ShowMon_0
;	anim_ret

;BattleAnim_Mimic: ; removed
;	anim_1gfx ANIM_GFX_SPEED
;	anim_obp0 $fc
;	anim_sound 63, 3, SFX_LICK
;	anim_obj ANIM_OBJ_MIMIC, -16, 4,   5, 4, $0
;	anim_obj ANIM_OBJ_MIMIC, -16, 4,   5, 4, $8
;	anim_obj ANIM_OBJ_MIMIC, -16, 4,   5, 4, $10
;	anim_obj ANIM_OBJ_MIMIC, -16, 4,   5, 4, $18
;	anim_obj ANIM_OBJ_MIMIC, -16, 4,   5, 4, $20
;	anim_obj ANIM_OBJ_MIMIC, -16, 4,   5, 4, $28
;	anim_obj ANIM_OBJ_MIMIC, -16, 4,   5, 4, $30
;	anim_obj ANIM_OBJ_MIMIC, -16, 4,   5, 4, $38
;	anim_wait 128
;	anim_wait 48
;	anim_ret

;BattleAnim_BoneClub: ; removed
;	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_MISC
;	anim_obj ANIM_OBJ_BONE_CLUB,   8, 0,  11, 0, $2
;	anim_wait 32
;	anim_sound 0, 1, SFX_BONE_CLUB
;	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
;	anim_wait 16
;	anim_ret

;BattleAnim_Constrict: ; removed
;	anim_1gfx ANIM_GFX_ROPE
;	anim_sound 0, 1, SFX_BIND
;	anim_obj ANIM_OBJ_BIND2, -16, 4,   8, 0, $0
;	anim_wait 8
;	anim_obj ANIM_OBJ_BIND1, -16, 4,   6, 0, $0
;	anim_wait 8
;	anim_obj ANIM_OBJ_BIND2, -16, 4,   5, 0, $0
;	anim_wait 8
;	anim_obj ANIM_OBJ_BIND1, -16, 4,   7, 0, $0
;	anim_wait 64
;	anim_ret

;BattleAnim_MegaKick: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $40, $2, $0
;	anim_wait 67
;	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $3
;.loop
;	anim_sound 0, 1, SFX_MEGA_KICK
;	anim_obj ANIM_OBJ_KICK, -15, 0,   7, 0, $0
;	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   7, 0, $0
;	anim_wait 6
;	anim_obj ANIM_OBJ_KICK, -15, 0,   7, 0, $0
;	anim_wait 6
;	anim_loop 3, .loop
;	anim_ret

;BattleAnim_RollingKick: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_sound 0, 1, SFX_DOUBLE_KICK
;	anim_obj ANIM_OBJ_KICK,  14, 0,   7, 0, $0
;	anim_setobj $1, $3
;	anim_wait 12
;	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   6, 0, $0
;	anim_wait 16
;	anim_ret

;BattleAnim_PoisonGas: ; removed
;	anim_1gfx ANIM_GFX_HAZE
;	anim_sound 16, 2, SFX_BUBBLE_BEAM
;.loop
;	anim_obj ANIM_OBJ_POISON_GAS,   5, 4,  10, 0, $2
;	anim_wait 8
;	anim_loop 10, .loop
;	anim_wait 128
;	anim_ret

;BattleAnim_Present: ; removed
;	anim_2gfx ANIM_GFX_STATUS, ANIM_GFX_BUBBLE
;	anim_sound 0, 1, SFX_PRESENT
;	anim_obj ANIM_OBJ_PRESENT,   8, 0,  11, 0, $6c
;	anim_wait 56
;	anim_obj ANIM_OBJ_AMNESIA,  13, 0,   6, 0, $0
;	anim_wait 48
;	anim_incobj 2
;	anim_incobj 1
;	anim_wait 1
;	anim_1gfx ANIM_GFX_EXPLOSION
;	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $12
;.loop
;	anim_call BattleAnimSub_Explosion2
;	anim_wait 16
;	anim_jumpuntil .loop
;	anim_ret

;BattleAnim_Clamp: ; removed
;	anim_2gfx ANIM_GFX_CUT, ANIM_GFX_HIT
;	anim_obj ANIM_OBJ_CLAMP, -15, 0,   7, 0, $a0
;	anim_obj ANIM_OBJ_CLAMP, -15, 0,   7, 0, $20
;	anim_wait 16
;	anim_sound 0, 1, SFX_BITE
;	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   6, 0, $18
;	anim_wait 32
;	anim_sound 0, 1, SFX_BITE
;	anim_obj ANIM_OBJ_HIT_YFIX,  16, 0,   8, 0, $18
;	anim_wait 16
;	anim_ret

;BattleAnim_CottonSpore: ; removed
;	anim_obp0 $54
;	anim_1gfx ANIM_GFX_MISC
;	anim_sound 0, 1, SFX_POWDER
;.loop
;	anim_obj ANIM_OBJ_COTTON_SPORE, -16, 4,   4, 0, $0
;	anim_wait 8
;	anim_loop 5, .loop
;	anim_wait 96
;	anim_ret

;BattleAnim_JumpKick: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_sound 0, 1, SFX_JUMP_KICK
;	anim_obj ANIM_OBJ_KICK,  14, 0,   9, 0, $0
;	anim_obj ANIM_OBJ_KICK,  12, 4,   7, 4, $0
;	anim_setobj $1, $2
;	anim_setobj $2, $2
;	anim_wait 24
;	anim_sound 0, 1, SFX_DOUBLE_KICK
;	anim_obj ANIM_OBJ_HIT, -15, 0,   6, 0, $0
;	anim_wait 16
;	anim_ret

;BattleAnim_BoneRush: ; removed
;	anim_2gfx ANIM_GFX_HIT, ANIM_GFX_MISC
;	anim_sound 0, 1, SFX_BONE_CLUB
;	anim_obj ANIM_OBJ_BONE_RUSH, -16, 4,   7, 0, $2
;	anim_wait 16
;	anim_sound 0, 1, SFX_COMET_PUNCH
;	anim_obj ANIM_OBJ_HIT_YFIX,  15, 0,   6, 0, $0
;	anim_wait 16
;	anim_sound 0, 1, SFX_COMET_PUNCH
;	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   8, 0, $0
;	anim_wait 16
;	anim_ret

;BattleAnim_SpiderWeb: ; removed
;	anim_1gfx ANIM_GFX_WEB
;	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
;	anim_obj ANIM_OBJ_SPIDER_WEB, -16, 4,   6, 0, $0
;	anim_sound 6, 2, SFX_SPIDER_WEB
;	anim_obj ANIM_OBJ_STRING_SHOT,   8, 0,  10, 0, $0
;	anim_wait 4
;	anim_obj ANIM_OBJ_STRING_SHOT,   8, 0,  11, 0, $0
;	anim_wait 4
;	anim_obj ANIM_OBJ_STRING_SHOT,   8, 0,  10, 4, $0
;	anim_wait 64
;	anim_ret

;BattleAnim_CometPunch: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_jumpif $1, .alternate
;	anim_sound 0, 1, SFX_COMET_PUNCH
;	anim_obj ANIM_OBJ_PUNCH, -14, 0,   6, 0, $0
;	anim_wait 6
;	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   6, 0, $0
;	anim_wait 8
;	anim_ret

;.alternate
;	anim_sound 0, 1, SFX_COMET_PUNCH
;	anim_obj ANIM_OBJ_PUNCH,  15, 0,   8, 0, $0
;	anim_wait 6
;	anim_obj ANIM_OBJ_HIT_YFIX,  15, 0,   8, 0, $0
;	anim_wait 8
;	anim_ret

;BattleAnim_Conversion2: ; removed
;	anim_1gfx ANIM_GFX_EXPLOSION
;	anim_sound 63, 3, SFX_SHARPEN
;	anim_obj ANIM_OBJ_CONVERSION2, -16, 4,   5, 4, $0
;	anim_obj ANIM_OBJ_CONVERSION2, -16, 4,   5, 4, $8
;	anim_obj ANIM_OBJ_CONVERSION2, -16, 4,   5, 4, $10
;	anim_obj ANIM_OBJ_CONVERSION2, -16, 4,   5, 4, $18
;	anim_obj ANIM_OBJ_CONVERSION2, -16, 4,   5, 4, $20
;	anim_obj ANIM_OBJ_CONVERSION2, -16, 4,   5, 4, $28
;	anim_obj ANIM_OBJ_CONVERSION2, -16, 4,   5, 4, $30
;	anim_obj ANIM_OBJ_CONVERSION2, -16, 4,   5, 4, $38
;	anim_wait 128
;	anim_wait 48
;	anim_ret

;BattleAnim_TailWhip: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_call BattleAnim_TargetObj_2Row
;	anim_sound 0, 0, SFX_TAIL_WHIP
;	anim_bgeffect ANIM_BG_WOBBLE_MON, $0, $1, $0
;	anim_wait 32
;	anim_incbgeffect ANIM_BG_WOBBLE_MON
;	anim_call BattleAnim_ShowMon_0
;	anim_ret

;BattleAnim_VitalThrow: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_call BattleAnim_TargetObj_1Row
;	anim_bgeffect ANIM_BG_VITAL_THROW, $0, $1, $0
;	anim_wait 16
;	anim_sound 0, 0, SFX_MENU
;	anim_obj ANIM_OBJ_HIT,   8, 0,  12, 0, $0
;	anim_wait 8
;	anim_sound 0, 0, SFX_MENU
;	anim_obj ANIM_OBJ_HIT,   7, 0,  11, 0, $0
;	anim_wait 8
;	anim_sound 0, 0, SFX_MENU
;	anim_obj ANIM_OBJ_HIT,   8, 4,  13, 0, $0
;	anim_wait 8
;	anim_incbgeffect ANIM_BG_VITAL_THROW
;	anim_wait 16
;	anim_call BattleAnim_ShowMon_0
;	anim_sound 0, 1, SFX_MEGA_PUNCH
;	anim_obj ANIM_OBJ_HIT_BIG, -16, 4,   7, 0, $0
;	anim_wait 16
;	anim_ret

;BattleAnim_ViceGrip: ; removed
;	anim_1gfx ANIM_GFX_CUT
;	anim_sound 0, 1, SFX_VICEGRIP
;	anim_obj ANIM_OBJ_CUT_DOWN_LEFT, -13, 0,   5, 0, $0
;	anim_obj ANIM_OBJ_CUT_UP_RIGHT,  15, 0,   9, 0, $0
;	anim_wait 32
;	anim_ret

;BattleAnim_Bide: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_call BattleAnim_TargetObj_1Row
;	anim_sound 0, 0, SFX_ESCAPE_ROPE
;	anim_bgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING, $0, $1, $20
;	anim_wait 72
;	anim_incbgeffect ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
;	anim_call BattleAnim_ShowMon_0
;	anim_ret

;BattleAnim_LovelyKiss: ; removed
;	anim_2gfx ANIM_GFX_OBJECTS, ANIM_GFX_ANGELS
;	anim_call BattleAnimSub_BGCycleOBPalsGrayAndYellow_0_2_0
;	anim_obj ANIM_OBJ_LOVELY_KISS, -13, 0,   5, 0, $0
;	anim_wait 32
;	anim_sound 0, 1, SFX_LICK
;	anim_obj ANIM_OBJ_HEART,  16, 0,   5, 0, $0
;	anim_wait 40
;	anim_ret

;BattleAnim_SkullBash: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $14, $2, $0
;	anim_wait 32
;	anim_call BattleAnim_TargetObj_1Row
;	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $3
;	anim_bgeffect ANIM_BG_TACKLE, $0, $1, $0
;	anim_wait 4
;.loop
;	anim_sound 0, 1, SFX_HEADBUTT
;	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
;	anim_wait 8
;	anim_loop 3, .loop
;	anim_call BattleAnim_ShowMon_0
;	anim_ret

;BattleAnim_Meditate: ; unused
;	anim_1gfx ANIM_GFX_HIT
;	anim_call BattleAnim_TargetObj_1Row
;	anim_sound 0, 0, SFX_PSYBEAM
;	anim_bgeffect ANIM_BG_WAVE_DEFORM_MON, $0, $1, $0
;	anim_wait 48
;	anim_incbgeffect ANIM_BG_WAVE_DEFORM_MON
;	anim_wait 48
;	anim_call BattleAnim_ShowMon_0
;	anim_ret

;BattleAnim_Snore: ; removed
;	anim_2gfx ANIM_GFX_STATUS, ANIM_GFX_NOISE
;	anim_obj ANIM_OBJ_ASLEEP,   8, 0,  10, 0, $0
;	anim_wait 32
;	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $2, $0
;	anim_sound 0, 0, SFX_SNORE
;.loop
;	anim_call BattleAnimSub_Sound
;	anim_wait 16
;	anim_loop 2, .loop
;	anim_wait 8
;	anim_ret

;BattleAnim_Barrage: ; removed
;	anim_2gfx ANIM_GFX_EGG, ANIM_GFX_EXPLOSION
;	anim_sound 6, 2, SFX_THROW_BALL
;	anim_obj ANIM_OBJ_SLUDGE_BOMB,   8, 0,  11, 4, $10
;	anim_wait 36
;	anim_sound 0, 1, SFX_EGG_BOMB
;	anim_obj ANIM_OBJ_EXPLOSION2, -15, 0,   7, 0, $0
;	anim_wait 16
;	anim_ret

;BattleAnim_Twister: ; removed
;	anim_2gfx ANIM_GFX_WIND, ANIM_GFX_HIT
;.loop1
;	anim_sound 0, 0, SFX_RAZOR_WIND
;	anim_obj ANIM_OBJ_GUST,   8, 0,  14, 0, $0
;	anim_wait 6
;	anim_loop 9, .loop1
;.loop2
;	anim_sound 0, 0, SFX_RAZOR_WIND
;	anim_wait 8
;	anim_loop 8, .loop2
;	anim_incobj 1
;	anim_incobj 2
;	anim_incobj 3
;	anim_incobj 4
;	anim_incobj 5
;	anim_incobj 6
;	anim_incobj 7
;	anim_incobj 8
;	anim_incobj 9
;	anim_wait 64
;	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   8, 0, $18
;.loop3
;	anim_sound 0, 1, SFX_RAZOR_WIND
;	anim_wait 8
;	anim_loop 4, .loop3
;	anim_obj ANIM_OBJ_HIT_YFIX,  16, 0,   4, 0, $18
;.loop4
;	anim_sound 0, 1, SFX_RAZOR_WIND
;	anim_wait 8
;	anim_loop 4, .loop4
;	anim_incobj 1
;	anim_incobj 2
;	anim_incobj 3
;	anim_incobj 4
;	anim_incobj 5
;	anim_incobj 6
;	anim_incobj 7
;	anim_incobj 8
;	anim_incobj 9
;	anim_wait 32
;	anim_ret

;BattleAnim_EggBomb: ; removed
;	anim_2gfx ANIM_GFX_EGG, ANIM_GFX_EXPLOSION
;	anim_sound 0, 0, SFX_SWITCH_POKEMON
;	anim_obj ANIM_OBJ_EGG,   5, 4,  13, 0, $1
;	anim_wait 128
;	anim_wait 96
;	anim_incobj 1
;	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $3
;	anim_sound 0, 1, SFX_EGG_BOMB
;	anim_obj ANIM_OBJ_EXPLOSION2,  16, 0,   8, 0, $0
;	anim_wait 8
;	anim_sound 0, 1, SFX_EGG_BOMB
;	anim_obj ANIM_OBJ_EXPLOSION2, -14, 0,   8, 4, $0
;	anim_wait 8
;	anim_sound 0, 1, SFX_EGG_BOMB
;	anim_obj ANIM_OBJ_EXPLOSION2, -15, 0,   9, 0, $0
;	anim_wait 24
;	anim_ret

;BattleAnim_LockOn: ; removed
;	anim_1gfx ANIM_GFX_MISC
;	anim_sound 0, 1, SFX_MIND_READER
;.loop
;	anim_obj ANIM_OBJ_LOCK_ON, -16, 4,   6, 0, $3
;	anim_obj ANIM_OBJ_LOCK_ON, -16, 4,   6, 0, $12
;	anim_obj ANIM_OBJ_LOCK_ON, -16, 4,   6, 0, $20
;	anim_obj ANIM_OBJ_LOCK_ON, -16, 4,   6, 0, $31
;	anim_wait 16
;	anim_loop 2, .loop
;	anim_wait 32
;	anim_ret

;BattleAnim_MegaPunch: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $40, $2, $0
;	anim_wait 48
;	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $3
;.loop
;	anim_sound 0, 1, SFX_MEGA_PUNCH
;	anim_obj ANIM_OBJ_PUNCH, -15, 0,   7, 0, $0
;	anim_obj ANIM_OBJ_HIT_BIG_YFIX, -15, 0,   7, 0, $0
;	anim_wait 6
;	anim_obj ANIM_OBJ_PUNCH, -15, 0,   7, 0, $0
;	anim_wait 6
;	anim_loop 3, .loop
;	anim_ret

;BattleAnim_Nightmare: ; removed
;	anim_1gfx ANIM_GFX_ANGELS
;	anim_bgp $1b
;	anim_obp0 $f
;	anim_obj ANIM_OBJ_NIGHTMARE, -16, 4,   5, 0, $0
;	anim_obj ANIM_OBJ_NIGHTMARE, -16, 4,   5, 0, $a0
;	anim_sound 0, 1, SFX_NIGHTMARE
;	anim_wait 96
;	anim_bgp $e4
;	anim_ret

;BattleAnim_Pound: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_sound 0, 1, SFX_POUND
;	anim_obj ANIM_OBJ_PALM, -15, 0,   7, 0, $0
;	anim_wait 6
;	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   7, 0, $0
;	anim_wait 16
;	anim_ret

;BattleAnim_Smog: ; removed
;	anim_1gfx ANIM_GFX_HAZE
;	anim_sound 0, 1, SFX_BUBBLE_BEAM
;.loop
;	anim_obj ANIM_OBJ_SMOG, -16, 4,   2, 0, $0
;	anim_wait 8
;	anim_loop 10, .loop
;	anim_wait 96
;	anim_ret

;BattleAnim_Slam: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_sound 0, 1, SFX_WING_ATTACK
;	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $2
;	anim_obj ANIM_OBJ_HIT_YFIX,  15, 4,   5, 0, $0
;	anim_wait 16
;	anim_ret

;BattleAnim_SweetScent2: ; removed
;	anim_2gfx ANIM_GFX_FLOWER, ANIM_GFX_MISC
;	anim_obj ANIM_OBJ_FLOWER,   8, 0,  12, 0, $2
;	anim_wait 2
;	anim_obj ANIM_OBJ_FLOWER,   8, 0,  10, 0, $2
;	anim_wait 64
;	anim_obj ANIM_OBJ_COTTON, -15, 0,   5, 0, $15
;	anim_obj ANIM_OBJ_COTTON, -15, 0,   5, 0, $2a
;	anim_obj ANIM_OBJ_COTTON, -15, 0,   5, 0, $3f
;	anim_bgeffect ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW, $0, $2, $0
;	anim_wait 128
;	anim_ret

;BattleAnim_TripleKick: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_jumpif $1, .alternate1
;	anim_jumpif $2, .alternate2
;	anim_sound 0, 1, SFX_MEGA_KICK
;	anim_obj ANIM_OBJ_KICK, -14, 0,   6, 0, $0
;	anim_wait 6
;	anim_obj ANIM_OBJ_HIT_YFIX, -14, 0,   6, 0, $0
;	anim_wait 8
;	anim_ret

;.alternate1:
;	anim_sound 0, 1, SFX_DOUBLE_KICK
;	anim_obj ANIM_OBJ_KICK,  15, 0,   8, 0, $0
;	anim_wait 6
;	anim_obj ANIM_OBJ_HIT_YFIX,  15, 0,   8, 0, $0
;	anim_wait 8
;	anim_ret

;.alternate2:
;	anim_sound 0, 1, SFX_DOUBLE_KICK
;	anim_obj ANIM_OBJ_KICK, -16, 4,   4, 0, $0
;	anim_wait 6
;	anim_obj ANIM_OBJ_HIT_YFIX, -16, 4,   4, 0, $0
;	anim_wait 8
;	anim_ret

;BattleAnim_Selfdestruct:
;	anim_1gfx ANIM_GFX_EXPLOSION
;	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $24
;	anim_jumpif $1, .loop
;	anim_call BattleAnimSub_Explosion2
;	anim_wait 16
;	anim_bgp $e4
;	anim_ret
;
;.loop
;	anim_call BattleAnimSub_Explosion1
;	anim_wait 5
;	anim_bgeffect ANIM_BG_HIDE_MON, $0, $1, $0
;	anim_loop 2, .loop
;	anim_wait 16
;	anim_bgp $e4
;	anim_ret

;BattleAnim_Bubble: ; removed
;	anim_1gfx ANIM_GFX_BUBBLE
;	anim_sound 32, 2, SFX_WATER_GUN
;	anim_obj ANIM_OBJ_BUBBLE,   8, 0,  11, 4, $c1
;	anim_wait 6
;	anim_sound 32, 2, SFX_WATER_GUN
;	anim_obj ANIM_OBJ_BUBBLE,   8, 0,  11, 4, $e1
;	anim_wait 6
;	anim_sound 32, 2, SFX_WATER_GUN
;	anim_obj ANIM_OBJ_BUBBLE,   8, 0,  11, 4, $d1
;	anim_wait 128
;	anim_wait 32
;	anim_ret

;BattleAnim_Flail: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_call BattleAnim_TargetObj_1Row
;	anim_sound 0, 0, SFX_SUBMISSION
;	anim_bgeffect ANIM_BG_FLAIL, $0, $1, $0
;	anim_wait 8
;	anim_obj ANIM_OBJ_HIT_YFIX,  15, 0,   6, 0, $0
;	anim_wait 8
;	anim_obj ANIM_OBJ_HIT_YFIX, -13, 0,   6, 0, $0
;	anim_wait 8
;	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   6, 0, $0
;	anim_wait 8
;	anim_incbgeffect ANIM_BG_FLAIL
;	anim_call BattleAnim_ShowMon_0
;	anim_ret

;BattleAnim_Spite: ; removed
;	anim_1gfx ANIM_GFX_ANGELS
;	anim_obj ANIM_OBJ_SPITE, -16, 4,   2, 0, $0
;	anim_sound 0, 1, SFX_SPITE
;	anim_wait 96
;	anim_ret

;BattleAnim_Submission: ; removed
;	anim_1gfx ANIM_GFX_HIT
;	anim_call BattleAnim_UserObj_1Row
;	anim_bgeffect ANIM_BG_WOBBLE_MON, $0, $0, $0
;	anim_sound 0, 1, SFX_SUBMISSION
;	anim_wait 32
;	anim_obj ANIM_OBJ_HIT_YFIX,  15, 0,   6, 0, $0
;	anim_wait 32
;	anim_obj ANIM_OBJ_HIT_YFIX, -13, 0,   7, 0, $0
;	anim_wait 32
;	anim_obj ANIM_OBJ_HIT_YFIX, -15, 0,   6, 4, $0
;	anim_wait 32
;	anim_incbgeffect ANIM_BG_WOBBLE_MON
;	anim_call BattleAnim_ShowMon_1
;	anim_ret

;BattleAnim_Detect: ; removed
;	anim_1gfx ANIM_GFX_SHINE
;	anim_bgeffect ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW, $0, $0, $0
;	anim_sound 0, 0, SFX_FORESIGHT
;	anim_obj ANIM_OBJ_FORESIGHT,   8, 0,  11, 0, $0
;	anim_wait 24
;	anim_ret

;BattleAnim_Psywave: ; removed
;	anim_1gfx ANIM_GFX_PSYCHIC
;	anim_bgeffect ANIM_BG_PSYCHIC, $0, $0, $0
;.loop
;	anim_sound 6, 2, SFX_PSYCHIC
;	anim_obj ANIM_OBJ_WAVE,   8, 0,  10, 0, $2
;	anim_wait 8
;	anim_sound 6, 2, SFX_PSYCHIC
;	anim_obj ANIM_OBJ_WAVE,   8, 0,  11, 0, $3
;	anim_wait 8
;	anim_sound 6, 2, SFX_PSYCHIC
;	anim_obj ANIM_OBJ_WAVE,   8, 0,  12, 0, $4
;	anim_wait 8
;	anim_loop 3, .loop
;	anim_wait 32
;	anim_incbgeffect ANIM_BG_PSYCHIC
;	anim_wait 4
;	anim_ret

;BattleAnim_Fissure: ; removed
;	anim_bgeffect ANIM_BG_FLASH_INVERTED, $0, $8, $40
;	anim_bgeffect ANIM_BG_SHAKE_SCREEN_X, $60, $4, $0
;.loop
;	anim_sound 0, 1, SFX_EMBER
;	anim_wait 24
;	anim_loop 4, .loop
;	anim_ret

;BattleAnim_SkyAttack: ; removed
;	anim_1gfx ANIM_GFX_SKY_ATTACK
;	anim_bgeffect ANIM_BG_REMOVE_MON, $0, $1, $0
;	anim_wait 32
;	anim_sound 0, 0, SFX_HYPER_BEAM
;	anim_obj ANIM_OBJ_SKY_ATTACK,   6, 0,  11, 0, $40
;	anim_wait 64
;	anim_incobj 1
;	anim_wait 21
;	anim_sound 0, 1, SFX_HYPER_BEAM
;	anim_bgeffect ANIM_BG_ALTERNATE_HUES, $0, $2, $0
;	anim_wait 64
;	anim_incobj 1
;	anim_wait 32
;	anim_bgeffect ANIM_BG_SHOW_MON, $0, $1, $0
;	anim_wait 16
;	anim_ret

;BattleAnim_FuryCutter: ; removed
;	anim_1gfx ANIM_GFX_CUT
;.loop
;	anim_sound 0, 1, SFX_CUT
;	anim_jumpand $1, .obj1
;	anim_obj ANIM_OBJ_CUT_LONG_DOWN_LEFT, -13, 0,   5, 0, $0
;	anim_jump .okay
;
;.obj1
;	anim_obj ANIM_OBJ_CUT_LONG_DOWN_RIGHT,  14, 0,   5, 0, $0
;.okay
;	anim_wait 16
;	anim_jumpuntil .loop
;	anim_ret

;BattleAnim_Sludge: ; removed
;	anim_1gfx ANIM_GFX_POISON
;	anim_call BattleAnimSub_Sludge
;	anim_wait 56
;	anim_ret
