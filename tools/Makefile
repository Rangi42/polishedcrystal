.PHONY: all clean

CC := gcc
CFLAGS = -O3 -std=c11 -Wall -Wextra -pedantic

tools := lzcomp scan_includes bankends

all: $(tools)
	@:

clean:
	rm -f $(tools) *.o

lzcomp: CFLAGS += -flto -Wno-strict-overflow -Wno-sign-compare
lzcomp: $(wildcard lz/*.c) $(wildcard lz/*.h)
	$(CC) $(CFLAGS) -o $@ lz/*.c

scan_includes: scan_includes.c
	$(CC) $(CFLAGS) -o $@ $<

bankends: bankends.c parsemap.o
	$(CC) $(CFLAGS) -o $@ $^

parsemap.o: parsemap.c parsemap.h
	$(CC) $(CFLAGS) -c $^
