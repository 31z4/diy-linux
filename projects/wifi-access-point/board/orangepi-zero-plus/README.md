# Orange Pi Zero Plus Wireless Access Point

This is a minimalistic system that acts as a gateway and provides internet access to multiple hosts on a local wireless network using a single public IP address.

It consists of the following major components:

* [BusyBox](https://busybox.net)
* [udhcp](https://udhcp.busybox.net) as a DHCP client and server
* [hostapd](https://w1.fi/hostapd/) to set up a Wi-Fi access point
* [Dropbear](https://matt.ucc.asn.au/dropbear/dropbear.html) as an SSH server
* iptables to set up NAT

## Configure

Enter an interactive curses-based configurator

    make BR2_EXTERNAL=projects/wifi-access-point orangepi_zero_plus_defconfig
    make menuconfig

and set the following configuration options.

### Root password

Located at `System configuration -> Enable root login with password -> Root password`.

Use only crypt-encoded password because it appears as-is in the `.config` file, and may appear in the build log!

Note: `$` signs in the hashed password must be doubled.
Otherwise `make` would attempt to interpret the `$` as a variable expansion.
To encode password on the host system run:

    echo supersecret | docker run -i --rm busybox mkpasswd -m sha256 | sed 's/\$/\$\$/g'

### Wi-Fi network name (SSID)

Located at `External options`.

### Channel number (IEEE 802.11)

Located at `External options`.

Note, that automatic Wi-Fi channel selection is not supported by driver yet.
Hence, `hostapd` won't start if this value is set to `0`.

### WPA preshared key

Located at `External options`.

The key used in WPA-PSK mode must be entered as 64 hex-digits.

Separate tool, `wpa_passphrase`, can be used to generate 256-bit keys from ASCII passphrase.
This process uses lot of CPU and `hostapd` startup and reconfiguration time can be optimized
by generating the PSK only only when the passphrase or SSID has actually changed.

    docker run -it --rm alpine sh -c 'apk add wpa_supplicant && wpa_passphrase SSID passphrase'

## Build

    make

Once build is successfully done you can follow general instructions to [flash the image to an SD card](/README.md#flash-the-image-to-an-sd-card).

## Future improvements

* Set up DNS based ad filtering.
* Add basic monitoring capabilities.
* Enhance logging.
* Decrease power consumption.
