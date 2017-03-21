# This file is part of MXE. See LICENSE.md for licensing information.
PKG             := phonon
$(PKG)_VERSION  := 4.9.1
$(PKG)_CHECKSUM  := 67bee986f85ca8b575186c8ba58a85886cb3b1c3567c86a118d56129f221e69c
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_HOME     := http://download.kde.org/stable/phonon
$(PKG)_URL      := $($(PKG)_HOME)/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := qtbase extra-cmake-modules

define $(PKG)_UPDATE
    $(WGET) -q -O- http://download.kde.org/stable/phonon/ | \
    $(SED) -n 's,.*\([0-9]\+\.[0-9]\+.[0-9]\+\)/.*,\1,p' | \
	tail -1
endef

define $(PKG)_BUILD
    mkdir "$(1)/build"
    cd "$(1)/build" && cmake .. \
        -DCMAKE_TOOLCHAIN_FILE="$(CMAKE_TOOLCHAIN_FILE)" \
        -DCMAKE_BUILD_TYPE=Release \
        -DPHONON_BUILD_EXAMPLES=OFF \
        -DPHONON_BUILD_TESTS=OFF \
        -DPHONON_INSTALL_QT_EXTENSIONS_INTO_SYSTEM_QT=ON \
        -DPHONON_BUILD_PHONON4QT5=ON
    $(MAKE) -C "$(1)/build" -j $(JOBS) install
endef
