PlayRadioShow:
; If we're already in the radio program proper, we don't need to be here.
	ld a, [wCurRadioLine]
	cp POKE_FLUTE_RADIO
	jr nc, .ok
; If Team Rocket is not occupying the radio tower, we don't need to be here.
	ld a, [wStatusFlags2]
	bit 0, a ; ENGINE_ROCKETS_IN_RADIO_TOWER
	jr z, .ok
; If we're in Kanto, we don't need to be here.
	call GetCurrentLandmark
	cp KANTO_LANDMARK
	jr nc, .ok
; Team Rocket broadcasts on all stations.
	ld a, ROCKET_RADIO
	ld [wCurRadioLine], a
.ok
; Jump to the currently loaded station.  The index to which we need to jump is in wCurRadioLine.
	ld a, [wCurRadioLine]
	call StackJumpTable

RadioJumptable:
	dw OaksPkmnTalk1  ; $00
	dw PokedexShow1 ; $01
	dw BenMonMusic1  ; $02
	dw LuckyNumberShow1 ; $03
	dw BuenasPassword1 ; $04
	dw PeoplePlaces1 ; $05
	dw FernMonMusic1 ; $06
	dw RocketRadio1 ; $07
	dw PokeFluteRadio ; $08
	dw UnownRadio ; $09
	dw EvolutionRadio ; $0a
; OaksPkmnTalk
	dw OaksPkmnTalk2  ; $0b
	dw OaksPkmnTalk3  ; $0c
	dw OaksPkmnTalk4  ; $0d
	dw OaksPkmnTalk5  ; $0e
	dw OaksPkmnTalk6  ; $0f
	dw OaksPkmnTalk7  ; $10
	dw OaksPkmnTalk8  ; $11
	dw OaksPkmnTalk9  ; $12
	dw PokedexShow2 ; $13
	dw PokedexShow3 ; $14
	dw PokedexShow4 ; $15
	dw PokedexShow5 ; $16
; Ben Music
	dw BenMonMusic2  ; $17
	dw BenMonMusic3  ; $18
	dw BenFernMusic4 ; $19
	dw BenFernMusic5 ; $1a
	dw BenFernMusic6 ; $1b
	dw DoNothing     ; $1c
	dw FernMonMusic2 ; $1d
; Lucky Number Show
	dw LuckyNumberShow2 ; $1e
	dw LuckyNumberShow3 ; $1f
	dw LuckyNumberShow4 ; $20
	dw LuckyNumberShow5 ; $21
	dw LuckyNumberShow6 ; $22
	dw LuckyNumberShow7 ; $23
	dw LuckyNumberShow8 ; $24
	dw LuckyNumberShow9 ; $25
	dw LuckyNumberShow10 ; $26
	dw LuckyNumberShow11 ; $27
	dw LuckyNumberShow12 ; $28
	dw LuckyNumberShow13 ; $29
	dw LuckyNumberShow14 ; $2a
	dw LuckyNumberShow15 ; $2b
; People & Places
	dw PeoplePlaces2 ; $2c
	dw PeoplePlaces3 ; $2d
	dw PeoplePlaces4 ; $2e
	dw PeoplePlaces5 ; $2f
	dw PeoplePlaces6 ; $30
	dw PeoplePlaces7 ; $31
; Rocket Radio
	dw RocketRadio2 ; $32
	dw RocketRadio3 ; $33
	dw RocketRadio4 ; $34
	dw RocketRadio5 ; $35
	dw RocketRadio6 ; $36
	dw RocketRadio7 ; $37
	dw RocketRadio8 ; $38
	dw RocketRadio9 ; $39
	dw RocketRadio10 ; $3a
; More Pokemon Channel stuff
	dw OaksPkmnTalk10 ; $3b
	dw OaksPkmnTalk11 ; $3c
	dw OaksPkmnTalk12 ; $3d
	dw OaksPkmnTalk13 ; $3e
	dw OaksPkmnTalk14 ; $3f
; Buenas Password
	dw BuenasPassword2 ; $40
	dw BuenasPassword3 ; $41
	dw BuenasPassword4 ; $42
	dw BuenasPassword5 ; $43
	dw BuenasPassword6 ; $44
	dw BuenasPassword7 ; $45
	dw BuenasPassword8 ; $46
	dw BuenasPassword9 ; $47
	dw BuenasPassword10 ; $48
	dw BuenasPassword11 ; $49
	dw BuenasPassword12 ; $4a
	dw BuenasPassword13 ; $4b
	dw BuenasPassword14 ; $4c
	dw BuenasPassword15 ; $4d
	dw BuenasPassword16 ; $4e
	dw BuenasPassword17 ; $4f
	dw BuenasPassword18 ; $50
	dw BuenasPassword19 ; $51
	dw BuenasPassword20 ; $52
	dw BuenasPassword21 ; $53
	dw RadioScroll ; $54
; More Pokemon Channel stuff
	dw PokedexShow6 ; $55
	dw PokedexShow7 ; $56
	dw PokedexShow8 ; $57

NextRadioLine:
	push af
	call CopyRadioTextToRAM
	pop af
	; fallthrough

PrintRadioLine:
	ld [wNextRadioLine], a
	ld hl, wRadioText
	ld a, [wNumRadioLinesPrinted]
	cp 2
	jr nc, .print
	inc hl
	ld [hl], "<START>"
	inc a
	ld [wNumRadioLinesPrinted], a
	cp 2
	jr nz, .print
	bccoord 1, 16
	call PlaceWholeStringInBoxAtOnce
	jr .skip
