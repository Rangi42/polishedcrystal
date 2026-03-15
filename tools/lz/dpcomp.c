#include "proto.h"

unsigned min(unsigned a, unsigned b) {
    return a < b ? a : b;
}

// best_size[i] = the best compressed length for the first i bytes of input
// Note that this is nondecreasing, since truncating even in
// the middle of a command won't enlarge it.
static unsigned * best_size;
// best_command[i] = the last command of the command stream that yields best_size[i]
static struct command * best_command;

static const unsigned char *data, *bitflipped;
static unsigned size;

static signed char pack_index[256];
static int pack_index_init;

static void init_pack_index(void) {
    if (pack_index_init) return;
    for (unsigned i = 0; i < 256; i++) pack_index[i] = -1;
    for (unsigned i = 0; i < PACK16_TABLE_SIZE; i++) pack_index[pack16_table[i]] = (signed char)i;
    pack_index_init = 1;
}

void consider(unsigned pos, struct command cmd) {
    unsigned new_size = best_size[pos - cmd.count] + command_size(cmd);
    if (new_size < best_size[pos]) {
        best_size[pos] = new_size;
        best_command[pos] = cmd;
    }
}

unsigned match_right(unsigned pos, unsigned at) {
    // Allow overlap (LZ77-style): the decompressor reads from the output buffer,
    // so copy sources can legitimately run into the region being written.
    // This enables better compression for periodic patterns (period > 2) that
    // aren't handled by LZ_REPEAT/LZ_ALTERNATE.
    unsigned n = 0;
    unsigned distance = pos - at;
    while (pos + n < size) {
        unsigned ref = (n < distance) ? (at + n) : (pos + n - distance);
        if (data[pos + n] != data[ref]) break;
        n++;
    }
    return n;
}

unsigned match_flipped(unsigned pos, unsigned at) {
    unsigned n = 0;
    while (pos+n < size && bitflipped[pos+n] == data[at+n]) n++;
    return n;
}

unsigned match_left(unsigned pos, unsigned at) {
    unsigned n = 0;
    while (pos+n < size && n <= at && data[pos+n] == data[at-n]) n++;
    return n;
}

int encode_delta(int pos, int at) {
    if (at - pos >= -LOOKBACK_LIMIT) {
        return at - pos;
    } else {
        return at;
    }
}

