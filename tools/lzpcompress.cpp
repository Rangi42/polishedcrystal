/** # Introduction
 *
 * LZ (Lempel-Ziv) compression works by generating a stream of *commands* that attempt to more
 * efficiently encode the raw data.
 * For example, “emit <byte>, emit <byte>, emit <byte>” can be expressed more compactly as
 * “emit <byte> 3 times”.
 *
 * There are a lot of variants of LZ compression due to the great flexibility of such a scheme;
 * Polished Crystal's variant evolved from Pokémon Crystal's original LZ (itself very similar to
 * LC_LZ3 [^LC_LZ3]), with additional commands and encoding tweaks to fit Game Boy graphics better.
 *
 * [^LC_LZ3]: “LC_LZ3 Compression Format”
 * https://github.com/bonimy/MushROMs/blob/master/doc/LC_LZ3%20Compression%20Format.md
 */

/** # Command stream
 *
 * Commands are encoded in a less obvious, but far more space-efficient manner.
 * Each command begins with a variable-length header indicating the command and its length,
 * followed by any payload bytes; the next command follows immediately.
 * The stream ends with a special header byte, at which the decompressor stops.
 *
 * The header byte(s) are interpreted in very different ways depending on some of their bits;
 * the various encodings are described first, followed by the decoder's decision tree.
 *
 * ## Command encodings
 *
 * There are seven “simple” LZ commands, which are thus encoded in three bits,
 * with the eigth value triggering some other special behavior.
 *
 * These commands have a “short”, 1-byte encoding:
 *   %cccl_llll
 * The three `c` bits indicate the command, and the five `l` bits encode a length from 0 to 31.
 *
 * They also have a “long”, 2-byte encoding:
 *   %111c_cc0l llll_llll
 * The length is expanded to 9 bits (0–511); the 10th bit is unused because that allows massively
 * speeding up the decompressor's loops. [^9bit_len]
 *
 * There are also some “special” commands:
 *   %1111_11cc llll_llll
 * ...although %1111_1111 instead indicates the end of the stream, and does not have a length byte.
 *
 * [^9bit_len]: “Shorten long lz counts to 9 bits”
 * https://github.com/Rangi42/polishedcrystal/commit/2d48f4f2314fd9e0e91f6df3d36ba87edd8e581d
 *
 * ## Decoding decision tree
 *
 * First, a header byte is read, and checked for “short” encoding: if the `ccc` field is not the
 * reserved value 7, then we have a short command and can process it.
 *
 * Otherwise, check if the byte begins a “long” encoding: if that `ccc` isn't the reserved value 7,
 * then we have a long command and can read the extra byte before processing it.
 *
 * Otherwise (the top 6 bits of the first byte are all set), we must have a special command.
 * First, if it is the terminator byte, simply exit.
 * Otherwise, read the special command's length, and process it.
 *
 * ## Command payloads
 *
 * Each command may have extra payload bytes after its header, but this is instead documented right
 * above each command's `serialize()` function.
 */

#include <algorithm>
#include <array>
#include <assert.h>
#include <charconv>
#include <cstdint>
#include <forward_list>
#include <inttypes.h>
#include <iterator>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string_view>
#include <utility>
#include <variant>
#include <vector>

#if defined(_MSC_VER) || defined(__MINGW32__)
#include <fcntl.h> // `_O_BINARY`.
#include <io.h>    // `_setmode`.
#endif

using namespace std::literals;

// Not using `common.h` so this program can be easily copy-pasted into other projects;
// pardon the boilerplate.

/// From BSD <sysexits.h>, which is deprecated but at least is a convention:
/// https://man.freebsd.org/cgi/man.cgi?query=sysexits&apropos=0&sektion=0&manpath=FreeBSD+16.0-CURRENT&format=html
/// This excludes `EXIT_SUCCESS` and `EXIT_FAILURE`, which are provided by <stdlib.h>.
enum {
	EXIT_BAD_USAGE = 64,
	EXIT_DATA_ERR = 65,
	EXIT_MISSING_INPUT = 66,
	EXIT_OS_ERR = 71,
	EXIT_CANT_CREATE = 73,
	EXIT_IO_ERR = 74,
};

[[noreturn, gnu::format(printf, 2, 3)]]
static void error_exit(int error_code, char const *error, ...) {
	va_list ap;
	va_start(ap, error);
	fputs("error: ", stderr);
	vfprintf(stderr, error, ap);
	va_end(ap);
	exit(error_code);
}

[[noreturn]] static void unreachable() {
#if __has_builtin(__builtin_unreachable)
	__builtin_unreachable();
#else
	abort();
#endif
}

static std::pair<std::vector<uint8_t>, char const *> read_input(char const *path) {
	FILE *input;
	char const *filename = path;
	if (path == nullptr || strcmp(path, "-") == 0) {
#if defined(_MSC_VER) || defined(__MINGW32__)
		errno = 0;
		int result = _setmode(_fileno(stdin), _O_BINARY);
		if (result == -1) {
			error_exit(EXIT_OS_ERR, "cannot set standard input to binary mode: %s\n",
			           strerror(errno));
		}
#endif
		input = stdin;
		filename = "<standard input>";
	} else {
		errno = 0;
		input = fopen(path, "rb");
		if (input == nullptr) {
			error_exit(EXIT_MISSING_INPUT, "cannot open input file \"%s\": %s\n", path,
			           strerror(errno));
		}
	}

	std::vector<uint8_t> data;
	for (;;) {
		size_t cur_size = data.size();
		data.resize(cur_size + BUFSIZ);
		errno = 0;
		size_t ret = fread(data.data() + cur_size, sizeof(uint8_t), BUFSIZ, input);
		if (ret < BUFSIZ) { // This only occurs at EOF or on error.
			if (ferror(input)) {
				error_exit(EXIT_IO_ERR, "error reading \"%s\": %s\n", path, strerror(errno));
			}
			assert(feof(input));
			data.resize(cur_size + ret);
			break;
		}
	}

	if (input != stdin) {
		fclose(input);
	}
	return {data, filename};
}

static FILE *open_output_file(char const *path, bool textual) {
	FILE *output;
	if (path == nullptr || strcmp(path, "-") == 0) {
#if defined(_MSC_VER) || defined(__MINGW32__)
		errno = 0;
		int result = _setmode(_fileno(stdout), textual ? _O_TEXT : _O_BINARY);
		if (result == -1) {
			error_exit(EXIT_OS_ERR, "cannot set standard output to %s mode: %s\n",
			           textual ? "text" : "binary", strerror(errno));
		}
#endif
		output = stdout;
	} else {
		errno = 0;
		output = fopen(path, textual ? "wt" : "wb");
		if (output == nullptr) {
			error_exit(EXIT_CANT_CREATE, "cannot create output file \"%s\": %s\n", path,
			           strerror(errno));
		}
	}
	return output;
}

static void close_output_file(FILE *file) {
	if (file != stdout) {
		fclose(file);
	}
}

