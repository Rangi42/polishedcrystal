MACRO flag_array
	ds ((\1) + 7) / 8
ENDM

MACRO breed_struct
\1Species::        db
\1Item::           db
\1Moves::          ds NUM_MOVES
\1ID::             dw
\1Exp::            ds 3
\1EVs::
\1HPEV::           db
\1AtkEV::          db
\1DefEV::          db
\1SpeEV::          db
\1SatEV::          db
\1SdfEV::          db
\1DVs::
\1HPAtkDV::        db
\1DefSpeDV::       db
\1SatSdfDV::       db
\1Personality::
\1Shiny::
\1Ability::
\1Nature::         db
\1Gender::
\1IsEgg::
\1ExtSpecies::
\1Form::           db
\1PP::             ds NUM_MOVES
\1EggCycles::
\1Happiness::      db
\1PokerusStatus::  db
\1CaughtData::
\1CaughtTime::
\1CaughtBall::     db
\1CaughtLevel::    db
\1CaughtLocation:: db
\1Level::          db
ENDM

MACRO party_struct
	breed_struct \1
\1Status::         db
\1Unused::         db
\1HP::             dw
\1MaxHP::          dw
\1Stats:: ; big endian
\1Attack::         dw
\1Defense::        dw
\1Speed::          dw
\1SpAtk::          dw
\1SpDef::          dw
\1End::
ENDM

MACRO battle_struct
\1Species::        db
\1Item::           db
\1Moves::          ds NUM_MOVES
; Mon capture assumes personality comes after DVs
\1DVs::
\1HPAtkDV::        db
\1DefSpeDV::       db
\1SatSdfDV::       db
\1Personality::
\1Shiny::
\1Ability::
\1Nature::         db
\1Gender::
\1IsEgg::
\1ExtSpecies::
\1Form::           db
\1PP::             ds NUM_MOVES
\1Happiness::      db
\1Level::          db
\1Status::         db
\1Unused::         db
\1HP::             dw
\1MaxHP::          dw
\1Stats:: ; big endian
\1Attack::         dw
\1Defense::        dw
\1Speed::          dw
\1SpAtk::          dw
\1SpDef::          dw
\1StatsEnd::
\1Type::
\1Type1::          db
\1Type2::          db
\1StructEnd::
ENDM

MACRO savemon_struct
\1Species::        db
\1Item::           db
\1Moves::          ds NUM_MOVES
\1ID::             dw
\1Exp::            ds 3
\1EVs::
\1HPEV::           db
\1AtkEV::          db
\1DefEV::          db
\1SpeEV::          db
\1SatEV::          db
\1SdfEV::          db
\1DVs::
\1HPAtkDV::        db
\1DefSpeDV::       db
\1SatSdfDV::       db
\1Personality::
\1Shiny::
\1Ability::
\1Nature::         db
\1Gender::
\1IsEgg::
\1ExtSpecies::
\1Form::           db
\1PPUps::          db
\1Happiness::      db
\1PokerusStatus::  db
\1CaughtData::
\1CaughtTime::
\1CaughtBall::     db
\1CaughtLevel::    db
\1CaughtLocation:: db
\1Level::          db
\1Extra::          ds 3 ; superfluous OT name bytes
\1Nickname::       ds MON_NAME_LENGTH - 1
\1OT::             ds PLAYER_NAME_LENGTH - 1
\1End::
ENDM

MACRO pokedb
\1Mons::
	for n, 1, \2 + 1
	\1Mon{d:n}:: savemon_struct \1Mon{d:n}
	endr
\1End::
ENDM

MACRO newbox
\1Entries:: ds MONS_PER_BOX
\1Banks::   flag_array MONS_PER_BOX
\1Name::    ds BOX_NAME_LENGTH
\1Theme::   db
ENDM

MACRO map_connection_struct
\1ConnectedMapGroup::       db
\1ConnectedMapNumber::      db
\1ConnectionStripPointer::  dw
\1ConnectionStripLocation:: dw
\1ConnectionStripLength::   db
\1ConnectedMapWidth::       db
\1ConnectionStripYOffset::  db
\1ConnectionStripXOffset::  db
\1ConnectionWindow::        dw
ENDM

MACRO channel_struct
\1MusicID::           dw
\1MusicBank::         db
\1MusicAddress::      dw
\1LastMusicAddress::  dw
\1Flags::             db ; 0:on/off 1:subroutine 3:sfx 4:noise 5:rest
\1Flags2::            db ; 0:vibrato on/off 2:duty 4:cry pitch 5:vibrato up/down
\1NoteFlags::         db ; 5:rest
\1Condition::         db ; conditional jumps
\1DutyCycle::         db ; bits 6-7 (0:12.5% 1:25% 2:50% 3:75%)
\1Intensity::         db ; hi:pressure lo:velocity
\1Frequency:: ; 11 bits
\1FrequencyLo::       db
\1FrequencyHi::       db
\1Pitch::             db ; 0:rest 1-c:note
\1Octave::            db ; 7-0 (0 is highest)
\1PitchOffset::       db ; raises existing octaves (to repeat phrases)
\1NoteDuration::      db ; frames remaining for the current note
\1Field0x16::         db
\1LoopCount::         db
\1Tempo::             dw
\1Tracks::            db ; hi:left lo:right
\1VibratoDelay::      db ; number of frames a note plays until vibrato starts
\1VibratoDelayCount:: db ; initialized by \1VibratoDelay
\1VibratoExtent::     db
\1VibratoRate::       db ; hi:frames for each alt lo:frames to the next alt
\1PitchWheelTarget::  dw ; frequency endpoint for pitch wheel
\1PitchWheelAmount::  db
\1PitchWheelAmountFraction:: db
\1Field0x25::         db
\1CryPitch::          dw
\1NoteLength::        db ; frames per 16th note
ENDM

