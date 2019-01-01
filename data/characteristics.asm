Characteristics:
	dw Chara_HP0, Chara_HP1, Chara_HP2, Chara_HP3, Chara_HP4
	dw Chara_ATK0, Chara_ATK1, Chara_ATK2, Chara_ATK3, Chara_ATK4
	dw Chara_DEF0, Chara_DEF1, Chara_DEF2, Chara_DEF3, Chara_DEF4
	dw Chara_SPA0, Chara_SPA1, Chara_SPA2, Chara_SPA3, Chara_SPA4
	dw Chara_SPD0, Chara_SPD1, Chara_SPD2, Chara_SPD3, Chara_SPD4
	dw Chara_SPE0, Chara_SPE1, Chara_SPE2, Chara_SPE3, Chara_SPE4

Chara_HP0:
	db   "Loves t", "o"
	next "eat@"
Chara_HP1:
	db   "Takes"
	next "plenty of"
	next "siestas@"
Chara_HP2:
	db   "Nods off"
	next "a lot@"
Chara_HP3:
	db   "Scatters"
	next "things"
	next "often@"
Chara_HP4:
	db   "Likes t", "o"
	next "relax@"

Chara_ATK0:
	db   "Proud of"
	next "its power@"
Chara_ATK1:
	db   "Likes t", "o"
	next "thrash"
	next "about@"
Chara_ATK2:
	db   "A little"
	next "quick"
	next "tempered@"
Chara_ATK3:
	db   "Likes t", "o"
	next "fight@"
Chara_ATK4:
	db   "Quick"
	next "tempered@"

Chara_DEF0:
	db   "Sturdy"
	next "body@"
Chara_DEF1:
	db   "Capable of"
	next "taking"
	next "hits@"
Chara_DEF2:
	db   "Highly"
	next "persistent@"
Chara_DEF3:
	db   "Good"
	next "endurance@"
Chara_DEF4:
	db   "Good"
	next "persever-"
	next "ance@"

Chara_SPA0:
	db   "Highly"
	next "curious@"
Chara_SPA1:
	db   "Mischiev-"
	next "ous@"
Chara_SPA2:
	db   "Thoroughly"
	next "cunning@"
Chara_SPA3:
	db   "Often lost"
	next "in thought@"
Chara_SPA4:
	db   "Very"
	next "finicky@"

Chara_SPD0:
	db   "Strong"
	next "willed@"
Chara_SPD1:
	db   "Somewhat"
	next "vain@"
Chara_SPD2:
	db   "Strongly"
	next "defiant@"
Chara_SPD3:
	db   "Hates t", "o"
	next "lose@"
Chara_SPD4:
	db   "Somewhat"
	next "stubborn@"

Chara_SPE0:
	db   "Likes t", "o"
	next "run@"
Chara_SPE1:
	db   "Alert t", "o"
	next "sounds@"
Chara_SPE2:
	db   "Impetuous"
	next "an", "d silly@"
Chara_SPE3:
	db   "Somewhat"
	next "of a clown@"
Chara_SPE4:
	db   "Quick t", "o"
	next "flee@"