void xfwrite(uint8_t const *data, size_t size, FILE *file, char const *filename) {
	errno = 0;
	if (fwrite(data, sizeof(*data), size, file) != size) {
		close_output_file(file);
		error_exit(EXIT_IO_ERR, "could not write to output file \"%s\": %s\n", filename,
		           strerror(errno));
	}
}

void xputc(uint8_t ch, FILE *file, char const *filename) {
	errno = 0;
	if (putc(ch, file) == EOF) {
		close_output_file(file);
		error_exit(EXIT_IO_ERR, "could not write to output file \"%s\": %s\n", filename,
		           strerror(errno));
	}
}

// C++20-like `span`, but with Python slice indexing semantics.
struct Span {
	uint8_t const *start;
	size_t len;

	uint8_t const &operator[](int idx) const {
		if (idx < 0) {
			assert(size_t(-idx) <= len);
			return start[idx + len];
		} else {
			assert(size_t(idx) < len);
			return start[idx];
		}
	}

	uint8_t const *begin() const { return start; }
	uint8_t const *end() const { return start + len; }

	/// Are all of the bytes in this span identical?
	bool is_uniform() const {
		assert(this->len > 0);
		return std::all_of(this->begin(), this->end(),
		                   [this](uint8_t byte) { return byte == this->start[0]; });
	}

	void resize_left(int how_much) {
		// No equivalent check when growing, since we don't know where the owning buffer starts.
		if (how_much < 0) {
			assert(size_t(-how_much) <= this->len); // Guard against underflow.
		}
		this->len += how_much;
		this->start -= how_much;
	}

	bool has_same_contents_as(Span const &other) const {
		assert(this->len == other.len);
		return std::equal(this->begin(), this->end(), other.begin());
	}
};

// `std::bit_reverse` is in C++29. Ouch.
// As of 2026-11-04, Clang 13 appears to (sometimes) recognise this idiom and optimise it to the
// dedicated CPU instruction when there is one <https://godbolt.org/z/14MM3cExW>
// so it's not worth attempting to use `__builtin_bitreverse()` when it's available.
static uint8_t reverse_bits(uint8_t byte) {
	byte = (byte & 0xF0) >> 4 | (byte & 0x0F) << 4; // Swap nibbles...
	byte = (byte & 0xCC) >> 2 | (byte & 0x33) << 2; // ...then bit pairs within each nibble...
	byte = (byte & 0xAA) >> 1 | (byte & 0x55) << 1; // ...then bits within each pair.
	return byte;
}

static void print_byte_list(FILE *file, uint8_t const *bytes, size_t len) {
	assert(len != 0);
	fprintf(file, "$%02x", bytes[0]);
	for (uint8_t byte : Span{bytes + 1, size_t(len - 1)}) {
		fprintf(file, ", $%02" PRIx8, byte);
	}
}

// The actual compressor logic.

// “Normal” command IDs.
enum LzCmdId {
	LZ_DATA,
	LZ_REPEAT,
	LZ_ALTERNATE,
	LZ_ZERO,
	LZ_COPY_NORMAL,
	LZ_COPY_FLIPPED,
	LZ_COPY_REVERSED,
};

enum LzSpecialCmdId {
	LZ_SPECIAL_PACKHI0 = 0xfc,
	LZ_SPECIAL_PACK16SHORT,
	LZ_SPECIAL_PACKLO0,
	LZ_END
};

/// Every LZ command's implementation derives from this abstract base class; there are some helpers
/// in the hierarchy, which can be distinguished from the actual commands by the latter being marked
/// `final`.
struct LzCmd {
	uint16_t len;

	/// Maximum length the “long” header format can encode.
	constexpr static uint16_t MAX_LONG_LENGTH = 512;

	/// This command refuses to encode fewer bytes than this.
	// Most commands are fine with encoding a single byte, but several have had their implementation
	// tweaked to unconditionally write more bytes than the length field encodes, because they would
	// otherwise be redundant with another command (e.g. `lzdata <byte>` is encoded using as many
	// bytes as `lzrepeat 1, <byte>` while emitting the same byte), and increasing the maximum
	// representable length allows a command to be more efficient at compressing data.
	virtual uint16_t min_length() const = 0;
	/// This command cannot encode more bytes than this. (Inclusive.)
	virtual uint16_t max_length() const { return this->min_length() + MAX_LONG_LENGTH - 1; }
	/// How many bytes in the compressed output would this command take?
	virtual size_t num_encoded_bytes() const = 0;

	virtual void serialize(uint8_t const *bytes, FILE *output, bool textual,
	                       char const *filename) const = 0;
	virtual void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const = 0;

	// No default-constructing the base class or any derived one unless it specifically wants to.
	LzCmd() = delete;

  protected:
	explicit LzCmd(uint16_t len_) : len(len_) {}

	/// Helper function for computing encoded sizes.
	size_t num_header_bytes() const {
		// How many bytes after the mandatory one(s)?
		size_t num_extra_bytes = this->len - this->min_length();
		// Short encoding, or long encoding?
		return num_extra_bytes < (1 << 5) ? 1 : 2;
	}
	void serialize_header(FILE *file, LzCmdId cmd_id, char const *filename) const {
		// How many bytes after the mandatory one(s)?
		size_t num_extra_bytes = this->len - this->min_length();
		if (num_extra_bytes < (1 << 5)) {
			xputc(cmd_id << 5 | num_extra_bytes, file, filename);
		} else {
			xputc(0b111 << 5 | cmd_id << 2 | num_extra_bytes >> 8, file, filename);
			xputc(num_extra_bytes & 0xff, file, filename);
		}
	}
};

struct LzData final : public LzCmd {
	explicit LzData(uint16_t len_) : LzCmd(len_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}
	// This is the “fallback” command, and thus it needs to be able to emit a single byte.
	// (See also the comment on `LzRepeat::min_length()` for more details of this decision.)
	constexpr static uint16_t MIN_LENGTH = 1;
	uint16_t min_length() const override { return MIN_LENGTH; }
	// Header + each payload byte as-is.
	size_t num_encoded_bytes() const override { return this->num_header_bytes() + this->len; }

	template <typename Func>
	static void for_each_possible_cmd(Func const &func, Span const &emitted_bytes) {
		for (size_t data_len = 1;
		     data_len <= emitted_bytes.len && data_len < MIN_LENGTH + MAX_LONG_LENGTH; ++data_len) {
			// Since this command's cost increases monotonically, if the cost is higher than the
			// current best sum, any further attempts are guaranteed to fail.
			if (!func(LzData(data_len))) {
				break;
			}
		}
	}

	/**
	 * The command is followed by the bytes that it needs to copy (as many as its length, thus).
	 */
	void serialize(uint8_t const *bytes, FILE *file, bool textual,
	               char const *filename) const override {
		if (textual) {
			fprintf(file, "\tlzdata ");
			print_byte_list(file, bytes, this->len);
			xputc('\n', file, filename);
		} else {
			this->serialize_header(file, LZ_DATA, filename);
			xfwrite(bytes, this->len, file, filename);
		}
	}
	void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const override {
		std::copy_n(payload, this->len, std::back_inserter(dest));
	}
};
struct LzRepeat final : public LzCmd {
	explicit LzRepeat(uint16_t len_) : LzCmd(len_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}
	// To avoid being equivalent to `LzData`.
	// Note that the minimum count of `LzData` could instead have been bumped to 2 instead, but
	// since that command performs no compression (it's pretty much a fall-back), we want to
	// generally avoid it, and thus it is not worth allowing it to be longer.
	constexpr static uint16_t MIN_LENGTH = 2;
	uint16_t min_length() const override { return MIN_LENGTH; }
	// Header + payload byte.
	size_t num_encoded_bytes() const override { return this->num_header_bytes() + 1; }

