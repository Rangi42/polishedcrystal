BillPhoneMornGreetingText:
	text "Good morning!"

	para "This is the #-"
	line "mon Storage System"

	para "Administration"
	line "Service."
	done

BillPhoneDayGreetingText:
	text "Good day!"

	para "This is the #-"
	line "mon Storage System"

	para "Administration"
	line "Service."
	done

BillPhoneNiteGreetingText:
	text "Good evening!"

	para "This is the #-"
	line "mon Storage System"

	para "Administration"
	line "Service."
	done

BillPhoneGenericText:
	text "Who's calling?"

	para "<PLAYER>, is it?"
	line "Hang on a sec…"

	para "……"
	line "……"
	done

BillPhoneNotFullText:
	text "Thanks for"
	line "waiting!"

	para "<PLAYER>, your Box"
	line "has room for "
	text_ram wStringBuffer3
	cont "more #mon."

	para "Get out there and"
	line "fill it up!"
	done

BillPhoneNearlyFullText:
	text "Thanks for"
	line "waiting!"

	para "<PLAYER>, your Box"
	line "has room for only"
	cont ""
	text_ram wStringBuffer3
	text " more #mon."

	para "Maybe you should"
	line "switch your Box."
	done

BillPhoneFullText:
	text "Thanks for"
	line "waiting!"

	para "<PLAYER>, your Box"
	line "is full!"

	para "You'll have to"
	line "switch Boxes if"

	para "you want to catch"
	line "more #mon."
	prompt

BillPhoneNewlyFullText:
	text "Hi, <PLAYER>?"
	line "It's me, Bill!"

	para "Thanks for using"
	line "my Storage System."

	para "That last #mon"
	line "you sent filled"
	cont "your Box up."

	para "You'll have to"
	line "switch Boxes if"

	para "you want to catch"
	line "more #mon."
	prompt

BillWholePCFullText:
	text "Wow, you filled"
	line "a whole server."

	para "You'll have to"
	line "release #mon"
	cont "to make space."
	done

BillWantNextBox:
	text "I'll swap to the"
	line "next Box with"
	cont "space for you."

	para "However…"
	prompt

BillThankYouText:
	text "Thank you for"
	line "using the PC"
	cont "Storage System!"
	done

BillCallMeToSwitch:
	text "OK, I'll leave it"
	line "alone."

	para "Call me back if"
	line "you change your"
	cont "mind."

	para "You can also"
	line "change boxes your-"
	cont "self via PC."
	prompt

BillPhoneSecondBadgeText:
	text "Hey there,"
	line "trainers!"
	cont "It's me, Bill!"

	para "I'm just calling to"
	line "warn y'all about"
	cont "Wonder Trading."

	para "The machine has"
	line "been unstable"
	cont "recently, and my"

	para "repairs aren't"
	line "quite complete."

	para "So if you're in"
	line "Goldenrod City,"

	para "be careful with"
	line "Wonder Trading."

	para "You might get a"
	line "weird #mon"
	cont "in exchange."

	para "That's all."
	line "Buh-bye!"
	prompt
