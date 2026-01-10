from __future__ import annotations

import pytest

from netcode import io


class _FakeSocket:
    def __init__(self, chunks: list[bytes]):
        self._chunks = chunks

    def recv(self, _size: int) -> bytes:
        if not self._chunks:
            return b""
        return self._chunks.pop(0)


def test_response_builder_sets_length() -> None:
    builder = io.ResponseBuilder(0x05)
    builder.append_byte(0xAA)
    builder.append_bytes(b"\x01\x02")
    payload = builder.build()
    assert payload[0] == len(payload) - 1
    assert payload[1] == 0x05
    assert payload[2:] == b"\xAA\x01\x02"


def test_ensure_length_raises_on_disconnect() -> None:
    sock = _FakeSocket([])
    with pytest.raises(io.ConnectionClosed):
        io.ensure_length(sock, bytearray(), 1)