	template <typename Func>
	static void for_each_possible_cmd(Func const &func, Span const &emitted_bytes) {
		uint8_t last_byte = emitted_bytes[-1];
		for (size_t data_len = 2;
		     data_len <= emitted_bytes.len && data_len < MIN_LENGTH + MAX_LONG_LENGTH; ++data_len) {
			// If the bytes are no longer repeating, stop.
			if (emitted_bytes[-data_len] != last_byte) {
				break;
			}
			// Since this command's cost increases monotonically, if the cost is higher than the
			// current best sum, any further attempts are guaranteed to fail.
			if (!func(LzRepeat(data_len))) {
				break;
			}
		}
	}

	/**
	 * The command is followed by the byte that ought to be repeated.
	 */
	void serialize(uint8_t const *bytes, FILE *file, bool textual,
	               char const *filename) const override {
		assert((Span{bytes, this->len}).is_uniform());

		if (textual) {
			fprintf(file, "\tlzrepeat %" PRIu16 ", $%02" PRIx8 "\n", this->len, bytes[0]);
		} else {
			this->serialize_header(file, LZ_REPEAT, filename);
			putc(bytes[0], file);
		}
	}
	void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const override {
		std::fill_n(std::back_inserter(dest), this->len, payload[0]);
	}
};
struct LzAlternate final : public LzCmd {
	explicit LzAlternate(uint16_t len_) : LzCmd(len_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}
	// Less than this is just sparkling `LzData`. The same rationale as for `LzRepeat` applies.
	constexpr static uint16_t MIN_LENGTH = 3;
	uint16_t min_length() const override { return MIN_LENGTH; }
	// Header + the 2 payload bytes.
	size_t num_encoded_bytes() const override { return this->num_header_bytes() + 2; }

	template <typename Func>
	static void for_each_possible_cmd(Func const &func, Span const &emitted_bytes) {
		if (emitted_bytes.len >= 2) {
			uint8_t last_byte = emitted_bytes[-1], penultimate = emitted_bytes[-2];
			for (size_t data_len = 3;
			     data_len <= emitted_bytes.len && data_len < MIN_LENGTH + MAX_LONG_LENGTH;
			     ++data_len) {
				// If the bytes are no longer repeating (alternated), stop.
				if (emitted_bytes[-data_len] != (data_len % 2 != 0 ? last_byte : penultimate)) {
					break;
				}
				// Since this command's cost increases monotonically, if the cost is higher than the
				// current best sum, any further attempts are guaranteed to fail.
				if (!func(LzAlternate(data_len))) {
					break;
				}
			}
		}
	}

	/**
	 * The command is followed by the two bytes to be repeated.
	 */
	void serialize(uint8_t const *bytes, FILE *file, bool textual,
	               char const *filename) const override {
		assert(std::all_of(bytes, bytes + this->len, [&bytes](uint8_t const &byte) {
			size_t idx = &byte - bytes;
			return byte == bytes[idx % 2];
		}));

		if (textual) {
			fprintf(file, "\tlzalternate %" PRIu16 ", $%02" PRIx8 ", $%02" PRIx8 " ; ", this->len,
			        bytes[0], bytes[1]);
			print_byte_list(file, bytes, this->len);
			xputc('\n', file, filename);
		} else {
			this->serialize_header(file, LZ_ALTERNATE, filename);
			xfwrite(bytes, 2, file, filename);
		}
	}
	void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const override {
		std::generate_n(std::back_inserter(dest), this->len, [&payload, i = 0]() mutable {
			uint8_t byte = payload[i];
			i ^= 1;
			return byte;
		});
	}
};
struct LzZero final : public LzCmd {
	explicit LzZero(uint16_t len_) : LzCmd(len_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}
	// Note that this command uses the default minimum length of 1: unlike `LzRepeat`, `lzzero 1` is
	// *smaller* than `lzdata $00`! Thus, it's always worth attempting it when possible.
	constexpr static uint16_t MIN_LENGTH = 1;
	uint16_t min_length() const override { return MIN_LENGTH; }

	// Just the header.
	size_t num_encoded_bytes() const override { return this->num_header_bytes(); }

	template <typename Func>
	static void for_each_possible_cmd(Func const &func, Span const &emitted_bytes) {
		assert(emitted_bytes[-1] == 0);
		for (size_t data_len = 1;
		     data_len <= emitted_bytes.len && data_len < MIN_LENGTH + MAX_LONG_LENGTH; ++data_len) {
			// If the bytes are no longer repeating, stop.
			if (emitted_bytes[-data_len] != 0) {
				break;
			}
			// Since this command's cost increases monotonically, if the cost is higher than the
			// current best sum, any further attempts are guaranteed to fail.
			if (!func(LzZero(data_len))) {
				break;
			}
		}
	}

	/**
	 * The command does not have any payload bytes.
	 */
	void serialize(uint8_t const *bytes, FILE *file, bool textual,
	               char const *filename) const override {
		assert(bytes[0] == 0);
		assert((Span{bytes, this->len}).is_uniform());

		if (textual) {
			fprintf(file, "\tlzzero %" PRIu16 "\n", this->len);
		} else {
			this->serialize_header(file, LZ_ZERO, filename);
		}
	}
	void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const override {
		(void)payload;
		std::fill_n(std::back_inserter(dest), this->len, 0);
	}
};

/// Copies data that has already been decompressed, possibly by the same command.
struct LzCopyCmd : public LzCmd {
	int16_t start_ofs; // Either negative 8-bit, or positive 15-bit.

	// FIXME: due to the overhead of the offset, this should be at least 2.
	//        This may be feasible to implement by unconditionally copying the first byte before
	//        entering the appropriate copy loop (with an ad-hoc correction for the “flipped”
	//        variant), and incrementing/decrementing the source *before* each copy within the loop.
	//        (Make sure to change `for_each_possible_cmd` accordingly!)
	constexpr static uint16_t MIN_LENGTH = 1;
	uint16_t min_length() const override { return MIN_LENGTH; }

	// Header + start offset, which is either 1-byte or 2-byte.
	size_t num_encoded_bytes() const override {
		return this->num_header_bytes() + (this->start_ofs < 0 ? 1 : 2);
	}

	template <typename Func>
	static void for_each_possible_cmd(Func const &func, Span const &emitted_bytes);

  protected:
	LzCopyCmd(uint16_t len_, int16_t start_ofs_) : LzCmd(len_), start_ofs(start_ofs_) {}

