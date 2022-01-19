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
	ctxt  "Loves to"
	next1 "eat"
	done
.Chara_HP1:
	ctxt  "Takes"
	next1 "plenty of"
	next1 "siestas"
	done
.Chara_HP2:
	ctxt  "Nods off"
	next1 "a lot"
	done
.Chara_HP3:
	ctxt  "Scatters"
	next1 "things"
	next1 "often"
	done
.Chara_HP4:
	ctxt  "Likes to"
	next1 "relax"
	done

.Chara_ATK0:
	ctxt  "Proud of"
	next1 "its power"
	done
.Chara_ATK1:
	ctxt  "Likes to"
	next1 "thrash"
	next1 "about"
	done
.Chara_ATK2:
	ctxt  "A little"
	next1 "quick"
	next1 "tempered"
	done
.Chara_ATK3:
	ctxt  "Likes to"
	next1 "fight"
	done
.Chara_ATK4:
	ctxt  "Quick"
	next1 "tempered"
	done

.Chara_DEF0:
	ctxt  "Sturdy"
	next1 "body"
	done
.Chara_DEF1:
	ctxt  "Capable of"
	next1 "taking"
	next1 "hits"
	done
.Chara_DEF2:
	ctxt  "Highly"
	next1 "persistent"
	done
.Chara_DEF3:
	ctxt  "Good"
	next1 "endurance"
	done
.Chara_DEF4:
	ctxt  "Good"
	next1 "persever-"
	next1 "ance"
	done

.Chara_SPA0:
	ctxt  "Highly"
	next1 "curious"
	done
.Chara_SPA1:
	ctxt  "Mischiev-"
	next1 "ous"
	done
.Chara_SPA2:
	ctxt  "Thoroughly"
	next1 "cunning"
	done
.Chara_SPA3:
	ctxt  "Often lost"
	next1 "in thought"
	done
.Chara_SPA4:
	ctxt  "Very"
	next1 "finicky"
	done

.Chara_SPD0:
	ctxt  "Strong"
	next1 "willed"
	done
.Chara_SPD1:
	ctxt  "Somewhat"
	next1 "vain"
	done
.Chara_SPD2:
	ctxt  "Strongly"
	next1 "defiant"
	done
.Chara_SPD3:
	ctxt  "Hates to"
	next1 "lose"
	done
.Chara_SPD4:
	ctxt  "Somewhat"
	next1 "stubborn"
	done

.Chara_SPE0:
	ctxt  "Likes to"
	next1 "run"
	done
.Chara_SPE1:
	ctxt  "Alert to"
	next1 "sounds"
	done
.Chara_SPE2:
	ctxt  "Impetuous"
	next1 "and silly"
	done
.Chara_SPE3:
	ctxt  "Somewhat"
	next1 "of a clown"
	done
.Chara_SPE4:
	ctxt  "Quick to"
	next1 "flee"
	done
