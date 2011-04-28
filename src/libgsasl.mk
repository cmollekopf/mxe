# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# Libgsasl
PKG             := libgsasl
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6.0
$(PKG)_CHECKSUM := bb760a943ac487d332d5216559cd5fa765952245
$(PKG)_SUBDIR   := libgsasl-$($(PKG)_VERSION)
$(PKG)_FILE     := libgsasl-$($(PKG)_VERSION).tar.gz
$(PKG)_WEBSITE  := http://www.gnu.org/software/gsasl/
$(PKG)_URL      := http://ftp.gnu.org/gnu/gsasl/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc libiconv libidn libntlm libgcrypt

define $(PKG)_UPDATE
    wget -q -O- 'http://git.savannah.gnu.org/gitweb/?p=gsasl.git;a=tags' | \
    grep '<a class="list subject"' | \
    $(SED) -n 's,.*<a[^>]*>\([0-9]*\.[0-9]*[02468]\.[^<]*\)<.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    # wine confuses the cross-compiling detection, so set it explicitly
    $(SED) -i 's,cross_compiling=no,cross_compiling=yes,' '$(1)/configure'
    cd '$(1)' && touch src/libgsasl-7.def && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-nls \
        --with-libgcrypt \
        --with-libiconv-prefix='$(PREFIX)/$(TARGET)' \
        --with-libidn-prefix='$(PREFIX)/$(TARGET)' \
        --with-libntlm-prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=

    '$(TARGET)-gcc' \
        -W -Wall -Werror -ansi -pedantic \
        '$(2).c' -o '$(PREFIX)/$(TARGET)/bin/test-libgsasl.exe' \
        `'$(TARGET)-pkg-config' libgsasl --cflags --libs`
endef
