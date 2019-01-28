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
	ld c, a
	ld a, [wMenuCursorY]
	dec a
	jr z, .by_name
	ld a, c
	pop bc
	ret
.by_name
	ld hl, ItemNameOrder
	ld b, 0
	add hl, bc
	ld a, [hl]
	pop bc
	ret

ItemNameOrder:
	db 0

	db NAM_POKE_BALL    ; 01
	db NAM_GREAT_BALL   ; 02
	db NAM_ULTRA_BALL   ; 03
	db NAM_MASTER_BALL  ; 04

	db NAM_SAFARI_BALL  ; 05

	db NAM_LEVEL_BALL   ; 06
	db NAM_LURE_BALL    ; 07
	db NAM_MOON_BALL    ; 08
	db NAM_FRIEND_BALL  ; 09
	db NAM_FAST_BALL    ; 0a
	db NAM_HEAVY_BALL   ; 0b
	db NAM_LOVE_BALL    ; 0c

	db NAM_PARK_BALL    ; 0d

	db NAM_REPEAT_BALL  ; 0e
	db NAM_TIMER_BALL   ; 0f
	db NAM_NEST_BALL    ; 10
	db NAM_NET_BALL     ; 11
	db NAM_DIVE_BALL    ; 12
	db NAM_LUXURY_BALL  ; 13
	db NAM_HEAL_BALL    ; 14
	db NAM_QUICK_BALL   ; 15
	db NAM_DUSK_BALL    ; 16
	db NAM_PREMIER_BALL ; 17
	db NAM_CHERISH_BALL ; 18

	db NAM_POTION       ; 19
	db NAM_SUPER_POTION ; 1a
	db NAM_HYPER_POTION ; 1b
	db NAM_MAX_POTION   ; 1c

	db NAM_ANTIDOTE     ; 1d
	db NAM_BURN_HEAL    ; 1e
	db NAM_PARALYZEHEAL ; 1f
	db NAM_AWAKENING    ; 20
	db NAM_ICE_HEAL     ; 21
	db NAM_FULL_HEAL    ; 22
	db NAM_FULL_RESTORE ; 23

	db NAM_REVIVE       ; 24
	db NAM_MAX_REVIVE   ; 25

	db NAM_ETHER        ; 26
	db NAM_MAX_ETHER    ; 27
	db NAM_ELIXIR       ; 28
	db NAM_MAX_ELIXIR   ; 29

	db NAM_HP_UP        ; 2a
	db NAM_PROTEIN      ; 2b
	db NAM_IRON         ; 2c
	db NAM_CARBOS       ; 2d
	db NAM_CALCIUM      ; 2e
	db NAM_ZINC         ; 2f
	db NAM_RARE_CANDY   ; 30
	db NAM_PP_UP        ; 31
	db NAM_PP_MAX       ; 32

	db NAM_FRESH_WATER  ; 33
	db NAM_SODA_POP     ; 34
	db NAM_LEMONADE     ; 35
	db NAM_MOOMOO_MILK  ; 36
	db NAM_RAGECANDYBAR ; 37

	db NAM_SACRED_ASH   ; 38
	db NAM_ENERGYPOWDER ; 39
	db NAM_ENERGY_ROOT  ; 3a
	db NAM_HEAL_POWDER  ; 3b
	db NAM_REVIVAL_HERB ; 3c

	db NAM_X_ATTACK     ; 3d
	db NAM_X_DEFEND     ; 3e
	db NAM_X_SPEED      ; 3f
	db NAM_X_SPCL_ATK   ; 40
	db NAM_X_SPCL_DEF   ; 41
	db NAM_X_ACCURACY   ; 42
	db NAM_DIRE_HIT     ; 43
	db NAM_GUARD_SPEC   ; 44

	db NAM_REPEL        ; 45
	db NAM_SUPER_REPEL  ; 46
	db NAM_MAX_REPEL    ; 47
	db NAM_ESCAPE_ROPE  ; 48
	db NAM_POKE_DOLL    ; 49

	db NAM_ABILITY_CAP  ; 4a

	db NAM_LEAF_STONE   ; 4b
	db NAM_FIRE_STONE   ; 4c
	db NAM_WATER_STONE  ; 4d
	db NAM_THUNDERSTONE ; 4e
	db NAM_MOON_STONE   ; 4f
	db NAM_SUN_STONE    ; 50
	db NAM_DUSK_STONE   ; 51
	db NAM_SHINY_STONE  ; 52
	db NAM_ICE_STONE    ; 53
	db NAM_EVERSTONE    ; 54

	db NAM_BICYCLE      ; 55
	db NAM_OLD_ROD      ; 56
	db NAM_GOOD_ROD     ; 57
	db NAM_SUPER_ROD    ; 58
	db NAM_COIN_CASE    ; 59
	db NAM_ITEMFINDER   ; 5a
	db NAM_EXP_SHARE    ; 5b
	db NAM_MYSTERY_EGG  ; 5c
	db NAM_SQUIRTBOTTLE ; 5d
	db NAM_SECRETPOTION ; 5e
	db NAM_RED_SCALE    ; 5f
	db NAM_CARD_KEY     ; 60
	db NAM_BASEMENT_KEY ; 61
	db NAM_S_S_TICKET   ; 62
	db NAM_PASS         ; 63
	db NAM_MACHINE_PART ; 64
	db NAM_LOST_ITEM    ; 65
	db NAM_RAINBOW_WING ; 66
	db NAM_SILVER_WING  ; 67
	db NAM_CLEAR_BELL   ; 68
	db NAM_GS_BALL      ; 69
	db NAM_BLUE_CARD    ; 6a
	db NAM_ORANGETICKET ; 6b
	db NAM_MYSTICTICKET ; 6c
	db NAM_OLD_SEA_MAP  ; 6d
	db NAM_SHINY_CHARM  ; 6e
	db NAM_OVAL_CHARM   ; 6f
	db NAM_SILPHSCOPE2  ; 70
	db NAM_APRICORN_BOX ; 71

	db NAM_TERU_SAMA    ; 72

	db NAM_CHERI_BERRY  ; 73
	db NAM_CHESTO_BERRY ; 74
	db NAM_PECHA_BERRY  ; 75
	db NAM_RAWST_BERRY  ; 76
	db NAM_ASPEAR_BERRY ; 77
	db NAM_LEPPA_BERRY  ; 78
	db NAM_ORAN_BERRY   ; 79
	db NAM_PERSIM_BERRY ; 7a
	db NAM_LUM_BERRY    ; 7b
	db NAM_SITRUS_BERRY ; 7c
	db NAM_FIGY_BERRY   ; 7d
	db NAM_LIECHI_BERRY ; 7e
	db NAM_GANLON_BERRY ; 7f
	db NAM_SALAC_BERRY  ; 80
	db NAM_PETAYA_BERRY ; 81
	db NAM_APICOT_BERRY ; 82
	db NAM_JABOCA_BERRY ; 83
	db NAM_ROWAP_BERRY  ; 84
	db NAM_KEE_BERRY    ; 85
	db NAM_MARANGABERRY ; 86

	db NAM_PEWTERCRUNCH ; 87

	db NAM_SILK_SCARF   ; 88
	db NAM_BLACK_BELT   ; 89
	db NAM_SHARP_BEAK   ; 8a
	db NAM_POISON_BARB  ; 8b
	db NAM_SOFT_SAND    ; 8c
	db NAM_HARD_STONE   ; 8d
	db NAM_SILVERPOWDER ; 8e
	db NAM_SPELL_TAG    ; 8f
	db NAM_METAL_COAT   ; 90
	db NAM_CHARCOAL     ; 91
	db NAM_MYSTIC_WATER ; 92
	db NAM_MIRACLE_SEED ; 93
	db NAM_MAGNET       ; 94
	db NAM_TWISTEDSPOON ; 95
	db NAM_NEVERMELTICE ; 96
	db NAM_DRAGON_FANG  ; 97
	db NAM_BLACKGLASSES ; 98
	db NAM_PINK_BOW     ; 99

	db NAM_BRIGHTPOWDER ; 9a
	db NAM_SCOPE_LENS   ; 9b
	db NAM_QUICK_CLAW   ; 9c
	db NAM_KINGS_ROCK   ; 9d
	db NAM_FOCUS_BAND   ; 9e
	db NAM_LEFTOVERS    ; 9f
	db NAM_LUCKY_EGG    ; a0
	db NAM_AMULET_COIN  ; a1
	db NAM_CLEANSE_TAG  ; a2
	db NAM_SMOKE_BALL   ; a3
	db NAM_BERSERK_GENE ; a4

	db NAM_LIGHT_BALL   ; a5
	db NAM_STICK        ; a6
	db NAM_THICK_CLUB   ; a7
	db NAM_LUCKY_PUNCH  ; a8
	db NAM_METAL_POWDER ; a9
	db NAM_QUICK_POWDER ; aa
	db NAM_ARMOR_SUIT   ; ab

	db NAM_AIR_BALLOON  ; ac
	db NAM_ASSAULT_VEST ; ad
	db NAM_BIG_ROOT     ; ae
	db NAM_BINDING_BAND ; af
	db NAM_DESTINY_KNOT ; b0
	db NAM_EVIOLITE     ; b1
	db NAM_EXPERT_BELT  ; b2
	db NAM_FOCUS_SASH   ; b3
	db NAM_GRIP_CLAW    ; b4
	db NAM_LIFE_ORB     ; b5
	db NAM_LIGHT_CLAY   ; b6
	db NAM_METRONOME_I  ; b7
	db NAM_MUSCLE_BAND  ; b8
	db NAM_PROTECT_PADS ; b9
	db NAM_ROCKY_HELMET ; ba
	db NAM_SAFE_GOGGLES ; bb
	db NAM_SHED_SHELL   ; bc
	db NAM_SHELL_BELL   ; bd
	db NAM_SOOTHE_BELL  ; be
	db NAM_WEAK_POLICY  ; bf
	db NAM_WIDE_LENS    ; c0
	db NAM_WISE_GLASSES ; c1
	db NAM_ZOOM_LENS    ; c2

	db NAM_MENTAL_HERB  ; c3
	db NAM_POWER_HERB   ; c4
	db NAM_WHITE_HERB   ; c5

	db NAM_DAMP_ROCK    ; c6
	db NAM_HEAT_ROCK    ; c7
	db NAM_SMOOTH_ROCK  ; c8
	db NAM_ICY_ROCK     ; c9

	db NAM_CHOICE_BAND  ; ca
	db NAM_CHOICE_SCARF ; cb
	db NAM_CHOICE_SPECS ; cc

	db NAM_FLAME_ORB    ; cd
	db NAM_TOXIC_ORB    ; ce
	db NAM_BLACK_SLUDGE ; cf

	db NAM_MACHO_BRACE  ; d0
	db NAM_POWER_WEIGHT ; d1
	db NAM_POWER_BRACER ; d2
	db NAM_POWER_BELT   ; d3
	db NAM_POWER_LENS   ; d4
	db NAM_POWER_BAND   ; d5
	db NAM_POWER_ANKLET ; d6

	db NAM_DRAGON_SCALE ; d7
	db NAM_UP_GRADE     ; d8
	db NAM_DUBIOUS_DISC ; d9
	db NAM_PROTECTOR    ; da
	db NAM_ELECTIRIZER  ; db
	db NAM_MAGMARIZER   ; dc
	db NAM_RAZOR_FANG   ; dd
	db NAM_RAZOR_CLAW   ; de
	db NAM_ODD_SOUVENIR ; df

	db NAM_NUGGET       ; e0
	db NAM_BIG_NUGGET   ; e1
	db NAM_TINYMUSHROOM ; e2
	db NAM_BIG_MUSHROOM ; e3
	db NAM_BALMMUSHROOM ; e4
	db NAM_PEARL        ; e5
	db NAM_BIG_PEARL    ; e6
	db NAM_PEARL_STRING ; e7
	db NAM_STARDUST     ; e8
	db NAM_STAR_PIECE   ; e9
	db NAM_BRICK_PIECE  ; ea
	db NAM_RARE_BONE    ; eb
	db NAM_SILVER_LEAF  ; ec
	db NAM_GOLD_LEAF    ; ed
	db NAM_SLOWPOKETAIL ; ee
	db NAM_BOTTLE_CAP   ; ef

	db NAM_HELIX_FOSSIL ; f0
	db NAM_DOME_FOSSIL  ; f1
	db NAM_OLD_AMBER    ; f2

	db NAM_MULCH        ; f3
	db NAM_SWEET_HONEY  ; f4

	db NAM_FLOWER_MAIL  ; f5
	db NAM_SURF_MAIL    ; f6
	db NAM_LITEBLUEMAIL ; f7
	db NAM_PORTRAITMAIL ; f8
	db NAM_LOVELY_MAIL  ; f9
	db NAM_EON_MAIL     ; fa
	db NAM_MORPH_MAIL   ; fb
	db NAM_BLUESKY_MAIL ; fc
	db NAM_MUSIC_MAIL   ; fd
	db NAM_MIRAGE_MAIL  ; fe
	db -1