.print
	call PrintTextboxText
.skip
	ld a, RADIO_SCROLL
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	ret

RadioScroll:
	ld hl, wRadioTextDelay
	ld a, [hl]
	and a
	jr z, .proceed
	dec [hl]
	ret
.proceed
	ld a, [wNextRadioLine]
	ld [wCurRadioLine], a
	ld a, [wNumRadioLinesPrinted]
	cp 1
	call nz, CopyBottomLineToTopLine
	jp ClearBottomLine

OaksPkmnTalk1:
	ld a, 5
	ld [wOaksPkmnTalkSegmentCounter], a
	call StartRadioStation
	ld hl, OPT_IntroText1
	ld a, OAKS_POKEMON_TALK_2
	jp NextRadioLine

OaksPkmnTalk2:
	ld hl, OPT_IntroText2
	ld a, OAKS_POKEMON_TALK_3
	jp NextRadioLine

OaksPkmnTalk3:
	ld hl, OPT_IntroText3
	ld a, OAKS_POKEMON_TALK_4
	jp NextRadioLine

OaksPkmnTalk4:
; Choose a random route, and a random Pokemon from that route.
	call Random
	and $1f
	cp (OaksPkmnTalkRoutes.End - OaksPkmnTalkRoutes) / 2
	jr nc, OaksPkmnTalk4
	; We now have a number between 0 and 14.
	ld hl, OaksPkmnTalkRoutes
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	; bc now contains the chosen map's group and number indices.
	push bc

	; Search the JohtoGrassWildMons array for the chosen map.
	ld hl, JohtoGrassWildMons
.loop
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	cp -1
	jr z, .overflow
	inc hl
	cp b
	jr nz, .next
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	cp c
	jr z, .done
.next
	dec hl
	ld de, GRASS_WILDDATA_LENGTH
	add hl, de
	jr .loop

.done
rept 4
	inc hl
endr
	; Generate a number, either 0, 1, or 2, to choose a time of day.
	; (Disallows EVE.)
.loop2
	call Random
	and 3
	cp 3
	jr z, .loop2

	ld bc, 2 * NUM_GRASSMON
	rst AddNTimes
.loop3
	; Choose one of the middle three Pokemon.
	call Random
	and NUM_GRASSMON
	cp 2
	jr c, .loop3
	cp 5
	jr nc, .loop3
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	inc hl ; skip level
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld [wNamedObjectIndexBuffer], a
	ld [wCurPartySpecies], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	; Now that we've chosen our wild Pokemon,
	; let's recover the map index info and get its name.
	pop bc
	call GetWorldMapLocation
	ld e, a
	farcall GetLandmarkName
	ld hl, OPT_OakText1
	call CopyRadioTextToRAM
	ld a, OAKS_POKEMON_TALK_5
	jp PrintRadioLine

.overflow
	pop bc
	ld a, OAKS_POKEMON_TALK
	jp PrintRadioLine

INCLUDE "data/radio/oaks_pkmn_talk_routes.asm"

OaksPkmnTalk5:
	ld hl, OPT_OakText2
	ld a, OAKS_POKEMON_TALK_6
	jp NextRadioLine

OaksPkmnTalk6:
	ld hl, OPT_OakText3
	ld a, OAKS_POKEMON_TALK_7
	jp NextRadioLine

OPT_IntroText1:
	; MARY: PROF.OAK'S
	text_jump _OPT_IntroText1
	text_end

OPT_IntroText2:
	; #MON TALK!
	text_jump _OPT_IntroText2
	text_end

OPT_IntroText3:
	; With me, MARY!
	text_jump _OPT_IntroText3
	text_end

OPT_OakText1:
	; OAK: @ @
	text_jump _OPT_OakText1
	text_end

OPT_OakText2:
	; may be seen around
	text_jump _OPT_OakText2
	text_end

OPT_OakText3:
	; @ .
	text_jump _OPT_OakText3
	text_end

OaksPkmnTalk7:
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, OPT_MaryText1
	ld a, OAKS_POKEMON_TALK_8
	jp NextRadioLine

OPT_MaryText1:
	; MARY: @ 's
	text_jump _OPT_MaryText1
	text_end

OaksPkmnTalk8:
	call Random
	and $f
	ld e, a
	ld d, 0
	ld hl, .Descriptors
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, OAKS_POKEMON_TALK_9
	jp NextRadioLine

.Descriptors:
	dw .sweetadorably
	dw .wigglyslickly
	dw .aptlynamed
	dw .undeniablykindof
	dw .unbearably
	dw .wowimpressively
	dw .almostpoisonously
	dw .sensually
	dw .mischievously
	dw .topically
	dw .addictively
	dw .looksinwater
	dw .evolutionmustbe
	dw .provocatively
	dw .flippedout
	dw .heartmeltingly

.sweetadorably
	; sweet and adorably
	text_jump OPT_SweetAdorably
	text_end

.wigglyslickly
	; wiggly and slickly
	text_jump OPT_WigglySlickly
	text_end

.aptlynamed
	; aptly named and
	text_jump OPT_AptlyNamed
	text_end

.undeniablykindof
	; undeniably kind of
	text_jump OPT_UndeniablyKindOf
	text_end

.unbearably
	; so, so unbearably
	text_jump OPT_Unbearably
	text_end

.wowimpressively
	; wow, impressively
	text_jump OPT_WowImpressively
	text_end

