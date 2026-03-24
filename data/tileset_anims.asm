MACRO tileframe
	if _NARG == 2
		dw \2 ; argument
	else
		dw 0
	endc
	dw \1 ; function
ENDM

TilesetJohtoTraditionalAnim::
TilesetJohtoModernAnim::
TilesetJohtoCoastAnim::
TilesetJohtoOutlandsAnim::
TilesetJohtoAncientAnim::
TilesetBattleTowerOutsideAnim::
TilesetEcruteakShrineAnim::
	tileframe AnimateWaterTile,         vTiles2 tile $14
	tileframe AnimateRainTiles,         vTiles2 tile $1c
	tileframe AnimateWhirlpoolTiles,    vTiles2 tile $30
	tileframe DoNothing
	tileframe DoNothing
	tileframe AnimateFlowerTile,        vTiles2 tile $03
	tileframe AnimateRainTiles,         vTiles2 tile $1c
	tileframe AnimateWaterfallTiles,    vTiles2 tile $34
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetKantoAnim::
TilesetKantoNorthAnim::
TilesetIndigoPlateauAnim::
	tileframe AnimateKantoWaterTile,    vTiles2 tile $14
	tileframe ScrollTileUp,             vTiles2 tile $10
	tileframe ScrollTileDown,           vTiles2 tile $11
	tileframe ScrollTileLeft,           vTiles2 tile $12
	tileframe ScrollTileRight,          vTiles2 tile $13
	tileframe AnimateKantoFlowerTile,   vTiles2 tile $03
	tileframe ScrollTileUp,             vTiles2 tile $10
	tileframe ScrollTileDown,           vTiles2 tile $11
	tileframe ScrollTileLeft,           vTiles2 tile $12
	tileframe ScrollTileRight,          vTiles2 tile $13
	tileframe AnimateWaterfallTiles,    vTiles2 tile $6b
	tileframe AnimateFountainTile,      vTiles2 tile $40
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetPortAnim::
	tileframe AnimateWaterTile,         vTiles2 tile $14
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetGymAnim::
	tileframe AnimateWaterTile,         vTiles2 tile $28
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe AnimateLavaBubbleTile2,   vTiles2 tile $38
	tileframe AnimateLavaBubbleTile1,   vTiles2 tile $5b
	tileframe DoNothing
	tileframe AnimateWaterfallTiles,    vTiles2 tile $58
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetTowerAnim::
	tileframe AnimateTowerPillarTiles1, vTiles5 tile $26
	tileframe AnimateTowerPillarTiles2, vTiles5 tile $2a
	tileframe AnimateTowerPillarTiles3, vTiles5 tile $2c
	tileframe AnimateTowerPillarTiles4, vTiles5 tile $2f
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame
	tileframe DoneTileAnimation

TilesetCaveAnim::
TilesetQuietCaveAnim::
	tileframe FlickeringCaveEntrancePalette
	tileframe ScrollTileRightLeft,      vTiles2 tile $25
	tileframe FlickeringCaveEntrancePalette
	tileframe ScrollTileUp,             vTiles2 tile $4e
	tileframe ScrollTileDown,           vTiles2 tile $4f
	tileframe ScrollTileLeft,           vTiles2 tile $5e
	tileframe ScrollTileRight,          vTiles2 tile $5f
	tileframe FlickeringCaveEntrancePalette
	tileframe AnimateWaterfallTiles,    vTiles2 tile $26
	tileframe FlickeringCaveEntrancePalette
	tileframe AnimateLavaBubbleTile2,   vTiles2 tile $3c
	tileframe AnimateLavaBubbleTile1,   vTiles2 tile $3d
	tileframe DoneTileAnimation

TilesetPeaksAnim::
	tileframe FlickeringCaveEntrancePalette
	tileframe ScrollTileRightLeft,      vTiles2 tile $25
	tileframe FlickeringCaveEntrancePalette
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe FlickeringCaveEntrancePalette
	tileframe AnimateWaterfallTiles,    vTiles2 tile $26
	tileframe FlickeringCaveEntrancePalette
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoneTileAnimation

