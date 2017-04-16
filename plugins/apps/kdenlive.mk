# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := kdenlive
$(PKG)_VERSION  := 17.04.0
$(PKG)_CHECKSUM :=
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_HOME     := http://download.kde.org/stable/applications
$(PKG)_URL      := $($(PKG)_HOME)/$($(PKG)_VERSION)/src/$($(PKG)_FILE)
$(PKG)_DEPS     := \
	ffmpeg mlt \
	qtbase qtdeclarative qtquickcontrols \
	breeze-icons karchive kconfig kcoreaddons kdbusaddons kguiaddons ki18n kitemviews kplotting kwidgetsaddons \
	kcompletion kcrash kfilemetadata kjobwidgets \
	kbookmarks kconfigwidgets kiconthemes kio knewstuff knotifications knotifyconfig kservice ktextwidgets kxmlgui kinit
#	breeze

define $(PKG)_UPDATE
    $(WGET) -q -O- http://download.kde.org/stable/applications | \
    $(SED) -n 's,[^0-9]*\([0-9]\+.[0-9]\+.[0-9]\+\)/.*,\1,p' | \
	tail -1
endef

define $(PKG)_BUILD
    mkdir -p "$(1)/build-mxe"
    cd "$(1)/build-mxe" && \
	PKG_CONFIG_LIBDIR=$(PREFIX)/$(TARGET)/lib/pkgconfig \
	cmake .. \
        -DCMAKE_TOOLCHAIN_FILE=$(CMAKE_TOOLCHAIN_FILE) \
        -DCMAKE_CROSSCOMPILING=ON \
        -DKF5_HOST_TOOLING=/usr/lib/x86_64-linux-gnu/cmake \
        -DKCONFIGCOMPILER_PATH=/usr/lib/x86_64-linux-gnu/cmake/KF5Config/KF5ConfigCompilerTargets.cmake \
        -DTARGETSFILE=/usr/lib/x86_64-linux-gnu/cmake/KF5CoreAddons/KF5CoreAddonsToolingTargets.cmake \
        -DCMAKE_DISABLE_FIND_PACKAGE_LibV4L2=TRUE \
        -DMLT_MELTBIN=./melt.exe \
        -DCMAKE_BUILD_TYPE=Release \
        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
	$(SED) -i 's,MLT_PREFIX ".*",MLT_PREFIX ".",' "$(1)/build-mxe/config-kdenlive.h"
	$(SED) -i 's,MLT_MELTBIN=[^ ]*,MLT_MELTBIN=\\"melt.exe\\",' "$(1)/build-mxe/src/CMakeFiles/kdenlive.dir/flags.make"
    $(MAKE) -C "$(1)/build-mxe" -j $(JOBS) install
endef
# -DCMAKE_CXX_FLAGS=-std=c++11 -DCMAKE_CXX_STANDARD=11 -DCMAKE_VERBOSE_MAKEFILE=ON
