## Process this file with automake to produce Makefile.in

SUBDIRS = src

ACLOCAL_AMFLAGS = -I .

GITHUB_USER = Themroc

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

dist-7z: distdir
	tardir=$(distdir) && $(am__tar) | P7Z_OPT=$${P7Z_OPT--e} 7z a -si -mx=7 $(distdir).tar.7z
	$(am__remove_distdir)


ROCKSPEC = $(PACKAGE)-$(VERSION)-$(RS_VER_POSTFIX).rockspec

$(ROCKSPEC): dist
	cat rockspec | sed -e 's/@MD5@/'`$(MD5SUM) $(distdir).tar.gz | cut -d " " -f 1`'/g' | sed -e 's/@ARC_EXT@/tar.gz/g' > $(ROCKSPEC)

$(ROCKSPEC)-7z: dist-7z
	cat rockspec | sed -e 's/@MD5@/'`$(MD5SUM) $(distdir).tar.7z | cut -d " " -f 1`'/g' | sed -e 's/@ARC_EXT@/tar.7z/g' > $(ROCKSPEC)

rockspec: $(ROCKSPEC)

rockspec-7z: $(ROCKSPEC)-7z

EXTRA_DIST =			\
	lrexlib/*		\
	luaposix/*		\
	rockspec.in
#	$(HTML)			\
#	$(LUATESTS)		\
#	$(LUNITTESTS)		

DISTCLEANFILES = rockspec

check-local:
	ls $(LUATESTS) | $(LUA_ENV) xargs -L 1 $(LUA)
	ls $(LUNITTESTS) | $(LUA_ENV) xargs -L 1 lunit --interpreter $(LUA)

release: distcheck $(ROCKSPEC)
	git diff --exit-code && \
	git push && \
	woger lua,github package=$(PACKAGE) package_name=$(PACKAGE_NAME) version=$(VERSION) description="`LUA_INIT= LUA_PATH='$(abs_srcdir)/?.rockspec.in' $(LUA) -l$(PACKAGE) -e 'print (description.summary)'`" notes=release-notes-$(VERSION) dist_type="tar.gz" github_user=$(GITHUB_USER) && \
	git tag -a -m "Release tag" v$(VERSION) && \
	git push --tags
