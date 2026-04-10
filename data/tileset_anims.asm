MACRO? tileframe
;\1: function pointer
;\2: "$b:xx" VRAM bank and address (optional parameter to function)
	if _NARG == 2
		assert STRLEN("\2") == STRLEN("$b:xx") && \
			STRSLICE("\2", 0, 1) === "$" && STRSLICE("\2", 2, 3) === ":", \
			"\2 is not a valid VRAM $bank:id"
		REDEF tileframe_bank EQUS STRSLICE("\2", 1, 2)
		REDEF tileframe_id EQUS STRSLICE("\2", 3, 5)
		DEF tile_bank = ${tileframe_bank}
		assert tile_bank == 0 || tile_bank == 1, "${x:tile_bank} is not a valid VRAM bank"
		DEF tile_id = ${tileframe_id}
		assert $00 <= tile_id && tile_id <= $ff, "${02x:tile_id} is not a valid tile ID"
		if tile_id < $80
			dw (vTiles2 tile tile_id) | tile_bank
		else
			dw (vTiles1 tile (tile_id - $80)) | tile_bank
		endc
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
	tileframe AnimateWaterTile,         $0:14
	tileframe AnimateRainTiles,         $0:1c
	tileframe AnimateWhirlpoolTiles,    $0:30
	tileframe AnimateBuoyTiles,         $0:60
	tileframe DoNothing
	tileframe AnimateFlowerTile,        $0:03
	tileframe AnimateRainTiles,         $0:1c
	tileframe AnimateWaterfallTiles,    $0:34
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetKantoAnim::
TilesetKantoNorthAnim::
TilesetIndigoPlateauAnim::
	tileframe AnimateKantoWaterTile,    $0:14
	tileframe ScrollTileUp,             $0:10
	tileframe ScrollTileDown,           $0:11
	tileframe ScrollTileLeft,           $0:12
	tileframe ScrollTileRight,          $0:13
	tileframe AnimateKantoFlowerTile,   $0:03
	tileframe ScrollTileUp,             $0:10
	tileframe ScrollTileDown,           $0:11
	tileframe ScrollTileLeft,           $0:12
	tileframe ScrollTileRight,          $0:13
	tileframe AnimateWaterfallTiles,    $0:6b
	tileframe AnimateFountainTile,      $0:40
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetPortAnim::
	tileframe AnimateWaterTile,         $0:14
	tileframe AnimateBuoyTiles,         $1:12
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetGymAnim::
	tileframe AnimateWaterTile,         $0:28
	tileframe AnimateLavaBubbleTile2,   $0:38
	tileframe AnimateLavaBubbleTile1,   $0:5b
	tileframe AnimateBigStarTile1,      $1:40
	tileframe AnimateSmallStarsTile1,   $1:42
	tileframe AnimateDoubleStarTile,    $1:44
	tileframe AnimateBigStarTile2,      $1:41
	tileframe AnimateSmallStarsTile2,   $1:43
	tileframe AnimateWaterfallTiles,    $0:58
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetTowerAnim::
	tileframe AnimateTowerPillarTiles1, $1:20
	tileframe AnimateTowerPillarTiles2, $1:24
	tileframe AnimateTowerPillarTiles3, $1:27
	tileframe AnimateTowerPillarTiles4, $1:2a
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame
	tileframe DoneTileAnimation

TilesetCaveAnim::
TilesetQuietCaveAnim::
	tileframe FlickeringCaveEntrancePalette
	tileframe ScrollTileRightLeft,      $0:25
	tileframe FlickeringCaveEntrancePalette
	tileframe ScrollTileUp,             $0:4e
	tileframe ScrollTileDown,           $0:4f
	tileframe ScrollTileLeft,           $0:5e
	tileframe ScrollTileRight,          $0:5f
	tileframe FlickeringCaveEntrancePalette
	tileframe AnimateWaterfallTiles,    $0:26
	tileframe FlickeringCaveEntrancePalette
	tileframe AnimateLavaBubbleTile2,   $0:3c
	tileframe AnimateLavaBubbleTile1,   $0:3d
	tileframe DoneTileAnimation

TilesetPeaksAnim::
	tileframe FlickeringCaveEntrancePalette
	tileframe ScrollTileRightLeft,      $0:25
	tileframe FlickeringCaveEntrancePalette
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe FlickeringCaveEntrancePalette
	tileframe AnimateWaterfallTiles,    $0:26
	tileframe FlickeringCaveEntrancePalette
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoneTileAnimation

TilesetParkAnim::
	tileframe AnimateWaterTile,         $0:14
	tileframe DoNothing
	tileframe AnimateFountainTile,      $0:15
	tileframe DoNothing
	tileframe DoNothing
	tileframe AnimateFlowerTile,        $0:03
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetIcePathAnim::
	tileframe FlickeringCaveEntrancePalette
	tileframe ScrollTileRightLeft,      $0:10
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
	tileframe AnimateWaterTile,         $0:14
	tileframe AnimateBuoyTiles,         $1:4c
	tileframe AnimateForestTreeTiles,   $1:1c
	tileframe DoNothing
	tileframe DoNothing
	tileframe AnimateFlowerTile,        $0:03
	tileframe DoNothing
	tileframe AnimateWaterfallTiles,    $0:42
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetSafariZoneAnim::
	tileframe AnimateKantoWaterTile,    $0:14
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe AnimateKantoFlowerTile,   $0:03
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetFarawayIslandAnim::
	tileframe AnimateFarawayWaterTiles, $0:14
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
	tileframe AnimateFireTiles,         $0:6d
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetTunnelAnim::
	tileframe FlickeringCaveEntrancePalette
	tileframe ScrollTileRightLeft,      $0:26
	tileframe FlickeringCaveEntrancePalette
	tileframe AnimateLCDTile,           $1:1e
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
	tileframe AnimateFarawayWaterTiles, $0:14
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe AnimateFlowerTile,        $0:03
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetSnowtopMountainAnim::
	tileframe AnimateTinyWaterTiles,    $1:30
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe DoNothing
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetFacilityAnim::
	tileframe AnimateTurbineTiles,      $0:6c
	tileframe StandingTileFrame8
	tileframe AnimateFountainTile,      $0:4d
	tileframe AnimateTurbineTiles,      $0:6c
	tileframe StandingTileFrame8
	tileframe DoNothing
	tileframe AnimateTurbineTiles,      $0:6c
	tileframe StandingTileFrame8
	tileframe DoNothing
	tileframe AnimateTurbineTiles,      $0:6c
	tileframe StandingTileFrame8
	tileframe DoneTileAnimation

TilesetHideoutAnim::
	tileframe AnimateTurbineTiles,      $0:6c
	tileframe StandingTileFrame8
	tileframe AnimateSpinnerTile,       $0:07
	tileframe AnimateTurbineTiles,      $0:6c
	tileframe StandingTileFrame8
	tileframe DoNothing
	tileframe AnimateTurbineTiles,      $0:6c
	tileframe StandingTileFrame8
	tileframe DoNothing
	tileframe AnimateTurbineTiles,      $0:6c
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
