MACRO weather_gfx
	fardw \1 ; gfx pointer
	db \2 ; tile count
ENDM

WeatherGraphics:
	table_width 3
	farbank "Overworld Weather Graphics"
	weather_gfx RainGFX, 2
	weather_gfx SnowGFX, 1
	weather_gfx RainGFX, 2
	weather_gfx SandGFX, 1
	weather_gfx CherryBlossomGFX, 1
	assert_table_length NUM_OW_WEATHERS
