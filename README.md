# rtl88x2bu package for **OpenWRT**
This package uses [Realtek 88x2BU driver by RinCat](https://github.com/RinCat/RTL88x2BU-Linux-Driver) with patches for **OpenWRT**.
I tested it with [TP-Link Archer T3U Nano](https://www.tp-link.com/us/home-networking/usb-adapter/archer-t3u-nano/) and [OpenWRT v23.05.0](https://openwrt.org/releases/23.05/notes-23.05.0).

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
* Ensure you have C compiler & toolchains, e.g. `build-essential` for **OpenWRT**, check [this](https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem).
* Download and update the **OpenWRT** sources:
```
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
git pull
```
* Select a specific code revision:
```
git branch -a
git tag
git checkout v23.05.0
```
* Update the feeds:
```
./scripts/feeds update -a
./scripts/feeds install -a
```
* Download the **rtl88x2bu** package:
```
git clone https://github.com/mirobiala/rtl88x2bu-cl package/kernel/rtl88x2bu-cl
```
* Download the default config for the **desired** target:
```
wget https://downloads.openwrt.org/releases/23.05.0/targets/<target>/config.buildinfo -O .config
```
* If you want actual _vendor_ and _device_ names in the **OpenWRT** instead of _Generic MAC80211_, you need to add them in the `devices.txt` file, `USB devices` section:
```
# rtl88x2bu-cl/os_dep/linux/usb_intf.c
0x0000 0x0000 0x0b05 0x1841    0      0  "ASUS" "AC1300 USB-AC55 B1"
0x0000 0x0000 0x0b05 0x184C    0      0  "ASUS" "U2"
0x0000 0x0000 0x0B05 0x19AA    0      0  "ASUS" "USB-AC58"
0x0000 0x0000 0x7392 0xB822    0      0  "Edimax" "EW-7822ULC"
0x0000 0x0000 0x7392 0xC822    0      0  "Edimax" "EW-7822UTC"
0x0000 0x0000 0x7392 0xF822    0      0  "Edimax" "EW-7822UAD"
0x0000 0x0000 0x2001 0x331e    0      0  "Dlink" "DWA-181"
0x0000 0x0000 0x2001 0x331c    0      0  "Dlink" "DWA-182"
0x0000 0x0000 0x2001 0x331f    0      0  "Dlink" "DWA-183 D Ver"
0x0000 0x0000 0x2001 0x3322    0      0  "Dlink" "DWA-T185"
0x0000 0x0000 0x0846 0x9055    0      0  "NetGear" "A6150"
0x0000 0x0000 0x2357 0x012D    0      0  "TP-Link" "Archer T3U"
0x0000 0x0000 0x2357 0x012E    0      0  "TP-Link" "Archer T3U Nano"
0x0000 0x0000 0x2357 0x0138    0      0  "TP-Link" "Archer T3U Plus"
0x0000 0x0000 0x2357 0x0115    0      0  "TP-Link" "Archer T4U V3"
0x0000 0x0000 0x20F4 0x808A    0      0  "TRENDnet" "TEW-808UBM"
```
* Compile and build the **OpenWRT** image.
```
make menuconfig
<enable rtl88x2bu-cl>
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
* [RinCat](https://github.com/RinCat)
* [morrownr](https://github.com/morrownr)
* [cilynx](https://github.com/cilynx)
* [ValdikSS](https://forum.openwrt.org/u/ValdikSS)
* [plntyk](https://github.com/plntyk)
* [_jason](https://gitlab.com/_jason)