MACRO mailmsg
\1Message::     ds MAIL_MSG_LENGTH
\1MessageEnd::  db
\1Author::      ds PLAYER_NAME_LENGTH
\1Nationality:: dw
\1AuthorID::    dw
\1Species::     db
\1Type::        db
\1End::
ENDM

MACRO hof_mon
\1Species::     db
\1ID::          dw
\1Personality:: dw
\1Level::       db
\1Nickname::    ds MON_NAME_LENGTH - 1
\1End::
ENDM

MACRO roam_struct
\1Species::     db
\1Level::       db
\1MapGroup::    db
\1MapNumber::   db
\1HP::          db
\1DVs::         ds 3
\1Personality:: db
\1Form::        db
\1Status::      db
\1End::
ENDM

MACRO bugcontestwinner
\1PersonID:: db
\1Mon::      db
\1Form::     db
\1Score::    dw
ENDM

MACRO hall_of_fame
\1WinCount:: db
	for n, 1, PARTY_LENGTH + 1
	\1Mon{d:n}:: hof_mon \1Mon{d:n}
	endr
\1End:: db
ENDM

MACRO link_battle_record
\1ID::     dw
\1Name::   ds NAME_LENGTH - 1
\1Wins::   dw
\1Losses:: dw
\1Draws::  dw
\1End::
ENDM

MACRO trademon
\1Species::     db
\1SpeciesName:: ds MON_NAME_LENGTH
\1Nickname::    ds MON_NAME_LENGTH
\1SenderName::  ds NAME_LENGTH
\1OTName::      ds NAME_LENGTH
\1DVs::
\1HPAtkDV::     db
\1DefSpeDV::    db
\1SatSdfDV::    db
\1Personality::
\1Shiny::
\1Ability::
\1Nature::      db
\1Gender::
\1IsEgg::
\1ExtSpecies::
\1Form::        db
\1ID::          dw
\1CaughtData::  db
\1End::
ENDM

MACRO move_struct
\1Animation::    db
\1Effect::       db
\1Power::        db
\1Type::         db
\1Accuracy::     db
\1PP::           db
\1EffectChance:: db
\1Category::     db
\1End::
ENDM

MACRO slot_reel
\1ReelAction::   db
\1TilemapAddr::  dw
\1Position::     db
\1SpinDistance:: db
\1SpinRate::     db
\1OAMAddr::      dw
\1XCoord::       db
\1Slot09::       db
\1Slot0a::       db
\1Slot0b::       db
\1Slot0c::       db
\1Slot0d::       db
\1Slot0e::       db
\1Slot0f::       db
ENDM

MACRO object_struct
\1Sprite::         db
\1MapObjectIndex:: db
\1SpriteTile::     db
\1MovementType::   db
\1Flags::          dw
\1Palette::        db
\1Walking::        db
\1Direction::      db
\1StepType::       db
\1StepDuration::   db
\1Action::         db
\1StepFrame::      db
\1Facing::         db
\1TileCollision::  db
\1LastTile::       db ; collision
\1MapX::           db
\1MapY::           db
\1LastMapX::       db
\1LastMapY::       db
\1InitX::          db
\1InitY::          db
\1Radius::         db
\1SpriteX::        db
\1SpriteY::        db
\1SpriteXOffset::  db
\1SpriteYOffset::  db
\1MovementIndex::  db
\1StepIndex::      db
\1Field1d::        db
\1Field1e::        db
\1JumpHeight::     db
\1Range::          db
\1PalIndex::       db
\1StructEnd::
ENDM

MACRO map_object
\1ObjectStructID::   db
\1ObjectSprite::     db
\1ObjectYCoord::     db
\1ObjectXCoord::     db
\1ObjectMovement::   db
\1ObjectRadius::     db
\1ObjectPalette::    db
\1ObjectTimeOfDay::  db
\1ObjectType::       db
\1ObjectSightRange:: db
\1ObjectScript::     dw
\1ObjectEventFlag::  dw
ENDM

MACRO sprite_oam_struct
\1YCoord::     db
\1XCoord::     db
\1TileID::     db
\1Attributes:: db
; bit 7: priority
; bit 6: y flip
; bit 5: x flip
; bit 4: pal # (non-cgb)
; bit 3: vram bank (cgb only)
; bit 2-0: pal # (cgb only)
ENDM

MACRO sprite_anim_struct
\1Index::          db
\1FramesetID::     db
\1AnimSeqID::      db
\1TileID::         db
\1XCoord::         db
\1YCoord::         db
\1XOffset::        db
\1YOffset::        db
\1Duration::       db
\1DurationOffset:: db
\1FrameIndex::     db
\1JumptableIndex:: db
\1Var1::           ds 1
\1Var2::           ds 1
\1Var3::           ds 1
\1Var4::           ds 1
ENDM

MACRO battle_anim_struct
\1_Index::              db
\1_Anim01::             db
\1_Anim02::             db
\1_FramesetIndex::      db
\1_FunctionIndex::      db
\1_Anim05::             db
\1_TileID::             db
\1_XCoord::             db
\1_YCoord::             db
\1_XOffset::            db
\1_YOffset::            db
\1_Anim0b::             db
\1_Anim0c::             db
\1_Anim0d::             db
\1_AnonJumptableIndex:: db
\1_Anim0f::             db
\1_Anim10::             db
\1_Anim11::             db
\1_Anim12::             db
\1_Anim13::             db
\1_Anim14::             db
\1_Anim15::             db
\1_Anim16::             db
\1_Anim17::             db
ENDM

MACRO battle_bg_effect
\1_Function:: db
\1_01::       db
\1_02::       db
\1_03::       db
ENDM
