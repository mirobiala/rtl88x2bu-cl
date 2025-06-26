# SPDX-License-Identifier: GPL-2.0-or-later

include $(TOPDIR)/rules.mk

PKG_NAME:=rtl88x2bu-cl
PKG_RELEASE=2
PKG_LICENSE:=GPLv2

PKG_SOURCE_URL:=https://github.com/RinCat/RTL88x2BU-Linux-Driver
PKG_MIRROR_HASH:=e63bedaa301d9261be2c5dd9c5e0d986f15376a8c2cdb64bb036698ca449a50e
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2025-06-11
PKG_SOURCE_VERSION:=77a82dbac7192bb49fa87458561b0f2455cdc88f
PKG_MAINTAINER:=Rin Cat <dev@rincat.ch>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/rtl88x2bu-cl
	SUBMENU:=Wireless Drivers
	TITLE:=Realtek 88x2BU driver by RinCat
	DEPENDS:=+kmod-cfg80211 +kmod-usb-core +@DRIVER_11N_SUPPORT +@DRIVER_11AC_SUPPORT
	FILES:=$(PKG_BUILD_DIR)/rtl88x2bu.ko
	AUTOLOAD:=$(call AutoProbe,rtl88x2bu)
	PROVIDES:=kmod-rtl88x2bu
endef

NOSTDINC_FLAGS := \
	$(KERNEL_NOSTDINC_FLAGS) \
	-I$(PKG_BUILD_DIR) \
	-I$(PKG_BUILD_DIR)/include \
	-I$(STAGING_DIR)/usr/include/mac80211-backport \
	-I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
	-I$(STAGING_DIR)/usr/include/mac80211 \
	-I$(STAGING_DIR)/usr/include/mac80211/uapi \
	-include backport/backport.h

define KernelPackage/rtl88x2bu-cl/config
$(shell \
	PATCHDIR=$$(pwd); \
	cd $(TOPDIR); \
	for PATCH in $$PATCHDIR/openwrt_patches/*; do \
		if ! git apply -R --check <$$PATCH >/dev/null 2>&1; then \
			git apply -v <$$PATCH; \
		fi; \
	done; \
)
endef

# from Makefile: obj-(CONFIG_RTL8822BU) = ...
ifdef CONFIG_PACKAGE_kmod-rtl88x2bu-cl
   PKG_MAKE_FLAGS += CONFIG_RTL8822BU=m
endif

define OpenWRT/Clean
$(shell \
	PATCHDIR=$$(pwd); \
	cd $(TOPDIR); \
	for PATCH in $$PATCHDIR/openwrt_patches/*; do \
		FILE=$$(cat $$PATCH | grep "+++ b/" | head -n 1 | grep -o "package/.*"); \
		if [ -f $$FILE ]; then rm $$FILE; fi; \
	done; \
)
endef

define Build/Clean
	$(call OpenWRT/Clean)
	$(call Build/Clean/Default)
endef

NOSTDINC_FLAGS+=-DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT -DBUILD_OPENWRT

define Build/Compile
	+$(KERNEL_MAKE) $(PKG_JOBS) \
		$(KERNEL_MAKE_FLAGS) \
		$(PKG_MAKE_FLAGS) \
		M="$(PKG_BUILD_DIR)" \
		NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
		modules
endef

$(eval $(call KernelPackage,rtl88x2bu-cl))
