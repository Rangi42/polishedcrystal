from netcode import constants


def test_command_values_match_wire_protocol():
    assert constants.Command.DISCONNECT == 0x00
    assert constants.Command.STATUS == 0x01
    assert constants.Command.WONDERTRADE == 0x02
    assert constants.Command.SETINFO == 0x03
    assert constants.Command.GETINFO == 0x04
    assert constants.Command.LISTUSERS == 0x05
    assert constants.Command.BATTLEUSER == 0x06
    assert constants.Command.TRADEUSER == 0x07
    assert constants.Command.GETBATTLE == 0x08
    assert constants.Command.BATTLETURN == 0x09
    assert constants.Command.TRADETURN == 0x0A
    assert constants.Command.SETREPLY == 0x0B
    assert constants.Command.GETINFO_VER == 0x0C


def test_signal_values_match_wire_protocol():
    assert constants.Signal.ERROR == 0x81
    assert constants.Signal.ASKBATTLE == 0x86
    assert constants.Signal.ASKTRADE == 0x87


def test_reply_and_error_values():
    assert constants.Reply.ACCEPT == 0x00
    assert constants.Reply.REJECT == 0x01
    assert constants.Reply.WAIT == 0x02

    assert constants.Error.OK == 0x00
    assert constants.Error.UNKNOWN_COMMAND == 0x01
    assert constants.Error.UNKNOWN_USER == 0x02
    assert constants.Error.BAD_INFO == 0x03
    assert constants.Error.INCOMPATIBLE == 0x04
    assert constants.Error.UNAUTHORIZED == 0x05
    assert constants.Error.BUSY == 0x06
    assert constants.Error.REJECTED == 0x07
    assert constants.Error.DESYNCED == 0x08


def test_serialized_user_size_matches_formula():
    expected = (
        2
        + constants.NAME_LENGTH
        + (constants.PARTYMON_STRUCT_LENGTH + constants.NAME_LENGTH * 2) * constants.PARTY_LENGTH
    )
    assert constants.SERIALIZED_USER == expected


def test_length_constants_match_rom_expectations():
    assert constants.NAME_LENGTH == 11
    assert constants.MON_NAME_LENGTH == 11
    assert constants.PARTY_LENGTH == 6
    assert constants.PARTYMON_STRUCT_LENGTH == 0x30
    assert constants.BOXMON_STRUCT_LENGTH == 0x20
    assert constants.MAIL_STRUCT_LENGTH == 0x2F
    assert constants.RNG_LENGTH == 15
