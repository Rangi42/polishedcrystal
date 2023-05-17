JackTriviaScript:
	random 11
	ifequalfwd  0, .Thunder
	ifequalfwd  1, .Rollout
	ifequalfwd  2, .Solarbeam
	ifequalfwd  3, .Stomp
	ifequalfwd  4, .Gust
	ifequalfwd  5, .KnockOff
	ifequalfwd  6, .Earthquake
	ifequalfwd  7, .Magnitude
	ifequalfwd  8, .Sandstorm
	ifequalfwd  9, .SunnyDay
	ifequalfwd 10, .RainDance

.Thunder:
	farwritetext JackThunderTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Rollout:
	farwritetext JackRolloutTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Solarbeam:
	farwritetext JackSolarbeamTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Stomp:
	farwritetext JackStompTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Gust:
	farwritetext JackGustTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.KnockOff:
	farwritetext JackKnockOffTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Earthquake:
	farwritetext JackEarthquakeTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Magnitude:
	farwritetext JackMagnitudeTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Sandstorm:
	farwritetext JackSandstormTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.SunnyDay:
	farwritetext JackSunnyDayTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.RainDance:
	farwritetext JackRainDanceTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male
