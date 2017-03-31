# This file is part of MXE. See LICENSE.md for licensing information.

$(info == Custom FFmpeg overrides: $(lastword $(MAKEFILE_LIST)))

sox_DEPS := $(filter-out lame, $(sox_DEPS))
sox_BUILD_SHARED = $(filter-out --with-lame, $(sox_BUILD))
twolame_BUILD_SHARED = $(twolame_BUILD)
gtk2_BUILD_SHARED = $(gtk2_BUILD)


ffmpeg_DEPS := twolame $(filter-out \
	gnutls \
	libass \
	libbluray \
	libbs2b \
	libcaca \
	lame \
	opencore-amr \
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
					  --enable-libmp3lame \
					  --enable-libopencore \
					  --enable-libspeex \
					  --enable-libvo-amrwbenc \
					  --enable-libx264 \
					  --enable-libxvid \
					  , $(ffmpeg_BUILD))
#$(subst --disable-pthreads, --enable-pthreads, \
#$(subst --enable-w32threads, --disable-w32threads, \
