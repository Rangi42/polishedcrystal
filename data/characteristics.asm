Characteristics:
	table_width 2, Characteristics
	dw .Chara_HP0
	dw .Chara_HP1
	dw .Chara_HP2
	dw .Chara_HP3
	dw .Chara_HP4
	dw .Chara_ATK0
	dw .Chara_ATK1
	dw .Chara_ATK2
	dw .Chara_ATK3
	dw .Chara_ATK4
	dw .Chara_DEF0
	dw .Chara_DEF1
	dw .Chara_DEF2
	dw .Chara_DEF3
	dw .Chara_DEF4
	dw .Chara_SPA0
	dw .Chara_SPA1
	dw .Chara_SPA2
	dw .Chara_SPA3
	dw .Chara_SPA4
	dw .Chara_SPD0
	dw .Chara_SPD1
	dw .Chara_SPD2
	dw .Chara_SPD3
	dw .Chara_SPD4
	dw .Chara_SPE0
	dw .Chara_SPE1
	dw .Chara_SPE2
	dw .Chara_SPE3
	dw .Chara_SPE4
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

.Chara_ATK0:
	text  "Proud of"
	next1 "its power"
	done
.Chara_ATK1:
	text  "Likes to"
	next1 "thrash"
	next1 "about"
	done
.Chara_ATK2:
	text  "A little"
	next1 "quick"
	next1 "tempered"
	done
.Chara_ATK3:
	text  "Likes to"
	next1 "fight"
	done
.Chara_ATK4:
	text  "Quick"
	next1 "tempered"
	done

.Chara_DEF0:
	text  "Sturdy"
	next1 "body"
	done
.Chara_DEF1:
	text  "Capable of"
	next1 "taking"
	next1 "hits"
	done
.Chara_DEF2:
	text  "Highly"
	next1 "persistent"
	done
.Chara_DEF3:
	text  "Good"
	next1 "endurance"
	done
.Chara_DEF4:
	text  "Good"
	next1 "persever-"
	next1 "ance"
	done

.Chara_SPA0:
	text  "Highly"
	next1 "curious"
	done
.Chara_SPA1:
	text  "Mischiev-"
	next1 "ous"
	done
.Chara_SPA2:
	text  "Thoroughly"
	next1 "cunning"
	done
.Chara_SPA3:
	text  "Often lost"
	next1 "in thought"
	done
.Chara_SPA4:
	text  "Very"
	next1 "finicky"
	done

.Chara_SPD0:
	text  "Strong"
	next1 "willed"
	done
.Chara_SPD1:
	text  "Somewhat"
	next1 "vain"
	done
.Chara_SPD2:
	text  "Strongly"
	next1 "defiant"
	done
.Chara_SPD3:
	text  "Hates to"
	next1 "lose"
	done
.Chara_SPD4:
	text  "Somewhat"
	next1 "stubborn"
	done

.Chara_SPE0:
	text  "Likes to"
	next1 "run"
	done
.Chara_SPE1:
	text  "Alert to"
	next1 "sounds"
	done
.Chara_SPE2:
	text  "Impetuous"
	next1 "and silly"
	done
.Chara_SPE3:
	text  "Somewhat"
	next1 "of a clown"
	done
.Chara_SPE4:
	text  "Quick to"
	next1 "flee"
	done
