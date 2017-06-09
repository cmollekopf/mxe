# This file is part of MXE. See LICENSE.md for licensing information.

$(info == Custom FFmpeg overrides: $(lastword $(MAKEFILE_LIST)))

sox_DEPS := gcc libltdl
define sox_BUILD_SHARED
    cd '$(1)' && ./configure \
		$(MXE_CONFIGURE_OPTS) \
        --disable-symlinks \
		--disable-gomp \
		--without-ffmpeg \
        --without-magic \
        --without-png \
        --without-ladspa
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef

twolame_BUILD_SHARED = $(twolame_BUILD)
gtk2_BUILD_SHARED = $(gtk2_BUILD)


ffmpeg_DEPS := twolame sdl2 $(filter-out \
	gnutls \
	libass \
	libbluray \
	libbs2b \
	libcaca \
	opencore-amr \
	sdl \
	speex \
	vo-amrwbenc \
	x264 \
	xvidcore \
	, $(ffmpeg_DEPS))

ffmpeg_BUILD_SHARED = $(filter-out \
					  --enable-gnutls \
					  --enable-libass \
					  --enable-libbluray \
					  --enable-libbs2b \
					  --enable-libcaca \
					  --enable-libopencore-amrnb \
					  --enable-libopencore-amrwb \
					  --enable-libspeex \
					  --enable-libvo-amrwbenc \
					  --enable-libx264 \
					  --enable-libxvid \
					  , $(ffmpeg_BUILD))
#$(subst --disable-pthreads, --enable-pthreads, \
#$(subst --enable-w32threads, --disable-w32threads, \
