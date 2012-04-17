#!/bin/sh
rm -f config.cache; aclocal -I m4; autoconf -I m4; autoheader; libtoolize; automake -a