void process_input(void) {
    init_pack_index();
    best_size = malloc(sizeof(unsigned) * (size + 1));
    best_command = malloc(sizeof(struct command) * (size + 1));
    best_size[0] = 0;
    for (unsigned short i = 1; i <= size; i++) best_size[i] = -1u;

    for (unsigned plen = 1; plen <= size; plen++) {
        unsigned char current_byte = data[plen - 1];
        for (unsigned prev = plen > MAX_COMMAND_COUNT ? plen - MAX_COMMAND_COUNT : 0; prev < plen; prev++) {
            consider(plen, (struct command) {
                .command = LZ_DATA,
                .count = plen - prev,
                .value = prev,
            });
        }

        unsigned count = 0;
        do {
            count++;
            if (!current_byte || count >= 2)
                consider(plen, (struct command) {
                .command = current_byte ? LZ_REPEAT : LZ_ZERO,
                .count = count,
                .value = current_byte,
            });
        } while (count < MAX_COMMAND_COUNT && count < plen && data[plen - (count + 1)] == current_byte);

        // lzpackhi0: packed literals where every byte has low nibble 0.
        // Consider runs ending at (plen - 1) where (byte & 0x0f) == 0.
        // Minimum length 4: extended opcode (2-byte header + 2 payload) = 4 bytes,
        // vs LZ_DATA (1-byte header + 4 literal) = 5 bytes. Saves 1 byte.
        unsigned packhi0 = 0;
        while (packhi0 < MAX_EXT_COUNT && packhi0 < plen && (data[plen - (packhi0 + 1)] & 0x0f) == 0) packhi0++;
        if (packhi0 >= 4) {
            unsigned start = plen - packhi0;
            // Consider all lengths >= 4. We do two parity passes so we still step by 2.
            for (unsigned prev = start; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = -(int)prev - 1,
                });
            }
            for (unsigned prev = start + 1; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = -(int)prev - 1,
                });
            }
        }

        // lzpacklo0: packed literals where every byte has high nibble 0.
        // Consider runs ending at (plen - 1) where (byte & 0xf0) == 0.
        // Minimum length 4: extended opcode (2-byte header + 2 payload) = 4 bytes,
        // vs LZ_DATA (1-byte header + 4 literal) = 5 bytes. Saves 1 byte.
        unsigned packlo0 = 0;
        while (packlo0 < MAX_EXT_COUNT && packlo0 < plen && (data[plen - (packlo0 + 1)] & 0xf0) == 0) packlo0++;
        if (packlo0 >= 4) {
            unsigned start = plen - packlo0;
            // Consider all lengths >= 4. We do two parity passes so we still step by 2.
            for (unsigned prev = start; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = -(int)prev - 1 - MAX_FILE_SIZE,
                });
            }
            for (unsigned prev = start + 1; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = -(int)prev - 1 - MAX_FILE_SIZE,
                });
            }
        }

        // lzpack16: packed literals using 4-bit indices into pack16_table.
        // Consider runs ending at (plen - 1) where every byte is in the table.
        unsigned pack = 0;
        while (pack < MAX_EXT_COUNT && pack < plen && pack_index[data[plen - (pack + 1)]] >= 0) pack++;
        if (pack >= 4) {
            unsigned start = plen - pack;
            // Consider all lengths >= 4. We do two parity passes so we still step by 2.
            for (unsigned prev = start; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = prev,
                });
            }
            for (unsigned prev = start + 1; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = prev,
                });
            }
        }

        if (plen > 1) {
            count = 1;
            do {
                count++;
                if (count >= 3)
                    consider(plen, (struct command) {
                    .command = LZ_ALTERNATE,
                    .count = count,
                    .value = (data[plen - count + 1] << 8) | (data[plen - count]),
                });
            } while (count < MAX_COMMAND_COUNT && count < plen && data[plen - (count + 1)] == data[plen - (count - 1)]);
        }

        for (unsigned at = 0; at < plen - 1; at++) {
            unsigned k = min(MAX_COMMAND_COUNT, match_right(plen - 1, at));
            for (unsigned i = 2; i <= k; i++) {
                consider(plen + i - 1, (struct command) {
                    .command = LZ_COPY_NORMAL,
                    .count = i,
                    .value = encode_delta(plen - 1, at),
                });
            }

            k = min(MAX_COMMAND_COUNT, match_left(plen - 1, at));
            for (unsigned i = 2; i <= k; i++) {
                consider(plen + i - 1, (struct command) {
                    .command = LZ_COPY_REVERSED,
                    .count = i,
                    .value = encode_delta(plen - 1, at),
                });
            }

            k = min(MAX_COMMAND_COUNT, match_flipped(plen - 1, at));
            for (unsigned i = 2; i <= k; i++) {
                consider(plen + i - 1, (struct command) {
                    .command = LZ_COPY_FLIPPED,
                    .count = i,
                    .value = encode_delta(plen - 1, at),
                });
            }
        }
    }
}

struct command * compress_dp(const unsigned char * _data, const unsigned char * _bitflipped, unsigned short * psize) {
    data = _data;
    bitflipped = _bitflipped;
    size = *psize;
    process_input();
    unsigned command_count = 0;
    unsigned pos = size;
    while (pos > 0) {
        pos -= best_command[pos].count;
        command_count++;
    }
    *psize = command_count;

    struct command * buf = malloc(sizeof(struct command) * command_count);
    pos = size;
    while (pos > 0) {
        buf[--command_count] = best_command[pos];
        pos -= best_command[pos].count;
    }

    return buf;
}
