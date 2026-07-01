#include <math.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * WAV to DED ("densely-encoded DPCM") converter.
 *
 * PCM WAV samples are read as input. After dithering and quantization, we get a sequence of 4-bit samples.
 * The differences between each pair of consecutive samples ("deltas") are encoded with a per-file Huffman code.
 *
 * The DED output consists of four parts:
 * - the Huffman tree (encoded as a "bytecode" that is easy and fast to "compile" into RAM)
 * - a 0xFF byte separator
 * - a 2-byte little-endian integer denoting the length of the SFX in 32-sample blocks (the wave RAM holds 32 4-bit samples)
 * - the Huffman-encoded delta values
 */

#define DED_RATE 10485.76 // frequency
#define DED_VOLUME 3.2 // amplitude
#define RESAMPLING_THRESHOLD 0.05 // input frequencies more different than this threshold are resampled to DED_RATE

#define NUM_DELTAS (1 << 4) // this many possible delta values, in [0, NUM_DELTAS)
#define WAVE_RAM_SIZE (16 * 2) // how many 4-bit samples can fit in wave pattern RAM [$FF30, $FF3F]

#define CHUNKID(a, b, c, d) (uint32_t)((uint32_t)(a) | ((uint32_t)(b) << 8) | ((uint32_t)(c) << 16) | ((uint32_t)(d) << 24))

_Noreturn void error_exit(const char *fmt, ...) {
  fputs("error: ", stderr);
  va_list ap;
  va_start(ap, fmt);
  vfprintf(stderr, fmt, ap);
  va_end(ap);
  putc('\n', stderr);
  exit(1);
}

// uniform pseudorandom double in [0, 1) via xorshift* PRNG
double uniform_random(void) {
  static uint64_t state = 3490487757541254948UL; // seed
  state ^= state >> 12;
  state ^= state << 25;
  state ^= state >> 27;
  return (state * 0x2545F4914F6CDD1DUL) / 0x1p64;
}

void *xmalloc(size_t size, const char *name) {
  void *ptr = malloc(size);
  if (!ptr) error_exit("could not allocate memory for %s", name);
  return ptr;
}

int32_t read_uint16le(FILE *file) {
  unsigned char b[2];
  return fread(b, 1, 2, file) == 2 ? (int32_t)b[0] | ((int32_t)b[1] << 8) : -1;
}

int64_t read_uint32le(FILE *file) {
  unsigned char b[4];
  return fread(b, 1, 4, file) == 4 ? (int64_t)b[0] | ((int64_t)b[1] << 8) | ((int64_t)b[2] << 16) | ((int64_t)b[3] << 24) : -1;
}

struct node {
  bool isBranch; // tag for the union
  union {
    size_t value; // only leaf nodes have a value
    struct { size_t left, right; }; // only branch nodes have a left and right index into nodes
  };
  size_t count; // primary key for comparison when sorting
  size_t tie; // value of the leftmost leaf of the subtree; tiebreaker for comparison when sorting
};

struct node nodes[NUM_DELTAS * 2 - 1]; // large enough for a full binary tree with one leaf node for each possible delta value

int compare_nodes(const void *a, const void *b) {
  struct node na = nodes[*(const size_t *)a], nb = nodes[*(const size_t *)b];
  return na.count > nb.count ? 1 : na.count < nb.count ? -1 : (na.tie > nb.tie) - (na.tie < nb.tie);
}

struct bits {
  size_t length; // how many bits of data are used (will never exceed the size of data)
  uint32_t data; // masked by (1 << length) - 1
};

struct bits push_bits(struct bits a, struct bits b) {
  return (struct bits){.length = a.length + b.length, .data = (a.data << b.length) | b.data};
}
#define push_bit(prefix, bit) push_bits(prefix, (struct bits){.length = 1, .data = (bit)})

struct bits codes[NUM_DELTAS]; // Huffman codes for each delta value
_Static_assert(NUM_DELTAS < 32, "'struct bits' data cannot fit all possible codes for delta values");

struct bytes {
  size_t length; // how many bytes of data are used
  uint8_t data[]; // flexible array member of length bytes
};

struct bytes *new_bytes(size_t length) {
  struct bytes *bytes = xmalloc(sizeof *bytes + length, "encoded Huffman tree");
  bytes->length = length;
  return bytes;
}

