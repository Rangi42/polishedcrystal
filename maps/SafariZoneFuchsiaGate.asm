SafariZoneFuchsiaGate_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 4 ; warps
	warp_def 0, 4, 1, SAFARI_ZONE_HUB
	warp_def 0, 5, 2, SAFARI_ZONE_HUB
	warp_def 7, 4, 6, FUCHSIA_CITY
	warp_def 7, 5, 6, FUCHSIA_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SafariZoneFuchsiaGateOfficerText, -1

SafariZoneFuchsiaGateOfficerText:
	text "Hi there!"

	para "The Warden is"
	line "gone, so we're not"

	para "running the Safari"
	line "Game right now."

	para "You'll have to"
	line "bring your own"

	para "Balls if you want"
	line "to catch any"
	cont "#mon."
	done