	/**
	 * The command is followed by the offset of the first source byte in the decompressed stream;
	 * it is encoded either as one negative byte, or as a positive big-endian word.
	 * The former indicates that the offset is (127 - N) bytes behind the current write position,
	 * the latter that the offset is N bytes from the start of the decompressed stream.
	 */
	void serialize_copy_cmd(char const *name, LzCmdId cmd_id, uint8_t const *bytes, FILE *file,
	                        bool textual, char const *filename) const {
		if (this->start_ofs < 0) {
			assert(this->start_ofs >= -128);
		}

		if (textual) {
			fprintf(file, "\tlzcopy %s, %" PRIu16 ", %" PRId16 " ; ", name, this->len,
			        this->start_ofs);
			print_byte_list(file, bytes, this->len);
			xputc('\n', file, filename);
		} else {
			this->serialize_header(file, cmd_id, filename);
			if (this->start_ofs < 0) {
				// FIXME: dumping `start_ofs` as-is should be faster, actually
				xputc((127 - this->start_ofs) & 0xff, file, filename);
			} else {
				// MSB first, since its bit 7 is what selects between the two.
				xputc(this->start_ofs >> 8, file, filename);
				xputc(this->start_ofs & 0xff, file, filename);
			}
		}
	}
	uint8_t const *copy_src_start(std::vector<uint8_t> const &dest, uint8_t const *payload) const {
		if (this->start_ofs < 0) {
			assert((127 - payload[0]) == this->start_ofs);
			assert(this->start_ofs >= -128);
			return &dest[dest.size() + this->start_ofs];
		} else {
			assert((payload[0] << 8 | payload[1]) == this->start_ofs);
			assert(size_t(this->start_ofs) < dest.size());
			return &dest[this->start_ofs];
		}
	}
};
struct LzCopyNormal final : public LzCopyCmd {
	LzCopyNormal(uint16_t len_, int16_t start_ofs_) : LzCopyCmd(len_, start_ofs_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}

	/**
	 * See `LzCopyCmd::serialize_copy_cmd()`.
	 */
	void serialize(uint8_t const *bytes, FILE *file, bool textual,
	               char const *filename) const override {
		this->serialize_copy_cmd("normal", LZ_COPY_NORMAL, bytes, file, textual, filename);
	}
	void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const override {
		dest.reserve(dest.size() +
		             this->len); // Required for the next pointer to remain stable during insertion.
		uint8_t const *src = this->copy_src_start(dest, payload);
		for (size_t i = 0; i < this->len; ++i) {
			dest.push_back(*src);
			++src;
		}
	}
};
struct LzCopyFlipped final : public LzCopyCmd {
	LzCopyFlipped(uint16_t len_, int16_t start_ofs_) : LzCopyCmd(len_, start_ofs_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}

	/**
	 * See `LzCopyCmd::serialize_copy_cmd()`.
	 */
	void serialize(uint8_t const *bytes, FILE *file, bool textual,
	               char const *filename) const override {
		this->serialize_copy_cmd("flipped", LZ_COPY_FLIPPED, bytes, file, textual, filename);
	}
	void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const override {
		dest.reserve(dest.size() +
		             this->len); // Required for the next pointer to remain stable during insertion.
		uint8_t const *src = this->copy_src_start(dest, payload);
		for (size_t i = 0; i < this->len; ++i) {
			dest.push_back(reverse_bits(*src));
			++src;
		}
	}
};
struct LzCopyReversed final : public LzCopyCmd {
	LzCopyReversed(uint16_t len_, int16_t start_ofs_) : LzCopyCmd(len_, start_ofs_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}

	/**
	 * See `LzCopyCmd::serialize_copy_cmd()`.
	 */
	void serialize(uint8_t const *bytes, FILE *file, bool textual,
	               char const *filename) const override {
		this->serialize_copy_cmd("reversed", LZ_COPY_REVERSED, bytes, file, textual, filename);
	}
	void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const override {
		dest.reserve(dest.size() +
		             this->len); // Required for the next pointer to remain stable during insertion.
		uint8_t const *src = this->copy_src_start(dest, payload);
		for (size_t i = 0; i < this->len; ++i) {
			dest.push_back(*src);
			--src;
		}
	}
};
template <typename Func>
void LzCopyCmd::for_each_possible_cmd(Func const &func, Span const &emitted_bytes) {
	auto copy_start_ofs = [&emitted_bytes](Span const &dest, uint8_t const *first_src_byte_ptr) {
		assert(first_src_byte_ptr - emitted_bytes.start >= 0);
		assert(dest.start - first_src_byte_ptr > 0);

		if (size_t relative_ofs = dest.start - first_src_byte_ptr; relative_ofs <= 128) {
			return -relative_ofs;
		} else {
			size_t absolute_ofs = first_src_byte_ptr - emitted_bytes.start;
			assert(absolute_ofs <= INT16_MAX);
			return absolute_ofs;
		}
	};

	uint8_t last_byte = emitted_bytes[-1], last_byte_flipped = reverse_bits(last_byte);
	// Seek opportunities for referencing previously-decompressed data;
	// since, as usual, we are looking for copies that *end* at the current byte,
	// we anchor searches based on that byte, and then proceed through each candidate range in
	// the direction *opposite* the copy's normal direction!

	// Make sure to search for anchors backwards, so commands with smaller encodings are
	// attempted first, and the “cost short-circuiting” optimisation remains valid.
	// Also, start searching *before* `last_byte`, otherwise we would be trying to copy the whole
	// data onto itself.
	assert(emitted_bytes.len > 0);
	for (size_t src_end_idx = emitted_bytes.len - 1; src_end_idx--;) {
		if (emitted_bytes[src_end_idx] == last_byte) {
			// Check if a normal, forward copy is possible.
			for (Span dest{&emitted_bytes[-1], 1}, src{&emitted_bytes[src_end_idx], 1};
			     src.len < LzCopyNormal::MIN_LENGTH + MAX_LONG_LENGTH &&
			     emitted_bytes[-dest.len] == src[0];
			     src.resize_left(1), dest.resize_left(1)) {
				assert(src.len == dest.len);

				if (!func(LzCopyNormal(src.len, copy_start_ofs(dest, src.start)))) {
					break;
				}
				// If the copy would start at the beginning of the decompressed stream, stop
				// searching.
				// It is however OK for `src` and `dest` to overlap! It only causes the
				// non-overlapping bytes to get repeated afterwards.
				if (src.start == emitted_bytes.start) {
					break;
				}
			}
			// Try also a reverse-direction copy; the logic is the same, but `src` grows to the
			// *right* instead.
			for (Span dest{&emitted_bytes[-1], 1}, src{&emitted_bytes[src_end_idx], 1};
			     src.len < LzCopyReversed::MIN_LENGTH + MAX_LONG_LENGTH &&
			     emitted_bytes[-dest.len] == src[-1];
			     src.len += 1, dest.resize_left(1)) {
				assert(src.len == dest.len);

				if (!func(LzCopyReversed(src.len, copy_start_ofs(dest, &src[-1])))) {
					break;
				}
				// Unlike a forward copy, `src` and `dest` must NOT overlap!
				// Each iteration of the loop grows each of the two spans by one byte each, so there
				// must be at least two byte of room between them.
				assert(dest.begin() - src.end() >= 0);
				if (dest.begin() - src.end() < 2) {
					break;
				}
			}
		}
		// This is not mutually exclusive with the above, in case the byte is symmetrical.
		if (emitted_bytes[src_end_idx] == last_byte_flipped) {
			// Check if a normal, forward copy is possible.
			for (Span dest{&emitted_bytes[-1], 1}, src{&emitted_bytes[src_end_idx], 1};
			     src.len < LzCopyFlipped::MIN_LENGTH + MAX_LONG_LENGTH &&
			     emitted_bytes[-dest.len] == reverse_bits(src[0]);
			     src.resize_left(1), dest.resize_left(1)) {
				if (!func(LzCopyFlipped(src.len, copy_start_ofs(dest, src.start)))) {
					break;
				}
				// If the copy would start at the beginning of the decompressed stream, stop
				// searching.
				// It is however OK for `src` and `dest` to overlap! It only causes the
				// non-overlapping bytes to get repeated afterwards.
				if (src.start == emitted_bytes.start) {
					break;
				}
			}
		}
	}
}

