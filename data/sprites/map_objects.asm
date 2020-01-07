sprite_movement_data: MACRO
	db \1, \2, \3, \4, \5
	dn \6, 0
ENDM

SpriteMovementData::
	; function,                                              facing, action,                        flags1, flags2, palette flags
	sprite_movement_data SPRITEMOVEFN_00,                    DOWN,   PERSON_ACTION_STAND,           $02,    $00,    %0000 ; SPRITEMOVEDATA_00
	sprite_movement_data SPRITEMOVEFN_STANDING,              DOWN,   PERSON_ACTION_STAND,           $0c,    $00,    %0000 ; SPRITEMOVEDATA_DOLL
	sprite_movement_data SPRITEMOVEFN_RANDOM_WALK_XY,        DOWN,   PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_WANDER
	sprite_movement_data SPRITEMOVEFN_SLOW_RANDOM_SPIN,      DOWN,   PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_SPINRANDOM_SLOW
	sprite_movement_data SPRITEMOVEFN_RANDOM_WALK_Y,         DOWN,   PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_WALK_UP_DOWN
	sprite_movement_data SPRITEMOVEFN_RANDOM_WALK_X,         DOWN,   PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_WALK_LEFT_RIGHT
	sprite_movement_data SPRITEMOVEFN_STANDING,              DOWN,   PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_STANDING_DOWN
	sprite_movement_data SPRITEMOVEFN_STANDING,              UP,     PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_STANDING_UP
	sprite_movement_data SPRITEMOVEFN_STANDING,              LEFT,   PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_STANDING_LEFT
	sprite_movement_data SPRITEMOVEFN_STANDING,              RIGHT,  PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_STANDING_RIGHT
	sprite_movement_data SPRITEMOVEFN_FAST_RANDOM_SPIN,      DOWN,   PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_SPINRANDOM_FAST
	sprite_movement_data SPRITEMOVEFN_OBEY_DPAD,             DOWN,   PERSON_ACTION_STAND,           $02,    $00,    %0000 ; SPRITEMOVEDATA_PLAYER
	sprite_movement_data SPRITEMOVEFN_CUT_TREE,              DOWN,   PERSON_ACTION_CUT_TREE,        $0c,    $00,    %0000 ; SPRITEMOVEDATA_CUTTABLE_TREE
	sprite_movement_data SPRITEMOVEFN_FOLLOW,                DOWN,   PERSON_ACTION_STAND,           $02,    $00,    %0000 ; SPRITEMOVEDATA_FOLLOWING
	sprite_movement_data SPRITEMOVEFN_SCRIPTED,              DOWN,   PERSON_ACTION_STAND,           $02,    $00,    %0000 ; SPRITEMOVEDATA_SCRIPTED
	sprite_movement_data SPRITEMOVEFN_BIG_SNORLAX,           DOWN,   PERSON_ACTION_BIG_SNORLAX,     $2e,    $01,    %1100 ; SPRITEMOVEDATA_SNORLAX
	sprite_movement_data SPRITEMOVEFN_BOUNCE,                DOWN,   PERSON_ACTION_BOUNCE,          $2e,    $00,    %0000 ; SPRITEMOVEDATA_POKEMON
	sprite_movement_data SPRITEMOVEFN_STANDING,              DOWN,   PERSON_ACTION_STAND,           $0c,    $00,    %0000 ; SPRITEMOVEDATA_SUDOWOODO
	sprite_movement_data SPRITEMOVEFN_STANDING,              UP,     PERSON_ACTION_STAND,           $2e,    $10,    %0000 ; SPRITEMOVEDATA_SMASHABLE_ROCK
	sprite_movement_data SPRITEMOVEFN_STRENGTH,              DOWN,   PERSON_ACTION_STAND,           $2e,    $00,    %0100 ; SPRITEMOVEDATA_STRENGTH_BOULDER
	sprite_movement_data SPRITEMOVEFN_FOLLOWNOTEXACT,        DOWN,   PERSON_ACTION_STAND,           $02,    $00,    %0000 ; SPRITEMOVEDATA_FOLLOWNOTEXACT
	sprite_movement_data SPRITEMOVEFN_SHADOW,                DOWN,   PERSON_ACTION_00,              $8e,    $01,    %0000 ; SPRITEMOVEDATA_SHADOW
	sprite_movement_data SPRITEMOVEFN_EMOTE,                 DOWN,   PERSON_ACTION_EMOTE,           $8e,    $02,    %0000 ; SPRITEMOVEDATA_EMOTE
	sprite_movement_data SPRITEMOVEFN_SCREENSHAKE,           DOWN,   PERSON_ACTION_00,              $82,    $00,    %0000 ; SPRITEMOVEDATA_SCREENSHAKE
	sprite_movement_data SPRITEMOVEFN_SPIN_COUNTERCLOCKWISE, LEFT,   PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE
	sprite_movement_data SPRITEMOVEFN_SPIN_CLOCKWISE,        RIGHT,  PERSON_ACTION_STAND,           $00,    $00,    %0000 ; SPRITEMOVEDATA_SPINCLOCKWISE
	sprite_movement_data SPRITEMOVEFN_STRENGTH,              DOWN,   PERSON_ACTION_BIG_DOLL,        $2e,    $01,    %1100 ; SPRITEMOVEDATA_BIGDOLL
	sprite_movement_data SPRITEMOVEFN_BOULDERDUST,           DOWN,   PERSON_ACTION_BOULDER_DUST,    $8e,    $01,    %0000 ; SPRITEMOVEDATA_BOULDERDUST
	sprite_movement_data SPRITEMOVEFN_GRASS,                 DOWN,   PERSON_ACTION_GRASS_SHAKE,     $8e,    $02,    %0000 ; SPRITEMOVEDATA_GRASS
	sprite_movement_data SPRITEMOVEFN_PUDDLE,                DOWN,   PERSON_ACTION_PUDDLE_SPLASH,   $8e,    $02,    %0000 ; SPRITEMOVEDATA_PUDDLE
	sprite_movement_data SPRITEMOVEFN_RANDOM_WALK_XY,        DOWN,   PERSON_ACTION_STAND,           $00,    $00,    %0010 ; SPRITEMOVEDATA_SWIM_AROUND
	sprite_movement_data SPRITEMOVEFN_RANDOM_WALK_Y,         DOWN,   PERSON_ACTION_STAND,           $00,    $00,    %0010 ; SPRITEMOVEDATA_SWIM_UP_DOWN
	sprite_movement_data SPRITEMOVEFN_RANDOM_WALK_X,         DOWN,   PERSON_ACTION_STAND,           $00,    $00,    %0010 ; SPRITEMOVEDATA_SWIM_LEFT_RIGHT
	sprite_movement_data SPRITEMOVEFN_BIG_GYARADOS,          DOWN,   PERSON_ACTION_BIG_GYARADOS,    $2e,    $01,    %1100 ; SPRITEMOVEDATA_BIG_GYARADOS
	sprite_movement_data SPRITEMOVEFN_STANDING_FLIP,         DOWN,   PERSON_ACTION_STAND_FLIP,      $00,    $00,    %0000 ; SPRITEMOVEDATA_STANDING_DOWN_FLIP
	sprite_movement_data SPRITEMOVEFN_STANDING_FLIP,         UP,     PERSON_ACTION_STAND_FLIP,      $00,    $00,    %0000 ; SPRITEMOVEDATA_STANDING_UP_FLIP
	sprite_movement_data SPRITEMOVEFN_POKECOM_NEWS,          DOWN,   PERSON_ACTION_POKECOM_NEWS,    $8e,    $02,    %0000 ; SPRITEMOVEDATA_POKECOM_NEWS
	sprite_movement_data SPRITEMOVEFN_ARCH_TREE,             DOWN,   PERSON_ACTION_ARCH_TREE,       $8e,    $02,    %0000 ; SPRITEMOVEDATA_ARCH_TREE_DOWN
	sprite_movement_data SPRITEMOVEFN_ARCH_TREE,             UP,     PERSON_ACTION_ARCH_TREE,       $8e,    $02,    %0000 ; SPRITEMOVEDATA_ARCH_TREE_UP
	sprite_movement_data SPRITEMOVEFN_ARCH_TREE,             LEFT,   PERSON_ACTION_ARCH_TREE,       $8e,    $02,    %0000 ; SPRITEMOVEDATA_ARCH_TREE_LEFT
	sprite_movement_data SPRITEMOVEFN_ARCH_TREE,             RIGHT,  PERSON_ACTION_ARCH_TREE,       $8e,    $02,    %0000 ; SPRITEMOVEDATA_ARCH_TREE_RIGHT
	sprite_movement_data SPRITEMOVEFN_SAILBOAT_TOP,          DOWN,   PERSON_ACTION_SAILBOAT_TOP,    $2e,    $02,    %1100 ; SPRITEMOVEDATA_SAILBOAT_TOP
	sprite_movement_data SPRITEMOVEFN_SAILBOAT_BOTTOM,       DOWN,   PERSON_ACTION_SAILBOAT_BOTTOM, $2e,    $01,    %1100 ; SPRITEMOVEDATA_SAILBOAT_BOTTOM