// the Huffman tree is encoded as follows:
// - %1100_xxxx %0000_yyyy: x = right leaf (...1), y = left leaf (...0)
// - %1000_xxxx: left is internal branch, x = right leaf (...1)
// - %0xxx_xxxx: left and right are internal branches, x = jump offset
// - %1111_1111: terminator, signifies the end of the tree
// returns the encoded bytes, and adds their compiled length to the offset parameter
struct bytes *encode_huffman_tree(size_t root, size_t *offset, struct bits prefix) {
  size_t left = nodes[root].left, right = nodes[root].right;
  size_t leftValue = nodes[left].value, rightValue = nodes[right].value;

  struct bytes *tree;
  if (nodes[left].isBranch && nodes[right].isBranch) {
    // assembly generated for this case:
    //     {inline GetDEDBit} ; 6 bytes
    //     jr c, .skip        ; 2 bytes
    //     {left branch}
    //     .skip:
    //     {right branch}
    *offset += 6 + 2;
    size_t startOffset = *offset;

    struct bytes *leftTree = encode_huffman_tree(left, offset, push_bit(prefix, 0));
    size_t leftSize = *offset - startOffset;
    struct bytes *rightTree = encode_huffman_tree(right, offset, push_bit(prefix, 1));

    // All histograms can be turned into a Huffman tree such that all jumps fit.
    // The algorithm currently being used does not take this into account and may
    // trigger this assertion in some pathological cases.
    // Should such a pathological example arise, the program will need to be modified
    // to always put the smaller subtree as the left child.
    if (leftSize > 127) error_exit("left branch is too large to skip with a jr opcode");

    tree = new_bytes(1 + leftTree->length + rightTree->length);
    tree->data[0] = leftSize;
    memcpy(tree->data + 1, leftTree->data, leftTree->length);
    memcpy(tree->data + 1 + leftTree->length, rightTree->data, rightTree->length);

    free(leftTree);
    free(rightTree);
  } else if (nodes[left].isBranch) {
    // assembly generated for this case:
    //     {inline GetDEDBit} ; 6 bytes
    //     ld b, RIGHT_LEAF   ; 2 bytes
    //     ret c              ; 1 byte
    //     {left branch}
    *offset += 6 + 2 + 1;

    codes[rightValue] = push_bit(prefix, 1);
    struct bytes *leftTree = encode_huffman_tree(left, offset, push_bit(prefix, 0));

    tree = new_bytes(1 + leftTree->length);
    tree->data[0] = 0x80 + rightValue;
    memcpy(tree->data + 1, leftTree->data, leftTree->length);

    free(leftTree);
  } else {
    // assembly generated for this case:
    //     {inline GetDEDBit} ; 6 bytes
    //     ld b, RIGHT_LEAF   ; 2 bytes
    //     ret c              ; 1 byte
    //     ld b, LEFT_LEAF    ; 2 bytes
    //     ret                ; 1 byte
    *offset += 6 + 2 + 1 + 2 + 1;

    codes[leftValue] = push_bit(prefix, 0);
    codes[rightValue] = push_bit(prefix, 1);

    tree = new_bytes(2);
    memcpy(tree->data, &(uint8_t []){0xc0 + rightValue, leftValue}, tree->length);
  }

  return tree;
}

