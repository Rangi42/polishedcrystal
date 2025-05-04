# Install Guide

If you just want to play Polished Crystal, use one of the .ips patches as described in [README.md](README.md#download-and-play). To build a ROM yourself from the source code, follow these instructions.

> You know it's sitting back and looking at it that you realize that Gamefreak is actually really good devs.  
> Like you have Pokemon and it's a simple formula "How can you fuck it up?" and then all of these Romhacks basically go "Like this."
>
> — Anonymous, [/vp/](https://boards.4channel.org/vp/)


## Windows

To build on Windows, install [**Cygwin**](http://cygwin.com/install.html) with the default settings.

In the installer, select the following packages: `git`, `make`, and `gcc-core`.

In the **Cygwin terminal**:

```bash
git clone https://github.com/Rangi42/polishedcrystal.git
cd polishedcrystal
mkdir rgbds
```

Then download [**rgbds 0.9.2**](https://rgbds.gbdev.io/). (If you're building an older release of Polished Crystal, you may need an older version of RGBDS.) Extract the archive and put all the .exe and .dll files in polishedcrystal/rgbds.

To build **polishedcrystal.gbc**:

```bash
make
```

To build other versions:

```bash
make [faithful] [hgss|monochrome|noir] [debug]
```

For example, to build a mononchrome faithful version:

```bash
make faithful monochrome
```


## Linux

```bash
sudo apt-get install make gcc git bison

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
make [faithful] [hgss|monochrome|noir] [debug]
```


## Mac OS X

`md5sum`, `ghead` and `gtail` are required.  
To install it: ```brew install coreutils```

In **Terminal**, run:

```bash
xcode-select --install

brew install rgbds

git clone https://github.com/Rangi42/polishedcrystal.git
cd polishedcrystal
```

To build **polishedcrystal.gbc**:

```bash
make
```

To build other versions:

```bash
make [faithful] [hgss|monochrome|noir] [debug]
```
