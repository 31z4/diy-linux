# Raspberry Pi 3 Model B+ Wireless Access Point

This is a minimalistic system that acts as a gateway and provides internet access to multiple hosts on a local wireless network using a single public IP address.

It consists of the following major components:

* [BusyBox](https://busybox.net)
* [udhcp](https://udhcp.busybox.net) as a DHCP client and server
* [wpa_supplicant](https://w1.fi/wpa_supplicant/) to set up a Wi-Fi access point
* iptables to set up NAT

## Configure

Enter an interactive curses-based configurator

    make BR2_EXTERNAL=projects/wifi-access-point raspberrypi3_64_defconfig
    make menuconfig

and set the following configuration options:

* Root password at `System configuration -> Enable root login with password`
* Wireless network name at `External options`
* WPA preshared key at `External options`

## Build

    make

Once build is successfully done you can follow general instructions to [flash the image to an SD card](/README.md#flash-the-image-to-an-sd-card).

## Future improvements

* Add an SSH daemon.
* Set up DNS based ad filtering.
* Add basic monitoring capabilities.
* Decrease power consumption.
