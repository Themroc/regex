dnl Process this file with autoconf to produce a configure script

AC_INIT(regex, 2.6.0)
RS_VER_POSTFIX=1
AC_CONFIG_AUX_DIR([.])
AC_CONFIG_MACRO_DIR([m4])

AM_INIT_AUTOMAKE([-Wall -Werror std-options])

# m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

dnl Check for programs
AC_PROG_CC

LT_PREREQ([2.2.6])
LT_INIT([disable-static])
LT_OUTPUT

eval `./libtool --config |grep '^objdir='`
eval `./libtool --config |grep '^shrext_cmds='`
module=yes eval shrext=$shrext_cmds

AC_SUBST([objdir])
AC_SUBST([shrext])
AC_SUBST(LIBTOOL_DEPS)
AC_SUBST(RS_VER_POSTFIX)

AC_DEFINE_UNQUOTED([REX_LIBNAME], ["$PACKAGE"], [for lposix.c])
AC_DEFINE_UNQUOTED([REX_OPENLIB], [luaopen_$PACKAGE], [for lposix.c])

dnl Check for header files
AC_HEADER_STDC

dnl Compiler flags for POSIX
dnl Get this from autotools/gnulib
if test Darwin != `uname`; then
  POSIX_EXTRA_CFLAGS=-D_XOPEN_SOURCE=700
fi
AC_SUBST(POSIX_EXTRA_CFLAGS)
AC_SUBST(POSIX_EXTRA_LDFLAGS)

dnl Lua 5.1 or 5.2
AX_PROG_LUA(501)
AX_LUA_HEADERS
AX_LUA_HEADERS_VERSION(501)
AC_SUBST(LUA)
AC_SUBST(LUA_INCLUDE)

dnl md5sum
AX_WITH_PROG([MD5SUM], [md5sum], [false])

dnl Generate output files
AC_CONFIG_HEADER(config.h)
AC_CONFIG_FILES([Makefile src/Makefile rockspec.tpl])
AC_OUTPUT
