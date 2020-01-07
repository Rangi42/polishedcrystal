_DoItemEffect:: ; e722
	ld a, [wCurItem]
	ld [wd265], a
	call GetItemName
	call CopyName1
	ld a, 1
	ld [wItemEffectSucceeded], a
	ld a, [wCurItem]
	dec a
	ld hl, ItemEffects
	rst JumpTable
	ret
; e73c

DoKeyItemEffect::
	ld a, [wCurKeyItem]
	ld [wd265], a
	call GetKeyItemName
	call CopyName1
	ld a, 1
	ld [wItemEffectSucceeded], a
	ld a, [wCurKeyItem]
	dec a
	ld hl, KeyItemEffects
	rst JumpTable
	ret

ItemEffects: ; e73c
	dw PokeBallEffect   ; POKE_BALL
	dw PokeBallEffect   ; GREAT_BALL
	dw PokeBallEffect   ; ULTRA_BALL
	dw PokeBallEffect   ; MASTER_BALL
	dw PokeBallEffect   ; SAFARI_BALL
	dw PokeBallEffect   ; LEVEL_BALL
	dw PokeBallEffect   ; LURE_BALL
	dw PokeBallEffect   ; MOON_BALL
	dw PokeBallEffect   ; FRIEND_BALL
	dw PokeBallEffect   ; FAST_BALL
	dw PokeBallEffect   ; HEAVY_BALL
	dw PokeBallEffect   ; LOVE_BALL
	dw PokeBallEffect   ; PARK_BALL
	dw PokeBallEffect   ; REPEAT_BALL
	dw PokeBallEffect   ; TIMER_BALL
	dw PokeBallEffect   ; NEST_BALL
	dw PokeBallEffect   ; NET_BALL
	dw PokeBallEffect   ; DIVE_BALL
	dw PokeBallEffect   ; LUXURY_BALL
	dw PokeBallEffect   ; HEAL_BALL
	dw PokeBallEffect   ; QUICK_BALL
	dw PokeBallEffect   ; DUSK_BALL
	dw PokeBallEffect   ; DREAM_BALL
	dw PokeBallEffect   ; PREMIER_BALL
	dw PokeBallEffect   ; CHERISH_BALL
	dw RestoreHPEffect  ; POTION
	dw RestoreHPEffect  ; SUPER_POTION
	dw RestoreHPEffect  ; HYPER_POTION
	dw RestoreHPEffect  ; MAX_POTION
	dw HealStatusEffect ; ANTIDOTE
	dw HealStatusEffect ; BURN_HEAL
	dw HealStatusEffect ; PARALYZEHEAL
	dw HealStatusEffect ; AWAKENING
	dw HealStatusEffect ; ICE_HEAL
	dw HealStatusEffect ; FULL_HEAL
	dw FullRestore      ; FULL_RESTORE
	dw ReviveEffect     ; REVIVE
	dw ReviveEffect     ; MAX_REVIVE
	dw RestorePPEffect  ; ETHER
	dw RestorePPEffect  ; MAX_ETHER
	dw RestorePPEffect  ; ELIXIR
	dw RestorePPEffect  ; MAX_ELIXIR
	dw VitaminEffect    ; HP_UP
	dw VitaminEffect    ; PROTEIN
	dw VitaminEffect    ; IRON
	dw VitaminEffect    ; CARBOS
	dw VitaminEffect    ; CALCIUM
	dw VitaminEffect    ; ZINC
	dw RareCandy        ; RARE_CANDY
	dw RestorePPEffect  ; PP_UP
	dw RestorePPEffect  ; PP_MAX
	dw RestoreHPEffect  ; FRESH_WATER
	dw RestoreHPEffect  ; SODA_POP
	dw RestoreHPEffect  ; LEMONADE
	dw RestoreHPEffect  ; MOOMOO_MILK
	dw HealStatusEffect ; RAGECANDYBAR
	dw HealStatusEffect ; PEWTERCRUNCH
	dw SacredAsh        ; SACRED_ASH
	dw EnergyPowder     ; ENERGYPOWDER
	dw EnergyRoot       ; ENERGY_ROOT
	dw HealPowder       ; HEAL_POWDER
	dw RevivalHerb      ; REVIVAL_HERB
	dw XItemEffect      ; X_ATTACK
	dw XItemEffect      ; X_DEFEND
	dw XItemEffect      ; X_SPEED
	dw XItemEffect      ; X_SPCL_ATK
	dw XItemEffect      ; X_SPCL_DEF
	dw XItemEffect      ; X_ACCURACY
	dw DireHit          ; DIRE_HIT
	dw GuardSpec        ; GUARD_SPEC
	dw RepelEffect      ; REPEL
	dw RepelEffect      ; SUPER_REPEL
	dw RepelEffect      ; MAX_REPEL
	dw EscapeRope       ; ESCAPE_ROPE
	dw PokeDoll         ; POKE_DOLL
	dw AbilityCap       ; ABILITY_CAP
	dw EvoStoneEffect   ; LEAF_STONE
	dw EvoStoneEffect   ; FIRE_STONE
	dw EvoStoneEffect   ; WATER_STONE
	dw EvoStoneEffect   ; THUNDERSTONE
	dw EvoStoneEffect   ; MOON_STONE
	dw EvoStoneEffect   ; SUN_STONE
	dw EvoStoneEffect   ; DUSK_STONE
	dw EvoStoneEffect   ; DAWN_STONE
	dw EvoStoneEffect   ; SHINY_STONE
	dw EvoStoneEffect   ; ICE_STONE
	dw NoEffect         ; EVERSTONE
	dw NoEffect         ; EXP_SHARE
	dw HealStatusEffect ; CHERI_BERRY
	dw HealStatusEffect ; CHESTO_BERRY
	dw HealStatusEffect ; PECHA_BERRY
	dw HealStatusEffect ; RAWST_BERRY
	dw HealStatusEffect ; ASPEAR_BERRY
	dw RestorePPEffect  ; LEPPA_BERRY
	dw RestoreHPEffect  ; ORAN_BERRY
	dw PersimBerry      ; PERSIM_BERRY
	dw HealStatusEffect ; LUM_BERRY
	dw RestoreHPEffect  ; SITRUS_BERRY
	dw RestoreHPEffect  ; FIGY_BERRY
	dw LowerEVBerry     ; POMEG_BERRY
	dw LowerEVBerry     ; KELPSY_BERRY
	dw LowerEVBerry     ; QUALOT_BERRY
	dw LowerEVBerry     ; HONDEW_BERRY
	dw LowerEVBerry     ; GREPA_BERRY
	dw LowerEVBerry     ; TAMATO_BERRY
	dw NoEffect         ; LIECHI_BERRY
	dw NoEffect         ; GANLON_BERRY
	dw NoEffect         ; SALAC_BERRY
	dw NoEffect         ; PETAYA_BERRY
	dw NoEffect         ; APICOT_BERRY
	dw NoEffect         ; LANSAT_BERRY
	dw NoEffect         ; STARF_BERRY
	dw NoEffect         ; ENIGMA_BERRY
	dw NoEffect         ; CUSTAP_BERRY
	dw NoEffect         ; JABOCA_BERRY
	dw NoEffect         ; ROWAP_BERRY
	dw NoEffect         ; KEE_BERRY
	dw NoEffect         ; MARANGABERRY
	dw RestoreHPEffect  ; BERRY_JUICE
	dw NoEffect         ; SILK_SCARF
	dw NoEffect         ; BLACK_BELT
	dw NoEffect         ; SHARP_BEAK
	dw NoEffect         ; POISON_BARB
	dw NoEffect         ; SOFT_SAND
	dw NoEffect         ; HARD_STONE
	dw NoEffect         ; SILVERPOWDER
	dw NoEffect         ; SPELL_TAG
	dw NoEffect         ; METAL_COAT
	dw NoEffect         ; CHARCOAL
	dw NoEffect         ; MYSTIC_WATER
	dw NoEffect         ; MIRACLE_SEED
	dw NoEffect         ; MAGNET
	dw NoEffect         ; TWISTEDSPOON
	dw NoEffect         ; NEVERMELTICE
	dw NoEffect         ; DRAGON_FANG
	dw NoEffect         ; BLACKGLASSES
	dw NoEffect         ; PINK_BOW
	dw NoEffect         ; BRIGHTPOWDER
	dw NoEffect         ; SCOPE_LENS
	dw NoEffect         ; QUICK_CLAW
	dw NoEffect         ; KINGS_ROCK
	dw NoEffect         ; FOCUS_BAND
	dw NoEffect         ; LEFTOVERS
	dw NoEffect         ; LUCKY_EGG
	dw NoEffect         ; AMULET_COIN
	dw NoEffect         ; CLEANSE_TAG
	dw NoEffect         ; SMOKE_BALL
	dw NoEffect         ; BERSERK_GENE
	dw NoEffect         ; LIGHT_BALL
	dw NoEffect         ; STICK
	dw NoEffect         ; THICK_CLUB
	dw NoEffect         ; LUCKY_PUNCH
	dw NoEffect         ; METAL_POWDER
	dw NoEffect         ; QUICK_POWDER
	dw NoEffect         ; ARMOR_SUIT
	dw NoEffect         ; AIR_BALLOON
	dw NoEffect         ; ASSAULT_VEST
	dw NoEffect         ; BIG_ROOT
	dw NoEffect         ; BINDING_BAND
	dw NoEffect         ; DESTINY_KNOT
	dw NoEffect         ; EVIOLITE
	dw NoEffect         ; EXPERT_BELT
	dw NoEffect         ; FOCUS_SASH
	dw NoEffect         ; GRIP_CLAW
	dw NoEffect         ; LIFE_ORB
	dw NoEffect         ; LIGHT_CLAY
	dw NoEffect         ; METRONOME_I
	dw NoEffect         ; MUSCLE_BAND
	dw NoEffect         ; PROTECT_PADS
	dw NoEffect         ; ROCKY_HELMET
	dw NoEffect         ; SAFE_GOGGLES
	dw NoEffect         ; SHED_SHELL
	dw NoEffect         ; SHELL_BELL
	dw NoEffect         ; SOOTHE_BELL
	dw NoEffect         ; WEAK_POLICY
	dw NoEffect         ; WIDE_LENS
	dw NoEffect         ; WISE_GLASSES
	dw NoEffect         ; ZOOM_LENS
	dw NoEffect         ; EJECT_BUTTON
	dw NoEffect         ; LAGGING_TAIL
	dw NoEffect         ; IRON_BALL
	dw NoEffect         ; RING_TARGET
	dw NoEffect         ; RED_CARD
	dw NoEffect         ; ABSORB_BULB
	dw NoEffect         ; CELL_BATTERY
	dw NoEffect         ; LUMINOUSMOSS
	dw NoEffect         ; SNOWBALL
	dw NoEffect         ; EJECT_PACK
	dw NoEffect         ; ROOM_SERVICE
	dw NoEffect         ; BLUNDRPOLICY
	dw NoEffect         ; THROAT_SPRAY
	dw NoEffect         ; HEAVY_BOOTS
	dw NoEffect         ; UTILUMBRELLA
	dw NoEffect         ; MENTAL_HERB
	dw NoEffect         ; POWER_HERB
	dw NoEffect         ; WHITE_HERB
	dw NoEffect         ; DAMP_ROCK
	dw NoEffect         ; HEAT_ROCK
	dw NoEffect         ; SMOOTH_ROCK
	dw NoEffect         ; ICY_ROCK
	dw NoEffect         ; CHOICE_BAND
	dw NoEffect         ; CHOICE_SCARF
	dw NoEffect         ; CHOICE_SPECS
	dw NoEffect         ; FLAME_ORB
	dw NoEffect         ; TOXIC_ORB
	dw NoEffect         ; BLACK_SLUDGE
	dw NoEffect         ; MACHO_BRACE
	dw NoEffect         ; POWER_WEIGHT
	dw NoEffect         ; POWER_BRACER
	dw NoEffect         ; POWER_BELT
	dw NoEffect         ; POWER_LENS
	dw NoEffect         ; POWER_BAND
	dw NoEffect         ; POWER_ANKLET
	dw NoEffect         ; DRAGON_SCALE
	dw NoEffect         ; UP_GRADE
	dw NoEffect         ; DUBIOUS_DISC
	dw NoEffect         ; PROTECTOR
	dw NoEffect         ; ELECTIRIZER
	dw NoEffect         ; MAGMARIZER
	dw NoEffect         ; RAZOR_FANG
	dw NoEffect         ; RAZOR_CLAW
	dw NoEffect         ; ODD_SOUVENIR
	dw NoEffect         ; NUGGET
	dw NoEffect         ; BIG_NUGGET
	dw NoEffect         ; TINYMUSHROOM
	dw NoEffect         ; BIG_MUSHROOM
	dw NoEffect         ; BALMMUSHROOM
	dw NoEffect         ; PEARL
	dw NoEffect         ; BIG_PEARL
	dw NoEffect         ; PEARL_STRING
	dw NoEffect         ; STARDUST
	dw NoEffect         ; STAR_PIECE
	dw NoEffect         ; BRICK_PIECE
	dw NoEffect         ; RARE_BONE
	dw NoEffect         ; SILVER_LEAF
	dw NoEffect         ; GOLD_LEAF
	dw NoEffect         ; SLOWPOKETAIL
	dw NoEffect         ; BOTTLE_CAP
	dw NoEffect         ; HELIX_FOSSIL
	dw NoEffect         ; DOME_FOSSIL
	dw NoEffect         ; OLD_AMBER
	dw NoEffect         ; MULCH
	dw NoEffect         ; SWEET_HONEY
	dw NoEffect         ; MINT
	dw NoEffect         ; FLOWER_MAIL
	dw NoEffect         ; SURF_MAIL
	dw NoEffect         ; LITEBLUEMAIL
	dw NoEffect         ; PORTRAITMAIL
	dw NoEffect         ; LOVELY_MAIL
	dw NoEffect         ; EON_MAIL
	dw NoEffect         ; MORPH_MAIL
	dw NoEffect         ; BLUESKY_MAIL
	dw NoEffect         ; MUSIC_MAIL
	dw NoEffect         ; MIRAGE_MAIL
