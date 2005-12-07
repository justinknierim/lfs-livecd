# man-pages-es Makefile

NM= man-pages-es
VRS= 1.55
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ditec.um.es/~piernas/manpages-es/$(FILE)
SHA-$(FILE)= 1d72e80d0c41f9e5c24ba6a4eea161fc151ec5b5

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	find man? -type f | \
	 grep -v 'man7/iso_8859-2.7' | grep -v 'man7/iso_8859-7.7' | \
	 while read F ; do \
	  iconv -f UTF-8 -t ISO-8859-1 $$F >tmp ; mv tmp $$F ; \
	 done
	cp -r man? /usr/share/man/es

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