.almostpoisonously
	; almost poisonously
	text_jump OPT_AlmostPoisonously
	text_end

.sensually
	; ooh, so sensually
	text_jump OPT_Sensually
	text_end

.mischievously
	; so mischievously
	text_jump OPT_Mischievously
	text_end

.topically
	; so very topically
	text_jump OPT_Topically
	text_end

.addictively
	; sure addictively
	text_jump OPT_Addictively
	text_end

.looksinwater
	; looks in water is
	text_jump OPT_LooksInWater
	text_end

.evolutionmustbe
	; evolution must be
	text_jump OPT_EvolutionMustBe
	text_end

.provocatively
	; provocatively
	text_jump OPT_Provocatively
	text_end

.flippedout
	; so flipped out and
	text_jump OPT_FlippedOut
	text_end

.heartmeltingly
	; heart-meltingly
	text_jump OPT_HeartMeltingly
	text_end

OaksPkmnTalk9:
	call Random
	and $f
	ld e, a
	ld d, 0
	ld hl, .Descriptors
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wOaksPkmnTalkSegmentCounter]
	dec a
	ld [wOaksPkmnTalkSegmentCounter], a
	ld a, OAKS_POKEMON_TALK_4
	jr nz, .ok
	ld a, 5
	ld [wOaksPkmnTalkSegmentCounter], a
	ld a, OAKS_POKEMON_TALK_10
.ok
	jp NextRadioLine

.Descriptors:
	dw .cute
	dw .weird
	dw .pleasant
	dw .boldsortof
	dw .frightening
	dw .suavedebonair
	dw .powerful
	dw .exciting
	dw .groovy
	dw .inspiring
	dw .friendly
	dw .hothothot
	dw .stimulating
	dw .guarded
	dw .lovely
	dw .speedy

.cute
	; cute.
	text_jump OPT_Cute
	text_end

.weird
	; weird.
	text_jump OPT_Weird
	text_end

.pleasant
	; pleasant.
	text_jump OPT_Pleasant
	text_end

.boldsortof
	; bold, sort of.
	text_jump OPT_BoldSortOf
	text_end

.frightening
	; frightening.
	text_jump OPT_Frightening
	text_end

.suavedebonair
	; suave & debonair!
	text_jump OPT_SuaveDebonair
	text_end

.powerful
	; powerful.
	text_jump OPT_Powerful
	text_end

.exciting
	; exciting.
	text_jump OPT_Exciting
	text_end

.groovy
	; groovy!
	text_jump OPT_Groovy
	text_end

.inspiring
	; inspiring.
	text_jump OPT_Inspiring
	text_end

.friendly
	; friendly.
	text_jump OPT_Friendly
	text_end

.hothothot
	; hot, hot, hot!
	text_jump OPT_HotHotHot
	text_end

.stimulating
	; stimulating.
	text_jump OPT_Stimulating
	text_end

.guarded
	; guarded.
	text_jump OPT_Guarded
	text_end

.lovely
	; lovely.
	text_jump OPT_Lovely
	text_end

.speedy
	; speedy.
	text_jump OPT_Speedy
	text_end

OaksPkmnTalk10:
	farcall RadioMusicRestartPokemonChannel
	ld hl, EmptyString
	call PrintText
	call ApplyTilemapInVBlank
	ld hl, OPT_PokemonChannelText
	call PrintText
	ld a, OAKS_POKEMON_TALK_11
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	ret

OPT_PokemonChannelText:
	; #MON
	text_jump _OPT_PokemonChannelText
	text_end

OaksPkmnTalk11:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 9, 14
	ld de, .pokemon_string
	ld a, OAKS_POKEMON_TALK_12
	jp PlaceRadioString

.pokemon_string
	db "#mon@"

OaksPkmnTalk12:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 1, 16
	ld de, .pokemon_channel_string
	ld a, OAKS_POKEMON_TALK_13
	jp PlaceRadioString

.pokemon_channel_string
	db "#mon Channel@"

OaksPkmnTalk13:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 12, 16
	ld de, EmptyString
	ld a, OAKS_POKEMON_TALK_14
	jp PlaceRadioString

