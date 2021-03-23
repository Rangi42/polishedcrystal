TypeNames:
; entries correspond to types (see constants/type_constants.asm)
	table_width 2, TypeNames
	dw Normal
	dw Fighting
	dw Flying
	dw Poison
	dw Ground
	dw Rock
	dw Bug
	dw Ghost
	dw Steel
	assert_table_length SPECIAL_TYPES
	dw Fire
	dw Water
	dw Grass
	dw Electric
	dw Psychic
	dw Ice
	dw Dragon
	dw Dark
	dw Fairy
	dw UnknownType
	assert_table_length NUM_TYPES

Normal:      db "Normal@"
Fighting:    db "Fighting@"
Flying:      db "Flying@"
Poison:      db "Poison@"
Ground:      db "Ground@"
Rock:        db "Rock@"
Bug:         db "Bug@"
Ghost:       db "Ghost@"
Steel:       db "Steel@"
Fire:        db "Fire@"
Water:       db "Water@"
Grass:       db "Grass@"
Electric:    db "Electric@"
Psychic:     db "Psychic@"
Ice:         db "Ice@"
Dragon:      db "Dragon@"
Dark:        db "Dark@"
Fairy:       db "Fairy@"
UnknownType: db "???@"