struct LzSpecialCmd : public LzCmd {
	// FIXME: min length should be 2, and then the max length should become 257,
	//        or that value reserved for some special purpose...
	constexpr static uint16_t MIN_LENGTH = 1;
	uint16_t min_length() const override { return MIN_LENGTH; }
	// All of the special commands use an 8-bit length instead of the “long” header encoding.
	uint16_t max_length() const override { return this->min_length() + 256 - 1; }
	// All of the special commands have a one-byte header, one-byte length, and operate on a nibble
	// stream, thus two output bytes compress to one (rounding up, though).
	size_t num_encoded_bytes() const override { return 1 + 1 + (this->len + 1) / 2; }

  protected:
	explicit LzSpecialCmd(uint16_t len_) : LzCmd(len_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}

	/**
	 * All special commands use a different header format:
	 * - the first byte encodes the command ID (remember that the encoding of normal command forces
	 *   its upper 6 bits to all be 1),
	 * - the second byte encodes the command's length.
	 */
	void serialize_special_header(FILE *file, LzSpecialCmdId cmd_id, char const *filename) const {
		xputc(cmd_id, file, filename);
		xputc(this->len - 1, file, filename);
	}
	template <typename Func>
	void decompress_special_cmd(std::vector<uint8_t> &dest, uint8_t const *payload,
	                            Func const &func) const {
		std::generate_n(std::back_inserter(dest), this->len, [&payload, &func, i = 0]() mutable {
			uint8_t byte = payload[i / 2];
			return func(i++ % 2 == 0 ? byte >> 4 : byte & 0x0f);
		});
	}
};
struct LzSpecialPackhi0 final : public LzSpecialCmd {
	explicit LzSpecialPackhi0(uint16_t len_) : LzSpecialCmd(len_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}

	template <typename Func>
	static void for_each_possible_cmd(Func const &func, Span const &emitted_bytes) {
		for (size_t data_len = MIN_LENGTH;
		     data_len <= emitted_bytes.len && data_len < MIN_LENGTH + 256; ++data_len) {
			// If the lower nibble is no longer zero, stop.
			if ((emitted_bytes[-data_len] & 0x0f) != 0) {
				break;
			}
			// Since this command's cost increases monotonically, if the cost is higher than the
			// current best sum, any further attempts are guaranteed to fail.
			if (!func(LzSpecialPackhi0(data_len))) {
				break;
			}
		}
	}

	/**
	 * This command is followed by a stream of “big-endian” nibbles that get zero-padded then
	 * output; if there is an odd number of nibbles, the last byte's low nibble is ignored.
	 */
	void serialize(uint8_t const *bytes, FILE *file, bool textual,
	               char const *filename) const override {
		assert(
			std::all_of(bytes, bytes + this->len, [](uint8_t byte) { return (byte & 0x0f) == 0; }));

		if (textual) {
			fputs("\tlzpackhi ", file);
			print_byte_list(file, bytes, this->len);
			xputc('\n', file, filename);
		} else {
			this->serialize_special_header(file, LZ_SPECIAL_PACKHI0, filename);

			Span remaining{bytes, this->len};
			while (remaining.len >= 2) {
				uint8_t first = remaining.start[0], second = remaining.start[1];
				xputc(first | second >> 4, file, filename);

				remaining.resize_left(-2);
			}
			if (remaining.len > 0) {
				assert(remaining.len == 1);
				xputc(remaining.start[0], file, filename);
			}
		}
	}
	void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const override {
		this->decompress_special_cmd(dest, payload, [](uint8_t byte) { return byte << 4; });
	}
};
struct LzSpecialPack16Short final : public LzSpecialCmd {
	explicit LzSpecialPack16Short(uint16_t len_) : LzSpecialCmd(len_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}
	/// Fixed dictionary designed to be indexed using a single nibble.
	/// This is intentionally biased toward very common tile/bitmask bytes.
	static constexpr std::array<uint8_t, 16> const dict{
		0x00, 0xff, 0x01, 0x02, 0x03, 0xfe, 0x80, 0x07,
		0xc0, 0x7f, 0x04, 0x0f, 0x1f, 0x3f, 0x08, 0xfc,
	};
	// Returns 16 if not in the dict.
	static uint8_t dict_key(uint8_t byte) {
		return std::find(dict.cbegin(), dict.cend(), byte) - dict.cbegin();
	}

	template <typename Func>
	static void for_each_possible_cmd(Func const &func, Span const &emitted_bytes) {
		for (size_t data_len = 1; data_len <= emitted_bytes.len && data_len <= 256; ++data_len) {
			// If the bytes are no longer in the dictionary, stop.
			if (std::find(dict.cbegin(), dict.cend(), emitted_bytes[-data_len]) == dict.cend()) {
				break;
			}
			// Since this command's cost increases monotonically, if the cost is higher than the
			// current best sum, any further attempts are guaranteed to fail.
			if (!func(LzSpecialPack16Short(data_len))) {
				break;
			}
		}
	}

	/**
	 * This command is followed by a stream of “big-endian” nibbles that get zero-padded then
	 * output; if there is an odd number of nibbles, the last byte's low nibble is ignored.
	 */
	void serialize(uint8_t const *bytes, FILE *file, bool textual,
	               char const *filename) const override {
		assert(std::all_of(bytes, bytes + this->len,
		                   [](uint8_t byte) { return dict_key(byte) < 16; }));

		if (textual) {
			fputs("\tlzpack16 ", file);
			print_byte_list(file, bytes, this->len);
			xputc('\n', file, filename);
		} else {
			this->serialize_special_header(file, LZ_SPECIAL_PACK16SHORT, filename);

			Span remaining{bytes, this->len};
			while (remaining.len >= 2) {
				uint8_t first_idx = dict_key(remaining.start[0]),
						second_idx = dict_key(remaining.start[1]);
				xputc(first_idx << 4 | second_idx, file, filename);

				remaining.resize_left(-2);
			}
			if (remaining.len > 0) {
				assert(remaining.len == 1);
				xputc(dict_key(remaining.start[0]) << 4, file, filename);
			}
		}
	}
	void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const override {
		this->decompress_special_cmd(dest, payload, [](uint8_t byte) { return dict[byte]; });
	}
};
struct LzSpecialPacklo0 final : public LzSpecialCmd {
	explicit LzSpecialPacklo0(uint16_t len_) : LzSpecialCmd(len_) {
		assert(this->len >= this->min_length());
		assert(this->len <= this->max_length());
	}