OaksPkmnTalk14:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	ld de, MUSIC_POKEMON_TALK
	farcall RadioMusicRestartDE
	ld hl, EmptyString
	call PrintText
	ld a, OAKS_POKEMON_TALK_4
	ld [wNextRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	ld a, RADIO_SCROLL
	ld [wCurRadioLine], a
	ld a, 10
	ld [wRadioTextDelay], a
	ret

PlaceRadioString:
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	rst PlaceString
	ret

CopyBottomLineToTopLine:
	hlcoord 0, 15
	decoord 0, 13
	ld bc, SCREEN_WIDTH * 2
	rst CopyBytes
	ret

ClearBottomLine:
	hlcoord 1, 15
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	rst ByteFill
	hlcoord 1, 16
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	rst ByteFill
	ret

PokedexShow1:
	call StartRadioStation
.loop
	call Random
	cp NUM_POKEMON
	jr nc, .loop
	ld c, a
	push bc
	ld a, c
	call CheckCaughtMon
	pop bc
	jr z, .loop
	inc c
	ld a, c
	ld [wCurPartySpecies], a
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, PokedexShowText
	ld a, POKEDEX_SHOW_2
	jp NextRadioLine

PokedexShow2:
	ld a, [wCurPartySpecies]
	dec a
	ld hl, PokedexDataPointerTable
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, BANK(PokedexDataPointerTable)
	call GetFarByte
	ld b, a
	inc hl
	ld a, BANK(PokedexDataPointerTable)
	call GetFarHalfword
	ld a, b
	push af
	push hl
	call CopyDexEntryPart1
	dec hl
	ld [hl], "<DONE>"
	ld hl, wPokedexShowPointerAddr
	call CopyRadioTextToRAM
	pop hl
	pop af
	call CopyDexEntryPart2
rept 4
	inc hl
endr
;	call GetFarByte
;	cp $2f
;	jr nz, .load
;	inc hl
;	ld a, [wOptions2]
;	bit POKEDEX_UNITS, a
;	jr z, .imperial
;	ld a, d
;	call GetFarHalfword
;	jr .load
;.imperial
;	inc hl
;	inc hl
;.load
	ld a, l
	ld [wPokedexShowPointerAddr], a
	ld a, h
	ld [wPokedexShowPointerAddr + 1], a
	ld a, POKEDEX_SHOW_3
	jp PrintRadioLine

PokedexShow3:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_4
	jp PrintRadioLine

PokedexShow4:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_5
	jp PrintRadioLine

PokedexShow5:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_6
	jp PrintRadioLine

PokedexShow6:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_7
	jp PrintRadioLine

PokedexShow7:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_8
	jp PrintRadioLine

PokedexShow8:
	call CopyDexEntry
	ld a, POKEDEX_SHOW
	jp PrintRadioLine

CopyDexEntry:
	ld hl, wPokedexShowPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wPokedexShowPointerBank]
	push af
	push hl
	call CopyDexEntryPart1
	dec hl
	ld [hl], "<DONE>"
	ld hl, wPokedexShowPointerAddr
	call CopyRadioTextToRAM
	pop hl
	pop af
	jp CopyDexEntryPart2

CopyDexEntryPart1:
	ld de, wPokedexShowPointerBank
	ld bc, SCREEN_WIDTH - 1
	call FarCopyBytes
	ld hl, wPokedexShowPointerAddr
	ld [hl], "<START>"
	inc hl
	ld [hl], "<LINE>"
	inc hl
.loop
	ld a, [hli]
	cp "@"
	ret z
	cp "<NEXT>"
	ret z
	jr .loop

CopyDexEntryPart2:
	ld d, a
.loop
	ld a, d
	call GetFarByte
	inc hl
	cp "@"
	jr z, .okay
	cp "<NEXT>"
	jr nz, .loop
.okay
	ld a, l
	ld [wPokedexShowPointerAddr], a
	ld a, h
	ld [wPokedexShowPointerAddr + 1], a
	ld a, d
	ld [wPokedexShowPointerBank], a
	ret

PokedexShowText:
	; @ @
	text_jump _PokedexShowText
	text_end

BenMonMusic1:
	call StartPokemonMusicChannel
	ld hl, BenIntroText1
	ld a, POKEMON_MUSIC_2
	jp NextRadioLine

BenMonMusic2:
	ld hl, BenIntroText2
	ld a, POKEMON_MUSIC_3
	jp NextRadioLine

BenMonMusic3:
	ld hl, BenIntroText3
	ld a, POKEMON_MUSIC_4
	jp NextRadioLine

FernMonMusic1:
	call StartPokemonMusicChannel
	ld hl, FernIntroText1
	ld a, LETS_ALL_SING_2
	jp NextRadioLine

FernMonMusic2:
	ld hl, FernIntroMusic2
	ld a, POKEMON_MUSIC_4
	jp NextRadioLine

BenFernMusic4:
	ld hl, BenFernText1
	ld a, POKEMON_MUSIC_5
	jp NextRadioLine

BenFernMusic5:
	call GetWeekday
	and 1
	ld hl, BenFernText2A
	jr z, .SunTueThurSun
	ld hl, BenFernText2B
.SunTueThurSun:
	ld a, POKEMON_MUSIC_6
	jp NextRadioLine

BenFernMusic6:
	call GetWeekday
	and 1
	ld hl, BenFernText3A
	jr z, .SunTueThurSun
	ld hl, BenFernText3B
.SunTueThurSun:
	ld a, POKEMON_MUSIC_7
	jp NextRadioLine

StartPokemonMusicChannel:
	ld hl, EmptyString
	call PrintText
	ld de, MUSIC_POKEMON_MARCH
	call GetWeekday
	and 1
	jr z, .SunTueThurSun
	ld de, MUSIC_POKEMON_LULLABY
.SunTueThurSun:
	farjp RadioMusicRestartDE

BenIntroText1:
	; BEN: #MON MUSIC
	text_jump _BenIntroText1
	text_end

BenIntroText2:
	; CHANNEL!
	text_jump _BenIntroText2
	text_end

BenIntroText3:
	; It's me, DJ BEN!
	text_jump _BenIntroText3
	text_end

FernIntroText1:
	; FERN: #MUSIC!
	text_jump _FernIntroText1
	text_end

FernIntroMusic2:
	; With DJ FERN!
	text_jump _FernIntroText2
	text_end

BenFernText1:
	; Today's @ ,
	text_jump _BenFernText1
	text_end

BenFernText2A:
	; so let us jam to
	text_jump _BenFernText2A
	text_end

BenFernText2B:
	; so chill out to
	text_jump _BenFernText2B
	text_end

BenFernText3A:
	; #MON March!
	text_jump _BenFernText3A
	text_end

BenFernText3B:
	; #MON Lullaby!
	text_jump _BenFernText3B
	text_end

