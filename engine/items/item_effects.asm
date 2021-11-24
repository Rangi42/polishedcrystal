_DoItemEffect::
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	call GetItemName
	call CopyName1
	ld a, 1
	ld [wItemEffectSucceeded], a
	ld a, [wCurItem]
	call StackJumpTable

ItemEffects:
; entries correspond to item ids (see constants/item_constants.asm)
	table_width 2, ItemEffects
	dw PokeBallEffect     ; PARK_BALL
	dw PokeBallEffect     ; POKE_BALL
	dw PokeBallEffect     ; GREAT_BALL
	dw PokeBallEffect     ; ULTRA_BALL
	dw PokeBallEffect     ; MASTER_BALL
	dw PokeBallEffect     ; SAFARI_BALL
	dw PokeBallEffect     ; LEVEL_BALL
	dw PokeBallEffect     ; LURE_BALL
	dw PokeBallEffect     ; MOON_BALL
	dw PokeBallEffect     ; FRIEND_BALL
	dw PokeBallEffect     ; FAST_BALL
	dw PokeBallEffect     ; HEAVY_BALL
	dw PokeBallEffect     ; LOVE_BALL
	dw AbilityPatch       ; ABILITYPATCH
	dw PokeBallEffect     ; REPEAT_BALL
	dw PokeBallEffect     ; TIMER_BALL
	dw PokeBallEffect     ; NEST_BALL
	dw PokeBallEffect     ; NET_BALL
	dw PokeBallEffect     ; DIVE_BALL
	dw PokeBallEffect     ; LUXURY_BALL
	dw PokeBallEffect     ; HEAL_BALL
	dw PokeBallEffect     ; QUICK_BALL
	dw PokeBallEffect     ; DUSK_BALL
	dw PokeBallEffect     ; DREAM_BALL
	dw PokeBallEffect     ; PREMIER_BALL
	dw PokeBallEffect     ; CHERISH_BALL
	dw RestoreHPEffect    ; POTION
	dw RestoreHPEffect    ; SUPER_POTION
	dw RestoreHPEffect    ; HYPER_POTION
	dw RestoreHPEffect    ; MAX_POTION
	dw HealStatusEffect   ; ANTIDOTE
	dw HealStatusEffect   ; BURN_HEAL
	dw HealStatusEffect   ; PARALYZEHEAL
	dw HealStatusEffect   ; AWAKENING
	dw HealStatusEffect   ; ICE_HEAL
	dw HealStatusEffect   ; FULL_HEAL
	dw FullRestore        ; FULL_RESTORE
	dw ReviveEffect       ; REVIVE
	dw ReviveEffect       ; MAX_REVIVE
	dw RestorePPEffect    ; ETHER
	dw RestorePPEffect    ; MAX_ETHER
	dw RestorePPEffect    ; ELIXIR
	dw RestorePPEffect    ; MAX_ELIXIR
	dw VitaminEffect      ; HP_UP
	dw VitaminEffect      ; PROTEIN
	dw VitaminEffect      ; IRON
	dw VitaminEffect      ; CARBOS
	dw VitaminEffect      ; CALCIUM
	dw VitaminEffect      ; ZINC
	dw RareCandy          ; RARE_CANDY
	dw RestorePPEffect    ; PP_UP
	dw RestorePPEffect    ; PP_MAX
	dw RestoreHPEffect    ; FRESH_WATER
	dw RestoreHPEffect    ; SODA_POP
	dw RestoreHPEffect    ; LEMONADE
	dw RestoreHPEffect    ; MOOMOO_MILK
	dw HealStatusEffect   ; RAGECANDYBAR
	dw HealStatusEffect   ; PEWTERCRUNCH
	dw SacredAsh          ; SACRED_ASH
	dw EnergyPowder       ; ENERGYPOWDER
	dw EnergyRoot         ; ENERGY_ROOT
	dw HealPowder         ; HEAL_POWDER
	dw RevivalHerb        ; REVIVAL_HERB
	dw XItemEffect        ; X_ATTACK
	dw XItemEffect        ; X_DEFEND
	dw XItemEffect        ; X_SPEED
	dw XItemEffect        ; X_SPCL_ATK
	dw XItemEffect        ; X_SPCL_DEF
	dw XItemEffect        ; X_ACCURACY
	dw DireHit            ; DIRE_HIT
	dw GuardSpec          ; GUARD_SPEC
	dw RepelEffect        ; REPEL
	dw RepelEffect        ; SUPER_REPEL
	dw RepelEffect        ; MAX_REPEL
	dw EscapeRope         ; ESCAPE_ROPE
	dw PokeDoll           ; POKE_DOLL
	dw AbilityCap         ; ABILITY_CAP
	dw EvoStoneEffect     ; LEAF_STONE
	dw EvoStoneEffect     ; FIRE_STONE
	dw EvoStoneEffect     ; WATER_STONE
	dw EvoStoneEffect     ; THUNDERSTONE
	dw EvoStoneEffect     ; MOON_STONE
	dw EvoStoneEffect     ; SUN_STONE
	dw EvoStoneEffect     ; DUSK_STONE
	dw EvoStoneEffect     ; DAWN_STONE
	dw EvoStoneEffect     ; SHINY_STONE
	dw EvoStoneEffect     ; ICE_STONE
	dw IsntTheTimeMessage ; EVERSTONE
	dw IsntTheTimeMessage ; EXP_SHARE
	dw HealStatusEffect   ; CHERI_BERRY
	dw HealStatusEffect   ; CHESTO_BERRY
	dw HealStatusEffect   ; PECHA_BERRY
	dw HealStatusEffect   ; RAWST_BERRY
	dw HealStatusEffect   ; ASPEAR_BERRY
	dw RestorePPEffect    ; LEPPA_BERRY
	dw RestoreHPEffect    ; ORAN_BERRY
	dw PersimBerry        ; PERSIM_BERRY
	dw HealStatusEffect   ; LUM_BERRY
	dw RestoreHPEffect    ; SITRUS_BERRY
	dw RestoreHPEffect    ; FIGY_BERRY
	dw LowerEVBerry       ; POMEG_BERRY
	dw LowerEVBerry       ; KELPSY_BERRY
	dw LowerEVBerry       ; QUALOT_BERRY
	dw LowerEVBerry       ; HONDEW_BERRY
	dw LowerEVBerry       ; GREPA_BERRY
	dw LowerEVBerry       ; TAMATO_BERRY
	dw IsntTheTimeMessage ; LIECHI_BERRY
	dw IsntTheTimeMessage ; GANLON_BERRY
	dw IsntTheTimeMessage ; SALAC_BERRY
	dw IsntTheTimeMessage ; PETAYA_BERRY
	dw IsntTheTimeMessage ; APICOT_BERRY
	dw IsntTheTimeMessage ; LANSAT_BERRY
	dw IsntTheTimeMessage ; STARF_BERRY
	dw IsntTheTimeMessage ; ENIGMA_BERRY
	dw IsntTheTimeMessage ; CUSTAP_BERRY
	dw IsntTheTimeMessage ; JABOCA_BERRY
	dw IsntTheTimeMessage ; ROWAP_BERRY
	dw IsntTheTimeMessage ; KEE_BERRY
	dw IsntTheTimeMessage ; MARANGABERRY
	dw RestoreHPEffect    ; BERRY_JUICE
	dw IsntTheTimeMessage ; SILK_SCARF
	dw IsntTheTimeMessage ; BLACK_BELT
	dw IsntTheTimeMessage ; SHARP_BEAK
	dw IsntTheTimeMessage ; POISON_BARB
	dw IsntTheTimeMessage ; SOFT_SAND
	dw IsntTheTimeMessage ; HARD_STONE
	dw IsntTheTimeMessage ; SILVERPOWDER
	dw IsntTheTimeMessage ; SPELL_TAG
	dw IsntTheTimeMessage ; METAL_COAT
	dw IsntTheTimeMessage ; CHARCOAL
	dw IsntTheTimeMessage ; MYSTIC_WATER
	dw IsntTheTimeMessage ; MIRACLE_SEED
	dw IsntTheTimeMessage ; MAGNET
	dw IsntTheTimeMessage ; TWISTEDSPOON
	dw IsntTheTimeMessage ; NEVERMELTICE
	dw IsntTheTimeMessage ; DRAGON_FANG
	dw IsntTheTimeMessage ; BLACKGLASSES
	dw IsntTheTimeMessage ; PINK_BOW
	dw IsntTheTimeMessage ; BRIGHTPOWDER
	dw IsntTheTimeMessage ; SCOPE_LENS
	dw IsntTheTimeMessage ; QUICK_CLAW
	dw IsntTheTimeMessage ; KINGS_ROCK
	dw IsntTheTimeMessage ; FOCUS_BAND
	dw IsntTheTimeMessage ; LEFTOVERS
	dw IsntTheTimeMessage ; LUCKY_EGG
	dw IsntTheTimeMessage ; AMULET_COIN
	dw IsntTheTimeMessage ; CLEANSE_TAG
	dw IsntTheTimeMessage ; SMOKE_BALL
	dw IsntTheTimeMessage ; BERSERK_GENE
	dw IsntTheTimeMessage ; LIGHT_BALL
	dw IsntTheTimeMessage ; STICK
	dw IsntTheTimeMessage ; THICK_CLUB
	dw IsntTheTimeMessage ; LUCKY_PUNCH
	dw IsntTheTimeMessage ; METAL_POWDER
	dw IsntTheTimeMessage ; QUICK_POWDER
	dw IsntTheTimeMessage ; ARMOR_SUIT
	dw IsntTheTimeMessage ; AIR_BALLOON
	dw IsntTheTimeMessage ; ASSAULT_VEST
	dw IsntTheTimeMessage ; BIG_ROOT
	dw IsntTheTimeMessage ; BINDING_BAND
	dw IsntTheTimeMessage ; DESTINY_KNOT
	dw IsntTheTimeMessage ; EVIOLITE
	dw IsntTheTimeMessage ; EXPERT_BELT
	dw IsntTheTimeMessage ; FOCUS_SASH
	dw IsntTheTimeMessage ; GRIP_CLAW
	dw IsntTheTimeMessage ; LIFE_ORB
	dw IsntTheTimeMessage ; LIGHT_CLAY
	dw IsntTheTimeMessage ; METRONOME_I
	dw IsntTheTimeMessage ; MUSCLE_BAND
	dw IsntTheTimeMessage ; PROTECT_PADS
	dw IsntTheTimeMessage ; ROCKY_HELMET
	dw IsntTheTimeMessage ; SAFE_GOGGLES
	dw IsntTheTimeMessage ; SHED_SHELL
	dw IsntTheTimeMessage ; SHELL_BELL
	dw IsntTheTimeMessage ; SOOTHE_BELL
	dw IsntTheTimeMessage ; WEAK_POLICY
	dw IsntTheTimeMessage ; WIDE_LENS
	dw IsntTheTimeMessage ; WISE_GLASSES
	dw IsntTheTimeMessage ; ZOOM_LENS
	dw IsntTheTimeMessage ; EJECT_BUTTON
	dw IsntTheTimeMessage ; LAGGING_TAIL
	dw IsntTheTimeMessage ; IRON_BALL
	dw IsntTheTimeMessage ; RING_TARGET
	dw IsntTheTimeMessage ; RED_CARD
	dw IsntTheTimeMessage ; ABSORB_BULB
	dw IsntTheTimeMessage ; CELL_BATTERY
	dw IsntTheTimeMessage ; LUMINOUSMOSS
	dw IsntTheTimeMessage ; SNOWBALL
	dw IsntTheTimeMessage ; EJECT_PACK
	dw IsntTheTimeMessage ; ROOM_SERVICE
	dw IsntTheTimeMessage ; BLUNDRPOLICY
	dw IsntTheTimeMessage ; THROAT_SPRAY
	dw IsntTheTimeMessage ; HEAVY_BOOTS
	dw IsntTheTimeMessage ; UTILUMBRELLA
	dw IsntTheTimeMessage ; MENTAL_HERB
	dw IsntTheTimeMessage ; POWER_HERB
	dw IsntTheTimeMessage ; WHITE_HERB
	dw IsntTheTimeMessage ; DAMP_ROCK
	dw IsntTheTimeMessage ; HEAT_ROCK
	dw IsntTheTimeMessage ; SMOOTH_ROCK
	dw IsntTheTimeMessage ; ICY_ROCK
	dw IsntTheTimeMessage ; CHOICE_BAND
	dw IsntTheTimeMessage ; CHOICE_SCARF
	dw IsntTheTimeMessage ; CHOICE_SPECS
	dw IsntTheTimeMessage ; FLAME_ORB
	dw IsntTheTimeMessage ; TOXIC_ORB
	dw IsntTheTimeMessage ; BLACK_SLUDGE
	dw IsntTheTimeMessage ; MACHO_BRACE
	dw IsntTheTimeMessage ; POWER_WEIGHT
	dw IsntTheTimeMessage ; POWER_BRACER
	dw IsntTheTimeMessage ; POWER_BELT
	dw IsntTheTimeMessage ; POWER_LENS
	dw IsntTheTimeMessage ; POWER_BAND
	dw IsntTheTimeMessage ; POWER_ANKLET
	dw IsntTheTimeMessage ; DRAGON_SCALE
	dw IsntTheTimeMessage ; UP_GRADE
	dw IsntTheTimeMessage ; DUBIOUS_DISC
	dw IsntTheTimeMessage ; PROTECTOR
	dw IsntTheTimeMessage ; ELECTIRIZER
	dw IsntTheTimeMessage ; MAGMARIZER
	dw IsntTheTimeMessage ; RAZOR_FANG
	dw IsntTheTimeMessage ; RAZOR_CLAW
	dw EvoStoneEffect     ; ODD_SOUVENIR
	dw IsntTheTimeMessage ; NUGGET
	dw IsntTheTimeMessage ; BIG_NUGGET
	dw IsntTheTimeMessage ; TINYMUSHROOM
	dw IsntTheTimeMessage ; BIG_MUSHROOM
	dw IsntTheTimeMessage ; BALMMUSHROOM
	dw IsntTheTimeMessage ; PEARL
	dw IsntTheTimeMessage ; BIG_PEARL
	dw IsntTheTimeMessage ; PEARL_STRING
	dw IsntTheTimeMessage ; STARDUST
	dw IsntTheTimeMessage ; STAR_PIECE
	dw IsntTheTimeMessage ; BRICK_PIECE
	dw IsntTheTimeMessage ; RARE_BONE
	dw IsntTheTimeMessage ; SILVER_LEAF
	dw IsntTheTimeMessage ; GOLD_LEAF
	dw IsntTheTimeMessage ; SLOWPOKETAIL
	dw IsntTheTimeMessage ; BOTTLE_CAP
	dw IsntTheTimeMessage ; HELIX_FOSSIL
	dw IsntTheTimeMessage ; DOME_FOSSIL
	dw IsntTheTimeMessage ; OLD_AMBER
	dw IsntTheTimeMessage ; MULCH
	dw IsntTheTimeMessage ; SWEET_HONEY
	dw IsntTheTimeMessage ; MINT_LEAF
	dw IsntTheTimeMessage ; FLOWER_MAIL
	dw IsntTheTimeMessage ; SURF_MAIL
	dw IsntTheTimeMessage ; LITEBLUEMAIL
	dw IsntTheTimeMessage ; PORTRAITMAIL
	dw IsntTheTimeMessage ; LOVELY_MAIL
	dw IsntTheTimeMessage ; EON_MAIL
	dw IsntTheTimeMessage ; MORPH_MAIL
	dw IsntTheTimeMessage ; BLUESKY_MAIL
	dw IsntTheTimeMessage ; MUSIC_MAIL
	dw IsntTheTimeMessage ; MIRAGE_MAIL
	assert_table_length NUM_ITEMS + 1 ; count PARK_BALL

