WonderTradeIntroText::
;	text "With Wonder Trade,"
;	line "you can quickly"
;	cont "and easily trade"
;
;	para "your #mon with"
;	line "anyone from anywh-"
;	cont "ere in the world!"

	text "Do you want to"
	line "start a Wonder"
	cont "Trade?"
	done

WonderTradeCanceledText::
	text "Never mind."
	done

WonderTradeConfirmText::
	text "Offer to trade"
	line "@"
	text_from_ram StringBuffer1
	text "? "
	done

WonderTradeSetupText::
	text "Searching for a"
	line "trade partner..."
	prompt

WonderTradeReadyText::
	text "We've found you a"
	line "trade partner!"
	prompt

WonderTradeCompleteText::
	text "Wonder Trade"
	line "complete!"
	done

WonderTradeDoneFanfare::
	sound_dex_fanfare_80_109
	interpret_data
	db "@@"
