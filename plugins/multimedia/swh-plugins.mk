# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := swh-plugins
$(PKG)_WEBSITE  := http://plugin.org.uk/
$(PKG)_DESCR    := The SWH Plugins package for the LADSPA plugin system
$(PKG)_VERSION  := 0.4.17
$(PKG)_CHECKSUM := d1b090feec4c5e8f9605334b47faaad72db7cc18fe91d792b9161a9e3b821ce7
$(PKG)_GH_CONF  := swh/ladspa,v
$(PKG)_DEPS     := gcc ladspa-sdk mman-win32

define $(PKG)_BUILD
    cd $(1) && \
    autoreconf -i && \
	./configure $(MXE_CONFIGURE_OPTS) \
        LIBS='-lintl' && \
	$(MAKE) -j $(JOBS) install $(if $(BUILD_SHARED),LDFLAGS=-no-undefined)
endef
