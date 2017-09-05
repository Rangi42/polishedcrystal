SilverCavePokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SilverCavePokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 1, SILVER_CAVE_OUTSIDE
	warp_def 7, 6, 1, SILVER_CAVE_OUTSIDE
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalLanceScript

.PersonEvents: db 3
	pc_nurse_event 1, 5
	person_event SPRITE_GRAMPS, 4, 9, SPRITEMOVEDATA_STANDING_DOWN, 1, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SilverCavePokeCenterGrampsScript, -1
	person_event SPRITE_GRANNY, 4, 2, SPRITEMOVEDATA_STANDING_LEFT, 1, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, SilverCavePokeCenter1FGrannyText, -1

PokemonJournalLanceScript:
	setflag ENGINE_READ_LANCE_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Champion Lance!"

	para "Lance has been"
	line "spotted buying"

	para "his capes at Cel-"
	line "adon Dept.Store."
	done

SilverCavePokeCenterGrampsScript:
	checkevent EVENT_GOT_EXPERT_BELT
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writetext .GreetingText
	waitbutton
	checkcode VAR_PKMN_JOURNALS
	if_equal 0, .ReadNone
	if_equal NUM_POKEMON_JOURNALS, .ReadThemAll
	thisopenedtext

	text "Oh, you've read @"
	deciram ScriptVar, 1, 2
	text ""
	line "of them?"

	para "Not bad, but I've"
	line "read all 33!"
	done

.ReadNone:
	thisopenedtext

	text "You haven't read"
	line "any? What a shame."

	para "#mon Centers"
	line "have most of them"
	cont "on their shelves,"

	para "but real fans like"
	line "me track down the"
	cont "rare issues."
	done

.ReadThemAll:
	writetext .ReadAllText
	buttonsound
	verbosegiveitem EXPERT_BELT
	iffalse_endtext
	setevent EVENT_GOT_EXPERT_BELT
	thisopenedtext

.AfterText:
	text "That Belt's not"
	line "just for show."

	para "It'll power up your"
	line "#mon if they"
	cont "hold it."
	done

.GreetingText:
	text "In my youth I was"
	line "a talented trainer"
	cont "myself."

	para "Now I just read"
	line "about others in"
	cont "#mon Journal."

	para "Are you a Journal"
	line "reader too?"
	done

.ReadAllText:
	text "You've read them"
	line "all? Then you're"

	para "a Journal expert"
	line "like me!"

	para "Take this to show"
	line "you're a fan!"
	done

SilverCavePokeCenter1FGrannyText:
	text "Trainers who seek"
	line "power climb Mt."

	para "Silver despite its"
	line "many dangers…"

	para "With their trusted"
	line "#mon, they must"

	para "feel they can go"
	line "anywhere…"
	done