LuckyNumberShow1:
	call StartRadioStation
	farcall Special_CheckLuckyNumberShowFlag
	jr nc, .dontreset
	farcall Special_ResetLuckyNumberShowFlag
.dontreset
	ld hl, LC_Text1
	ld a, LUCKY_NUMBER_SHOW_2
	jp NextRadioLine

LuckyNumberShow2:
	ld hl, LC_Text2
	ld a, LUCKY_NUMBER_SHOW_3
	jp NextRadioLine

LuckyNumberShow3:
	ld hl, LC_Text3
	ld a, LUCKY_NUMBER_SHOW_4
	jp NextRadioLine

LuckyNumberShow4:
	ld hl, LC_Text4
	ld a, LUCKY_NUMBER_SHOW_5
	jp NextRadioLine

LuckyNumberShow5:
	ld hl, LC_Text5
	ld a, LUCKY_NUMBER_SHOW_6
	jp NextRadioLine

LuckyNumberShow6:
	ld hl, LC_Text6
	ld a, LUCKY_NUMBER_SHOW_7
	jp NextRadioLine

LuckyNumberShow7:
	ld hl, LC_Text7
	ld a, LUCKY_NUMBER_SHOW_8
	jp NextRadioLine

LuckyNumberShow8:
	ld hl, wStringBuffer1
	ld de, wLuckyIDNumber
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld a, "@"
	ld [wStringBuffer1 + 5], a
	ld hl, LC_Text8
	ld a, LUCKY_NUMBER_SHOW_9
	jp NextRadioLine

LuckyNumberShow9:
	ld hl, LC_Text9
	ld a, LUCKY_NUMBER_SHOW_10
	jp NextRadioLine

LuckyNumberShow10:
	ld hl, LC_Text7
	ld a, LUCKY_NUMBER_SHOW_11
	jp NextRadioLine

LuckyNumberShow11:
	ld hl, LC_Text8
	ld a, LUCKY_NUMBER_SHOW_12
	jp NextRadioLine

LuckyNumberShow12:
	ld hl, LC_Text10
	ld a, LUCKY_NUMBER_SHOW_13
	jp NextRadioLine

LuckyNumberShow13:
	ld hl, LC_Text11
	call Random
	and a
	ld a, LUCKY_CHANNEL
	jr nz, .okay
	ld a, LUCKY_NUMBER_SHOW_14
.okay
	jp NextRadioLine

LuckyNumberShow14:
	ld hl, LC_DragText1
	ld a, LUCKY_NUMBER_SHOW_15
	jp NextRadioLine

LuckyNumberShow15:
	ld hl, LC_DragText2
	ld a, LUCKY_CHANNEL
	jp NextRadioLine

LC_Text1:
	; REED: Yeehaw! How
	text_jump _LC_Text1
	text_end

LC_Text2:
	; y'all doin' now?
	text_jump _LC_Text2
	text_end

LC_Text3:
	; Whether you're up
	text_jump _LC_Text3
	text_end

LC_Text4:
	; or way down low,
	text_jump _LC_Text4
	text_end

LC_Text5:
	; don't you miss the
	text_jump _LC_Text5
	text_end

LC_Text6:
	; LUCKY NUMBER SHOW!
	text_jump _LC_Text6
	text_end

LC_Text7:
	; This week's Lucky
	text_jump _LC_Text7
	text_end

LC_Text8:
	; Number is @ !
	text_jump _LC_Text8
	text_end

LC_Text9:
	; I'll repeat that!
	text_jump _LC_Text9
	text_end

LC_Text10:
	; Match it and go to
	text_jump _LC_Text10
	text_end

LC_Text11:
	; the RADIO TOWER!
	text_jump _LC_Text11
	text_end

LC_DragText1:
	; …Repeating myself
	text_jump _LC_DragText1
	text_end

LC_DragText2:
	; gets to be a drag…
	text_jump _LC_DragText2
	text_end

PeoplePlaces1:
	call StartRadioStation
	ld hl, PnP_Text1
	ld a, PLACES_AND_PEOPLE_2
	jp NextRadioLine

PeoplePlaces2:
	ld hl, PnP_Text2
	ld a, PLACES_AND_PEOPLE_3
	jp NextRadioLine

PeoplePlaces3:
	ld hl, PnP_Text3
	call PickPeopleOrPlaces
	jp NextRadioLine

PnP_Text1:
	; PLACES AND PEOPLE!
	text_jump _PnP_Text1
	text_end

PnP_Text2:
	; Brought to you by
	text_jump _PnP_Text2
	text_end

PnP_Text3:
	; me, DJ LILY!
	text_jump _PnP_Text3
	text_end

PeoplePlaces4: ; People
	call Random
	cp NUM_TRAINER_CLASSES - 1
	jr nc, PeoplePlaces4
	inc a
	push af
	ld hl, PnP_HiddenPeople
	ld a, [wStatusFlags]
	bit 6, a ; ENGINE_CREDITS_SKIP
	jr z, .ok
	ld hl, PnP_HiddenPeople_BeatE4
	ld a, [wKantoBadges]
	cp %11111111
	jr nz, .ok
	ld hl, PnP_HiddenPeople_BeatKanto
.ok
	pop af
	ld c, a
	ld de, 1
	push bc
	call IsInArray
	pop bc
	jr c, PeoplePlaces4
	push bc
	farcall GetTrainerClassName
	ld de, wStringBuffer1
	call CopyName1
	pop bc
	ld b, 1
	farcall GetTrainerName
	ld hl, PnP_Text4
	ld a, PLACES_AND_PEOPLE_5
	jp NextRadioLine

