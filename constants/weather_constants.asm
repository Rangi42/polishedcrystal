; GetCurrentWeather return values
	const_def
	const OW_WEATHER_NONE
	const OW_WEATHER_RAIN
	const OW_WEATHER_SNOW
	const OW_WEATHER_THUNDERSTORM
	const OW_WEATHER_SANDSTORM
DEF NUM_OW_WEATHERS EQU const_value - 1

; wWeatherFlags
	const_def
	const OW_WEATHER_DO_FLY_F             ; 0
	const OW_WEATHER_DISABLED_F           ; 1
	const OW_WEATHER_LIGHTNING_DISABLED_F ; 2
