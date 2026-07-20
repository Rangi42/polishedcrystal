# Install Guide

> You know it's sitting back and looking at it that you realize that Gamefreak are actually really good devs.  
> Like you have Pokemon and it's a simple formula "How can you fuck it up?" and then all of these Romhacks basically go "Like this."
>
> — Anonymous, [/vp/](https://boards.4channel.org/vp/)

If you just want to play Polished Crystal, install the .gbc file directly from the [latest release](https://github.com/Rangi42/polishedcrystal/releases/latest).

To build a ROM yourself from the source code, follow the instructions below. They first provide installation guides for the tools required to build the ROM, then provide the actual ROM building instructions.

Operating Systems:
- [Windows (10 & Newer)](#windows-10--newer)
- [Windows (8 & Older)](#windows-8--older)
- [Linux](#linux)
- [MacOS](#macos)

## Windows 10 & Newer

Download and install [**Windows Subsystem for Linux**](https://docs.microsoft.com/en-us/windows/wsl/install-win10). Then open the **WSL terminal**.

Update WSL's software before continuing. For example, if you chose Debian, Ubuntu, or another distribution that uses `apt-get`, then enter this command:

```bash
apt-get update && apt-get upgrade
```

Then, follow [the instructions for **Linux**](#linux) below for whatever distribution you installed for WSL.

## Windows (8 & Older)

To build on Windows, install [**Cygwin**](http://cygwin.com/install.html) with the default settings.

In the installer, select the following packages: `git`, `make`, and `gcc-core`.

In the **Cygwin terminal**:

```bash
git clone https://github.com/Rangi42/polishedcrystal.git
cd polishedcrystal
mkdir rgbds
```

Then download [**rgbds 1.0.1**](https://rgbds.gbdev.io/install/windows). (If you're building an older release of Polished Crystal, you may need an older version of RGBDS.) Extract the archive and put all the .exe and .dll files in polishedcrystal/rgbds.

Now you're ready to [build **polishedcrystal**](#build-polishedcrystal).

## Linux

Regardless of distro choice, the goal here is to install the following software:
- `make`
- `gcc` (or `clang`)
- `git`
- `rgbds`

To do so, open **Terminal** and enter the following commands, depending on which distro you're using.

### Debian or Ubuntu

To install the software required for **polishedcrystal**:

```bash
sudo apt-get install make gcc git
```

Then follow the [**rgbds** instructions](https://rgbds.gbdev.io/install/linux) to install **rgbds 1.0.1**.

### OpenSUSE

To install the software required for **polishedcrystal**:

```bash
sudo zypper install make gcc git
```

Then follow the [**rgbds** instructions](https://rgbds.gbdev.io/install/linux) to install **rgbds 1.0.1**.

### Arch Linux

To install the software required for **polishedcrystal**:

```bash
sudo pacman -S make gcc git rgbds
```

### Termux

To install the software required for **pokecrystal**:

```bash
pkg install make clang git sed rgbds
```

### Other distros

If your distro is not listed here, try to find the required software below in its repositories:

- `make`
- `gcc` (or `clang`)
- `git`
- `rgbds`

If `rgbds` is not available, you'll need to follow the [**rgbds** instructions](https://rgbds.gbdev.io/install#building-from-source) to build **rgbds 1.0.1** from source.

Now you're ready to [build **polishedcrystal**](#build-polishedcrystal).

## macOS

Install [**Homebrew**](https://brew.sh/). Follow the official instructions.	

In **Terminal**, run:

```bash
brew install coreutils
xcode-select --install

brew install rgbds
```

Now you're ready to [build **polishedcrystal**](#build-polishedcrystal).

## Build polishedcrystal

Open your **Terminal** and enter the following commands.
To download the **polishedcrystal** source files:

```bash
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

For example, to build a mononchrome faithful version:

```bash
make faithful monochrome
```


