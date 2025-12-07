from __future__ import annotations

from pathlib import Path

from netcode import constants, serialization
from netcode.models import Battle, User


def _seq(length: int, start: int) -> bytes:
    return bytes(((start + idx) % 256) for idx in range(length))


def _sample_user() -> User:
    user = User(user_id=0x2A)
    user.otid = 0x1234
    user.party_count = 5
    user.gender = 0xAF
    user.name[:] = _seq(constants.NAME_LENGTH, 0x10)
    user.mons[:] = _seq(constants.PARTYMON_STRUCT_LENGTH * constants.PARTY_LENGTH, 0x20)
    user.ot_names[:] = _seq(constants.NAME_LENGTH * constants.PARTY_LENGTH, 0x40)
    user.nicknames[:] = _seq(constants.MON_NAME_LENGTH * constants.PARTY_LENGTH, 0x60)
    user.mail[:] = _seq(constants.MAIL_STRUCT_LENGTH * constants.PARTY_LENGTH, 0x80)
    return user


def test_chunk0_layout_matches_legacy_spec():
    user = _sample_user()
    chunk = user.serialize_chunk(0)
    expected = bytearray()
    expected.extend([0x12, 0x34, 0x05, 0xAF])
    expected.extend(_seq(constants.NAME_LENGTH, 0x10))
    expected.extend(_seq(constants.PARTYMON_STRUCT_LENGTH * 4, 0x20))
    assert chunk == bytes(expected)


def test_chunk1_layout_matches_legacy_spec():
    user = _sample_user()
    chunk = user.serialize_chunk(1)
    offset = constants.PARTYMON_STRUCT_LENGTH * 4
    expected = bytearray()
    expected.extend(_seq(constants.PARTYMON_STRUCT_LENGTH * 2, 0x20 + offset))
    expected.extend(_seq(constants.NAME_LENGTH * constants.PARTY_LENGTH, 0x40))
    expected.extend(_seq(constants.MON_NAME_LENGTH * constants.PARTY_LENGTH, 0x60))
    assert chunk == bytes(expected)


def test_chunk2_and_3_match_mail_layout():
    user = _sample_user()
    chunk2 = user.serialize_chunk(2)
    chunk3 = user.serialize_chunk(3)
    expected_mail = _seq(constants.MAIL_STRUCT_LENGTH * constants.PARTY_LENGTH, 0x80)
    expected_chunk2 = expected_mail[: constants.MAIL_STRUCT_LENGTH * 5]
    expected_chunk3 = expected_mail[constants.MAIL_STRUCT_LENGTH * 5 :]
    assert chunk2 == expected_chunk2
    assert chunk3 == expected_chunk3


def test_serialize_full_matches_manual_layout():
    user = _sample_user()
    serialized = user.serialize_full()
    expected = bytearray()
    expected.extend([0x12, 0x34, 0x05, 0xAF])
    expected.extend(_seq(constants.NAME_LENGTH, 0x10))
    expected.extend(_seq(constants.PARTYMON_STRUCT_LENGTH * constants.PARTY_LENGTH, 0x20))
    expected.extend(_seq(constants.NAME_LENGTH * constants.PARTY_LENGTH, 0x40))
    expected.extend(_seq(constants.MON_NAME_LENGTH * constants.PARTY_LENGTH, 0x60))
    expected.extend(_seq(constants.MAIL_STRUCT_LENGTH * constants.PARTY_LENGTH, 0x80))
    assert serialized == bytes(expected)


def test_battle_turn_bytes_match_legacy_host_format():
    battle = Battle(battle_id=9, host_id=1, client_id=2)
    battle.host_offset = battle.client_offset = 0
    battle.host_action = (3 << 4) | 0x7
    battle.client_action = (1 << 4) | 0x2

    payload_for_host = battle.pending_input(1)

    battle = Battle(battle_id=10, host_id=1, client_id=2)
    battle.host_offset = battle.client_offset = 0
    battle.host_action = (3 << 4) | 0x7
    battle.client_action = (1 << 4) | 0x2
    payload_for_client = battle.pending_input(2)

    assert payload_for_host[0] == 0x72
    assert payload_for_client[0] == 0x72


def test_rom_fixture_chunk0_matches_serializer():
    fixture = Path(__file__).with_name("fixtures").joinpath("sample_chunk0.hex")
    lines = [line.strip() for line in fixture.read_text().splitlines() if line.strip() and not line.startswith("#")]
    expected = bytes.fromhex("".join(lines))
    user = _sample_user()
    assert len(expected) == serialization.user_chunk_size(0)
    assert user.serialize_chunk(0) == expected
