# This is a template of configuration file for MXE. See
# index.html for more extensive documentations.

# This variable controls the number of compilation processes
# within one package ("intra-package parallelism").
#JOBS := 

# This variable controls where intermediate files are created
# this is necessary when compiling inside a virtualbox shared
# directory. Some commands like strip fail in there with Protocol error
# default is the current directory
#MXE_TMP := /tmp

# This variable controls the targets that will build.
#MXE_TARGETS :=  i686-w64-mingw32.static i686-w64-mingw32.shared  x86_64-w64-mingw32.static x86_64-w64-mingw32.shared

# kdenlive_SOURCE_TREE := /path/to/kdenlive/source
MXE_TARGETS := x86_64-w64-mingw32.shared

override MXE_PLUGIN_DIRS += \
	plugins/kdeframeworks \
	plugins/kube

# This variable controls the download mirror for SourceForge,
# when it is used. Enabling the value below means auto.
#SOURCEFORGE_MIRROR := downloads.sourceforge.net

# The three lines below makes `make` build these "local
# packages" instead of all packages.
#LOCAL_PKG_LIST := boost curl file flac lzo pthreads vorbis wxwidgets
# LOCAL_PKG_LIST := curl
# .DEFAULT local-pkg-list:
# local-pkg-list: $(LOCAL_PKG_LIST)

LOCAL_PKG_LIST := kmime kimap2
local-pkg-list: $(LOCAL_PKG_LIST)

# openssl recognition fails on Debian sid
# REQUIREMENTS := $(filter-out openssl ,$(REQUIREMENTS))
