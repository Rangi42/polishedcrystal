.PHONY: all clean

CC := gcc
CFLAGS = -O3 -std=c17 -Wall -Wextra -pedantic \
         -Walloc-zero \
         -Wcast-align \
         -Wcast-qual \
         -Wduplicated-branches \
         -Wduplicated-cond \
         -Wfloat-equal \
         -Wformat=2 \
         -Wformat-overflow=2 \
         -Wformat-truncation=1 \
         -Winline \
         -Wlogical-op \
         -Wnested-externs \
         -Wno-sign-compare \
         -Wnull-dereference \
         -Wold-style-definition \
         -Wshadow \
         -Wshift-overflow=2 \
         -Wstrict-overflow=2 \
         -Wstrict-prototypes \
         -Wstringop-overflow=4 \
         -Wundef \
         -Wuninitialized \
         -Wunused \
         -Wwrite-strings

tools := \
	lzcomp \
	png_dimensions \
	scan_includes \
	pokemon_animation \
	pokemon_animation_graphics \
	gfx \
	bankends \
	bspcomp

all: $(tools)
	@:

clean:
	rm -f $(tools) *.o *.h.gch *.pyc

gfx: common.h
png_dimensions: common.h
pokemon_animation: common.h
pokemon_animation_graphics: common.h
scan_includes: common.h

lzcomp: CFLAGS += -flto
lzcomp: $(wildcard lz/*.c) $(wildcard lz/*.h)
	$(CC) $(CFLAGS) -o $@ lz/*.c

bspcomp: bsp/bspcomp.c
	$(CC) $(CFLAGS) -o $@ $^

bankends: bankends.c parsemap.o
	$(CC) $(CFLAGS) -o $@ $^

parsemap.o: parsemap.c parsemap.h
	$(CC) $(CFLAGS) -c $^

%: %.c
	$(CC) $(CFLAGS) -o $@ $<
