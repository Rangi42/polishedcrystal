from __future__ import annotations

from unittest.mock import patch

import pytest

from netcode import constants
from netcode.models import Battle, LinkType, User


def _fill(buffer: bytearray, start: int = 0) -> None:
    for idx in range(len(buffer)):
        buffer[idx] = (start + idx) % 256


def test_user_chunk_roundtrip_preserves_full_payload():
    reference = User(user_id=1)
    reference.otid = 0xBEEF
    reference.party_count = 4
    reference.gender = 1
    _fill(reference.name, 0x10)
    _fill(reference.mons, 0x20)
    _fill(reference.ot_names, 0x30)
    _fill(reference.nicknames, 0x40)
    _fill(reference.mail, 0x50)

    chunks = [reference.serialize_chunk(i) for i in range(4)]

    restored = User(user_id=2)
    for i, chunk in enumerate(chunks):
        restored.apply_chunk(i, chunk)

    assert restored.serialize_full() == reference.serialize_full()
    assert restored.info_version == 4


def test_user_chunk_validation_rejects_bad_lengths():
    user = User(user_id=3)
    with pytest.raises(ValueError):
        user.apply_chunk(0, b"\x00")


def test_battle_set_action_masks_rng_and_blocks_replay():
    battle = Battle(battle_id=1, host_id=10, client_id=11)

    assert battle.set_action(10, 0xAB)
    assert battle.host_action == 0x0B  # RNG nibble stripped on first turn

    battle.host_offset = 2
    battle.client_offset = 1
    assert not battle.set_action(11, 0xCD)  # still replaying log for client


def test_battle_pending_input_emits_turn_and_rng():
    battle = Battle(battle_id=2, host_id=1, client_id=2)
    battle.host_offset = 1
    battle.client_offset = 1
    battle.host_action = (2 << 4) | 0x3
    battle.client_action = (1 << 4) | 0x4
    battle.rng = bytearray(range(constants.RNG_LENGTH))

    with patch("netcode.models.secrets.token_bytes", return_value=b"\xAA" * constants.RNG_LENGTH):
        payload = battle.pending_input(1)

    assert payload[0] == 0x34  # host sees its action in high nibble
    assert payload[1:] == bytearray(b"\xAA" * constants.RNG_LENGTH)
    assert battle.host_action == 0xFF
    assert battle.host_offset == 1 + 2 + 1  # original + rng bytes + action
    # Previous RNG bytes should be preserved in the log before the turn byte.
    assert battle.log[:2] == bytearray(range(2))
    assert battle.log[-1] == 0x34


def test_trade_pending_input_replays_log_entries():
    battle = Battle(battle_id=3, host_id=5, client_id=6, link_type=LinkType.TRADE)
    battle.log = bytearray([0x11, 0x22, 0x33])
    battle.host_offset = 3
    battle.client_offset = 0
    battle.host_action = 0x10

    payload = battle.pending_input_trade(6)

    assert payload == bytearray([0x11])
    assert battle.client_offset == 1
    assert battle.client_action == 0xFF
