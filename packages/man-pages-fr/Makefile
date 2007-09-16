# man-pages-fr Makefile

NM= man-pages-fr
VRS= 2.40.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://manpagesfr.free.fr/download/$(FILE)
SHA-$(FILE)= b6997da3658289f5b22053a05caa65147e1535e0

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./utf8_en_latin1.sh
	cp -r man? /usr/share/man/fr

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