TilesetParkAnim::
	tileframe AnimateWaterTile,         vTiles2 tile $14
	tileframe DoNothing
	tileframe AnimateFountainTile,      vTiles2 tile $15
	tileframe DoNothing
	tileframe DoNothing
	tileframe AnimateFlowerTile,        vTiles2 tile $03
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetIcePathAnim::
	tileframe FlickeringCaveEntrancePalette
	tileframe ScrollTileRightLeft,      vTiles2 tile $10
	tileframe FlickeringCaveEntrancePalette
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe FlickeringCaveEntrancePalette
	tileframe DoNothing
	tileframe FlickeringCaveEntrancePalette
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoneTileAnimation

TilesetForestAnim::
	tileframe AnimateWaterTile,         vTiles2 tile $14
	tileframe DoNothing
	tileframe AnimateForestTreeTiles,   vTiles2 tile $50
	tileframe AnimateForestTreeTiles,   vTiles2 tile $50
	tileframe DoNothing
	tileframe AnimateFlowerTile,        vTiles2 tile $03
	tileframe DoNothing
	tileframe AnimateWaterfallTiles,    vTiles2 tile $42
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetSafariZoneAnim::
	tileframe AnimateKantoWaterTile,    vTiles2 tile $14
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe AnimateKantoFlowerTile,   vTiles2 tile $03
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetFarawayIslandAnim::
	tileframe AnimateFarawayWaterTiles, vTiles2 tile $14
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetTraditionalHouseAnim::
	tileframe AnimateFireTiles,         vTiles2 tile $6d
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetTunnelAnim::
	tileframe FlickeringCaveEntrancePalette
	tileframe ScrollTileRightLeft,      vTiles2 tile $26
	tileframe FlickeringCaveEntrancePalette
	tileframe AnimateLCDTile,           vTiles2 tile $5e
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe FlickeringCaveEntrancePalette
	tileframe DoNothing
	tileframe FlickeringCaveEntrancePalette
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoneTileAnimation

TilesetShamoutiIslandAnim::
TilesetValenciaIslandAnim::
	tileframe AnimateFarawayWaterTiles, vTiles2 tile $14
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe AnimateFlowerTile,        vTiles2 tile $03
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetSnowtopMountainAnim::
	tileframe AnimateTinyWaterTiles,    vTiles2 tile $0a
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetHideoutAnim::
	tileframe AnimateSpinnerTile,       vTiles2 tile $08
TilesetFacilityAnim::
	tileframe AnimateTurbineTiles,      vTiles2 tile $6c
	tileframe StandingTileFrame8
	tileframe DoNothing
	tileframe AnimateTurbineTiles,      vTiles2 tile $6c
	tileframe StandingTileFrame8
	tileframe DoNothing
	tileframe AnimateTurbineTiles,      vTiles2 tile $6c
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetJohtoHouseAnim::
TilesetKantoHouseAnim::
TilesetPokeCenterAnim::
TilesetGateAnim::
TilesetLabAnim::
TilesetMartAnim::
TilesetMansionAnim::
TilesetGameCornerAnim::
TilesetMagnetTrainAnim::
TilesetChampionsRoomAnim::
TilesetLighthouseAnim::
TilesetUndergroundAnim::
TilesetPokeComCenterAnim::
TilesetBattleTowerInsideAnim::
TilesetRuinsOfAlphAnim::
TilesetRadioTowerAnim::
TilesetPokemonMansionAnim::
TilesetDecorAnim::
TilesetMuseumAnim::
TilesetHotelAnim::
TilesetBattleFactoryAnim::
TilesetHiddenGrottoAnim::
TilesetKantoGymAnim::
	tileframe DoNothing
	tileframe DoneTileAnimation
