#define PROGRAM_NAME "fine_print"
#define USAGE_OPTS "[-h|--help] [-c|--colors map=012] [-e|--center tiles] [-n|--indent px=0] [-s|--spacing px=1] text out.2bpp"

#include "common.h"

struct Options {
	int colors[3];
	size_t center;
	size_t indent;
	size_t spacing;
};

void parse_args(int argc, char *argv[], struct Options *options) {
	struct option long_options[] = {
		{"colors", required_argument, 0, 'c'},
		{"center", required_argument, 0, 'e'},
		{"indent", required_argument, 0, 'n'},
		{"spacing", required_argument, 0, 's'},
		{"help", no_argument, 0, 'h'},
		{0}
	};
	for (int opt; (opt = getopt_long(argc, argv, "c:e:n:s:h", long_options)) != -1;) {
		switch (opt) {
		case 'c':
			if (strlen(optarg) != 3) {
				error_exit("color mapping '%s' must specify three colors (bg, shading, text)\n", optarg);
			}
			for (size_t i = 0; i < 3; i++) {
				if (optarg[i] < '0' || optarg[i] > '3') {
					error_exit("color '%c' must be 0 (white), 1 (light), 2 (dark), or 3 (black)\n", optarg[i]);
				}
				options->colors[i] = optarg[i] - '0';
			}
			break;
		case 'e':
			options->center = strtoul(optarg, NULL, 0);
			break;
		case 'n':
			options->indent = strtoul(optarg, NULL, 0);
			break;
		case 's':
			options->spacing = strtoul(optarg, NULL, 0);
			break;
		case 'h':
			usage_exit(0);
			break;
		default:
			usage_exit(1);
		}
	}
}

#define HEIGHT 8 // pixels

#define BG_PIXEL ' '
#define SHADING_PIXEL '.'
#define TEXT_PIXEL  '#'

