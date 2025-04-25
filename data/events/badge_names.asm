BadgeNames:
    list_start
    li "Zephyr"
    li "Hive"
    li "Plain"
    li "Fog"
    li "Mineral"
    li "Storm"
    li "Glacier"
    li "Rising"
    li "Boulder"
    li "Cascade"
    li "Thunder"
    li "Rainbow"
if DEF(FAITHFUL)
    li "Soul"
    li "Marsh"
else
    li "Marsh"
    li "Soul"
endc
    li "Volcano"
    li "Earth"
    assert_list_length NUM_BADGES
