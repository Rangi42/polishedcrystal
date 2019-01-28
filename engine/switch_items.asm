SwitchItemsInBag:
	ld a, [wSwitchItem]
	and a
	jr nz, .completeItemSwitch
	ld a, [wScrollingMenuCursorPosition]
	inc a
	ld [wSwitchItem], a
	ret
.completeItemSwitch
	ld b, a
	ld a, [wScrollingMenuCursorPosition]
	inc a
	cp b
	jr nz, .notSwappingItemWithItself
	xor a
	ld [wSwitchItem], a
	ret
.notSwappingItemWithItself
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	ld a, [hl]
	inc a
	ret z
	ld a, [wSwitchItem]
	dec a
	ld [wSwitchItem], a
	call TryCombiningSwitchItems
	jp c, CombineSwitchItems
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld a, [wSwitchItem]
	cp c
	jr c, .insertItemAbove
	call GetSwitchItemDestinationOffset
	push bc
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	dec hl
	push hl
	call ItemSwitch_ConvertSpacingToDW
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	call SwitchItems_BackwardsCopy
	ld a, [wScrollingMenuCursorPosition]
	call CopyBufferedSwitchItemToScrollLocation
	xor a
	ld [wSwitchItem], a
	ret

.insertItemAbove
	call GetSwitchItemDestinationOffset
	push bc
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	call ItemSwitch_ConvertSpacingToDW
	add hl, bc
	pop bc
	call CopyBytes
	ld a, [wScrollingMenuCursorPosition]
	call CopyBufferedSwitchItemToScrollLocation
	xor a
	ld [wSwitchItem], a
	ret

TryCombiningSwitchItems:
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	ld a, [de]
	cp [hl]
	jr nz, .doNotCombineSwitchItems
	ld a, [wMenuData2_ScrollingMenuSpacing]
	cp 2
	jr nz, .doNotCombineSwitchItems
	ld a, [wScrollingMenuCursorPosition]
	call GetQuantityOfSwitchItem
	cp 99
	jr z, .doNotCombineSwitchItems
	ld a, [wSwitchItem]
	call GetQuantityOfSwitchItem
	cp 99
	jr nz, .combineSwitchItems
.doNotCombineSwitchItems
	and a
	ret

.combineSwitchItems
	scf
	ret

CombineSwitchItems:
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	inc hl
	push hl
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	ld a, [hl]
	pop hl
	add [hl]
	cp 100
	jr c, .mergeItemStacks
	sub 99
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	ld [hl], 99
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	inc hl
	pop af
	ld [hl], a
	xor a
	ld [wSwitchItem], a
	ret

.mergeItemStacks
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	pop af
	ld [hl], a
	ld hl, wMenuData2_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSwitchItem]
	cp [hl]
	jr nz, .notCombiningLastItem
	dec [hl]
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	ld [hl], $ff
	xor a
	ld [wSwitchItem], a
	ret

.notCombiningLastItem
	dec [hl]
	call ItemSwitch_ConvertSpacingToDW
	push bc
	ld a, [wSwitchItem]
	call ItemSwitch_GetNthItem
	pop bc
	push hl
	add hl, bc
	pop de
.shiftInventoryAboveLoop
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .shiftInventoryAboveLoop
	xor a
	ld [wSwitchItem], a
	ret

CopySwitchItemToBuffer:
	call ItemSwitch_GetNthItem
	ld de, wd002
	call ItemSwitch_ConvertSpacingToDW
	jp CopyBytes

CopyBufferedSwitchItemToScrollLocation:
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	ld hl, wd002
	call ItemSwitch_ConvertSpacingToDW
	jp CopyBytes

ItemSwitch_GetNthItem:
	ld c, a
	ld b, 0
	ld hl, wMenuData2_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [wMenuData2_ScrollingMenuSpacing]
	jp AddNTimes

GetSwitchItemDestinationOffset:
	ld a, [wSwitchItem]
	call CopySwitchItemToBuffer
	push hl
	call ItemSwitch_ConvertSpacingToDW
	ld a, [wSwitchItem]
	ld e, a
	ld a, [wScrollingMenuCursorPosition]
	sub e
	jr nc, .dont_negate
	dec a
	cpl
