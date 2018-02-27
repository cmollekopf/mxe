# This file is part of MXE. See LICENSE.md for licensing information.
PKG             := kimap2
$(PKG)_VERSION  := 0.2.0
$(PKG)_CHECKSUM := b99125de1f8170c62d79dcc4baa456b64340d428e127ee993df470ce76a7ea33
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_HOME     := http://download.kde.org/unstable/$(PKG)
$(PKG)_URL      := $($(PKG)_HOME)/$($(PKG)_VERSION)/src/$($(PKG)_FILE)
$(PKG)_DEPS     := qtbase extra-cmake-modules kcoreaddons kmime sasl2

define $(PKG)_BUILD
    mkdir "$(1)/build"
    cd "$(1)/build" && cmake .. \
        -DCMAKE_TOOLCHAIN_FILE="$(CMAKE_TOOLCHAIN_FILE)" \
        -DCMAKE_BUILD_TYPE=Release \
        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
        -DBUILD_TESTING=OFF
    $(MAKE) -C "$(1)/build" -j $(JOBS) install
endef
