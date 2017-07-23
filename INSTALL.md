The source files are assembled into a rom using [**rgbds**](https://github.com/rednex/rgbds).
These instructions explain how to set up the tools required to build.

If you run into trouble, ask on irc ([**freenode#pret**](https://kiwiirc.com/client/irc.freenode.net/?#pret)).


# Linux

Python 2.7 is required.

```bash
sudo apt-get install make gcc bison git python

git clone https://github.com/rednex/rgbds
cd rgbds
git checkout v0.3.1
sudo make install
cd ..

git clone --recursive https://github.com/roukaour/polishedcrystal
cd polishedcrystal
```

To build **polishedcrystal.gbc**:

```bash
make
```

To build other versions:

```bash
make [faithful] [nortc] [monochrome] [debug]
```


# Mac

In **Terminal**, run:

```bash
xcode-select --install

git clone https://github.com/rednex/rgbds
cd rgbds
git checkout v0.3.1
sudo make install
cd ..

git clone --recursive https://github.com/roukaour/polishedcrystal
cd polishedcrystal
```

To build **polishedcrystal.gbc**:

```bash
make
```

To build other versions:

```bash
make [faithful] [nortc] [monochrome] [debug]
```


# Windows

To build on Windows, install [**Cygwin**](http://cygwin.com/install.html) with the default settings.

In the installer, select the following packages: `make` `git` `gettext` `python` `gcc-core`

Then get [**rgbds 0.3.1**](https://github.com/bentley/rgbds/releases/). Other versions are not compatible. Extract the archive and put all the `exe` and `dll` files individually in `C:\cygwin64\usr\local\bin`.

In the **Cygwin terminal**:

```bash

git clone --recursive https://github.com/roukaour/polishedcrystal
cd polishedcrystal
```

To build **polishedcrystal.gbc**:

```bash
make
```

To build other versions:

```bash
make [faithful] [nortc] [monochrome] [debug]
```

For example, to build a mononchrome faithful version:

```bash
make faithful monochrome
```

## Notes

* If `gettext` no longer exists, grab `libsasl2-3` `ca-certificates`.