DoKeyItemEffect::
	ld a, [wCurKeyItem]
	ld [wNamedObjectIndex], a
	call GetKeyItemName
	call CopyName1
	ld a, 1
	ld [wItemEffectSucceeded], a
	ld a, [wCurKeyItem]
	dec a
	call StackJumpTable

KeyItemEffects:
; entries correspond to key item ids (see constants/item_constants.asm)
	table_width 2, KeyItemEffects
	dw BikeFunction       ; BICYCLE
	dw OldRod             ; OLD_ROD
	dw GoodRod            ; GOOD_ROD
	dw SuperRod           ; SUPER_ROD
	dw CoinCase           ; COIN_CASE
	dw Itemfinder         ; ITEMFINDER
	dw IsntTheTimeMessage ; MYSTERY_EGG
	dw SquirtBottle       ; SQUIRTBOTTLE
	dw IsntTheTimeMessage ; SECRETPOTION
	dw IsntTheTimeMessage ; RED_SCALE
	dw CardKey            ; CARD_KEY
	dw BasementKey        ; BASEMENT_KEY
	dw IsntTheTimeMessage ; S_S_TICKET
	dw IsntTheTimeMessage ; PASS
	dw IsntTheTimeMessage ; MACHINE_PART
	dw IsntTheTimeMessage ; LOST_ITEM
	dw IsntTheTimeMessage ; RAINBOW_WING
	dw IsntTheTimeMessage ; SILVER_WING
	dw IsntTheTimeMessage ; CLEAR_BELL
	dw IsntTheTimeMessage ; GS_BALL
	dw BlueCard           ; BLUE_CARD
	dw IsntTheTimeMessage ; ORANGETICKET
	dw IsntTheTimeMessage ; MYSTICTICKET
	dw IsntTheTimeMessage ; OLD_SEA_MAP
	dw IsntTheTimeMessage ; SHINY_CHARM
	dw IsntTheTimeMessage ; OVAL_CHARM
	dw IsntTheTimeMessage ; CATCH_CHARM
	dw IsntTheTimeMessage ; SILPHSCOPE2
	dw ApricornBox        ; APRICORN_BOX
	dw TypeChart          ; TYPE_CHART
	assert_table_length NUM_KEY_ITEMS