; e8a2

KeyItemEffects:
	dw Bicycle          ; BICYCLE
	dw OldRod           ; OLD_ROD
	dw GoodRod          ; GOOD_ROD
	dw SuperRod         ; SUPER_ROD
	dw CoinCase         ; COIN_CASE
	dw Itemfinder       ; ITEMFINDER
	dw NoEffect         ; MYSTERY_EGG
	dw SquirtBottle     ; SQUIRTBOTTLE
	dw NoEffect         ; SECRETPOTION
	dw NoEffect         ; RED_SCALE
	dw CardKey          ; CARD_KEY
	dw BasementKey      ; BASEMENT_KEY
	dw NoEffect         ; S_S_TICKET
	dw NoEffect         ; PASS
	dw NoEffect         ; MACHINE_PART
	dw NoEffect         ; LOST_ITEM
	dw NoEffect         ; RAINBOW_WING
	dw NoEffect         ; SILVER_WING
	dw NoEffect         ; CLEAR_BELL
	dw NoEffect         ; GS_BALL
	dw BlueCard         ; BLUE_CARD
	dw NoEffect         ; ORANGETICKET
	dw NoEffect         ; MYSTICTICKET
	dw NoEffect         ; OLD_SEA_MAP
	dw NoEffect         ; SHINY_CHARM
	dw NoEffect         ; OVAL_CHARM
	dw NoEffect         ; CATCH_CHARM
	dw NoEffect         ; SILPHSCOPE2
	dw ApricornBox      ; APRICORN_BOX