int main(int argc, char **argv) {
  if (argc != 3) {
    fprintf(stderr, "usage: %s in.wav out.ded\n", argv[0]);
    return 1;
  }

  FILE *in = fopen(argv[1], "rb");
  if (!in) error_exit("could not open \"%s\" for reading", argv[1]);

  if (read_uint32le(in) != CHUNKID('R', 'I', 'F', 'F')) error_exit("not RIFF file format");
  if (read_uint32le(in) < 36) error_exit("incomplete header");
  if (read_uint32le(in) != CHUNKID('W', 'A', 'V', 'E')) error_exit("not WAVE file type");
  if (read_uint32le(in) != CHUNKID('f', 'm', 't', ' ')) error_exit("no initial \"fmt \" chunk");
  if (read_uint32le(in) != 16) error_exit("\"fmt \" chunk is not 16 bytes");
  if (read_uint16le(in) != 1) error_exit("not PCM audio");
  int32_t numChannels = read_uint16le(in);
  int64_t frameRate = read_uint32le(in); // frames per second
  int64_t byteRate = read_uint32le(in); // bytes per second
  int32_t frameSize = read_uint16le(in); // bytes per frame
  int32_t bitsPerSample = read_uint16le(in);
  if (numChannels < 0 || frameRate < 0 || bitsPerSample < 0) error_exit("could not read WAV metadata");
  if (bitsPerSample % 8) error_exit("samples are not 8-bit byte divisible");
  int64_t sampleWidth = bitsPerSample / 8; // bytes per sample
  if (sampleWidth > 4) error_exit("unsupported sample width");
  if (frameSize != sampleWidth * numChannels) error_exit("frame size is inconsistent with other metadata");
  if (byteRate != frameRate * frameSize) error_exit("byte rate is inconsistent with other metadata");

  int64_t chunkSize = 0;
  for (int64_t chunkId = 0; !feof(in); fseek(in, chunkSize, SEEK_CUR)) {
    chunkId = read_uint32le(in);
    chunkSize = read_uint32le(in);
    if (chunkId == CHUNKID('d', 'a', 't', 'a')) break;
  }
  if (chunkSize < 0) error_exit("could not read \"data\" chunk size");
  if (chunkSize % frameSize) error_exit("sample data is not divisible into samples");
  if (!numChannels || !frameRate || !frameSize || !chunkSize) error_exit("no sample data");

  size_t numRealSamples = chunkSize / frameSize;
  size_t numSamples = numRealSamples + 2; // padding to simplify cubic spline interpolation
  double *samples = xmalloc(numSamples * sizeof *samples, "samples");
  uint8_t *frame = xmalloc(frameSize, "frame");

  uint64_t sampleScale = 1UL << bitsPerSample, sampleThreshold = 1UL << (bitsPerSample - 1);
  for (size_t i = 0; i < numRealSamples; i++) {
    if (fread(frame, 1, frameSize, in) != (size_t)frameSize) error_exit("could not read WAV frame");
    // 8-bit samples are unsigned, higher widths are signed
    int64_t total = 0;
    if (sampleWidth == 1) {
      for (int64_t j = 0; j < numChannels; j++) total += (int64_t)frame[j] - 128; // add a bias, to be signed too
    } else {
      for (int64_t j = 0; j < frameSize; j += sampleWidth) {
        uint64_t v = 0;
        for (int64_t k = 0; k < sampleWidth; k++) v = (v << 8) | frame[j + k];
        total += v < sampleThreshold ? v : -((int64_t)~v & (sampleThreshold - 1)) - 1; // reinterpret v as signed
      }
    }
    samples[i] = (double)total * DED_VOLUME / numChannels / sampleScale;
  }
  for (size_t i = numRealSamples; i < numSamples; i++) samples[i] = 0.0;

  free(frame);
  fclose(in);
  if (!samples || !numRealSamples) error_exit("no WAV samples");

  if (fabs(frameRate - DED_RATE) / DED_RATE > RESAMPLING_THRESHOLD) {
    size_t numInterpolated = (size_t)(numRealSamples * DED_RATE / frameRate);
    double *interpolated = xmalloc(numInterpolated * sizeof *interpolated, "interpolated samples");

    // cubic spline interpolation
    for (size_t i = 0; i < numInterpolated; i++) {
      double n = i * frameRate / DED_RATE;
      int nn = (int)n;
      double p0 = samples[nn], p1 = samples[nn + 1];
      double pPrev = nn > 0 ? samples[nn - 1] : samples[0]; // clamp at the left edge to avoid reading before the buffer
      double m0 = (samples[nn + 1] - pPrev) / 2, m1 = (samples[nn + 2] - samples[nn]) / 2;
      double t1 = modf(n, &(double){0});
      double t2 = pow(t1, 2), t3 = pow(t1, 3);
      interpolated[i] = (2 * t3 - 3 * t2 + 1) * p0 + (t3 - 2 * t2 + t1) * m0 + (-2 * t3 + 3 * t2) * p1 + (t3 - t2) * m1;
    }

    free(samples);
    samples = interpolated;
    numSamples = numInterpolated;
  } else {
    numSamples = numRealSamples; // do not count the two padding zeros as real samples
  }

  for (size_t i = 0; i < numSamples; i++) {
    samples[i] += (double)(NUM_DELTAS / 2) / (NUM_DELTAS - 1);
    if (samples[i] < 0.0) samples[i] = 0.0;
    else if (samples[i] > 1.0) samples[i] = 1.0;
  }

  size_t numDeltas = numSamples + (WAVE_RAM_SIZE * 2 - numSamples) % WAVE_RAM_SIZE; // pad to be divisible by wave RAM capacity
  int *deltas = xmalloc(numDeltas * sizeof *deltas, "sample deltas");

  // calculate deltas between samples; triangular PDF dithering to randomize quantization error
  int prevDelta = NUM_DELTAS / 2;
  for (size_t i = 0; i < numSamples; i++) {
    double sample = samples[i] * (NUM_DELTAS - 1);
    int quantized = (int)sample;
    double error = sample - quantized;
    double prob = error < 0.5 ? 2 * pow(error, 2) : 1 - (2 * pow(1 - error, 2)); // quadratic S-curve
    if (prob > uniform_random()) quantized++;
    deltas[i] = (quantized - prevDelta + NUM_DELTAS * 2) % NUM_DELTAS; // deltas are in [0, NUM_DELTAS)
    prevDelta = quantized;
  }
  for (size_t i = numSamples; i < numDeltas; i++) deltas[i] = 0;

  free(samples);

  size_t queue[NUM_DELTAS]; // initially queue one leaf per possible delta value
  size_t numQueued = sizeof queue / sizeof *queue;
  for (size_t i = 0; i < numQueued; i++) queue[i] = i;

  size_t numNodes = numQueued;
  for (size_t i = 0; i < numNodes; i++) nodes[i] = (struct node){.value = i, .tie = i};
  for (size_t i = 0; i < numSamples; i++) nodes[deltas[i]].count++;

  for (; numQueued > 1; queue[numQueued++] = numNodes++) {
    qsort(queue, numQueued, sizeof *queue, &compare_nodes);
    size_t left = queue[0];
    memmove(queue, queue + 1, --numQueued * sizeof *queue); // pop the left node
    size_t rightIndex = 0;
    for (size_t i = 0; i < numQueued && nodes[queue[i]].count == nodes[queue[0]].count; i++) {
      if (nodes[queue[i]].isBranch != nodes[left].isBranch) {
        rightIndex = i;
        break;
      }
    }
    size_t right = queue[rightIndex];
    memmove(queue + rightIndex, queue + rightIndex + 1, (--numQueued - rightIndex) * sizeof *queue); // pop the right node
    if (!nodes[left].isBranch && nodes[right].isBranch) {
      size_t tmp = left;
      left = right;
      right = tmp;
    }
    nodes[numNodes] = (struct node){
      .isBranch = true,
      .left = left,
      .right = right,
      .count = nodes[left].count + nodes[right].count,
      .tie = nodes[left].tie
    };
  }

  FILE *out = fopen(argv[2], "wb");
  if (!out) error_exit("could not open \"%s\" for writing", argv[2]);

  struct bytes *tree = encode_huffman_tree(queue[0], &(size_t){0}, (struct bits){0});
  if (fwrite(tree->data, 1, tree->length, out) < tree->length) error_exit("could not write encoded Huffman tree");
  free(tree);
  putc(0xff, out); // separate Huffman tree from encoded delta values

  size_t scaledNumDeltas = numDeltas / WAVE_RAM_SIZE;
  putc(scaledNumDeltas & 0xff, out);
  putc(scaledNumDeltas >> 8, out);

  struct bits deltaSeq = {0};
  for (size_t i = 0; i < numDeltas; i++) {
    for (deltaSeq = push_bits(deltaSeq, codes[deltas[i]]); deltaSeq.length >= 8; deltaSeq.data &= (1 << deltaSeq.length) - 1) {
      deltaSeq.length -= 8;
      putc((deltaSeq.data >> deltaSeq.length) & 0xff, out);
    }
  }
  if (deltaSeq.length) {
    size_t padLength = 8 - deltaSeq.length;
    putc((deltaSeq.data << padLength) | ((1 << padLength) - 1), out);
  }
  if (ferror(out)) error_exit("could not write encoded delta values");

  free(deltas);
  fclose(out);
  return 0;
}
