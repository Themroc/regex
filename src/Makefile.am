## Process this file with automake to produce Makefile.in

show-funcs:
	@echo "posix library:"
	@fgrep '/**' lposix.c | cut -f2 -d/ | tr -d '*' | sort

TRG    = regex
#DEFS   = -DREX_OPENLIB=luaopen_$(TRG) -DREX_LIBNAME=\"$(TRG)\"

AM_CPPFLAGS = $(LUA_INCLUDE)
AM_CFLAGS = $(WERROR_CFLAGS) $(WARN_CFLAGS) $(DEFS)

lib_LTLIBRARIES = regex.la $(WANTEDLIBS)

regex_la_SOURCES = lposix.c ../algo.h ../common.h ../common.c
regex_la_CFLAGS = $(POSIX_EXTRA_CFLAGS)
regex_la_LDFLAGS = -module -avoid-version $(POSIX_EXTRA_LDFLAGS)

#ChangeLog:
#	git2cl > ChangeLog

LUA_PATH ?= ;
LUA_CPATH ?= ;
LUA_ENV = LUA_INIT= LUA_PATH="$(abs_srcdir)/?.lua;$(LUA_PATH)" LUA_CPATH="$(abs_builddir)/$(objdir)/?$(shrext);$(LUA_CPATH)"