PokeBallEffect: ; e8a2
	farcall DoesNuzlockeModePreventCapture
	jp c, Ball_NuzlockeFailureMessage

.NoNuzlockeCheck
	ld a, [wBattleMode]
	dec a
	jp nz, UseBallInTrainerBattle

	ld a, [wBattleType]
	cp BATTLETYPE_GHOST
	jp z, Ball_MonCantBeCaughtMessage

	ld a, [wEnemySubStatus3] ; BATTLE_VARS_SUBSTATUS3_OPP
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jp nz, Ball_MonIsHiddenMessage

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
	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld a, [sBoxCount]
	cp MONS_PER_BOX
	call CloseSRAM
	jp z, Ball_BoxIsFullMessage

.room_in_party
	xor a
	ld [wWildMon], a
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jr z, .skipReturnToBattle
	cp BATTLETYPE_SAFARI
	jr z, .skipReturnToBattle
	call ReturnToBattle_UseBall

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
	ld [wEnemyMonSpecies], a
	ld [wWildMon], a

	; Figure out if we should do a critical capture
	farcall CheckCriticalCapture
	ld a, 0
	jr nc, .not_critical
	ld a, $10
.not_critical
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
	ld [hBattleTurn], a
	ld [wNumHits], a
	predef PlayBattleAnim

	ld a, [wBuffer2] ; amount of shakes
	and a
	ld hl, Text_NoShake
	jp z, .shake_and_break_free
	dec a
	ld hl, Text_OneShake
	jp z, .shake_and_break_free
	dec a
	ld hl, Text_TwoShakes
	jp z, .shake_and_break_free
	dec a
	ld hl, Text_ThreeShakes
	jp z, .shake_and_break_free

.caught
	ld a, [wTempEnemyMonSpecies]
	ld [wEnemyMonSpecies], a

	ld a, [wEnemyMonSpecies]
	push af
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld [wd265], a
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jp z, .FinishTutorial

	ld hl, Text_GotchaMonWasCaught
	call PrintText

	call ClearSprites

	; Get current landmark
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
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
	call GetBaseData

	pop af
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld [wd265], a

	dec a
	call CheckCaughtMon

	ld a, c
	push af
	ld a, [wd265]
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
	ld [wd265], a
	predef NewPokedexEntry

.skip_pokedex
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jp z, .catch_bug_contest_mon
	cp BATTLETYPE_LEGENDARY
	jr nz, .not_celebi ; false positive for other legendaries, but that's okay
	ld hl, wBattleResult
	set 6, [hl]
.not_celebi

	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jp z, .SendToPC

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
	ld hl, wPartyMonOT
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes
	pop af
	push af
	ld hl, wPartyMonNicknames
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
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

	ld a, FRIEND_BALL_HAPPINESS
	ld [hl], a
.SkipPartyMonFriendBall:

	ld a, [wCurItem]
	cp HEAL_BALL
	jr nz, .SkipPartyMonHealBall

	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	farcall HealPartyMonEvenForNuzlocke
.SkipPartyMonHealBall:

	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jr nz, .AlwaysNickname

	ld a, [wCurPartySpecies]
	ld [wd265], a
	call GetPokemonName

	ld hl, Text_AskNicknameNewlyCaughtMon
	call PrintText

	call YesNoBox
	jp c, .return_from_capture

.AlwaysNickname:
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld hl, wPartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
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

	jp .return_from_capture

.SendToPC:
	call ClearSprites

	predef SentPkmnIntoBox

	farcall SetBoxMonCaughtData

	ld a, BANK(sBoxCount)
	call GetSRAMBank

	ld a, [sBoxCount]
	cp MONS_PER_BOX
	jr nz, .BoxNotFullYet
	ld hl, wBattleResult
	set 7, [hl]
