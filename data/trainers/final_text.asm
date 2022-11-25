FinalTextList_TriplePhrases:
	dbw RIVAL0, .FinalText_Rival0
	dbw RIVAL1, .FinalText_Rival1
	dbw RIVAL2, .FinalText_Rival2
	dbw LYRA1,  .FinalText_Lyra1
	dbw LYRA2,  .FinalText_Lyra2
	db -1

.FinalText_Rival0:
	dw Rival1_1FinalPkmnText

.FinalText_Rival1:
	dw Rival1_2FinalPkmnText
	dw Rival1_3FinalPkmnText
	dw Rival1_4FinalPkmnText
	dw Rival1_5FinalPkmnText

.FinalText_Rival2:
	dw Rival2_1FinalPkmnText
	dw Rival2_2FinalPkmnText

.FinalText_Lyra1:
	dw Lyra1_1FinalPkmnText
	dw Lyra1_2FinalPkmnText
	dw Lyra1_3FinalPkmnText
	dw Lyra1_4FinalPkmnText

.FinalText_Lyra2:
	dw Lyra2_1FinalPkmnText

FinalText_TeamRocket:
	dw Proton1FinalPkmnText
	dw Proton2FinalPkmnText
	assert PROTON + 1 == PETREL
	dw Petrel1FinalPkmnText
	dw Petrel2FinalPkmnText
	assert PETREL + 1 == ARCHER
	dw Archer1FinalPkmnText
	dw Archer2FinalPkmnText
	assert ARCHER + 1 == ARIANA
	dw Ariana1FinalPkmnText
	dw Ariana2FinalPkmnText
	assert ARIANA + 1 == GIOVANNI
	dw Giovanni1FinalPkmnText
	dw Giovanni2FinalPkmnText

FinalText_SinglePhrases:
	table_width 2, FinalText_SinglePhrases
	dw CarrieFinalPkmnText
	dw CalFinalPkmnText
	dw JackyFinalPkmnText
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
	dw ThortonFinalPkmnText
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
	dw MarlonFinalPkmnText
	dw ValerieFinalPkmnText
	dw KukuiFinalPkmnText
	dw PiersFinalPkmnText
	dw KatyFinalPkmnText
	dw NULL ; Victor
	dw BillFinalPkmnText
	dw YellowFinalPkmnText
	dw WalkerFinalPkmnText
	dw ImakuniFinalPkmnText
	dw LawrenceFinalPkmnText
	dw ReiFinalPkmnText
	; all trainers between LEAF and PROF_OAK are omitted
	assert_table_length NUM_TRAINER_CLASSES - (PROF_OAK - LEAF - 1)
