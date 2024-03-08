# SPDX-License-Identifier: GPL-2.0-or-later

include $(TOPDIR)/rules.mk

PKG_NAME:=rtl88x2bu-cl
PKG_RELEASE=2
PKG_LICENSE:=GPLv2

PKG_SOURCE_URL:=https://github.com/RinCat/RTL88x2BU-Linux-Driver
PKG_MIRROR_HASH:=a1b66b5b111f569910469f1b13e9db0385f386644ec1001fd5e6f1086fa6eb74
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-02-01
PKG_SOURCE_VERSION:=7bdc911e1c14cac9448c3b9f68bf5392cc318849
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

# from Makefile: obj-(CONFIG_RTL8822BU) = ...
ifdef CONFIG_PACKAGE_kmod-rtl88x2bu-cl
   PKG_MAKE_FLAGS += CONFIG_RTL8822BU=m
endif

NOSTDINC_FLAGS+=-DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT -DBUILD_OPENWRT

define Build/Prepare
	$(call Build/Prepare/Default)
	$(shell PATCHDIR=$$(pwd); \
		cd $(TOPDIR); \
		REBUILD_PATCHED=0; \
		for PATCH in $$PATCHDIR/openwrt_patches/*; do \
			if ! git apply -R --check <$$PATCH >> /dev/null; then \
				git apply -v <$$PATCH; \
				REBUILD_PATCHED=1; \
			fi; \
		done; \
		if [ $$REBUILD_PATCHED -eq 1 ] ; then \
			$$(make package/iwinfo/compile); \
		fi \
	)
endef

define Build/Compile
	+$(KERNEL_MAKE) $(PKG_JOBS) \
		$(KERNEL_MAKE_FLAGS) \
		$(PKG_MAKE_FLAGS) \
		M="$(PKG_BUILD_DIR)" \
		NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
		modules
endef

$(eval $(call KernelPackage,rtl88x2bu-cl))