.BoxNotFullYet:
	ld a, [wCurItem]
	cp FRIEND_BALL
	jr nz, .SkipBoxMonFriendBall
	; caught Pokemon become the first Pokemon in the box
	ld a, FRIEND_BALL_HAPPINESS
	ld [sBoxMon1Happiness], a
.SkipBoxMonFriendBall:
	call CloseSRAM

	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jr nz, .AlwaysNicknameBox

	ld a, [wCurPartySpecies]
	ld [wd265], a
	call GetPokemonName

	ld hl, Text_AskNicknameNewlyCaughtMon
	call PrintText

	call YesNoBox
	jr c, .SkipBoxMonNickname

.AlwaysNicknameBox:
	xor a
	ld [wCurPartyMon], a
	ld a, BOXMON
	ld [wMonType], a
	ld de, wMonOrItemNameBuffer
	ld b, $0 ; pokemon
	farcall NamingScreen

	ld a, BANK(sBoxMonNicknames)
	call GetSRAMBank

	ld hl, wMonOrItemNameBuffer
	ld de, sBoxMonNicknames
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes

	ld hl, sBoxMonNicknames
	ld de, wStringBuffer1
	call InitName

	call CloseSRAM

.SkipBoxMonNickname:
	ld a, BANK(sBoxMonNicknames)
	call GetSRAMBank

	ld hl, sBoxMonNicknames
	ld de, wMonOrItemNameBuffer
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes

	call CloseSRAM

	ld hl, Text_SentToBillsPC
	call PrintText

	ld c, 15
	call FadeToWhite

	call LoadStandardFont
	jr .return_from_capture

.catch_bug_contest_mon
	farcall BugContest_SetCaughtContestMon
	jr .return_from_capture

.FinishTutorial:
	pop af
	ld hl, Text_GotchaMonWasCaught
	jr .print

.shake_and_break_free
	push hl
	farcall BattleCheckEnemyShininess
	jr nc, .not_shiny
	ld a, 1 ; shiny anim
	ld [wBattleAnimParam], a
	ld de, ANIM_SEND_OUT_MON
	farcall Call_PlayBattleAnim
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
	pop hl
.print
	ld a, 0
	ld [wWildMon], a
	call PrintText
	call ClearSprites

.return_from_capture
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	ret z
	cp BATTLETYPE_CONTEST
	jr z, .used_park_ball
	cp BATTLETYPE_SAFARI
	jr z, .used_safari_ball

	ld a, [wWildMon]
	and a
	jr z, .toss

	call ClearBGPalettes
	call ClearTileMap

.toss
	ld hl, wNumItems
	inc a
	ld [wItemQuantityChangeBuffer], a
	jp TossItem

.used_park_ball
	ld hl, wParkBallsRemaining
	dec [hl]
	ret

.used_safari_ball
	ld hl, wSafariBallsRemaining
	dec [hl]
	ret
; ec0a

Text_NoShake: ; 0xedb5
	; Oh no! The #MON broke free!
	text_jump UnknownText_0x1c5aa6
	db "@"
; 0xedba

Text_OneShake: ; 0xedba
	; Aww! It appeared to be caught!
	text_jump UnknownText_0x1c5ac3
	db "@"
; 0xedbf

Text_TwoShakes: ; 0xedbf
	; Aargh! Almost had it!
	text_jump UnknownText_0x1c5ae3
	db "@"
; 0xedc4

Text_ThreeShakes: ; 0xedc4
	; Shoot! It was so close too!
	text_jump UnknownText_0x1c5afa
	db "@"
; 0xedc9

Text_GotchaMonWasCaught: ; 0xedc9
	; Gotcha! @ was caught!@ @
	text_jump UnknownText_0x1c5b17
	start_asm
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
; ede6

TextJump_Waitbutton: ; 0xede6
	; @
	text_jump Text_Waitbutton_2
	db "@"
; 0xedeb

Text_SentToBillsPC: ; 0xedeb
	; was sent to BILL's PC.
	text_jump UnknownText_0x1c5b38
	db "@"
; 0xedf0

Text_AddedToPokedex: ; 0xedf0
	; 's data was newly added to the #DEX.@ @
	text_jump UnknownText_0x1c5b53
	db "@"
; 0xedf5

Text_AskNicknameNewlyCaughtMon: ; 0xedf5
	; Give a nickname to @ ?
	text_jump UnknownText_0x1c5b7f
	db "@"
; 0xedfa

ReturnToBattle_UseBall: ; edfa (3:6dfa)
	farjp _ReturnToBattle_UseBall


Bicycle: ; ee08
	farjp BikeFunction
; ee0f


EvoStoneEffect:
	ld b, PARTYMENUACTION_EVO_STONE
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

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
	jp nz, UseDisposableItem
.no_effect
	jp WontHaveAnyEffectMessage
; ee3d

LowerEVBerry:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

	ld a, MON_HAPPINESS
	call GetPartyParamLocation
	ld a, [hl]
	inc a
	push af
	call SetUpEVModifier
	add hl, bc
	pop af
	or [hl]
	jp z, WontHaveAnyEffectMessage

	ld a, [hl]
	sub 10
	jr nc, .ev_value_ok
	xor a

.ev_value_ok
	ld [hl], a
	farcall UpdatePkmnStats
	ld c, HAPPINESS_USEDEVBERRY
	farcall ChangeHappiness
	call GetStatStringAndPlayFullHealSFX
	ld hl, ItemHappinessRoseButStatFellText
	call PrintText
	jp UseDisposableItem

ItemHappinessRoseButStatFellText:
	text_jump _ItemHappinessRoseButStatFellText
	db "@"

VitaminEffect: ; ee3d
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

	call SetUpEVModifier
	add hl, bc
	ld a, [hl]
	cp 252
	jp nc, WontHaveAnyEffectMessage

	add 10
	jr c, .set_to_max
	cp 252 + 1
	jr c, .ev_value_ok
.set_to_max
	ld a, 252

.ev_value_ok
	ld [hl], a
	farcall UpdatePkmnStats

	call GetStatStringAndPlayFullHealSFX
	ld hl, ItemStatRoseText
	call PrintText

	ld c, HAPPINESS_USEDITEM
	farcall ChangeHappiness
	jp UseDisposableItem
; ee8c


ItemStatRoseText: ; 0xeea6
	; 's @ rose.
	text_jump _ItemStatRoseText
	db "@"
; 0xeeab

