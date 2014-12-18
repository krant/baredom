################################################################################
#
# LINCX
#
################################################################################

LINCX_VERSION = master
LINCX_SITE = $(call github,cloudozer,lincx,$(LINCX_VERSION))
LINCX_LICENSE_FILES = LICENSE
LINCX_DEPENDENCIES = erlang xen binutils

define LINCX_BUILD_CMDS
	(cd $(@D); ./rebar get-deps)
endef

define LINCX_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/root/lincx
	tar -c --exclude .git --exclude .gitignore --exclude .stamp* -C $(@D) . | tar -x -C $(TARGET_DIR)/root/lincx
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL)/package/lincx/lincx.yml $(TARGET_DIR)/root/lincx/lincx.yml
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL)/package/lincx/S60lincx $(TARGET_DIR)/etc/init.d/S60lincx
endef

$(eval $(generic-package))