const char *ASCII[95][HEIGHT] = {
	// ' '
	{
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
	},
	// '!'
	{
		"  ",
		"##",
		"##",
		"##",
		"  ",
		"##",
		"  ",
		"  ",
	},
	// '"'
	{
		"   ",
		"# #",
		"# #",
		"   ",
		"   ",
		"   ",
		"   ",
		"   ",
	},
	// '#'
	{
		"     ",
		" # # ",
		"#####",
		" # # ",
		"#####",
		" # # ",
		"     ",
		"     ",
	},
	// '$'
	{
		" ## ",
		".###",
		"##  ",
		"####",
		"  ##",
		"###.",
		" ## ",
		"    ",
	},
	// '%'
	{
		"      ",
		"##  ##",
		"## ## ",
		"  ##  ",
		" ## ##",
		"##  ##",
		"      ",
		"      ",
	},
	// '&'
	{
		"      ",
		".###. ",
		"## ## ",
		" ###.#",
		"## ## ",
		".###.#",
		"      ",
		"      ",
	},
	// "'"
	{
		"  ",
		"##",
		" #",
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
	},
	// '('
	{
		" ##",
		".# ",
		"## ",
		"## ",
		"## ",
		".# ",
		" ##",
		"   ",
	},
	// ')'
	{
		"## ",
		" #.",
		" ##",
		" ##",
		" ##",
		" #.",
		"## ",
		"   ",
	},
	// '*'
	{
		"   ",
		"   ",
		"# #",
		" # ",
		"# #",
		"   ",
		"   ",
		"   ",
	},
	// '+'
	{
		"   ",
		"   ",
		" # ",
		"###",
		" # ",
		"   ",
		"   ",
		"   ",
	},
	// ','
	{
		"  ",
		"  ",
		"  ",
		"  ",
		"##",
		"##",
		" #",
		"  ",
	},
	// '-'
	{
		"  ",
		"  ",
		"  ",
		"##",
		"  ",
		"  ",
		"  ",
		"  ",
	},
	// '.'
	{
		"  ",
		"  ",
		"  ",
		"  ",
		"##",
		"##",
		"  ",
		"  ",
	},
	// '/'
	{
		"  #",
		" .#",
		" ##",
		".#.",
		"## ",
		"#. ",
		"#  ",
		"   ",
	},
	// '0'
	{
		"     ",
		".###.",
		"## ##",
		"## ##",
		"## ##",
		".###.",
		"     ",
		"     ",
	},
	// '1'
	{
		"   ",
		"###",
		" ##",
		" ##",
		" ##",
		" ##",
		"   ",
		"   ",
	},
	// '2'
	{
		"     ",
		"####.",
		"   ##",
		".####",
		"##   ",
		"#####",
		"     ",
		"     ",
	},
	// '3'
	{
		"     ",
		".###.",
		"   ##",
		" ###.",
		"   ##",
		".###.",
		"     ",
		"     ",
	},
	// '4'
	{
		"     ",
		"## ##",
		"## ##",
		"#####",
		"   ##",
		"   ##",
		"     ",
		"     ",
	},
	// '5'
	{
		"     ",
		"####.",
		"##   ",
		"#####",
		"   ##",
		".###.",
		"     ",
		"     ",
	},
	// '6'
	{
		"     ",
		" ###.",
		"##   ",
		"#####",
		"## ##",
		".###.",
		"     ",
		"     ",
	},
	// '7'
	{
		"    ",
		"####",
		"  ##",
		" ##.",
		" ## ",
		" ## ",
		"    ",
		"    ",
	},
	// '8'
	{
		"     ",
		".###.",
		"## ##",
		" ### ",
		"## ##",
		".###.",
		"     ",
		"     ",
	},
	// '9'
	{
		"     ",
		".###.",
		"## ##",
		"#####",
		"   ##",
		".###.",
		"     ",
		"     ",
	},
	// ':'
	{
		"  ",
		"##",
		"##",
		"  ",
		"##",
		"##",
		"  ",
		"  ",
	},
	// ';'
	{
		"  ",
		"##",
		"##",
		"  ",
		"##",
		"##",
		" #",
		"  ",
	},
	// '<'
	{
		"   ",
		"  #",
		" ##",
		"## ",
		" ##",
		"  #",
		"   ",
		"   ",
	},
	// '='
	{
		"   ",
		"   ",
		"###",
		"   ",
		"###",
		"   ",
		"   ",
		"   ",
	},
	// '>'
	{
		"   ",
		"#  ",
		"## ",
		" ##",
		"## ",
		"#  ",
		"   ",
		"   ",
	},
	// '?'
	{
		"    ",
		"###.",
		"  ##",
		" ##.",
		"    ",
		" ## ",
		"    ",
		"    ",
	},
	// '@' (copyright symbol)
	{
		" .###. ",
		".#   #.",
		"# .## #",
		"# #   #",
		"# .## #",
		".#   #.",
		" .###. ",
		"       ",
	},
	// 'A'
	{
		"     ",
		".###.",
		"## ##",
		"#####",
		"## ##",
		"## ##",
		"     ",
		"     ",
	},
	// 'B'
	{
		"     ",
		"####.",
		"## ##",
		"####.",
		"## ##",
		"####.",
		"     ",
		"     ",
	},
	// 'C'
	{
		"     ",
		".####",
		"##   ",
		"##   ",
		"##   ",
		".####",
		"     ",
		"     ",
	},
	// 'D'
	{
		"     ",
		"####.",
		"## ##",
		"## ##",
		"## ##",
		"####.",
		"     ",
		"     ",
	},
	// 'E'
	{
		"    ",
		"####",
		"##  ",
		"####",
		"##  ",
		"####",
		"    ",
		"    ",
	},
	// 'F'
	{
		"    ",
		"####",
		"##  ",
		"####",
		"##  ",
		"##  ",
		"    ",
		"    ",
	},
	// 'G'
	{
		"     ",
		".####",
		"##   ",
		"## ##",
		"## ##",
		".####",
		"     ",
		"     ",
	},
	// 'H'
	{
		"     ",
		"## ##",
		"## ##",
		"#####",
		"## ##",
		"## ##",
		"     ",
		"     ",
	},
	// 'I'
	{
		"    ",
		"####",
		" ## ",
		" ## ",
		" ## ",
		"####",
		"    ",
		"    ",
	},
	// 'J'
	{
		"     ",
		" ####",
		"  ## ",
		"  ## ",
		"# ## ",
		".##. ",
		"     ",
		"     ",
	},
	// 'K'
	{
		"     ",
		"## ##",
		"#### ",
		"###. ",
		"## ##",
		"## ##",
		"     ",
		"     ",
	},
	// 'L'
	{
		"    ",
		"##  ",
		"##  ",
		"##  ",
		"##  ",
		"####",
		"    ",
		"    ",
	},
	// 'M'
	{
		"       ",
		"#     #",
		"##   ##",
		"###.###",
		"## # ##",
		"##   ##",
		"       ",
		"       ",
	},
	// 'N'
	{
		"      ",
		"##  ##",
		"### ##",
		"##.###",
		"## ###",
		"##  ##",
		"      ",
		"      ",
	},
	// 'O'
	{
		"     ",
		".###.",
		"## ##",
		"## ##",
		"## ##",
		".###.",
		"     ",
		"     ",
	},
	// 'P'
	{
		"     ",
		"#####",
		"## ##",
		"####.",
		"##   ",
		"##   ",
		"     ",
		"     ",
	},
	// 'Q'
	{
		"      ",
		".###. ",
		"## ## ",
		"## ##.",
		"## ###",
		".###.#",
		"      ",
		"      ",
	},
	// 'R'
	{
		"     ",
		"####.",
		"## ##",
		"####.",
		"## ##",
		"## ##",
		"     ",
		"     ",
	},
	// 'S'
	{
		"     ",
		".####",
		"##   ",
		".###.",
		"   ##",
		"####.",
		"     ",
		"     ",
	},
	// 'T'
	{
		"    ",
		"####",
		" ## ",
		" ## ",
		" ## ",
		" ## ",
		"    ",
		"    ",
	},
	// 'U'
	{
		"     ",
		"## ##",
		"## ##",
		"## ##",
		"## ##",
		".###.",
		"     ",
		"     ",
	},
	// 'V'
	{
		"     ",
		"## ##",
		"## ##",
		"## ##",
		".### ",
		" ### ",
		"     ",
		"     ",
	},
	// 'W'
	{
		"       ",
		"##   ##",
		"##   ##",
		"## # ##",
		"#######",
		".## ##.",
		"       ",
		"       ",
	},
	// 'X'
	{
		"     ",
		"## ##",
		"##.##",
		" ### ",
		"##.##",
		"## ##",
		"     ",
		"     ",
	},
	// 'Y'
	{
		"      ",
		"##  ##",
		"##  ##",
		".####.",
		"  ##  ",
		"  ##  ",
		"      ",
		"      ",
	},
	// 'Z'
	{
		"     ",
		"#####",
		"  ##.",
		" ##. ",
		"##.  ",
		"#####",
		"     ",
		"     ",
	},
	// '['
	{
		"   ",
		"###",
		"## ",
		"## ",
		"## ",
		"###",
		"   ",
		"   ",
	},
	// '\\'
	{
		"#  ",
		"#. ",
		"## ",
		".#.",
		" ##",
		" .#",
		"  #",
		"   ",
	},
	// ']'
	{
		"   ",
		"###",
		" ##",
		" ##",
		" ##",
		"###",
		"   ",
		"   ",
	},
	// '^'
	{
		"   ",
		" # ",
		"# #",
		"   ",
		"   ",
		"   ",
		"   ",
		"   ",
	},
	// '_'
	{
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
		"##",
		"  ",
		"  ",
	},
	// '`'
	{
		"  ",
		"# ",
		"##",
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
	},
	// 'a'
	{
		"      ",
		"      ",
		" #### ",
		"## ## ",
		"## ## ",
		" #####",
		"      ",
		"      ",
	},
	// 'b'
	{
		"     ",
		"##   ",
		"#### ",
		"## ##",
		"## ##",
		"#### ",
		"     ",
		"     ",
	},
	// 'c'
	{
		"    ",
		"    ",
		".###",
		"##  ",
		"##  ",
		".###",
		"    ",
		"    ",
	},
	// 'd'
	{
		"     ",
		"   ##",
		" ####",
		"## ##",
		"## ##",
		" ####",
		"     ",
		"     ",
	},
	// 'e'
	{
		"    ",
		"    ",
		" ###",
		"## #",
		"### ",
		".###",
		"    ",
		"    ",
	},
	// 'f'
	{
		"    ",
		" .##",
		" ## ",
		"####",
		" ## ",
		" ## ",
		"    ",
		"    ",
	},
	// 'g'
	{
		"     ",
		"     ",
		".####",
		"## ##",
		".####",
		"   ##",
		".###.",
		"     ",
	},
	// 'h'
	{
		"     ",
		"##   ",
		"#### ",
		"## ##",
		"## ##",
		"## ##",
		"     ",
		"     ",
	},
	// 'i'
	{
		"  ",
		"##",
		"  ",
		"##",
		"##",
		"##",
		"  ",
		"  ",
	},
	// 'j'
	{
		"   ",
		" ##",
		"   ",
		" ##",
		" ##",
		" ##",
		"##.",
		"   ",
	},
	// 'k'
	{
		"    ",
		"##  ",
		"## #",
		"### ",
		"### ",
		"## #",
		"    ",
		"    ",
	},
	// 'l'
	{
		"  ",
		"##",
		"##",
		"##",
		"##",
		"##",
		"  ",
		"  ",
	},
	// 'm'
	{
		"      ",
		"      ",
		"#####.",
		"## # #",
		"## # #",
		"## # #",
		"      ",
		"      ",
	},
	// 'n'
	{
		"     ",
		"     ",
		"#### ",
		"## ##",
		"## ##",
		"## ##",
		"     ",
		"     ",
	},
	// 'o'
	{
		"     ",
		"     ",
		".###.",
		"## ##",
		"## ##",
		".###.",
		"     ",
		"     ",
	},
	// 'p'
	{
		"     ",
		"     ",
		"####.",
		"## ##",
		"####.",
		"##   ",
		"##   ",
		"     ",
	},
	// 'q'
	{
		"     ",
		"     ",
		".####",
		"## ##",
		".####",
		"   ##",
		"   ##",
		"     ",
	},
	// 'r'
	{
		"    ",
		"    ",
		"###.",
		"##  ",
		"##  ",
		"##  ",
		"    ",
		"    ",
	},
	// 's'
	{
		"     ",
		"     ",
		".####",
		"###  ",
		"  ###",
		"####.",
		"     ",
		"     ",
	},
	// 't'
	{
		"    ",
		" ## ",
		"####",
		" ## ",
		" ## ",
		" ## ",
		"    ",
		"    ",
	},
	// 'u'
	{
		"     ",
		"     ",
		"## ##",
		"## ##",
		"## ##",
		".####",
		"     ",
		"     ",
	},
	// 'v'
	{
		"     ",
		"     ",
		"## ##",
		"## ##",
		".###.",
		" ### ",
		"     ",
		"     ",
	},
	// 'w'
	{
		"     ",
		"     ",
		"## ##",
		"## ##",
		"#####",
		"##.##",
		"     ",
		"     ",
	},
	// 'x'
	{
		"     ",
		"     ",
		"## ##",
		" ### ",
		" ### ",
		"## ##",
		"     ",
		"     ",
	},
	// 'y'
	{
		"     ",
		"     ",
		"## ##",
		".#.##",
		"  ## ",
		" ### ",
		" ##  ",
		"     ",
	},
	// 'z'
	{
		"     ",
		"     ",
		"#####",
		"  ## ",
		" ##  ",
		"#####",
		"     ",
		"     ",
	},
	// '{'
	{
		"  ##",
		" .# ",
		" ## ",
		"##. ",
		" ## ",
		" .# ",
		"  ##",
		"    ",
	},
	// '|'
	{
		"#",
		"#",
		"#",
		"#",
		"#",
		"#",
		"#",
		" ",
	},
	// '}'
	{
		"##  ",
		" #. ",
		" ## ",
		" .##",
		" ## ",
		" #. ",
		"##  ",
		"    ",
	},
	// '~'
	{
		"    ",
		" # #",
		"# # ",
		"    ",
		"    ",
		"    ",
		"    ",
		"    ",
	},
};