INCLUDE "data/radio/pnp_hidden_people.asm"

PnP_Text4:
	; @  @ @
	text_jump _PnP_Text4
	text_end

PeoplePlaces5:
	call Random
	and $f
	ld e, a
	ld d, 0
	ld hl, .Descriptors
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PickPeopleOrPlacesBiased
	jp NextRadioLine

.Descriptors:
	dw PnP_cute
	dw PnP_lazy
	dw PnP_happy
	dw PnP_noisy
	dw PnP_precocious
	dw PnP_bold
	dw PnP_picky
	dw PnP_sortofok
	dw PnP_soso
	dw PnP_great
	dw PnP_mytype
	dw PnP_cool
	dw PnP_inspiring
	dw PnP_weird
	dw PnP_rightforme
	dw PnP_odd

PnP_cute:
	; is cute.
	text_jump _PnP_cute
	text_end

PnP_lazy:
	; is sort of lazy.
	text_jump _PnP_lazy
	text_end

PnP_happy:
	; is always happy.
	text_jump _PnP_happy
	text_end

PnP_noisy:
	; is quite noisy.
	text_jump _PnP_noisy
	text_end

PnP_precocious:
	; is precocious.
	text_jump _PnP_precocious
	text_end

PnP_bold:
	; is somewhat bold.
	text_jump _PnP_bold
	text_end

PnP_picky:
	; is too picky!
	text_jump _PnP_picky
	text_end

PnP_sortofok:
	; is sort of OK.
	text_jump _PnP_sortofok
	text_end

PnP_soso:
	; is just so-so.
	text_jump _PnP_soso
	text_end

PnP_great:
	; is actually great.
	text_jump _PnP_great
	text_end

PnP_mytype:
	; is just my type.
	text_jump _PnP_mytype
	text_end

PnP_cool:
	; is so cool, no?
	text_jump _PnP_cool
	text_end

PnP_inspiring:
	; is inspiring!
	text_jump _PnP_inspiring
	text_end

PnP_weird:
	; is kind of weird.
	text_jump _PnP_weird
	text_end

PnP_rightforme:
	; is right for me?
	text_jump _PnP_rightforme
	text_end

PnP_odd:
	; is definitely odd!
	text_jump _PnP_odd
	text_end

PeoplePlaces6: ; Places
	call Random
	cp PnP_Places.End - PnP_Places
	jr nc, PeoplePlaces6
	ld hl, PnP_Places
	ld c, a
	ld b, 0
	add hl, bc
	ld e, [hl]
	farcall GetLandmarkName
	ld hl, PnP_Text5
	ld a, PLACES_AND_PEOPLE_7
	jp NextRadioLine

INCLUDE "data/radio/pnp_places.asm"

PnP_Text5:
	; @ @
	text_jump _PnP_Text5
	text_end

PeoplePlaces7:
	call Random
	and $f
	ld e, a
	ld d, 0
	ld hl, .Descriptors
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CopyRadioTextToRAM
	call PickPeopleOrPlacesBiased
	jp PrintRadioLine

.Descriptors:
	dw PnP_cute
	dw PnP_lazy
	dw PnP_happy
	dw PnP_noisy
	dw PnP_precocious
	dw PnP_bold
	dw PnP_picky
	dw PnP_sortofok
	dw PnP_soso
	dw PnP_great
	dw PnP_mytype
	dw PnP_cool
	dw PnP_inspiring
	dw PnP_weird
	dw PnP_rightforme
	dw PnP_odd

PickPeopleOrPlacesBiased:
	call Random
	cp 4 percent
	ld a, PLACES_AND_PEOPLE
	ret c
PickPeopleOrPlaces:
	call Random
	cp 1 + 48 percent
	; a = carry ? PLACES_AND_PEOPLE_4 (People) : PLACES_AND_PEOPLE_6 (Places)
	assert PLACES_AND_PEOPLE_4 + 2 == PLACES_AND_PEOPLE_6
	sbc a
	sbc -PLACES_AND_PEOPLE_6
	ret

RocketRadio1:
	call StartRadioStation
	ld hl, RocketRadioText1
	ld a, ROCKET_RADIO_2
	jp NextRadioLine

RocketRadio2:
	ld hl, RocketRadioText2
	ld a, ROCKET_RADIO_3
	jp NextRadioLine

RocketRadio3:
	ld hl, RocketRadioText3
	ld a, ROCKET_RADIO_4
	jp NextRadioLine

RocketRadio4:
	ld hl, RocketRadioText4
	ld a, ROCKET_RADIO_5
	jp NextRadioLine

RocketRadio5:
	ld hl, RocketRadioText5
	ld a, ROCKET_RADIO_6
	jp NextRadioLine

RocketRadio6:
	ld hl, RocketRadioText6
	ld a, ROCKET_RADIO_7
	jp NextRadioLine

RocketRadio7:
	ld hl, RocketRadioText7
	ld a, ROCKET_RADIO_8
	jp NextRadioLine

RocketRadio8:
	ld hl, RocketRadioText8
	ld a, ROCKET_RADIO_9
	jp NextRadioLine

RocketRadio9:
	ld hl, RocketRadioText9
	ld a, ROCKET_RADIO_10
	jp NextRadioLine

RocketRadio10:
	ld hl, RocketRadioText10
	ld a, ROCKET_RADIO
	jp NextRadioLine