	template <typename Func>
	static void for_each_possible_cmd(Func const &func, Span const &emitted_bytes) {
		for (size_t data_len = 1; data_len <= emitted_bytes.len && data_len <= 256; ++data_len) {
			// If the upper nibble is no longer zero, stop.
			if ((emitted_bytes[-data_len] & 0xf0) != 0) {
				break;
			}
			// Since this command's cost increases monotonically, if the cost is higher than the
			// current best sum, any further attempts are guaranteed to fail.
			if (!func(LzSpecialPacklo0(data_len))) {
				break;
			}
		}
	}

	/**
	 * This command is followed by a stream of “big-endian” nibbles that get zero-padded then
	 * output; if there is an odd number of nibbles, the last byte's low nibble is ignored.
	 */
	void serialize(uint8_t const *bytes, FILE *file, bool textual,
	               char const *filename) const override {
		assert(
			std::all_of(bytes, bytes + this->len, [](uint8_t byte) { return (byte & 0xf0) == 0; }));

		if (textual) {
			fputs("\tlzpacklo ", file);
			print_byte_list(file, bytes, this->len);
			xputc('\n', file, filename);
		} else {
			this->serialize_special_header(file, LZ_SPECIAL_PACKLO0, filename);

			Span remaining{bytes, this->len};
			while (remaining.len >= 2) {
				uint8_t first = remaining.start[0], second = remaining.start[1];
				assert((first & 0xf0) == 0);
				assert((second & 0xf0) == 0);
				xputc(first << 4 | second, file, filename);

				remaining.resize_left(-2);
			}
			if (remaining.len > 0) {
				assert(remaining.len == 1);
				assert((remaining.start[0] & 0xf0) == 0);
				xputc(remaining.start[0] << 4, file, filename);
			}
		}
	}
	void decompress(std::vector<uint8_t> &dest, uint8_t const *payload) const override {
		this->decompress_special_cmd(dest, payload, [](uint8_t byte) { return byte; });
	}
};

using Command =
	std::variant<LzData, LzRepeat, LzAlternate, LzZero, LzCopyNormal, LzCopyFlipped, LzCopyReversed,
	             LzSpecialPackhi0, LzSpecialPack16Short, LzSpecialPacklo0>;

/// Extract a `LzCmd` pointer out of a `Command`, for common dynamic dispatch.
LzCmd const &lz_cmd(Command const &cmd) {
	return std::visit([](LzCmd const &inner_base) -> LzCmd const & { return inner_base; }, cmd);
}

static std::forward_list<Command> compress(std::vector<uint8_t> const &uncompressed) {
	// The strategy behind a “dynamic programming” LZ compressor stems from an interesting property:
	// the optimal command stream for the first N bytes is composed of one command, plus the optimal
	// stream for all bytes prior to this command.
	//
	// So, for each *end* position, consider each command that could end exactly at this position,
	// and consider the total cost to be
	// `optimal cost of ending at that command's start + cost of that command`.
	// Assuming that no command generates nothing (which, intuitively, we don't want), then that
	// optimal cost references an earlier end position, which will have been computed by a previous
	// iteration of the loop, induction-style!
	//
	// Once this is computed for every end position, take the optimal command that ends at the end
	// of the uncompressed data, “rewind” by however many bytes it covers, and repeat until you
	// reach the beginning of the data!
	//
	// Of course, it's possible to implement the above strategy in less naive and more efficient
	// ways (mostly about more efficiently considering commands), but this remains the underlying
	// principle.

	// Each index corresponds to the best command that ends at this offset, and its associated cost.
	// The first entry is a dummy that encodes nothing but “seeds” all future iterations.
	std::vector<std::pair<size_t, Command>> best_cmds;
	best_cmds.reserve(uncompressed.size());

	Span data_emitted{uncompressed.data(), 0};
	while (best_cmds.size() < uncompressed.size()) {
		++data_emitted.len;

		size_t end_ofs = best_cmds.size() + 1;
		uint8_t last_byte = uncompressed[best_cmds.size()];

		// Begin with a dummy command that will be overwritten.
		auto &best = best_cmds.emplace_back(SIZE_MAX, LzData(1));
		assert(data_emitted.len == best_cmds.size());
		// Returns whether the considered command has a chance to pass *at all*;
		// this is useful for commands whose cost increases monotonically,
		// so that iteration can stop earlier.
		auto consider = [&best, &best_cmds, &end_ofs](auto const &candidate) {
			size_t this_cost = candidate.num_encoded_bytes();
			size_t start_ofs = end_ofs - candidate.len;
			size_t total_cost = this_cost + (start_ofs == 0 ? 0 : best_cmds[start_ofs - 1].first);
			// If this is a strict improvement, retain it.
			if (total_cost < best.first) {
				best = {total_cost, candidate};
				return true;
			} else {
				return this_cost < best.first;
			}
		};

		// Consider either repeating command, since `LzZero` is a better version of `LzRepeat`.
		if (last_byte == 0) {
			LzZero::for_each_possible_cmd(consider, data_emitted);
		} else {
			LzRepeat::for_each_possible_cmd(consider, data_emitted);
		}

		LzAlternate::for_each_possible_cmd(consider, data_emitted);

		LzSpecialPackhi0::for_each_possible_cmd(consider, data_emitted);
		LzSpecialPack16Short::for_each_possible_cmd(consider, data_emitted);
		LzSpecialPacklo0::for_each_possible_cmd(consider, data_emitted);

		LzCopyCmd::for_each_possible_cmd(consider, data_emitted);

		// Consider `LzData` last, since its cost increases quickly, and thus the iteration may be
		// stopped very early if any of the previous commands succeeded at finding a more optimal
		// solution (and faster, too).
		LzData::for_each_possible_cmd(consider, data_emitted);
	}

	// Done! Now, we can walk the list of optimal commands backwards...
	// Think of this as a Dijkstra, and you won't be far.
	std::forward_list<Command> final;
	for (size_t end_ofs = uncompressed.size(); end_ofs != 0;) {
		Command &&cmd = std::move(best_cmds[end_ofs - 1].second);
		end_ofs -= lz_cmd(cmd).len; // Rewind by however many bytes that command covered.
		final.emplace_after(final.before_begin(), std::move(cmd));
	}
	return final;
}
// Must decompress to a buffer, so that back-refs (`LzCopy`-derived commands) can access previous
// output.
static std::vector<uint8_t>
decompress(std::vector<std::pair<Command, uint8_t const *>> const &commands) {
	std::vector<uint8_t> data;
	for (auto const &[cmd, payload] : commands) {
		lz_cmd(cmd).decompress(data, payload);
	}
	return data;
}

