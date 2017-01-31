## Makefile.am

man1_MANS = update-xml-catalog.1

## update-xml-catalog.1: update-xml-catalog.txt
	## txt2man -t "update-xml-catalog" -r "@VERSION@" -s 1 -v "XML catalog generator" $^ > $@

bin_SCRIPTS = edit-xml-catalog \
	install-catalog \
	install-dtd.sh \
	parse-sgml-catalog.sh \
	sgml2xmlcat.sh \
	sgml-register-catalog \
	update-xml-catalog

EXTRA_DIST = $(bin_SCRIPTS) $(bin_SCRIPTS:=.in) $(man1_MANS)

## Makefile.am ends here
