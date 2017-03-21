# This file is part of MXE. See LICENSE.md for licensing information.

$(info == Custom FFmpeg overrides: $(lastword $(MAKEFILE_LIST)))

# reduced ffmpeg
ffmpeg_DEPS := $(filter-out gnutls libass libbluray libbs2b libcaca opencore-amr vo-amrwbenc xvidcore lame x264 speex,$(ffmpeg_DEPS))

# use pthreads with MLT
define ffmpeg_BUILD
    cd '$(1)' && ./configure \
        --cross-prefix='$(TARGET)'- \
        --enable-cross-compile \
        --arch=$(firstword $(subst -, ,$(TARGET))) \
        --target-os=mingw32 \
        --prefix='$(PREFIX)/$(TARGET)' \
        $(if $(BUILD_STATIC), \
            --enable-static --disable-shared , \
            --disable-static --enable-shared ) \
        --yasmexe='$(TARGET)-yasm' \
        --disable-debug \
        --disable-ffserver \
        --enable-memalign-hack \
        --enable-pthreads \
        --disable-w32threads \
        --disable-doc \
        --enable-avresample \
        --enable-gpl \
        --enable-version3 \
        --extra-libs='-mconsole' \
        --enable-avisynth \
        --enable-gnutls \
        --disable-libass \
        --disable-libbluray \
        --disable-libbs2b \
        --disable-libcaca \
        --disable-libmp3lame \
        --disable-libopencore-amrnb \
        --disable-libopencore-amrwb \
        --enable-libopus \
        --disable-libspeex \
        --enable-libtheora \
        --enable-libvidstab \
        --disable-libvo-amrwbenc \
        --enable-libvorbis \
        --enable-libvpx \
        --disable-libx264 \
        --disable-libxvid
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef

