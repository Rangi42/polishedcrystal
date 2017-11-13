BluesHouse1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

BluesHouse1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 2, 2, PALLET_TOWN
	warp_def 7, 3, 2, PALLET_TOWN
	warp_def 0, 7, 1, BLUES_HOUSE_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 5, SIGNPOST_UP, RedsHouse1FTVScript

.PersonEvents: db 1
	person_event SPRITE_DAISY, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DaisyScript, -1

DaisyScript:
	checkcode VAR_HOUR
	if_equal 15, .Massage
	checkflag ENGINE_TEA_IN_BLUES_HOUSE
	iftrue .After
	thistextfaceplayer

	text "Daisy: Hi! My kid"
	line "brother is the Gym"

	para "Leader in Viridian"
	line "City."

	para "But he goes out"
	line "of town so often,"

	para "it causes problems"
	line "for the trainers."
	done

.Massage:
	faceplayer
	opentext
	writetext .IntroText
	yesorno
	iffalse .NoMassage
	writetext .QuestionText
	waitbutton
	special Special_DaisyMassage
	if_equal 0, .NoMassage
	if_equal 1, .EggMassage
	setflag ENGINE_TEA_IN_BLUES_HOUSE
	writetext .OkayText
	waitbutton
	closetext
	special FadeOutPalettes
	special SaveMusic
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes
	special RestoreMusic
	opentext
	writetext .LooksContentText
	special PlayCurMonCry
	buttonsound
	thisopenedtext

	text "Daisy: There you"
	line "go! All done."

	para "See? Doesn't it"
	line "look nice?"

	para "It's such a cute"
	line "#mon."
	done

.IntroText:
	text "Daisy: Hi! Good"
	line "timing. I'm about"
	cont "to have some tea."

	para "Would you like to"
	line "join me?"

	para "Oh, your #mon"
	line "are a bit dirty."

	para "Would you like me"
	line "to groom one?"
	done

.After:
	thistextfaceplayer

	text "Daisy: I always"
	line "have tea around"

	para "this time. Come"
	line "join me."
	done

.NoMassage:
	thistext

	text "Daisy: You don't"
	line "want to have one"

	para "groomed? OK, we'll"
	line "just have tea."
	done

.QuestionText:
	text "Daisy: Which one"
	line "should I groom?"
	done

.OkayText:
	text "Daisy: OK, I'll"
	line "get it looking"
	cont "nice in no time."
	done

.LooksContentText:
	text_from_ram StringBuffer3
	text " looks"
	line "content."
	done

.EggMassage:
	thistext

	text "Daisy: Oh, sorry."
	line "I honestly can't"
	cont "groom an Egg."
	done
