BEGIN {
D["PACKAGE_NAME"]=" \"iperf\""
D["PACKAGE_TARNAME"]=" \"iperf\""
D["PACKAGE_VERSION"]=" \"3.13\""
D["PACKAGE_STRING"]=" \"iperf 3.13\""
D["PACKAGE_BUGREPORT"]=" \"https://github.com/esnet/iperf\""
D["PACKAGE_URL"]=" \"https://software.es.net/iperf/\""
D["PACKAGE"]=" \"iperf\""
D["VERSION"]=" \"3.13\""
D["HAVE_STDIO_H"]=" 1"
D["HAVE_STDLIB_H"]=" 1"
D["HAVE_STRING_H"]=" 1"
D["HAVE_INTTYPES_H"]=" 1"
D["HAVE_STDINT_H"]=" 1"
D["HAVE_STRINGS_H"]=" 1"
D["HAVE_SYS_STAT_H"]=" 1"
D["HAVE_SYS_TYPES_H"]=" 1"
D["HAVE_UNISTD_H"]=" 1"
D["STDC_HEADERS"]=" 1"
D["HAVE_DLFCN_H"]=" 1"
D["LT_OBJDIR"]=" \".libs/\""
D["HAVE_POLL_H"]=" 1"
D["HAVE_LINUX_TCP_H"]=" 1"
D["HAVE_ENDIAN_H"]=" 1"
D["HAVE_TCP_CONGESTION"]=" 1"
D["HAVE_TCP_USER_TIMEOUT"]=" 1"
D["HAVE_FLOWLABEL"]=" 1"
D["HAVE_SCHED_SETAFFINITY"]=" 1"
D["HAVE_CPU_AFFINITY"]=" 1"
D["HAVE_DAEMON"]=" 1"
D["HAVE_SENDFILE"]=" 1"
D["HAVE_GETLINE"]=" 1"
D["HAVE_SO_MAX_PACING_RATE"]=" 1"
D["HAVE_SO_BINDTODEVICE"]=" 1"
D["HAVE_IP_MTU_DISCOVER"]=" 1"
D["HAVE_DONT_FRAGMENT"]=" 1"
D["HAVE_TCP_INFO_SND_WND"]=" 1"
D["HAVE_CLOCK_GETTIME"]=" 1"
  for (key in D) D_is_set[key] = 1
  FS = ""
}
/^[\t ]*#[\t ]*(define|undef)[\t ]+[_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ][_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789]*([\t (]|$)/ {
  line = $ 0
  split(line, arg, " ")
  if (arg[1] == "#") {
    defundef = arg[2]
    mac1 = arg[3]
  } else {
    defundef = substr(arg[1], 2)
    mac1 = arg[2]
  }
  split(mac1, mac2, "(") #)
  macro = mac2[1]
  prefix = substr(line, 1, index(line, defundef) - 1)
  if (D_is_set[macro]) {
    # Preserve the white space surrounding the "#".
    print prefix "define", macro P[macro] D[macro]
    next
  } else {
    # Replace #undef with comments.  This is necessary, for example,
    # in the case of _POSIX_SOURCE, which is predefined and required
    # on some systems where configure will not decide to define it.
    if (defundef == "undef") {
      print "/*", prefix defundef, macro, "*/"
      next
    }
  }
}
{ print }
