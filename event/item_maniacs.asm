GetGourmetManiacPrice:
	ld hl, GourmetManiacItemRewards
	jr GetItemManiacPrice

GetOreManiacPrice:
	ld hl, OreManiacItemRewards
	jr GetItemManiacPrice

GetFossilManiacPrice:
	ld hl, FossilManiacItemRewards
GetItemManiacPrice:
	xor a ; ld a, FALSE
	ld [ScriptVar], a
	ld a, [CurItem]
	ld b, a
.loop
	ld a, [hli]
	cp -1
	ret z
	cp b
	jr z, .found
	inc hl
	inc hl
	jr .loop
.found
	ld a, [hli]
	ld [hMoneyTemp + 2], a
	ld a, [hl]
	ld [hMoneyTemp + 1], a
	xor a
	ld [hMoneyTemp], a
	inc a ; ld a, TRUE
	ld [ScriptVar], a
	ret

GourmetManiacItemRewards:
	dbw ORAN_BERRY,   20
	dbw SITRUS_BERRY, 20
	dbw PECHA_BERRY,  20
	dbw RAWST_BERRY,  20
	dbw CHERI_BERRY,  20
	dbw CHESTO_BERRY, 20
	dbw ASPEAR_BERRY, 20
	dbw PERSIM_BERRY, 20
	dbw LUM_BERRY,    20
	dbw LEPPA_BERRY,  20
	dbw FRESH_WATER,  200
	dbw SODA_POP,     300
	dbw LEMONADE,     350
	dbw MOOMOO_MILK,  500
	dbw RAGECANDYBAR, 300
	dbw RARE_CANDY,   10000
	dbw STICK,        2000
	dbw LEFTOVERS,    4000
	dbw LUCKY_EGG,    4000
	dbw TINYMUSHROOM, 500
	dbw BIG_MUSHROOM, 5000
	dbw BALMMUSHROOM, 15000
	dbw SWEET_HONEY,  300
	db -1

OreManiacItemRewards:
	dbw LEAF_STONE,    3000
	dbw FIRE_STONE,    3000
	dbw WATER_STONE,   3000
	dbw THUNDERSTONE,  3000
	dbw MOON_STONE,    3000
	dbw SUN_STONE,     3000
	dbw DUSK_STONE,    3000
	dbw SHINY_STONE,   3000
	dbw ICE_STONE,     3000
	dbw EVERSTONE,     3000
	dbw HARD_STONE,    1000
	dbw DAMP_ROCK,     4000
	dbw HEAT_ROCK,     4000
	dbw SMOOTH_ROCK,   4000
	dbw ICY_ROCK,      4000
	dbw NUGGET,       10000
	dbw BIG_NUGGET,   20000
	dbw PEARL,         2000
	dbw BIG_PEARL,     8000
	dbw PEARL_STRING, 16000
	dbw STARDUST,      3000
	dbw STAR_PIECE,   12000
	dbw BRICK_PIECE,    100
	db -1

FossilManiacItemRewards:
	dbw RARE_BONE,    5000
	dbw HELIX_FOSSIL, 1000
	dbw DOME_FOSSIL,  1000
	dbw OLD_AMBER,    1000
	db -1

Give_hMoneyTemp:
	ld de, Money
	ld bc, hMoneyTemp
	farjp GiveMoney