SetUpEVModifier:
	call UseItem_GetBaseDataAndNickParameters
	call GetEVRelativePointer
	ld a, MON_EVS
	jp GetPartyParamLocation

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
	jp Play_SFX_FULL_HEAL

StatStrings: ; eeab
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
; eed9


GetEVRelativePointer: ; eed9
	ld a, [wCurItem]
	farcall CheckItemParam
	ld c, a
	ld b, 0
	ret
; eeeb


RareCandy: ; ef14
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

	call UseItem_GetBaseDataAndNickParameters

	ld a, MON_LEVEL
	call GetPartyParamLocation

	ld a, [hl]
	cp MAX_LEVEL
	jp nc, EvoStoneEffect.force_evolution

	inc a
	ld [hl], a
	ld [wCurPartyLevel], a
	push de
	ld d, a
	farcall CalcExpAtLevel

	pop de
	ld a, MON_EXP
	call GetPartyParamLocation

	ld a, [hMultiplicand]
	ld [hli], a
	ld a, [hMultiplicand + 1]
	ld [hli], a
	ld a, [hMultiplicand + 2]
	ld [hl], a

	push bc
	call UseItem_GetMaxHPParameter
	push de
	ld de, wStringBuffer3
	ld bc, 12
	rst CopyBytes
	pop de
	pop bc

	farcall UpdatePkmnStats
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

	jp UseDisposableItem
; efad


HealPowder: ; efad
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

	call UseStatusHealer
	and a
	jp nz, WontHaveAnyEffectMessage

	ld c, HAPPINESS_BITTERPOWDER
	farcall ChangeHappiness
	jp LooksBitterMessage
; efcc


HealStatusEffect: ; efcc
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

FullyHealStatus: ; efd4
	call UseStatusHealer
	and a
	jp nz, WontHaveAnyEffectMessage
	ret
; efda


UseStatusHealer: ; efda (3:6fda)
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

BattlemonRestoreHealth: ; f01e (3:701e)
	call IsItemUsedOnBattleMon
	ret nc
	call UseItem_GetHPParameter
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
	ret

HealStatus: ; f030 (3:7030)
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

GetItemHealingAction: ; f058 (3:7058)
	push hl
	ld a, [wCurItem]
	farcall CheckItemParam
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
; f071 (3:7071)

.StatusHealingActionTexts:
; status param, party menu action text
	db 1 << PSN, PARTYMENUTEXT_HEAL_PSN
	db 1 << BRN, PARTYMENUTEXT_HEAL_BRN
	db 1 << PAR, PARTYMENUTEXT_HEAL_PAR
	db 1 << FRZ, PARTYMENUTEXT_HEAL_FRZ
	db SLP,      PARTYMENUTEXT_HEAL_SLP
	db -1,       PARTYMENUTEXT_HEAL_ALL

RevivalHerb: ; f0a9
	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jp nz, Revive_NuzlockeFailureMessage

	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

	call RevivePokemon
	and a
	jp WontHaveAnyEffectMessage

	ld c, HAPPINESS_REVIVALHERB
	farcall ChangeHappiness
	jp LooksBitterMessage
; f0c8


ReviveEffect: ; f0c8
	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jp nz, Revive_NuzlockeFailureMessage

	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

	call RevivePokemon
	and a
	jp nz, WontHaveAnyEffectMessage
	ret
; f0d6


RevivePokemon: ; f0d6
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
; f128


FullRestore: ; f128
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

	call IsMonFainted
	jp z, WontHaveAnyEffectMessage

	call IsMonAtFullHealth
	jp nc, FullyHealStatus

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
	jp UseDisposableItem
; f144


PersimBerry: ; f16a
	ld hl, wPlayerSubStatus3
	bit SUBSTATUS_CONFUSED, [hl]
	jp z, WontHaveAnyEffectMessage

	res SUBSTATUS_CONFUSED, [hl]
	xor a
	ld [hBattleTurn], a
	call UseItemText

	ld hl, ConfusedNoMoreText
	jp StdBattleTextBox
; f186


RestoreHPEffect: ; f186
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

	call ItemRestoreHP
	and a
	jp nz, WontHaveAnyEffectMessage
	ret
; f18c


EnergyPowder: ; f18c
	ld c, HAPPINESS_BITTERPOWDER
	jr EnergyPowderEnergyRootCommon
; f190

EnergyRoot: ; f190
	ld c, HAPPINESS_ENERGYROOT
; f192

EnergyPowderEnergyRootCommon: ; f192
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu
    
	push bc
	call ItemRestoreHP
	pop bc
	and a
	jp nz, WontHaveAnyEffectMessage

	farcall ChangeHappiness
	jp LooksBitterMessage
; f1a9


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

HealHP_SFX_GFX: ; f1db (3:71db)
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

UseItem_SelectMon: ; f1f9 (3:71f9)
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

UseItem_GetBaseDataAndNickParameters: ; eef5
; loads base data and nickname into memory
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wd265], a
	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	jp GetNick
; 0xef14

UseItem_GetHPParameter:
	ld a, MON_HP
	jp GetPartyParamLocation

UseItem_GetMaxHPParameter:
	ld a, MON_MAXHP
	jp GetPartyParamLocation

ChoosePkmnToUseItemOn: ; f21c (3:721c)
	farcall InitPartyMenuLayout
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	farjp PartyMenuSelect

ItemActionText: ; f24a (3:724a)
	ld [wPartyMenuActionText], a
	ld a, [wCurPartySpecies]
	push af
	ld a, [wCurPartyMon]
	push af
	push hl
	push de
	push bc
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuActionText
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	pop bc
	pop de
	pop hl
	pop af
	ld [wCurPartyMon], a
	pop af
	ld [wCurPartySpecies], a
	ret

ItemActionTextWaitButton: ; f279 (3:7279)
	xor a
	ld [hBGMapMode], a
	hlcoord 0, 0
	ld bc, wTileMapEnd - wTileMap
	ld a, " "
	call ByteFill
	ld a, [wPartyMenuActionText]
	call ItemActionText
	ld a, $1
	ld [hBGMapMode], a
	ld c, 50
	call DelayFrames
	jp WaitPressAorB_BlinkCursor

IsItemUsedOnBattleMon: ; f2a6 (3:72a6)
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

ReviveHalfHP: ; f2ba (3:72ba)
	call LoadHPFromBuffer1
	srl d
	rr e
	jr ContinueRevive

ReviveFullHP: ; f2c3 (3:72c3)
	call LoadHPFromBuffer1
