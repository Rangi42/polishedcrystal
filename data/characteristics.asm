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
	db    "Loves to"
	next1 "eat@"
.Chara_HP1:
	db    "Takes"
	next1 "plenty of"
	next1 "siestas@"
.Chara_HP2:
	db    "Nods off"
	next1 "a lot@"
.Chara_HP3:
	db    "Scatters"
	next1 "things"
	next1 "often@"
.Chara_HP4:
	db    "Likes to"
	next1 "relax@"

.Chara_ATK0:
	db    "Proud of"
	next1 "its power@"
.Chara_ATK1:
	db    "Likes to"
	next1 "thrash"
	next1 "about@"
.Chara_ATK2:
	db    "A little"
	next1 "quick"
	next1 "tempered@"
.Chara_ATK3:
	db    "Likes to"
	next1 "fight@"
.Chara_ATK4:
	db    "Quick"
	next1 "tempered@"

.Chara_DEF0:
	db    "Sturdy"
	next1 "body@"
.Chara_DEF1:
	db    "Capable of"
	next1 "taking"
	next1 "hits@"
.Chara_DEF2:
	db    "Highly"
	next1 "persistent@"
.Chara_DEF3:
	db    "Good"
	next1 "endurance@"
.Chara_DEF4:
	db    "Good"
	next1 "persever-"
	next1 "ance@"

.Chara_SPA0:
	db    "Highly"
	next1 "curious@"
.Chara_SPA1:
	db    "Mischiev-"
	next1 "ous@"
.Chara_SPA2:
	db    "Thoroughly"
	next1 "cunning@"
.Chara_SPA3:
	db    "Often lost"
	next1 "in thought@"
.Chara_SPA4:
	db    "Very"
	next1 "finicky@"

.Chara_SPD0:
	db    "Strong"
	next1 "willed@"
.Chara_SPD1:
	db    "Somewhat"
	next1 "vain@"
.Chara_SPD2:
	db    "Strongly"
	next1 "defiant@"
.Chara_SPD3:
	db    "Hates to"
	next1 "lose@"
.Chara_SPD4:
	db    "Somewhat"
	next1 "stubborn@"

.Chara_SPE0:
	db    "Likes to"
	next1 "run@"
.Chara_SPE1:
	db    "Alert to"
	next1 "sounds@"
.Chara_SPE2:
	db    "Impetuous"
	next1 "and silly@"
.Chara_SPE3:
	db    "Somewhat"
	next1 "of a clown@"
.Chara_SPE4:
	db    "Quick to"
	next1 "flee@"
