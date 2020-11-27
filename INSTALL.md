# Install Guide

If you just want to play Polished Crystal, use one of the .ips patches as described in [README.md](README.md#download-and-play). To build a ROM yourself from the source code, follow these instructions.

> You know it's sitting back and looking at it that you realize that Gamefreak is actually really good devs.  
> Like you have Pokemon and it's a simple formula "How can you fuck it up?" and then all of these Romhacks basically go "Like this."
>
> — Anonymous, [/vp/](http://boards.4chan.org/vp/)


## Windows

To build on Windows, install [**Cygwin**](http://cygwin.com/install.html) with the default settings.

In the installer, select the following packages: `git`, `python`, `make`, and `gcc-core`.

In the **Cygwin terminal**:

```bash
git clone https://github.com/Rangi42/polishedcrystal.git
cd polishedcrystal
mkdir rgbds
```

Then download [**rgbds**](https://github.com/bentley/rgbds/). You'll need version 0.3.9 or later. Extract the archive and put all the .exe and .dll files in polishedcrystal/rgbds.

To build **polishedcrystal.gbc**:

```bash
make
```

To build other versions:

```bash
make [faithful] [nortc] [hgss|monochrome|noir] [debug]
```

For example, to build a mononchrome faithful version:

```bash
make faithful monochrome
```


## Linux

Python 2.7 is required.

```bash
sudo apt-get install make python gcc git bison

git clone https://github.com/gbdev/rgbds.git
cd rgbds
sudo make install
cd ..

git clone https://github.com/Rangi42/polishedcrystal.git
cd polishedcrystal
```

To build **polishedcrystal.gbc**:

```bash
make
```

To build other versions:

```bash
make [faithful] [nortc] [hgss|monochrome|noir] [debug]
```


## Mac OS X

`md5sum`, `ghead` and `gtail` are required.  
To install it: ```brew install coreutils```

In **Terminal**, run:

```bash
xcode-select --install

git clone https://github.com/gbdev/rgbds.git
cd rgbds
sudo make install
cd ..

git clone https://github.com/Rangi42/polishedcrystal.git
cd polishedcrystal
```

To build **polishedcrystal.gbc**:

```bash
make
```

To build other versions:

```bash
make [faithful] [nortc] [hgss|monochrome|noir] [debug]
```
