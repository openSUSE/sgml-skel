#!/bin/bash
# Copyright (C) 2002 by SuSE Linux AG.
# Author: Karl Eichwalder <ke@suse.de>, 2002.
# GPL

package=sgml-skel
version=0.7.2

LANGUAGE=C; export LANGUAGE
LC_ALL=C; export LC_ALL

# debug=yes

progname=${0##*/}
usage="\
Usage: $progname file...
Print normalized SGML catalog files.

  -d, --debug
  -h, --help

Example:

Version info: $progname ($package) $version

Please, report bugs to Karl Eichwalder <feedback@suse.de>."

while test $# -gt 0; do
  case $1 in
    -d | --debug) debug=yes; shift 1; ;;
    -h | --h* ) echo "$usage"; exit 0 ;;
    -*) echo "Try '$progname --help' for more information."; exit 1 ;;
    *) break
  esac
done

_debug(){
  [ x$debug = xyes ] && echo -e $1
}

cat_norm() {
#!/bin/sed -f
  sed '
s/--/\
&\
/g

/^$/d
s/^[ 	]*//' "$1"
}

cat_del_empty_lines() {
#!/bin/sed -f
  sed '
/^$/d
s/^[ 	]*//'
}

cat_print_norm() {
#!/bin/gawk -f
awk '
BEGIN{IGNORECASE=1;p=1; c=0;}

p == 1 && ! /--/ {
  # if (/^[A-Za-z]/) {
  if (/^(sgmldecl|dtddecl|doctype|entity|public|override|catalog)[ 	]/) {
    if (line != "") {print line; line="";}
    line=$0}
  else
    line = line " " $0;
};
/^--/ && c == 0 {
  if (line != "") {print line; line="";}
  p=0; c=1; next;};
/^--/ && c == 1 {p=1; c=0;};

END{print line}'
}

cat_norm "$@" | cat_del_empty_lines | cat_print_norm

exit
