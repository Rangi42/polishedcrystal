CanLearnTMHMMove: ; 11639
	ld a, [CurPartySpecies]
	ld [CurSpecies], a
	call GetBaseData
	ld hl, BaseTMHM
	push hl

	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, 0
	ld hl, TMHMMoves
.loop
	ld a, [hli]
	and a
	jr z, .end
	cp b
	jr z, .asm_11659
	inc c
	jr .loop

.asm_11659
	pop hl
	ld b, CHECK_FLAG
	push de
	ld d, 0
	predef FlagPredef
	pop de
	ret

.end
	pop hl
	ld c, 0
	ret
; 1166a

GetTMHMMove: ; 1166a
	ld a, [wd265]
	dec a
	ld hl, TMHMMoves
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd265], a
	ret
; 1167a

TMHMMoves: ; 1167a
	db DYNAMICPUNCH
	db DRAGON_CLAW
	db CURSE
	db CALM_MIND
	db ROAR
	db TOXIC
	db ZAP_CANNON
	db BULK_UP
	db HEADBUTT
	db HIDDEN_POWER
	db SUNNY_DAY
	db ROLLOUT
	db ICY_WIND
	db BLIZZARD
	db HYPER_BEAM
	db LIGHT_SCREEN
	db PROTECT
	db RAIN_DANCE
	db GIGA_DRAIN
	db ENDURE
	db ICE_PUNCH
	db SOLARBEAM
	db IRON_TAIL
	db DRAGONBREATH
	db THUNDER
	db EARTHQUAKE
	db RETURN
	db DIG
	db PSYCHIC_M
	db SHADOW_BALL
	db MUD_SLAP
	db DOUBLE_TEAM
	db REFLECT
	db SWAGGER
	db SLEEP_TALK
	db SLUDGE_BOMB
	db SANDSTORM
	db FIRE_BLAST
	db SWIFT
	db DEFENSE_CURL
	db THUNDERPUNCH
	db DREAM_EATER
	db WILL_O_WISP
	db REST
	db ATTRACT
	db THIEF
	db STEEL_WING
	db FIRE_PUNCH
	db FURY_CUTTER
	db DAZZLINGLEAM
	db STONE_EDGE
	db ROCK_SLIDE ; TODO: AVALANCHE
	db WILD_CHARGE
	db POISON_JAB
	db SHADOW_CLAW
	db FOCUS_BLAST
	db DARK_PULSE
	db FLASH_CANNON
	db DRAGON_PULSE
	db X_SCISSOR
	db CUT
	db FLY
	db SURF
	db STRENGTH
	db FLASH
	db WHIRLPOOL
	db WATERFALL
	db ROCK_SMASH

; Move tutor
	db FLAMETHROWER
	db THUNDERBOLT
	db ICE_BEAM

	db 0 ; end
; 116b7
