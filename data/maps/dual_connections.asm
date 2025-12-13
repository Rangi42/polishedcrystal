MACRO dual_connection
;\1: direction
;\2: map id
;\3: split coordinate (lesser/greater) (y for east/west, x for north/south)
;\4: lesser map name
;\5: lesser map id
;\6: lesser map offset (x for east/west, y for north/south)
;\7: greater map name
;\8: greater map id
;\9: greater map offset (x for east/west, y for north/south)

	map_id \2

	if "\1" === "north"
		db UP
		dw wXCoord
		db \3
		dw wNorthMapConnection
	elif "\1" === "south"
		db DOWN
		dw wXCoord
		db \3
		dw wSouthMapConnection
	elif "\1" === "west"
		db LEFT
		dw wYCoord
		db \3
		dw wWestMapConnection
	elif "\1" === "east"
		db RIGHT
		dw wYCoord
		db \3
		dw wEastMapConnection
	else
		fail "Invalid direction for 'dual_connection'."
	endc

	DEF CURRENT_MAP_WIDTH = \2_WIDTH
	DEF CURRENT_MAP_HEIGHT = \2_HEIGHT
	connection \1, \4, \5, \6
	connection \1, \7, \8, \9
ENDM

DualMapConnections:
	; When you walk north off of Route35CoastSouth, if [wXCoord] < 30,
	; then use "connection north, OlivineCity, OLIVINE_CITY, -7";
	; else use "connection north, Route35CoastNorth, ROUTE_35_COAST_NORTH, 15".
	dual_connection north, ROUTE_35_COAST_SOUTH, 30, \
		OlivineCity, OLIVINE_CITY, -7, \
		Route35CoastNorth, ROUTE_35_COAST_NORTH, 15
	db 0 ; end
