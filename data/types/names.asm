TypeNames:
; entries correspond to types (see constants/type_constants.asm)
	table_width 1
	dr Normal
	dr Fighting
	dr Flying
	dr Poison
	dr Ground
	dr Rock
	dr Bug
	dr Ghost
	dr Steel
	assert_table_length SPECIAL_TYPES
	dr Fire
	dr Water
	dr Grass
	dr Electric
	dr Psychic
	dr Ice
	dr Dragon
	dr Dark
	dr Fairy
	dr UnknownType
	assert_table_length NUM_TYPES

EggGroupNames:
; entries correspond to egg groups (see constants/pokemon_data_constants.asm)
; placed here because several egg groups use the same string as a type
	table_width 1
	dr Monster
	dr Water1
	dr Bug
	dr Flying
	dr Field
	dr Fairy
	dr Grass
	dr Humanlike
	dr Water3
	dr Mineral
	dr Amorphous
	dr Water2
	dr Ditto
	dr Dragon
	dr Undiscovered
	assert_table_length NUM_EGG_GROUPS

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

Monster:      db "Monster@"
Field:        db "Field@"
Humanlike:    db "Human-Like@"
Mineral:      db "Mineral@"
Amorphous:    db "Amorphous@"
Ditto:        db "Ditto@"
Undiscovered: db "Undiscovered@"
if !DEF(FAITHFUL)
Water1:       db "Amphibian@"
Water2:       db "Fish@"
Water3:       db "Invertebrate@"
else
Water1:       db "Water 1@"
Water2:       db "Water 2@"
Water3:       db "Water 3@"
endc