.dont_negate
	ld hl, 0
	call AddNTimes
	ld b, h
	ld c, l
	pop hl
	ret

ItemSwitch_ConvertSpacingToDW:
	ld a, [wMenuData2_ScrollingMenuSpacing]
	ld c, a
	ld b, 0
	ret

GetQuantityOfSwitchItem:
	call ItemSwitch_GetNthItem
	inc hl
	ld a, [hl]
	ret

SwitchItems_BackwardsCopy:
.loop
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

SortItemsInBag:
; Sorts items in the bag.
; wMenuCursorY=1: by name
; wMenuCursorY=2: by type (index order)
	ld a, [wScrollingMenuCursorPosition]
	push af
	xor a
	ld b, a
.loop
	ld a, b
	call GetSortingItemIndex
	ld c, a
	inc a
	jr z, .done
	ld a, b
	inc a
	call GetSortingItemIndex
	inc a
	jr z, .done
	dec a
	cp c
	jr nc, .sort_ok
	push bc
	ld a, b
	ld [wScrollingMenuCursorPosition], a
	call SwitchItemsInBag
	ld [wScrollingMenuCursorPosition], a
	call SwitchItemsInBag
	pop bc
	ld a, b
	and a
	jr z, .loop
	dec b
	jr .loop
.sort_ok
	inc b
	jr .loop
.done
	pop af
	ld [wScrollingMenuCursorPosition], a
	ret

GetSortingItemIndex:
	push bc
	call ItemSwitch_GetNthItem
	ld a, [hl]
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	jr z, .by_name
	ld a, b
	pop bc
	ret
.by_name
	ld hl, ItemNameOrder
	ld c, 0
.loop
	ld a, [hli]
	cp b
	jr z, .got_name_index
	inc c
	jr .loop
.got_name_index
	ld a, c
	pop bc
	ret

