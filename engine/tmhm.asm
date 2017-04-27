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
	dec a ; off by one error?
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
	db CALM_MIND    ; TM04 (Celadon Dept. Store)
	db ROAR         ; TM05 (Route 32)
	db TOXIC        ; TM06 (Celadon Game Corner)
	db HAIL         ; TM07 (Celadon Dept. Store)
	db BULK_UP      ; TM08 (Celadon Dept. Store)
	db SWORDS_DANCE ; TM09 (Celadon Dept. Store)
	db HIDDEN_POWER ; TM10 (Lake of Rage)
	db SUNNY_DAY    ; TM11 (Celadon Dept. Store)
	db HONE_CLAWS   ; TM12 (Route 35)
	db ICE_BEAM     ; TM13 (Goldenrod Game Corner)
	db BLIZZARD     ; TM14 (Goldenrod Dept. Store)
	db HYPER_BEAM   ; TM15 (Goldenrod Dept. Store)
	db LIGHT_SCREEN ; TM16 (Goldenrod Dept. Store)
	db PROTECT      ; TM17 (Goldenrod Dept. Store)
	db RAIN_DANCE   ; TM18 (Celadon Dept. Store)
	db GIGA_DRAIN   ; TM19 (Erika)
	db SAFEGUARD    ; TM20 (Celadon Dept. Store)
	db DRAGONBREATH ; TM21 (Clair)
	db SOLAR_BEAM   ; TM22 (Goldenrod Dept. Store)
	db IRON_TAIL    ; TM23 (Jasmine)
	db THUNDERBOLT  ; TM24 (Goldenrod Game Corner)
	db THUNDER      ; TM25 (Goldenrod Dept. Store)
	db EARTHQUAKE   ; TM26 (Victory Road)
	db RETURN       ; TM27 (Goldenrod Dept. Store)
	db DIG          ; TM28 (National Park)
	db PSYCHIC_M    ; TM29 (Sabrina)
	db SHADOW_BALL  ; TM30 (Morty)
	db MUD_SLAP     ; TM31 (Falkner)
	db DOUBLE_TEAM  ; TM32 (Celadon Game Corner)
	db REFLECT      ; TM33 (Goldenrod Dept. Store)
	db FLASH_CANNON ; TM34 (Route 9)
	db FLAMETHROWER ; TM35 (Goldenrod Game Corner)
	db SLUDGE_BOMB  ; TM36 (Route 43)
	db SANDSTORM    ; TM37 (Celadon Dept. Store)
	db FIRE_BLAST   ; TM38 (Goldenrod Dept. Store)
	db SWIFT        ; TM39 (Union Cave)
	db AERIAL_ACE   ; TM40 (Mount Mortar)
	db STONE_EDGE   ; TM41 (Blue)
	db FACADE       ; TM42 (TODO: Dim Cave)
	db WILD_CHARGE  ; TM43 (Lt. Surge)
	db REST         ; TM44 (Route 27)
	db ATTRACT      ; TM45 (Whitney)
	db THIEF        ; TM46 (Team Rocket Base)
	db STEEL_WING   ; TM47 (Route 28)
	db ROCK_SLIDE   ; TM48 (Brock)
	db FURY_CUTTER  ; TM49 (Bugsy)
	db ROCK_SMASH   ; TM50 (Route 36)
	db LEECH_LIFE   ; TM51 (Yellow Forest)
	db FOCUS_BLAST  ; TM52 (Quiet Cave)
	db ENERGY_BALL  ; TM53 (Olivine Lighthouse)
	db FALSE_SWIPE  ; TM54 (Ilex Forest Gate)
	db SCALD        ; TM55 (Misty)
	db X_SCISSOR    ; TM56 (Underground Warehouse)
	db DARK_PULSE   ; TM57 (Dark Cave)
	db ENDURE       ; TM58 (Burned Tower)
	db DRAGON_PULSE ; TM59 (Route 26)
	db DAZZLINGLEAM ; TM60 (Bellchime Trail)
	db WILL_O_WISP  ; TM61 (Blaine)
	db ACROBATICS   ; TM62 (Route 39 Farmhouse)
	db THUNDER_WAVE ; TM63 (Rock Tunnel)
	db EXPLOSION    ; TM64 (Underground)
	db SHADOW_CLAW  ; TM65 (Lake of Rage)
	db POISON_JAB   ; TM66 (Janine)
	db AVALANCHE    ; TM67 (Pryce)
	db GIGA_IMPACT  ; TM68 (Celadon Game Corner)
	db U_TURN       ; TM69 (Noisy Forest)
	db FLASH        ; TM70 (Sprout Tower)
	db CUT          ; HM01 (Ilex Forest)
	db FLY          ; HM02 (Cianwood City)
	db SURF         ; HM03 (Ecruteak City)
	db STRENGTH     ; HM04 (Olivine City)
	db WHIRLPOOL    ; HM05 (Route 42)
	db WATERFALL    ; HM06 (Ice Path)
	db AQUA_TAIL    ; MT01 (Route 4)
	db BODY_SLAM    ; MT02 (TODO: Warm Beach)
	db COUNTER      ; MT03 (Celadon Dept. Store)
	db DEFENSE_CURL ; MT04 (Mt. Mortar)
	db DOUBLE_EDGE  ; MT05 (Safari Zone)
	db DREAM_EATER  ; MT06 (Viridian City)
	db EARTH_POWER  ; MT07 (Cherrygrove Bay)
	db FIRE_PUNCH   ; MT08 (Goldenrod City)
	db HEADBUTT     ; MT09 (Ilex Forest)
	db HYPER_VOICE  ; MT10 (Goldenrod Harbor)
	db ICE_PUNCH    ; MT11 (Goldenrod City)
	db ICY_WIND     ; MT12 (Ice Path)
	db IRON_HEAD    ; MT13 (Route 4)
	db PAY_DAY      ; MT14 (TODO: Goldenrod Game Corner)
	db ROLLOUT      ; MT15 (Route 46)
	db SEED_BOMB    ; MT16 (Yellow Forest)
	db SEISMIC_TOSS ; MT17 (Pewter City)
	db SLEEP_TALK   ; MT18 (Route 31)
	db SUBSTITUTE   ; MT19 (TODO: Dim Cave)
	db SUCKER_PUNCH ; MT20 (TODO: Scary Cave)
	db SWAGGER      ; MT21 (Celadon City)
	db THUNDERPUNCH ; MT22 (Goldenrod City)
	db VOLT_SWITCH  ; MT23 (Vermilion City)
	db WATER_PULSE  ; MT24 (Battle Tower)
	db ZAP_CANNON   ; MT25 (Power Plant)
	db ZEN_HEADBUTT ; MT26 (Saffron City)

	db 0 ; end
; 116b7
