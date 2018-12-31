EcruteakPokeCenter1F_MapScriptHeader:

.MapTriggers: db 1
	dw EcruteakPokeCenter1FBillWalksUpTrigger

.MapCallbacks: db 0

EcruteakPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 6, ECRUTEAK_CITY
	warp_def 7, 6, 6, ECRUTEAK_CITY
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalMortyScript

.PersonEvents: db 6
	person_event SPRITE_BILL, 3, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EcruteakPokeCenter1FBillScript, EVENT_ECRUTEAK_POKE_CENTER_BILL
	pc_nurse_event 1, 5
	person_event SPRITE_POKEFAN_M, 6, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EcruteakPokeCenter1FPokefanMScript, -1
	person_event SPRITE_LASS, 5, 11, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EcruteakPokeCenter1FLassScript, -1
	person_event SPRITE_COOLTRAINER_F, 4, 1, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, EcruteakPokeCenter1FCooltrainerFText, -1
	person_event SPRITE_GYM_GUY, 1, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, EcruteakPokeCenter1FGymGuyText, -1

const_value set 1
	const ECRUTEAKPOKECENTER1F_BILL

EcruteakPokeCenter1FBillWalksUpTrigger:
	priorityjump .Script
	end

.Script:
	pause 30
	moveperson ECRUTEAKPOKECENTER1F_BILL, 0, 7
	playsound SFX_EXIT_BUILDING
	appear ECRUTEAKPOKECENTER1F_BILL
	spriteface ECRUTEAKPOKECENTER1F_BILL, RIGHT
	waitsfx
	applymovement ECRUTEAKPOKECENTER1F_BILL, .Movement1
	pause 60
	applymovement ECRUTEAKPOKECENTER1F_BILL, .Movement2
	dotrigger $1
	end

.Movement1:
	step_right
	step_right
	step_up
	step_up
	step_up
	step_up
	step_right
	step_right
	step_right
	turn_head_up
	step_end

.Movement2:
	step_right
	turn_head_down
	step_end

PokemonJournalMortyScript:
	setflag ENGINE_READ_MORTY_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Morty!"

	para "Morty claims to"
	line "have once seen"
	cont "Entei. He says:"

	para "“It was amazing."
	line "Entei looked me"
	cont "in the eyes."

	para "I'll never forget"
	line "its eyes. It was"

	para "like it could see"
	line "right through me,"

	para "down into the dep-"
	line "ths of my heart…”"
	done

EcruteakPokeCenter1FBillScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_BILL_INTRO
	iftrue .heardintro
	writetext .IntroText
	waitbutton
	setevent EVENT_LISTENED_TO_BILL_INTRO
.heardintro
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .YesText
	buttonsound
	waitsfx
	checkcode VAR_PARTYCOUNT
	if_equal $6, .NoRoom
	writetext .GotEeveeText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke EEVEE, 5
	givepokeitem .GiftEeveeMail
	writebyte GREAT_BALL
	special SetLastPartyMonBall
	setevent EVENT_GOT_EEVEE
	writetext .GoodbyeText
	waitbutton
	closetext
	checkcode VAR_FACING
	spriteface PLAYER, DOWN
	if_not_equal UP, .noleftstep
	applyonemovement ECRUTEAKPOKECENTER1F_BILL, step_left
.noleftstep
	applymovement ECRUTEAKPOKECENTER1F_BILL, .LeaveMovement
	playsound SFX_EXIT_BUILDING
	disappear ECRUTEAKPOKECENTER1F_BILL
	clearevent EVENT_NEVER_MET_BILL
	waitsfx
	end

.NoRoom:
	thisopenedtext

	text "Whoa, wait. You"
	line "can't carry any"
	cont "more #mon."
	done

.IntroText:
	text "Hi, I'm Bill. And"
	line "who are you?"

	para "Hmm, <PLAYER>, huh?"
	line "You've come at the"
	cont "right time."

	para "The Time Capsules"
	line "are totally fried,"

	para "and I could use"
	line "your help."
	done

.QuestionText:
	text "Bill: This Eevee"
	line "came over just"

	para "before the Time"
	line "Capsule shut down."

	para "Someone has to"
	line "take care of it,"

	para "but I don't like"
	line "being outside."

	para "Can I count on you"
	line "to play with it,"
	cont "<PLAYER>?"
	done

.YesText:
	text "Bill: I knew you'd"
	line "come through!"

	para "Way to go! You're"
	line "the real deal!"

	para "OK, I'm counting"
	line "on you."

	para "Take good care of"
	line "it!"
	done

.GotEeveeText:
	text "<PLAYER> received"
	line "Eevee!"
	done

.GoodbyeText:
	text "Bill: Prof.Elm"
	line "claims Eevee may"

	para "evolve in new and"
	line "unknown ways."

	para "I have to hurry on"
	line "back to Goldenrod"
	cont "and see my folks,"

	para "and then it's back"
	line "to Kanto for me."

	para "Buh-bye!"
	done

.NoText:
	text "Oh… Now what to"
	line "do?"
	done

.LeaveMovement:
	step_down
	step_down
	step_down
	step_down
	step_end

.GiftEeveeMail:
	db   EON_MAIL
	db   "Greetings from"
	next "Kanto! -- Oak@"
	db 0

EcruteakPokeCenter1FPokefanMScript:
	checkevent EVENT_GOT_HM03_SURF
	iftrue_jumptextfaceplayer .SurfText
	thistextfaceplayer

	text "The way the Kimono"
	line "Girls dance is"

	para "marvelous. Just"
	line "like the way they"
	cont "use their #mon."
	done

.SurfText:
	text "You must be hoping"
	line "to battle more"
	cont "people, right?"

	para "There's apparently"
	line "some place where"
	cont "trainers gather."

	para "Where, you ask?"

	para "It's a little past"
	line "Olivine City."
	done

EcruteakPokeCenter1FLassScript:
	faceplayer
	opentext
	writetext .QuestionText
	yesorno
	iffalse .No
	checkevent EVENT_ECRUTEAK_POKE_CENTER_BILL
	iffalse_jumpopenedtext .HereText
	thisopenedtext

	text "I once heard that"
	line "Bill's mother used"

	para "to be a Kimono"
	line "Girl. Maybe that's"

	para "why he visits"
	line "here so often."
	done

.No:
	checkevent EVENT_ECRUTEAK_POKE_CENTER_BILL
	iffalse_jumpopenedtext .HereText
	thisopenedtext

	text "Oh… Never mind"
	line "then."
	done

.QuestionText:
	text "Do you know who"
	line "Bill is?"
	done

.HereText:
	text "Then go talk to"
	line "him! He's right"
	cont "by the counter!"
	done

EcruteakPokeCenter1FCooltrainerFText:
	text "Morty, the Gym"
	line "Leader, is soooo"
	cont "cool."

	para "His #mon are"
	line "really tough too."
	done

EcruteakPokeCenter1FGymGuyText:
	text "Lake of Rage…"

	para "The appearance of"
	line "a Gyarados swarm…"

	para "I smell a conspir-"
	line "acy. I know it!"
	done