RocketRadioText1:
	; … …Ahem, we are
	text_jump _RocketRadioText1
	text_end

RocketRadioText2:
	; TEAM ROCKET!
	text_jump _RocketRadioText2
	text_end

RocketRadioText3:
	; After three years
	text_jump _RocketRadioText3
	text_end

RocketRadioText4:
	; of preparation, we
	text_jump _RocketRadioText4
	text_end

RocketRadioText5:
	; have risen again
	text_jump _RocketRadioText5
	text_end

RocketRadioText6:
	; from the ashes!
	text_jump _RocketRadioText6
	text_end

RocketRadioText7:
	; GIOVANNI! @ Can you
	text_jump _RocketRadioText7
	text_end

RocketRadioText8:
	; hear?@  We did it!
	text_jump _RocketRadioText8
	text_end

RocketRadioText9:
	; @ Where is our boss?
	text_jump _RocketRadioText9
	text_end

RocketRadioText10:
	; @ Is he listening?
	text_jump _RocketRadioText10
	text_end

PokeFluteRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

UnownRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

EvolutionRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

BuenasPassword1:
; Determine if we need to be here
	call BuenasPasswordCheckTime
	jp nc, .PlayPassword
	ld a, [wNumRadioLinesPrinted]
	and a
	jp z, BuenasPassword20
	jp BuenasPassword8

.PlayPassword:
	call StartRadioStation
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld de, BuenasPasswordChannelName
	hlcoord 2, 9
	rst PlaceString
	pop af
	ldh [hBGMapMode], a
	ld hl, BuenaRadioText1
	ld a, BUENAS_PASSWORD_2
	jp NextRadioLine

BuenasPassword2:
	ld hl, BuenaRadioText2
	ld a, BUENAS_PASSWORD_3
	jp NextRadioLine

BuenasPassword3:
	call BuenasPasswordCheckTime
	ld hl, BuenaRadioText3
	jp c, BuenasPasswordAfterMidnight
	ld a, BUENAS_PASSWORD_4
	jp NextRadioLine

BuenasPassword4:
	call BuenasPasswordCheckTime
	jp c, BuenasPassword8
	ld a, [wBuenasPassword]
; If we already generated the password today, we don't need to generate a new one.
	ld hl, wWeeklyFlags
	bit 7, [hl]
	jr nz, .AlreadyGotIt
; There are only 11 groups to choose from.
.greater_than_11
	call Random
	and $f
	cp NUM_PASSWORD_CATEGORIES
	jr nc, .greater_than_11
; Store it in the high nybble of e.
	swap a
	ld e, a
; For each group, choose one of the three passwords.
.greater_than_three
	call Random
	and $3
	cp NUM_PASSWORDS_PER_CATEGORY
	jr nc, .greater_than_three
; The high nybble of wBuenasPassword will now contain the password group index, and the low nybble contains the actual password.
	add e
	ld [wBuenasPassword], a
; Set the flag so that we don't generate a new password this week.
	ld hl, wWeeklyFlags
	set 7, [hl]
.AlreadyGotIt:
	ld c, a
	call GetBuenasPassword
	ld hl, BuenaRadioText4
	ld a, BUENAS_PASSWORD_5
	jp NextRadioLine

GetBuenasPassword:
; The password indices are held in c.  High nybble contains the group index, low nybble contains the word index.
; Load the password group pointer in hl.
	ld a, c
	swap a
	and $f
	ld hl, BuenasPasswordTable
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
; Get the password type and store it in b.
	ld a, [hli]
	ld b, a
	push hl
	inc hl
; Get the password index.
	ld a, c
	and $f
	ld c, a
	push hl
	ld hl, .StringFunctionJumpTable
	ld e, b
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de ; de now contains the pointer to the value of this week's password, in Blue Card Points.
	call _hl_
	pop hl
	ld c, [hl]
	ret

.StringFunctionJumpTable:
	dw .Mon
	dw .Item
	dw .Move
	dw .RawString

.Mon:
	call .GetTheIndex
	jp GetPokemonName

.Item:
	call .GetTheIndex
	jp GetItemName

.Move:
	call .GetTheIndex
	jp GetMoveName

.GetTheIndex:
	ld h, 0
	ld l, c
	add hl, de
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	ret

.RawString:
; Get the string from the table...
	ld a, c
	and a
	jr z, .skip
.read_loop
	ld a, [de]
	inc de
	cp "@"
	jr nz, .read_loop
	dec c
	jr nz, .read_loop
; ... and copy it into wStringBuffer1.
.skip
	ld hl, wStringBuffer1
.copy_loop
	ld a, [de]
	inc de
	ld [hli], a
	cp "@"
	jr nz, .copy_loop
	ld de, wStringBuffer1
	ret

INCLUDE "data/radio/buenas_passwords.asm"

BuenasPassword5:
	ld hl, BuenaRadioText5
	ld a, BUENAS_PASSWORD_6
	jp NextRadioLine

BuenasPassword6:
	ld hl, BuenaRadioText6
	ld a, BUENAS_PASSWORD_7
	jp NextRadioLine

BuenasPassword7:
	call BuenasPasswordCheckTime
	ld hl, BuenaRadioText7
	jr c, BuenasPasswordAfterMidnight
	ld a, BUENAS_PASSWORD
	jp NextRadioLine

BuenasPasswordAfterMidnight:
	push hl
	ld hl, wWeeklyFlags
	res 7, [hl]
	pop hl
	ld a, BUENAS_PASSWORD_8
	jp NextRadioLine

