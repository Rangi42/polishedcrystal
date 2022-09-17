WingNames::
	list_start WingNames
	li "Health Wing"
	li "Muscle Wing"
	li "Resist Wing"
	li "Swift Wing"
	li "Genius Wing"
	li "Clever Wing"
	assert_list_length NUM_WINGS

WingMenuItems:
; Note that the order doesn't match the internal index order,
; because Swift Wing (Speed) is last.
	db NUM_WINGS
	table_width 1
	db HEALTH_WING
	db MUSCLE_WING
	db RESIST_WING
	db GENIUS_WING
	db CLEVER_WING
	db SWIFT_WING
	assert_table_length NUM_WINGS
	db -1
