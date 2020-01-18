# DIY Linux

This is a set of Linux system configurations for [Buildroot](https://buildroot.org) intended for personal use. The motivation behind this project is the following:

* Replace some shitty consumer electronics (e.g. wireless access point, network-attached storage) with custom solutions built on better hardware and software aiming to do one thing well.
* Do research projects like a highly available [Kubernetes](http://kubernetes.io) cluster out of 8 [Raspberry Pi](http://raspberrypi.org) or similar hardware. Or a 1024-core supercomputer for AI out of [Jetson Nano](https://developer.nvidia.com/embedded/jetson-nano-developer-kit).
* Have fun ;)

I've been passionate about building embedded systems [since the year 2006](https://sourceforge.net/projects/legobsd/).

## List of projects

* [Raspberry Pi 3 Model B+ Wireless Access Point](projects/wifi-access-point/board/raspberrypi3-64/README.md)
* [Orange Pi Zero Plus Wireless Access Point](projects/wifi-access-point/board/orangepi-zero-plus/README.md)

## Usage

### Build the Buildroot Docker image

    docker build -t buildroot .

### Build a project-specific image

Run a shell within a Buildroot container

    docker run -it --rm \
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

    sudo dd bs=4m if=images/sdcard.img of=/dev/disk-name

If you get the following error

    dd: /dev/disk-name: Resource busy

unmounting the disk might help:

    diskutil unmountDisk /dev/disk-name

Once `dd` process is finished don't forget to eject the disk:

    diskutil eject /dev/disk-name

### Troubleshoot

If a board has a UART port it's convenient to use a USB to UART cable to connect to the serial port.
PL2303HX based cable is confirmed to work on macOS. Driver can be found [here](http://www.prolific.com.tw/US/ShowProduct.aspx?p_id=229&pcid=41).
Once the driver is installed and a cable is connected use the following command.

    sudo cu -s 115200 -l /dev/cu.usbserial

## Known issues

The build is slow and eventually fails if Buildroot `output` directory is a Docker volume mounted on the macOS host.

## Interesting hardware for future projects

* [COMPEX embedded boards](https://compex.com.sg/embedded-board/)
* [Banana Pi single board computers](http://www.banana-pi.org/bpi-products.html)
* [GATEWORKS single board computers](https://www.gateworks.com/products/)
* [VIA Embedded Pico-ITX boards](https://www.viatech.com/en/boards/pico-itx/)
* [VIA Embedded 3.5″ boards](https://www.viatech.com/en/boards/3-5-inch-sbc/)
* [PINE64 single board computers](https://www.pine64.org)
* [Onion](https://onion.io)
* [CubieBoard](http://cubieboard.org/model/)
* [BeagleBoard](http://beagleboard.org/boards)
* [TinyCircuits](https://tinycircuits.com)
* [Coral](https://coral.ai)
* [8devices](https://www.8devices.com)

## Useful links

* [Comparison of open-source wireless drivers](https://en.wikipedia.org/wiki/Comparison_of_open-source_wireless_drivers)
* [Beginners guide to a custom 802.11ac setup](http://pisarenko.net/blog/2015/02/01/beginners-guide-to-802-dot-11ac-setup/)
* [Cryptographic hardware accelerators](https://openwrt.org/docs/techref/hardware/cryptographic.hardware.accelerators)
* [EROFS](https://en.wikipedia.org/wiki/EROFS)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
