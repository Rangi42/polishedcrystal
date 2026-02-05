Characteristics:
	table_width 2
	dw .Chara_HP0
	dw .Chara_HP1
	dw .Chara_HP2
	dw .Chara_HP3
	dw .Chara_HP4
	dw .Chara_Atk0
	dw .Chara_Atk1
	dw .Chara_Atk2
	dw .Chara_Atk3
	dw .Chara_Atk4
	dw .Chara_Def0
	dw .Chara_Def1
	dw .Chara_Def2
	dw .Chara_Def3
	dw .Chara_Def4
	dw .Chara_SAt0
	dw .Chara_SAt1
	dw .Chara_SAt2
	dw .Chara_SAt3
	dw .Chara_SAt4
	dw .Chara_SDf0
	dw .Chara_SDf1
	dw .Chara_SDf2
	dw .Chara_SDf3
	dw .Chara_SDf4
	dw .Chara_Spe0
	dw .Chara_Spe1
	dw .Chara_Spe2
	dw .Chara_Spe3
	dw .Chara_Spe4
	assert_table_length NUM_STATS * 5

.Chara_HP0:
	text  "Adore"
	next1 "manger"
	done
.Chara_HP1:
	text  "S’assoupit"
	next1 "souvent"
	done
.Chara_HP2:
	text  "Dort"
	next1 "beaucoup"
	done
.Chara_HP3:
	text  "Éparpille"
	next1 "des choses"
	done
.Chara_HP4:
	text  "Aime se"
	next1 "détendre"
	done

.Chara_Atk0:
	text  "Est fier"
	next1 "de sa"
	next1 "puissance"
	done
.Chara_Atk1:
	text  "Aime se"
	next1 "démener"
	done
.Chara_Atk2:
	text  "Un peu"
	next1 "coléreux"
	done
.Chara_Atk3:
	text  "Aime"
	next1 "combattre"
	done
.Chara_Atk4:
	text  "S’emporte"
	next1 "facilement"
	done

.Chara_Def0:
	text  "Corps"
	next1 "robuste"
	done
.Chara_Def1:
	text  "Sait"
	next1 "encaisser"
	next1 "les coups"
	done
.Chara_Def2:
	text  "Très"
	next1 "obstiné"
	done
.Chara_Def3:
	text  "Bonne"
	next1 "endurance"
	done
.Chara_Def4:
	text  "Persévérant"
	done

.Chara_SAt0:
	text  "Extrêmement"
	next1 "curieux"
	done
.Chara_SAt1:
	text  "Coquin"
	done
.Chara_SAt2:
	text  "Très"
	next1 "astucieux"
	done
.Chara_SAt3:
	text  "Souvent"
	next1 "dans la"
	next1 "lune"
	done
.Chara_SAt4:
	text  "Très"
	next1 "particulier"
	done

.Chara_SDf0:
	text  "Très"
	next1 "volontaire"
	done
.Chara_SDf1:
	text  "Un peu"
	next1 "vaniteux"
	done
.Chara_SDf2:
	text  "Esprit"
	next1 "rebelle"
	done
.Chara_SDf3:
	text  "A horreur"
	next1 "de perdre"
	done
.Chara_SDf4:
	text  "Assez"
	next1 "entêté"
	done

.Chara_Spe0:
	text  "Aime"
	next1 "courir"
	done
.Chara_Spe1:
	text  "Attentif"
	next1 "aux sons"
	done
.Chara_Spe2:
	text  "Bête et"
	next1 "impulsif"
	done
.Chara_Spe3:
	text  "Aime faire"
	next1 "le pitre"
	done
.Chara_Spe4:
	text  "Fuit"
	next1 "rapidement"
	done