ContinueRevive: ; f2c6 (3:72c6)
	call UseItem_GetHPParameter
	ld [hl], d
	inc hl
	ld [hl], e
	jp LoadCurHPIntoBuffer5

RestoreHealth: ; f2d1 (3:72d1)
	call UseItem_GetHPParameter
	inc hl
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	jr c, .full_hp
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
.full_hp
	jp ReviveFullHP

RemoveHP: ; f2f9 (3:72f9)
	call UseItem_GetHPParameter
	inc hl
	ld a, [hl]
	sub e
	ld [hld], a
	ld a, [hl]
	sbc d
	ld [hl], a
	jr nc, .okay
	xor a
	ld [hld], a
	ld [hl], a
.okay
	jp LoadCurHPIntoBuffer5

IsMonFainted: ; f30d (3:730d)
	push de
	call LoadMaxHPToBuffer1
	call LoadCurHPToBuffer3
	call LoadHPFromBuffer3
	ld a, d
	or e
	pop de
	ret

IsMonAtFullHealth: ; f31b (3:731b)
	call LoadHPFromBuffer3
	ld h, d
	ld l, e
	call LoadHPFromBuffer1
	ld a, l
	sub e
	ld a, h
	sbc d
	ret

LoadCurHPIntoBuffer5: ; f328 (3:7328)
	call UseItem_GetHPParameter
	ld a, [hli]
	ld [wBuffer6], a
	ld a, [hl]
	ld [wBuffer5], a
	ret
; f336 (3:7336)

LoadCurHPToBuffer3: ; f348 (3:7348)
	call UseItem_GetHPParameter
	ld a, [hli]
	ld [wBuffer4], a
	ld a, [hl]
	ld [wBuffer3], a
	ret

LoadHPFromBuffer3: ; f356 (3:7356)
	ld a, [wBuffer4]
	ld d, a
	ld a, [wBuffer3]
	ld e, a
	ret

LoadMaxHPToBuffer1: ; f35f (3:735f)
	push hl
	call UseItem_GetMaxHPParameter
	ld a, [hli]
	ld [wBuffer2], a
	ld a, [hl]
	ld [wBuffer1], a
	pop hl
	ret

LoadHPFromBuffer1: ; f36f (3:736f)
	ld a, [wBuffer2]
	ld d, a
	ld a, [wBuffer1]
	ld e, a
	ret

GetOneFifthMaxHP: ; f378 (3:7378)
	push bc
	call UseItem_GetMaxHPParameter
	ld a, [hli]
	ld [hDividend + 0], a
	ld a, [hl]
	ld [hDividend + 1], a
	ld a, 5
	ld [hDivisor], a
	ld b, 2
	call Divide
	ld a, [hQuotient + 1]
	ld d, a
	ld a, [hQuotient + 2]
	ld e, a
	pop bc
	ret

GetHealingItemAmount: ; f395 (3:7395)
	ld a, [wCurItem]
	cp SITRUS_BERRY
	jr z, .sitrus_berry
	cp FIGY_BERRY
	jr z, .figy_berry

	farcall CheckItemParam
	ld e, a
	ld d, 0
	cp -1
	ret nz
	ld de, 999
	ret
; f3af (3:73af)

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

FreshSnackFunction: ; f3df (3:73df)
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

.SelectFreshSnackRecipient: ; f419 (3:7419)
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
	call MenuTextBoxBackup
	pop bc
	jr .loop
; f44a (3:744a)

.Text_CantBeUsed: ; 0xf44a
	; That can't be used on this #MON.
	text_jump UnknownText_0x1c5bac
	db "@"
; 0xf44f


EscapeRope: ; f44f
	xor a
	ld [wItemEffectSucceeded], a
	farcall EscapeRopeFunction

	ld a, [wItemEffectSucceeded]
	dec a
	jp z, UseDisposableItem
	ret
; f462


RepelEffect: ; f46c
	ld a, [wRepelEffect]
	and a
	ld hl, TextJump_RepelUsedEarlierIsStillInEffect
	jp nz, PrintText

	farcall CheckItemParam
	ld [wRepelEffect], a

	ld a, [wCurItem]
	ld [wRepelType], a

	jp UseItemText

TextJump_RepelUsedEarlierIsStillInEffect: ; 0xf47d
	; The REPEL used earlier is still in effect.
	text_jump Text_RepelUsedEarlierIsStillInEffect
	db "@"
; 0xf482


PokeDoll: ; f48f
	ld a, [wBattleMode]
	dec a
	jp nz, ItemNotUsed_ExitMenu ; not a wild battle
	inc a
	ld [wBattleEnded], a
	ld a, [wBattleResult]
	and 3 << 6
	or $2
	ld [wBattleResult], a
	jp UseItemText
; f4ab


GuardSpec: ; f4ab
	ld hl, wPlayerSubStatus4
	bit SUBSTATUS_MIST, [hl]
	jp nz, WontHaveAnyEffect_NotUsedMessage
	set SUBSTATUS_MIST, [hl]
	jp UseItemText
; f4b8


DireHit: ; f4b8
	ld hl, wPlayerSubStatus4
	bit SUBSTATUS_FOCUS_ENERGY, [hl]
	jp nz, WontHaveAnyEffect_NotUsedMessage
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	jp UseItemText
; f4c5


XItemEffect: ; f4c5
	farcall CheckItemParam
	ld b, a

	ld a, STAT_SKIPTEXT | STAT_SILENT
	farcall _ForceRaiseStat
	ld a, [wFailedMessage]
	and a
	jp nz, WontHaveAnyEffect_NotUsedMessage

	push bc
	call UseItemText
	pop bc

	; skip stat raise anim since we're in bag
	farcall GetStatRaiseMessage
	or 1
	farcall DoPrintStatChange

	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	ld c, HAPPINESS_USEDXITEM
	farjp ChangeHappiness
; f504


BlueCard: ; f58f
	ld hl, .bluecardtext
	jp MenuTextBoxWaitButton

.bluecardtext
	text_jump UnknownText_0x1c5c5e
	db "@"
; f59a


CoinCase: ; f59a
	ld hl, .coincasetext
	jp MenuTextBoxWaitButton

.coincasetext
	text_jump UnknownText_0x1c5c7b
	db "@"
; f5a5


ApricornBox:
	ld hl, .MenuDataHeader
	call LoadMenuDataHeader
	hlcoord 5, 1
	lb bc, 9, 13
	call TextBox
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
	jp ExitMenu

.MenuDataHeader:
	db $40 ; flags
	db 01, 05 ; start coords
	db 11, 19 ; end coords
	dw VTiles0
	db 0 ; default option

