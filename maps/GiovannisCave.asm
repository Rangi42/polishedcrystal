const_value set 2
	const GIOVANNISCAVE_CELEBI
	const GIOVANNISCAVE_LYRA
	const GIOVANNISCAVE_GIOVANNI
	const GIOVANNISCAVE_ROCK1
	const GIOVANNISCAVE_ROCK2

GiovannisCave_MapScriptHeader:
.MapTriggers:
	db 1

	; triggers
	maptrigger .Trigger0

.MapCallbacks:
	db 0

.Trigger0:
	priorityjump GiovannisCaveCelebiEventScript
	end

GiovannisCaveCelebiEventScript:
	end

GiovannisCave_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_CELEBI, 6, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_LYRA, 5, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_GIOVANNI, 3, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_ROCK, 6, 3, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_ROCK, 2, 6, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
