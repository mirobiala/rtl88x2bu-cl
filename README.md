# rtl88x2bu package for OpenWRT (snapshot builds)
This package uses [Realtek 88x2BU driver](https://github.com/RinCat/RTL88x2BU-Linux-Driver) by [@RinCat](https://github.com/RinCat) with patches for [OpenWRT](https://openwrt.org/).
I tested it with [TP-Link Archer T3U Nano](https://www.tp-link.com/us/home-networking/usb-adapter/archer-t3u-nano/) and [OpenWRT SNAPSHOT r30226](https://openwrt.org/releases/snapshot).

**Note:** No need for patching `mac80211.sh` with this package.

## Supported Devices
<details>
  <summary>
    ASUS
  </summary>

* ASUS AC1300 USB-AC55 B1
* ASUS U2
* ASUS USB-AC58
</details>

<details>
  <summary>
    Dlink
  </summary>

* Dlink - DWA-181
* Dlink - DWA-182
* Dlink - DWA-183 D Version
* Dlink - DWA-T185
</details>

<details>
  <summary>
    Edimax
  </summary>

* Edimax EW-7822ULC
* Edimax EW-7822UTC
* Edimax EW-7822UAD
</details>

<details>
  <summary>
    NetGear
  </summary>

* NetGear A6150
</details>

<details>
  <summary>
    TP-Link
  </summary>

* TP-Link Archer T3U
* TP-Link Archer T3U Nano
* TP-Link Archer T3U Plus
* TP-Link Archer T4U V3
</details>

<details>
  <summary>
    TRENDnet
  </summary>

* TRENDnet TEW-808UBM
</details>

## Usage
* Ensure you have C compiler & toolchains, e.g. `build-essential` for [OpenWRT](https://openwrt.org/), check [this](https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem).
* Download and update the [OpenWRT sources](https://git.openwrt.org/openwrt/openwrt.git):
```
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
git pull
```
* Select a specific code revision:
```
git branch -a
git checkout main
```
* Update the feeds:
```
./scripts/feeds update -a
./scripts/feeds install -a
```
* Download the [rtl88x2bu](https://github.com/mirobiala/rtl88x2bu-cl) package:
```
git clone https://github.com/mirobiala/rtl88x2bu-cl package/kernel/rtl88x2bu-cl
```
* Select a patch code revision:
```
cd package/kernel/rtl88x2bu-cl
git branch -a
git checkout main
cd ../../../
```
* Download the default config for the **desired** target:
```
wget https://downloads.openwrt.org/snapshots/targets/<target>/config.buildinfo -O .config
```
* Compile and build the [OpenWRT](https://openwrt.org/) image.
```
make menuconfig
<enable Kernel modules->Wireless Drivers->kmod-rtl88x2bu-cl ... Realtek 88x2BU driver by RinCat>
make
```

## Links
* https://github.com/RinCat/RTL88x2BU-Linux-Driver
* https://github.com/cilynx/rtl88x2bu
* https://github.com/morrownr/88x2bu-20210702
* https://forum.openwrt.org/t/rtl8822bu-and-rtl8821cu-usb-drivers
* https://github.com/openwrt/openwrt/pull/4253
* https://gitlab.com/_jason/openwrt-rtl8812bu-package


## Credits
* [@RinCat](https://github.com/RinCat)
* [@morrownr](https://github.com/morrownr)
* [@cilynx](https://github.com/cilynx)
* [@ValdikSS](https://forum.openwrt.org/u/ValdikSS)
* [@plntyk](https://github.com/plntyk)
* [@_jason](https://gitlab.com/_jason)
