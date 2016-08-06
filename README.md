# rr-docker

Docker image to build RR.

## Usage

Replace `[YOUR_SRC_DIR]` with the path where your source code is stored (I didn't want to bloat the image), `[YOUR_DEVICE]` with your device codename and `[YOUR_CACHE_DIR]` with the path you want ccache to use.

First, you need to get the source. To do that (assuming that you already have repo) do:

```bash
mkdir -p [YOUR_SRC_DIR]
mkdir -p [YOUR_CACHE_DIR]
cd [YOUR_SRC_DIR]
repo init -u git://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow
```

To sync the source and start the build:

```bash
docker run -it -v [YOUR_SRC_DIR]:/root/source -v [YOUR_CACHE_DIR]:/root/cache -e "DEVICE=[YOUR_DEVICE]" lerk/android
```