void sanity_check(void) {
	for (size_t a = 0; a < COUNTOF(ASCII); a++) {
		size_t n = strlen(ASCII[a][0]);
		char c = ' ' + a;
		for (size_t i = 1; i < HEIGHT; i++) {
			if (strlen(ASCII[a][i]) != n) {
				error_exit("ASCII glyph '%c' row %zu is not %zu pixels\n", c, i + 1, n);
			}
			for (size_t j = 0; j < n; j++) {
				char p = ASCII[a][i][j];
				if (p != BG_PIXEL && p != SHADING_PIXEL && p != TEXT_PIXEL) {
					error_exit("ASCII glyph '%c' row %zu has invalid pixel '%c'\n", c, i + 1, p);
				}
			}
		}
	}
}

struct Canvas {
	size_t capacity;
	size_t width;
	char *pixels[HEIGHT]; // each member must have `width` chars
};

void ensure_capacity(struct Canvas *canvas, size_t append_width) {
	if (canvas->width + append_width > canvas->capacity) {
		canvas->capacity = canvas->capacity * 2 + append_width;
		for (size_t i = 0; i < HEIGHT; i++) {
			canvas->pixels[i] = xrealloc(canvas->pixels[i], canvas->capacity);
		}
	}
}

void append_padding(struct Canvas *canvas, size_t padding) {
	ensure_capacity(canvas, padding);
	for (size_t i = 0; i < HEIGHT; i++) {
		for (size_t j = 0; j < padding; j++) {
			canvas->pixels[i][canvas->width + j] = BG_PIXEL;
		}
	}
	canvas->width += padding;
}