BuenasPassword8:
	ld hl, wWeeklyFlags
	res 7, [hl]
	ld hl, BuenaRadioMidnightText10
	ld a, BUENAS_PASSWORD_9
	jp NextRadioLine

BuenasPassword9:
	ld hl, BuenaRadioMidnightText1
	ld a, BUENAS_PASSWORD_10
	jp NextRadioLine

BuenasPassword10:
	ld hl, BuenaRadioMidnightText2
	ld a, BUENAS_PASSWORD_11
	jp NextRadioLine

BuenasPassword11:
	ld hl, BuenaRadioMidnightText3
	ld a, BUENAS_PASSWORD_12
	jp NextRadioLine

BuenasPassword12:
	ld hl, BuenaRadioMidnightText4
	ld a, BUENAS_PASSWORD_13
	jp NextRadioLine

BuenasPassword13:
	ld hl, BuenaRadioMidnightText5
	ld a, BUENAS_PASSWORD_14
	jp NextRadioLine

BuenasPassword14:
	ld hl, BuenaRadioMidnightText6
	ld a, BUENAS_PASSWORD_15
	jp NextRadioLine

BuenasPassword15:
	ld hl, BuenaRadioMidnightText7
	ld a, BUENAS_PASSWORD_16
	jp NextRadioLine

BuenasPassword16:
	ld hl, BuenaRadioMidnightText8
	ld a, BUENAS_PASSWORD_17
	jp NextRadioLine

BuenasPassword17:
	ld hl, BuenaRadioMidnightText9
	ld a, BUENAS_PASSWORD_18
	jp NextRadioLine

BuenasPassword18:
	ld hl, BuenaRadioMidnightText10
	ld a, BUENAS_PASSWORD_19
	jp NextRadioLine

BuenasPassword19:
	ld hl, BuenaRadioMidnightText10
	ld a, BUENAS_PASSWORD_20
	jp NextRadioLine

BuenasPassword20:
	ldh a, [hBGMapMode]
	push af
	farcall NoRadioMusic
	farcall NoRadioName
	pop af
	ldh [hBGMapMode], a
	ld hl, wWeeklyFlags
	res 7, [hl]
	ld a, BUENAS_PASSWORD
	ld [wCurRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	ld hl, BuenaOffTheAirText
	ld a, BUENAS_PASSWORD_21
	jp NextRadioLine

BuenasPassword21:
	ld a, BUENAS_PASSWORD
	ld [wCurRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	call BuenasPasswordCheckTime
	jp nc, BuenasPassword1
	ld hl, BuenaOffTheAirText
	ld a, BUENAS_PASSWORD_21
	jp NextRadioLine

BuenasPasswordCheckTime:
	call UpdateTime
	ldh a, [hHours]
	cp EVE_HOUR
	ret

BuenasPasswordChannelName:
	db "Buena's Password@"

BuenaRadioText1:
	; BUENA: BUENA here!
	text_jump _BuenaRadioText1
	text_end

BuenaRadioText2:
	; Today's password!
	text_jump _BuenaRadioText2
	text_end

BuenaRadioText3:
	; Let me think… It's
	text_jump _BuenaRadioText3
	text_end

BuenaRadioText4:
	; @ !
	text_jump _BuenaRadioText4
	text_end

BuenaRadioText5:
	; Don't forget it!
	text_jump _BuenaRadioText5
	text_end

BuenaRadioText6:
	; I'm in GOLDENROD's
	text_jump _BuenaRadioText6
	text_end

BuenaRadioText7:
	; RADIO TOWER!
	text_jump _BuenaRadioText7
	text_end

BuenaRadioMidnightText1:
	; BUENA: Oh my…
	text_jump _BuenaRadioMidnightText1
	text_end

BuenaRadioMidnightText2:
	; It's midnight! I
	text_jump _BuenaRadioMidnightText2
	text_end

BuenaRadioMidnightText3:
	; have to shut down!
	text_jump _BuenaRadioMidnightText3
	text_end

BuenaRadioMidnightText4:
	; Thanks for tuning
	text_jump _BuenaRadioMidnightText4
	text_end

BuenaRadioMidnightText5:
	; in to the end! But
	text_jump _BuenaRadioMidnightText5
	text_end

BuenaRadioMidnightText6:
	; don't stay up too
	text_jump _BuenaRadioMidnightText6
	text_end

BuenaRadioMidnightText7:
	; late! Presented to
	text_jump _BuenaRadioMidnightText7
	text_end

BuenaRadioMidnightText8:
	; you by DJ BUENA!
	text_jump _BuenaRadioMidnightText8
	text_end

BuenaRadioMidnightText9:
	; I'm outta here!
	text_jump _BuenaRadioMidnightText9
	text_end

BuenaRadioMidnightText10:
	; …
	text_jump _BuenaRadioMidnightText10
	text_end

BuenaOffTheAirText:
	;
	text_jump _BuenaOffTheAirText
	text_end

CopyRadioTextToRAM:
	ld a, [hl]
	cp "<FAR>"
	jp z, FarCopyRadioText
	ld de, wRadioText
	ld bc, SCREEN_WIDTH * 2
	rst CopyBytes
	ret

StartRadioStation:
	ld a, [wNumRadioLinesPrinted]
	and a
	ret nz
	ld hl, EmptyString
	call PrintText
	ld hl, RadioChannelSongs
	ld a, [wCurRadioLine]
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	farjp RadioMusicRestartDE

INCLUDE "data/radio/channel_music.asm"
