HappinessChanges:
	table_width 3
; change if happiness < HAPPINESS_THRESHOLD_1, change if happiness < HAPPINESS_THRESHOLD_2, change otherwise
	db  +3,  +2,  +0 ; Gained a level
	db  +3,  +1,  +0 ; Vitamin
	db  +1,  +1,  +0 ; X Item
	db +10,  +5,  +0 ; EV lowering berry
	db  +5,  +3,  +0 ; Battled a Gym Leader
	db  +1,  +1,  +0 ; Learned a move
	db  -1,  -1,  -1 ; Lost to an enemy
	db  -5,  -5, -10 ; Fainted due to poison
	db  -5,  -5, -10 ; Lost to a much stronger enemy
	db  +4,  +4,  +4 ; Haircut (Y1)
	db  +8,  +8,  +8 ; Haircut (Y2)
	db +16, +16, +16 ; Haircut (Y3)
	db  +8,  +8,  +8 ; Haircut (O1)
	db +16, +16, +16 ; Haircut (O2)
	db +32, +32, +32 ; Haircut (O3)
	db  -5,  -5, -10 ; Used Heal Powder or Energypowder (bitter)
	db -10, -10, -15 ; Used Energy Root (bitter)
	db -15, -15, -20 ; Used Revival Herb (bitter)
	db  +3,  +3,  +1 ; Grooming
	db  +6,  +4,  +0 ; Gained a level in the place where it was caught
	db  +5,  +3,  +2 ; Took a photograph
	db  +5,  +3,  +2 ; Received a blessing
	db  +2,  +1,  +0 ; Added every step cycle
	assert_table_length NUM_HAPPINESS_CHANGES
