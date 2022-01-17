NurseMornText:
	ctxt "Good morning!"
	line "Welcome to our"
	cont "#mon Center."
	done

NurseDayText:
	ctxt "Hello!"
	line "Welcome to our"
	cont "#mon Center."
	done

NurseEveText:
	ctxt "Good evening!"
	line "Welcome to our"
	cont "#mon Center."
	done

NurseNiteText:
	ctxt "Good evening!"
	line "You're out late."

	para "Welcome to our"
	line "#mon Center."
	done

PokeComNurseMornText:
	ctxt "Good morning!"

	para "This is the #-"
	line "mon Communication"

	para "Center--or the"
	line "#Com Center."
	done

PokeComNurseDayText:
	ctxt "Hello!"

	para "This is the #-"
	line "mon Communication"

	para "Center--or the"
	line "#Com Center."
	done

PokeComNurseEveText:
	ctxt "Good evening!"

	para "This is the #-"
	line "mon Communication"

	para "Center--or the"
	line "#Com Center."
	done

PokeComNurseNiteText:
	ctxt "Good to see you"
	line "working so late."

	para "This is the #-"
	line "mon Communication"

	para "Center--or the"
	line "#Com Center."
	done

NurseAskHealText:
	ctxt "We can heal your"
	line "#mon to perfect"
	cont "health."

	para "Shall we heal your"
	line "#mon?"
	done

NurseTrainerStarText:
	ctxt "We can heal your"
	line "#mon to perfect"
	cont "health."

	para "Shall we…"

	para "Th-that Trainer"
	line "Card!"

	para "That wonderful"
	line "shade! And that"
	cont "shiny star!"

	para "You're an impres-"
	line "sive Trainer."

	para "Please, <PLAYER>,"
	line "may I heal your"
	cont "#mon?"
	done

NurseTheUsualText:
	ctxt "Great to see you"
	line "again, <PLAYER>!"

	para "You want the"
	line "usual, right?"
	done

NurseTakePokemonText:
	ctxt "OK, may I see your"
	line "#mon?"
	done

NurseReturnPokemonText:
	ctxt "Thank you for"
	line "waiting."

	para "Your #mon are"
	line "fully healed."
	done

NurseGoodbyeText:
	ctxt "We hope to see you"
	line "again."
	done

NursePokerusText:
	ctxt "Your #mon"
	line "appear to be"

	para "infected by tiny"
	line "life forms."

	para "Your #mon are"
	line "healthy and seem"
	cont "to be fine."

	para "But we can't tell"
	line "you anything more"

	para "at a #mon"
	line "Center."
	done

PokeComNursePokerusText:
	ctxt "Your #mon"
	line "appear to be"

	para "infected by tiny"
	line "life forms."

	para "Your #mon are"
	line "healthy and seem"
	cont "to be fine."

	para "But we can't tell"
	line "you anything more."
	done

DifficultBookshelfText:
	ctxt "It's full of"
	line "difficult books."
	done

PictureBookshelfText:
	ctxt "A whole collection"
	line "of #mon picture"
	cont "books!"
	done

MagazineBookshelfText:
	ctxt "#mon magazines…"
	line "#mon Pal,"

	para "#mon Handbook,"
	line "#mon Graph…"
	done

TeamRocketOathText:
	ctxt "Team Rocket Oath"

	para "Steal #mon for"
	line "profit!"

	para "Exploit #mon"
	line "for profit!"

	para "All #mon exist"
	line "for the glory of"
	cont "Team Rocket!"
	done

IncenseBurnerText:
	ctxt "It's an incense"
	line "burner!"
	done

MerchandiseShelfText:
	ctxt "Lots of #mon"
	line "merchandise!"
	done

TownMapText:
	ctxt "It's the Town Map."
	done

DiplomaText:
	ctxt "It's the Diploma."
	done

WindowText:
	ctxt "My reflection!"
	line "Lookin' good!"
	done

TVText:
	ctxt "It's a TV."
	done

WrongSideText:
	ctxt "Oops, wrong side."
	done

RadioOffAirText:
	ctxt "The radio is just"
	line "playing static…"
	done

RefrigeratorText:
	ctxt "It's a fridge."
	done

SinkText:
	ctxt "It's a sink."
	done

StoveText:
	ctxt "It's a stove."
	done

TrashCanText:
	ctxt "There's nothing in"
	line "here…"
	done

PokeCenterSignText:
	ctxt "Heal Your #mon!"
	line "#mon Center"
	done

MartSignText:
	ctxt "For All Your"
	line "#mon Needs"

	para "#mon Mart"
	done

