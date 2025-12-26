"""Socket framing helpers for the Polished Online server."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import ByteString

DEFAULT_CHUNK_SIZE = 256


class ConnectionClosed(RuntimeError):
    """Raised when the remote end disconnects while reading or writing."""


class FramingError(RuntimeError):
    """Raised when a malformed frame is encountered."""


def ensure_length(sock, buffer: bytearray, length: int, *, chunk_size: int = DEFAULT_CHUNK_SIZE) -> bytearray:
    """Read from ``sock`` until ``buffer`` reaches ``length`` bytes."""

    if length < 0:
        raise FramingError("length must be non-negative")
    while len(buffer) < length:
        chunk = sock.recv(chunk_size)
        if not chunk:
            raise ConnectionClosed("client disconnected")
        buffer.extend(chunk)
    return buffer


@dataclass
class ResponseBuilder:
    """Convenience helper for building legacy length-prefixed responses."""

    code: int
    buffer: bytearray = field(init=False)

    def __post_init__(self) -> None:
        self.buffer = bytearray((0, self.code & 0xFF))

    def set_code(self, code: int) -> None:
        self.buffer[1] = code & 0xFF

    def append_byte(self, value: int) -> None:
        self.buffer.append(value & 0xFF)

    def append_bytes(self, payload: ByteString) -> None:
        self.buffer.extend(payload)

    def build(self) -> bytes:
        self.buffer[0] = len(self.buffer) - 1
        return bytes(self.buffer)
