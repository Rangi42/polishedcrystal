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
	db DYNAMICPUNCH ; TM01
	db DRAGON_CLAW  ; TM02
	db CURSE        ; TM03
	db CALM_MIND    ; TM04
	db ROAR         ; TM05
	db TOXIC        ; TM06
	db DRAGONBREATH ; TM07
	db BULK_UP      ; TM08
	db HEADBUTT     ; TM09
	db HIDDEN_POWER ; TM10
	db SUNNY_DAY    ; TM11
	db ROLLOUT      ; TM12
	db ICE_BEAM     ; TM13
	db BLIZZARD     ; TM14
	db HYPER_BEAM   ; TM15
	db LIGHT_SCREEN ; TM16
	db PROTECT      ; TM17
	db RAIN_DANCE   ; TM18
	db GIGA_DRAIN   ; TM19
	db ENDURE       ; TM20
	db ICE_PUNCH    ; TM21
	db SOLARBEAM    ; TM22
	db IRON_TAIL    ; TM23
	db THUNDERBOLT  ; TM24
	db THUNDER      ; TM25
	db EARTHQUAKE   ; TM26
	db RETURN       ; TM27
	db DIG          ; TM28
	db PSYCHIC_M    ; TM29
	db SHADOW_BALL  ; TM30
	db MUD_SLAP     ; TM31
	db DOUBLE_TEAM  ; TM32
	db REFLECT      ; TM33
	db SWAGGER      ; TM34
	db FLAMETHROWER ; TM35
	db SLUDGE_BOMB  ; TM36
	db SANDSTORM    ; TM37
	db FIRE_BLAST   ; TM38
	db SWIFT        ; TM39
	db DEFENSE_CURL ; TM40
	db THUNDERPUNCH ; TM41
	db ICY_WIND     ; TM42
	db WILL_O_WISP  ; TM43
	db REST         ; TM44
	db ATTRACT      ; TM45
	db THIEF        ; TM46
	db STEEL_WING   ; TM47
	db FIRE_PUNCH   ; TM48
	db FURY_CUTTER  ; TM49
	db DAZZLINGLEAM ; TM50
	db STONE_EDGE   ; TM51
	db AVALANCHE    ; TM52
	db WILD_CHARGE  ; TM53
	db POISON_JAB   ; TM54
	db SHADOW_CLAW  ; TM55
	db FOCUS_BLAST  ; TM56
	db DARK_PULSE   ; TM57
	db FLASH_CANNON ; TM58
	db DRAGON_PULSE ; TM59
	db X_SCISSOR    ; TM60
	db CUT          ; HM01
	db FLY          ; HM02
	db SURF         ; HM03
	db STRENGTH     ; HM04
	db FLASH        ; HM05
	db WHIRLPOOL    ; HM06
	db WATERFALL    ; HM07
	db ROCK_SMASH   ; HM08

; Move tutor
	db AQUA_TAIL    ; MT01
	db DREAM_EATER  ; MT02
	db EARTH_POWER  ; MT03
	db HYPER_VOICE  ; MT04
	db IRON_HEAD    ; MT05
	db SEED_BOMB    ; MT06
	db SLEEP_TALK   ; MT07
	db ZAP_CANNON   ; MT08
	db ZEN_HEADBUTT ; MT09

	db 0 ; end
; 116b7