.Text
	db "<START>"
	db " Red   Blu<LNBRK>"
	db "   ×     ×<LNBRK>"
	db " Ylw   Grn<LNBRK>"
	db "   ×     ×<LNBRK>"
	db " Wht   Blk<LNBRK>"
	db "   ×     ×<LNBRK>"
	db " Pnk<LNBRK>"
	db "   ×@@"

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
	jp PrintNum


OldRod: ; f5a5
	ld e, $0
	jr UseRod
; f5a9

GoodRod: ; f5a9
	ld e, $1
	jr UseRod
; f5ad

SuperRod: ; f5ad
	ld e, $2
	; fallthrough

UseRod: ; f5b1
	farjp FishFunction
; f5b8


Itemfinder: ; f5b8
	farjp ItemFinder
; f5bf


RestorePPEffect: ; f5bf
	ld a, [wCurItem]
	ld [wd002], a

.loop
	; Party Screen opens to choose on which Pkmn to use the Item
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, ItemNotUsed_ExitMenu

.loop2
	ld a, [wd002]
	cp MAX_ELIXIR
	jp z, Elixir_RestorePPofAllMoves
	cp ELIXIR
	jp z, Elixir_RestorePPofAllMoves

	ld hl, TextJump_RaiseThePPOfWhichMove
	ld a, [wd002]
	cp PP_UP
	jr z, .ppup
	cp PP_MAX
	jr z, .ppup
	ld hl, TextJump_RestoreThePPOfWhichMove

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
	ld [wd265], a
	call GetMoveName
	call CopyName1
	pop hl

	ld a, [wd002]
	cp PP_UP
	jr z, .ppup2
	cp PP_MAX
	jp nz, Not_PP_Up

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
	ld hl, TextJump_PPIsMaxedOut
	call PrintText
	jr .loop2

.do_ppup
	ld a, [wd002]
	cp PP_MAX
	jr nz, .not_pp_max
	ld a, [hl]
	or 3 << 6 ; maximize PP Up count
	jr .raised_pp
.not_pp_max
	ld a, [hl]
	add 1 << 6 ; increase PP Up count by 1
.raised_pp
	ld [hl], a
	ld a, $1
	ld [wd265], a
	call ApplyPPUp
	call Play_SFX_FULL_HEAL

	ld hl, TextJump_PPsIncreased
	ld a, [wd002]
	cp PP_UP
	jr z, .ppup3
	ld hl, TextJump_PPsMaximized
.ppup3
	call PrintText

FinishPPRestore: ; f64c
	jp UseDisposableItem
; f652

BattleRestorePP: ; f652
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
	jr nz, .not_in_battle
	call .UpdateBattleMonPP

.not_in_battle
	call Play_SFX_FULL_HEAL
	ld hl, UnknownText_0xf739
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
; f6a7

Not_PP_Up: ; f6a7
	call RestorePP
	jr nz, BattleRestorePP
	jp WontHaveAnyEffectMessage
; f6af

Elixir_RestorePPofAllMoves: ; f6af
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
	jp nz, BattleRestorePP
	jp WontHaveAnyEffectMessage

RestorePP: ; f6e8
	xor a ; PARTYMON
	ld [wMonType], a
	call GetMaxPPOfMove
	ld hl, wPartyMon1PP
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld a, [wd265]
	ld b, a
	ld a, [hl]
	and (1 << 6) - 1
	cp b
	jr nc, .dont_restore

	ld a, [wd002]
	cp MAX_ELIXIR
	jr z, .restore_all
	cp MAX_ETHER
	jr z, .restore_all

	ld c, 10
	cp LEPPA_BERRY
	jr z, .restore_some

	ld c, 10

.restore_some
	ld a, [hl]
	and (1 << 6) - 1
	add c
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
; f725

TextJump_RaiseThePPOfWhichMove: ; 0xf725
	; Raise the PP of which move?
	text_jump Text_RaiseThePPOfWhichMove
	db "@"
; 0xf72a

TextJump_RestoreThePPOfWhichMove: ; 0xf72a
	; Restore the PP of which move?
	text_jump Text_RestoreThePPOfWhichMove
	db "@"
; 0xf72f

TextJump_PPIsMaxedOut: ; 0xf72f
	; 's PP is maxed out.
	text_jump Text_PPIsMaxedOut
	db "@"
; 0xf734

TextJump_PPsIncreased: ; 0xf734
	; 's PP increased.
	text_jump Text_PPsIncreased
	db "@"
; 0xf739

TextJump_PPsMaximized:
	; 's PP maximized.
	text_jump Text_PPsMaximized
	db "@"

UnknownText_0xf739: ; 0xf739
	; PP was restored.
	text_jump UnknownText_0x1c5cf1
	db "@"
; 0xf73e


SquirtBottle: ; f73e
	farjp _Squirtbottle
; f745


CardKey: ; f745
	farjp _CardKey
; f74c


BasementKey: ; f74c
	farjp _BasementKey
; f753


SacredAsh: ; f753
	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jp nz, Revive_NuzlockeFailureMessage

	farcall _SacredAsh
	ld a, [wItemEffectSucceeded]
	dec a
	ret nz
	jp UseDisposableItem
; f763

NoEffect: ; f77d
	jp IsntTheTimeMessage
; f780


Play_SFX_FULL_HEAL: ; f780
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	pop de
	ret
; f789

UseItemText: ; f789
	ld hl, UsedItemText
	call PrintText
	call Play_SFX_FULL_HEAL
	call WaitPressAorB_BlinkCursor
UseDisposableItem: ; f795
	ld hl, wNumItems
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	jp TossItem
; f7a0

UseBallInTrainerBattle: ; f7a0
	call ReturnToBattle_UseBall
	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a
	xor a
	ld [wBattleAnimParam], a
	ld [hBattleTurn], a
	ld [wNumHits], a
	predef PlayBattleAnim
	ld hl, BlockedTheBallText
	call PrintText
	ld hl, DontBeAThiefText
	call PrintText
	jr UseDisposableItem
; f7ca

LooksBitterMessage: ; f7d6
	ld hl, LooksBitterText
	jp PrintText
; f7dc

WontHaveAnyEffect_NotUsedMessage: ; f7ca
	ld hl, WontHaveAnyEffectText
	jr ItemWasntUsedMessage
; f7d6

Ball_BoxIsFullMessage: ; f7dc
	ld hl, Ball_BoxIsFullText
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
	cp PARK_BALL
	ret z
	cp SAFARI_BALL
	ret z

