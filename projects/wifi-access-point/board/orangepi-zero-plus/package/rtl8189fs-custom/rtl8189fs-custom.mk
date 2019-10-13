################################################################################
#
# rtl8189fs-custom
#
################################################################################

RTL8189FS_CUSTOM_VERSION = 50da9756282edf5008a5a567275b33c1d2f16197
RTL8189FS_CUSTOM_SITE = $(call github,jwrdegoede,rtl8189ES_linux,$(RTL8189FS_CUSTOM_VERSION))
RTL8189FS_CUSTOM_LICENSE = GPL-2.0

RTL8189FS_CUSTOM_MODULE_MAKE_OPTS = \
	CONFIG_RTL8189FS=m \
	KVER=$(LINUX_VERSION_PROBED) \
	KSRC=$(LINUX_DIR)

$(eval $(kernel-module))
$(eval $(generic-package))
