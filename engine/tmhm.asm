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
	db DYNAMICPUNCH ; TM01 (Chuck)
	db DRAGON_CLAW  ; TM02 (Route 27)
	db CURSE        ; TM03 (Celadon Mansion)
	db CALM_MIND    ; TM04 (Celadon Dept.Store)
	db ROAR         ; TM05 (Route 32)
	db TOXIC        ; TM06 (Celadon Dept.Store)
	db ROLLOUT      ; TM07 (Route 35)
	db BULK_UP      ; TM08 (Celadon Dept.Store)
	db SWORDS_DANCE ; TM09 (Celadon Dept.Store)
	db HIDDEN_POWER ; TM10 (Lake of Rage, Celadon Dept.Store)
	db SUNNY_DAY    ; TM11 (Radio Tower, Celadon Dept.Store)
	db ICY_WIND     ; TM12 (Pryce)
	db ICE_BEAM     ; TM13 (Goldenrod Dept.Store)
	db BLIZZARD     ; TM14 (Goldenrod Game Corner)
	db HYPER_BEAM   ; TM15 (Celadon Game Corner)
	db LIGHT_SCREEN ; TM16 (Goldenrod Dept.Store)
	db PROTECT      ; TM17 (Goldenrod Dept.Store)
	db RAIN_DANCE   ; TM18 (Slowpoke Well, Celadon Dept.Store)
	db GIGA_DRAIN   ; TM19 (Erika)
	db SAFEGUARD    ; TM20 (Goldenrod Dept.Store)
	db DRAGONBREATH ; TM21 (Clair)
	db SOLAR_BEAM   ; TM22 (Goldenrod Dept.Store)
	db IRON_TAIL    ; TM23 (Jasmine)
	db THUNDERBOLT  ; TM24 (Goldenrod Dept.Store)
	db THUNDER      ; TM25 (Goldenrod Game Corner)
	db EARTHQUAKE   ; TM26 (Victory Road)
	db RETURN       ; TM27 (Goldenrod Dept.Store)
	db DIG          ; TM28 (National Park)
	db PSYCHIC_M    ; TM29 (Sabrina)
	db SHADOW_BALL  ; TM30 (Morty)
	db MUD_SLAP     ; TM31 (Falkner)
	db DOUBLE_TEAM  ; TM32 (Celadon Game Corner)
	db REFLECT      ; TM33 (Goldenrod Dept.Store)
	db SWAGGER      ; TM34 (Olivine Lighthouse)
	db FLAMETHROWER ; TM35 (Goldenrod Dept.Store)
	db SLUDGE_BOMB  ; TM36 (Route 43)
	db SANDSTORM    ; TM37 (Route 27, Celadon Dept.Store)
	db FIRE_BLAST   ; TM38 (Goldenrod Game Corner)
	db SWIFT        ; TM39 (Union Cave)
	db DEFENSE_CURL ; TM40 (Mount Mortar)
	db STONE_EDGE   ; TM41 (Blue)
	db AVALANCHE    ; TM42 (Ice Path)
	db WILD_CHARGE  ; TM43 (Lt.Surge)
	db REST         ; TM44 (Celadon Dept.Store)
	db ATTRACT      ; TM45 (Whitney)
	db THIEF        ; TM46 (Team Rocket Base)
	db STEEL_WING   ; TM47 (Route 28)
	db ROCK_SLIDE   ; TM48 (Brock)
	db FURY_CUTTER  ; TM49 (Bugsy)
	db SUBSTITUTE   ; TM50 (Route 39 Farmhouse)
	db BODY_SLAM    ; TM51 (Fast Ship)
	db FOCUS_BLAST  ; TM52 (Quiet Cave)
	db FLASH_CANNON ; TM53 (Route 9)
	db FALSE_SWIPE  ; TM54 (Goldenrod Dept.Store)
	db SCALD        ; TM55 (Misty)
	db X_SCISSOR    ; TM56 (Underground Warehouse)
	db DARK_PULSE   ; TM57 (Dark Cave)
	db ENDURE       ; TM58 (Burned Tower)
	db DRAGON_PULSE ; TM59 (Route 26)
	db DAZZLINGLEAM ; TM60 (TODO: Valerie)
	db WILL_O_WISP  ; TM61 (Blaine)
	db POISON_JAB   ; TM62 (Janine)
	db THUNDER_WAVE ; TM63 (Rock Tunnel)
	db EXPLOSION    ; TM64 (Underground)
	db SHADOW_CLAW  ; TM65 (Lake of Rage)
	db CUT          ; HM01 (Ilex Forest)
	db FLY          ; HM02 (Cianwood City)
	db SURF         ; HM03 (Ecruteak City)
	db STRENGTH     ; HM04 (Olivine City)
	db FLASH        ; HM05 (Sprout Tower)
	db WHIRLPOOL    ; HM06 (Team Rocket Base)
	db WATERFALL    ; HM07 (Ice Path)
	db ROCK_SMASH   ; HM08 (Route 36)
	db AQUA_TAIL    ; MT01 (TODO)
	db COUNTER      ; MT02 (TODO: Celadon Dept.Store)
	db DOUBLE_EDGE  ; MT03 (TODO: Victory Road)
	db DREAM_EATER  ; MT04 (Viridian City)
	db EARTH_POWER  ; MT05 (TODO)
	db FIRE_PUNCH   ; MT06 (Goldenrod City)
	db HEADBUTT     ; MT07 (Ilex Forest)
	db HYPER_VOICE  ; MT08 (TODO)
	db ICE_PUNCH    ; MT09 (Goldenrod City)
	db IRON_HEAD    ; MT10 (TODO)
	db SEED_BOMB    ; MT11 (TODO)
	db SEISMIC_TOSS ; MT12 (TODO: Pewter City)
	db SLEEP_TALK   ; MT13 (Route 31)
	db THUNDERPUNCH ; MT14 (Goldenrod City)
	db ZAP_CANNON   ; MT15 (Power Plant)
	db ZEN_HEADBUTT ; MT16 (TODO)

	db 0 ; end
; 116b7
