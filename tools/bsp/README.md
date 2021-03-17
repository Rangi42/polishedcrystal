# bsp — Binary Script Patching

This project focuses on creating binary patch files; that is, files that encode the conversion between a source and a
target file, both of them being binary files regardless of internal structure. This project also contains a patching
library that can be used to apply said patches once created.

Instead of following the typical approach of building a file containing the differences as pure data, this project aims
towards building scripted patches — that is, patch files that contain a script that is executed in order to perform the
patching process. While this implies that, unlike in standard approaches, patch files must be built manually; it in
turn allows arbitrarily complex patching and verification processes, including the possibility of handling multiple,
different source and/or target files, or allowing the user of the patch to select which target to produce.

This software is released to the public domain. For more information, view the (conventionally but inaccurately named)
[LICENSE][license] file.

For information on the BSP format, defined by this project, read the [specification]. For information about the exact
syntax and details that the compiler uses, read the [compiler documentation][compiler-docs]. For information about the
patching library, read the corresponding [documentation][patcher-docs]; the library itself is available in the
[`bsppatch.js`](bsppatch.js) file.

A patching program for Node.js using this library is also available here, in the [`patcher.js`](patcher.js) file. This
program uses the `bsppatch.js` library, and requires it to be in the same directory. It needs Node.js 4.x or higher to
run. In order to use it, invoke it with the patch file, the input file and the output filename (in that order) as
command-line arguments, like this:

```
node patcher.js patch.bsp input.dat output.dat
```

It is also possible to apply patches via a website. A sample patching website is available here, which should work in
any modern browser; it is located in the [`sample.htm`](sample.htm) file, and it requires having the `bsppatch.js` file
in the same directory for it to work. This website can be tested at http://aaaaaa123456789.github.io/bsp.

[license]: LICENSE
[specification]: specification.md
[compiler-docs]: compiler.md
[patcher-docs]: patching.md
