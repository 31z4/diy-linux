# DIY Linux

This is a set of Linux system configurations for [Buildroot](https://buildroot.org) intended for personal use. The motivation behind this project is the following:

* Replace some shitty consumer electronics (e.g. wireless access point, network-attached storage) with custom solutions built on better hardware and software aiming to do one thing well.
* Do research projects like a highly available [Kubernetes](http://kubernetes.io) cluster out of 8 [Raspberry Pi](http://raspberrypi.org) or similar hardware. Or a 1024-core supercomputer for AI out of [Jetson Nano](https://developer.nvidia.com/embedded/jetson-nano-developer-kit).
* Have fun ;)

I've been passionate about building customized systems [since the year 2006](https://sourceforge.net/projects/legobsd/).

## List of projects

* [Raspberry Pi 3 Model B+ Wireless Access Point](projects/wifi-access-point/README.md)

## Usage

### Build the Buildroot Docker image

    docker build -t buildroot .

### Build a project-specific image

Run a shell within a Buildroot container

    docker run -it \
    -v `pwd`/dl:/buildroot/dl \
    -v `pwd`/projects:/buildroot/projects \
    -v `pwd`/images:/buildroot/output/images \
    buildroot bash

and follow [project-specific instructions](#list-of-projects).

Once build is successfully done you can exit the Buildroot container. The resulting image will be within the `images` directory.

### Flash the image to an SD card

To figure out an SD card disk name on macOS host run the following command:

    diskutil list

Double-check the disk name and flash the image to it:

    sudo dd if=images/sdcard.img of=/dev/disk-name

If you get the following error

    dd: /dev/disk-name: Resource busy

unmounting the disk might help:

    diskutil unmountDisk /dev/disk-name

Once `dd` process is finished don't forget to eject the disk:

    diskutil eject /dev/disk-name

## Known issues

The build is slow and eventually fails if Buildroot `output` directory is a Docker volume mounted on the macOS host.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
