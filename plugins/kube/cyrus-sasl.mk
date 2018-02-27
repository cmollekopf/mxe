# This file is part of MXE. See LICENSE.md for licensing information.
PKG             := cyrus-sasl
$(PKG)_VERSION  := 2.1.26
$(PKG)_CHECKSUM := 8fbc5136512b59bb793657f36fadda6359cae3b08f01fd16b3d406f1345b7bc3
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_HOME     := ftp://ftp.cyrusimap.org/cyrus-sasl
$(PKG)_URL      := $($(PKG)_HOME)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

    # mkdir "$(1)/build"
    # cd "$(1)/build" && cmake .. \
    #     -DCMAKE_TOOLCHAIN_FILE="$(CMAKE_TOOLCHAIN_FILE)" \
    #     -DCMAKE_BUILD_TYPE=Release \
    #     -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    #     -DBUILD_TESTING=OFF

define $(PKG)_BUILD
	cd "$(1)" && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C "$(1)" -j $(JOBS)
    $(MAKE) -C "$(1)" -j $(JOBS) install
endef
