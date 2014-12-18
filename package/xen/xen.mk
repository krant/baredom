################################################################################
#
# xen
#
################################################################################

XEN_VERSION = master
XEN_SITE = git://xenbits.xen.org/xen.git
XEN_LICENSE = GPLv2+
XEN_DEPENDENCIES = util-linux yajl pixman

define XEN_CONFIGURE_CMDS
	( cd $(@D); \
		./autogen.sh; \
		$(TARGET_CONFIGURE_OPTS) \
		$(TARGET_CONFIGURE_ARGS) \
		PREPEND_INCLUDES=$(STAGING_DIR)/usr/include \
		PREPEND_LIB=$(STAGING_DIR)/usr/lib \
		./configure \
			--prefix=/usr \
			--disable-docs \
			--disable-stubdom \
			--build=$(GNU_HOST_NAME) \
			--host=$(GNU_TARGET_NAME) \
	)
endef

define XEN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) HOST_EXTRACFLAGS=-Wno-format-security APPEND_CFLAGS="-Wno-format-nonliteral -Wno-missing-declarations -Wno-missing-prototypes"
endef

define XEN_INSTALL_TARGET_CMDS
        $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(XEN_MAKE_ENV) DESTDIR=$(TARGET_DIR) install
	cp $(TARGET_DIR)/etc/init.d/xencommons $(TARGET_DIR)/etc/init.d/S50xencommons
	rm -rf $(TARGET_DIR)/boot
endef

$(eval $(generic-package))
