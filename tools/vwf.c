#define PROGRAM_NAME "vwf"
#define USAGE_OPTS "[-h|--help] [-o|--output vwf.vwf.1bpp] [-w|--widths vwf.vwf.widths] vwf.2bpp"

#include "common.h"

struct Options {
	const char *out_filename;
	const char *widths_filename;
};

void parse_args(int argc, char *argv[], struct Options *options) {
	struct option long_options[] = {
		{"output", required_argument, 0, 'o'},
		{"widths", required_argument, 0, 'w'},
		{"help", no_argument, 0, 'h'},
		{0}
	};
	for (int opt; (opt = getopt_long(argc, argv, "o:w:h", long_options)) != -1;) {
		switch (opt) {
		case 'o':
			options->out_filename = optarg;
			break;
		case 'w':
			options->widths_filename = optarg;
			break;
		case 'h':
			usage_exit(0);
			break;
		default:
			usage_exit(1);
		}
	}
}

#define TILE_SIZE 16

uint8_t *read_tiles(const char *filename, long *tiles_size) {
	uint8_t *tiles = read_u8(filename, tiles_size);
	if (!*tiles_size) {
		error_exit("%s: empty file\n", filename);
	} else if (*tiles_size % TILE_SIZE) {
		error_exit("%s: not divisible into 8x8-px 2bpp tiles\n", filename);
	}
	for (int i = 0; i < *tiles_size; i += TILE_SIZE) {
		uint8_t mask = tiles[i] ^ tiles[i + 1]; // Detect gray pixels
		for (int j = 2; j < TILE_SIZE; j += 2) {
			uint8_t next = tiles[i + j] ^ tiles[i + j + 1];
			if (next != mask) {
				error_exit("%s: tile #%d has inconsistent VWF width\n", filename, i / TILE_SIZE);
			}
		}
	}
	return tiles;
}

void write_graphics(const char *filename, const uint8_t *tiles, long tiles_size) {
	long data_size = tiles_size / 2; // 1bpp is half the size of 2bpp
	uint8_t *data = xmalloc(data_size);
	for (int i = 0; i < tiles_size; i += 2) {
		data[i / 2] = tiles[i] & tiles[i + 1]; // Turn gray pixels into white
	}
	write_u8(filename, data, data_size);
	free(data);
}

void write_widths(const char *filename, const uint8_t *tiles, long tiles_size) {
	long data_size = tiles_size / TILE_SIZE;
	uint8_t *data = xmalloc(data_size);
	for (int i = 0; i < tiles_size; i += TILE_SIZE) {
		int width = 8;
		uint8_t mask = tiles[i] ^ tiles[i + 1]; // Detect gray pixels
		if (mask) {
			for (width = 0; mask < 0x80; mask <<= 1, width++); // Count leading zeros
		}
		data[i / TILE_SIZE] = width;
	}
	write_u8(filename, data, data_size);
	free(data);
}

int main(int argc, char *argv[]) {
	struct Options options = {0};
	parse_args(argc, argv, &options);

	argc -= optind;
	argv += optind;
	if (argc < 1) {
		usage_exit(1);
	}

	long tiles_size;
	uint8_t *tiles = read_tiles(argv[0], &tiles_size);

	if (options.out_filename) {
		write_graphics(options.out_filename, tiles, tiles_size);
	}
	if (options.widths_filename) {
		write_widths(options.widths_filename, tiles, tiles_size);
	}

	free(tiles);
	return 0;
}
