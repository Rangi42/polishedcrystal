const_value set 2

WarmBeachHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

; 17 (A book in a house, either on a table or in a bookcase): “Disturb not the harmony of Fire, Ice, or Lightning. Lest these Titans wreak destruction. Upon the world in which they clash. Though the Water's Great Guardian shall arise to quell the fighting. Alone its song will fail. Thus the earth shall turn to ash.” (Option to keep reading) “O Chosen One. Into thine hands bring together all three. Their treasures combined tame the Beast of The Sea. From the trio of islands, ancient spheres shall you take. For between life and death, all the difference you'll make. Climb to the shrine to right what is wrong. And the world shall be healed by the Guardian's song…”

WarmBeachHouse_MapEventHeader:
.Warps:
	db 2
	warp_def $7, $2, 3, WARM_BEACH
	warp_def $7, $3, 3, WARM_BEACH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