ContestResults_ReadyToJudgeText:
	ctxt "We will now judge"
	line "the #mon you've"
	cont "caught."

	para "……"
	line "……"

	para "We have chosen the"
	line "winners!"

	para "Are you ready for"
	line "this?"
	done

ContestResults_PlayerWonAPrizeText:
	ctxt "<PLAYER>, the No."
	text_ram wStringBuffer3
	line "finisher, wins"
	cont ""
	text_ram wStringBuffer4
	text "!"
	done

ReceivedItemText:
	ctxt "<PLAYER> received"
	line ""
	text_ram wStringBuffer4
	text "."
	done

ContestResults_JoinUsNextTimeText:
	ctxt "Please join us for"
	line "the next Contest!"
	done

ContestResults_ConsolationPrizeText:
	ctxt "Everyone else gets"
	line "a "
	text_ram wStringBuffer4
	ctxt " as a"
	cont "consolation prize!"
	done

ContestResults_DidNotWinText:
	ctxt "We hope you do"
	line "better next time."
	done

ContestResults_ReturnPartyText:
	ctxt "We'll return the"
	line "#mon we kept"

	para "for you."
	line "Here you go!"
	done

ContestResults_PartyFullText:
	ctxt "Your party's full,"
	line "so the #mon was"

	para "sent to your BOX"
	line "in Bill's PC."
	done

GymStatue_CityGymText:
	text_ram wStringBuffer3
	line "#mon Gym"

	para "Leader: "
	text_ram wStringBuffer4
	done

GymStatue_WinningTrainersText:
	ctxt "Winning Trainers:"
	line "<RIVAL>"
	done

GymStatue_TwoWinningTrainersText:
	ctxt "Winning Trainers:"
	line "<RIVAL>"
	cont "<PLAYER>"
	done

GymStatue_ThreeWinningTrainersText:
	ctxt "Winning Trainers:"
	line "<RIVAL>"
	cont "<PLAYER>"
	cont "Lyra"
	done

CoinVendor_WelcomeText:
	ctxt "Welcome to the"
	line "Game Corner."
	done

CoinVendor_NoCoinCaseText:
	ctxt "Do you need game"
	line "coins?"

	para "Oh, you don't have"
	line "a Coin Case for"
	cont "your coins."
	done

CoinVendor_IntroText:
	ctxt "Do you need some"
	line "game coins?"

	para "It costs ¥1000 for"
	line "50 coins. Do you"
	cont "want some?"
	done

CoinVendor_Buy50CoinsText:
	ctxt "Thank you!"
	line "Here are 50 coins."
	done

CoinVendor_Buy500CoinsText:
	ctxt "Thank you! Here"
	line "are 500 coins."
	done

CoinVendor_NotEnoughMoneyText:
	ctxt "You don't have"
	line "enough money."
	done

CoinVendor_CoinCaseFullText:
	ctxt "Whoops! Your Coin"
	line "Case is full."
	done

CoinVendor_CancelText:
	ctxt "No coins for you?"
	line "Come again!"
	done

BugContestPrizeNoRoomText:
	ctxt "Oh? Your Bag is"
	line "full."

	para "We'll keep this"
	line "for you today, so"

	para "come back when you"
	line "make room for it."
	done

HappinessText3:
	ctxt "Wow! You and your"
	line "#mon are really"
	cont "close!"
	done

HappinessText2:
	ctxt "#mon get more"
	line "friendly if you"

	para "spend time with"
	line "them."
	done

HappinessText1:
	ctxt "You haven't tamed"
	line "your #mon."

	para "If you aren't"
	line "nice, it'll pout."
	done

RegisteredNumber1Text:
	ctxt "<PLAYER> registered"
	line ""
	text_ram wStringBuffer3
	ctxt "'s number."
	done

RegisteredNumber2Text:
	ctxt "<PLAYER> registered"
	line ""
	text_ram wStringBuffer3
	ctxt "'s number."
	done

VendingMachineText:
	ctxt "A vending machine!"
	line "Here's the menu."
	done

VendingMachineClangText:
	text "Clang!"

	para ""
	text_ram wStringBuffer3
	line "popped out."
	done

VendingMachineScoreText:
	ctxt "Score! An extra"
	line ""
	text_ram wStringBuffer3
	cont "popped out."
	done

VendingMachineNoMoneyText:
	ctxt "Oops, not enough"
	line "money…"
	done

VendingMachineNoSpaceText:
	ctxt "There's no more"
	line "room for stuff…"
	done

HiddenGrottoText:
	ctxt "Look! You've found"
	line "a narrow path!"

	para "Will you follow"
	line "it?"
	done
