GetFinalPkmnTextPointer::
	; Silver and Lyra have a phrase for each set of three IDs
	ld a, [OtherTrainerClass]
	ld hl, .triple_phrases
	call .findinarray
	jr c, .rival_or_lyra
	; Proton to Giovanni have a phrase for each ID
	ld a, [OtherTrainerClass]
	cp PROTON
	jr c, .not_rocket
	cp GIOVANNI + 1
	jr c, .rocket
.not_rocket
	; Leaf and below, and Prof. Oak and above, have one unique phrase
	dec a
	cp LEAF
	jr c, .single_phrase
	cp PROF_OAK - 1
	jr c, .nothing
	sub PROF_OAK - LEAF - 1
	jr .single_phrase

.nothing:
	xor a
	and a
	ret

.rival_or_lyra:
	ld a, [OtherTrainerID]
	dec a
	ld c, 3
	call SimpleDivide
	ld a, b
	jr .get_text

.rocket:
	; a = ([OtherTrainerClass] - PROTON) * 2 + [OtherTrainerID] - 1
	sub PROTON
	add a
	ld b, a
	ld a, [OtherTrainerID]
	dec a
	add b
	ld hl, .TeamRocketFinalTexts
	jr .get_text

.single_phrase:
	ld hl, .SinglePhraseFinalTexts
.get_text:
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc
	jr .finish

.findinarray:
	push de
	ld de, 3
	call IsInArray
	pop de
	ret nc
	inc hl
.finish:
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr z, .nothing
.done:
	scf
	ret

.triple_phrases:
	dbw RIVAL0, .Rival0FinalTexts
	dbw RIVAL1, .Rival1FinalTexts
	dbw RIVAL2, .Rival2FinalTexts
	dbw LYRA1, .Lyra1FinalTexts
	dbw LYRA2, .Lyra2FinalTexts
	db -1

.Rival0FinalTexts:
	dw Rival1_1FinalPkmnText

.Rival1FinalTexts:
	dw Rival1_2FinalPkmnText
	dw Rival1_3FinalPkmnText
	dw Rival1_4FinalPkmnText
	dw Rival1_5FinalPkmnText

.Rival2FinalTexts:
	dw Rival2_1FinalPkmnText
	dw Rival2_2FinalPkmnText

.Lyra1FinalTexts:
	dw Lyra1_1FinalPkmnText
	dw Lyra1_2FinalPkmnText
	dw Lyra1_3FinalPkmnText
	dw Lyra1_4FinalPkmnText

.Lyra2FinalTexts:
	dw Lyra2_1FinalPkmnText

.TeamRocketFinalTexts:
	dw Proton1FinalPkmnText
	dw Proton2FinalPkmnText
	dw Petrel1FinalPkmnText
	dw Petrel2FinalPkmnText
	dw Archer1FinalPkmnText
	dw Archer2FinalPkmnText
	dw Ariana1FinalPkmnText
	dw Ariana2FinalPkmnText
	dw Giovanni1FinalPkmnText
	dw Giovanni2FinalPkmnText

.SinglePhraseFinalTexts:
	dw CarrieFinalPkmnText
	dw CalFinalPkmnText
	dw FalknerFinalPkmnText
	dw BugsyFinalPkmnText
	dw WhitneyFinalPkmnText
	dw MortyFinalPkmnText
	dw ChuckFinalPkmnText
	dw JasmineFinalPkmnText
	dw PryceFinalPkmnText
	dw ClairFinalPkmnText
	dw WillFinalPkmnText
	dw KogaFinalPkmnText
	dw BrunoFinalPkmnText
	dw KarenFinalPkmnText
	dw ChampionFinalPkmnText
	dw BrockFinalPkmnText
	dw MistyFinalPkmnText
	dw LtSurgeFinalPkmnText
	dw ErikaFinalPkmnText
	dw JanineFinalPkmnText
	dw SabrinaFinalPkmnText
	dw BlaineFinalPkmnText
	dw BlueFinalPkmnText
	dw RedFinalPkmnText
	dw LeafFinalPkmnText
	; ...
	dw ProfOakFinalPkmnText
	dw ProfElmFinalPkmnText
	dw ProfIvyFinalPkmnText
	dw MysticalManFinalPkmnText
	dw KarateKingFinalPkmnText
	dw PalmerFinalPkmnText
	dw JessieJamesFinalPkmnText
	dw LoreleiFinalPkmnText
	dw AgathaFinalPkmnText
	dw StevenFinalPkmnText
	dw CynthiaFinalPkmnText
	dw InverFinalPkmnText
	dw CherylFinalPkmnText
	dw RileyFinalPkmnText
	dw BuckFinalPkmnText
	dw MarleyFinalPkmnText
	dw MiraFinalPkmnText
	dw AnabelFinalPkmnText
	dw DarachFinalPkmnText
	dw CaitlinFinalPkmnText
	dw CandelaFinalPkmnText
	dw BlancheFinalPkmnText
	dw SparkFinalPkmnText
	dw FlanneryFinalPkmnText
	dw MayleneFinalPkmnText
	dw SkylaFinalPkmnText
	dw ValerieFinalPkmnText
	dw KukuiFinalPkmnText ; Kukui
	dw NULL ; Victor
	dw BillFinalPkmnText
	dw YellowFinalPkmnText
	dw WalkerFinalPkmnText
	dw ImakuniFinalPkmnText
	dw LawrenceFinalPkmnText
	dw ReiFinalPkmnText