static void serialize(std::forward_list<Command> const &cmds,
                      std::vector<uint8_t> const &uncompressed, FILE *output, bool textual_output,
                      char const *filename) {
	uint8_t const *bytes = uncompressed.data();
	for (Command const &cmd : cmds) {
		LzCmd const &inner_base = lz_cmd(cmd);
		assert(inner_base.len >= inner_base.min_length());
		assert(inner_base.len <= inner_base.max_length());
		if (0) { // To print costs at the start of each line:
			fprintf(output, "/* %2zu */", inner_base.num_encoded_bytes());
		}
		inner_base.serialize(bytes, output, textual_output, filename);

		bytes += inner_base.len;
	}

	assert(size_t(bytes - uncompressed.data()) == uncompressed.size());
	if (textual_output) {
		fputs("\tlzend\n", output);
	} else {
		xputc(LZ_END, output, filename);
	}
}
static void serialize(std::vector<std::pair<Command, uint8_t const *>> const &cmds,
                      std::vector<uint8_t> const &uncompressed, FILE *output, bool textual_output,
                      char const *filename) {
	uint8_t const *bytes = uncompressed.data();
	for (auto const &[cmd, payload] : cmds) {
		LzCmd const &inner_base = lz_cmd(cmd);
		assert(inner_base.len >= inner_base.min_length());
		assert(inner_base.len <= inner_base.max_length());
		if (0) { // To print costs at the start of each line:
			fprintf(output, "/* %2zu */", inner_base.num_encoded_bytes());
		}
		inner_base.serialize(bytes, output, textual_output, filename);

		bytes += inner_base.len;
	}

	assert(size_t(bytes - uncompressed.data()) == uncompressed.size());
	if (textual_output) {
		fputs("\tlzend\n", output);
	} else {
		xputc(LZ_END, output, filename);
	}
}