void append_char(struct Canvas *canvas, char c) {
	if ((unsigned char)c < ' ' || (unsigned char)c >= ' ' + COUNTOF(ASCII)) {
		error_exit("invalid character '\\x%02x'\n", c);
	}
	size_t a = c - ' ';
	size_t n = strlen(ASCII[a][0]);
	if (n == 0) {
		error_exit("unimplemented character '%c'\n", c);
	}
	ensure_capacity(canvas, n);
	for (size_t i = 0; i < HEIGHT; i++) {
		for (size_t j = 0; j < n; j++) {
			canvas->pixels[i][canvas->width + j] = ASCII[a][i][j];
		}
	}
	canvas->width += n;
}

void append_string(struct Canvas *canvas, const char *s, size_t spacing) {
	for (const char *ptr = s; *ptr != '\r' && *ptr != '\n' && *ptr != '\0'; ptr++) {
		if (canvas->width > 0) {
			append_padding(canvas, spacing);
		}
		append_char(canvas, *ptr);
	}
}

void output_2bpp(const struct Canvas *canvas, const char *filename, int colors[static 3], size_t center) {
	size_t num_tiles = (canvas->width + 7) / 8;
	if (center) {
		if (num_tiles > center) {
			error_exit("cannot center in %zu tiles, requires %zu\n", center, num_tiles);
		}
		num_tiles = center;
	}
	FILE *f = xfopen(filename, 'w');
	size_t start_x = center ? (center * 8 - canvas->width) / 2 : 0;
	for (size_t t = 0; t < num_tiles; t++) {
		for (size_t i = 0; i < HEIGHT; i++) {
			int bp0 = 0, bp1 = 0;
			for (size_t j = 0; j < 8; j++) {
				size_t x = t * 8 + j;
				char p = x >= start_x && x < start_x + canvas->width ? canvas->pixels[i][x - start_x] : BG_PIXEL;
				int v = colors[p == BG_PIXEL ? 0 : p == SHADING_PIXEL ? 1 : 2];
				bp0 = (bp0 << 1) | !!(v & 1);
				bp1 = (bp1 << 1) | !!(v & 2);
			}
			putc((unsigned char)bp0, f);
			putc((unsigned char)bp1, f);
		}
	}
	fclose(f);
}

int main(int argc, char *argv[]) {
	sanity_check();

	struct Options options = {
		.colors = {0, 1, 2}, // white bg, light shading, dark text
		.indent = 0,
		.spacing = 1,
	};
	parse_args(argc, argv, &options);

	argc -= optind;
	argv += optind;
	if (argc != 2) {
		usage_exit(1);
	}

	struct Canvas output = {0};
	append_padding(&output, options.indent);
	append_string(&output, argv[0], options.spacing);
	output_2bpp(&output, argv[1], options.colors, options.center);

	return 0;
}
