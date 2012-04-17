package="regex"
version="2.6.0-1"
source = {
  url = "https://github.com/downloads/Themroc/regex/regex-2.6.0.tar.gz",
  md5 = "@MD5@",
  dir = "regex-2.6.0"
}
description = {
  summary = "Lua bindings for POSIX regular expressions",
  detailed = [[
      A library binding POSIX regular expression APIs.
      POSIX is the IEEE Portable Operating System Interface standard.
   ]],
  homepage = "http://github.com/Themroc/regex/",
  license = "MIT/X11"
}
dependencies = {
  "lua >= 5.1"
}
external_dependencies = {
   LIBREGEX = {
      header = "regex.h"
   }
}
build = {
   type = "builtin",
   modules = {
      regex = {
         sources = {"src/lposix.c", "src/common.c"},
         incdirs = {"$(LIBREGEX_INCDIR)"},
         libdirs = {"$(LIBREGEX_LIBDIR)"}
      }
   }
}