static std::vector<std::pair<Command, uint8_t const *>>
deserialize(std::vector<uint8_t> const &compressed) {
	if (compressed.empty()) {
		error_exit(EXIT_DATA_ERR, "empty input\n");
	}

	std::vector<std::pair<Command, uint8_t const *>> commands;

	size_t byte_idx = 0;
	for (;;) {
		size_t cmd_start_idx = byte_idx;
		auto require_bytes = [&compressed, &byte_idx, &cmd_start_idx](size_t amount) {
			if (compressed.size() - byte_idx < amount) {
				error_exit(EXIT_DATA_ERR,
				           "corrupted input (encountered EOF while parsing command starting at "
				           "offset %zu)\n",
				           cmd_start_idx);
			}
			uint8_t const *start = &compressed[byte_idx];
			byte_idx += amount;
			return start;
		};

		uint8_t const &first_byte = require_bytes(1)[0];
		if (first_byte == LZ_END) {
			break;
		}
		uint8_t const *payload_start;
		Command cmd = [&payload_start, &first_byte, &compressed, &byte_idx,
		               &require_bytes]() -> Command {
			if ((first_byte & 0b111'111'00) == 0b111'111'00) { // Special commands.
				uint8_t len = require_bytes(1)[0] + LzSpecialCmd::MIN_LENGTH;
				payload_start = compressed.data() + byte_idx;
				require_bytes((len + 1) / 2); // Halved, rounding up.
				switch (first_byte) {
				case LZ_SPECIAL_PACKHI0:
					return LzSpecialPackhi0(len);
				case LZ_SPECIAL_PACK16SHORT:
					return LzSpecialPack16Short(len);
				case LZ_SPECIAL_PACKLO0:
					return LzSpecialPacklo0(len);
				}
				unreachable();
			} else {
				uint8_t cmd_id;
				uint16_t len;
				if ((first_byte & 0b111'00000) == 0b111'00000) {
					uint8_t extended_header = require_bytes(1)[0];
					cmd_id = (first_byte >> 2) & 0b111;
					len = (first_byte & 1) << 8 | extended_header;
				} else {
					cmd_id = first_byte >> 5;
					len = first_byte & 0b000'11111;
				}

				auto read_copy_start_ofs = [&require_bytes]() -> int16_t {
					uint8_t first_ofs_byte = require_bytes(1)[0];
					if ((first_ofs_byte & 0x80) != 0) {
						return 127 - first_ofs_byte;
					} else {
						uint8_t second_byte = require_bytes(1)[0];
						return first_ofs_byte << 8 | second_byte;
					}
				};

				payload_start = compressed.data() + byte_idx;
				switch (cmd_id) {
				case LZ_DATA:
					require_bytes(len + LzData::MIN_LENGTH);
					return LzData(len + LzData::MIN_LENGTH);
				case LZ_REPEAT:
					require_bytes(1);
					return LzRepeat(len + LzRepeat::MIN_LENGTH);
				case LZ_ALTERNATE:
					require_bytes(2);
					return LzAlternate(len + LzAlternate::MIN_LENGTH);
				case LZ_ZERO:
					return LzZero(len + LzZero::MIN_LENGTH);

				case LZ_COPY_NORMAL:
					return LzCopyNormal(len + LzCopyNormal::MIN_LENGTH, read_copy_start_ofs());
				case LZ_COPY_FLIPPED:
					return LzCopyFlipped(len + LzCopyFlipped::MIN_LENGTH, read_copy_start_ofs());
				case LZ_COPY_REVERSED:
					return LzCopyReversed(len + LzCopyReversed::MIN_LENGTH, read_copy_start_ofs());
				}
				unreachable();
			}
		}();
		assert(byte_idx - cmd_start_idx == lz_cmd(cmd).num_encoded_bytes());

		commands.emplace_back(std::move(cmd), payload_start);
	}

	if (byte_idx != compressed.size()) {
		error_exit(EXIT_DATA_ERR,
		           "corrupted input (end marker found after %zu bytes, but %zu remain)\n",
		           byte_idx - 1, compressed.size() - byte_idx);
	}

	return commands;
}

// CLI option parsing.

[[noreturn]] static void usage(int retcode, char const *program_name) {
	fprintf(stderr,
	        "Usage: %s [<options>] [<source file> [<output>]]\n"
	        "\n"
	        "Execution mode:\n"
	        "    -b, --binary      Output the command stream as binary data (default).\n"
	        "    -t, --text        Output the command stream as text.\n"
	        "    -u, --uncompress  Process a compressed file and output the original data.\n"
	        "    -d, --dump        Process a compressed file and dump the command stream as\n"
	        "                      text (as if compressing with the --text option).\n"
	        "    -h, --help        Print this help text and exit.\n"
	        "Compression options:\n"
	        "    -a<number>, --align <number>   Pad the compressed output with zeros until\n"
	        "                                   the size has the specified number of low bits\n"
	        "                                   cleared (default: 0).\n"
	        "The source and output filenames can be given as - (or omitted) to use standard\n"
	        "input and output. Use -- to indicate that subsequent arguments are file names.\n",
	        program_name);
	exit(retcode);
}

template <typename Val>
std::from_chars_result parse_num_arg(char const *arg, Val &value, Val limit) {
	std::from_chars_result result = std::from_chars(arg, &arg[strlen(arg)], value, 10);
	if (result.ec == std::errc{}) {
		if (*result.ptr != '\0') {
			result.ec = std::errc::invalid_argument;
		} else if (value > limit) {
			result.ec = std::errc::result_out_of_range;
		}
	}
	return result;
}

struct Options {
	char const *input;
	char const *output;
	enum { MODE_COMPRESS_BIN, MODE_COMPRESS_TEXT, MODE_DECOMPRESS, MODE_DUMP } mode;
	uint8_t alignment_nb_bits; // TODO: not hooked up to anything
	static constexpr uint8_t max_alignment = 12;

	/// Parse from CLI args.
	Options(int argc, char *argv[])
		: input(nullptr), output(nullptr), mode(MODE_COMPRESS_BIN), alignment_nb_bits(0) {
		char const *program_name = argv[0] ? argv[0] : "lzpcompress";
		bool accepting_options = true;
		for (size_t arg_idx = 1; arg_idx < size_t(argc); ++arg_idx) {
			char const *arg = argv[arg_idx];

			// Positional argument (just "-" is an arg, not an option).
			if (!accepting_options || arg[0] != '-' || arg[1] == '\0') {
				if (this->input == nullptr) {
					this->input = arg;
				} else if (this->output == nullptr) {
					this->output = arg;
				} else {
					error_exit(EXIT_BAD_USAGE, "too many positional arguments (use `--help`)\n");
				}

			} else if (arg[1] == '-') { // Long option.
				char const *name_start = &arg[2];
				char const *name_end = strchrnul(name_start, '='); // `--opt=arg`
				std::string_view name(name_start, name_end - name_start);

				char const *option_arg = *name_end == '=' ? &name_end[1] : nullptr;
				auto ensure_no_arg = [&option_arg, &name] {
					if (option_arg != nullptr) {
						error_exit(EXIT_BAD_USAGE, "--%.*s does not take an argument\n",
						           int(name.size()), name.data());
					}
				};
				auto require_arg = [&argv, &arg_idx, &name](char const *&opt_arg) {
					if (opt_arg == nullptr) {
						opt_arg = argv[++arg_idx]; // This is fine, since `argv` is NULL-terminated.
						if (opt_arg == nullptr) {
							error_exit(EXIT_BAD_USAGE, "missing argument to --%.*s\n",
							           int(name.size()), name.data());
						}
					}
				};

				if (arg[2] == '\0') {
					accepting_options = false;
				} else if (name == "help"sv) {
					usage(EXIT_SUCCESS, program_name);
				} else if (name == "binary"sv) {
					ensure_no_arg();
					this->mode = MODE_COMPRESS_BIN;
				} else if (name == "text"sv) {
					ensure_no_arg();
					this->mode = MODE_COMPRESS_TEXT;
				} else if (name == "uncompress"sv || name == "decompress"sv) {
					ensure_no_arg();
					this->mode = MODE_DECOMPRESS;
				} else if (name == "dump"sv) {
					ensure_no_arg();
					this->mode = MODE_DUMP;
				} else if (name == "align"sv) {
					require_arg(option_arg);
					std::from_chars_result result =
						parse_num_arg(option_arg, this->alignment_nb_bits, max_alignment);
					switch (result.ec) {
					case std::errc::invalid_argument:
						error_exit(EXIT_BAD_USAGE, "argument to --%.*s must be a number\n",
						           int(name.size()), name.data());
					case std::errc::result_out_of_range:
						error_exit(EXIT_BAD_USAGE,
						           "argument to --%.*s must be at most %" PRIu8 "\n",
						           int(name.size()), name.data(), max_alignment);
					default:
						// Checking for this in the `switch` triggers a warning that this value is
						// not in the enum. Ugh.
						if (result.ec != std::errc{}) {
							unreachable();
						}
					}
				} else {
					error_exit(EXIT_BAD_USAGE, "unknown option --%.*s\n", int(name.size()),
					           name.data());
				}

			} else { // Short option.
				// Since short options can be packed into a single arg, parse it char by char.
				// However, `-a10`, for example, is equivalent to `-a 10`!
				for (size_t i = 1; arg[i] != '\0'; ++i) {
					auto require_arg = [&arg, &i, &argv, &arg_idx] {
						if (arg[i + 1] != '\0') {
							return &arg[i + 1];
						} else if (char const *next_arg = argv[++arg_idx]; next_arg != nullptr) {
							return next_arg;
						} else {
							error_exit(EXIT_BAD_USAGE, "missing argument to -%c\n", arg[i]);
						}
					};

					switch (arg[i]) {
						char const *option_arg;
						std::from_chars_result result;

					case '?':
					case 'h':
						usage(EXIT_SUCCESS, program_name);

					case 'b':
						this->mode = MODE_COMPRESS_BIN;
						break;
					case 't':
						this->mode = MODE_COMPRESS_TEXT;
						break;
					case 'u':
						this->mode = MODE_DECOMPRESS;
						break;
					case 'd':
						this->mode = MODE_DUMP;
						break;
					case 'a':
						option_arg = require_arg();
						result = parse_num_arg(option_arg, this->alignment_nb_bits, max_alignment);
						switch (result.ec) {
						case std::errc::invalid_argument:
							error_exit(EXIT_BAD_USAGE, "argument to -%c must be a number\n",
							           arg[i]);
						case std::errc::result_out_of_range:
							error_exit(EXIT_BAD_USAGE,
							           "argument to -%c must be at most %" PRIu8 "\n", arg[i],
							           max_alignment);
						default:
							// Checking for this in the `switch` triggers a warning that this value
							// is not in the enum. Ugh.
							if (result.ec != std::errc{}) {
								unreachable();
							}
						}
						goto consumed_arg;

					default:
						error_exit(EXIT_BAD_USAGE, "unknown option -%c\n", arg[i]);
					}
				}
			consumed_arg:;
			}
		}
	}
};

// The entry point.

int main(int argc, char *argv[]) {
	Options options(argc, argv);
	auto [input_bytes, input_filename] = read_input(options.input);

	switch (options.mode) {
	case Options::MODE_COMPRESS_BIN:
	case Options::MODE_COMPRESS_TEXT: {
		std::forward_list<Command> commands = compress(input_bytes);

		bool textual_output = options.mode == Options::MODE_COMPRESS_TEXT;
		FILE *output = open_output_file(options.output, textual_output);
		serialize(commands, input_bytes, output, textual_output, options.input);
		close_output_file(output);
	} break;

	case Options::MODE_DECOMPRESS:
	case Options::MODE_DUMP: {
		std::vector<std::pair<Command, uint8_t const *>> commands = deserialize(input_bytes);
		std::vector<uint8_t> decompressed = decompress(commands);

		FILE *output = open_output_file(options.output, true);
		if (options.mode == Options::MODE_DECOMPRESS) {
			xfwrite(decompressed.data(), decompressed.size(), output, options.output);
		} else {
			serialize(commands, decompressed, output, true, options.input);
		}
		close_output_file(output);
	} break;
	}

	return EXIT_SUCCESS;
}
