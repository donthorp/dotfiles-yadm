# Grip - Render Markdown

Source: [https://github.com/joeyespo/grip](https://github.com/joeyespo/grip)

## Overview

I prefer to not install binaries that require runtimes like python at a specific version, or want/need to store packages outside of a venv. Using a venv is also a pain since it requires modifying the existing shell.

## Usage

There is a driver script `grip` in `~/.local/bin` that uses `docker compose` to build and run the grip command in the image. By default, it expects a `README.md` in the current directory. You can pass it another markdown file if you prefer. The script is smart enough to find the absolute pats for mounting the volume into the container.

Grip starts a webserver at [http://localhost:6419](http://localhost:6419) that you can open in a browser window. The page updates each time the markdown file is saved.

> Note: the `-b` flag of grip is probably non-functional due to it running in the container.