ItemWasntUsedMessage:
	; Item wasn't used.
	ld a, $2
	ld [wItemEffectSucceeded], a
	jp PrintText
; f7e8

CantUseOnEggMessage: ; f7e8
	ld hl, CantUseOnEggText
	jr CantUseItemMessage

IsntTheTimeMessage: ; f7ed
	ld hl, IsntTheTimeText
	jr CantUseItemMessage

WontHaveAnyEffectMessage: ; f7f2
	ld hl, WontHaveAnyEffectText
	; fallthrough

CantUseItemMessage: ; f804
; Item couldn't be used.
	call PrintText
	; fallthrough
ItemNotUsed_ExitMenu:
	xor a
	ld [wItemEffectSucceeded], a
	ret

LooksBitterText: ; 0xf80b
	; It looks bitter…
	text_jump UnknownText_0x1c5d3e
	db "@"
; 0xf810

CantUseOnEggText: ; 0xf810
	; That can't be used on an EGG.
	text_jump UnknownText_0x1c5d50
	db "@"
; 0xf815

IsntTheTimeText: ; 0xf815
	; OAK:  ! This isn't the time to use that!
	text_jump UnknownText_0x1c5d6e
	db "@"
; 0xf81a

WontHaveAnyEffectText: ; 0xf81f
	; It won't have any effect.
	text_jump UnknownText_0x1c5db6
	db "@"
; 0xf824

BlockedTheBallText: ; 0xf824
	; The trainer blocked the BALL!
	text_jump UnknownText_0x1c5dd0
	db "@"
; 0xf829

DontBeAThiefText: ; 0xf829
	; Don't be a thief!
	text_jump UnknownText_0x1c5def
	db "@"
; 0xf82e

Ball_BoxIsFullText: ; 0xf838
	; The #MON BOX is full. That can't be used now.
	text_jump UnknownText_0x1c5e3a
	db "@"
; 0xf83d

Ball_MonIsHiddenText:
	; The #MON can't be seen!
	text_jump Text_MonIsHiddenFromBall
	db "@"

Ball_MonCantBeCaughtText:
	; The #MON can't be caught!
	text_jump Text_MonCantBeCaught
	db "@"

Ball_NuzlockeFailureText:
	; You already encountered a #MON here.
	text_jump Text_NuzlockeBallFailure
	db "@"

Revive_NuzlockeFailureText:
	; You can't revive #MON in NUZLOCKE mode!
	text_jump Text_NuzlockeReviveFailure
	db "@"

UsedItemText: ; 0xf83d
	; used the@ .
	text_jump UnknownText_0x1c5e68
	db "@"
; 0xf842


ApplyPPUp: ; f84c
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
	ld a, [wd265]
	dec a
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
; f881



ComputeMaxPP: ; f881
	push bc
	; Divide the base PP by 5.
	ld a, [de]
	ld [hDividend + 3], a
	xor a
	ld [hDividend], a
	ld [hDividend + 1], a
	ld [hDividend + 2], a
	ld a, 5
	ld [hDivisor], a
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
	ld a, [hQuotient + 2]
	cp $8
	jr c, .okay
	ld a, $7

.okay
	add b
	ld b, a
	ld a, [wd265]
	dec a
	jr z, .NoPPUp
	dec c
	jr nz, .loop

.NoPPUp:
	ld [hl], b
	pop bc
	ret
; f8b9

RestoreAllPP: ; f8b9
	ld a, MON_PP
	call GetPartyParamLocation
	push hl
	ld a, MON_MOVES
	call GetPartyParamLocation
	pop de
	xor a ; PARTYMON
	ld [wMenuCursorY], a
	ld [wMonType], a
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
	and 3 << 6
	ld b, a
	ld a, [wd265]
	add b
	ld [de], a
	inc de
	ld hl, wMenuCursorY
	inc [hl]
	pop hl
	dec c
	jr nz, .loop
	ret
; f8ec


GetMaxPPOfMove: ; f8ec
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
	jr z, .got_nonpartymon ; BREEDMON

	ld hl, wBattleMonMoves ; WILDMON

.got_nonpartymon ; BOXMON, BREEDMON, WILDMON
	call GetMthMoveOfCurrentMon
	jr .gotdatmove

.got_partymon ; PARTYMON, OTPARTYMON
	call GetMthMoveOfNthPartymon

.gotdatmove
	ld a, [hl]
	dec a

	push hl
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
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
	and 3 << 6
	pop bc

	or b
	ld hl, wStringBuffer1 + 1
	ld [hl], a
	xor a
	ld [wd265], a
	call ComputeMaxPP
	ld a, [hl]
	and (1 << 6) - 1
	ld [wd265], a

	pop af
	ld [wStringBuffer1 + 1], a
	pop af
	ld [wStringBuffer1 + 0], a
	ret
; f963

GetMthMoveOfNthPartymon: ; f963
	ld a, [wCurPartyMon]
	rst AddNTimes

GetMthMoveOfCurrentMon: ; f969
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ret
; f971

AbilityCap:
; If a pokémon doesn't have its hidden ability, switch between its
; 1st and 2nd ability
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
.loop
	ret c

	push hl
	ld a, MON_ABILITY
	call GetPartyParamLocation
	ld a, [hl]
	and ABILITY_MASK
	cp HIDDEN_ABILITY
	jr z, .no_effect

	; Check if the ability would change
	ld d, h
	ld e, l
	pop hl
	push hl
	push de
	call UseItem_GetBaseDataAndNickParameters
	pop de
	ld a, [wBaseAbility1]
	ld b, a
	ld a, [wBaseAbility2]
	cp b
	jr z, .no_effect

	; Ability would change: ask for a confirmation
	ld a, [de]
	and ABILITY_MASK
	cp ABILITY_1
	ld a, [wBaseAbility2]
	ld c, ABILITY_2
	jr z, .got_new_ability
	ld a, [wBaseAbility1]
	ld c, ABILITY_1
.got_new_ability
	ld b, a
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
	and $ff ^ ABILITY_MASK
	or c
	ld [de], a

	call UseDisposableItem
	ld hl, AbilityChangedText
	jp PrintText

.no_effect
	call WontHaveAnyEffectMessage
	pop hl
.loopnext
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon2
	jr .loop

ChangeAbilityToText:
	text "Change ability to"
	line "@"
	text_from_ram wStringBuffer1
	text "?"
	done

AbilityChangedText:
	text "The ability was"
	line "changed!"
	prompt

INCLUDE "engine/battle_anims/pokeball_wobble.asm"
