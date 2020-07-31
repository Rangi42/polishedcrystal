.PHONY: all clean

CC := gcc
CFLAGS = -O3 -std=c11 -Wall -Wextra -pedantic

tools := \
	lzcomp \
	png_dimensions \
	scan_includes \
	pokemon_animation \
	pokemon_animation_graphics \
	gfx \
	bankends

all: $(tools)
	@:

clean:
	rm -f $(tools) *.o *.h.gch *.pyc

lzcomp: CFLAGS += -flto -Wno-strict-overflow -Wno-sign-compare
lzcomp: $(wildcard lz/*.c) $(wildcard lz/*.h)
	$(CC) $(CFLAGS) -o $@ lz/*.c

bankends: bankends.c parsemap.o
	$(CC) $(CFLAGS) -o $@ $^

parsemap.o: parsemap.c parsemap.h
	$(CC) $(CFLAGS) -c $^

%: %.c
	$(CC) $(CFLAGS) -o $@ $<
