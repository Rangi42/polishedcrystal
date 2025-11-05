GetOvercastIndex::
; Some maps are overcast, depending on certain conditions
	ld a, [wMapGroup]
	cp GROUP_AZALEA_TOWN ; GROUP_ROUTE_33
	jr z, .azalea_route_33
	cp GROUP_LAKE_OF_RAGE ; GROUP_ROUTE_43
	jr z, .lake_of_rage_route_43
	cp GROUP_STORMY_BEACH ; GROUP_GOLDENROD_CITY, GROUP_MAGNET_TUNNEL_WEST, GROUP_ROUTE_34, GROUP_ROUTE_34_COAST
	jr z, .stormy_beach_goldenrod_city_route_34
	; Generic chance of overcast for other outdoor maps (excluding always snowy/sandstorm)
	; Skip indoor/cave/gate/dungeon environments
	ld a, [wEnvironment]
	cp TOWN
	jr z, .maybe_generic
	cp ROUTE
	jr z, .maybe_generic
	cp ISOLATED
	jr z, .maybe_generic
.not_overcast:
	xor a ; NOT_OVERCAST
	ret

.azalea_route_33:
; Azalea Town and Route 33
	ld a, [wMapNumber]
	cp MAP_AZALEA_TOWN
	jr z, .azalea_town
	cp MAP_ROUTE_33
	jr nz, .not_overcast
.azalea_town
; Not overcast until Slowpokes appear (Team Rocket beaten)
	eventflagcheck EVENT_AZALEA_TOWN_SLOWPOKES
	jr nz, .not_overcast
; Overcast on Sunday, Tuesday, Thursday, and Saturday
	call GetWeekday
	cp MONDAY
	jr z, .not_overcast
	cp WEDNESDAY
	jr z, .not_overcast
	cp FRIDAY
	jr z, .not_overcast
	ld a, AZALEA_OVERCAST
	ret

.lake_of_rage_route_43:
; Lake of Rage and Route 43
	ld a, [wMapNumber]
	cp MAP_LAKE_OF_RAGE
	jr z, .lake_of_rage
	cp MAP_ROUTE_43
	jr nz, .not_overcast
.lake_of_rage
; Always overcast until civilians appear (Team Rocket beaten)
	eventflagcheck EVENT_LAKE_OF_RAGE_CIVILIANS
	jr nz, .overcast_lake_of_rage
; Overcast on Monday, Wednesday, and Friday
	call GetWeekday
	cp MONDAY
	jr z, .overcast_lake_of_rage
	cp WEDNESDAY
	jr z, .overcast_lake_of_rage
	cp FRIDAY
	jr nz, .not_overcast
.overcast_lake_of_rage
	ld a, LAKE_OF_RAGE_OVERCAST
	ret

.stormy_beach_goldenrod_city_route_34:
; Stormy Beach, Goldenrod City, Magnet Tunnel West, Route 34, Route 34 Coast
	ld a, [wMapNumber]
; Stormy Beach is always overcast
	cp MAP_STORMY_BEACH
	jr z, .overcast_stormy_beach
	cp MAP_ROUTE_34_COAST
	jr z, .maybe_stormy_beach
	cp MAP_ROUTE_34
	jr z, .maybe_stormy_beach
	cp MAP_MAGNET_TUNNEL_WEST
	jr z, .maybe_stormy_beach
	cp MAP_GOLDENROD_CITY
	jr nz, .not_overcast
.maybe_stormy_beach
; Only overcast while Team Rocket is present
	eventflagcheck EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	jr nz, .not_overcast
.overcast_stormy_beach
	ld a, STORMY_BEACH_OVERCAST
	ret

.maybe_generic
	ld a, GENERIC_OVERCAST
	ret
	; Exclude Snowtop Mountain (inside/outside) and Rugged Road (always snowy/sandstorm)
	ld a, [wMapGroup]
	cp GROUP_SNOWTOP_MOUNTAIN_OUTSIDE
	jp z, .not_overcast
	cp GROUP_SNOWTOP_MOUNTAIN_INSIDE ; aka GROUP_RUGGED_ROAD_SOUTH
	jp nz, .check_rugged_road_north
	; in this group, only allow if not Snowtop/Rugged Road maps
	ld a, [wMapNumber]
	cp MAP_SNOWTOP_MOUNTAIN_INSIDE
	jp z, .not_overcast
	cp MAP_RUGGED_ROAD_SOUTH
	jp z, .not_overcast
.check_rugged_road_north
	cp GROUP_RUGGED_ROAD_NORTH
	jp nz, .generic_by_weekday
	ld a, [wMapNumber]
	cp MAP_RUGGED_ROAD_NORTH
	jp z, .not_overcast

.generic_by_weekday
	; Use map group parity to split days: odd -> M/W/F, even -> T/Th/Sa
	call GetWeekday
	ld b, a ; weekday in b
	ld a, [wMapGroup]
	and 1
	jr z, .even_group_days
	; odd group: MON/WED/FRI
	ld a, b
	cp MONDAY
	jr z, .return_generic
	cp WEDNESDAY
	jr z, .return_generic
	cp FRIDAY
	jr z, .return_generic
	jmp .not_overcast
.even_group_days
	ld a, b
	cp TUESDAY
	jr z, .return_generic
	cp THURSDAY
	jr z, .return_generic
	cp SATURDAY
	jr z, .return_generic
	; Sunday not overcast by default for even groups
	jmp .not_overcast

.return_generic
	ld a, GENERIC_OVERCAST
	ret
