flag_array: MACRO
	ds ((\1) + 7) / 8
ENDM

breed_struct: MACRO
\1Species::        db
\1Item::           db
\1Moves::          ds NUM_MOVES
\1ID::             dw
\1Exp::            ds 3
\1EVs::
\1HPEV::           db
\1AtkEV::          db
\1DefEV::          db
\1SpdEV::          db
\1SatEV::          db
\1SdfEV::          db
\1DVs::
\1HPAtkDV::        db
\1DefSpdDV::       db
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
\1PokerusStatus::  db
\1CaughtData::
\1CaughtGender::
\1CaughtTime::
\1CaughtBall::     db
\1CaughtLevel::    db
\1CaughtLocation:: db
\1Level::          db
ENDM

party_struct: MACRO
	breed_struct \1
\1Status::         db
\1Unused::         db
\1HP::             dw
\1MaxHP::          dw
\1Stats:: ; big endian
\1Attack::         dw
\1Defense::        dw
\1Speed::          dw
\1SpclAtk::        dw
\1SpclDef::        dw
\1End::
ENDM

battle_struct: MACRO
\1Species::        db
\1Item::           db
\1Moves::          ds NUM_MOVES
; Mon capture assumes personality comes after DVs
\1DVs::
\1HPAtkDV::        db
\1DefSpdDV::       db
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
\1SpclAtk::        dw
\1SpclDef::        dw
\1StatsEnd::
\1Type::
\1Type1::          db
\1Type2::          db
\1StructEnd::
ENDM

savemon_struct: MACRO
\1Species::        db
\1Item::           db
\1Moves::          ds NUM_MOVES
\1ID::             dw
\1Exp::            ds 3
\1EVs::
\1HPEV::           db
\1AtkEV::          db
\1DefEV::          db
\1SpdEV::          db
\1SatEV::          db
\1SdfEV::          db
\1DVs::
\1HPAtkDV::        db
\1DefSpdDV::       db
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
\1CaughtGender::
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

pokedb: MACRO
\1Mons::
\1Mon1::        savemon_struct \1Mon1
\1Mon2::        ds SAVEMON_STRUCT_LENGTH * (MONDB_ENTRIES - 1)
\1End::
ENDM

newbox: MACRO
\1Entries:: ds MONS_PER_BOX
\1Banks::   flag_array MONS_PER_BOX
\1Name::    ds BOX_NAME_LENGTH
\1Theme::   db
ENDM

map_connection_struct: MACRO
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

channel_struct: MACRO
\1MusicID::           dw
\1MusicBank::         db
\1Flags::             db ; 0:on/off 1:subroutine 3:sfx 4:noise 5:rest
\1Flags2::            db ; 0:vibrato on/off 2:duty 4:cry pitch
\1Flags3::            db ; 0:vibrato up/down
\1MusicAddress::      dw
\1LastMusicAddress::  dw
                      dw
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
\1Field0x16::         dw
\1LoopCount::         db
\1Tempo::             dw
\1Tracks::            db ; hi:left lo:right
\1SFXDutyLoop::       db
\1VibratoDelayCount:: db ; initialized by \1VibratoDelay
\1VibratoDelay::      db ; number of frames a note plays until vibrato starts
\1VibratoExtent::     db
\1VibratoRate::       db ; hi:frames for each alt lo:frames to the next alt
\1PitchWheelTarget::  dw ; frequency endpoint for pitch wheel
\1PitchWheelAmount::  db
\1PitchWheelAmountFraction:: db
\1Field0x25::         dw
\1CryPitch::          dw
\1Field0x29::         db
\1Field0x2a::         dw
\1Field0x2c::         db
\1NoteLength::        db ; frames per 16th note
\1Field0x2e::         db
\1Field0x2f::         db
\1Field0x30::         dw
ENDM

mailmsg: MACRO
\1Message::     ds MAIL_MSG_LENGTH
\1MessageEnd::  db
\1Author::      ds PLAYER_NAME_LENGTH
\1Nationality:: dw
\1AuthorID::    dw
\1Species::     db
\1Type::        db
\1End::
ENDM

hof_mon: MACRO
\1Species::     db
\1ID::          dw
\1Personality:: dw
\1Level::       db
\1Nickname::    ds MON_NAME_LENGTH - 1
\1End::
ENDM

roam_struct: MACRO
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

bugcontestwinner: MACRO
\1PersonID:: db
\1Mon::      db
\1Score::    dw
ENDM

hall_of_fame: MACRO
\1WinCount:: db
\1Mon1:: hof_mon \1Mon1
\1Mon2:: hof_mon \1Mon2
\1Mon3:: hof_mon \1Mon3
\1Mon4:: hof_mon \1Mon4
\1Mon5:: hof_mon \1Mon5
\1Mon6:: hof_mon \1Mon6
\1End:: db
ENDM

link_battle_record: MACRO
\1Name::   ds NAME_LENGTH - 1
\1ID::     dw
\1Wins::   dw
\1Losses:: dw
\1Draws::  dw
ENDM

trademon: MACRO
\1Species::     db
\1SpeciesName:: ds MON_NAME_LENGTH
\1Nickname::    ds MON_NAME_LENGTH
\1SenderName::  ds NAME_LENGTH
\1OTName::      ds NAME_LENGTH
\1DVs::
\1HPAtkDV::     db
\1DefSpdDV::    db
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

move_struct: MACRO
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

slot_reel: MACRO
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

object_struct: MACRO
\1Sprite::            db
\1MapObjectIndex::    db
\1SpriteTile::        db
\1MovementType::      db
\1Flags::             dw
\1Palette::           db
\1Walking::           db
\1Direction::         db
\1StepType::          db
\1StepDuration::      db
\1Action::            db
\1ObjectStepFrame::   db
\1Facing::            db
\1StandingTile::      db ; collision
\1LastTile::          db ; collision
\1StandingMapX::      db
\1StandingMapY::      db
\1LastMapX::          db
\1LastMapY::          db
\1ObjectInitX::       db
\1ObjectInitY::       db
\1Radius::            db
\1SpriteX::           db
\1SpriteY::           db
\1SpriteXOffset::     db
\1SpriteYOffset::     db
\1MovementByteIndex:: db
\1Object28::          db
\1Object29::          db
\1Object30::          db
\1Object31::          db
\1Range::             db
\1StructEnd::
ENDM

map_object: MACRO
\1ObjectStructID::  db
\1ObjectSprite::    db
\1ObjectYCoord::    db
\1ObjectXCoord::    db
\1ObjectMovement::  db
\1ObjectRadius::    db
\1ObjectHour::      db
\1ObjectTimeOfDay:: db
\1ObjectColor::     db
\1ObjectRange::     db
\1ObjectScript::    dw
\1ObjectEventFlag:: dw
ENDM

sprite_oam_struct: MACRO
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

sprite_anim_struct: MACRO
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

battle_anim_struct: MACRO
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

battle_bg_effect: MACRO
\1_Function:: db
\1_01::       db
\1_02::       db
\1_03::       db
ENDM