PokeBallEffect:
	; Replacing caught balls
	ld a, [wBattleMode]
	and a ; overworld
	jmp z, Ball_ReplacePartyMonCaughtBall

	; Using balls in trainer battles
	dec a
	jmp nz, UseBallInTrainerBattle

	; Battling ghosts
	ld a, [wBattleType]
	cp BATTLETYPE_GHOST
	jmp z, Ball_MonCantBeCaughtMessage

	; Everything below this are regular wild battles
	farcall DoesNuzlockeModePreventCapture
	jmp c, Ball_NuzlockeFailureMessage

.NoNuzlockeCheck
	ld a, [wEnemySubStatus3] ; BATTLE_VARS_SUBSTATUS3_OPP
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jmp nz, Ball_MonIsHiddenMessage

	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr z, .check_room
	ld c, a

	; Don't mess with item backup struct if we are in a bug contest
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jr z, .room_in_party

	; Copy wildmon's item to item backup struct in case we catch
	ld hl, wPartyBackupItems
	ld b, 0
	add hl, bc
	ld a, [wEnemyMonItem]
	ld [hl], a
	jr .room_in_party

.check_room
	farcall NewStorageBoxPointer
	jmp c, Ball_BoxIsFullMessage

.room_in_party
	xor a
	ld [wWildMon], a
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jr z, .skipReturnToBattle
	cp BATTLETYPE_SAFARI
	call nz, ReturnToBattle_UseBall
.skipReturnToBattle
	ld hl, wOptions1
	res NO_TEXT_SCROLL, [hl]
	ld hl, UsedItemText
	call PrintText

	ld a, [wOTPartyMon1Species]
	ld [wWildMon], a

	farcall GetModifiedCaptureRate
	ld [wBuffer1], a
	ld a, [wTempEnemyMonSpecies]
	ld [wWildMon], a

	; Figure out if we should do a critical capture
	farcall CheckCriticalCapture
	sbc a   ; if c (critical) then $ff else 0
	and $10 ; if c (critical) then $10 else 0
	ld [wBuffer2], a

	ld c, 20
	call DelayFrames

	ld a, [wCurItem]
	ld [wBattleAnimParam], a

	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a
	xor a
	ldh [hBattleTurn], a
	ld [wNumHits], a
	predef PlayBattleAnim

	ld a, [wBuffer2] ; amount of shakes
	and a
	ld hl, Text_NoShake
	jmp z, .shake_and_break_free
	dec a
	ld hl, Text_OneShake
	jmp z, .shake_and_break_free
	dec a
	ld hl, Text_TwoShakes
	jmp z, .shake_and_break_free
	dec a
	ld hl, Text_ThreeShakes
	jmp z, .shake_and_break_free

.caught
	ld a, [wTempEnemyMonSpecies]
	ld [wEnemyMonSpecies], a

	push af
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jmp z, .FinishTutorial

	ld hl, Text_GotchaMonWasCaught
	call PrintText

	call ClearSprites

	; Get current landmark
	call GetCurrentLandmark

	; Use landmark as index into flag array
	ld c, a
	ld hl, wNuzlockeLandmarkFlags
	ld b, SET_FLAG
	predef FlagPredef

	farcall GiveExperiencePointsAfterCatch

	ld a, [wOTPartyMon1Level]
	ld [wCurPartyLevel], a

	ld a, [wOTPartyMon1Species]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	ld a, [wOTPartyMon1Form]
	and SPECIESFORM_MASK
	ld [wCurForm], a
	call GetBaseData

	pop af
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a

	push af
	cp UNOWN
	jr nz, .unown_done
	ld hl, wOTPartyMon1Form
	predef GetVariant
	farcall UpdateUnownDex
.unown_done
	pop af

	dec a
	call CheckCaughtMon

	ld a, c
	push af
	ld a, [wTempSpecies]
	dec a
	call SetSeenAndCaughtMon
	pop af
	and a
	jr nz, .skip_pokedex

	call CheckReceivedDex
	jr z, .skip_pokedex

	ld hl, Text_AddedToPokedex
	call PrintText

	call ClearSprites

	ld a, [wOTPartyMon1Species]
	ld [wTempSpecies], a
	farcall NewPokedexEntry

.skip_pokedex
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jmp z, .catch_bug_contest_mon
	cp BATTLETYPE_LEGENDARY
	jr nz, .not_celebi ; false positive for other legendaries, but that's okay
	ld hl, wBattleResult
	set 6, [hl]
.not_celebi

	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jmp z, .SendToPC

	xor a ; PARTYMON
	ld [wMonType], a
	call ClearSprites

	; Copy to player party
	ld hl, wPartyCount
	ld a, [hl]
	inc [hl]
	ld hl, wPartyMon1
	push af
	call GetPartyLocation
	ld d, h
	ld e, l
	ld hl, wOTPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	pop af
	push af
	ld hl, wPartyMonOTs
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonOTs
	ld bc, NAME_LENGTH
	rst CopyBytes
	pop af
	push af
	ld hl, wPartyMonNicknames
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	pop af
	ld b, 0
	ld c, a
	ld hl, wPartySpecies
	add hl, bc
	ld a, [wOTPartyMon1Species]
	ld [hli], a
	ld [hl], $ff

	farcall SetCaughtData

	ld a, [wCurItem]
	cp FRIEND_BALL
	jr nz, .SkipPartyMonFriendBall

	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

	ld [hl], FRIEND_BALL_HAPPINESS
.SkipPartyMonFriendBall:

	ld a, [wCurItem]
	cp HEAL_BALL
	jr nz, .SkipPartyMonHealBall

	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	call HealPartyMonEvenForNuzlocke
.SkipPartyMonHealBall:

	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jr nz, .AlwaysNickname

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName

	ld hl, Text_AskNicknameNewlyCaughtMon
	call PrintText

	call YesNoBox
	jmp c, .return_from_capture

.AlwaysNickname:
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	rst AddNTimes

	ld d, h
	ld e, l
	push de
	xor a ; PARTYMON
	ld [wMonType], a
	ld b, $0 ; pokemon
	farcall NamingScreen

	ld c, 15
	call FadeToWhite

	call LoadStandardFont

	pop hl
	ld de, wStringBuffer1
	call InitName

	jmp .return_from_capture

.SendToPC:
	call ClearSprites

	call SentPkmnIntoBox

	farcall SetBoxMonCaughtData

	farcall NewStorageBoxPointer
	jr nc, .BoxNotFullYet
	ld hl, wBattleResult
	set 7, [hl]
.BoxNotFullYet:
	ld a, [wCurItem]
	cp FRIEND_BALL
	jr nz, .SkipBoxMonFriendBall
	; caught Pokemon become the first Pokemon in the box
	ld a, FRIEND_BALL_HAPPINESS
	ld [wTempMonHappiness], a
.SkipBoxMonFriendBall:

	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jr nz, .AlwaysNicknameBox

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName

	ld hl, Text_AskNicknameNewlyCaughtMon
	call PrintText

	call YesNoBox
	jr c, .SkipBoxMonNickname

.AlwaysNicknameBox:
	xor a
	ld [wCurPartyMon], a
	ld a, TEMPMON
	ld [wMonType], a
	ld de, wMonOrItemNameBuffer
	ld b, $0 ; pokemon
	farcall NamingScreen

	ld hl, wMonOrItemNameBuffer
	ld de, wTempMonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	ld hl, wTempMonNickname
	ld de, wStringBuffer1
	call InitName

.SkipBoxMonNickname:
	ld hl, wTempMonNickname
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	farcall UpdateStorageBoxMonFromTemp
	farcall CurBoxFullCheck
	jr z, .box_not_full
	ld hl, Text_CurBoxFull
	push bc
	call PrintText
	pop bc

.box_not_full
	ld a, [wCurBox]
	inc a
	ld b, a
	farcall GetBoxName
	ld hl, Text_SentToBillsPC
	call PrintText

	ld c, 15
	call FadeToWhite

	call LoadStandardFont
	jr .return_from_capture

