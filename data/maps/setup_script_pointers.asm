MACRO add_mapsetup
\1_MapSetupCmd:
	dba \1
ENDM

MapSetupCommands:
	add_mapsetup EnableLCD ; 00
	add_mapsetup DisableLCD ; 01
	add_mapsetup InitSound ; 02
	add_mapsetup PlayMapMusic ; 03
	add_mapsetup RestartMapMusic ; 04
	add_mapsetup FadeToMapMusic ; 05
	add_mapsetup FadeMapMusicAndPalettes ; 06
	add_mapsetup PlayMapMusicBike ; 07
	add_mapsetup ForceMapMusic ; 08
	add_mapsetup FadeInToMusic ; 09
	add_mapsetup LoadBlockData ; 0a (callback 1)
	add_mapsetup LoadConnectionBlockData ; 0b
	add_mapsetup SaveScreen ; 0c
	add_mapsetup BufferScreen ; 0d
	add_mapsetup LoadMapGraphics ; 0e
	add_mapsetup LoadMapTileset ; 0f
	add_mapsetup LoadMapTimeOfDay ; 10
	add_mapsetup LoadMapPalettes ; 11
	add_mapsetup LoadWildMonData ; 12
	add_mapsetup RefreshMapSprites ; 13
	add_mapsetup HandleNewMap ; 14
	add_mapsetup HandleContinueMap ; 15
	add_mapsetup LoadMapObjects ; 16
	add_mapsetup EnterMapSpawnPoint ; 17
	add_mapsetup EnterMapConnection ; 18
	add_mapsetup EnterMapWarp ; 19
	add_mapsetup LoadMapAttributes ; 1a
	add_mapsetup LoadMapAttributes_SkipObjects ; 1b
	add_mapsetup ClearBGPalettes ; 1c
	add_mapsetup FadeOutPalettes ; 1d
	add_mapsetup FadeInPalettes ; 1e
	add_mapsetup GetMapScreenCoords ; 1f
	add_mapsetup GetWarpDestCoords ; 20
	add_mapsetup SpawnInFacingDown ; 21
	add_mapsetup SpawnPlayer ; 22
	add_mapsetup RefreshPlayerCoords ; 23
	add_mapsetup ResetPlayerObjectAction ; 24
	add_mapsetup SkipUpdateMapSprites ; 25
	add_mapsetup UpdateRoamMons ; 26
	add_mapsetup JumpRoamMons ; 27
	add_mapsetup FadeOutMapMusic ; 28
	add_mapsetup ActivateMapAnims ; 29
	add_mapsetup SuspendMapAnims ; 2a
	add_mapsetup ApplyMapPalettes ; 2b
	add_mapsetup InitMapNameSign ; 2c
	add_mapsetup DecompressMetatiles ; 2d
	add_mapsetup DeferredLoadMapGraphics ; 2e
	add_mapsetup LoadMapTilesetGFX ; 2f
	add_mapsetup DisableDynPalUpdates ; 30
	add_mapsetup EnableDynPalUpdates ; 31
	add_mapsetup EnableDynPalUpdatesNoApply ; 32
	add_mapsetup ClearWeather ; 33
	add_mapsetup SetCurrentWeather ; 34
	add_mapsetup MapConnOWFadePalettesInit ; 35
	add_mapsetup LoadMapObjects_Connection ; 36
	add_mapsetup GrottoUpdatePlayerTallGrassFlags ; 37
	add_mapsetup LoadMapAttributes_Connection ; 38
	add_mapsetup SavePrevPalStates ; 39
	add_mapsetup ClearSavedObjPals ; 3a
