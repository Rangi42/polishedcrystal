; LevelCaps[CountSetBits(wBadges)] is the highest level a Pokémon can reach
; until the next major battle. Each entry is the next boss's ace level, per
; https://github.com/Rangi42/polishedcrystal/wiki/Nuzlocke#list-of-highest-levels
; Post-game caps (Red, ???) are handled by event flags in GetLevelCap.

LevelCaps:
	db 13 ; 0 badges
	db 17 ; 1 badge (falkner)
	db 21 ; 2 badges (bugsy)
	db 26 ; 3 badges (whitney)
	db 31 ; 4 badges (morty)
	db 37 ; 5 badges (chuck)
	db 42 ; 6 badges (jasmine)
	db 47 ; 7 badges (pryce)
	db 60 ; 8 badges (clair / johto elite four & champion)
	db 62 ; 9 badges (lt.surge)
	db 64 ; 10 badges (sabrina)
	db 65 ; 11 badges (misty)
	db 65 ; 12 badges (erika)
	db 66 ; 13 badges (janine)
	db 69 ; 14 badges (brock)
	db 70 ; 15 badges (blaine)
	db 80 ; 16 badges (blue / kanto elite four & champion)