.catch_bug_contest_mon
	call BugContest_SetCaughtContestMon
	jr .return_from_capture

.FinishTutorial:
	pop af
	ld hl, Text_GotchaMonWasCaught
	jr .print

.shake_and_break_free
	push hl
	ld a, [wTempEnemyMonSpecies]
	push af
	ld a, [wEnemyMonSpecies]
	ld [wTempEnemyMonSpecies], a
	ld [wCurPartySpecies], a
	farcall BattleCheckEnemyShininess
	jr nc, .not_shiny
	call SetEnemyTurn
	ld a, 1 ; shiny anim
	ld [wBattleAnimParam], a
	ld de, ANIM_SEND_OUT_MON
	farcall Call_PlayBattleAnim
	call SetPlayerTurn
.not_shiny

	ld bc, wTempMonSpecies
	farcall CheckFaintedFrzSlp
	jr c, .skip_cry
	farcall CheckBattleEffects
	jr c, .cry_no_anim
	hlcoord 12, 0
	lb de, $0, ANIM_MON_SLOW
	predef AnimateFrontpic
	jr .skip_cry

.cry_no_anim
	ld a, $f
	ld [wCryTracks], a
	ld a, [wTempEnemyMonSpecies]
	call PlayStereoCry

.skip_cry
	pop af
	ld [wTempEnemyMonSpecies], a
	pop hl
.print
	call PrintText
	call ClearSprites
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	ret z
	xor a
	ld [wWildMon], a

.return_from_capture
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jr z, .used_park_ball
	cp BATTLETYPE_SAFARI
	jr z, .used_safari_ball

	ld a, [wWildMon]
	and a
	jr z, .toss

	call ClearBGPalettes
	call ClearTileMap

	push af
	ld a, CGB_BATTLE_COLORS
	call GetCGBLayout
	call SetPalettes
	pop af

.toss
	ld hl, wNumItems
	inc a
	ld [wItemQuantityChangeBuffer], a
	jmp TossItem

.used_park_ball
	ld hl, wParkBallsRemaining
	dec [hl]
	ret

.used_safari_ball
	ld hl, wSafariBallsRemaining
	dec [hl]
	ret

Text_NoShake:
	; Oh no! The #MON broke free!
	text_far _BallBrokeFreeText
	text_end

Text_OneShake:
	; Aww! It appeared to be caught!
	text_far _BallAppearedCaughtText
	text_end

Text_TwoShakes:
	; Aargh! Almost had it!
	text_far _BallAlmostHadItText
	text_end

Text_ThreeShakes:
	; Shoot! It was so close too!
	text_far _BallSoCloseText
	text_end

Text_GotchaMonWasCaught:
	; Gotcha! @ was caught!@ @
	text_far Text_BallCaught
	text_asm
	call WaitSFX
	push bc
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_CAPTURE
	call PlayMusic
	pop bc
	ld hl, TextJump_Waitbutton
	ret

TextJump_Waitbutton:
	; @
	text_far Text_Waitbutton_2
	text_end

Text_CurBoxFull:
	text_far _CurBoxFullText
	text_end

Text_SentToBillsPC:
	; was sent to BILL's PC.
	text_far _MonSentToPCText
	text_end

Text_AddedToPokedex:
	; 's data was newly added to the #DEX.@ @
	text_far _NewDexDataText
	text_end

Text_AskNicknameNewlyCaughtMon:
	; Give a nickname to @ ?
	text_far _AskGiveNicknameText
	text_end

ReturnToBattle_UseBall:
	farjp _ReturnToBattle_UseBall

EvoStoneEffect:
	ld b, PARTYMENUACTION_EVO_STONE
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

	ld a, MON_ITEM
	call GetPartyParamLocation
	ld a, [hl]
	cp EVERSTONE
	jr z, .no_effect

.force_evolution
	ld a, $1
	ld [wForceEvolution], a
	farcall EvolvePokemon

	ld a, [wMonTriedToEvolve]
	and a
	jmp nz, UseDisposableItem
.no_effect
	jmp WontHaveAnyEffectMessage

LowerEVBerry:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

	ld a, MON_HAPPINESS
	call GetPartyParamLocation
	ld a, [hl]
	inc a
	push af
	call SetUpEVModifier
	add hl, bc
	pop af
	or [hl]
	jmp z, WontHaveAnyEffectMessage

	ld a, [hl]
	sub 10
	jr nc, .ev_value_ok
	xor a

.ev_value_ok
	ld [hl], a
	call UpdatePkmnStats
	ld c, HAPPINESS_USEDEVBERRY
	predef ChangeHappiness
	call GetStatStringAndPlayFullHealSFX
	ld hl, ItemHappinessRoseButStatFellText
	call PrintText
	jmp UseDisposableItem

ItemHappinessRoseButStatFellText:
	text_far _ItemHappinessRoseButStatFellText
	text_end

VitaminEffect:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

	call SetUpEVModifier
	add hl, bc
	ld a, [hl]
	cp 252
	jmp nc, WontHaveAnyEffectMessage

	add 10
	jr c, .set_to_max
	cp 252 + 1
	jr c, .ev_value_ok
.set_to_max
	ld a, 252

.ev_value_ok
	ld [hl], a
	call UpdatePkmnStats

	call GetStatStringAndPlayFullHealSFX
	ld hl, ItemStatRoseText
	call PrintText
	call UseDisposableItem
	; fallthrough
VitaminHappiness:
	ld c, HAPPINESS_USEDVITAMIN
	predef_jump ChangeHappiness

ItemStatRoseText:
	; 's @ rose.
	text_far _ItemStatRoseText
	text_end

SetUpEVModifier:
	call UseItem_GetBaseDataAndNickParameters
	call GetEVRelativePointer
	ld a, MON_EVS
	jmp GetPartyParamLocation

GetStatStringAndPlayFullHealSFX:
	call GetEVRelativePointer
	ld hl, StatStrings
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer2
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes
	jmp Play_SFX_FULL_HEAL

StatStrings:
	dw .health
	dw .attack
	dw .defense
	dw .speed
	dw .spcl_atk
	dw .spcl_def

.health   db "Health@"
.attack   db "Attack@"
.defense  db "Defense@"
.speed    db "Speed@"
.spcl_atk db "Spcl.Atk@"
.spcl_def db "Spcl.Def@"

GetEVRelativePointer:
	ld a, [wCurItem]
	call CheckItemParam
	ld c, a
	ld b, 0
	ret

RareCandy:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

	call UseItem_GetBaseDataAndNickParameters

	ld a, MON_LEVEL
	call GetPartyParamLocation

	ld a, [hl]
	cp MAX_LEVEL
	jmp nc, EvoStoneEffect.force_evolution

	inc a
	ld [hl], a
	ld [wCurPartyLevel], a
	push de
	ld d, a
	farcall CalcExpAtLevel

	pop de
	ld a, MON_EXP
	call GetPartyParamLocation

	ldh a, [hMultiplicand]
	ld [hli], a
	ldh a, [hMultiplicand + 1]
	ld [hli], a
	ldh a, [hMultiplicand + 2]
	ld [hl], a

	push bc
	call UseItem_GetMaxHPParameter
	push de
	ld de, wStringBuffer3
	ld bc, 12
	rst CopyBytes
	pop de
	pop bc

	call UpdatePkmnStats
	call VitaminHappiness
	farcall LevelUpHappinessMod

	ld a, PARTYMENUTEXT_LEVEL_UP
	call ItemActionText

	xor a ; PARTYMON
	ld [wMonType], a
	predef CopyPkmnToTempMon
	farcall PrintStatDifferences
	predef LearnLevelMoves

	xor a
	ld [wForceEvolution], a
	farcall EvolvePokemon

	jmp UseDisposableItem

HealPowder:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

	call UseStatusHealer
	and a
	jmp nz, WontHaveAnyEffectMessage

	ld c, HAPPINESS_BITTERPOWDER
	predef ChangeHappiness
	jmp LooksBitterMessage

HealStatusEffect:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

FullyHealStatus:
	call UseStatusHealer
	and a
	jmp nz, WontHaveAnyEffectMessage
	ret

UseStatusHealer:
	call IsMonFainted
	jr z, .no_good
	call GetItemHealingAction
	ld a, MON_STATUS
	call GetPartyParamLocation
	ld a, [hl]
	and c
	jr nz, .good

	; is item used on confused mon?
	call IsItemUsedOnBattleMon
	jr nc, .no_good
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr z, .no_good
	ld a, c
	inc a ; cp $ff
	jr nz, .no_good
	ld b, PARTYMENUTEXT_HEAL_CONFUSION

.good
	xor a
	ld [hl], a
	ld a, b
	ld [wPartyMenuActionText], a
	call HealStatus
	call Play_SFX_FULL_HEAL
	call ItemActionTextWaitButton
	call UseDisposableItem
	xor a
	ret

