# This file is part of MXE. See LICENSE.md for licensing information.
PKG             := kpackage
$(PKG)_VERSION  := 5.35.0
$(PKG)_CHECKSUM  := 2c59bf930f49c56229d02cf340e7792e80ae24bc47e19440a92f2a94058f2df1
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_HOME     := http://download.kde.org/stable/frameworks
$(PKG)_URL      := $($(PKG)_HOME)/$(basename $($(PKG)_VERSION))/$($(PKG)_FILE)
$(PKG)_DEPS     := qtbase extra-cmake-modules breeze-icons kdecoration

define $(PKG)_UPDATE
    $(WGET) -q -O- http://download.kde.org/stable/frameworks/ | \
    $(SED) -n 's,.*\([0-9]\+\.[0-9]\+\)/.*,\1.0,p' | \
	tail -1
endef

define $(PKG)_BUILD
	# mkdir "$(1)/build-kpackagetool5"
	# cd "$(1)/build-kpackagetool5" && cmake .. -DCMAKE_PREFIX_PATH=/usr/lib/x86_64-linux-gnu/cmake/
	# $(MAKE) -C "$(1)/build-kpackagetool5" -j $(JOBS) kpackagetool5
	# cp "$(1)/build-kpackagetool5/src/kpackagetool/kpackagetool5" $(PREFIX)/bin
	# cp "$(1)/build-kpackagetool5/src/kpackage/libKF5Package.so*" $(PREFIX)/lib
    mkdir "$(1)/build"
    cd "$(1)/build" && cmake .. \
        -DCMAKE_TOOLCHAIN_FILE="$(CMAKE_TOOLCHAIN_FILE)" \
        -DCMAKE_BUILD_TYPE=Release \
        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
        -DBUILD_TESTING=OFF
    $(MAKE) -C "$(1)/build" -j $(JOBS) install
endef