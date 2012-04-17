## Process this file with automake to produce Makefile.in

GITHUB_USER = Themroc

SUBDIRS = src

EXTRA_DIST =			\
	lrexlib/*		\
	luaposix/*		\
	config.h		\
	rockspec.tpl.in
#	$(HTML)			\
#	$(LUATESTS)		\
#	$(LUNITTESTS)		

DISTCLEANFILES = rockspec

ACLOCAL_AMFLAGS = -I m4

rockdir = $(PACKAGE)-$(VERSION).rock

#ChangeLog:
#	git2cl > ChangeLog

LUA_PATH ?= ;
LUA_CPATH ?= ;
LUA_ENV = LUA_INIT= LUA_PATH="$(abs_srcdir)/?.lua;$(LUA_PATH)" LUA_CPATH="$(abs_builddir)/$(objdir)/?$(shrext);$(LUA_CPATH)"

#HTML = curses.html lcurses_c.html

#LUATESTS =				\
#	$(srcdir)/tests-posix.lua

#LUNITTESTS=				\
#	$(srcdir)/tests-fcntl.lua

DEV_CLEAN = \
	aclocal.m4 m4/libtool.m4 m4/lt*.m4 \
	libtool ltmain.sh install-sh depcomp missing mkinstalldirs \
	config.cache config.guess config.h.in config.log config.status config.sub configure compile \
	Makefile.in src/Makefile.in *~ src/*~

DEV_AUTOGEN = \
	rm -f config.cache; \
	aclocal -I m4; autoconf -I m4; autoheader; libtoolize; automake -a

DEV_CONFIG_H = \
	echo '\#define PACKAGE_NAME "$(PACKAGE)"'; \
	echo '\#define PACKAGE_VERSION "$(VERSION)"'

distclean-local:
	($(DEV_CONFIG_H)) > config.h

devclean: distclean
	rm -f $(DEV_CLEAN) *.tar.gz *.tar.xz *.rock *.rockspec; \
	rm -rf autom4te.cache; \
	echo -e "#!/bin/sh\n$(DEV_AUTOGEN)" >autogen.sh; \
	chmod a+x autogen.sh

dev-distdir: distdir
	-chmod -R a+r $(distdir)
	pushd .; cd $(distdir); \
	rm -f $(DEV_CLEAN); \
	rm -rf autom4te.cache; \
	echo -e "#!/bin/sh\n$(DEV_AUTOGEN)" >autogen.sh; \
	chmod a+x autogen.sh; \
	popd

dev-dist-gzip: dev-distdir
	tardir=$(distdir) && $(am__tar) | GZIP=$(GZIP_ENV) gzip -c >$(distdir)-dev.tar.gz
	$(am__remove_distdir)

dev-dist-xz: dev-distdir
	tardir=$(distdir) && $(am__tar) | XZ_OPT=$${XZ_OPT--e} xz -c >$(distdir)-dev.tar.xz
	$(am__remove_distdir)


ROCKSPEC_GZ = $(PACKAGE)-$(VERSION)-$(RS_VER_POSTFIX).rockspec

$(ROCKSPEC_GZ): rockspec.tpl dev-dist-gzip
	cat rockspec.tpl | sed -e 's/@MD5@/'`$(MD5SUM) $(distdir)-dev.tar.gz | cut -d " " -f 1`'/g' | sed -e 's/.tar.gz/-dev.tar.gz/g' > $(ROCKSPEC_GZ)

src-rock: rockspec
	zip $(PACKAGE)-$(VERSION)-$(RS_VER_POSTFIX).src.rock $(ROCKSPEC) $(distdir)-dev.tar.gz

check-local:
	ls $(LUATESTS) | $(LUA_ENV) xargs -L 1 $(LUA)
	ls $(LUNITTESTS) | $(LUA_ENV) xargs -L 1 lunit --interpreter $(LUA)

release: distcheck $(ROCKSPEC)
	git diff --exit-code && \
	git push && \
	woger lua,github package=$(PACKAGE) package_name=$(PACKAGE_NAME) version=$(VERSION) description="`LUA_INIT= LUA_PATH='$(abs_srcdir)/?.rockspec.in' $(LUA) -l$(PACKAGE) -e 'print (description.summary)'`" notes=release-notes-$(VERSION) dist_type="tar.gz" github_user=$(GITHUB_USER) && \
	git tag -a -m "Release tag" v$(VERSION) && \
	git push --tags

dev-dist: dev-dist-xz

ROCKSPEC = $(ROCKSPEC_GZ)

rockspec: $(ROCKSPEC)


rock-inst: rockspec
	luarocks make $(ROCKSPEC)

rock-uninst:
	luarocks remove $(PACKAGE)