.no_good
	ld a, $1
	ret

BattlemonRestoreHealth:
	call IsItemUsedOnBattleMon
	ret nc
	call UseItem_GetHPParameter
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
	ret

HealStatus:
	call IsItemUsedOnBattleMon
	ret nc
	xor a
	ld [wBattleMonStatus], a
	call GetItemHealingAction
	ld a, c
	cp -1
	ret nz
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_CONFUSED, [hl]
	ret

GetItemHealingAction:
	push hl
	ld a, [wCurItem]
	call CheckItemParam
	ld c, a
	ld hl, .StatusHealingActionTexts
.next
	cp [hl]
	jr z, .found_it
	inc hl
	inc hl
	jr .next
.found_it
	inc hl
	ld b, [hl]
	pop hl
	ret

.StatusHealingActionTexts:
; status param, party menu action text
	db 1 << PSN, PARTYMENUTEXT_HEAL_PSN
	db 1 << BRN, PARTYMENUTEXT_HEAL_BRN
	db 1 << PAR, PARTYMENUTEXT_HEAL_PAR
	db 1 << FRZ, PARTYMENUTEXT_HEAL_FRZ
	db SLP,      PARTYMENUTEXT_HEAL_SLP
	db -1,       PARTYMENUTEXT_HEAL_ALL

RevivalHerb:
	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jmp nz, Revive_NuzlockeFailureMessage

	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

	call RevivePokemon
	and a
	jmp nz, WontHaveAnyEffectMessage

	ld c, HAPPINESS_REVIVALHERB
	predef ChangeHappiness
	jmp LooksBitterMessage

ReviveEffect:
	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jmp nz, Revive_NuzlockeFailureMessage

	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

	call RevivePokemon
	and a
	jmp nz, WontHaveAnyEffectMessage
	ret

RevivePokemon:
	call IsMonFainted
	ld a, 1
	ret nz

	xor a
	ld [wLowHealthAlarm], a
	ld a, [wCurItem]
	cp REVIVE
	jr z, .revive_half_hp

	call ReviveFullHP
	jr .finish_revive

.revive_half_hp
	call ReviveHalfHP

.finish_revive
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_REVIVE
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	xor a
	ret

FullRestore:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

	call IsMonFainted
	jmp z, WontHaveAnyEffectMessage

	call IsMonAtFullHealth
	jmp nc, FullyHealStatus

	xor a
	ld [wLowHealthAlarm], a
	call ReviveFullHP
	ld a, MON_STATUS
	call GetPartyParamLocation
	xor a
	ld [hli], a
	ld [hl], a
	call HealStatus
	call BattlemonRestoreHealth
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	jmp UseDisposableItem

PersimBerry:
	ld hl, wPlayerSubStatus3
	bit SUBSTATUS_CONFUSED, [hl]
	jmp z, WontHaveAnyEffectMessage

	res SUBSTATUS_CONFUSED, [hl]
	xor a
	ldh [hBattleTurn], a
	call UseItemText

	ld hl, ConfusedNoMoreText
	jmp StdBattleTextbox

EnergyPowder:
	ld c, HAPPINESS_BITTERPOWDER
	jr EnergyPowderEnergyRootCommon

EnergyRoot:
	ld c, HAPPINESS_ENERGYROOT

EnergyPowderEnergyRootCommon:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

	push bc
	call ItemRestoreHP
	pop bc
	and a
	jmp nz, WontHaveAnyEffectMessage

	predef ChangeHappiness
	jmp LooksBitterMessage

ItemRestoreHP:
	call IsMonFainted
	ld a, 1
	ret z

	call IsMonAtFullHealth
	ld a, 1
	ret nc

	xor a
	ld [wLowHealthAlarm], a
	call GetHealingItemAmount
	call RestoreHealth
	call BattlemonRestoreHealth
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	xor a
	ret

HealHP_SFX_GFX:
	push de
	ld de, SFX_POTION
	call WaitPlaySFX
	pop de
	ld a, [wCurPartyMon]
	hlcoord 11, 0
	ld bc, SCREEN_WIDTH * 2
	rst AddNTimes
	ld a, $2
	ld [wWhichHPBar], a
	predef_jump AnimateHPBar

UseItem_SelectMon2:
; Used on something already: don't reload the graphics
	ld a, b
	ld [wPartyMenuActionText], a
	push hl
	push de
	push bc
	farcall InitPartyMenuWithCancel
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	farcall PartyMenuSelect
	pop bc
	pop de
	pop hl
	jr UseItem_DoSelectMon

RestoreHPEffect:
	ld b, PARTYMENUACTION_HEALING_ITEM
	ld hl, ItemRestoreHP
	; fallthrough

UseItem_SelectMon_Loop:
	ld a, b
	ld [wPartyMenuActionText], a
	push de
	ld b, 0
	push bc
	push hl
	call ClearBGPalettes
	jr .handle_loop
.loop
	ld a, [wItemQuantityBuffer]
	and a
	jr z, .done
	ld a, [wBattleMode]
	and a
	jr nz, .done
.handle_loop
	call ChoosePkmnToUseItemOn
	jr c, .done
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr z, .not_egg
	call CantUseOnEggMessage
	jr .handle_loop
.not_egg
	pop hl
	push hl
	call _hl_
	and a
	jr nz, .no_effect
	pop hl
	pop bc
	ld b, 1
	push bc
	push hl
	jr .loop
.no_effect
	call WontHaveAnyEffectMessage
	jr .handle_loop
.done
	pop hl
	pop bc
	pop de
	ld a, b
	ld [wItemEffectSucceeded], a
	ret

UseItem_SelectMon:
	ld a, b
	ld [wPartyMenuActionText], a
	push hl
	push de
	push bc
	call ClearBGPalettes
	call ChoosePkmnToUseItemOn
	pop bc
	pop de
	pop hl
	; fallthrough

UseItem_DoSelectMon:
	ret c

	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr z, .not_egg

	call CantUseOnEggMessage
	scf
	ret

.not_egg
	and a
	ret

UseItem_GetBaseDataAndNickParameters:
; loads base data and nickname into memory
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wTempSpecies], a
	ld a, MON_FORM
	call GetPartyParamLocation
	ld a, [hl]
	and SPECIESFORM_MASK
	ld [wCurForm], a
	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	jmp GetNickname

UseItem_GetHPParameter:
	ld a, MON_HP
	jmp GetPartyParamLocation

UseItem_GetMaxHPParameter:
	ld a, MON_MAXHP
	jmp GetPartyParamLocation

ChoosePkmnToUseItemOn:
	farcall InitPartyMenuLayout
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	farjp PartyMenuSelect

ItemActionText:
	ld [wPartyMenuActionText], a
	ld a, [wCurPartySpecies]
	push af
	ld a, [wCurPartyMon]
	push hl
	push de
	push bc
	push af
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuActionText
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	pop af
	pop bc
	pop de
	pop hl
	ld [wCurPartyMon], a
	pop af
	ld [wCurPartySpecies], a
	ret

ItemActionTextWaitButton:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, wTileMapEnd - wTileMap
	ld a, " "
	rst ByteFill
	ld a, [wPartyMenuActionText]
	call ItemActionText
	ld a, $1
	ldh [hBGMapMode], a
	ld c, 50
	call DelayFrames
	jmp WaitPressAorB_BlinkCursor

IsItemUsedOnBattleMon:
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wCurPartyMon]
	push hl
	ld hl, wCurBattleMon
	cp [hl]
	pop hl
	jr nz, .nope
	scf
	ret

.nope
	xor a
	ret

ReviveHalfHP:
	call LoadHPFromBuffer1
	srl d
	rr e
	jr ContinueRevive

RestoreHealth:
	call UseItem_GetHPParameter
	inc hl
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	jr c, ReviveFullHP
	call LoadCurHPIntoBuffer5
	ld d, h
	ld e, l
	call UseItem_GetMaxHPParameter
	inc hl
	ld a, [de]
	sub [hl]
	dec de
	dec hl
	ld a, [de]
	sbc [hl]
	ret c
	; fallthrough

ReviveFullHP:
	call LoadHPFromBuffer1
ContinueRevive:
	call UseItem_GetHPParameter
	ld [hl], d
	inc hl
	ld [hl], e
	jr LoadCurHPIntoBuffer5

RemoveHP:
	call UseItem_GetHPParameter
	inc hl
	ld a, [hl]
	sub e
	ld [hld], a
	ld a, [hl]
	sbc d
	ld [hl], a
	jr nc, LoadCurHPIntoBuffer5
	xor a
	ld [hld], a
	ld [hl], a
	jr LoadCurHPIntoBuffer5

