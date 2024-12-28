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
	text  "Loves to"
	next1 "eat"
	done
.Chara_HP1:
	text  "Takes"
	next1 "plenty of"
	next1 "siestas"
	done
.Chara_HP2:
	text  "Nods off"
	next1 "a lot"
	done
.Chara_HP3:
	text  "Scatters"
	next1 "things"
	next1 "often"
	done
.Chara_HP4:
	text  "Likes to"
	next1 "relax"
	done

.Chara_Atk0:
	text  "Proud of"
	next1 "its power"
	done
.Chara_Atk1:
	text  "Likes to"
	next1 "thrash"
	next1 "about"
	done
.Chara_Atk2:
	text  "A little"
	next1 "quick"
	next1 "tempered"
	done
.Chara_Atk3:
	text  "Likes to"
	next1 "fight"
	done
.Chara_Atk4:
	text  "Quick"
	next1 "tempered"
	done

.Chara_Def0:
	text  "Sturdy"
	next1 "body"
	done
.Chara_Def1:
	text  "Capable of"
	next1 "taking"
	next1 "hits"
	done
.Chara_Def2:
	text  "Highly"
	next1 "persistent"
	done
.Chara_Def3:
	text  "Good"
	next1 "endurance"
	done
.Chara_Def4:
	text  "Good"
	next1 "persever-"
	next1 "ance"
	done

.Chara_SAt0:
	text  "Highly"
	next1 "curious"
	done
.Chara_SAt1:
	text  "Mischiev-"
	next1 "ous"
	done
.Chara_SAt2:
	text  "Thoroughly"
	next1 "cunning"
	done
.Chara_SAt3:
	text  "Often lost"
	next1 "in thought"
	done
.Chara_SAt4:
	text  "Very"
	next1 "finicky"
	done

.Chara_SDf0:
	text  "Strong"
	next1 "willed"
	done
.Chara_SDf1:
	text  "Somewhat"
	next1 "vain"
	done
.Chara_SDf2:
	text  "Strongly"
	next1 "defiant"
	done
.Chara_SDf3:
	text  "Hates to"
	next1 "lose"
	done
.Chara_SDf4:
	text  "Somewhat"
	next1 "stubborn"
	done

.Chara_Spe0:
	text  "Likes to"
	next1 "run"
	done
.Chara_Spe1:
	text  "Alert to"
	next1 "sounds"
	done
.Chara_Spe2:
	text  "Impetuous"
	next1 "and silly"
	done
.Chara_Spe3:
	text  "Somewhat"
	next1 "of a clown"
	done
.Chara_Spe4:
	text  "Quick to"
	next1 "flee"
	done
