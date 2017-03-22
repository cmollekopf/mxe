# This file is part of MXE. See LICENSE.md for licensing information.

$(info == Custom FFmpeg overrides: $(lastword $(MAKEFILE_LIST)))

ffmpeg_DEPS := $(filter-out gnutls libass libbluray libbs2b libcaca opencore-amr vo-amrwbenc \
	lame x264 xvidcore speex theora,$(ffmpeg_DEPS))

ffmpeg_BUILD_SHARED = $(subst --disable-pthreads, --enable-pthreads, \
					  $(subst --enable-w32threads, --disable-w32threads, \
					  $(subst --enable-avisynth, --disable-avisynth, \
					  $(subst --enable-gnutls, --disable-gnutls, \
					  $(subst --enable-libass, --disable-libass, \
					  $(subst --enable-libbluray, --disable-libbluray, \
					  $(subst --enable-libbs2b, --disable-libbs2b, \
					  $(subst --enable-libcaca, --disable-libcaca, \
					  $(subst --enable-libmp3lame, --disable-libmp3lame, \
					  $(subst --enable-libopencore, --disable-libopencore, \
					  $(subst --enable-libspeex, --disable-libspeex, \
					  $(subst --enable-libtheora, --disable-libtheora, \
					  $(subst --enable-libvo-amrwbenc, --disable-libvo-amrwbenc, \
					  $(subst --enable-libx264, --disable-libx264, \
					  $(subst --enable-libxvid, --disable-libxvid, \
					  $(ffmpeg_BUILD) )))))))))))))))