IsMonFainted:
	push de
	call LoadMaxHPToBuffer1
	call LoadCurHPToBuffer3
	call LoadHPFromBuffer3
	ld a, d
	or e
	pop de
	ret

IsMonAtFullHealth:
	call LoadHPFromBuffer3
	ld h, d
	ld l, e
	call LoadHPFromBuffer1
	ld a, l
	sub e
	ld a, h
	sbc d
	ret

LoadCurHPIntoBuffer5:
	call UseItem_GetHPParameter
	ld a, [hli]
	ld [wBuffer6], a
	ld a, [hl]
	ld [wBuffer5], a
	ret

LoadCurHPToBuffer3:
	call UseItem_GetHPParameter
	ld a, [hli]
	ld [wBuffer4], a
	ld a, [hl]
	ld [wBuffer3], a
	ret

LoadHPFromBuffer3:
	ld a, [wBuffer4]
	ld d, a
	ld a, [wBuffer3]
	ld e, a
	ret

LoadMaxHPToBuffer1:
	push hl
	call UseItem_GetMaxHPParameter
	ld a, [hli]
	ld [wBuffer2], a
	ld a, [hl]
	ld [wBuffer1], a
	pop hl
	ret

LoadHPFromBuffer1:
	ld a, [wBuffer2]
	ld d, a
	ld a, [wBuffer1]
	ld e, a
	ret

GetOneFifthMaxHP:
	push bc
	call UseItem_GetMaxHPParameter
	ld a, [hli]
	ldh [hDividend + 0], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 1]
	ld d, a
	ldh a, [hQuotient + 2]
	ld e, a
	pop bc
	ret

GetHealingItemAmount:
	ld a, [wCurItem]
	cp SITRUS_BERRY
	jr z, .sitrus_berry
	cp FIGY_BERRY
	jr z, .figy_berry

	call CheckItemParam
	ld e, a
	ld d, 0
	cp -1
	ret nz
	ld de, 999
	ret

.figy_berry
	call .set_de_to_hp
	jr .half_hp

.sitrus_berry
	call .set_de_to_hp
	srl d
	rr e
.half_hp
	srl d
	rr e
	ld a, d
	or e
	ret nz
	ld e, 1
	ret

.set_de_to_hp
	call UseItem_GetMaxHPParameter
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ret

FreshSnackFunction:
; Fresh Snack in the field
	ld a, [wPartyMenuCursor]
	dec a
	ld b, a
	call .SelectFreshSnackRecipient ; select pokemon
	jr c, .skip
	ld a, b
	ld [wCurPartyMon], a
	call IsMonFainted
	call GetOneFifthMaxHP
	call RemoveHP
	push bc
	call HealHP_SFX_GFX
	pop bc
	call GetOneFifthMaxHP
	ld a, c
	ld [wCurPartyMon], a
	call IsMonFainted
	call RestoreHealth
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	call ItemActionText
	call JoyWaitAorB
.skip
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	ret

.SelectFreshSnackRecipient:
.loop
	push bc
	ld a, PARTYMENUACTION_HEALING_ITEM
	ld [wPartyMenuActionText], a
	call ChoosePkmnToUseItemOn
	pop bc
	jr c, .set_carry
	ld a, [wPartyMenuCursor]
	dec a
	ld c, a
	ld a, b
	cp c
	jr z, .cant_use ; chose the same mon as user
	ld a, c
	ld [wCurPartyMon], a
	call IsMonFainted
	jr z, .cant_use
	call IsMonAtFullHealth
	jr nc, .cant_use
	xor a
	ret

.set_carry
	scf
	ret

.cant_use
	push bc
	ld hl, .Text_CantBeUsed
	call MenuTextboxBackup
	pop bc
	jr .loop

.Text_CantBeUsed:
	; That can't be used on this #MON.
	text_far _ItemCantUseOnMonText
	text_end

EscapeRope:
	xor a
	ld [wItemEffectSucceeded], a
	call EscapeRopeFunction

	ld a, [wItemEffectSucceeded]
	dec a
	jmp z, UseDisposableItem
	ret

RepelEffect:
	ld a, [wRepelEffect]
	and a
	ld hl, TextJump_RepelUsedEarlierIsStillInEffect
	jmp nz, PrintText

	call CheckItemParam
	ld [wRepelEffect], a

	ld a, [wCurItem]
	ld [wRepelType], a

	jmp UseItemText

TextJump_RepelUsedEarlierIsStillInEffect:
	; The REPEL used earlier is still in effect.
	text_far Text_RepelUsedEarlierIsStillInEffect
	text_end

PokeDoll:
	ld a, [wBattleMode]
	dec a
	jmp nz, ItemNotUsed_ExitMenu ; not a wild battle
	inc a
	ld [wBattleEnded], a
	ld a, [wBattleResult]
	and 3 << 6
	or $2
	ld [wBattleResult], a
	jmp UseItemText

GuardSpec:
	ld a, [wPlayerGuards]
	and GUARD_MIST
	jmp nz, WontHaveAnyEffect_NotUsedMessage
	ld a, 5 << 4
	ld hl, wPlayerGuards
	or [hl]
	ld [hl], a
	call UseItemText
	call XItemHappiness
	ld hl, MistText
	jmp StdBattleTextbox

DireHit:
	ld hl, wPlayerSubStatus4
	bit SUBSTATUS_FOCUS_ENERGY, [hl]
	jmp nz, WontHaveAnyEffect_NotUsedMessage
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	call XItemHappiness
	jmp UseItemText

XItemEffect:
	call CheckItemParam
	ld b, a

	ld a, STAT_SKIPTEXT | STAT_SILENT
	farcall _ForceRaiseStat
	ld a, [wFailedMessage]
	and a
	jmp nz, WontHaveAnyEffect_NotUsedMessage

	push bc
	call UseItemText
	pop bc

	; skip stat raise anim since we're in bag
	farcall GetStatRaiseMessage
	or 1
	farcall DoPrintStatChange
	; fallthrough
XItemHappiness:
	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	ld c, HAPPINESS_USEDXITEM
	predef_jump ChangeHappiness

BlueCard:
	ld hl, .bluecardtext
	jmp MenuTextboxWaitButton

.bluecardtext
	text_far _BlueCardBalanceText
	text_end

CoinCase:
	ld hl, .coincasetext
	jmp MenuTextboxWaitButton

.coincasetext
	text_far _CoinCaseCountText
	text_end

ApricornBox:
	ld hl, .MenuDataHeader
	call LoadMenuHeader
	hlcoord 5, 1
	lb bc, 9, 13
	call Textbox
	call UpdateSprites
	call ApplyTilemap
	hlcoord 6, 3
	lb bc, 8, 13
	call ClearBox
	ld hl, .Text
	bccoord 6, 3
	call PlaceWholeStringInBoxAtOnce
	call PrintAprValues
	call WaitButton
	jmp ExitMenu

.MenuDataHeader:
	db $40 ; flags
	db 01, 05 ; start coords
	db 11, 19 ; end coords
	dw vTiles0
	db 0 ; default option

.Text
	text  " Red   Blu"
	next1 "   ×     ×"
	next1 " Ylw   Grn"
	next1 "   ×     ×"
	next1 " Wht   Blk"
	next1 "   ×     ×"
	next1 " Pnk"
	next1 "   ×"
	done

PrintAprValues:
	lb bc, 1, 2
	hlcoord 10, 4
	ld de, wApricorns
	call PrintNum
	hlcoord 16, 4
	call .print
	hlcoord 10, 6
	call .print
	hlcoord 16, 6
	call .print
	hlcoord 10, 8
	call .print
	hlcoord 16, 8
	call .print
	hlcoord 10, 10
.print
	inc de
	jmp PrintNum

TypeChart:
	call FadeToMenu
	farcall _TypeChart
	call ExitMenu
	xor a
	ldh [hBGMapMode], a
	farcall Pack_InitGFX
	farcall WaitBGMap_DrawPackGFX
	farjp Pack_InitColors

OldRod:
	ld e, $0
	jr UseRod

GoodRod:
	ld e, $1
	jr UseRod

SuperRod:
	ld e, $2
	; fallthrough

UseRod:
	jmp FishFunction

Itemfinder:
	farjp ItemFinder

RestorePPEffect:
	ld a, [wCurItem]
	ld [wTempItem], a

.loop
	; Party Screen opens to choose on which Pkmn to use the Item
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jmp c, ItemNotUsed_ExitMenu

.loop2
	ld a, [wTempItem]
	cp MAX_ELIXIR
	jmp z, Elixir_RestorePPofAllMoves
	cp ELIXIR
	jmp z, Elixir_RestorePPofAllMoves

	ld hl, RaiseThePPOfWhichMoveText
	ld a, [wTempItem]
	cp PP_UP
	jr z, .ppup
	cp PP_MAX
	jr z, .ppup
	ld hl, RestoreThePPOfWhichMoveText