ItemNameOrder:
	db NO_ITEM
	db ABILITY_CAP  ; 4a
	db AIR_BALLOON  ; ac
	db AMULET_COIN  ; a1
	db ANTIDOTE     ; 1d
	db APICOT_BERRY ; 82
	db APRICORN_BOX ; 71
	db ARMOR_SUIT   ; ab
	db ASPEAR_BERRY ; 77
	db ASSAULT_VEST ; ad
	db AWAKENING    ; 20
	db BALMMUSHROOM ; e4
	db BASEMENT_KEY ; 61
	db BERSERK_GENE ; a4
	db BICYCLE      ; 55
	db BIG_MUSHROOM ; e3
	db BIG_NUGGET   ; e1
	db BIG_PEARL    ; e6
	db BIG_ROOT     ; ae
	db BINDING_BAND ; af
	db BLACK_BELT   ; 89
	db BLACK_SLUDGE ; cf
	db BLACKGLASSES ; 98
	db BLUE_CARD    ; 6a
	db BLUESKY_MAIL ; fc
	db BOTTLE_CAP   ; ef
	db BRICK_PIECE  ; ea
	db BRIGHTPOWDER ; 9a
	db BURN_HEAL    ; 1e
	db CALCIUM      ; 2e
	db CARBOS       ; 2d
	db CARD_KEY     ; 60
	db CHARCOAL     ; 91
	db CHERI_BERRY  ; 73
	db CHERISH_BALL ; 18
	db CHESTO_BERRY ; 74
	db CHOICE_BAND  ; ca
	db CHOICE_SCARF ; cb
	db CHOICE_SPECS ; cc
	db CLEANSE_TAG  ; a2
	db CLEAR_BELL   ; 68
	db COIN_CASE    ; 59
	db DAMP_ROCK    ; c6
	db DESTINY_KNOT ; b0
	db DIRE_HIT     ; 43
	db DIVE_BALL    ; 12
	db DOME_FOSSIL  ; f1
	db DRAGON_FANG  ; 97
	db DRAGON_SCALE ; d7
	db DUBIOUS_DISC ; d9
	db DUSK_BALL    ; 16
	db DUSK_STONE   ; 51
	db ELECTIRIZER  ; db
	db ELIXER       ; 28
	db ENERGY_ROOT  ; 3a
	db ENERGYPOWDER ; 39
	db EON_MAIL     ; fa
	db ESCAPE_ROPE  ; 48
	db ETHER        ; 26
	db EVERSTONE    ; 54
	db EVIOLITE     ; b1
	db EXP_SHARE    ; 5b
	db EXPERT_BELT  ; b2
	db FAST_BALL    ; 0a
	db FIGY_BERRY   ; 7d
	db FIRE_STONE   ; 4c
	db FLAME_ORB    ; cd
	db FLOWER_MAIL  ; f5
	db FOCUS_BAND   ; 9e
	db FOCUS_SASH   ; b3
	db FRESH_WATER  ; 33
	db FRIEND_BALL  ; 09
	db FULL_HEAL    ; 22
	db FULL_RESTORE ; 23
	db GANLON_BERRY ; 7f
	db GOLD_LEAF    ; ed
	db GOOD_ROD     ; 57
	db GREAT_BALL   ; 02
	db GRIP_CLAW    ; b4
	db GS_BALL      ; 69
	db GUARD_SPEC   ; 44
	db HARD_STONE   ; 8d
	db HEAL_BALL    ; 14
	db HEAL_POWDER  ; 3b
	db HEAT_ROCK    ; c7
	db HEAVY_BALL   ; 0b
	db HELIX_FOSSIL ; f0
	db HP_UP        ; 2a
	db HYPER_POTION ; 1b
	db ICE_HEAL     ; 21
	db ICE_STONE    ; 53
	db ICY_ROCK     ; c9
	db IRON         ; 2c
	db ITEMFINDER   ; 5a
	db JABOCA_BERRY ; 83
	db KEE_BERRY    ; 85
	db KINGS_ROCK   ; 9d
	db LEAF_STONE   ; 4b
	db LEFTOVERS    ; 9f
	db LEMONADE     ; 35
	db LEPPA_BERRY  ; 78
	db LEVEL_BALL   ; 06
	db LIECHI_BERRY ; 7e
	db LIFE_ORB     ; b5
	db LIGHT_BALL   ; a5
	db LIGHT_CLAY   ; b6
	db LITEBLUEMAIL ; f7
	db LOST_ITEM    ; 65
	db LOVE_BALL    ; 0c
	db LOVELY_MAIL  ; f9
	db LUCKY_EGG    ; a0
	db LUCKY_PUNCH  ; a8
	db LUM_BERRY    ; 7b
	db LURE_BALL    ; 07
	db LUXURY_BALL  ; 13
	db MACHINE_PART ; 64
	db MACHO_BRACE  ; d0
	db MAGMARIZER   ; dc
	db MAGNET       ; 94
	db MARANGABERRY ; 86
	db MASTER_BALL  ; 04
	db MAX_ELIXER   ; 29
	db MAX_ETHER    ; 27
	db MAX_POTION   ; 1c
	db MAX_REPEL    ; 47
	db MAX_REVIVE   ; 25
	db MENTAL_HERB  ; c3
	db METAL_COAT   ; 90
	db METAL_POWDER ; a9
	db METRONOME_I  ; b7
	db MIRACLE_SEED ; 93
	db MIRAGE_MAIL  ; fe
	db MOOMOO_MILK  ; 36
	db MOON_BALL    ; 08
	db MOON_STONE   ; 4f
	db MORPH_MAIL   ; fb
	db MULCH        ; f3
	db MUSCLE_BAND  ; b8
	db MUSIC_MAIL   ; fd
	db MYSTERY_EGG  ; 5c
	db MYSTIC_WATER ; 92
	db MYSTICTICKET ; 6c
	db NEST_BALL    ; 10
	db NET_BALL     ; 11
	db NEVERMELTICE ; 96
	db NUGGET       ; e0
	db ODD_SOUVENIR ; df
	db OLD_AMBER    ; f2
	db OLD_ROD      ; 56
	db OLD_SEA_MAP  ; 6d
	db ORAN_BERRY   ; 79
	db ORANGETICKET ; 6b
	db OVAL_CHARM   ; 6f
	db PARLYZ_HEAL  ; 1f
	db PARK_BALL    ; 0d
	db PASS         ; 63
	db PEARL        ; e5
	db PEARL_STRING ; e7
	db PECHA_BERRY  ; 75
	db PERSIM_BERRY ; 7a
	db PETAYA_BERRY ; 81
	db PEWTERCRUNCH ; 87
	db PINK_BOW     ; 99
	db POISON_BARB  ; 8b
	db POKE_BALL    ; 01
	db POKE_DOLL    ; 49
	db PORTRAITMAIL ; f8
	db POTION       ; 19
	db POWER_ANKLET ; d6
	db POWER_BAND   ; d5
	db POWER_BELT   ; d3
	db POWER_BRACER ; d2
	db POWER_HERB   ; c4
	db POWER_LENS   ; d4
	db POWER_WEIGHT ; d1
	db PP_MAX       ; 32
	db PP_UP        ; 31
	db PREMIER_BALL ; 17
	db PROTECT_PADS ; b9
	db PROTECTOR    ; da
	db PROTEIN      ; 2b
	db QUICK_BALL   ; 15
	db QUICK_CLAW   ; 9c
	db QUICK_POWDER ; aa
	db RAGECANDYBAR ; 37
	db RAINBOW_WING ; 66
	db RARE_BONE    ; eb
	db RARE_CANDY   ; 30
	db RAWST_BERRY  ; 76
	db RAZOR_CLAW   ; de
	db RAZOR_FANG   ; dd
	db RED_SCALE    ; 5f
	db REPEAT_BALL  ; 0e
	db REPEL        ; 45
	db REVIVAL_HERB ; 3c
	db REVIVE       ; 24
	db ROCKY_HELMET ; ba
	db ROWAP_BERRY  ; 84
	db S_S_TICKET   ; 62
	db SACRED_ASH   ; 38
	db SAFARI_BALL  ; 05
	db SAFE_GOGGLES ; bb
	db SALAC_BERRY  ; 80
	db SCOPE_LENS   ; 9b
	db SECRETPOTION ; 5e
	db SHARP_BEAK   ; 8a
	db SHED_SHELL   ; bc
	db SHELL_BELL   ; bd
	db SHINY_CHARM  ; 6e
	db SHINY_STONE  ; 52
	db SILK_SCARF   ; 88
	db SILPHSCOPE2  ; 70
	db SILVER_LEAF  ; ec
	db SILVER_WING  ; 67
	db SILVERPOWDER ; 8e
	db SITRUS_BERRY ; 7c
	db SLOWPOKETAIL ; ee
	db SMOKE_BALL   ; a3
	db SMOOTH_ROCK  ; c8
	db SODA_POP     ; 34
	db SOFT_SAND    ; 8c
	db SOOTHE_BELL  ; be
	db SPELL_TAG    ; 8f
	db SQUIRTBOTTLE ; 5d
	db STAR_PIECE   ; e9
	db STARDUST     ; e8
	db STICK        ; a6
	db SUN_STONE    ; 50
	db SUPER_POTION ; 1a
	db SUPER_REPEL  ; 46
	db SUPER_ROD    ; 58
	db SURF_MAIL    ; f6
	db SWEET_HONEY  ; f4
	db TERU_SAMA    ; 72
	db THICK_CLUB   ; a7
	db THUNDERSTONE ; 4e
	db TIMER_BALL   ; 0f
	db TINYMUSHROOM ; e2
	db TOXIC_ORB    ; ce
	db TWISTEDSPOON ; 95
	db ULTRA_BALL   ; 03
	db UP_GRADE     ; d8
	db WATER_STONE  ; 4d
	db WEAK_POLICY  ; bf
	db WIDE_LENS    ; c0
	db WISE_GLASSES ; c1
	db WHITE_HERB   ; c5
	db X_ACCURACY   ; 42
	db X_ATTACK     ; 3d
	db X_DEFEND     ; 3e
	db X_SPCL_ATK   ; 40
	db X_SPCL_DEF   ; 41
	db X_SPEED      ; 3f
	db ZINC         ; 2f
	db ZOOM_LENS    ; c2
	db -1
