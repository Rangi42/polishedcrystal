"""Helpers for (de)serializing Game Boy structs to Python objects."""

from __future__ import annotations

from typing import ByteString

from . import constants

USER_CHUNK_SIZES = (
    2 + 1 + 1 + constants.NAME_LENGTH + constants.PARTYMON_STRUCT_LENGTH * 4,
    constants.PARTYMON_STRUCT_LENGTH * 2 + constants.NAME_LENGTH * constants.PARTY_LENGTH * 2,
    constants.MAIL_STRUCT_LENGTH * 5,
    constants.MAIL_STRUCT_LENGTH,
)


def read_uint16(buf: ByteString, offset: int = 0) -> int:
    """Return a big-endian 16-bit value without struct dependency."""

    view = memoryview(buf)
    return (view[offset] << 8) | view[offset + 1]


def write_uint16(buf: bytearray, value: int, offset: int = 0) -> None:
    """Store ``value`` at ``offset`` using big-endian order."""

    buf[offset] = (value >> 8) & 0xFF
    buf[offset + 1] = value & 0xFF


def copy_bytes(dst: bytearray, src: ByteString, *, length: int, dst_offset: int = 0, src_offset: int = 0) -> None:
    """Slice-copy data while guarding against short reads."""

    src_slice = bytes(memoryview(src)[src_offset : src_offset + length])
    dst[dst_offset : dst_offset + length] = src_slice


def user_chunk_size(chunk_id: int) -> int:
    """Return the exact byte length for a given chunk ID."""

    try:
        return USER_CHUNK_SIZES[chunk_id]
    except IndexError as exc:  # pragma: no cover - defensive guard
        raise ValueError(f"unknown user chunk id {chunk_id}") from exc


def assert_user_chunk_length(chunk_id: int, payload: ByteString) -> None:
    """Validate that ``payload`` matches the expected chunk length."""

    expected = user_chunk_size(chunk_id)
    actual = len(payload)
    if actual != expected:
        raise ValueError(f"chunk {chunk_id} requires {expected} bytes (got {actual})")