.ppup
	call PrintText

	ld a, [wCurMoveNum]
	push af
	xor a
	ld [wCurMoveNum], a
	inc a
	ld [wMoveSelectionMenuType], a
	farcall MoveSelectionScreen
	pop bc

	ld a, b
	ld [wCurMoveNum], a
	jr nz, .loop
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon

	push hl
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetMoveName
	call CopyName1
	pop hl

	ld a, [wTempItem]
	cp PP_UP
	jr z, .ppup2
	cp PP_MAX
	jmp nz, Not_PP_Up

.ppup2
	ld a, [hl]
	cp SKETCH
	jr z, .CantUsePPUpOnSketch

	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [hl]
	cp 3 << 6 ; have 3 PP Ups already been used?
	jr c, .do_ppup

.CantUsePPUpOnSketch:
.pp_is_maxed_out
	ld hl, PPIsMaxedOutText
	call PrintText
	jr .loop2

.do_ppup
	push hl
	call VitaminHappiness
	pop hl
	ld c, 3 << 6
	ld a, [wTempItem]
	cp PP_MAX
	ld b, 3
	jr z, .pp_restore_loop
	ld b, 1
.pp_restore_loop
	push hl
	push bc
	ld a, [hl]
	add PP_UP_ONE ; increase PP Up count by 1
	ld [hl], a
	ld a, TRUE
	ld [wUsePPUp], a
	call ApplyPPUp
	pop bc
	pop hl

	; Unless PP is maxed, we might want to continue increasing PP further.
	ld a, [hl]
	and c
	cp c
	jr z, .maxed_pp
	dec b
	jr nz, .pp_restore_loop
.maxed_pp
	call Play_SFX_FULL_HEAL

	ld hl, PPsIncreasedText
	ld a, [wTempItem]
	cp PP_UP
	jr z, .ppup3
	ld hl, PPsMaximizedText
.ppup3
	call PrintText

FinishPPRestore:
	jmp UseDisposableItem

BattleRestorePP:
	ld a, [wBattleMode]
	and a
	jr z, .not_in_battle
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jr nz, .not_in_battle
	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_TRANSFORMED, a
	call z, .UpdateBattleMonPP
.not_in_battle
	call Play_SFX_FULL_HEAL
	ld hl, PPRestoredText
	call PrintText
	jr FinishPPRestore

.UpdateBattleMonPP:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld de, wBattleMonMoves
	ld b, NUM_MOVES
.loop
	ld a, [de]
	and a
	ret z
	cp [hl]
	jr nz, .next
	push hl
	push de
	push bc
rept NUM_MOVES + 5 ; wBattleMonPP - wBattleMonMoves
	inc de
endr
	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [hl]
	ld [de], a
	pop bc
	pop de
	pop hl

.next
	inc hl
	inc de
	dec b
	jr nz, .loop
	ret

Not_PP_Up:
	call RestorePP
	jr nz, BattleRestorePP
	jmp WontHaveAnyEffectMessage

Elixir_RestorePPofAllMoves:
	xor a
	ld hl, wMenuCursorY
	ld [hli], a
	ld [hl], a
	ld b, NUM_MOVES
.moveLoop
	push bc
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld a, [hl]
	and a
	jr z, .next

	call RestorePP
	jr z, .next
	ld hl, wMenuCursorX
	inc [hl]

.next
	ld hl, wMenuCursorY
	inc [hl]
	pop bc
	dec b
	jr nz, .moveLoop
	ld a, [wMenuCursorX]
	and a
	jmp nz, BattleRestorePP
	jmp WontHaveAnyEffectMessage

RestorePP:
	xor a ; PARTYMON
	ld [wMonType], a
	call GetMaxPPOfMove
	ld hl, wPartyMon1PP
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld a, [wTempPP]
	ld b, a
	ld a, [hl]
	and PP_MASK
	cp b
	jr nc, .dont_restore

	ld a, [wTempItem]
	cp MAX_ELIXIR
	jr z, .restore_all
	cp MAX_ETHER
	jr z, .restore_all

; restore up to 10 PP for ETHER, ELIXIR, and LEPPA_BERRY
	ld a, [hl]
	and PP_MASK
	add 10
	cp b
	jr nc, .restore_all
	ld b, a

.restore_all
	ld a, [hl]
	and 3 << 6
	or b
	ld [hl], a
	ret

.dont_restore
	xor a
	ret

RaiseThePPOfWhichMoveText:
	; Raise the PP of which move?
	text_far Text_RaiseThePPOfWhichMove
	text_end

RestoreThePPOfWhichMoveText:
	; Restore the PP of which move?
	text_far Text_RestoreThePPOfWhichMove
	text_end

PPIsMaxedOutText:
	; 's PP is maxed out.
	text_far Text_PPIsMaxedOut
	text_end

PPsIncreasedText:
	; 's PP increased.
	text_far Text_PPsIncreased
	text_end

PPsMaximizedText:
	; 's PP maximized.
	text_far Text_PPsMaximized
	text_end

PPRestoredText:
	; PP was restored.
	text_far _PPRestoredText
	text_end

SquirtBottle:
	farjp _Squirtbottle

CardKey:
	farjp _CardKey

BasementKey:
	farjp _BasementKey

SacredAsh:
	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jr nz, Revive_NuzlockeFailureMessage

	farcall _SacredAsh
	ld a, [wItemEffectSucceeded]
	dec a
	ret nz
	jr UseDisposableItem

Play_SFX_FULL_HEAL:
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	pop de
	ret

UseItemText:
	ld hl, UsedItemText
	call PrintText
	call Play_SFX_FULL_HEAL
	call WaitPressAorB_BlinkCursor
	; fallthrough
UseDisposableItem:
	ld hl, wNumItems
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	jmp TossItem

UseBallInTrainerBattle:
	call ReturnToBattle_UseBall
	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a
	ld a, -1 ; trainer blocked the ball
	ld [wBattleAnimParam], a
	ldh [hBattleTurn], a
	ld [wNumHits], a
	predef PlayBattleAnim
	ld hl, BlockedTheBallText
	call PrintText
	ld hl, DontBeAThiefText
	call PrintText
	jr UseDisposableItem

LooksBitterMessage:
	ld hl, LooksBitterText
	jmp PrintText

WontHaveAnyEffect_NotUsedMessage:
	ld hl, WontHaveAnyEffectText
	jr ItemWasntUsedMessage

Ball_BoxIsFullMessage:
	ld hl, Ball_StorageFullText
	jr z, ItemWasntUsedMessage
	ld hl, Ball_DatabaseTaxedText
	jr ItemWasntUsedMessage

Ball_MonIsHiddenMessage:
	ld hl, Ball_MonIsHiddenText
	jr ItemWasntUsedMessage

Ball_MonCantBeCaughtMessage:
	ld hl, Ball_MonCantBeCaughtText
	jr ItemWasntUsedMessage

Revive_NuzlockeFailureMessage:
	ld hl, Revive_NuzlockeFailureText
	jr ItemWasntUsedMessage

Ball_NuzlockeFailureMessage:
	ld hl, Ball_NuzlockeFailureText
	call PrintText

	ld a, [wCurItem]
	and a ; PARK_BALL?
	ret z
	cp SAFARI_BALL
	ret z
	jr _ItemWasntUsedMessage

ItemWasntUsedMessage:
	; Item wasn't used.
	call PrintText
_ItemWasntUsedMessage:
	ld a, $2
	ld [wItemEffectSucceeded], a
	ret

Ball_ReplacePartyMonCaughtBall:
	ld b, PARTYMENUACTION_CHOOSE_POKEMON
	call UseItem_SelectMon
	jr c, ItemNotUsed_ExitMenu

	ld a, [wCurItem]
	ld b, a
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1CaughtBall
	call GetPartyLocation
	ld a, [hl]
	and CAUGHT_BALL_MASK
	cp b
	jr z, AlreadyInThatBallMessage

	ld a, [hl]
	and ~CAUGHT_BALL_MASK
	add b
	ld [hl], a
	call UseDisposableItem

	; wStringBuffer2 already contains the item name from GetItemName + CopyName1
	call GetCurNickname
	ld hl, BallReplacedText
	jmp PrintText

BallReplacedText:
	text "Put "
	text_ram wStringBuffer1
	text " in"
	line "the "
	text_ram wStringBuffer2
	text "."
	prompt

AlreadyInThatBallMessage:
	ld hl, AlreadyInThatBallText
	jr CantUseItemMessage

CantUseOnEggMessage:
	ld hl, CantUseOnEggText
	jr CantUseItemMessage

IsntTheTimeMessage:
	ld hl, IsntTheTimeText
	jr CantUseItemMessage

WontHaveAnyEffectMessage:
	ld hl, WontHaveAnyEffectText
	; fallthrough

CantUseItemMessage:
; Item couldn't be used.
	call PrintText
	; fallthrough
ItemNotUsed_ExitMenu:
	xor a
	ld [wItemEffectSucceeded], a
	ret

LooksBitterText:
	; It looks bitter…
	text_far _ItemLooksBitterText
	text_end

CantUseOnEggText:
	; That can't be used on an EGG.
	text_far _ItemCantUseOnEggText
	text_end

AlreadyInThatBallText:
	text_far AlreadyInThatBallTextData
	text_end

IsntTheTimeText:
	; OAK:  ! This isn't the time to use that!
	text_far _ItemOakWarningText
	text_end

WontHaveAnyEffectText:
	; It won't have any effect.
	text_far _ItemWontHaveEffectText
	text_end

BlockedTheBallText:
	; The trainer blocked the BALL!
	text_far _BallBlockedText
	text_end

DontBeAThiefText:
	; Don't be a thief!
	text_far _BallDontBeAThiefText
	text_end

Ball_StorageFullText:
	; The #MON BOX is full. That can't be used now.
	text_far _BallStorageFullText
	text_end

Ball_DatabaseTaxedText:
	; The #MON BOX is full. That can't be used now.
	text_far _BallDatabaseFullText
	text_end

Ball_MonIsHiddenText:
	; The #MON can't be seen!
	text_far Text_MonIsHiddenFromBall
	text_end

Ball_MonCantBeCaughtText:
	; The #MON can't be caught!
	text_far Text_MonCantBeCaught
	text_end

Ball_NuzlockeFailureText:
	; You already encountered a #MON here.
	text_far Text_NuzlockeBallFailure
	text_end

Revive_NuzlockeFailureText:
	; You can't revive #MON in NUZLOCKE mode!
	text_far Text_NuzlockeReviveFailure
	text_end

UsedItemText:
	; used the@ .
	text_far _ItemUsedText
	text_end

ApplyPPUp:
	ld a, MON_MOVES
	call GetPartyParamLocation
	push hl
	ld de, wBuffer1
	predef FillPP
	pop hl
	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld de, wBuffer1
	ld b, 0
.loop
	inc b
	ld a, b
	cp NUM_MOVES + 1
	ret z
	ld a, [wUsePPUp]
	dec a ; FALSE?
	jr nz, .use
	ld a, [wMenuCursorY]
	inc a
	cp b
	jr nz, .skip

.use
	ld a, [hl]
	and 3 << 6
	call nz, ComputeMaxPP

.skip
	inc hl
	inc de
	jr .loop

ComputeMaxPP:
	push bc
	; Divide the base PP by 5.
	ld a, [de]
	ldh [hDividend + 3], a
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ldh [hDividend + 2], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 4
	call Divide
	; Get the number of PP, which are bits 6 and 7 of the PP value stored in RAM.
	ld a, [hl]
	ld b, a
	swap a
	and $f
	srl a
	srl a
	ld c, a
	; If this value is 0, we are done
	and a
	jr z, .NoPPUp

.loop
	; Normally, a move with 40 PP would have 64 PP with three PP Ups.
	; Since this would overflow into bit 6, we prevent that from happening
	; by decreasing the extra amount of PP each PP Up provides, resulting
	; in a maximum of 61.
	ldh a, [hQuotient + 2]
	cp $8
	jr c, .okay
	ld a, $7

.okay
	add b
	ld b, a
	ld a, [wTempPP]
	dec a
	jr z, .NoPPUp
	dec c
	jr nz, .loop

.NoPPUp:
	ld [hl], b
	pop bc
	ret

RestoreTempPP:
	ld hl, wTempMonMoves
	ld de, wTempMonPP
	ld a, [wMenuCursorY]
	push af
	ld a, TEMPMON
	ld [wMonType], a
	call _RestoreAllPP
	pop af
	ld [wMenuCursorY], a
	ret

RestoreAllPP:
	ld a, MON_PP
	call GetPartyParamLocation
	push hl
	ld a, MON_MOVES
	call GetPartyParamLocation
	pop de
	xor a ; PARTYMON
	ld [wMonType], a
	; fallthrough
_RestoreAllPP:
	xor a
	ld [wMenuCursorY], a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	and a
	ret z
	push hl
	push de
	push bc
	call GetMaxPPOfMove
	pop bc
	pop de
	ld a, [de]
	and PP_UP_MASK
	ld b, a
	ld a, [wTempPP]
	add b
	ld [de], a
	inc de
	ld hl, wMenuCursorY
	inc [hl]
	pop hl
	dec c
	jr nz, .loop
	ret

GetMaxPPOfMove:
	ld a, [wStringBuffer1 + 0]
	push af
	ld a, [wStringBuffer1 + 1]
	push af

	ld a, [wMonType]
	and a

	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	jr z, .got_partymon ; PARTYMON

	ld hl, wOTPartyMon1Moves
	dec a
	jr z, .got_partymon ; OTPARTYMON

	ld hl, wTempMonMoves
	dec a
	jr z, .got_nonpartymon ; BOXMON
	dec a
	jr z, .got_nonpartymon ; TEMPMON

	ld hl, wBattleMonMoves ; WILDMON

.got_nonpartymon ; BOXMON, TEMPMON, WILDMON
	call GetMthMoveOfCurrentMon
	jr .gotdatmove

.got_partymon ; PARTYMON, OTPARTYMON
	call GetMthMoveOfNthPartymon

.gotdatmove
	ld a, [hl]
	push hl
	ld hl, Moves + MOVE_PP
	call GetMoveProperty
	ld b, a
	ld de, wStringBuffer1
	ld [de], a
	pop hl

	push bc
	ld bc, MON_PP - MON_MOVES
	ld a, [wMonType]
	cp WILDMON
	jr nz, .notwild
	ld bc, wEnemyMonPP - wEnemyMonMoves
.notwild
	add hl, bc
	ld a, [hl]
	and PP_UP_MASK
	pop bc

	or b
	ld hl, wStringBuffer1 + 1
	ld [hl], a
	xor a
	ld [wTempPP], a
	call ComputeMaxPP
	ld a, [hl]
	and PP_MASK
	ld [wTempPP], a

	pop af
	ld [wStringBuffer1 + 1], a
	pop af
	ld [wStringBuffer1 + 0], a
	ret

GetMthMoveOfNthPartymon:
	ld a, [wCurPartyMon]
	rst AddNTimes

GetMthMoveOfCurrentMon:
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ret

AbilityPatch:
; Switch between regular and hidden ability
	; fallthrough (most code is shared with Ability Capsule)
AbilityCap:
; If a pokémon doesn't have its hidden ability, switch between its
; 1st and 2nd ability
	ld a, [wCurItem]
	ld [wTempItem], a

	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
.loop
	ret c

	push hl
	call UseItem_GetBaseDataAndNickParameters
	ld a, MON_ABILITY
	call GetPartyParamLocation
	ld d, h
	ld e, l
	pop hl
	push hl
	ld a, [wTempItem]
	cp ABILITYPATCH
	ld a, [de]
	ld b, ABILITY_2 ; xor to change later
	jr z, .allow_change
	ld b, ABILITY_1 | ABILITY_2
	and ABILITY_MASK
	jr z, .no_effect
	cp HIDDEN_ABILITY
	jr z, .no_effect

	; Check if the ability would change
	push bc
	ld a, [wBaseAbility1]
	ld b, a
	ld a, [wBaseAbility2]
	cp b
	pop bc
	jr z, .no_effect

.allow_change
	; Ability would change: ask for a confirmation
	ld a, [de]
	and ABILITY_MASK
	xor b
	ld c, a
	ld hl, wBaseAbility1
	cp ABILITY_1
	jr z, .got_new_ability
	inc hl
	cp ABILITY_2
	jr z, .got_new_ability
	inc hl
.got_new_ability
	ld b, [hl]
	push bc
	push de
	farcall BufferAbility
	ld hl, ChangeAbilityToText
	call PrintText
	call YesNoBox
	pop de
	pop bc
	pop hl
	jr c, .loopnext

	; Change ability
	ld a, [de]
	and ~ABILITY_MASK
	or c
	ld [de], a

	call UseDisposableItem
	ld hl, AbilityChangedText
	jmp PrintText

.no_effect
	call WontHaveAnyEffectMessage
	pop hl
.loopnext
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon2
	jr .loop

ChangeAbilityToText:
	text "Change ability to"
	line ""
	text_ram wStringBuffer1
	text "?"
	done

AbilityChangedText:
	text "The ability was"
	line "changed!"
	prompt

INCLUDE "engine/battle_anims/pokeball_wobble.asm"
